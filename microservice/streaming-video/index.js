const express = require('express');
const fs = require('fs');
const app = express();

if (!process.env.PORT) {
	throw new Error('please specify the port number for the HTTP server with the environment variable PORT.')
}

const PORT = process.env.PORT;

app.get('/video', (req, res) => {
	const path = "../videos/sample.mp4";
	fs.state(path, (err, stats) => {
		if (err) {
			console.error('an error occurred');
			res.sendStatus(500);
			return;
		}
		res.writeHead(200, {
			"Content-Length": stats.size,
			"Content-Type": "video/mp4",
		});
		fs.createReadStream(path).pipe(res);
	});
});

app.listen(PORT, () => {
	console.log(`app listening on port ${port}`);
});
