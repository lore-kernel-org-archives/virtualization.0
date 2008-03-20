From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 2/5] lguest: Encapsulate Guest memory ready for dealing
	with other Guests.
Date: Thu, 20 Mar 2008 17:22:53 +1100
Message-ID: <200803201722.53636.rusty__2011.49847493998$1205994344$gmane$org@rustcorp.com.au>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201705.44422.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201705.44422.rusty@rustcorp.com.au>
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

We currently keep Guest memory pointer and size in globals.  We move
this into a structure and explicitly hand that to to_guest_phys() and
from_guest_phys() so we can deal with other Guests' memory.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |   89 +++++++++++++++++++++++-------------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff -r 95558c7d210e Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Thu Mar 13 14:11:40 2008 +1100
+++ b/Documentation/lguest/lguest.c	Thu Mar 13 23:05:35 2008 +1100
@@ -76,10 +76,20 @@ static bool verbose;
 
 /* The pipe to send commands to the waker process */
 static int waker_fd;
-/* The pointer to the start of guest memory. */
-static void *guest_base;
-/* The maximum guest physical address allowed, and maximum possible. */
-static unsigned long guest_limit, guest_max;
+
+struct guest_memory
+{
+	/* The pointer to the start of guest memory. */
+	void *base;
+	/* The maximum guest physical address allowed. */
+	unsigned long limit;
+};
+
+/* The maximum possible page for the guest. */
+static unsigned long guest_max;
+
+/* This Guest's memory. */
+static struct guest_memory gmem;
 
 /* a per-cpu variable indicating whose vcpu is currently running */
 static unsigned int __thread cpu_id;
