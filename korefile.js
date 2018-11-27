let fs = require('fs');
let path = require('path');
let project = new Project('New Project');
project.addDefine('HXCPP_API_LEVEL=332');
project.targetOptions = {"html5":{},"flash":{},"android":{},"ios":{}};
project.setDebugDir('build/osx');
await project.addProject('build/osx-build');
await project.addProject('/Users/Will/.vscode/extensions/kodetech.kha-18.11.4/Kha');
resolve(project);
