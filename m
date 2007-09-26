From: rusty@rustcorp.com.au
Subject: [patch 17/43] lguest: Introduce guest mem offset,
	static link example launcher
Date: Wed, 26 Sep 2007 16:36:35 +1000
Message-ID: <20070926063648.190077613@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=launcher-offset.patch
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In order to avoid problematic special linking of the Launcher, we give
the Host an offset: this means we can use any memory region in the
Launcher as Guest memory rather than insisting on mmap() at 0.

The result is quite pleasing: a number of casts are replaced with
simple additions.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 Documentation/lguest/Makefile |   28 -----
 Documentation/lguest/lguest.c |  195 +++++++++++++++++++++++------------------
 drivers/lguest/core.c         |   22 ++--
 drivers/lguest/hypercalls.c   |   15 +--
 drivers/lguest/io.c           |   18 ++-
 drivers/lguest/lg.h           |    3 
 drivers/lguest/lguest_user.c  |   23 ++--
 drivers/lguest/page_tables.c  |    7 +
 8 files changed, 167 insertions(+), 144 deletions(-)

===================================================================
--- a/Documentation/lguest/Makefile
+++ b/Documentation/lguest/Makefile
@@ -1,28 +1,8 @@
 # This creates the demonstration utility "lguest" which runs a Linux guest.
+CFLAGS:=-Wall -Wmissing-declarations -Wmissing-prototypes -O3 -I../../include
+LDLIBS:=-lz
 
-# For those people that have a separate object dir, look there for .config
-KBUILD_OUTPUT := ../..
-ifdef O
-  ifeq ("$(origin O)", "command line")
-    KBUILD_OUTPUT := $(O)
-  endif
-endif
-# We rely on CONFIG_PAGE_OFFSET to know where to put lguest binary.
-include $(KBUILD_OUTPUT)/.config
-LGUEST_GUEST_TOP := ($(CONFIG_PAGE_OFFSET) - 0x08000000)
-
-CFLAGS:=-Wall -Wmissing-declarations -Wmissing-prototypes -O3 -I../../include -Wl,-T,lguest.lds
-LDLIBS:=-lz
-# Removing this works for some versions of ld.so (eg. Ubuntu Feisty) and
-# not others (eg. FC7).
-LDFLAGS+=-static
-all: lguest.lds lguest
-
-# The linker script on x86 is so complex the only way of creating one
-# which will link our binary in the right place is to mangle the
-# default one.
-lguest.lds:
-	$(LD) --verbose | awk '/^==========/ { PRINT=1; next; } /SIZEOF_HEADERS/ { gsub(/0x[0-9A-F]*/, "$(LGUEST_GUEST_TOP)") } { if (PRINT) print $$0; }' > $@
+all: lguest
 
 clean:
-	rm -f lguest.lds lguest
+	rm -f lguest
===================================================================
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -1,10 +1,7 @@
 /*P:100 This is the Launcher code, a simple program which lays out the
  * "physical" memory for the new Guest by mapping the kernel image and the
  * virtual devices, then reads repeatedly from /dev/lguest to run the Guest.
- *
- * The only trick: the Makefile links it at a high address so it will be clear
- * of the guest memory region.  It means that each Guest cannot have more than
- * about 2.5G of memory on a normally configured Host. :*/
+:*/
 #define _LARGEFILE64_SOURCE
 #define _GNU_SOURCE
 #include <stdio.h>
@@ -56,6 +53,8 @@ typedef uint8_t u8;
 #ifndef SIOCBRADDIF
 #define SIOCBRADDIF	0x89a2		/* add interface to bridge      */
 #endif
+/* We can have up to 256 pages for devices. */
+#define DEVICE_PAGES 256
 
 /*L:120 verbose is both a global flag and a macro.  The C preprocessor allows
  * this, and although I wouldn't recommend it, it works quite nicely here. */
@@ -66,8 +65,10 @@ static bool verbose;
 
 /* The pipe to send commands to the waker process */
 static int waker_fd;
-/* The top of guest physical memory. */
-static u32 top;
+/* The pointer to the start of guest memory. */
+static void *guest_base;
+/* The maximum guest physical address allowed, and maximum possible. */
+static unsigned long guest_limit, guest_max;
 
 /* This is our list of devices. */
 struct device_list
