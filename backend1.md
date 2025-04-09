+++

title = "50 Popular Backend Developer Interview Questions and Answers"

date = "2025-04-09"

draft = false

[taxonomies]  

tags=["documentation", "backend"]

[extra]                                                                                                                                                                                                                    
comment = true  

+++

## Beginner Level

### Explain what an API endpoint is?

An API endpoint is a specific URL that acts as an entry point into a specific service or a functionality within a service.

Through an API endpoint, client applications can interact with the server sending requests (sometimes even with data in the form of payload) and receive a response from it.

Usually, each endpoint can be mapped to a single feature inside the server.

### Can you explain the difference between SQL and NoSQL databases?

[SQL databases](https://roadmap.sh/sql) (or relational databases as they’re also known) rely on a predefined schema (or structure) for their data. Whenever you describe a record, or table inside the database, you do so through its format (name and fields).

In [NoSQL](https://roadmap.sh/mongodb) databases, there is no schema, so there is no predefined structure to the data. You usually have collections of records that are not obligated to have the same structure, even if they represent conceptually the same thing.

### What is a RESTful API, and what are its core principles?

For an API to be RESTful (which means it complies with the REST guidelines), it needs to:

- It needs to follow a client-server architecture (which all HTTP-based services do).
- It has to provide a uniform interface which means:
  - There should be a way to identify resources from each other through URIs (Unique Resource Identification).
  - There should be a way to modify resources through their representation.
  - Messages should be self descriptive, meaning that each message should provide enough information to understand how to process it.
  - Clients using the API should be able to discover actions available for the current resource using the provided response from the server (this is known as HATEOAS or Hypermedia as the Engine of Application State).
- It needs to be stateless, which means each request to the server must contain all information to process the request.
- It should be a layered system, meaning that client and server don’t have to be connected directly to each other, there might be intermediaries, but that should not affect the communication between client and server.
- Resources should be cacheable either by client or by server.
- Optionally, the server could send code to the client for it to execute (known as “Code on Demand”).

### Can you describe a typical HTTP request/response cycle?

The HTTP protocol is very structured and consists of a very well-defined set of steps:

- **Open the connection.** The client opens a TCP connection to the server. The port will be port 80 for HTTP connections and 443 for HTTPS (secured) connections.
- **Send the request.** The client will now send the HTTP request to the server. The request contains the following information:
  - An [HTTP method](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods). It can be any of them (i.e. GET, POST, PUT, DELETE, etc).
  - A URI (or Uniform Resource Identifier). This specifies the location of the resources on the server.
  - The HTTP version (usually HTTP/1.1 or HTTP/2).
  - A set of headers. They include extra data related to the request; there is a [full list of HTTP headers](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers) that can be used here.
  - The optional body. Depending on the type of request, you’ll want to also send data, and the data is encoded inside the body of the request.
- **Request processed by the server.** At this stage, the server will process the request and prepare a response.
- **Send the HTTP response back to the client.** Through the open channel, the server sends back an HTTP response. The response will contain the following elements:
  - The HTTP Version. 
  - The status code. There is a list of [potential status codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) that describe the result of the request.
  - A set of headers with extra data.
  - The optional body, just like with the request, the body of the response is optional.
- **The connection is closed.** This is usually the last step, although with newer versions of the protocol, there are options to leave the channel open and continue sending requests and responses back and forth.

### How would you handle file uploads in a web application?

From a backend developer perspective, the following considerations should be taken into account when handling file uploads regardless of the programming language you’re using:

- **Perform server-side validations.** Validate that the size of your file is within range, and that the file is of the required type. You can check [this OWASP guide](https://cheatsheetseries.owasp.org/cheatsheets/File_Upload_Cheat_Sheet.html) for more details.
- **Use secure channels.** Make sure the file upload is done through an HTTPS connection.
- **Avoid name collision.** Rename the file ensuring the new filename is unique within your system. Otherwise this can lead to application errors by not being able to save the uploaded files.
- **Keep metadata about your files.** Store it in your database or somewhere else, but make sure to keep track of it, so you can provide extra information to your users. Also, if you’re renaming the files for security and to avoid name collisions, keep track of the original filename in case the file needs to be downloaded back by the user.

### What kind of tests would you write for a new API endpoint?

As backend developers, we have to think about the types of tests that there are out there.

- **Unit tests:** Always remember to only test the relevant logic through the public interface of your code (avoid testing private methods or inaccessible functions inside your modules). Focus on the business logic and don’t try to test the code that uses external services (like a database, the disk or anything outside of the piece of code you’re testing).
- **Integration tests:** Test the full endpoint through its public interface (the actual HTTP endpoint) and see how it integrates with the external services it’s using (i.e the database, another API, etc).
- **Load testing / performance testing:** You might want to also check how the new endpoint behaves under heavy stress. This might not be required depending on the API you’re using, but as a rule of thumb, it’s a good one to perform at the end of the development phase before releasing the new endpoint into prod.

### Describe how session management works in web applications

The following is a high-level overview of how session management works for web applications:

- **The session is created.** This happens with the first interaction with the system by the user (during log-in). The backend of your app will create a unique session ID that will be stored and returned to the user to use in future requests.
- **Session information storage.** The session data needs to be stored somewhere. Whether it’s in-memory, or inside a database, it needs to be indexed by the session ID from the previous point. Here the best option is to use a database (ideally something like Redis with high I/O performance) so that the services can be scaled independently from the session data.
- **The session ID is sent to the client.** The most common way of doing this is through cookies. The backend can set up a cookie with the session ID and the frontend can read it securely and use that ID however it needs to.
- **Client sends the session ID.** After the ID is created, the client application will identify itself with the backend using this ID on every request.
- **Accessing the session data in the backend.** The backend will access the stored session data using the session ID received from the client.
- **Session is closed.** After a while, or perhaps through a user action, the session ID will be deleted, which will cause the session data to be lost (or removed from the DB). This effectively ends the interactions between the client and the server as part of the existing session.