From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 1/5] lguest: mmap backing file
Date: Thu, 20 Mar 2008 17:05:44 +1100
Message-ID: <200803201705.44422.rusty__12930.9839023792$1205993307$gmane$org@rustcorp.com.au>
References: <200803201659.14344.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201659.14344.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Paul TBBle Hampson <Paul.Hampson@Pobox.com>

This creates a file in $HOME/.lguest/ to directly back the RAM and DMA memory
mappings created by map_zeroed_pages.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |   59 ++++++++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/Documentation/lguest/lguest.c b/Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -236,19 +236,51 @@ static int open_or_die(const char *name,
 	return fd;
 }
 
-/* map_zeroed_pages() takes a number of pages. */
+/* unlink_memfile() removes the backing file for the Guest's memory, if we exit
+ * cleanly. */
+static char memfile_path[PATH_MAX];
+
+static void unlink_memfile(void)
+{
+	unlink(memfile_path);
+}
+
+/* map_zeroed_pages() takes a number of pages, and creates a mapping file where
+ * this Guest's memory lives. */
 static void *map_zeroed_pages(unsigned int num)
 {
-	int fd = open_or_die("/dev/zero", O_RDONLY);
+	int fd;
 	void *addr;
 
-	/* We use a private mapping (ie. if we write to the page, it will be
-	 * copied). */
+	/* We create a .lguest directory in the user's home, to put the memory
+	 * files into. */
+	snprintf(memfile_path, PATH_MAX, "%s/.lguest", getenv("HOME") ?: "");
+	if (mkdir(memfile_path, S_IRWXU) != 0 && errno != EEXIST)
+		err(1, "Creating directory %s", memfile_path);
+
+	/* Name the memfiles by the process ID of this launcher. */
+	snprintf(memfile_path, PATH_MAX, "%s/.lguest/%u",
+		 getenv("HOME") ?: "", getpid());
+	fd = open(memfile_path, O_RDWR | O_CREAT | O_TRUNC, S_IRWXU);
+	if (fd < 0)
+		err(1, "Creating memory backing file %s", memfile_path);
+
+	/* Make sure we remove it when we're finished. */
+	atexit(unlink_memfile);
+
+	/* Now, we opened it with O_TRUNC, so the file is 0 bytes long.  Here
+	 * we expand it to the length we need, and it will be filled with
+	 * zeroes. */
+	if (ftruncate(fd, num * getpagesize()) != 0)
+		err(1, "Truncating file %s %u pages", memfile_path, num);
+
+	/* We use a shared mapping, so others can share with us. */
 	addr = mmap(NULL, getpagesize() * num,
-		    PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, fd, 0);
+		    PROT_READ|PROT_WRITE|PROT_EXEC, MAP_SHARED, fd, 0);
 	if (addr == MAP_FAILED)
 		err(1, "Mmaping %u pages of /dev/zero", num);
 
+	verbose("Memory backing file is %s @ %p\n", memfile_path, addr);
 	return addr;
 }
 
@@ -263,23 +295,12 @@ static void *get_pages(unsigned int num)
 	return addr;
 }
 
-/* This routine is used to load the kernel or initrd.  It tries mmap, but if
- * that fails (Plan 9's kernel file isn't nicely aligned on page boundaries),
- * it falls back to reading the memory in. */
+/* This routine is used to load the kernel or initrd.  We used to mmap, but now
+ * we simply read it in, so it will be present in the shared underlying
+ * file. */
 static void map_at(int fd, void *addr, unsigned long offset, unsigned long len)
 {
 	ssize_t r;
-
-	/* We map writable even though for some segments are marked read-only.
-	 * The kernel really wants to be writable: it patches its own
-	 * instructions.
-	 *
-	 * MAP_PRIVATE means that the page won't be copied until a write is
-	 * done to it.  This allows us to share untouched memory between
-	 * Guests. */
-	if (mmap(addr, len, PROT_READ|PROT_WRITE|PROT_EXEC,
-		 MAP_FIXED|MAP_PRIVATE, fd, offset) != MAP_FAILED)
-		return;
 
 	/* pread does a seek and a read in one shot: saves a few lines. */
 	r = pread(fd, addr, len, offset);
