export class Output<T> {

    success: boolean = true;
  
    data: T;
  
    message: string;
  
    dateTime = new Date().toISOString();
  
    errorCod: number;
  
    static out(status: number, body: any) {
      return {
        status,
        body,
        headers: {
          'Content-Type': 'application/json',
        }
      };
    }
  
    static ok(message: string = 'Ok', data?: any) {
      const output = new Output();
  
      output.message = message;
        if (data != null) output.data = data;
      output.errorCod = 0;
      return this.out(200, output);
    }

    static okFindInformation(message: string = 'Ok', success: boolean = false, data?: any) {
        const output = new Output();
        
        output.success = success;
        output.message = message;
          if (data != null) output.data = data;
        output.errorCod = 7042;
        return this.out(202, output);
    }

    static okNoExistInformation(message: string = 'Ok', success: boolean = false, data?: any) {
      const output = new Output();
      
      output.success = success;
      output.message = message;
        if (data != null) output.data = data;
      output.errorCod = 7048;
      return this.out(202, output);
  }
  
  
    static internalError(message: string = 'There are some errors.', data?: any) {
      const output = new Output();
  
      output.success = false;
  
      if (message) output.message = message;
      if (data) output.data = data;
      output.errorCod = 300;
      return this.out(500, output);
    }
  
    static error(message: string, data?: any) {
      const output = new Output();
  
      output.success = false;
      output.message = message;
  
      if (data) output.data = data;
      output.errorCod = 300;
      return this.out(400, output);
    }
  
    static badRequest(message: string, data?: any) {
      const output = new Output();
  
      output.success = false;
      output.message = message;
      //output.data = '';
      output.errorCod = 300;
      return this.out(400, output);
    }
  
    static unauthorized() {
      const output = new Output();
  
      output.success = false;
      output.errorCod = 300;
      return this.out(401, output);
    }
  
  }