Feature 1 :  Project Scaffolding and Version Control
Report :
        I have created public git hub repository named  BSDSF23M035-OS-M035  with README.md file
        I copied the HTTPS URL of the repository.
        On my Linux terminal, I used the following command to clone the repository to my local machine:
        git clone <repository-URL](https://github.com/BSDSF23M035/BSDSF23M035-OS-M035->
        After cloning, I verified that the folder was successfully created and contained the initialized README.md
        I navigated inside my cloned repository by command (cd BSDSF23M035-OS-M035-)
        Using Linux shell commands, I created the required directory hierarchy(mkdir src include lib bin obj) & (touch REPORT.md)
        The resulting structure was:
        BSDSF23M035-OS-M035-/
        ├── src/        # Source code for library and application
        ├── include/    # Header files
        ├── lib/        # Compiled static and dynamic libraries
        ├── bin/        # Final executables
        ├── obj/        # Intermediate object files
        └── REPORT.md   # My analysis report
        Saved and Pushed the Structure to GitHub
        I staged all files and directories:
        git add .
        I committed the changes with a descriptive message(git commit -m "any Description")
        I pushed the commit to GitHub(git push origin main)
        
Feature-2: Multi-file Project using Make Utility
        Q1.Explain the linking rule in this part's Makefile:
        $(TARGET): $(OBJECTS)
        This rule tells make how to build the final executable (the target) from the compiled object files (.o files).
        Here $(TARGET) is the final binary (for example bin/client).
        $(OBJECTS) is a list of all the object files generated from source files (for example obj/main.o obj/mystrfunctions.o obj/myfilefunctions.o).
        When this rule runs, the linker (gcc by default) combines all the .o files into a single executable.
        Difference from linking against a library:
        In this Makefile, we are directly linking object files to produce the executable.
        If we were linking against a library, the rule would look something like:
        $(TARGET): $(OBJECTS) lib/mylib.a
	      $(CC) $(OBJECTS) -Llib -lmylib -o $(TARGET)
        Instead of just .o files, the linker pulls in precompiled code from a library (.a for static or .so for shared(dynamic)).
        So the key difference: direct linking combines object files, while library linking reuses precompiled modules stored in a library.
        Q2. What is a git tag and why is it useful in a project? What is the difference between a simple tag and an annotated tag?
        Git Tag:
        A tag in Git is a marker that points to a specific commit. It is often used to identify important points in history, such as version releases.
        Why useful:
        Marks stable releases (v0.1.0, v1.0, etc.).
        Makes it easier to go back to that exact commit later.
        Essential for versioning and software distribution.
        Simple Tag:
        Just a pointer to a commit.
        Does not store extra metadata (no tagger, date, or message).
        Example:(git tag v1.0)
        Annotated Tag:
        Stores full metadata: tagger’s name, email, date, and a descriptive message.
        Recommended for public releases.
        Example:(git tag -a v1.0 -m "Version 1.0 - any comment")
        In professional projects, annotated tags are always preferred.
        Q3. What is the purpose of creating a "Release" on GitHub? What is the significance of attaching binaries (like your client executable) to it?
        Purpose of GitHub Release:
        A Release is a packaged distribution of your project at a specific version
        It helps users download the exact version of the project (source code and/or binaries) without needing to clone and build.
        Acts as an official snapshot of the repository.
        Significance of attaching binaries:
        Many users (especially non-developers) may not want or be able to compile the source code themselves.
        Attaching binaries (like bin/client) lets them run the program immediately.
        Ensures consistency — everyone who downloads the release gets the same compiled binary.
        Makes your project look professional and ready for distribution.
Feature-3: Creating and using Static Library
        Q1. Compare the Makefile from Part 2 and Part 3. What are the key differences in the variables and rules that enable the creation of a static library?
        In Part 2, the Makefile directly compiled all .c source files into object files and linked them into a single executable.
        In Part 3, the Makefile first created a static library (libmyutils.a) containing the utility functions, and then linked the main program (main.c) against that library.
        Key differences:
        New library target: a rule to create libmyutils.a using ar rcs.
        Modified linking rule: the executable depends on the library, not directly on all utility .o files.
        Variables: added STATIC_LIB for the library path, and changed the executable target to link with -Llib -lmyutils.
        Q2. What is the purpose of the ar command? Why is ranlib often used immediately after it?
        ar (archiver): bundles multiple object files (.o) into a single static library file (.a).
        Purpose: simplifies linking — instead of linking many object files one by one, you link against a single library.
        ranlib: generates an index for the symbols inside the library. This allows the linker to quickly locate functions during compilation.
        On many systems, ar rcs already creates the index, but using ranlib ensures compatibility.
        Q3. When you run nm on your client_static executable, are the symbols for functions like mystrlen present? What does this tell you about how static linking works?
        Yes, the symbols for functions like mystrlen appear inside the final executable.
        This shows that static linking copies the actual code of the functions from the library into the executable at compile time.
        As a result, the executable is self-contained, does not need the library at runtime, and is usually larger in size compared to dynamic linking.
Feature-4: Creating and using Dynamic Library
        Q1. What is Position-Independent Code (-fPIC) and why is it a fundamental requirement for creating shared libraries?
        Position-Independent Code (PIC) means that the machine code can execute correctly regardless of where in memory it is loaded.
        For shared libraries (.so), PIC is essential because the operating system’s dynamic loader may map the library into different memory addresses for different processes.
        Without PIC, absolute addresses would break when the library is loaded at a new location.
        Q2. Explain the difference in file size between your static and dynamic clients. Why does this difference exist?
        The static client (client_static) is larger because it contains copies of all the utility function code directly embedded inside the executable.
        The dynamic client (client_dynamic) is smaller because it only contains references (symbols) to the functions, and the actual code is loaded from libmyutils.so at runtime.
        This size difference highlights the main advantage of dynamic linking: smaller executables and memory efficiency.
        Q3. What is the LD_LIBRARY_PATH environment variable? Why was it necessary to set it for your program to run, and what does this tell you about the responsibilities of the operating system's dynamic loader?
        LD_LIBRARY_PATH is an environment variable in Linux that tells the dynamic loader (ld.so) where to look for shared libraries at runtime.
        By default, the loader only checks system library directories like /lib and /usr/lib.
        Since libmyutils.so was in a custom lib/ directory, setting LD_LIBRARY_PATH=./lib explicitly told the loader to search there.
        This shows that the dynamic loader is responsible for finding and mapping the required shared libraries into memory before the program runs.
        
