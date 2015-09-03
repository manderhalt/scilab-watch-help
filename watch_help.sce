// Rebuild help whenever watched files are added, deleted or changed. 
// Auteur: Mathieu Anderhalt
// Mail: mathieu.anderhalt@gmail.com
// Date: 03/09/2015
// This file must be added at the Toolbox root level (= same level as
// builder.sce): Toolbox/watch_help.sce
// If you want to change the location of this file, change the 
// toolbox_dir definition at the end of the file
// "toolbox_dir   = get_absolute_file_path("watch_help.sce");"
// TODO: Handle compilation errors 
// TODO: Asynchronous watch 

function filenames = get_xml_help_files(languages,toolbox_dir)
    // get .xml files names in help directories
    // Inputs: 
    //  - languages = vector of languages
    //  - toolbox_dir = Root directory of the Toolbox 
    filenames = [];
    for l=languages
        filenames = [filenames;...
            listfiles(fullfile(toolbox_dir,'help',l,'*.xml'))];
    end
    filenames=gsort(filenames,'r','i')
endfunction

function []=watch_help_builder(toolbox_dir,languages)
    // Rebuild .html help whenever watched files are added, 
    // deleted or changed
    // Inputs: 
    //  - languages = vector of languages
    //  - toolbox_dir = Root directory of the Toolbox 
    printf("\n[INFO] Watch Help Builder starts");
    // Get files names
    filenames = get_xml_help_files(languages,toolbox_dir);
    if filenames==[]
        printf("\n[INFO] No xml file in %s",toolbox_dir);
        printf("\n[INFO] Change the directory and restart Watch Help Builder");
        return;
    end
    // Initialization of files information
    fileinfos = fileinfo(filenames);
    // Save previous files info
    filenames_0 = filenames;
    fileinfos_0 = fileinfos;
    printf("\n[INFO] Watch Help Builder is ready!");
    printf("\n[INFO] Wait for file change...");
    // Start watcher
    while %T then
        // watch every seconds 
        sleep(1000)
        filenames = get_xml_help_files(languages,toolbox_dir);
        fileinfos = fileinfo(filenames);
        // watch new files
        somenew = setdiff(filenames,filenames_0);
        if ~somenew==[] then
            for f=somenew
                [path, fname, extension] = fileparts(f);
                printf("\n[INFO] Added : %s", fname+extension);
            end
        end
        // watch deleted files
        somedel = setdiff(filenames_0,filenames);
        if ~somedel==[] then
            for f=somedel
                [path, fname, extension] = fileparts(f);
                printf("\n[INFO] Deleted : %s", fname+extension);
            end
        end
        // watch changed files 
        somechange = find(~fileinfos(:,6) == fileinfos_0(:,6));
        if and([~somechange==[],somedel==[],somenew==[]]) then
            for fi=somechange
                f = filenames(fi);
                [path, fname, extension] = fileparts(f);
                printf("\n[INFO] Changed : %s", fname+extension);
            end
        end
        // Rebuild help whenever watched files are added, deleted or changed
        if or([~somenew==[],~somedel==[],~somechange==[]]) then
            printf("\n[INFO] Build Help...");
            tbx_builder_help(toolbox_dir);
            printf("\n[INFO] Wait for file change...");
            filenames = get_xml_help_files(languages,toolbox_dir);
            fileinfos = fileinfo(filenames);
        end
        // Save previous files info
        filenames_0 = filenames;
        fileinfos_0 = fileinfos;
    end
endfunction
// Run watch_help_builder
// ----------------------
TOOLBOX_TITLE = "Toolbox";
// = TOOLBOX_TITLE as defined in Toolbox/builder.sce
languages = ['fr_FR','en_US'];
// = languages as defined in Toolbox/help/builder_help.sce
toolbox_dir   = get_absolute_file_path("watch_help.sce");
watch_help_builder(toolbox_dir,languages)
