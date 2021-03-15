const bodyParser = require("body-parser");
const express = require("express");

const config = {
	port: 8080,
};

app = express();
app.use(bodyParser.json());

app.post("/", (req, res) => {
	const input = req.body;

	if (input.feedback == null) {
		res.status(400).send("Missing parameter feedback\n");
		return;
	}

	res.status(201).send();
});

app.listen(config.port, () => {
	console.log(`trigger-func app listening on port ${config.port}\n`);
});


