# Express App Generator

This script can be used to setup an express.js project.
It generates the boilerplate and config files in a way I prefer them.

#### Note
At the end, you need to interact with your terminal for determining the flavour of `tsconfig.json`.
It should be `node(Default)`.
Removing this step and setting up the `tsconfig.json` with this flavour is something I will work on in the future.

---

### Usage

#### Quickly downloading the script without cloning

```
curl https://raw.githubusercontent.com/mrbeepot/express-app-gen/master/build.sh > build.sh
```

#### Generating a plain JS project
```
./build.sh my-app
```

#### Generating a project with TypeScript dependencies
```
./build.sh my-app ts
```

`Run build.sh -h` for the usage instructions