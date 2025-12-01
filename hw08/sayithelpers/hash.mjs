import bcrypt from "bcrypt";

const password = process.argv[2];

if (!password) {
    console.log("Usage: node hash.js <password>");
    process.exit(1);
}

const saltRounds = 12;

const hash = await bcrypt.hash(password, saltRounds);
console.log(`Password: ${password}`);
console.log(`Hash: ${hash}`);

