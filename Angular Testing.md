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
  