@@ -111,6 +112,29 @@ struct device
 	void *priv;
 };
 
+/*L:100 The Launcher code itself takes us out into userspace, that scary place
+ * where pointers run wild and free!  Unfortunately, like most userspace
+ * programs, it's quite boring (which is why everyone likes to hack on the
+ * kernel!).  Perhaps if you make up an Lguest Drinking Game at this point, it
+ * will get you through this section.  Or, maybe not.
+ *
+ * The Launcher sets up a big chunk of memory to be the Guest's "physical"
+ * memory and stores it in "guest_base".  In other words, Guest physical ==
+ * Launcher virtual with an offset.
+ *
+ * This can be tough to get your head around, but usually it just means that we
+ * use these trivial conversion functions when the Guest gives us it's
+ * "physical" addresses: */
+static void *from_guest_phys(unsigned long addr)
+{
+	return guest_base + addr;
+}
+
+static unsigned long to_guest_phys(const void *addr)
+{
+	return (addr - guest_base);
+}
+
 /*L:130
  * Loading the Kernel.
  *
@@ -124,33 +148,40 @@ static int open_or_die(const char *name,
 	return fd;
 }
 
-/* map_zeroed_pages() takes a (page-aligned) address and a number of pages. */
-static void *map_zeroed_pages(unsigned long addr, unsigned int num)
-{
-	/* We cache the /dev/zero file-descriptor so we only open it once. */
-	static int fd = -1;
-
-	if (fd == -1)
-		fd = open_or_die("/dev/zero", O_RDONLY);
+/* map_zeroed_pages() takes a number of pages. */
+static void *map_zeroed_pages(unsigned int num)
+{
+	int fd = open_or_die("/dev/zero", O_RDONLY);
+	void *addr;
 
 	/* We use a private mapping (ie. if we write to the page, it will be
-	 * copied), and obviously we insist that it be mapped where we ask. */
-	if (mmap((void *)addr, getpagesize() * num,
-		 PROT_READ|PROT_WRITE|PROT_EXEC, MAP_FIXED|MAP_PRIVATE, fd, 0)
-	    != (void *)addr)
-		err(1, "Mmaping %u pages of /dev/zero @%p", num, (void *)addr);
-
-	/* Returning the address is just a courtesy: can simplify callers. */
-	return (void *)addr;
+	 * copied). */
+	addr = mmap(NULL, getpagesize() * num,
+		    PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE, fd, 0);
+	if (addr == MAP_FAILED)
+		err(1, "Mmaping %u pages of /dev/zero", num);
+
+	return addr;
+}
+
+/* Get some more pages for a device. */
+static void *get_pages(unsigned int num)
+{
+	void *addr = from_guest_phys(guest_limit);
+
+	guest_limit += num * getpagesize();
+	if (guest_limit > guest_max)
+		errx(1, "Not enough memory for devices");
+	return addr;
 }
 
 /* To find out where to start we look for the magic Guest string, which marks
  * the code we see in lguest_asm.S.  This is a hack which we are currently
  * plotting to replace with the normal Linux entry point. */