@@ -207,20 +217,19 @@ static u8 *get_feature_bits(struct devic
  * will get you through this section.  Or, maybe not.
  *
  * The Launcher sets up a big chunk of memory to be the Guest's "physical"
- * memory and stores it in "guest_base".  In other words, Guest physical ==
- * Launcher virtual with an offset.
+ * memory.  In other words, Guest physical == Launcher virtual with an offset.
  *
  * This can be tough to get your head around, but usually it just means that we
  * use these trivial conversion functions when the Guest gives us it's
  * "physical" addresses: */
-static void *from_guest_phys(unsigned long addr)
+static void *from_guest_phys(struct guest_memory *mem, unsigned long addr)
 {
-	return guest_base + addr;
+	return mem->base + addr;
 }
 
-static unsigned long to_guest_phys(const void *addr)
+static unsigned long to_guest_phys(struct guest_memory *mem, const void *addr)
 {
-	return (addr - guest_base);
+	return (addr - mem->base);
 }
 
 /*L:130
@@ -287,10 +296,10 @@ static void *map_zeroed_pages(unsigned i
 /* Get some more pages for a device. */
 static void *get_pages(unsigned int num)
 {
-	void *addr = from_guest_phys(guest_limit);
+	void *addr = from_guest_phys(&gmem, gmem.limit);
 
-	guest_limit += num * getpagesize();
-	if (guest_limit > guest_max)
+	gmem.limit += num * getpagesize();
+	if (gmem.limit > guest_max)
 		errx(1, "Not enough memory for devices");
 	return addr;
 }
@@ -351,7 +360,7 @@ static unsigned long map_elf(int elf_fd,
 			i, phdr[i].p_memsz, (void *)phdr[i].p_paddr);
 
 		/* We map this section of the file at its physical address. */
-		map_at(elf_fd, from_guest_phys(phdr[i].p_paddr),
+		map_at(elf_fd, from_guest_phys(&gmem, phdr[i].p_paddr),
 		       phdr[i].p_offset, phdr[i].p_filesz);
 	}
 
@@ -371,7 +380,7 @@ static unsigned long load_bzimage(int fd
 	struct boot_params boot;
 	int r;
 	/* Modern bzImages get loaded at 1M. */
-	void *p = from_guest_phys(0x100000);
+	void *p = from_guest_phys(&gmem, 0x100000);
 
 	/* Go back to the start of the file and read the header.  It should be
 	 * a Linux boot header (see Documentation/i386/boot.txt) */
@@ -444,7 +453,7 @@ static unsigned long load_initrd(const c
 	/* We map the initrd at the top of memory, but mmap wants it to be
 	 * page-aligned, so we round the size up for that. */
 	len = page_align(st.st_size);
-	map_at(ifd, from_guest_phys(mem - len), 0, st.st_size);
+	map_at(ifd, from_guest_phys(&gmem, mem - len), 0, st.st_size);
 	/* Once a file is mapped, you can close the file descriptor.  It's a
 	 * little odd, but quite useful. */
 	close(ifd);
@@ -473,7 +482,7 @@ static unsigned long setup_pagetables(un
 	linear_pages = (mapped_pages + ptes_per_page-1)/ptes_per_page;
 
 	/* We put the toplevel page directory page at the top of memory. */
-	pgdir = from_guest_phys(mem) - initrd_size - getpagesize();
+	pgdir = from_guest_phys(&gmem, mem) - initrd_size - getpagesize();
 
 	/* Now we use the next linear_pages pages as pte pages */
 	linear = (void *)pgdir - linear_pages*getpagesize();
@@ -487,16 +496,16 @@ static unsigned long setup_pagetables(un
 	/* The top level points to the linear page table pages above. */
 	for (i = 0; i < mapped_pages; i += ptes_per_page) {
 		pgdir[i/ptes_per_page]
-			= ((to_guest_phys(linear) + i*sizeof(void *))
+			= ((to_guest_phys(&gmem, linear) + i*sizeof(void *))
 			   | PAGE_PRESENT);
 	}
 
 	verbose("Linear mapping of %u pages in %u pte pages at %#lx\n",
-		mapped_pages, linear_pages, to_guest_phys(linear));
+		mapped_pages, linear_pages, to_guest_phys(&gmem, linear));
 
 	/* We return the top level (guest-physical) address: the kernel needs
 	 * to know where it is. */
-	return to_guest_phys(pgdir);
+	return to_guest_phys(&gmem, pgdir);
 }
 /*:*/
 
@@ -525,12 +534,12 @@ static int tell_kernel(unsigned long pgd
 static int tell_kernel(unsigned long pgdir, unsigned long start)
 {
 	unsigned long args[] = { LHREQ_INITIALIZE,
-				 (unsigned long)guest_base,
-				 guest_limit / getpagesize(), pgdir, start };
+				 (unsigned long)gmem.base,
+				 gmem.limit / getpagesize(), pgdir, start };
 	int fd;
 
 	verbose("Guest: %p - %p (%#lx)\n",
-		guest_base, guest_base + guest_limit, guest_limit);
+		gmem.base, gmem.base + gmem.limit, gmem.limit);
 	fd = open_or_die("/dev/lguest", O_RDWR);
 	if (write(fd, args, sizeof(args)) < 0)
 		err(1, "Writing to /dev/lguest");
@@ -629,18 +638,18 @@ static int setup_waker(int lguest_fd)
  * if something funny is going on:
  */
 static void *_check_pointer(unsigned long addr, unsigned int size,
-			    unsigned int line)
+			    struct guest_memory *mem, unsigned int line)
 {
 	/* We have to separately check addr and addr+size, because size could
 	 * be huge and addr + size might wrap around. */
-	if (addr >= guest_limit || addr + size >= guest_limit)
+	if (addr >= mem->limit || addr + size >= mem->limit)
 		errx(1, "%s:%i: Invalid address %#lx", __FILE__, line, addr);
 	/* We return a pointer for the caller's convenience, now we know it's
 	 * safe to use. */
-	return from_guest_phys(addr);
+	return from_guest_phys(&gmem, addr);
 }
 /* A macro which transparently hands the line number to the real function. */
-#define check_pointer(addr,size) _check_pointer(addr, size, __LINE__)
+#define check_pointer(mem,addr,size) _check_pointer(addr, size, mem, __LINE__)
 
 /* Each buffer in the virtqueues is actually a chain of descriptors.  This
  * function returns the next descriptor in the chain, or vq->vring.num if we're
@@ -702,7 +711,7 @@ static unsigned get_vq_desc(struct virtq
 		/* Grab the first descriptor, and check it's OK. */
 		iov[*out_num + *in_num].iov_len = vq->vring.desc[i].len;
 		iov[*out_num + *in_num].iov_base
-			= check_pointer(vq->vring.desc[i].addr,
+			= check_pointer(&gmem, vq->vring.desc[i].addr,
 					vq->vring.desc[i].len);
 		/* If this is an input descriptor, increment that count. */
 		if (vq->vring.desc[i].flags & VRING_DESC_F_WRITE)
@@ -975,7 +984,7 @@ static void handle_output(int fd, unsign
 	/* Check each device and virtqueue. */
 	for (i = devices.dev; i; i = i->next) {
 		/* Notifications to device descriptors reset the device. */
-		if (from_guest_phys(addr) == i->desc) {
+		if (from_guest_phys(&gmem, addr) == i->desc) {
 			reset_device(i);
 			return;
 		}
@@ -1002,11 +1011,11 @@ static void handle_output(int fd, unsign
 
 	/* Early console write is done using notify on a nul-terminated string
 	 * in Guest memory. */
-	if (addr >= guest_limit)
+	if (addr >= gmem.limit)
 		errx(1, "Bad NOTIFY %#lx", addr);
 
-	write(STDOUT_FILENO, from_guest_phys(addr),
-	      strnlen(from_guest_phys(addr), guest_limit - addr));
+	write(STDOUT_FILENO, from_guest_phys(&gmem, addr),
+	      strnlen(from_guest_phys(&gmem, addr), gmem.limit - addr));
 }
 
 /* This is called when the Waker wakes us up: check for incoming file
@@ -1112,7 +1121,7 @@ static void add_virtqueue(struct device 
 	/* Initialize the configuration. */
 	vq->config.num = num_descs;
 	vq->config.irq = devices.next_irq++;
-	vq->config.pfn = to_guest_phys(p) / getpagesize();
+	vq->config.pfn = to_guest_phys(&gmem, p) / getpagesize();
 
 	/* Initialize the vring. */
 	vring_init(&vq->vring, num_descs, p, getpagesize());
@@ -1125,7 +1134,7 @@ static void add_virtqueue(struct device 
 	memcpy(device_config(dev), &vq->config, sizeof(vq->config));
 	dev->desc->num_vq++;
 
-	verbose("Virtqueue page %#lx\n", to_guest_phys(p));
+	verbose("Virtqueue page %#lx\n", to_guest_phys(&gmem, p));
 
 	/* Add to tail of list, so dev->vq is first vq, dev->vq->next is
 	 * second.  */
@@ -1731,9 +1740,9 @@ int main(int argc, char *argv[])
 			 * guest-physical memory range.  This fills it with 0,
 			 * and ensures that the Guest won't be killed when it
 			 * tries to access it. */
-			guest_base = map_zeroed_pages(mem / getpagesize()
-						      + DEVICE_PAGES);
-			guest_limit = mem;
+			gmem.base = map_zeroed_pages(mem / getpagesize()
+						     + DEVICE_PAGES);
+			gmem.limit = mem;
 			guest_max = mem + DEVICE_PAGES*getpagesize();
 			devices.descpage = get_pages(1);
 			break;
@@ -1765,7 +1774,7 @@ int main(int argc, char *argv[])
 	if (optind + 2 > argc)
 		usage();
 
-	verbose("Guest base is at %p\n", guest_base);
+	verbose("Guest base is at %p\n", gmem.base);
 
 	/* We always have a console device */
 	setup_console();
@@ -1774,7 +1783,7 @@ int main(int argc, char *argv[])
 	start = load_kernel(open_or_die(argv[optind+1], O_RDONLY));
 
 	/* Boot information is stashed at physical address 0 */
-	boot = from_guest_phys(0);
+	boot = from_guest_phys(&gmem, 0);
 
 	/* Map the initrd image if requested (at top of physical memory) */
 	if (initrd_name) {
@@ -1796,7 +1805,7 @@ int main(int argc, char *argv[])
 	boot->e820_map[0] = ((struct e820entry) { 0, mem, E820_RAM });
 	/* The boot header contains a command line pointer: we put the command
 	 * line after the boot header. */
-	boot->hdr.cmd_line_ptr = to_guest_phys(boot + 1);
+	boot->hdr.cmd_line_ptr = to_guest_phys(&gmem, boot + 1);
 	/* We use a simple helper to copy the arguments separated by spaces. */
 	concat((char *)(boot + 1), argv+optind+2);
