From: rusty@rustcorp.com.au
Subject: [patch 16/43] lguest: Accept elf files that are valid but have
	sections that can not be mmaped for some reason.
Date: Wed, 26 Sep 2007 16:36:34 +1000
Message-ID: <20070926063647.988925288@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline;
	filename=0001-Accept-elf-files-that-are-valid-but-have-sections-th.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: "Ronald G. Minnich" <rminnich@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Ronald G. Minnich <rminnich@gmail.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |   61 +++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

===================================================================
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -15,6 +15,7 @@
 #include <stdlib.h>
 #include <elf.h>
 #include <sys/mman.h>
+#include <sys/param.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
@@ -162,6 +163,30 @@ static unsigned long entry_point(void *s
 	errx(1, "Is this image a genuine lguest?");
 }
 
+/* This routine is used to load the kernel or initrd.  It tries mmap, but if
+ * that fails (Plan 9's kernel file isn't nicely aligned on page boundaries),
+ * it falls back to reading the memory in. */
+static void map_at(int fd, void *addr, unsigned long offset, unsigned long len)
+{
+	ssize_t r;
+
+	/* We map writable even though for some segments are marked read-only.
+	 * The kernel really wants to be writable: it patches its own
+	 * instructions.
+	 *
+	 * MAP_PRIVATE means that the page won't be copied until a write is
+	 * done to it.  This allows us to share untouched memory between
+	 * Guests. */
+	if (mmap(addr, len, PROT_READ|PROT_WRITE|PROT_EXEC,
+		 MAP_FIXED|MAP_PRIVATE, fd, offset) != MAP_FAILED)
+		return;
+
+	/* pread does a seek and a read in one shot: saves a few lines. */
+	r = pread(fd, addr, len, offset);
+	if (r != len)
+		err(1, "Reading offset %lu len %lu gave %zi", offset, len, r);
+}
+
 /* This routine takes an open vmlinux image, which is in ELF, and maps it into
  * the Guest memory.  ELF = Embedded Linking Format, which is the format used
  * by all modern binaries on Linux including the kernel.
@@ -176,7 +201,6 @@ static unsigned long map_elf(int elf_fd,
 static unsigned long map_elf(int elf_fd, const Elf32_Ehdr *ehdr,
 			     unsigned long *page_offset)
 {
-	void *addr;
 	Elf32_Phdr phdr[ehdr->e_phnum];
 	unsigned int i;
 	unsigned long start = -1UL, end = 0;
@@ -227,23 +251,9 @@ static unsigned long map_elf(int elf_fd,
 		if (phdr[i].p_paddr + phdr[i].p_filesz > end)
 			end = phdr[i].p_paddr + phdr[i].p_filesz;
 
-		/* We map this section of the file at its physical address.  We
-		 * map it read & write even if the header says this segment is
-		 * read-only.  The kernel really wants to be writable: it
-		 * patches its own instructions which would normally be
-		 * read-only.
-		 *
-		 * MAP_PRIVATE means that the page won't be copied until a
-		 * write is done to it.  This allows us to share much of the
-		 * kernel memory between Guests. */
-		addr = mmap((void *)phdr[i].p_paddr,
-			    phdr[i].p_filesz,
-			    PROT_READ|PROT_WRITE|PROT_EXEC,
-			    MAP_FIXED|MAP_PRIVATE,
-			    elf_fd, phdr[i].p_offset);
-		if (addr != (void *)phdr[i].p_paddr)
-			err(1, "Mmaping vmlinux seg %i gave %p not %p",
-			    i, addr, (void *)phdr[i].p_paddr);
+		/* We map this section of the file at its physical address. */
+		map_at(elf_fd, (void *)phdr[i].p_paddr,
+		       phdr[i].p_offset, phdr[i].p_filesz);
 	}
 
 	return entry_point((void *)start, (void *)end, *page_offset);
@@ -402,27 +412,20 @@ static unsigned long load_initrd(const c
 	int ifd;
 	struct stat st;
 	unsigned long len;
-	void *iaddr;
 
 	ifd = open_or_die(name, O_RDONLY);
 	/* fstat() is needed to get the file size. */
 	if (fstat(ifd, &st) < 0)
 		err(1, "fstat() on initrd '%s'", name);
 
-	/* The length needs to be rounded up to a page size: mmap needs the
-	 * address to be page aligned. */
+	/* We map the initrd at the top of memory, but mmap wants it to be
+	 * page-aligned, so we round the size up for that. */
 	len = page_align(st.st_size);
-	/* We map the initrd at the top of memory. */
-	iaddr = mmap((void *)mem - len, st.st_size,
-		     PROT_READ|PROT_EXEC|PROT_WRITE,
-		     MAP_FIXED|MAP_PRIVATE, ifd, 0);
-	if (iaddr != (void *)mem - len)
-		err(1, "Mmaping initrd '%s' returned %p not %p",
-		    name, iaddr, (void *)mem - len);
+	map_at(ifd, (void *)mem - len, 0, st.st_size);
 	/* Once a file is mapped, you can close the file descriptor.  It's a
 	 * little odd, but quite useful. */
 	close(ifd);
-	verbose("mapped initrd %s size=%lu @ %p\n", name, st.st_size, iaddr);
+	verbose("mapped initrd %s size=%lu @ %p\n", name, len, (void*)mem-len);
 
 	/* We return the initrd size. */
 	return len;

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