-static unsigned long entry_point(void *start, void *end,
+static unsigned long entry_point(const void *start, const void *end,
 				 unsigned long page_offset)
 {
-	void *p;
+	const void *p;
 
 	/* The scan gives us the physical starting address.  We want the
 	 * virtual address in this case, and fortunately, we already figured
@@ -158,7 +189,8 @@ static unsigned long entry_point(void *s
 	 * "page_offset". */
 	for (p = start; p < end; p++)
 		if (memcmp(p, "GenuineLguest", strlen("GenuineLguest")) == 0)
-			return (long)p + strlen("GenuineLguest") + page_offset;
+			return to_guest_phys(p + strlen("GenuineLguest"))
+				+ page_offset;
 
 	errx(1, "Is this image a genuine lguest?");
 }
@@ -201,9 +233,9 @@ static unsigned long map_elf(int elf_fd,
 static unsigned long map_elf(int elf_fd, const Elf32_Ehdr *ehdr,
 			     unsigned long *page_offset)
 {
+	void *start = (void *)-1, *end = NULL;
 	Elf32_Phdr phdr[ehdr->e_phnum];
 	unsigned int i;
-	unsigned long start = -1UL, end = 0;
 
 	/* Sanity checks on the main ELF header: an x86 executable with a
 	 * reasonable number of correctly-sized program headers. */
@@ -246,17 +278,17 @@ static unsigned long map_elf(int elf_fd,
 
 		/* We track the first and last address we mapped, so we can
 		 * tell entry_point() where to scan. */
-		if (phdr[i].p_paddr < start)
-			start = phdr[i].p_paddr;
-		if (phdr[i].p_paddr + phdr[i].p_filesz > end)
-			end = phdr[i].p_paddr + phdr[i].p_filesz;
+		if (from_guest_phys(phdr[i].p_paddr) < start)
+			start = from_guest_phys(phdr[i].p_paddr);
+		if (from_guest_phys(phdr[i].p_paddr) + phdr[i].p_filesz > end)
+			end=from_guest_phys(phdr[i].p_paddr)+phdr[i].p_filesz;
 
 		/* We map this section of the file at its physical address. */
-		map_at(elf_fd, (void *)phdr[i].p_paddr,
+		map_at(elf_fd, from_guest_phys(phdr[i].p_paddr),
 		       phdr[i].p_offset, phdr[i].p_filesz);
 	}
 
-	return entry_point((void *)start, (void *)end, *page_offset);
+	return entry_point(start, end, *page_offset);
 }
 
 /*L:170 Prepare to be SHOCKED and AMAZED.  And possibly a trifle nauseated.
@@ -307,7 +339,7 @@ static unsigned long unpack_bzimage(int 
 	 * actually configurable as CONFIG_PHYSICAL_START, but as the comment
 	 * there says, "Don't change this unless you know what you are doing".
 	 * Indeed. */
-	void *img = (void *)0x100000;
+	void *img = from_guest_phys(0x100000);
 
 	/* gzdopen takes our file descriptor (carefully placed at the start of
 	 * the GZIP header we found) and returns a gzFile. */
@@ -421,7 +453,7 @@ static unsigned long load_initrd(const c
 	/* We map the initrd at the top of memory, but mmap wants it to be
 	 * page-aligned, so we round the size up for that. */
 	len = page_align(st.st_size);
-	map_at(ifd, (void *)mem - len, 0, st.st_size);
+	map_at(ifd, from_guest_phys(mem - len), 0, st.st_size);
 	/* Once a file is mapped, you can close the file descriptor.  It's a
 	 * little odd, but quite useful. */
 	close(ifd);
@@ -431,9 +463,9 @@ static unsigned long load_initrd(const c
 	return len;
 }
 
-/* Once we know how much memory we have, and the address the Guest kernel
- * expects, we can construct simple linear page tables which will get the Guest
- * far enough into the boot to create its own.
+/* Once we know the address the Guest kernel expects, we can construct simple
+ * linear page tables for all of memory which will get the Guest far enough
+ * into the boot to create its own.
  *
  * We lay them out of the way, just below the initrd (which is why we need to
  * know its size). */
@@ -457,7 +489,7 @@ static unsigned long setup_pagetables(un
 	linear_pages = (mapped_pages + ptes_per_page-1)/ptes_per_page;
 
 	/* We put the toplevel page directory page at the top of memory. */
-	pgdir = (void *)mem - initrd_size - getpagesize();
+	pgdir = from_guest_phys(mem) - initrd_size - getpagesize();
 
 	/* Now we use the next linear_pages pages as pte pages */
 	linear = (void *)pgdir - linear_pages*getpagesize();
@@ -473,15 +505,16 @@ static unsigned long setup_pagetables(un
 	 * continue from there. */
 	for (i = 0; i < mapped_pages; i += ptes_per_page) {
 		pgdir[(i + page_offset/getpagesize())/ptes_per_page]
-			= (((u32)linear + i*sizeof(u32)) | PAGE_PRESENT);
-	}
-
-	verbose("Linear mapping of %u pages in %u pte pages at %p\n",
-		mapped_pages, linear_pages, linear);
+			= ((to_guest_phys(linear) + i*sizeof(u32))
+			   | PAGE_PRESENT);
+	}
+
+	verbose("Linear mapping of %u pages in %u pte pages at %#lx\n",
+		mapped_pages, linear_pages, to_guest_phys(linear));
 
 	/* We return the top level (guest-physical) address: the kernel needs
 	 * to know where it is. */
-	return (unsigned long)pgdir;
+	return to_guest_phys(pgdir);
 }
 
 /* Simple routine to roll all the commandline arguments together with spaces
@@ -501,14 +534,19 @@ static void concat(char *dst, char *args
 
 /* This is where we actually tell the kernel to initialize the Guest.  We saw
  * the arguments it expects when we looked at initialize() in lguest_user.c:
- * the top physical page to allow, the top level pagetable, the entry point and
- * the page_offset constant for the Guest. */
+ * the base of guest "physical" memory, the top physical page to allow, the
+ * top level pagetable, the entry point and the page_offset constant for the
+ * Guest. */
 static int tell_kernel(u32 pgdir, u32 start, u32 page_offset)
 {
 	u32 args[] = { LHREQ_INITIALIZE,
-		       top/getpagesize(), pgdir, start, page_offset };
+		       (unsigned long)guest_base,
+		       guest_limit / getpagesize(),
+		       pgdir, start, page_offset };
 	int fd;
 
+	verbose("Guest: %p - %p (%#lx)\n",
+		guest_base, guest_base + guest_limit, guest_limit);
 	fd = open_or_die("/dev/lguest", O_RDWR);
 	if (write(fd, args, sizeof(args)) < 0)
 		err(1, "Writing to /dev/lguest");
@@ -605,11 +643,11 @@ static void *_check_pointer(unsigned lon
 {
 	/* We have to separately check addr and addr+size, because size could
 	 * be huge and addr + size might wrap around. */
-	if (addr >= top || addr + size >= top)
+	if (addr >= guest_limit || addr + size >= guest_limit)
 		errx(1, "%s:%i: Invalid address %li", __FILE__, line, addr);
 	/* We return a pointer for the caller's convenience, now we know it's
 	 * safe to use. */
-	return (void *)addr;
+	return from_guest_phys(addr);
 }
 /* A macro which transparently hands the line number to the real function. */
 #define check_pointer(addr,size) _check_pointer(addr, size, __LINE__)
@@ -646,7 +684,7 @@ static u32 *get_dma_buffer(int fd, void 
 static u32 *get_dma_buffer(int fd, void *key,
 			   struct iovec iov[], unsigned int *num, u32 *irq)
 {
-	u32 buf[] = { LHREQ_GETDMA, (u32)key };
+	u32 buf[] = { LHREQ_GETDMA, to_guest_phys(key) };
 	unsigned long udma;
 	u32 *res;
 
@@ -998,11 +1036,11 @@ new_dev_desc(struct lguest_device_desc *
 			descs[i].features = features;
 			descs[i].num_pages = num_pages;
 			/* If they said the device needs memory, we allocate
-			 * that now, bumping up the top of Guest memory. */
+			 * that now. */
 			if (num_pages) {
-				map_zeroed_pages(top, num_pages);
-				descs[i].pfn = top/getpagesize();
-				top += num_pages*getpagesize();
+				unsigned long pa;
+				pa = to_guest_phys(get_pages(num_pages));
+				descs[i].pfn = pa / getpagesize();
 			}
 			return &descs[i];
 		}
@@ -1040,9 +1078,9 @@ static struct device *new_device(struct 
 	if (handle_input)
 		set_fd(dev->fd, devices);
 	dev->desc = new_dev_desc(devices->descs, type, features, num_pages);
-	dev->mem = (void *)(dev->desc->pfn * getpagesize());
+	dev->mem = from_guest_phys(dev->desc->pfn * getpagesize());
 	dev->handle_input = handle_input;
-	dev->watch_key = (unsigned long)dev->mem + watch_off;
+	dev->watch_key = to_guest_phys(dev->mem) + watch_off;
 	dev->handle_output = handle_output;
 	return dev;
 }
@@ -1382,21 +1420,7 @@ static void usage(void)
 	     "<mem-in-mb> vmlinux [args...]");
 }
 
-/*L:100 The Launcher code itself takes us out into userspace, that scary place
- * where pointers run wild and free!  Unfortunately, like most userspace
- * programs, it's quite boring (which is why everyone like to hack on the
- * kernel!).  Perhaps if you make up an Lguest Drinking Game at this point, it
- * will get you through this section.  Or, maybe not.
- *
- * The Launcher binary sits up high, usually starting at address 0xB8000000.
- * Everything below this is the "physical" memory for the Guest.  For example,
- * if the Guest were to write a "1" at physical address 0, we would see a "1"
- * in the Launcher at "(int *)0".  Guest physical == Launcher virtual.
- *
- * This can be tough to get your head around, but usually it just means that we
- * don't need to do any conversion when the Guest gives us it's "physical"
- * addresses.
- */
+/*L:105 The main routine is where the real work begins: */
 int main(int argc, char *argv[])
 {
 	/* Memory, top-level pagetable, code startpoint, PAGE_OFFSET and size
@@ -1406,8 +1430,8 @@ int main(int argc, char *argv[])
 	int i, c, lguest_fd;
 	/* The list of Guest devices, based on command line arguments. */
 	struct device_list device_list;
-	/* The boot information for the Guest: at guest-physical address 0. */
-	void *boot = (void *)0;
+	/* The boot information for the Guest. */
+	void *boot;
 	/* If they specify an initrd file to load. */
 	const char *initrd_name = NULL;
 
@@ -1427,9 +1451,16 @@ int main(int argc, char *argv[])
 	 * of memory now. */
 	for (i = 1; i < argc; i++) {
 		if (argv[i][0] != '-') {
-			mem = top = atoi(argv[i]) * 1024 * 1024;
-			device_list.descs = map_zeroed_pages(top, 1);
-			top += getpagesize();
+			mem = atoi(argv[i]) * 1024 * 1024;
+			/* We start by mapping anonymous pages over all of
+			 * guest-physical memory range.  This fills it with 0,
+			 * and ensures that the Guest won't be killed when it
+			 * tries to access it. */
+			guest_base = map_zeroed_pages(mem / getpagesize()
+						      + DEVICE_PAGES);
+			guest_limit = mem;
+			guest_max = mem + DEVICE_PAGES*getpagesize();
+			device_list.descs = get_pages(1);
 			break;
 		}
 	}
@@ -1462,17 +1493,17 @@ int main(int argc, char *argv[])
 	if (optind + 2 > argc)
 		usage();
 
+	verbose("Guest base is at %p\n", guest_base);
+
 	/* We always have a console device */
 	setup_console(&device_list);
-
-	/* We start by mapping anonymous pages over all of guest-physical
-	 * memory range.  This fills it with 0, and ensures that the Guest
-	 * won't be killed when it tries to access it. */
-	map_zeroed_pages(0, mem / getpagesize());
 
 	/* Now we load the kernel */
 	start = load_kernel(open_or_die(argv[optind+1], O_RDONLY),
 			    &page_offset);
+
+	/* Boot information is stashed at physical address 0 */
+	boot = from_guest_phys(0);
 
 	/* Map the initrd image if requested (at top of physical memory) */
 	if (initrd_name) {
@@ -1495,7 +1526,7 @@ int main(int argc, char *argv[])
 		= ((struct e820entry) { 0, mem, E820_RAM });
 	/* The boot header contains a command line pointer: we put the command
 	 * line after the boot header (at address 4096) */
-	*(void **)(boot + 0x228) = boot + 4096;
+	*(u32 *)(boot + 0x228) = 4096;
 	concat(boot + 4096, argv+optind+2);
 
 	/* The guest type value of "1" tells the Guest it's under lguest. */
===================================================================
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -325,8 +325,8 @@ static int emulate_insn(struct lguest *l
  * Dealing With Guest Memory.
  *
  * When the Guest gives us (what it thinks is) a physical address, we can use
- * the normal copy_from_user() & copy_to_user() on that address: remember,
- * Guest physical == Launcher virtual.
+ * the normal copy_from_user() & copy_to_user() on the corresponding place in
+ * the memory region allocated by the Launcher.
  *
  * But we can't trust the Guest: it might be trying to access the Launcher
  * code.  We have to check that the range is below the pfn_limit the Launcher
@@ -348,8 +348,8 @@ u32 lgread_u32(struct lguest *lg, unsign
 
 	/* Don't let them access lguest binary. */
 	if (!lguest_address_ok(lg, addr, sizeof(val))
-	    || get_user(val, (u32 __user *)addr) != 0)
-		kill_guest(lg, "bad read address %#lx", addr);
+	    || get_user(val, (u32 *)(lg->mem_base + addr)) != 0)
+		kill_guest(lg, "bad read address %#lx: pfn_limit=%u membase=%p", addr, lg->pfn_limit, lg->mem_base);
 	return val;
 }
 
@@ -357,7 +357,7 @@ void lgwrite_u32(struct lguest *lg, unsi
 void lgwrite_u32(struct lguest *lg, unsigned long addr, u32 val)
 {
 	if (!lguest_address_ok(lg, addr, sizeof(val))
-	    || put_user(val, (u32 __user *)addr) != 0)
+	    || put_user(val, (u32 *)(lg->mem_base + addr)) != 0)
 		kill_guest(lg, "bad write address %#lx", addr);
 }
 
@@ -367,7 +367,7 @@ void lgread(struct lguest *lg, void *b, 
 void lgread(struct lguest *lg, void *b, unsigned long addr, unsigned bytes)
 {
 	if (!lguest_address_ok(lg, addr, bytes)
-	    || copy_from_user(b, (void __user *)addr, bytes) != 0) {
+	    || copy_from_user(b, lg->mem_base + addr, bytes) != 0) {
 		/* copy_from_user should do this, but as we rely on it... */
 		memset(b, 0, bytes);
 		kill_guest(lg, "bad read address %#lx len %u", addr, bytes);
@@ -379,7 +379,7 @@ void lgwrite(struct lguest *lg, unsigned
 	     unsigned bytes)
 {
 	if (!lguest_address_ok(lg, addr, bytes)
-	    || copy_to_user((void __user *)addr, b, bytes) != 0)
+	    || copy_to_user(lg->mem_base + addr, b, bytes) != 0)
 		kill_guest(lg, "bad write address %#lx len %u", addr, bytes);
 }
 /* (end of memory access helper routines) :*/
@@ -616,11 +616,9 @@ int run_guest(struct lguest *lg, unsigne
 			 *
 			 * Note that if the Guest were really messed up, this
 			 * could happen before it's done the INITIALIZE
-			 * hypercall, so lg->lguest_data will be NULL, so
-			 * &lg->lguest_data->cr2 will be address 8.  Writing
-			 * into that address won't hurt the Host at all,
-			 * though. */
-			if (put_user(cr2, &lg->lguest_data->cr2))
+			 * hypercall, so lg->lguest_data will be NULL */
+			if (lg->lguest_data
+			    && put_user(cr2, &lg->lguest_data->cr2))
 				kill_guest(lg, "Writing cr2");
 			break;
 		case 7: /* We've intercepted a Device Not Available fault. */
===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -205,16 +205,19 @@ static void initialize(struct lguest *lg
 		tsc_speed = 0;
 
 	/* The pointer to the Guest's "struct lguest_data" is the only
-	 * argument. */
-	lg->lguest_data = (struct lguest_data __user *)lg->regs->edx;
-	/* If we check the address they gave is OK now, we can simply
-	 * copy_to_user/from_user from now on rather than using lgread/lgwrite.
-	 * I put this in to show that I'm not immune to writing stupid
-	 * optimizations. */
+	 * argument.  We check that address now. */
 	if (!lguest_address_ok(lg, lg->regs->edx, sizeof(*lg->lguest_data))) {
 		kill_guest(lg, "bad guest page %p", lg->lguest_data);
 		return;
 	}
+
+	/* Having checked it, we simply set lg->lguest_data to point straight
+	 * into the Launcher's memory at the right place and then use
+	 * copy_to_user/from_user from now on, instead of lgread/write.  I put
+	 * this in to show that I'm not immune to writing stupid
+	 * optimizations. */
+	lg->lguest_data = lg->mem_base + lg->regs->edx;
+
 	/* The Guest tells us where we're not to deliver interrupts by putting
 	 * the range of addresses into "struct lguest_data". */
 	if (get_user(lg->noirq_start, &lg->lguest_data->noirq_start)
===================================================================
--- a/drivers/lguest/io.c
+++ b/drivers/lguest/io.c
@@ -186,7 +186,7 @@ int bind_dma(struct lguest *lg,
 	 * we're doing this. */
 	mutex_lock(&lguest_lock);
 	down_read(fshared);
-	if (get_futex_key((u32 __user *)ukey, fshared, &key) != 0) {
+	if (get_futex_key(lg->mem_base + ukey, fshared, &key) != 0) {
 		kill_guest(lg, "bad dma key %#lx", ukey);
 		goto unlock;
 	}
@@ -247,7 +247,8 @@ static int lgread_other(struct lguest *l
 			void *buf, u32 addr, unsigned bytes)
 {
 	if (!lguest_address_ok(lg, addr, bytes)
-	    || access_process_vm(lg->tsk, addr, buf, bytes, 0) != bytes) {
+	    || access_process_vm(lg->tsk, (unsigned long)lg->mem_base + addr,
+				 buf, bytes, 0) != bytes) {
 		memset(buf, 0, bytes);
 		kill_guest(lg, "bad address in registered DMA struct");
 		return 0;
@@ -261,8 +262,8 @@ static int lgwrite_other(struct lguest *
 			 const void *buf, unsigned bytes)
 {
 	if (!lguest_address_ok(lg, addr, bytes)
-	    || (access_process_vm(lg->tsk, addr, (void *)buf, bytes, 1)
-		!= bytes)) {
+	    || access_process_vm(lg->tsk, (unsigned long)lg->mem_base + addr,
+				 (void *)buf, bytes, 1) != bytes) {
 		kill_guest(lg, "bad address writing to registered DMA");
 		return 0;
 	}
@@ -318,7 +319,7 @@ static u32 copy_data(struct lguest *srcl
 		 * copy_to_user_page(), and some arch's seem to need special
 		 * flushes.  x86 is fine. */
 		if (copy_from_user(maddr + (dst->addr[di] + dstoff)%PAGE_SIZE,
-				   (void __user *)src->addr[si], len) != 0) {
+				   srclg->mem_base+src->addr[si], len) != 0) {
 			/* If a copy failed, it's the source's fault. */
 			kill_guest(srclg, "bad address in sending DMA");
 			totlen = 0;
@@ -377,7 +378,8 @@ static u32 do_dma(struct lguest *srclg, 
 		 * number of pages.  Note that we're holding the destination's
 		 * mmap_sem, as get_user_pages() requires. */
 		if (get_user_pages(dstlg->tsk, dstlg->mm,
-				   dst->addr[i], 1, 1, 1, pages+i, NULL)
+				   (unsigned long)dstlg->mem_base+dst->addr[i],
+				   1, 1, 1, pages+i, NULL)
 		    != 1) {
 			/* This means the destination gave us a bogus buffer */
 			kill_guest(dstlg, "Error mapping DMA pages");
@@ -493,7 +495,7 @@ again:
 	mutex_lock(&lguest_lock);
 	down_read(fshared);
 	/* Get the futex key for the key the Guest gave us */
-	if (get_futex_key((u32 __user *)ukey, fshared, &key) != 0) {
+	if (get_futex_key(lg->mem_base + ukey, fshared, &key) != 0) {
 		kill_guest(lg, "bad sending DMA key");
 		goto unlock;
 	}
@@ -584,7 +586,7 @@ unsigned long get_dma_buffer(struct lgue
 
 	/* This can fail if it's not a valid address, or if the address is not
 	 * divisible by 4 (the futex code needs that, we don't really). */
-	if (get_futex_key((u32 __user *)ukey, fshared, &key) != 0) {
+	if (get_futex_key(lg->mem_base + ukey, fshared, &key) != 0) {
 		kill_guest(lg, "bad registered DMA buffer");
 		goto unlock;
 	}
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -143,6 +143,9 @@ struct lguest
 	struct mm_struct *mm; 	/* == tsk->mm, but that becomes NULL on exit */
 	u16 guestid;
 	u32 pfn_limit;
+	/* This provides the offset to the base of guest-physical
+	 * memory in the Launcher. */
+	void __user *mem_base;
 	u32 page_offset;
 	u32 cr2;
 	int halted;
===================================================================
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -1,9 +1,9 @@
 /*P:200 This contains all the /dev/lguest code, whereby the userspace launcher
  * controls and communicates with the Guest.  For example, the first write will
- * tell us the memory size, pagetable, entry point and kernel address offset.
- * A read will run the Guest until a signal is pending (-EINTR), or the Guest
- * does a DMA out to the Launcher.  Writes are also used to get a DMA buffer
- * registered by the Guest and to send the Guest an interrupt. :*/
+ * tell us the Guest's memory layout, pagetable, entry point and kernel address
+ * offset.  A read will run the Guest until something happens, such as a signal
+ * or the Guest doing a DMA out to the Launcher.  Writes are also used to get a
+ * DMA buffer registered by the Guest and to send the Guest an interrupt. :*/
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
 #include <linux/fs.h>
@@ -142,8 +142,10 @@ static ssize_t read(struct file *file, c
 	return run_guest(lg, (unsigned long __user *)user);
 }
 
-/*L:020 The initialization write supplies 4 32-bit values (in addition to the
+/*L:020 The initialization write supplies 5 32-bit values (in addition to the
  * 32-bit LHREQ_INITIALIZE value).  These are:
+ *
+ * base: The start of the Guest-physical memory inside the Launcher memory.
  *
  * pfnlimit: The highest (Guest-physical) page number the Guest should be
  * allowed to access.  The Launcher has to live in Guest memory, so it sets
@@ -166,7 +168,7 @@ static int initialize(struct file *file,
 	 * Guest. */
 	struct lguest *lg;
 	int err, i;
-	u32 args[4];
+	u32 args[5];
 
 	/* We grab the Big Lguest lock, which protects the global array
 	 * "lguests" and multiple simultaneous initializations. */
@@ -194,8 +196,9 @@ static int initialize(struct file *file,
 
 	/* Populate the easy fields of our "struct lguest" */
 	lg->guestid = i;
-	lg->pfn_limit = args[0];
-	lg->page_offset = args[3];
+	lg->mem_base = (void __user *)(long)args[0];
+	lg->pfn_limit = args[1];
+	lg->page_offset = args[4];
 
 	/* We need a complete page for the Guest registers: they are accessible
 	 * to the Guest and we can only grant it access to whole pages. */
@@ -210,13 +213,13 @@ static int initialize(struct file *file,
 	/* Initialize the Guest's shadow page tables, using the toplevel
 	 * address the Launcher gave us.  This allocates memory, so can
 	 * fail. */
-	err = init_guest_pagetable(lg, args[1]);
+	err = init_guest_pagetable(lg, args[2]);
 	if (err)
 		goto free_regs;
 
 	/* Now we initialize the Guest's registers, handing it the start
 	 * address. */
-	setup_regs(lg->regs, args[2]);
+	setup_regs(lg->regs, args[3]);
 
 	/* There are a couple of GDT entries the Guest expects when first
 	 * booting. */
===================================================================
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -152,7 +152,7 @@ static spte_t gpte_to_spte(struct lguest
 static spte_t gpte_to_spte(struct lguest *lg, gpte_t gpte, int write)
 {
 	spte_t spte;
-	unsigned long pfn;
+	unsigned long pfn, base;
 
 	/* The Guest sets the global flag, because it thinks that it is using
 	 * PGE.  We only told it to use PGE so it would tell us whether it was
@@ -160,11 +160,14 @@ static spte_t gpte_to_spte(struct lguest
 	 * use the global bit, so throw it away. */
 	spte.flags = (gpte.flags & ~_PAGE_GLOBAL);
 
+	/* The Guest's pages are offset inside the Launcher. */
+	base = (unsigned long)lg->mem_base / PAGE_SIZE;
+
 	/* We need a temporary "unsigned long" variable to hold the answer from
 	 * get_pfn(), because it returns 0xFFFFFFFF on failure, which wouldn't
 	 * fit in spte.pfn.  get_pfn() finds the real physical number of the
 	 * page, given the virtual number. */
-	pfn = get_pfn(gpte.pfn, write);
+	pfn = get_pfn(base + gpte.pfn, write);
 	if (pfn == -1UL) {
 		kill_guest(lg, "failed to get page %u", gpte.pfn);
 		/* When we destroy the Guest, we'll go through the shadow page

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
