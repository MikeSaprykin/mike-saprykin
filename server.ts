import * as express from 'express';
import * as compression from 'compression';
const path = require('path');

const PORT =  process.env.PORT || 8080;
const app = express();

// Run the app by serving the static files
// in the dist directory
app.use(express.static(__dirname + '/build'));
app.use(compression());

// For all GET requests, send back index.html
// so that PathLocationStrategy can be used
app.get('/*', (req: any, res: any) => {
    res.sendFile(path.join(__dirname + '/build/index.html'));
});


app.listen(PORT);
