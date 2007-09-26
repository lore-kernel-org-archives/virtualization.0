From: rusty@rustcorp.com.au
Subject: [patch 31/43] lguest: Boot with virtual == physical to get closer
	to native Linux.
Date: Wed, 26 Sep 2007 16:36:49 +1000
Message-ID: <20070926063650.704084137@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=remove-known-pageoffset.patch
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

1) This allows us to get alot closer to booting bzImages.

2) It means we don't have to know page_offset.

3) The Guest needs to modify the boot pagetables to create the
   PAGE_OFFSET mapping before jumping to C code.

4) guest_pa() walks the page tables rather than using page_offset.

5) We don't use page_offset to figure out whether to emulate: it was
   always kinda quesationable, and won't work for instructions done
   before remapping (bzImage unpacking in particular).

6) We still want the kernel address for tlb flushing: have the initial
   hypercall give us that, too.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

---
 Documentation/lguest/lguest.c         |  134 +++++++--------------------------
 arch/i386/kernel/asm-offsets.c        |    1 
 arch/i386/lguest/boot.c               |    7 -
 arch/i386/lguest/head.S               |   41 ++++++++--
 drivers/lguest/hypercalls.c           |    8 -
 drivers/lguest/i386_core.c            |    7 -
 drivers/lguest/interrupts_and_traps.c |   13 ++-
 drivers/lguest/lg.h                   |    8 -
 drivers/lguest/lguest_user.c          |   11 --
 drivers/lguest/page_tables.c          |   47 +++++++++--
 include/asm-i386/lguest_hcall.h       |    3 
 include/linux/lguest.h                |    5 -
 12 files changed, 139 insertions(+), 146 deletions(-)

===================================================================
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -178,19 +178,16 @@ static void *get_pages(unsigned int num)
 /* To find out where to start we look for the magic Guest string, which marks
  * the code we see in lguest_asm.S.  This is a hack which we are currently
  * plotting to replace with the normal Linux entry point. */
-static unsigned long entry_point(const void *start, const void *end,
-				 unsigned long page_offset)
+static unsigned long entry_point(const void *start, const void *end)
 {
 	const void *p;
 
-	/* The scan gives us the physical starting address.  We want the
-	 * virtual address in this case, and fortunately, we already figured
-	 * out the physical-virtual difference and passed it here in
-	 * "page_offset". */
+	/* The scan gives us the physical starting address.  We boot with
+	 * pagetables set up with virtual and physical the same, so that's
+	 * OK. */
 	for (p = start; p < end; p++)
 		if (memcmp(p, "GenuineLguest", strlen("GenuineLguest")) == 0)
-			return to_guest_phys(p + strlen("GenuineLguest"))
-				+ page_offset;
+			return to_guest_phys(p + strlen("GenuineLguest"));
 
 	errx(1, "Is this image a genuine lguest?");
 }
