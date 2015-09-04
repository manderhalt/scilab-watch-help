# scilab-watch-help v0.1

> Rebuild Scilab help whenever watched files are added, deleted or changed

## Getting Started
This file requires [Scilab](http://www.scilab.org/) and a Toolbox based on the Scilabs [toolbox_skeleton](https://atoms.scilab.org/toolboxes/toolbox_skeleton).

Next steps will be described with the Scilab standard [toolbox_skeleton](https://atoms.scilab.org/toolboxes/toolbox_skeleton/5.5.0/files/toolbox_skeleton-5.5.0-1-src.zip). To follow the Getting Started with the `toolbox_skeleton`, [download](https://atoms.scilab.org/toolboxes/toolbox_skeleton/5.5.0/files/toolbox_skeleton-5.5.0-1-src.zip) the sources of the toolbox skeleton and unzip it somewhere on your computer. 

Copy and paste `watch_help.sce` at the root level of your Toolbox (toolbox_skeleton here). 

```
toolbox_skeleton\
    demos\
    etc\
    ...    
    builder.sce
    watch_help.sce
```

Open `watch_help.sce` and change the values of the following variables at the end of the file:
- `TOOLBOX_TITLE` = same value as defined in the file `Toolbox/builder.sce` of your toolbox. 
- `languages` = same value as the one given as parameters of the `tbx_builder_help_lang` function in the file `Toolbox/help\builder_help.sce` of your toolbox.

```scilab
TOOLBOX_TITLE = "Toolbox Skeleton";
languages = ['fr_FR','en_US'];
```

Open Scilab and go to the root of your toolbox in the File Browser

Execute `watch_help.sce`

```scilab
exec watch_help.sce
```

While the process is running, Scilab won't be available! 

The following lines appear:
```
[INFO] Watch Help Builder starts
[INFO] Watch Help Builder is ready!
[INFO] Wait for file change... 
```

Edit a `.xml` help file with your favorite text editor and the help will be rebuilt automatically (or built if it has not been built before). 

Open a `.html` help file in the web browser of your choice. The `.html` help files are in `../toolbox_skeleton/help/fr_FR/scilab_fr_FR_help` for the french language. 

Change `.xml` files and refresh your web browser (F5) to see the result!

Now writting Scilab help is like a funny game!

## Livereload
To avoid to refresh the web browser manually, you can use a live or auto reload. There is a lot of different ways to do this.

### In the browser
On Firefox, Chrome or Safari you can add a livereload or autoreload plugin.

### With a webserver
UNIX users can easily start a web server with livereload capability in the help folder. The page is served on the localhost http://127.0.0.1:8000/index.html and will be refreshed whenever the underlying file is changed. 

You can do this with [python](https://github.com/lepture/python-livereload), [node](https://github.com/napcs/node-livereload) or [grunt](https://github.com/gruntjs/grunt-contrib-connect) (with [grunt watch](https://github.com/gruntjs/grunt-contrib-watch)). 




