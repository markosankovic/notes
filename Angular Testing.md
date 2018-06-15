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

