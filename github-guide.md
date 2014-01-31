UseR Burlington on GitHub
============================

A nice guide to github is available [here](http://readwrite.com/2013/09/30/understanding-github-a-journey-for-beginners-part-1#awesm=~ougxPZ28pysYVI)

1. Install [RStudio](http://www.rstudio.com/) (make sure you have at least Version 0.98) and [git](http://git-scm.com/) and start an account on [github](https://github.com/). Email [me](john.stantongeddes.research@gmail.com) your username and I will add you to the "UserR-Burlington" organization

2. Open RStudio

3. In the menu bar, select "File" --> "New Project" and the third option "Version Control"

4. Choose "git"

5. In the "Repository URL", type `https://github.com/UserR-Burlington/Superfoods`. Choose a "Project Directory Name" (e.g. Superfoods) and a subdirectory (e.g. ~/Documents/github_repos/UserR-Burlington/).

6. A window that says "Cloning into..." should briefly pop up as RStudio automatically downloads all files in the repository - yay!

7. Open "superfoods_gamestorm.Rmd" (File --> Open).

8. Modify file. Save

9. In the top right window of Rstudio, select the "Git" tab.

10. Check the boxes of the files under the first column "Staged" that you want to commit. Note that the blue M in the second column "Status" indicates that a file has been modified, and it will move from right to left when you stage it for a commit.   

11. Push the "Commit" button. This will bring up a new window. In the box in the top right, type your "Commit message". Something like "Added great new plots" or "Fixed bug in code". Remember, the more detailed, the better. Then push the "Commit" button. A window will pop-up telling you a commit has been made.

12. At the top right of the Commit window are three buttons - `Refresh`, `Pull` and `Push`. Push `Pull` - this will pull in any changes made while you were working. After you are up-to-date (hopefully no conflicts are introduced - another topic!), push `Push`. A dialog should briefly pop up - your changes are now in the public repository!


Addendum: So what if you want to use version control on your own repository? The basic process is the same. Start a project in RStudio, put it in version control (Tools --> Version Control). On [github](www.github.com), start a new repository and initialize it without a README or license. You can either open a terminal and follow the steps shown on the webpage:

    git remote add origin https://github.com/username/Hello-World.git
    git push origin master
    
or in RStudio, go to Tools --> Version Control --> Project Setup and in the "Origin" box, put in the url for the repository.