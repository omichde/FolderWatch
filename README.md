# FolderWatch

Watch file changes in a folder and upon idling move each file to another folder.

Once a minute, a source folder is inspected and for each file its last modification date is checked. If it's older than 5 minutes, the file is moved to a destination folder.

## Use Case

I use [AudioHijack](https://rogueamoeba.com/audiohijack/) from Rogueamoeba to record radio streams, which works awesome but if your destination folder is a shared folder (e.g. via box.com) this file constantly uploaded even only small chunks of data is added to the file.

Hence this FolderWatch mini-project was born:

- let AudioHijack record to a temporary folder
- let FolderWatch observe this temporary folder as the source
- set the destination folder to any shared folder you like
- start FolderWatch
- it will report once a file is moved

## Caveats

- this app has to run in the foreground (hint: hide it)
- once restarted, this app loses its read/write permissions on Catalina, so click-and-confirm the source and destination folders and start again...

## Contact

[Oliver Michalak](mailto:oliver@werk01.de) - [omichde](https://twitter.com/omichde)

## License

FolderWatch is available under the MIT license:

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.