@@ -224,14 +221,11 @@ static void map_at(int fd, void *addr, u
  * by all modern binaries on Linux including the kernel.
  *
  * The ELF headers give *two* addresses: a physical address, and a virtual
- * address.  The Guest kernel expects to be placed in memory at the physical
- * address, and the page tables set up so it will correspond to that virtual
- * address.  We return the difference between the virtual and physical
- * addresses in the "page_offset" pointer.
+ * address.  We use the physical address; the Guest will map itself to the
+ * virtual address.
  *
  * We return the starting address. */
-static unsigned long map_elf(int elf_fd, const Elf32_Ehdr *ehdr,
-			     unsigned long *page_offset)
+static unsigned long map_elf(int elf_fd, const Elf32_Ehdr *ehdr)
 {
 	void *start = (void *)-1, *end = NULL;
 	Elf32_Phdr phdr[ehdr->e_phnum];
@@ -255,9 +249,6 @@ static unsigned long map_elf(int elf_fd,
 	if (read(elf_fd, phdr, sizeof(phdr)) != sizeof(phdr))
 		err(1, "Reading program headers");
 
-	/* We don't know page_offset yet. */
-	*page_offset = 0;
-
 	/* Try all the headers: there are usually only three.  A read-only one,
 	 * a read-write one, and a "note" section which isn't loadable. */
 	for (i = 0; i < ehdr->e_phnum; i++) {
@@ -268,14 +259,6 @@ static unsigned long map_elf(int elf_fd,
 		verbose("Section %i: size %i addr %p\n",
 			i, phdr[i].p_memsz, (void *)phdr[i].p_paddr);
 
-		/* We expect a simple linear address space: every segment must
-		 * have the same difference between virtual (p_vaddr) and
-		 * physical (p_paddr) address. */
-		if (!*page_offset)
-			*page_offset = phdr[i].p_vaddr - phdr[i].p_paddr;
-		else if (*page_offset != phdr[i].p_vaddr - phdr[i].p_paddr)
-			errx(1, "Page offset of section %i different", i);
-
 		/* We track the first and last address we mapped, so we can
 		 * tell entry_point() where to scan. */
 		if (from_guest_phys(phdr[i].p_paddr) < start)
@@ -288,50 +271,13 @@ static unsigned long map_elf(int elf_fd,
 		       phdr[i].p_offset, phdr[i].p_filesz);
 	}
 
-	return entry_point(start, end, *page_offset);
-}
-
-/*L:170 Prepare to be SHOCKED and AMAZED.  And possibly a trifle nauseated.
- *
- * We know that CONFIG_PAGE_OFFSET sets what virtual address the kernel expects
- * to be.  We don't know what that option was, but we can figure it out
- * approximately by looking at the addresses in the code.  I chose the common
- * case of reading a memory location into the %eax register:
- *
- *  movl <some-address>, %eax
- *
- * This gets encoded as five bytes: "0xA1 <4-byte-address>".  For example,
- * "0xA1 0x18 0x60 0x47 0xC0" reads the address 0xC0476018 into %eax.
- *
- * In this example can guess that the kernel was compiled with
- * CONFIG_PAGE_OFFSET set to 0xC0000000 (it's always a round number).  If the
- * kernel were larger than 16MB, we might see 0xC1 addresses show up, but our
- * kernel isn't that bloated yet.
- *
- * Unfortunately, x86 has variable-length instructions, so finding this
- * particular instruction properly involves writing a disassembler.  Instead,
- * we rely on statistics.  We look for "0xA1" and tally the different bytes
- * which occur 4 bytes later (the "0xC0" in our example above).  When one of
- * those bytes appears three times, we can be reasonably confident that it
- * forms the start of CONFIG_PAGE_OFFSET.
- *
- * This is amazingly reliable. */
-static unsigned long intuit_page_offset(unsigned char *img, unsigned long len)
-{
-	unsigned int i, possibilities[256] = { 0 };
-
-	for (i = 0; i + 4 < len; i++) {
-		/* mov 0xXXXXXXXX,%eax */
-		if (img[i] == 0xA1 && ++possibilities[img[i+4]] > 3)
-			return (unsigned long)img[i+4] << 24;
-	}
-	errx(1, "could not determine page offset");
+	return entry_point(start, end);
 }
 
 /*L:160 Unfortunately the entire ELF image isn't compressed: the segments
  * which need loading are extracted and compressed raw.  This denies us the
  * information we need to make a fully-general loader. */
-static unsigned long unpack_bzimage(int fd, unsigned long *page_offset)
+static unsigned long unpack_bzimage(int fd)
 {
 	gzFile f;
 	int ret, len = 0;
@@ -352,12 +298,7 @@ static unsigned long unpack_bzimage(int 
 
 	verbose("Unpacked size %i addr %p\n", len, img);
 
-	/* Without the ELF header, we can't tell virtual-physical gap.  This is
-	 * CONFIG_PAGE_OFFSET, and people do actually change it.  Fortunately,
-	 * I have a clever way of figuring it out from the code itself.  */
-	*page_offset = intuit_page_offset(img, len);
-
-	return entry_point(img, img + len, *page_offset);
+	return entry_point(img, img + len);
 }
 
 /*L:150 A bzImage, unlike an ELF file, is not meant to be loaded.  You're
@@ -368,7 +309,7 @@ static unsigned long unpack_bzimage(int 
  * The bzImage is formed by putting the decompressing code in front of the
  * compressed kernel code.  So we can simple scan through it looking for the
  * first "gzip" header, and start decompressing from there. */
-static unsigned long load_bzimage(int fd, unsigned long *page_offset)
+static unsigned long load_bzimage(int fd)
 {
 	unsigned char c;
 	int state = 0;
@@ -396,7 +337,7 @@ static unsigned long load_bzimage(int fd
 			if (c != 0x03)
 				state = -1;
 			else
-				return unpack_bzimage(fd, page_offset);
+				return unpack_bzimage(fd);
 		}
 	}
 	errx(1, "Could not find kernel in bzImage");
@@ -405,7 +346,7 @@ static unsigned long load_bzimage(int fd
 /*L:140 Loading the kernel is easy when it's a "vmlinux", but most kernels
  * come wrapped up in the self-decompressing "bzImage" format.  With some funky
  * coding, we can load those, too. */
-static unsigned long load_kernel(int fd, unsigned long *page_offset)
+static unsigned long load_kernel(int fd)
 {
 	Elf32_Ehdr hdr;
 
@@ -415,10 +356,10 @@ static unsigned long load_kernel(int fd,
 
 	/* If it's an ELF file, it starts with "\177ELF" */
 	if (memcmp(hdr.e_ident, ELFMAG, SELFMAG) == 0)
-		return map_elf(fd, &hdr, page_offset);
+		return map_elf(fd, &hdr);
 
 	/* Otherwise we assume it's a bzImage, and try to unpack it */
-	return load_bzimage(fd, page_offset);
+	return load_bzimage(fd);
 }
 
 /* This is a trivial little helper to align pages.  Andi Kleen hated it because
@@ -463,27 +404,20 @@ static unsigned long load_initrd(const c
 	return len;
 }
 
-/* Once we know the address the Guest kernel expects, we can construct simple
- * linear page tables for all of memory which will get the Guest far enough
+/* Once we know how much memory we have, we can construct simple linear page
+ * tables which set virtual == physical which will get the Guest far enough
  * into the boot to create its own.
  *
  * We lay them out of the way, just below the initrd (which is why we need to
  * know its size). */
 static unsigned long setup_pagetables(unsigned long mem,
-				      unsigned long initrd_size,
-				      unsigned long page_offset)
+				      unsigned long initrd_size)
 {
 	unsigned long *pgdir, *linear;
 	unsigned int mapped_pages, i, linear_pages;
 	unsigned int ptes_per_page = getpagesize()/sizeof(void *);
 
-	/* Ideally we map all physical memory starting at page_offset.
-	 * However, if page_offset is 0xC0000000 we can only map 1G of physical
-	 * (0xC0000000 + 1G overflows). */
-	if (mem <= -page_offset)
-		mapped_pages = mem/getpagesize();
-	else
-		mapped_pages = -page_offset/getpagesize();
+	mapped_pages = mem/getpagesize();
 
 	/* Each PTE page can map ptes_per_page pages: how many do we need? */
 	linear_pages = (mapped_pages + ptes_per_page-1)/ptes_per_page;
@@ -500,11 +434,9 @@ static unsigned long setup_pagetables(un
 	for (i = 0; i < mapped_pages; i++)
 		linear[i] = ((i * getpagesize()) | PAGE_PRESENT);
 
-	/* The top level points to the linear page table pages above.  The
-	 * entry representing page_offset points to the first one, and they
-	 * continue from there. */
+	/* The top level points to the linear page table pages above. */
 	for (i = 0; i < mapped_pages; i += ptes_per_page) {
-		pgdir[(i + page_offset/getpagesize())/ptes_per_page]
+		pgdir[i/ptes_per_page]
 			= ((to_guest_phys(linear) + i*sizeof(void *))
 			   | PAGE_PRESENT);
 	}
@@ -535,15 +467,12 @@ static void concat(char *dst, char *args
 /* This is where we actually tell the kernel to initialize the Guest.  We saw
  * the arguments it expects when we looked at initialize() in lguest_user.c:
  * the base of guest "physical" memory, the top physical page to allow, the
- * top level pagetable, the entry point and the page_offset constant for the
- * Guest. */
-static int tell_kernel(unsigned long pgdir, unsigned long start,
-		       unsigned long page_offset)
+ * top level pagetable and the entry point for the Guest. */
+static int tell_kernel(unsigned long pgdir, unsigned long start)
 {
 	unsigned long args[] = { LHREQ_INITIALIZE,
 				 (unsigned long)guest_base,
-				 guest_limit / getpagesize(),
-				 pgdir, start, page_offset };
+				 guest_limit / getpagesize(), pgdir, start };
 	int fd;
 
 	verbose("Guest: %p - %p (%#lx)\n",
@@ -1424,9 +1353,9 @@ static void usage(void)
 /*L:105 The main routine is where the real work begins: */
 int main(int argc, char *argv[])
 {
-	/* Memory, top-level pagetable, code startpoint, PAGE_OFFSET and size
-	 * of the (optional) initrd. */
-	unsigned long mem = 0, pgdir, start, page_offset, initrd_size = 0;
+	/* Memory, top-level pagetable, code startpoint and size of the
+	 * (optional) initrd. */
+	unsigned long mem = 0, pgdir, start, initrd_size = 0;
 	/* A temporary and the /dev/lguest file descriptor. */
 	int i, c, lguest_fd;
 	/* The list of Guest devices, based on command line arguments. */
@@ -1500,8 +1429,7 @@ int main(int argc, char *argv[])
 	setup_console(&device_list);
 
 	/* Now we load the kernel */
-	start = load_kernel(open_or_die(argv[optind+1], O_RDONLY),
-			    &page_offset);
+	start = load_kernel(open_or_die(argv[optind+1], O_RDONLY));
 
 	/* Boot information is stashed at physical address 0 */
 	boot = from_guest_phys(0);
@@ -1518,7 +1446,7 @@ int main(int argc, char *argv[])
 	}
 
 	/* Set up the initial linear pagetables, starting below the initrd. */
-	pgdir = setup_pagetables(mem, initrd_size, page_offset);
+	pgdir = setup_pagetables(mem, initrd_size);
 
 	/* The Linux boot header contains an "E820" memory map: ours is a
 	 * simple, single region. */
@@ -1535,7 +1463,7 @@ int main(int argc, char *argv[])
 
 	/* We tell the kernel to initialize the Guest: this returns the open
 	 * /dev/lguest file descriptor. */
-	lguest_fd = tell_kernel(pgdir, start, page_offset);
+	lguest_fd = tell_kernel(pgdir, start);
 
 	/* We fork off a child process, which wakes the Launcher whenever one
 	 * of the input file descriptors needs attention.  Otherwise we would
===================================================================
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
@@ -133,6 +133,7 @@ void foo(void)
 #ifdef CONFIG_LGUEST_GUEST
 	BLANK();
 	OFFSET(LGUEST_DATA_irq_enabled, lguest_data, irq_enabled);
+	OFFSET(LGUEST_DATA_pgdir, lguest_data, pgdir);
 	OFFSET(LGUEST_PAGES_host_gdt_desc, lguest_pages, state.host_gdt_desc);
 	OFFSET(LGUEST_PAGES_host_idt_desc, lguest_pages, state.host_idt_desc);
 	OFFSET(LGUEST_PAGES_host_cr3, lguest_pages, state.host_cr3);
===================================================================
--- a/arch/i386/lguest/boot.c
+++ b/arch/i386/lguest/boot.c
@@ -86,6 +86,7 @@ struct lguest_data lguest_data = {
 	.hcall_status = { [0 ... LHCALL_RING_SIZE-1] = 0xFF },
 	.noirq_start = (u32)lguest_noirq_start,
 	.noirq_end = (u32)lguest_noirq_end,
+	.kernel_address = PAGE_OFFSET,
 	.blocked_interrupts = { 1 }, /* Block timer interrupts */
 	.syscall_vec = SYSCALL_VECTOR,
 };
@@ -988,11 +989,7 @@ __init void lguest_init(void *boot)
 
 	/*G:070 Now we've seen all the paravirt_ops, we return to
 	 * lguest_init() where the rest of the fairly chaotic boot setup
-	 * occurs.
-	 *
-	 * The Host expects our first hypercall to tell it where our "struct
-	 * lguest_data" is, so we do that first. */
-	hcall(LHCALL_LGUEST_INIT, __pa(&lguest_data), 0, 0);
+	 * occurs. */
 
 	/* The native boot code sets up initial page tables immediately after
 	 * the kernel itself, and sets init_pg_tables_end so they're not
===================================================================
--- a/arch/i386/lguest/head.S
+++ b/arch/i386/lguest/head.S
@@ -1,5 +1,6 @@
 #include <linux/linkage.h>
 #include <linux/lguest.h>
+#include <asm/lguest_hcall.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/processor-flags.h>
@@ -8,18 +9,48 @@
  * looks for.  The plan is that the Linux boot protocol will be extended with a
  * "platform type" field which will guide us here from the normal entry point,
  * but for the moment this suffices.  The normal boot code uses %esi for the
- * boot header, so we do too.  We convert it to a virtual address by adding
- * PAGE_OFFSET, and hand it to lguest_init() as its argument (ie. %eax).
+ * boot header, so we do too.
+ *
+ * WARNING: be very careful here!  We're running at addresses equal to physical
+ * addesses (around 0), not above PAGE_OFFSET as most code expectes
+ * (eg. 0xC0000000).  Jumps are relative, so they're OK, but we can't touch any
+ * data.
  *
  * The .section line puts this code in .init.text so it will be discarded after
  * boot. */
 .section .init.text, "ax", @progbits
 .ascii "GenuineLguest"
-	/* Set up initial stack. */
- 	movl $(init_thread_union+THREAD_SIZE),%esp
+	/* Make initial hypercall now, so we can set up the pagetables. */
+	movl $LHCALL_LGUEST_INIT, %eax
+	movl $lguest_data - __PAGE_OFFSET, %edx
+	int $LGUEST_TRAP_ENTRY
+
+	/* Set up boot information pointer to hand to lguest_init(): it wants
+	 * a virtual address. */
 	movl %esi, %eax
 	addl $__PAGE_OFFSET, %eax
-	jmp lguest_init
+
+	/* The Host put the toplevel pagetable in lguest_data.pgdir.  The movsl
+	 * instruction uses %esi, so we needed to save it above. */
+	movl lguest_data - __PAGE_OFFSET + LGUEST_DATA_pgdir, %esi
+
+	/* Copy first 32 entries of page directory to __PAGE_OFFSET entries.
+	 * This means the first 128M of kernel memory will be mapped at
+	 * PAGE_OFFSET where the kernel expects to run.  This will get it far
+	 * enough through boot to switch to its own pagetables. */
+	movl $32, %ecx
+	movl %esi, %edi
+	addl $((__PAGE_OFFSET >> 22) * 4), %edi
+	rep
+	movsl
+
+	/* Set up the initial stack so we can run C code. */
+ 	movl $(init_thread_union+THREAD_SIZE),%esp
+
+
+	/* Jumps are relative, and we're running __PAGE_OFFSET too low at the
+	 * moment. */
+	jmp lguest_init+__PAGE_OFFSET
 
 /*G:055 We create a macro which puts the assembler code between lgstart_ and
  * lgend_ markers.  These templates are put in the .text section: they can't be
===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -181,14 +181,14 @@ static void initialize(struct lguest *lg
 	/* The Guest tells us where we're not to deliver interrupts by putting
 	 * the range of addresses into "struct lguest_data". */
 	if (get_user(lg->noirq_start, &lg->lguest_data->noirq_start)
-	    || get_user(lg->noirq_end, &lg->lguest_data->noirq_end)
-	    /* We tell the Guest that it can't use the top 4MB of virtual
-	     * addresses used by the Switcher. */
-	    || put_user(4U*1024*1024, &lg->lguest_data->reserve_mem))
+	    || get_user(lg->noirq_end, &lg->lguest_data->noirq_end))
 		kill_guest(lg, "bad guest page %p", lg->lguest_data);
 
 	/* We write the current time into the Guest's data page once now. */
 	write_timestamp(lg);
+
+	/* page_tables.c will also do some setup. */
+	page_table_guest_data_init(lg);
 
 	/* This is the one case where the above accesses might have been the
 	 * first write to a Guest page.  This may have caused a copy-on-write
===================================================================
--- a/drivers/lguest/i386_core.c
+++ b/drivers/lguest/i386_core.c
@@ -216,9 +216,10 @@ static int emulate_insn(struct lguest *l
 	 * guest_pa just subtracts the Guest's page_offset. */
 	unsigned long physaddr = guest_pa(lg, lg->regs->eip);
 
-	/* The guest_pa() function only works for Guest kernel addresses, but
-	 * that's all we're trying to do anyway. */
-	if (lg->regs->eip < lg->page_offset)
+	/* This must be the Guest kernel trying to do something, not userspace!
+	 * The bottom two bits of the CS segment register are the privilege
+	 * level. */
+	if ((lg->regs->cs & 3) != GUEST_PL)
 		return 0;
 
 	/* Decoding x86 instructions is icky. */
===================================================================
--- a/drivers/lguest/interrupts_and_traps.c
+++ b/drivers/lguest/interrupts_and_traps.c
@@ -62,8 +62,9 @@ static void push_guest_stack(struct lgue
  * it). */
 static void set_guest_interrupt(struct lguest *lg, u32 lo, u32 hi, int has_err)
 {
-	unsigned long gstack;
+	unsigned long gstack, origstack;
 	u32 eflags, ss, irq_enable;
+	unsigned long virtstack;
 
 	/* There are two cases for interrupts: one where the Guest is already
 	 * in the kernel, and a more complex one where the Guest is in
@@ -71,8 +72,10 @@ static void set_guest_interrupt(struct l
 	if ((lg->regs->ss&0x3) != GUEST_PL) {
 		/* The Guest told us their kernel stack with the SET_STACK
 		 * hypercall: both the virtual address and the segment */
-		gstack = guest_pa(lg, lg->esp1);
+		virtstack = lg->esp1;
 		ss = lg->ss1;
+
+		origstack = gstack = guest_pa(lg, virtstack);
 		/* We push the old stack segment and pointer onto the new
 		 * stack: when the Guest does an "iret" back from the interrupt
 		 * handler the CPU will notice they're dropping privilege
@@ -81,8 +84,10 @@ static void set_guest_interrupt(struct l
 		push_guest_stack(lg, &gstack, lg->regs->esp);
 	} else {
 		/* We're staying on the same Guest (kernel) stack. */
-		gstack = guest_pa(lg, lg->regs->esp);
+		virtstack = lg->regs->esp;
 		ss = lg->regs->ss;
+
+		origstack = gstack = guest_pa(lg, virtstack);
 	}
 
 	/* Remember that we never let the Guest actually disable interrupts, so
@@ -108,7 +113,7 @@ static void set_guest_interrupt(struct l
 	/* Now we've pushed all the old state, we change the stack, the code
 	 * segment and the address to execute. */
 	lg->regs->ss = ss;
-	lg->regs->esp = gstack + lg->page_offset;
+	lg->regs->esp = virtstack + (gstack - origstack);
 	lg->regs->cs = (__KERNEL_CS|GUEST_PL);
 	lg->regs->eip = idt_address(lo, hi);
 
===================================================================
--- a/drivers/lguest/lg.h
+++ b/drivers/lguest/lg.h
@@ -64,7 +64,7 @@ struct lguest
 	/* This provides the offset to the base of guest-physical
 	 * memory in the Launcher. */
 	void __user *mem_base;
-	u32 page_offset;
+	unsigned long kernel_address;
 	u32 cr2;
 	int halted;
 	int ts;
@@ -166,6 +166,8 @@ void map_switcher_in_guest(struct lguest
 void map_switcher_in_guest(struct lguest *lg, struct lguest_pages *pages);
 int demand_page(struct lguest *info, unsigned long cr2, int errcode);
 void pin_page(struct lguest *lg, unsigned long vaddr);
+unsigned long guest_pa(struct lguest *lg, unsigned long vaddr);
+void page_table_guest_data_init(struct lguest *lg);
 
 /* <arch>_core.c: */
 void lguest_arch_host_init(void);
@@ -230,9 +232,5 @@ do {								\
 } while(0)
 /* (End of aside) :*/
 
-static inline unsigned long guest_pa(struct lguest *lg, unsigned long vaddr)
-{
-	return vaddr - lg->page_offset;
-}
 #endif	/* __ASSEMBLY__ */
 #endif	/* _LGUEST_H */
===================================================================
--- a/drivers/lguest/lguest_user.c
+++ b/drivers/lguest/lguest_user.c
@@ -111,7 +111,7 @@ static ssize_t read(struct file *file, c
 	return run_guest(lg, (unsigned long __user *)user);
 }
 
-/*L:020 The initialization write supplies 5 pointer sized (32 or 64 bit)
+/*L:020 The initialization write supplies 4 pointer sized (32 or 64 bit)
  * values (in addition to the LHREQ_INITIALIZE value).  These are:
  *
  * base: The start of the Guest-physical memory inside the Launcher memory.
@@ -124,12 +124,6 @@ static ssize_t read(struct file *file, c
  * pagetables (which are set up by the Launcher).
  *
  * start: The first instruction to execute ("eip" in x86-speak).
- *
- * page_offset: The PAGE_OFFSET constant in the Guest kernel.  We should
- * probably wean the code off this, but it's a very useful constant!  Any
- * address above this is within the Guest kernel, and any kernel address can
- * quickly converted from physical to virtual by adding PAGE_OFFSET.  It's
- * 0xC0000000 (3G) by default, but it's configurable at kernel build time.
  */
 static int initialize(struct file *file, const unsigned long __user *input)
 {
@@ -137,7 +131,7 @@ static int initialize(struct file *file,
 	 * Guest. */
 	struct lguest *lg;
 	int err;
-	unsigned long args[5];
+	unsigned long args[4];
 
 	/* We grab the Big Lguest lock, which protects against multiple
 	 * simultaneous initializations. */
@@ -162,7 +156,6 @@ static int initialize(struct file *file,
 	/* Populate the easy fields of our "struct lguest" */
 	lg->mem_base = (void __user *)(long)args[0];
 	lg->pfn_limit = args[1];
-	lg->page_offset = args[4];
 
 	/* We need a complete page for the Guest registers: they are accessible
 	 * to the Guest and we can only grant it access to whole pages. */
===================================================================
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -13,6 +13,7 @@
 #include <linux/random.h>
 #include <linux/percpu.h>
 #include <asm/tlbflush.h>
+#include <asm/uaccess.h>
 #include "lg.h"
 
 /*M:008 We hold reference to pages, which prevents them from being swapped.
@@ -348,7 +349,7 @@ static void flush_user_mappings(struct l
 {
 	unsigned int i;
 	/* Release every pgd entry up to the kernel's address. */
-	for (i = 0; i < pgd_index(lg->page_offset); i++)
+	for (i = 0; i < pgd_index(lg->kernel_address); i++)
 		release_pgd(lg, lg->pgdirs[idx].pgdir + i);
 }
 
@@ -360,6 +361,25 @@ void guest_pagetable_flush_user(struct l
 	flush_user_mappings(lg, lg->pgdidx);
 }
 /*:*/
+
+/* We walk down the guest page tables to get a guest-physical address */
+unsigned long guest_pa(struct lguest *lg, unsigned long vaddr)
+{
+	pgd_t gpgd;
+	pte_t gpte;
+
+	/* First step: get the top-level Guest page table entry. */
+	gpgd = __pgd(lgread_u32(lg, gpgd_addr(lg, vaddr)));
+	/* Toplevel not present?  We can't map it in. */
+	if (!(pgd_flags(gpgd) & _PAGE_PRESENT))
+		kill_guest(lg, "Bad address %#lx", vaddr);
+
+	gpte = __pte(lgread_u32(lg, gpte_addr(lg, gpgd, vaddr)));
+	if (!(pte_flags(gpte) & _PAGE_PRESENT))
+		kill_guest(lg, "Bad address %#lx", vaddr);
+
+	return pte_pfn(gpte) * PAGE_SIZE | (vaddr & ~PAGE_MASK);
+}
 
 /* We keep several page tables.  This is a simple routine to find the page
  * table (if any) corresponding to this top-level address the Guest has given
@@ -503,7 +523,7 @@ void guest_set_pte(struct lguest *lg,
 {
 	/* Kernel mappings must be changed on all top levels.  Slow, but
 	 * doesn't happen often. */
-	if (vaddr >= lg->page_offset) {
+	if (vaddr >= lg->kernel_address) {
 		unsigned int i;
 		for (i = 0; i < ARRAY_SIZE(lg->pgdirs); i++)
 			if (lg->pgdirs[i].pgdir)
@@ -553,11 +573,6 @@ void guest_set_pmd(struct lguest *lg, un
  * its first page table is.  We set some things up here: */
 int init_guest_pagetable(struct lguest *lg, unsigned long pgtable)
 {
-	/* In flush_user_mappings() we loop from 0 to
-	 * "pgd_index(lg->page_offset)".  This assumes it won't hit
-	 * the Switcher mappings, so check that now. */
-	if (pgd_index(lg->page_offset) >= SWITCHER_PGD_INDEX)
-		return -EINVAL;
 	/* We start on the first shadow page table, and give it a blank PGD
 	 * page. */
 	lg->pgdidx = 0;
@@ -566,6 +581,24 @@ int init_guest_pagetable(struct lguest *
 	if (!lg->pgdirs[lg->pgdidx].pgdir)
 		return -ENOMEM;
 	return 0;
+}
+
+/* When the Guest calls LHCALL_LGUEST_INIT we do more setup. */
+void page_table_guest_data_init(struct lguest *lg)
+{
+	/* We get the kernel address: above this is all kernel memory. */
+	if (get_user(lg->kernel_address, &lg->lguest_data->kernel_address)
+	    /* We tell the Guest that it can't use the top 4MB of virtual
+	     * addresses used by the Switcher. */
+	    || put_user(4U*1024*1024, &lg->lguest_data->reserve_mem)
+	    || put_user(lg->pgdirs[lg->pgdidx].gpgdir,&lg->lguest_data->pgdir))
+		kill_guest(lg, "bad guest page %p", lg->lguest_data);
+
+	/* In flush_user_mappings() we loop from 0 to
+	 * "pgd_index(lg->kernel_address)".  This assumes it won't hit the
+	 * Switcher mappings, so check that now. */
+	if (pgd_index(lg->kernel_address) >= SWITCHER_PGD_INDEX)
+		kill_guest(lg, "bad kernel address %#lx", lg->kernel_address);
 }
 
 /* When a Guest dies, our cleanup is fairly simple. */
===================================================================
--- a/include/asm-i386/lguest_hcall.h
+++ b/include/asm-i386/lguest_hcall.h
@@ -36,6 +36,7 @@
  * definition of a gentleman: "someone who is only rude intentionally". */
 #define LGUEST_TRAP_ENTRY 0x1F
 
+#ifndef __ASSEMBLY__
 static inline unsigned long
 hcall(unsigned long call,
       unsigned long arg1, unsigned long arg2, unsigned long arg3)
@@ -71,4 +72,6 @@ struct hcall_args
 	/* These map directly onto eax, ebx, ecx, edx in struct lguest_regs */
 	unsigned long arg0, arg2, arg3, arg1;
 };
+
+#endif /* !__ASSEMBLY__ */
 #endif	/* _I386_LGUEST_HCALL_H */
===================================================================
--- a/include/linux/lguest.h
+++ b/include/linux/lguest.h
@@ -44,11 +44,14 @@ struct lguest_data
 	unsigned long reserve_mem;
 	/* KHz for the TSC clock. */
 	u32 tsc_khz;
+	/* Page where the top-level pagetable is */
+	unsigned long pgdir;
 
 /* Fields initialized by the Guest at boot: */
 	/* Instruction range to suppress interrupts even if enabled */
 	unsigned long noirq_start, noirq_end;
-
+	/* Address above which page tables are all identical. */
+	unsigned long kernel_address;
 	/* The vector to try to use for system calls (0x40 or 0x80). */
 	unsigned int syscall_vec;
 };

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
