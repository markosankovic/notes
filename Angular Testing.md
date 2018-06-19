# Angular Testing

## Service Tests

Synchronous and asynchronous unit tests of the ValueService without assistance from Angular testing utilities:

    describe('ValueService', () => {
      let service: ValueService;
      beforeEach(() => { service = new ValueService(); });

      it('#getValue should regurn real value', () {
        expect(service.getValue()).toBe('real value');
      });

      it('#getObservableValue should return value from observable', (done: DoneFn) => {
        service.getObservableValue().subscribe(value => {
          expect(value).toBe('observable value');
          done();
        });
      });

      it('#getPromiseValue should return value from a promise', (done: DoneFn) => {
        service.getPromiseValue().then(value => {
          expect(value).toBe('promise value');
          done();
        });
      });
    });
  
### Services with dependencies
  
Services often depend on other services that Angular injects into the contrustor. In many cases, it is easy to create and *inject* these dependencies by hand while calling the service's contructor.

    @Injectable
    export class MasterService {
        contructor(private valueService: ValueService) { }
        getValue() { return this.valueService.getValue(); }
    }
    
MasterService delegates its only method, getValue, to the injected ValueService. The ways to test it:

    describe('MasterService without Angular testing support', () => {
        let masterService: MasterService;
        
        it('#getValue should return real value from the real service', () => {
            masterService = new MasterService(new ValueService());
            expect(masterService.getValue()).toBe('real value');
        });
        
        it('#getValue should return faked value from a fakeService', () => {
            masterService = new MasterService(new FakeValueService());
            expect(masterService.getValue()).toBe('faked service value');
        });
        
        it('#getValue should return faked value from a fake object', () => {
            const fake = { getValue: () => 'fake value' };
            masterService = new MasterService(fake as ValueService);
            expect(masterService.getValue()).toBe('fake value');            
        });

        it('#getValue should return stubbed value from a spy', () => {
            // create `getValue` spy on an object representing the ValueService
            const valueServiceSpy = jasmine.createSpyObj('ValueService', ['getValue']);
            
            // set the value to return when the `getValue` spy is called.
            const stubValue = 'stub value';
            valueServiceSpy.getValue.and.returnValue(stubValue);
            
            masterService = new MasterService(valueServiceSpy);
            
            expect(masterService.getValue()).toBe(stubValue, 'service returned stub value');
            expect(valueServiceSpy.getValue.calls.count()).toBe(1, 'spy method was called once');
            expect(valueServiceSpy.getValue.calls.mostRecent().returnValue).toBe(stubValue);
        });
    });
    
Prefer spies as they are usually the easiest way to mock services.

### Testing services with the TestBed

### Angular *TestBed*

The TestBed creates a dynamically-constructed Angular test module that emulates an Angular @NgModule.

To test a service, you set the providers metadata property with an array of the services that you'll test or mock.

    let service: ValueService;
    
    beforeEach(() => {
        TestBed.configureTestingModule({ providers: [ValueService] });
    });

Then inject it inside a test by calling TestBed.get() with the service class as the argument.

    it('should use ValueService', () => {
        service = TestBed.get(ValueService);
        expect(service.getValue()).toBe('real value');
    });

Or inside the beforeEach() if you prefer to inject the service as part of your setup.

    beforeEach(() => {
        TestBed.configureTestingModule({ providers: [ValueService] });
        service = TestBed.get(ValueService);
    });

When testing a service with a dependency, provide the mock in the providers array. In the following example, the mock is a spy object.

    let masterService: MasterService;
    let valueServiceSpy: jasmine.SpyObj<ValueService>;
    
    beforeEach(() => {
        const spy = jasmine.createSpyObj('ValueService', ['getValue']);
        
        TestBed.configureTestingModule({
            // Provide both the service-to-test and its (spy) dependency
            providers: [
                MasterService,
                { provide: ValueService, useValue: spy }
            ]
        });
        // Inject both the service-to-test and its (spy) dependency
        masterService = TestBed.get(MasterService);
        valueServiceSpy = TestBed.get(ValueService);
    });

The test consumes that spy in the same way it did earlier.

    it('#getValue should return stubbed value from a spy', () => {
        const stubValue = 'stub value';
        valueServiceSpy.getValue.and.returnValue(stubValue);
        
        expect(masterService.getValue()).toBe(stubValue, 'service returned stub value');
        expect(masterService.getValue.calls.count()).toBe(1, 'spy method was called once');
        expect(masterService.getValue.calls.mostRecent().returnValue).toBe(stubValue);
    });

### Testing without *beforeEach()*

    function setup() {
        const valueServiceSpy = jasmine.createSpyObj('ValueService', ['getValue']);
        const stubValue = 'stub value';
        const masterService = new MasterService(valueServiceSpy);
        
        valueServiceSpy.getValue.and.returnValue(stubValue);
        return { masterService, stubValue, valueServiceSpy };
    }

Each test invokes setup() in its first line:

    it('#getValue should return stubbed value from a spy', () => {
        const { masterService, stubValue, valueServiceSpy } = setup();
        expect(masterService.getValue()).toBe(stubValue, 'service returned stub value');
        expect(valueServiceSpy.getValue.calls.count()).toBe(1, 'spy method was called once');
        expect(valueServiceSpy.getValue.calls.mostRecent().returnValue).toBe(stubValue);
    });

### Testing HTTP services

Data services that make HTTP calls to remote servers typically inject and delegate to the Angular HttpClient service for XHR calls.

You can test a data service with an injected HttpClient spy as you would test any service with a dependency.

    let httpClientSpy: { get: jasmine.Spy };
    let heroService: HeroService;

    beforeEach(() => {
        // TODO: spy on other methods too
        httpClientSpy = jasmine.createSpyObj('HttpClient', ['get']);
        heroService = new HeroService(<any> httpClientSpy);
    });

    it('should return expected heroes (HttpClient called once)', () => {
        const expectedHeroes: Hero[] = [{ id: 1, name: 'A' }, { id: 2, name: 'B' }]
        
        httpClientSpy.get.and.returnValue(asyncData(expectedHeroes));
        
        heroService.getHeroes().subscribe(heroes => expect(heroes).toEqual(expectedHeroes, 'expected heroes'), fail);
        expect(httpClientSpy.get.calls.count()).toBe(1, 'one call');
    });

    it('should return an error when the server returns a 404', () => {
        const errorResponse = new HttpErrorResponse({
            error: 'test 404 error',
            status: 404,
            statusText: 'Not Found'
        });
        
        httpClientSpy.get.and.returnValue(asyncError(errorResponse));
        
        heroService.getHeroes().subscribe(
            heroes => fail('expected an error, not heroes'),
            error => expect(error.message).toContain('test 404 error')
        );
    });

### HttpClientTestingModule

Extended interactions between a data service and the HttpClient can be complex and difficult to mock with spies.

The HttpClientTestingModule can make these testing scenarios more manageable.

## Component Test Basics

### Component class testing

Test a component class on its own as you would test a service class.

    @Component({
        selector: 'lightswitch-comp',
        template: `
            <button (click)="clicked()">Click me!</button>
            <span>{{message}}</span>`
    })
    export class LightswitchComponent {
        isOn = false;
        clicked() { this.isOn = !this.isOn; }
        get message() { return `The light is ${this.isOn ? 'On' : 'Off'}`; }
    }

