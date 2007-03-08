From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 07/13] lguest64 loader
Date: Thu, 08 Mar 2007 12:39:00 -0500
Message-ID: <1173375540.32170.9.camel@localhost.localdomain>
References: <20070308162348.299676000@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: virtualization@lists.osdl.org
Cc: Chris Wright <chrisw@sous-sol.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

plain text document attachment (lguest64-loader.patch)
I noticed that the lguest loader code for i386 was in
Documentation/lguest.  Well, that's fine (I guess) but
it can't just be for i386.  So I made a separate directory
to put the loader code in.  So now we have:

 Documentation/lguest/i386/... for the lguest i386 loader.

and
 Documentation/lguest/x86_64/... for the lguest x86_64 loader.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>


Index: work-pv/Documentation/lguest/i386/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/Documentation/lguest/i386/Makefile
@@ -0,0 +1,21 @@
+# This creates the demonstration utility "lguest" which runs a Linux guest.
+
+# We rely on CONFIG_PAGE_OFFSET to know where to put lguest binary.
+# Some shells (dash - ubunu) can't handle numbers that big so we cheat.
+include ../../../.config
+LGUEST_GUEST_TOP :=3D ($(CONFIG_PAGE_OFFSET) - 0x08000000)
+
+CFLAGS:=3D-Wall -Wmissing-declarations -Wmissing-prototypes -O3 \
+	-static -DLGUEST_GUEST_TOP=3D"$(LGUEST_GUEST_TOP)" -Wl,-T,lguest.lds
+LDLIBS:=3D-lz
+
+all: lguest.lds lguest
+
+# The linker script on x86 is so complex the only way of creating one
+# which will link our binary in the right place is to mangle the
+# default one.
+lguest.lds:
+	$(LD) --verbose | awk '/^=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/ { PRINT=3D1; nex=
t; } /SIZEOF_HEADERS/ { gsub(/0x[0-9A-F]*/, "$(LGUEST_GUEST_TOP)") } { if (=
PRINT) print $$0; }' > $@
+
+clean:
+	rm -f lguest.lds lguest
Index: work-pv/Documentation/lguest/i386/lguest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/Documentation/lguest/i386/lguest.c
@@ -0,0 +1,1039 @@
+/* Simple program to layout "physical" memory for new lguest guest.
+ * Linked high to avoid likely physical memory.  */
+#define _LARGEFILE64_SOURCE
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <err.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <elf.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <assert.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <time.h>
+#include <netinet/in.h>
+#include <net/if.h>
+#include <linux/sockios.h>
+#include <linux/if_tun.h>
+#include <sys/uio.h>
+#include <termios.h>
+#include <zlib.h>
+typedef uint32_t u32;
+typedef uint16_t u16;
+typedef uint8_t u8;
+
+#include "../../../include/asm/lguest_user.h"
+
+#define PAGE_PRESENT 0x7 	/* Present, RW, Execute */
+#define NET_PEERNUM 1
+#define BRIDGE_PFX "bridge:"
+
+static bool verbose;
+#define verbose(args...) \
+	do { if (verbose) printf(args); fflush(stdout); } while(0)
+
+struct devices
+{
+	fd_set infds;
+	int max_infd;
+
+	struct device *dev;
+};
+
+struct device
+{
+	struct device *next;
+	struct lguest_device_desc *desc;
+	void *mem;
+
+	/* Watch this fd if handle_input non-NULL. */
+	int fd;
+	int (*handle_input)(int fd, struct device *me);
+
+	/* Watch DMA to this address if handle_input non-NULL. */
+	unsigned long watch_address;
+	u32 (*handle_output)(int fd, const struct iovec *iov,
+			     unsigned int num, struct device *me);
+
+	/* Device-specific data. */
+	void *priv;
+};
+
+static char buf[1024];
+static struct iovec discard_iov =3D { .iov_base=3Dbuf, .iov_len=3Dsizeof(b=
uf) };
+static int zero_fd;
+
+/* LGUEST_GUEST_TOP defined in Makefile, just below us.
+   FIXME: vdso gets mapped just under it, and we need to protect that. */
+#define RESERVE_TOP LGUEST_GUEST_TOP - 1024*1024
+
+static u32 memparse(const char *ptr)
+{
+	char *end;
+	unsigned long ret =3D strtoul(ptr, &end, 0);
+
+	switch (*end) {
+	case 'G':
+	case 'g':
+		ret <<=3D 10;
+	case 'M':
+	case 'm':
+		ret <<=3D 10;
+	case 'K':
+	case 'k':
+		ret <<=3D 10;
+		end++;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static inline unsigned long page_align(unsigned long addr)
+{
+	return ((addr + getpagesize()-1) & ~(getpagesize()-1));
+}
+
+/* initrd gets loaded at top of memory: return length. */
+static unsigned long load_initrd(const char *name, unsigned long end)
+{
+	int ifd;
+	struct stat st;
+	void *iaddr;
+
+	if (!name)
+		return 0;
+
+	ifd =3D open(name, O_RDONLY, 0);
+	if (ifd < 0)
+		err(1, "Opening initrd '%s'", name);
+
+	if (fstat(ifd, &st) < 0)
+		err(1, "fstat() on initrd '%s'", name);
+
+	iaddr =3D mmap((void *)end - st.st_size, st.st_size,
+		     PROT_READ|PROT_EXEC|PROT_WRITE,
+		     MAP_FIXED|MAP_PRIVATE, ifd, 0);
+	if (iaddr !=3D (void *)end - st.st_size)
+		err(1, "Mmaping initrd '%s' returned %p not %p",
+		    name, iaddr, (void *)end - st.st_size);
+	close(ifd);
+	verbose("mapped initrd %s size=3D%lu @ %p\n", name, st.st_size, iaddr);
+	return st.st_size;
+}
+
+/* First map /dev/zero over entire memory, then insert kernel. */
+static void map_memory(unsigned long mem)
+{
+	if (mmap(0, mem,
+		 PROT_READ|PROT_WRITE|PROT_EXEC,
+		 MAP_FIXED|MAP_PRIVATE, zero_fd, 0) !=3D (void *)0)
+		err(1, "Mmaping /dev/zero for %li bytes", mem);
+}
+
+static u32 finish(unsigned long mem, unsigned long *page_offset,
+		  const char *initrd, unsigned long *ird_size)
+{
+	u32 *pgdir =3D NULL, *linear =3D NULL;
+	int i, pte_pages;
+
+	/* This is a top of mem. */
+	*ird_size =3D load_initrd(initrd, mem);
+
+	/* Below initrd is used as top level of pagetable. */
+	pte_pages =3D 1 + (mem/getpagesize() + 1023)/1024;
+
+	pgdir =3D (u32 *)page_align(mem - *ird_size - pte_pages*getpagesize());
+	linear =3D (void *)pgdir + getpagesize();
+
+	/* Linear map all of memory at page_offset (to top of mem). */
+	if (mem > -*page_offset)
+		mem =3D -*page_offset;
+
+	for (i =3D 0; i < mem / getpagesize(); i++)
+		linear[i] =3D ((i * getpagesize()) | PAGE_PRESENT);
+	verbose("Linear %p-%p (%i-%i) =3D %#08x-%#08x\n",
+		linear, linear+i-1, 0, i-1, linear[0], linear[i-1]);
+
+	/* Now set up pgd so that this memory is at page_offset */
+	for (i =3D 0; i < mem / getpagesize(); i +=3D getpagesize()/sizeof(u32)) {
+		pgdir[(i + *page_offset/getpagesize())/1024]
+			=3D (((u32)linear + i*sizeof(u32)) | PAGE_PRESENT);
+		verbose("Top level %lu =3D %#08x\n",
+			(i + *page_offset/getpagesize())/1024,
+			pgdir[(i + *page_offset/getpagesize())/1024]);
+	}
+
+	return (unsigned long)pgdir;
+}
+
+/* Returns the entry point */
+static u32 map_elf(int elf_fd, const Elf32_Ehdr *ehdr, unsigned long mem,
+		   unsigned long *pgdir_addr,
+		   const char *initrd, unsigned long *ird_size,
+		   unsigned long *page_offset)
+{
+	void *addr;
+	Elf32_Phdr phdr[ehdr->e_phnum];
+	unsigned int i;
+
+	/* Sanity checks. */
+	if (ehdr->e_type !=3D ET_EXEC
+	    || ehdr->e_machine !=3D EM_386
+	    || ehdr->e_phentsize !=3D sizeof(Elf32_Phdr)
+	    || ehdr->e_phnum < 1 || ehdr->e_phnum > 65536U/sizeof(Elf32_Phdr))
+		errx(1, "Malformed elf header");
+
+	if (lseek(elf_fd, ehdr->e_phoff, SEEK_SET) < 0)
+		err(1, "Seeking to program headers");
+	if (read(elf_fd, phdr, sizeof(phdr)) !=3D sizeof(phdr))
+		err(1, "Reading program headers");
+
+	map_memory(mem);
+
+	*page_offset =3D 0;
+	/* We map the loadable segments at virtual addresses corresponding
+	 * to their physical addresses (our virtual =3D=3D guest physical). */
+	for (i =3D 0; i < ehdr->e_phnum; i++) {
+		if (phdr[i].p_type !=3D PT_LOAD)
+			continue;
+
+		verbose("Section %i: size %i addr %p\n",
+			i, phdr[i].p_memsz, (void *)phdr[i].p_paddr);
+		/* We map everything private, writable. */
+		if (phdr[i].p_paddr + phdr[i].p_memsz > mem)
+			errx(1, "Segment %i overlaps end of memory", i);
+
+		/* We expect linear address space. */
+		if (!*page_offset)
+			*page_offset =3D phdr[i].p_vaddr - phdr[i].p_paddr;
+		else if (*page_offset !=3D phdr[i].p_vaddr - phdr[i].p_paddr)
+			errx(1, "Page offset of section %i different", i);
+
+		/* Recent ld versions don't page align any more. */
+		if (phdr[i].p_paddr % getpagesize()) {
+			phdr[i].p_filesz +=3D (phdr[i].p_paddr % getpagesize());
+			phdr[i].p_offset -=3D (phdr[i].p_paddr % getpagesize());
+			phdr[i].p_paddr -=3D (phdr[i].p_paddr % getpagesize());
+		}
+		addr =3D mmap((void *)phdr[i].p_paddr,
+			    phdr[i].p_filesz,
+			    PROT_READ|PROT_WRITE|PROT_EXEC,
+			    MAP_FIXED|MAP_PRIVATE,
+			    elf_fd, phdr[i].p_offset);
+		if (addr !=3D (void *)phdr[i].p_paddr)
+			err(1, "Mmaping vmlinux segment %i returned %p not %p (%p)",
+			    i, addr, (void *)phdr[i].p_paddr, &phdr[i].p_paddr);
+	}
+
+	*pgdir_addr =3D finish(mem, page_offset, initrd, ird_size);
+	/* Entry is physical address: convert to virtual */
+	return ehdr->e_entry + *page_offset;
+}
+
+static unsigned long intuit_page_offset(unsigned char *img, unsigned long =
len)
+{
+	unsigned int i, possibilities[256];
+
+	for (i =3D 0; i + 4 < len; i++) {
+		/* mov 0xXXXXXXXX,%eax */
+		if (img[i] =3D=3D 0xA1 && ++possibilities[img[i+4]] > 3)
+			return (unsigned long)img[i+4] << 24;
+	}
+	errx(1, "could not determine page offset");
+}
+
+static u32 bzimage(int fd, unsigned long mem, unsigned long *pgdir_addr,
+		   const char *initrd, unsigned long *ird_size,
+		   unsigned long *page_offset)
+{
+	gzFile f;
+	int ret, len =3D 0;
+	void *img =3D (void *)0x100000;
+
+	map_memory(mem);
+
+	f =3D gzdopen(fd, "rb");
+	if (gzdirect(f))
+		errx(1, "did not find correct gzip header");
+	while ((ret =3D gzread(f, img + len, 65536)) > 0)
+		len +=3D ret;
+	if (ret < 0)
+		err(1, "reading image from bzImage");
+
+	verbose("Unpacked size %i addr %p\n", len, img);
+	*page_offset =3D intuit_page_offset(img, len);
+	*pgdir_addr =3D finish(mem, page_offset, initrd, ird_size);
+
+	/* Entry is physical address: convert to virtual */
+	return (u32)img + *page_offset;
+}
+
+static u32 load_bzimage(int bzimage_fd, const Elf32_Ehdr *ehdr,
+			unsigned long mem, unsigned long *pgdir_addr,
+			const char *initrd, unsigned long *ird_size,
+			unsigned long *page_offset)
+{
+	unsigned char c;
+	int state =3D 0;
+
+	/* Just brute force it. */
+	while (read(bzimage_fd, &c, 1) =3D=3D 1) {
+		switch (state) {
+		case 0:
+			if (c =3D=3D 0x1F)
+				state++;
+			break;
+		case 1:
+			if (c =3D=3D 0x8B)
+				state++;
+			else
+				state =3D 0;
+			break;
+		case 2 ... 8:
+			state++;
+			break;
+		case 9:
+			lseek(bzimage_fd, -10, SEEK_CUR);
+			if (c !=3D 0x03) /* Compressed under UNIX. */
+				state =3D -1;
+			else
+				return bzimage(bzimage_fd, mem, pgdir_addr,
+					       initrd, ird_size, page_offset);
+		}
+	}
+	errx(1, "Could not find kernel in bzImage");
+}
+
+static void *map_pages(unsigned long addr, unsigned int num)
+{
+	if (mmap((void *)addr, getpagesize() * num,
+		 PROT_READ|PROT_WRITE|PROT_EXEC,
+		 MAP_FIXED|MAP_PRIVATE, zero_fd, 0) !=3D (void *)addr)
+		err(1, "Mmaping %u pages of /dev/zero @%p", num, (void *)addr);
+	return (void *)addr;
+}
+
+static struct lguest_device_desc *
+get_dev_entry(struct lguest_device_desc *descs, u16 type, u16 num_pages)
+{
+	static unsigned long top =3D RESERVE_TOP;
+	int i;
+	unsigned long pfn =3D 0;
+
+	if (num_pages) {
+		top -=3D num_pages*getpagesize();
+		map_pages(top, num_pages);
+		pfn =3D top / getpagesize();
+	}
+
+	for (i =3D 0; i < LGUEST_MAX_DEVICES; i++) {
+		if (!descs[i].type) {
+			descs[i].features =3D descs[i].status =3D 0;
+			descs[i].type =3D type;
+			descs[i].num_pages =3D num_pages;
+			descs[i].pfn =3D pfn;
+			return &descs[i];
+		}
+	}
+	errx(1, "too many devices");
+}
+
+static void set_fd(int fd, struct devices *devices)
+{
+	FD_SET(fd, &devices->infds);
+	if (fd > devices->max_infd)
+		devices->max_infd =3D fd;
+}
+
+static struct device *new_device(struct devices *devices,
+				 struct lguest_device_desc *descs,
+				 u16 type, u16 num_pages,
+				 int fd,
+				 int (*handle_input)(int, struct device *),
+				 unsigned long watch_off,
+				 u32 (*handle_output)(int,
+						      const struct iovec *,
+						      unsigned,
+						      struct device *))
+{
+	struct device *dev =3D malloc(sizeof(*dev));
+
+	dev->next =3D devices->dev;
+	devices->dev =3D dev;
+
+	dev->fd =3D fd;
+	if (handle_input)
+		set_fd(dev->fd, devices);
+	dev->desc =3D get_dev_entry(descs, type, num_pages);
+	dev->mem =3D (void *)(dev->desc->pfn * getpagesize());
+	dev->handle_input =3D handle_input;
+	dev->watch_address =3D (unsigned long)dev->mem + watch_off;
+	dev->handle_output =3D handle_output;
+	return dev;
+}
+
+static int tell_kernel(u32 pagelimit, u32 pgdir, u32 start, u32 page_offse=
t)
+{
+	u32 args[] =3D { LHREQ_INITIALIZE,
+		       pagelimit, pgdir, start, page_offset };
+	int fd =3D open("/dev/lguest", O_RDWR);
+
+	if (fd < 0)
+		err(1, "Opening /dev/lguest");
+
+	verbose("Telling kernel limit %u, pgdir %i, e=3D%#08x page_off=3D0x%08x\n=
",
+		pagelimit, pgdir, start, page_offset);
+	if (write(fd, args, sizeof(args)) < 0)
+		err(1, "Writing to /dev/lguest");
+	return fd;
+}
+
+static void concat(char *dst, char *args[])
+{
+	unsigned int i, len =3D 0;
+
+	for (i =3D 0; args[i]; i++) {
+		strcpy(dst+len, args[i]);
+		strcat(dst+len, " ");
+		len +=3D strlen(args[i]) + 1;
+	}
+	/* In case it's empty. */
+	dst[len] =3D '\0';
+}
+
+static void *_check_pointer(unsigned long addr, unsigned int size,
+			    unsigned int line)
+{
+	if (addr >=3D RESERVE_TOP || addr + size >=3D RESERVE_TOP)
+		errx(1, "%s:%i: Invalid address %li", __FILE__, line, addr);
+	return (void *)addr;
+}
+#define check_pointer(addr,size) _check_pointer(addr, size, __LINE__)
+
+/* Returns pointer to dma->used_len */
+static u32 *dma2iov(unsigned long dma, struct iovec iov[], unsigned *num)
+{
+	unsigned int i;
+	struct lguest_dma *udma;
+
+	/* No buffers? */
+	if (dma =3D=3D 0) {
+		printf("no buffers\n");
+		return NULL;
+	}
+
+	udma =3D check_pointer(dma, sizeof(*udma));
+	for (i =3D 0; i < LGUEST_MAX_DMA_SECTIONS; i++) {
+		if (!udma->len[i])
+			break;
+
+		iov[i].iov_base =3D check_pointer(udma->addr[i], udma->len[i]);
+		iov[i].iov_len =3D udma->len[i];
+	}
+	*num =3D i;
+	return &udma->used_len;
+}
+
+static u32 *get_dma_buffer(int fd, void *addr,
+			   struct iovec iov[], unsigned *num, u32 *irq)
+{
+	u32 buf[] =3D { LHREQ_GETDMA, (u32)addr };
+	unsigned long udma;
+	u32 *res;
+
+	udma =3D write(fd, buf, sizeof(buf));
+	if (udma =3D=3D (unsigned long)-1)
+		return NULL;
+
+	/* Kernel stashes irq in ->used_len. */
+	res =3D dma2iov(udma, iov, num);
+	if (res)
+		*irq =3D *res;
+	return res;
+}
+
+static void trigger_irq(int fd, u32 irq)
+{
+	u32 buf[] =3D { LHREQ_IRQ, irq };
+	if (write(fd, buf, sizeof(buf)) !=3D 0)
+		err(1, "Triggering irq %i", irq);
+}
+
+static struct termios orig_term;
+static void restore_term(void)
+{
+	tcsetattr(STDIN_FILENO, TCSANOW, &orig_term);
+}
+
+struct console_abort
+{
+	int count;
+	struct timeval start;
+};
+
+/* We DMA input to buffer bound at start of console page. */
+static int handle_console_input(int fd, struct device *dev)
+{
+	u32 num, irq =3D 0, *lenp;
+	int len;
+	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
+	struct console_abort *abort =3D dev->priv;
+
+	lenp =3D get_dma_buffer(fd, dev->mem, iov, &num, &irq);
+	if (!lenp) {
+		warn("console: no dma buffer!");
+		iov[0] =3D discard_iov;
+		num =3D 1;
+	}
+
+	len =3D readv(dev->fd, iov, num);
+	if (len <=3D 0) {
+		warnx("Failed to get console input, ignoring console.");
+		len =3D 0;
+	}
+
+	if (lenp) {
+		*lenp =3D len;
+		trigger_irq(fd, irq);
+	}
+
+	/* Three ^C within one second?  Exit. */
+	if (len =3D=3D 1 && ((char *)iov[0].iov_base)[0] =3D=3D 3) {
+		if (!abort->count++)
+			gettimeofday(&abort->start, NULL);
+		else if (abort->count =3D=3D 3) {
+			struct timeval now;
+			gettimeofday(&now, NULL);
+			if (now.tv_sec <=3D abort->start.tv_sec+1)
+				exit(2);
+			abort->count =3D 0;
+		}
+	} else
+		abort->count =3D 0;
+
+	if (!len) {
+		restore_term();
+		return 0;
+	}
+	return 1;
+}
+
+static unsigned long peer_offset(unsigned int peernum)
+{
+	return 4 * peernum;
+}
+
+static u32 handle_tun_output(int fd, const struct iovec *iov,
+			     unsigned num, struct device *dev)
+{
+	/* Now we've seen output, we should warn if we can't get buffers. */
+	*(bool *)dev->priv =3D true;
+	return writev(dev->fd, iov, num);
+}
+
+static u32 handle_block_output(int fd, const struct iovec *iov,
+			       unsigned num, struct device *dev)
+{
+	struct lguest_block_page *p =3D dev->mem;
+	u32 irq, reply_num, *lenp;
+	int len;
+	struct iovec reply[LGUEST_MAX_DMA_SECTIONS];
+	off64_t device_len, off =3D (off64_t)p->sector * 512;
+
+	device_len =3D *(off64_t *)dev->priv;
+
+	if (off >=3D device_len)
+		err(1, "Bad offset %llu vs %llu", off, device_len);
+	if (lseek64(dev->fd, off, SEEK_SET) !=3D off)
+		err(1, "Bad seek to sector %i", p->sector);
+
+	verbose("Block: %s at offset %llu\n", p->type ? "WRITE" : "READ", off);
+
+	lenp =3D get_dma_buffer(fd, dev->mem, reply, &reply_num, &irq);
+	if (!lenp)
+		err(1, "Block request didn't give us a dma buffer");
+
+	if (p->type) {
+		len =3D writev(dev->fd, iov, num);
+		if (off + len > device_len) {
+			ftruncate(dev->fd, device_len);
+			errx(1, "Write past end %llu+%u", off, len);
+		}
+		*lenp =3D 0;
+	} else {
+		len =3D readv(dev->fd, reply, reply_num);
+		*lenp =3D len;
+	}
+
+	p->result =3D 1 + (p->bytes !=3D len);
+	trigger_irq(fd, irq);
+	return 0;
+}
+
+#define HIPQUAD(ip)				\
+	((u8)(ip >> 24)),			\
+	((u8)(ip >> 16)),			\
+	((u8)(ip >> 8)),			\
+	((u8)(ip))
+
+static void configure_device(int fd, const char *devname, u32 ipaddr,
+			     unsigned char hwaddr[6])
+{
+	struct ifreq ifr;
+	struct sockaddr_in *sin =3D (struct sockaddr_in *)&ifr.ifr_addr;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strcpy(ifr.ifr_name, devname);
+	sin->sin_family =3D AF_INET;
+	sin->sin_addr.s_addr =3D htonl(ipaddr);
+	if (ioctl(fd, SIOCSIFADDR, &ifr) !=3D 0)
+		err(1, "Setting %s interface address", devname);
+	ifr.ifr_flags =3D IFF_UP;
+	if (ioctl(fd, SIOCSIFFLAGS, &ifr) !=3D 0)
+		err(1, "Bringing interface %s up", devname);
+
+	if (ioctl(fd, SIOCGIFHWADDR, &ifr) !=3D 0)
+		err(1, "getting hw address for %s", devname);
+
+	memcpy(hwaddr, ifr.ifr_hwaddr.sa_data, 6);
+}
+
+/* We send lguest_add signals while input is pending: avoids races. */
+static void wake_parent(int pipefd, struct devices *devices)
+{
+	int parent =3D getppid();
+	nice(19);
+
+	set_fd(pipefd, devices);
+
+	for (;;) {
+		fd_set rfds =3D devices->infds;
+
+		select(devices->max_infd+1, &rfds, NULL, NULL, NULL);
+		if (FD_ISSET(pipefd, &rfds)) {
+			int ignorefd;
+			if (read(pipefd, &ignorefd, sizeof(ignorefd)) =3D=3D 0)
+				exit(0);
+			FD_CLR(ignorefd, &devices->infds);
+		}
+		kill(parent, SIGUSR1);
+	}
+}
+
+/* We don't want signal to kill us, just jerk us out of kernel. */
+static void wakeup(int signo)
+{
+}
+
+static int handle_tun_input(int fd, struct device *dev)
+{
+	u32 irq =3D 0, num, *lenp;
+	int len;
+	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
+
+	lenp =3D get_dma_buffer(fd, dev->mem+peer_offset(NET_PEERNUM), iov, &num,
+			      &irq);
+	if (!lenp) {
+		if (*(bool *)dev->priv)
+			warn("network: no dma buffer!");
+		iov[0] =3D discard_iov;
+		num =3D 1;
+	}
+
+	len =3D readv(dev->fd, iov, num);
+	if (len <=3D 0)
+		err(1, "reading network");
+	if (lenp) {
+		*lenp =3D len;
+		trigger_irq(fd, irq);
+	}
+	verbose("tun input packet len %i [%02x %02x] (%s)\n", len,
+		((u8 *)iov[0].iov_base)[0], ((u8 *)iov[0].iov_base)[1],
+		lenp ? "sent" : "discarded");
+	return 1;
+}
+
+/* We use fnctl locks to reserve network slots (autocleanup!) */
+static unsigned int find_slot(int netfd, const char *filename)
+{
+	struct flock fl;
+
+	fl.l_type =3D F_WRLCK;
+	fl.l_whence =3D SEEK_SET;
+	fl.l_len =3D 1;
+	for (fl.l_start =3D 0;
+	     fl.l_start < getpagesize()/sizeof(struct lguest_net);
+	     fl.l_start++) {
+		if (fcntl(netfd, F_SETLK, &fl) =3D=3D 0)
+			return fl.l_start;
+	}
+	errx(1, "No free slots in network file %s", filename);
+}
+
+static void setup_net_file(const char *filename,
+			   struct lguest_device_desc *descs,
+			   struct devices *devices)
+{
+	int netfd;
+	struct device *dev;
+
+	netfd =3D open(filename, O_RDWR, 0);
+	if (netfd < 0) {
+		if (errno =3D=3D ENOENT) {
+			netfd =3D open(filename, O_RDWR|O_CREAT, 0600);
+			if (netfd >=3D 0) {
+				char page[getpagesize()];
+				/* 0xFFFF =3D=3D NO_GUEST */
+				memset(page, 0xFF, sizeof(page));
+				write(netfd, page, sizeof(page));
+			}
+		}
+		if (netfd < 0)
+			err(1, "cannot open net file '%s'", filename);
+	}
+
+	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_NET, 1,
+			 -1, NULL, 0, NULL);
+
+	/* This is the slot for the guest to use. */
+	dev->desc->features =3D find_slot(netfd, filename)|LGUEST_NET_F_NOCSUM;
+	/* We overwrite the /dev/zero mapping with the actual file. */
+	if (mmap(dev->mem, getpagesize(), PROT_READ|PROT_WRITE,
+			 MAP_FIXED|MAP_SHARED, netfd, 0) !=3D dev->mem)
+			err(1, "could not mmap '%s'", filename);
+	verbose("device %p@%p: shared net %s, peer %i\n", dev->desc,
+		(void *)(dev->desc->pfn * getpagesize()), filename,
+		dev->desc->features & ~LGUEST_NET_F_NOCSUM);
+}
+
+static u32 str2ip(const char *ipaddr)
+{
+	unsigned int byte[4];
+
+	sscanf(ipaddr, "%u.%u.%u.%u", &byte[0], &byte[1], &byte[2], &byte[3]);
+	return (byte[0] << 24) | (byte[1] << 16) | (byte[2] << 8) | byte[3];
+}
+
+/* adapted from libbridge */
+static void add_to_bridge(int fd, const char *if_name, const char *br_name)
+{
+	int r, ifidx;
+	struct ifreq ifr;
+
+	if (!*br_name)
+		errx(1, "must specify bridge name");
+
+	ifidx =3D if_nametoindex(if_name);
+	if (!ifidx)
+		errx(1, "interface %s does not exist!\n", if_name);
+
+	strncpy(ifr.ifr_name, br_name, IFNAMSIZ);
+	ifr.ifr_ifindex =3D ifidx;
+	r =3D ioctl(fd, SIOCBRADDIF, &ifr);
+	if (r !=3D -1)
+		return;
+
+	switch (errno) {
+	case ENODEV:
+		errx(1, "bridge %s does not exist!\n", br_name);
+	case EBUSY:
+		errx(1, "device %s is already a member of a bridge; "
+			"can't enslave it to bridge %s.\n", if_name, br_name);
+	case ELOOP:
+		errx(1, "device %s is a bridge device itself; "
+			"can't enslave a bridge device to a bridge device.\n",
+			if_name);
+	default:
+		err(1, "can't add %s to bridge %s\n", if_name, br_name);
+	}
+}
+
+
+static void setup_tun_net(const char *arg,
+			  struct lguest_device_desc *descs,
+			  struct devices *devices)
+{
+	struct device *dev;
+	struct ifreq ifr;
+	int netfd, ipfd;
+	u32 ipaddr;
+	const char *br_name =3D NULL;
+
+	netfd =3D open("/dev/net/tun", O_RDWR);
+	if (netfd < 0)
+		err(1, "opening /dev/net/tun");
+
+	memset(&ifr, 0, sizeof(ifr));
+	ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI;
+	strcpy(ifr.ifr_name, "tap%d");
+	if (ioctl(netfd, TUNSETIFF, &ifr) !=3D 0)
+		err(1, "configuring /dev/net/tun");
+
+	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_NET, 1,
+			 netfd, handle_tun_input,
+			 peer_offset(0), handle_tun_output);
+	dev->priv =3D malloc(sizeof(bool));
+	*(bool *)dev->priv =3D false;
+
+	ipfd =3D socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
+	if (ipfd < 0)
+		err(1, "opening IP socket");
+
+	if (!strncmp(BRIDGE_PFX, arg, strlen(BRIDGE_PFX))) {
+		ipaddr =3D INADDR_ANY;
+		br_name =3D arg + strlen(BRIDGE_PFX);
+		add_to_bridge(ipfd, ifr.ifr_name, br_name);
+	} else
+		ipaddr =3D str2ip(arg);
+
+	/* We are peer 0, rest is all NO_GUEST */
+	configure_device(ipfd, ifr.ifr_name, ipaddr, dev->mem);
+	close (ipfd);
+
+	/* You will be peer 1: we should create enough jitter to randomize */
+	dev->desc->features =3D NET_PEERNUM|LGUEST_DEVICE_F_RANDOMNESS;
+	verbose("device %p@%p: tun net %u.%u.%u.%u\n", dev->desc,
+		(void *)(dev->desc->pfn * getpagesize()),
+		HIPQUAD(ipaddr));
+	if (br_name)
+		verbose("attched to bridge: %s\n", br_name);
+}
+
+static void setup_block_file(const char *filename,
+			     struct lguest_device_desc *descs,
+			     struct devices *devices)
+{
+	int fd;
+	struct device *dev;
+	off64_t *blocksize;
+	struct lguest_block_page *p;
+
+	fd =3D open(filename, O_RDWR|O_LARGEFILE|O_DIRECT, 0);
+	if (fd < 0)
+		err(1, "Opening %s", filename);
+
+	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_BLOCK, 1,
+			 fd, NULL, 0, handle_block_output);
+	dev->desc->features =3D LGUEST_DEVICE_F_RANDOMNESS;
+	blocksize =3D dev->priv =3D malloc(sizeof(*blocksize));
+	*blocksize =3D lseek64(fd, 0, SEEK_END);
+	p =3D dev->mem;
+
+	p->num_sectors =3D *blocksize/512;
+	verbose("device %p@%p: block %i sectors\n", dev->desc,
+		(void *)(dev->desc->pfn * getpagesize()), p->num_sectors);
+}
+
+static u32 handle_console_output(int fd, const struct iovec *iov,
+				 unsigned num, struct device*dev)
+{
+	return writev(STDOUT_FILENO, iov, num);
+}
+
+static void setup_console(struct lguest_device_desc *descs,
+			  struct devices *devices)
+{
+	struct device *dev;
+
+	if (tcgetattr(STDIN_FILENO, &orig_term) =3D=3D 0) {
+		struct termios term =3D orig_term;
+		term.c_lflag &=3D ~(ISIG|ICANON|ECHO);
+		tcsetattr(STDIN_FILENO, TCSANOW, &term);
+		atexit(restore_term);
+	}
+
+	/* We don't currently require a page for the console. */
+	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_CONSOLE, 0,
+			 STDIN_FILENO, handle_console_input,
+			 4, handle_console_output);
+	dev->priv =3D malloc(sizeof(struct console_abort));
+	((struct console_abort *)dev->priv)->count =3D 0;
+	verbose("device %p@%p: console\n", dev->desc,
+		(void *)(dev->desc->pfn * getpagesize()));
+}
+
+static const char *get_arg(const char *arg, const char *prefix)
+{
+	if (strncmp(arg, prefix, strlen(prefix)) =3D=3D 0)
+		return arg + strlen(prefix);
+	return NULL;
+}
+
+static u32 handle_device(int fd, unsigned long dma, unsigned long addr,
+			 struct devices *devices)
+{
+	struct device *i;
+	u32 *lenp;
+	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
+	unsigned num =3D 0;
+
+	lenp =3D dma2iov(dma, iov, &num);
+	if (!lenp)
+		errx(1, "Bad SEND_DMA %li for address %#lx\n", dma, addr);
+
+	for (i =3D devices->dev; i; i =3D i->next) {
+		if (i->handle_output && addr =3D=3D i->watch_address) {
+			*lenp =3D i->handle_output(fd, iov, num, i);
+			return 0;
+		}
+	}
+	warnx("Pending dma %p, addr %p", (void *)dma, (void *)addr);
+	return 0;
+}
+
+static void handle_input(int fd, int childfd, struct devices *devices)
+{
+	struct timeval poll =3D { .tv_sec =3D 0, .tv_usec =3D 0 };
+
+	for (;;) {
+		struct device *i;
+		fd_set fds =3D devices->infds;
+
+		if (select(devices->max_infd+1, &fds, NULL, NULL, &poll) =3D=3D 0)
+			break;
+
+		for (i =3D devices->dev; i; i =3D i->next) {
+			if (i->handle_input && FD_ISSET(i->fd, &fds)) {
+				if (!i->handle_input(fd, i)) {
+					FD_CLR(i->fd, &devices->infds);
+					/* Tell child to ignore it too... */
+					write(childfd, &i->fd, sizeof(i->fd));
+				}
+			}
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long mem, pgdir, entry, initrd_size, page_offset;
+	int arg, kern_fd, fd, child, pipefd[2];
+	Elf32_Ehdr hdr;
+	struct sigaction act;
+	sigset_t sigset;
+	struct lguest_device_desc *devdescs;
+	struct devices devices;
+	struct lguest_boot_info *boot =3D (void *)0;
+	const char *initrd_name =3D NULL;
+	u32 (*load)(int, const Elf32_Ehdr *ehdr, unsigned long,
+		    unsigned long *, const char *, unsigned long *,
+		    unsigned long *);
+
+	if (argv[1] && strcmp(argv[1], "--verbose") =3D=3D 0) {
+		verbose =3D true;
+		argv++;
+		argc--;
+	}
+
+	if (argc < 4)
+		errx(1, "Usage: lguest [--verbose] <mem> vmlinux "
+			"[--sharenet=3D<filename>|--tunnet=3D(<ipaddr>|bridge:<bridgename>)"
+			"|--block=3D<filename>|--initrd=3D<filename>]... [args...]");
+
+	zero_fd =3D open("/dev/zero", O_RDONLY, 0);
+	if (zero_fd < 0)
+		err(1, "Opening /dev/zero");
+
+	mem =3D memparse(argv[1]);
+	kern_fd =3D open(argv[2], O_RDONLY, 0);
+	if (kern_fd < 0)
+		err(1, "Opening %s", argv[2]);
+
+	if (read(kern_fd, &hdr, sizeof(hdr)) !=3D sizeof(hdr))
+		err(1, "Reading %s elf header", argv[2]);
+
+	if (memcmp(hdr.e_ident, ELFMAG, SELFMAG) =3D=3D 0)
+		load =3D map_elf;
+	else
+		load =3D load_bzimage;
+
+	devices.max_infd =3D -1;
+	devices.dev =3D NULL;
+	FD_ZERO(&devices.infds);
+
+	devdescs =3D map_pages(mem, 1);
+	arg =3D 3;
+	while (argv[arg] && argv[arg][0] =3D=3D '-') {
+		const char *argval;
+
+		if ((argval =3D get_arg(argv[arg], "--sharenet=3D")) !=3D NULL)
+			setup_net_file(argval, devdescs, &devices);
+		else if ((argval =3D get_arg(argv[arg], "--tunnet=3D")) !=3D NULL)
+			setup_tun_net(argval, devdescs, &devices);
+		else if ((argval =3D get_arg(argv[arg], "--block=3D")) !=3D NULL)
+			setup_block_file(argval, devdescs, &devices);
+		else if ((argval =3D get_arg(argv[arg], "--initrd=3D")) !=3D NULL)
+			initrd_name =3D argval;
+		else
+			errx(1, "unknown arg '%s'", argv[arg]);
+		arg++;
+	}
+
+	entry =3D load(kern_fd, &hdr, mem, &pgdir, initrd_name, &initrd_size,
+		     &page_offset);
+	setup_console(devdescs, &devices);
+
+	concat(boot->cmdline, argv+arg);
+	boot->max_pfn =3D mem/getpagesize();
+	boot->initrd_size =3D initrd_size;
+
+	act.sa_handler =3D wakeup;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags =3D 0;
+	sigaction(SIGUSR1, &act, NULL);
+
+	pipe(pipefd);
+	child =3D fork();
+	if (child =3D=3D -1)
+		err(1, "forking");
+
+	if (child =3D=3D 0) {
+		close(pipefd[1]);
+		wake_parent(pipefd[0], &devices);
+	}
+	close(pipefd[0]);
+
+	sigemptyset(&sigset);
+	sigaddset(&sigset, SIGUSR1);
+	sigprocmask(SIG_BLOCK, &sigset, NULL);
+
+	fd =3D tell_kernel(RESERVE_TOP/getpagesize(), pgdir, entry, page_offset);
+
+	for (;;) {
+		unsigned long arr[2];
+		int readval;
+
+		sigprocmask(SIG_UNBLOCK, &sigset, NULL);
+		readval =3D read(fd, arr, sizeof(arr));
+		sigprocmask(SIG_BLOCK, &sigset, NULL);
+
+		switch (readval) {
+		case sizeof(arr):
+			handle_device(fd, arr[0], arr[1], &devices);
+			break;
+		case -1:
+			if (errno =3D=3D EINTR)
+				break;
+		default:
+			if (errno =3D=3D ENOENT) {
+				char reason[1024];
+				if (read(fd, reason, sizeof(reason)) > 0)
+					errx(1, "%s", reason);
+			}
+			err(1, "Running guest failed");
+		}
+		handle_input(fd, pipefd[1], &devices);
+	}
+}
Index: work-pv/Documentation/lguest/x86_64/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/Documentation/lguest/x86_64/Makefile
@@ -0,0 +1,22 @@
+# This creates the demonstration utility "lguest" which runs a Linux guest.
+
+# For now on x86_64 we'll hard code the location of the lguest binary load=
er.
+# But when we can get a relocatable kernel, we'll have to work to make this
+# dynamic.
+LGUEST_GUEST_TOP :=3D 0x7f000000
+
+CFLAGS:=3D-Wall -Wmissing-declarations -Wmissing-prototypes -O3 \
+	-g \
+	-static -DLGUEST_GUEST_TOP=3D"$(LGUEST_GUEST_TOP)" -Wl,-T,lguest.lds
+LDLIBS:=3D-lz
+
+all: lguest.lds lguest
+
+# The linker script on x86 is so complex the only way of creating one
+# which will link our binary in the right place is to mangle the
+# default one.
+lguest.lds: Makefile
+	$(LD) --verbose | awk '/^=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/ { PRINT=3D1; nex=
t; } /SIZEOF_HEADERS/ { gsub(/0x[0-9A-F]*/, "$(LGUEST_GUEST_TOP)") } { if (=
PRINT) print $$0; }' > $@
+
+clean:
+	rm -f lguest.lds lguest
Index: work-pv/Documentation/lguest/x86_64/lguest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/Documentation/lguest/x86_64/lguest.c
@@ -0,0 +1,1021 @@
+/* Simple program to layout "physical" memory for new lguest guest.
+ * Linked high to avoid likely physical memory.  */
+#define _LARGEFILE64_SOURCE
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <err.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <elf.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <assert.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <signal.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+#include <sys/time.h>
+#include <time.h>
+#include <netinet/in.h>
+#include <linux/if.h>
+#include <linux/if_tun.h>
+#include <asm/vsyscall.h>
+#include <sys/uio.h>
+#include <termios.h>
+#include <zlib.h>
+typedef uint64_t u64;
+typedef uint32_t u32;
+typedef uint16_t u16;
+typedef uint8_t u8;
+
+#include "../../../include/asm/lguest_user.h"
+
+#define PAGE_PRESENT 0x7 	/* Present, RW, Execute */
+#define NET_PEERNUM 1
+
+static bool verbose;
+#define verbose(args...) \
+	do { if (verbose) printf(args); fflush(stdout); } while(0)
+
+struct devices
+{
+	fd_set infds;
+	int max_infd;
+
+	struct device *dev;
+};
+
+struct device
+{
+	struct device *next;
+	struct lguest_device_desc *desc;
+	void *mem;
+
+	/* Watch this fd if handle_input non-NULL. */
+	int fd;
+	int (*handle_input)(int fd, struct device *me);
+
+	/* Watch DMA to this address if handle_input non-NULL. */
+	unsigned long watch_address;
+	u64 (*handle_output)(int fd, const struct iovec *iov,
+			     unsigned int num, struct device *me);
+
+	/* Device-specific data. */
+	void *priv;
+};
+
+static char buf[1024];
+static struct iovec discard_iov =3D { .iov_base=3Dbuf, .iov_len=3Dsizeof(b=
uf) };
+static int zero_fd;
+
+static u64 memparse(const char *ptr)
+{
+	char *end;
+	unsigned long ret =3D strtoul(ptr, &end, 0);
+
+	switch (*end) {
+	case 'G':
+	case 'g':
+		ret <<=3D 10;
+	case 'M':
+	case 'm':
+		ret <<=3D 10;
+	case 'K':
+	case 'k':
+		ret <<=3D 10;
+		end++;
+	default:
+		break;
+	}
+	return ret;
+}
+
+static inline unsigned long page_align(unsigned long addr)
+{
+	return ((addr + getpagesize()-1) & ~(getpagesize()-1));
+}
+
+/* initrd gets loaded at top of memory: return length. */
+static unsigned long load_initrd(const char *name, unsigned long end)
+{
+	int ifd;
+	struct stat st;
+	void *iaddr;
+
+	if (!name)
+		return 0;
+
+	ifd =3D open(name, O_RDONLY, 0);
+	if (ifd < 0)
+		err(1, "Opening initrd '%s'", name);
+
+	if (fstat(ifd, &st) < 0)
+		err(1, "fstat() on initrd '%s'", name);
+
+	iaddr =3D mmap((void *)end - st.st_size, st.st_size,
+		     PROT_READ|PROT_EXEC|PROT_WRITE,
+		     MAP_FIXED|MAP_PRIVATE, ifd, 0);
+	if (iaddr !=3D (void *)end - st.st_size)
+		err(1, "Mmaping initrd '%s' returned %p not %p",
+		    name, iaddr, (void *)end - st.st_size);
+	close(ifd);
+	verbose("mapped initrd %s size=3D%lu @ %p\n", name, st.st_size, iaddr);
+	return st.st_size;
+}
+
+/* First map /dev/zero over entire memory, then insert kernel. */
+static void map_memory(unsigned long mem)
+{
+	if (mmap(0, mem,
+		 PROT_READ|PROT_WRITE|PROT_EXEC,
+		 MAP_FIXED|MAP_PRIVATE, zero_fd, 0) !=3D (void *)0)
+		err(1, "Mmaping /dev/zero for %li bytes", mem);
+}
+
+/* Returns the entry point */
+static u64 map_elf(int elf_fd, const Elf64_Ehdr *ehdr, unsigned long mem,
+		   unsigned long *pgdir_addr,
+		   const char *initrd, unsigned long *ird_size,
+		   u64 *page_offset)
+{
+	void *addr;
+	Elf64_Phdr phdr[ehdr->e_phnum];
+	unsigned int i;
+	Elf64_Shdr sec[ehdr->e_shnum];
+	Elf64_Sym *syms;
+	char *strtab =3D NULL;
+	unsigned long nsyms =3D 0;
+
+	/* Sanity checks. */
+	if (ehdr->e_type !=3D ET_EXEC
+	    || ehdr->e_machine !=3D EM_X86_64
+	    || ehdr->e_phentsize !=3D sizeof(Elf64_Phdr)
+	    || ehdr->e_phnum < 1 || ehdr->e_phnum > 65536U/sizeof(Elf64_Phdr))
+		errx(1, "Malformed elf header");
+
+	if (lseek(elf_fd, ehdr->e_phoff, SEEK_SET) < 0)
+		err(1, "Seeking to program headers");
+	if (read(elf_fd, phdr, sizeof(phdr)) !=3D sizeof(phdr))
+		err(1, "Reading program headers");
+
+	map_memory(mem);
+
+	*page_offset =3D 0;
+	/* We map the loadable segments at virtual addresses corresponding
+	 * to their physical addresses (our virtual =3D=3D guest physical). */
+	for (i =3D 0; i < ehdr->e_phnum; i++) {
+		if (phdr[i].p_type !=3D PT_LOAD)
+			continue;
+
+		verbose("Section %i: size %li addr %p\n",
+			i, phdr[i].p_memsz, (void *)phdr[i].p_paddr);
+		/* We map everything private, writable. */
+		if (phdr[i].p_paddr + phdr[i].p_memsz > mem)
+			errx(1, "Segment %i overlaps end of memory", i);
+
+		/* We expect linear address space. */
+		if (!*page_offset)
+			*page_offset =3D phdr[i].p_vaddr - phdr[i].p_paddr;
+		else if ((*page_offset !=3D phdr[i].p_vaddr - phdr[i].p_paddr) &&
+			 phdr[i].p_vaddr !=3D VSYSCALL_START)
+			errx(1, "Page offset of section %i different (got %lx, expected %lx)",
+			     i, (phdr[i].p_vaddr - phdr[i].p_paddr), *page_offset);
+
+		/* Recent ld versions don't page align any more. */
+		if (phdr[i].p_paddr % getpagesize()) {
+			phdr[i].p_filesz +=3D (phdr[i].p_paddr % getpagesize());
+			phdr[i].p_offset -=3D (phdr[i].p_paddr % getpagesize());
+			phdr[i].p_paddr -=3D (phdr[i].p_paddr % getpagesize());
+		}
+		addr =3D mmap((void *)phdr[i].p_paddr,
+			    phdr[i].p_filesz,
+			    PROT_READ|PROT_WRITE|PROT_EXEC,
+			    MAP_FIXED|MAP_PRIVATE,
+			    elf_fd, phdr[i].p_offset);
+		if (addr !=3D (void *)phdr[i].p_paddr)
+			err(1, "Mmaping vmlinux segment %i returned %p not %p (%p)",
+			    i, addr, (void *)phdr[i].p_paddr, &phdr[i].p_paddr);
+	}
+
+	/* Now process sections searching for boot page tables
+	 * Start by finding the symtab section */
+	if (lseek(elf_fd, ehdr->e_shoff, SEEK_SET) < 0)
+		err(1, "Seeking to section headers");
+	if (read(elf_fd, sec, sizeof(sec)) !=3D sizeof(sec))
+		err(1, "Reading section headers");
+
+	for (i =3D 0; i < ehdr->e_shnum; i++) {
+		if (sec[i].sh_type =3D=3D SHT_SYMTAB) {
+			int ret =3D 0;
+			syms =3D malloc(sec[i].sh_size);
+			if (!syms)
+				err(1,"Not enough memory for symbol table");
+			ret =3D lseek(elf_fd, sec[i].sh_offset, SEEK_SET);
+			if (ret < 0)
+				err(1, "Seeking to symbol table");
+			ret =3D read(elf_fd, syms, sec[i].sh_size);
+			if (ret !=3D sec[i].sh_size)
+				err(1, "Reading symbol table");
+			nsyms =3D sec[i].sh_size / sizeof(Elf64_Sym);
+
+
+			/* symtab links to strtab. We use it to find symbol
+			 * names */
+			strtab =3D malloc(sec[sec[i].sh_link].sh_size);
+			if (!strtab)
+				err(1,"Not enough memory for string table");
+			ret =3D lseek(elf_fd, sec[sec[i].sh_link].sh_offset , SEEK_SET);
+			if (ret < 0)
+				err(1, "Seeking to string table");
+			ret =3D read(elf_fd, strtab, sec[sec[i].sh_link].sh_size);
+			if (ret !=3D sec[sec[i].sh_link].sh_size)
+				err(1, "Reading string table");
+			break;
+		}
+	}
+
+	/* We now have a pointer to the symtab, start searching for the symbol */
+	for (i =3D 0; i < nsyms; i++) {
+		if ((syms[i].st_shndx =3D=3D SHN_UNDEF) || !syms[i].st_name)
+			continue;
+		if (!strcmp("boot_level4_pgt",
+				(char *)((u64)syms[i].st_name + strtab))) {
+			*pgdir_addr =3D syms[i].st_value - *page_offset;
+			break;
+		}
+	}
+
+	if (!*pgdir_addr)
+		err(1,"Unable to find boot pgdir");
+
+	*ird_size =3D load_initrd(initrd, mem);
+
+	/* Entry is physical address: convert to virtual */
+	printf("entry=3D%lx page_offset=3D%lx  entry+page_offset=3D%lx\n",
+	       ehdr->e_entry, *page_offset, ehdr->e_entry + *page_offset);
+	return ehdr->e_entry + *page_offset;
+}
+
+static unsigned long intuit_page_offset(unsigned char *img, unsigned long =
len)
+{
+	unsigned int i, possibilities[256];
+
+	for (i =3D 0; i + 4 < len; i++) {
+		/* mov 0xXXXXXXXX,%eax */
+		if (img[i] =3D=3D 0xA1 && ++possibilities[img[i+4]] > 3)
+			return (unsigned long)img[i+4] << 24;
+	}
+	errx(1, "could not determine page offset");
+}
+
+static u64 bzimage(int fd, unsigned long mem, unsigned long *pgdir_addr,
+		   const char *initrd, unsigned long *ird_size,
+		   u64 *page_offset)
+{
+	gzFile f;
+	int ret, len =3D 0;
+	void *img =3D (void *)0x100000;
+
+	map_memory(mem);
+
+	f =3D gzdopen(fd, "rb");
+	if (gzdirect(f))
+		errx(1, "did not find correct gzip header");
+	while ((ret =3D gzread(f, img + len, 65536)) > 0)
+		len +=3D ret;
+	if (ret < 0)
+		err(1, "reading image from bzImage");
+
+	verbose("Unpacked size %i addr %p\n", len, img);
+	*page_offset =3D intuit_page_offset(img, len);
+//	*pgdir_addr =3D finish(mem, page_offset, initrd, ird_size);
+
+	/* Entry is physical address: convert to virtual */
+	return (u64)img + *page_offset;
+}
+
+static u64 load_bzimage(int bzimage_fd, const Elf64_Ehdr *ehdr,
+			unsigned long mem, unsigned long *pgdir_addr,
+			const char *initrd, unsigned long *ird_size,
+			u64 *page_offset)
+{
+	unsigned char c;
+	int state =3D 0;
+
+	/* Just brute force it. */
+	while (read(bzimage_fd, &c, 1) =3D=3D 1) {
+		switch (state) {
+		case 0:
+			if (c =3D=3D 0x1F)
+				state++;
+			break;
+		case 1:
+			if (c =3D=3D 0x8B)
+				state++;
+			else
+				state =3D 0;
+			break;
+		case 2 ... 8:
+			state++;
+			break;
+		case 9:
+			lseek(bzimage_fd, -10, SEEK_CUR);
+			if (c !=3D 0x03) /* Compressed under UNIX. */
+				state =3D -1;
+			else
+				return bzimage(bzimage_fd, mem, pgdir_addr,
+					       initrd, ird_size, page_offset);
+		}
+	}
+	errx(1, "Could not find kernel in bzImage");
+}
+
+static void *map_pages(unsigned long addr, unsigned int num)
+{
+	if (mmap((void *)addr, getpagesize() * num,
+		 PROT_READ|PROT_WRITE|PROT_EXEC,
+		 MAP_FIXED|MAP_PRIVATE, zero_fd, 0) !=3D (void *)addr)
+		err(1, "Mmaping %u pages of /dev/zero @%p", num, (void *)addr);
+	return (void *)addr;
+}
+
+static struct lguest_device_desc *
+get_dev_entry(struct lguest_device_desc *descs, u16 type, u16 num_pages)
+{
+	static unsigned long top =3D LGUEST_GUEST_TOP;
+	int i;
+	unsigned long pfn =3D 0;
+
+	if (num_pages) {
+		top -=3D num_pages*getpagesize();
+		map_pages(top, num_pages);
+		pfn =3D top / getpagesize();
+	}
+
+	for (i =3D 0; i < LGUEST_MAX_DEVICES; i++) {
+		if (!descs[i].type) {
+			descs[i].features =3D descs[i].status =3D 0;
+			descs[i].type =3D type;
+			descs[i].num_pages =3D num_pages;
+			descs[i].pfn =3D pfn;
+			return &descs[i];
+		}
+	}
+	errx(1, "too many devices");
+}
+
+static void set_fd(int fd, struct devices *devices)
+{
+	FD_SET(fd, &devices->infds);
+	if (fd > devices->max_infd)
+		devices->max_infd =3D fd;
+}
+
+static struct device *new_device(struct devices *devices,
+				 struct lguest_device_desc *descs,
+				 u16 type, u16 num_pages,
+				 int fd,
+				 int (*handle_input)(int, struct device *),
+				 unsigned long watch_off,
+				 u64 (*handle_output)(int,
+						      const struct iovec *,
+						      unsigned,
+						      struct device *))
+{
+	struct device *dev =3D malloc(sizeof(*dev));
+
+	dev->next =3D devices->dev;
+	devices->dev =3D dev;
+
+	dev->fd =3D fd;
+	if (handle_input)
+		set_fd(dev->fd, devices);
+	dev->desc =3D get_dev_entry(descs, type, num_pages);
+	dev->mem =3D (void *)(dev->desc->pfn * getpagesize());
+	dev->handle_input =3D handle_input;
+	dev->watch_address =3D (unsigned long)dev->mem + watch_off;
+	dev->handle_output =3D handle_output;
+	return dev;
+}
+
+#define DEVNAME "/dev/lguest"
+
+static int tell_kernel(u64 pagelimit, u64 pgdir, u64 start, u64 page_offse=
t)
+{
+	u64 args[] =3D { LHREQ_INITIALIZE,
+		       pagelimit, pgdir, start, page_offset };
+	int fd;
+
+	fd =3D open(DEVNAME, O_RDWR);
+	if (fd < 0)
+		err(1, "Opening %s", DEVNAME);
+
+	verbose("Telling kernel limit %lu, pgdir %li, e=3D%#08lx page_off=3D0x%08=
lx\n",
+		pagelimit, pgdir, start, page_offset);
+	if (write(fd, args, sizeof(args)) < 0)
+		err(1, "Writing to /dev/lguest");
+	return fd;
+}
+
+static void concat(char *dst, char *args[])
+{
+	unsigned int i, len =3D 0;
+
+	for (i =3D 0; args[i]; i++) {
+		strcpy(dst+len, args[i]);
+		strcat(dst+len, " ");
+		len +=3D strlen(args[i]) + 1;
+	}
+	/* In case it's empty. */
+	dst[len] =3D '\0';
+}
+
+static void *_check_pointer(unsigned long addr, unsigned int size,
+			    unsigned int line)
+{
+	if (addr >=3D LGUEST_GUEST_TOP || addr + size >=3D LGUEST_GUEST_TOP)
+		errx(1, "%s:%i: Invalid address %li", __FILE__, line, addr);
+	return (void *)addr;
+}
+#define check_pointer(addr,size) _check_pointer(addr, size, __LINE__)
+
+/* Returns pointer to dma->used_len */
+static u64 *dma2iov(unsigned long dma, struct iovec iov[], unsigned *num)
+{
+	unsigned int i;
+	struct lguest_dma *udma;
+
+	/* No buffers? */
+	if (dma =3D=3D 0) {
+		printf("no buffers\n");
+		return NULL;
+	}
+
+	udma =3D check_pointer(dma, sizeof(*udma));
+	for (i =3D 0; i < LGUEST_MAX_DMA_SECTIONS; i++) {
+		if (!udma->len[i])
+			break;
+
+		iov[i].iov_base =3D check_pointer(udma->addr[i], udma->len[i]);
+		iov[i].iov_len =3D udma->len[i];
+	}
+	*num =3D i;
+	return &udma->used_len;
+}
+
+static u64 *get_dma_buffer(int fd, void *addr,
+			   struct iovec iov[], unsigned *num, u32 *irq)
+{
+	u64 buf[] =3D { LHREQ_GETDMA, (u64)addr };
+	unsigned long udma;
+	u64 *res;
+
+	udma =3D write(fd, buf, sizeof(buf));
+	if (udma =3D=3D (unsigned long)-1)
+		return NULL;
+
+	/* Kernel stashes irq in ->used_len. */
+	res =3D dma2iov(udma, iov, num);
+	if (res)
+		*irq =3D *res;
+	return res;
+}
+
+static void trigger_irq(int fd, u32 irq)
+{
+	u64 buf[] =3D { LHREQ_IRQ, irq };
+	if (write(fd, buf, sizeof(buf)) !=3D 0)
+		err(1, "Triggering irq %i", irq);
+}
+
+static struct termios orig_term;
+static void restore_term(void)
+{
+	tcsetattr(STDIN_FILENO, TCSANOW, &orig_term);
+}
+
+struct console_abort
+{
+	int count;
+	struct timeval start;
+};
+
+/* We DMA input to buffer bound at start of console page. */
+static int handle_console_input(int fd, struct device *dev)
+{
+	u32 num, irq =3D 0;
+	u64 *lenp;
+	int len;
+	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
+	struct console_abort *abort =3D dev->priv;
+
+	lenp =3D get_dma_buffer(fd, dev->mem, iov, &num, &irq);
+	if (!lenp) {
+		warn("console: no dma buffer!");
+		iov[0] =3D discard_iov;
+		num =3D 1;
+	}
+
+	len =3D readv(dev->fd, iov, num);
+	if (len <=3D 0) {
+		warnx("Failed to get console input, ignoring console.");
+		len =3D 0;
+	}
+
+	if (lenp) {
+		*lenp =3D len;
+		trigger_irq(fd, irq);
+	}
+
+	/* Three ^C within one second?  Exit. */
+	if (len =3D=3D 1 && ((char *)iov[0].iov_base)[0] =3D=3D 3) {
+		if (!abort->count++)
+			gettimeofday(&abort->start, NULL);
+		else if (abort->count =3D=3D 3) {
+			struct timeval now;
+			gettimeofday(&now, NULL);
+			if (now.tv_sec <=3D abort->start.tv_sec+1)
+				exit(2);
+			abort->count =3D 0;
+		}
+	} else
+		abort->count =3D 0;
+
+	if (!len) {
+		restore_term();
+		return 0;
+	}
+	return 1;
+}
+
+static unsigned long peer_offset(unsigned int peernum)
+{
+	return 4 * peernum;
+}
+
+static u64 handle_tun_output(int fd, const struct iovec *iov,
+			     unsigned num, struct device *dev)
+{
+	/* Now we've seen output, we should warn if we can't get buffers. */
+	*(bool *)dev->priv =3D true;
+	return writev(dev->fd, iov, num);
+}
+
+static u64 handle_block_output(int fd, const struct iovec *iov,
+			       unsigned num, struct device *dev)
+{
+	struct lguest_block_page *p =3D dev->mem;
+	u32 irq, reply_num;
+	u64 *lenp;
+	int len;
+	struct iovec reply[LGUEST_MAX_DMA_SECTIONS];
+	off64_t device_len, off =3D (off64_t)p->sector * 512;
+
+	device_len =3D *(off64_t *)dev->priv;
+
+	if (off >=3D device_len)
+		err(1, "Bad offset %lu vs %lu", off, device_len);
+	if (lseek64(dev->fd, off, SEEK_SET) !=3D off)
+		err(1, "Bad seek to sector %i", p->sector);
+
+	verbose("Block: %s at offset %lu\n", p->type ? "WRITE" : "READ", off);
+
+	lenp =3D get_dma_buffer(fd, dev->mem, reply, &reply_num, &irq);
+	if (!lenp)
+		err(1, "Block request didn't give us a dma buffer");
+
+	if (p->type) {
+		len =3D writev(dev->fd, iov, num);
+		if (off + len > device_len) {
+			ftruncate(dev->fd, device_len);
+			errx(1, "Write past end %lu+%u", off, len);
+		}
+		*lenp =3D 0;
+	} else {
+		len =3D readv(dev->fd, reply, reply_num);
+		*lenp =3D len;
+	}
+
+	p->result =3D 1 + (p->bytes !=3D len);
+	trigger_irq(fd, irq);
+	return 0;
+}
+
+#define HIPQUAD(ip)				\
+	((u8)(ip >> 24)),			\
+	((u8)(ip >> 16)),			\
+	((u8)(ip >> 8)),			\
+	((u8)(ip))
+
+static void configure_device(const char *devname, u64 ipaddr,
+			     unsigned char hwaddr[6])
+{
+	struct ifreq ifr;
+	int fd;
+	struct sockaddr_in *sin =3D (struct sockaddr_in *)&ifr.ifr_addr;
+
+	memset(&ifr, 0, sizeof(ifr));
+	strcpy(ifr.ifr_name, devname);
+	sin->sin_family =3D AF_INET;
+	sin->sin_addr.s_addr =3D htonl(ipaddr);
+	fd =3D socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
+	if (fd < 0)
+		err(1, "opening IP socket");
+	if (ioctl(fd, SIOCSIFADDR, &ifr) !=3D 0)
+		err(1, "Setting %s interface address", devname);
+	ifr.ifr_flags =3D IFF_UP;
+	if (ioctl(fd, SIOCSIFFLAGS, &ifr) !=3D 0)
+		err(1, "Bringing interface %s up", devname);
+
+	if (ioctl(fd, SIOCGIFHWADDR, &ifr) !=3D 0)
+		err(1, "getting hw address for %s", devname);
+
+	memcpy(hwaddr, ifr.ifr_hwaddr.sa_data, 6);
+}
+
+/* We send lguest_add signals while input is pending: avoids races. */
+static void wake_parent(int pipefd, struct devices *devices)
+{
+	int parent =3D getppid();
+	nice(19);
+
+	set_fd(pipefd, devices);
+
+	for (;;) {
+		fd_set rfds =3D devices->infds;
+
+		select(devices->max_infd+1, &rfds, NULL, NULL, NULL);
+		if (FD_ISSET(pipefd, &rfds)) {
+			int ignorefd;
+			if (read(pipefd, &ignorefd, sizeof(ignorefd)) =3D=3D 0)
+				exit(0);
+			FD_CLR(ignorefd, &devices->infds);
+		}
+		kill(parent, SIGUSR1);
+	}
+}
+
+/* We don't want signal to kill us, just jerk us out of kernel. */
+static void wakeup(int signo)
+{
+}
+
+static int handle_tun_input(int fd, struct device *dev)
+{
+	u32 irq =3D 0, num;
+	u64 *lenp;
+	int len;
+	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
+
+	lenp =3D get_dma_buffer(fd, dev->mem+peer_offset(NET_PEERNUM), iov, &num,
+			      &irq);
+	if (!lenp) {
+		if (*(bool *)dev->priv)
+			warn("network: no dma buffer!");
+		iov[0] =3D discard_iov;
+		num =3D 1;
+	}
+
+	len =3D readv(dev->fd, iov, num);
+	if (len <=3D 0)
+		err(1, "reading network");
+	if (lenp) {
+		*lenp =3D len;
+		trigger_irq(fd, irq);
+	}
+	verbose("tun input packet len %i [%02x %02x] (%s)\n", len,
+		((u8 *)iov[0].iov_base)[0], ((u8 *)iov[0].iov_base)[1],
+		lenp ? "sent" : "discarded");
+	return 1;
+}
+
+/* We use fnctl locks to reserve network slots (autocleanup!) */
+static unsigned int find_slot(int netfd, const char *filename)
+{
+	struct flock fl;
+
+	fl.l_type =3D F_WRLCK;
+	fl.l_whence =3D SEEK_SET;
+	fl.l_len =3D 1;
+	for (fl.l_start =3D 0;
+	     fl.l_start < getpagesize()/sizeof(struct lguest_net);
+	     fl.l_start++) {
+		if (fcntl(netfd, F_SETLK, &fl) =3D=3D 0)
+			return fl.l_start;
+	}
+	errx(1, "No free slots in network file %s", filename);
+}
+
+static void setup_net_file(const char *filename,
+			   struct lguest_device_desc *descs,
+			   struct devices *devices)
+{
+	int netfd;
+	struct device *dev;
+
+	netfd =3D open(filename, O_RDWR, 0);
+	if (netfd < 0) {
+		if (errno =3D=3D ENOENT) {
+			netfd =3D open(filename, O_RDWR|O_CREAT, 0600);
+			if (netfd >=3D 0) {
+				char page[getpagesize()];
+				/* 0xFFFF =3D=3D NO_GUEST */
+				memset(page, 0xFF, sizeof(page));
+				write(netfd, page, sizeof(page));
+			}
+		}
+		if (netfd < 0)
+			err(1, "cannot open net file '%s'", filename);
+	}
+
+	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_NET, 1,
+			 -1, NULL, 0, NULL);
+
+	/* This is the slot for the guest to use. */
+	dev->desc->features =3D find_slot(netfd, filename)|LGUEST_NET_F_NOCSUM;
+	/* We overwrite the /dev/zero mapping with the actual file. */
+	if (mmap(dev->mem, getpagesize(), PROT_READ|PROT_WRITE,
+			 MAP_FIXED|MAP_SHARED, netfd, 0) !=3D dev->mem)
+			err(1, "could not mmap '%s'", filename);
+	verbose("device %p@%p: shared net %s, peer %i\n", dev->desc,
+		(void *)(dev->desc->pfn * getpagesize()), filename,
+		dev->desc->features & ~LGUEST_NET_F_NOCSUM);
+}
+
+static u64 str2ip(const char *ipaddr)
+{
+	unsigned int byte[4];
+
+	sscanf(ipaddr, "%u.%u.%u.%u", &byte[0], &byte[1], &byte[2], &byte[3]);
+	return (byte[0] << 24) | (byte[1] << 16) | (byte[2] << 8) | byte[3];
+}
+
+static void setup_tun_net(const char *ipaddr,
+			  struct lguest_device_desc *descs,
+			  struct devices *devices)
+{
+	struct device *dev;
+	struct ifreq ifr;
+	int netfd;
+
+	netfd =3D open("/dev/net/tun", O_RDWR);
+	if (netfd < 0)
+		err(1, "opening /dev/net/tun");
+
+	memset(&ifr, 0, sizeof(ifr));
+	ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI;
+	strcpy(ifr.ifr_name, "tap%d");
+	if (ioctl(netfd, TUNSETIFF, &ifr) !=3D 0)
+		err(1, "configuring /dev/net/tun");
+
+	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_NET, 1,
+			 netfd, handle_tun_input,
+			 peer_offset(0), handle_tun_output);
+	dev->priv =3D malloc(sizeof(bool));
+	*(bool *)dev->priv =3D false;
+
+	/* We are peer 0, rest is all NO_GUEST */
+	memset(dev->mem, 0xFF, getpagesize());
+	configure_device(ifr.ifr_name, str2ip(ipaddr), dev->mem);
+
+	/* You will be peer 1: we should create enough jitter to randomize */
+	dev->desc->features =3D NET_PEERNUM|LGUEST_DEVICE_F_RANDOMNESS;
+	verbose("device %p@%p: tun net %u.%u.%u.%u\n", dev->desc,
+		(void *)(dev->desc->pfn * getpagesize()),
+		HIPQUAD(str2ip(ipaddr)));
+}
+
+static void setup_block_file(const char *filename,
+			     struct lguest_device_desc *descs,
+			     struct devices *devices)
+{
+	int fd;
+	struct device *dev;
+	off64_t *blocksize;
+	struct lguest_block_page *p;
+
+	fd =3D open(filename, O_RDWR|O_LARGEFILE|O_DIRECT, 0);
+	if (fd < 0)
+		err(1, "Opening %s", filename);
+
+	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_BLOCK, 1,
+			 fd, NULL, 0, handle_block_output);
+	dev->desc->features =3D LGUEST_DEVICE_F_RANDOMNESS;
+	blocksize =3D dev->priv =3D malloc(sizeof(*blocksize));
+	*blocksize =3D lseek64(fd, 0, SEEK_END);
+	p =3D dev->mem;
+
+	p->num_sectors =3D *blocksize/512;
+	verbose("device %p@%p: block %i sectors\n", dev->desc,
+		(void *)(dev->desc->pfn * getpagesize()), p->num_sectors);
+}
+
+static u64 handle_console_output(int fd, const struct iovec *iov,
+				 unsigned num, struct device*dev)
+{
+	return writev(STDOUT_FILENO, iov, num);
+}
+
+static void setup_console(struct lguest_device_desc *descs,
+			  struct devices *devices)
+{
+	struct device *dev;
+
+	if (tcgetattr(STDIN_FILENO, &orig_term) =3D=3D 0) {
+		struct termios term =3D orig_term;
+		term.c_lflag &=3D ~(ISIG|ICANON|ECHO);
+		tcsetattr(STDIN_FILENO, TCSANOW, &term);
+		atexit(restore_term);
+	}
+
+	/* We don't currently require a page for the console. */
+	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_CONSOLE, 0,
+			 STDIN_FILENO, handle_console_input,
+			 4, handle_console_output);
+	dev->priv =3D malloc(sizeof(struct console_abort));
+	((struct console_abort *)dev->priv)->count =3D 0;
+	verbose("device %p@%p: console\n", dev->desc,
+		(void *)(dev->desc->pfn * getpagesize()));
+}
+
+static const char *get_arg(const char *arg, const char *prefix)
+{
+	if (strncmp(arg, prefix, strlen(prefix)) =3D=3D 0)
+		return arg + strlen(prefix);
+	return NULL;
+}
+
+static u32 handle_device(int fd, unsigned long dma, unsigned long addr,
+			 struct devices *devices)
+{
+	struct device *i;
+	u64 *lenp;
+	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
+	unsigned num =3D 0;
+
+	lenp =3D dma2iov(dma, iov, &num);
+	if (!lenp)
+		errx(1, "Bad SEND_DMA %li for address %#lx\n", dma, addr);
+
+	for (i =3D devices->dev; i; i =3D i->next) {
+		if (i->handle_output && addr =3D=3D i->watch_address) {
+			*lenp =3D i->handle_output(fd, iov, num, i);
+			return 0;
+		}
+	}
+	warnx("Pending dma %p, addr %p", (void *)dma, (void *)addr);
+	return 0;
+}
+
+static void handle_input(int fd, int childfd, struct devices *devices)
+{
+	struct timeval poll =3D { .tv_sec =3D 0, .tv_usec =3D 0 };
+
+	for (;;) {
+		struct device *i;
+		fd_set fds =3D devices->infds;
+
+		if (select(devices->max_infd+1, &fds, NULL, NULL, &poll) =3D=3D 0)
+			break;
+
+		for (i =3D devices->dev; i; i =3D i->next) {
+			if (i->handle_input && FD_ISSET(i->fd, &fds)) {
+				if (!i->handle_input(fd, i)) {
+					FD_CLR(i->fd, &devices->infds);
+					/* Tell child to ignore it too... */
+					write(childfd, &i->fd, sizeof(i->fd));
+				}
+			}
+		}
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long mem, pgdir, entry, initrd_size, page_offset;
+	int arg, kern_fd, fd, child, pipefd[2];
+	Elf64_Ehdr hdr;
+	struct sigaction act;
+	sigset_t sigset;
+	struct lguest_device_desc *devdescs;
+	struct devices devices;
+	struct lguest_boot_info *boot =3D (void *)0;
+	const char *initrd_name =3D NULL;
+	u64 (*load)(int, const Elf64_Ehdr *ehdr, unsigned long,
+		    unsigned long *, const char *, unsigned long *,
+		    u64 *);
+
+	if (argv[1] && strcmp(argv[1], "--verbose") =3D=3D 0) {
+		verbose =3D true;
+		argv++;
+		argc--;
+	}
+
+	if (argc < 3)
+		errx(1, "Usage: lguest [--verbose] <mem> vmlinux "
+			"[--sharenet=3D<filename>|--tunnet=3D<ipaddr>|--block=3D<filename>"
+			"|--initrd=3D<filename>]... [args...]");
+
+	zero_fd =3D open("/dev/zero", O_RDONLY, 0);
+	if (zero_fd < 0)
+		err(1, "Opening /dev/zero");
+
+	mem =3D memparse(argv[1]);
+	kern_fd =3D open(argv[2], O_RDONLY, 0);
+	if (kern_fd < 0)
+		err(1, "Opening %s", argv[2]);
+
+	if (read(kern_fd, &hdr, sizeof(hdr)) !=3D sizeof(hdr))
+		err(1, "Reading %s elf header", argv[2]);
+
+	if (memcmp(hdr.e_ident, ELFMAG, SELFMAG) =3D=3D 0)
+		load =3D map_elf;
+	else
+		load =3D load_bzimage;
+
+	devices.max_infd =3D -1;
+	devices.dev =3D NULL;
+	FD_ZERO(&devices.infds);
+
+	devdescs =3D map_pages(mem, 1);
+	arg =3D 3;
+	while (argv[arg] && argv[arg][0] =3D=3D '-') {
+		const char *argval;
+
+		if ((argval =3D get_arg(argv[arg], "--sharenet=3D")) !=3D NULL)
+			setup_net_file(argval, devdescs, &devices);
+		else if ((argval =3D get_arg(argv[arg], "--tunnet=3D")) !=3D NULL)
+			setup_tun_net(argval, devdescs, &devices);
+		else if ((argval =3D get_arg(argv[arg], "--block=3D")) !=3D NULL)
+			setup_block_file(argval, devdescs, &devices);
+		else if ((argval =3D get_arg(argv[arg], "--initrd=3D")) !=3D NULL)
+			initrd_name =3D argval;
+		else
+			errx(1, "unknown arg '%s'", argv[arg]);
+		arg++;
+	}
+
+	entry =3D load(kern_fd, &hdr, mem, &pgdir, initrd_name, &initrd_size,
+		     &page_offset);
+	setup_console(devdescs, &devices);
+
+	concat(boot->cmdline, argv+arg);
+	boot->max_pfn =3D mem/getpagesize();
+	boot->initrd_size =3D initrd_size;
+
+	act.sa_handler =3D wakeup;
+	sigemptyset(&act.sa_mask);
+	act.sa_flags =3D 0;
+	sigaction(SIGUSR1, &act, NULL);
+
+	pipe(pipefd);
+	child =3D fork();
+	if (child =3D=3D -1)
+		err(1, "forking");
+
+	if (child =3D=3D 0) {
+		close(pipefd[1]);
+		wake_parent(pipefd[0], &devices);
+	}
+	close(pipefd[0]);
+
+	sigemptyset(&sigset);
+	sigaddset(&sigset, SIGUSR1);
+	sigprocmask(SIG_BLOCK, &sigset, NULL);
+
+	/* LGUEST_GUEST_TOP defined in Makefile, just below us. */
+	fd =3D tell_kernel(LGUEST_GUEST_TOP/getpagesize(),
+			 pgdir, entry, page_offset);
+
+	for (;;) {
+		unsigned long arr[2];
+		int readval;
+
+		sigprocmask(SIG_UNBLOCK, &sigset, NULL);
+		readval =3D read(fd, arr, sizeof(arr));
+		sigprocmask(SIG_BLOCK, &sigset, NULL);
+
+		switch (readval) {
+		case sizeof(arr):
+			handle_device(fd, arr[0], arr[1], &devices);
+			break;
+		case -1:
+			if (errno =3D=3D EINTR)
+				break;
+		default:
+			if (errno =3D=3D ENOENT) {
+				char reason[1024];
+				if (read(fd, reason, sizeof(reason)) > 0)
+					errx(1, "%s", reason);
+			}
+			err(1, "Running guest failed");
+		}
+		handle_input(fd, pipefd[1], &devices);
+	}
+}
Index: work-pv/Documentation/lguest/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/Documentation/lguest/Makefile
+++ /dev/null
@@ -1,21 +0,0 @@
-# This creates the demonstration utility "lguest" which runs a Linux guest.
-
-# We rely on CONFIG_PAGE_OFFSET to know where to put lguest binary.
-# Some shells (dash - ubunu) can't handle numbers that big so we cheat.
-include ../../.config
-LGUEST_GUEST_TOP :=3D ($(CONFIG_PAGE_OFFSET) - 0x08000000)
-
-CFLAGS:=3D-Wall -Wmissing-declarations -Wmissing-prototypes -O3 \
-	-static -DLGUEST_GUEST_TOP=3D"$(LGUEST_GUEST_TOP)" -Wl,-T,lguest.lds
-LDLIBS:=3D-lz
-
-all: lguest.lds lguest
-
-# The linker script on x86 is so complex the only way of creating one
-# which will link our binary in the right place is to mangle the
-# default one.
-lguest.lds:
-	$(LD) --verbose | awk '/^=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/ { PRINT=3D1; nex=
t; } /SIZEOF_HEADERS/ { gsub(/0x[0-9A-F]*/, "$(LGUEST_GUEST_TOP)") } { if (=
PRINT) print $$0; }' > $@
-
-clean:
-	rm -f lguest.lds lguest
Index: work-pv/Documentation/lguest/lguest.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- work-pv.orig/Documentation/lguest/lguest.c
+++ /dev/null
@@ -1,1039 +0,0 @@
-/* Simple program to layout "physical" memory for new lguest guest.
- * Linked high to avoid likely physical memory.  */
-#define _LARGEFILE64_SOURCE
-#define _GNU_SOURCE
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <err.h>
-#include <stdint.h>
-#include <stdlib.h>
-#include <elf.h>
-#include <sys/mman.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <fcntl.h>
-#include <assert.h>
-#include <stdbool.h>
-#include <errno.h>
-#include <signal.h>
-#include <sys/socket.h>
-#include <sys/ioctl.h>
-#include <sys/time.h>
-#include <time.h>
-#include <netinet/in.h>
-#include <net/if.h>
-#include <linux/sockios.h>
-#include <linux/if_tun.h>
-#include <sys/uio.h>
-#include <termios.h>
-#include <zlib.h>
-typedef uint32_t u32;
-typedef uint16_t u16;
-typedef uint8_t u8;
-
-#include "../../include/asm/lguest_user.h"
-
-#define PAGE_PRESENT 0x7 	/* Present, RW, Execute */
-#define NET_PEERNUM 1
-#define BRIDGE_PFX "bridge:"
-
-static bool verbose;
-#define verbose(args...) \
-	do { if (verbose) printf(args); fflush(stdout); } while(0)
-
-struct devices
-{
-	fd_set infds;
-	int max_infd;
-
-	struct device *dev;
-};
-
-struct device
-{
-	struct device *next;
-	struct lguest_device_desc *desc;
-	void *mem;
-
-	/* Watch this fd if handle_input non-NULL. */
-	int fd;
-	int (*handle_input)(int fd, struct device *me);
-
-	/* Watch DMA to this address if handle_input non-NULL. */
-	unsigned long watch_address;
-	u32 (*handle_output)(int fd, const struct iovec *iov,
-			     unsigned int num, struct device *me);
-
-	/* Device-specific data. */
-	void *priv;
-};
-
-static char buf[1024];
-static struct iovec discard_iov =3D { .iov_base=3Dbuf, .iov_len=3Dsizeof(b=
uf) };
-static int zero_fd;
-
-/* LGUEST_GUEST_TOP defined in Makefile, just below us.
-   FIXME: vdso gets mapped just under it, and we need to protect that. */
-#define RESERVE_TOP LGUEST_GUEST_TOP - 1024*1024
-
-static u32 memparse(const char *ptr)
-{
-	char *end;
-	unsigned long ret =3D strtoul(ptr, &end, 0);
-
-	switch (*end) {
-	case 'G':
-	case 'g':
-		ret <<=3D 10;
-	case 'M':
-	case 'm':
-		ret <<=3D 10;
-	case 'K':
-	case 'k':
-		ret <<=3D 10;
-		end++;
-	default:
-		break;
-	}
-	return ret;
-}
-
-static inline unsigned long page_align(unsigned long addr)
-{
-	return ((addr + getpagesize()-1) & ~(getpagesize()-1));
-}
-
-/* initrd gets loaded at top of memory: return length. */
-static unsigned long load_initrd(const char *name, unsigned long end)
-{
-	int ifd;
-	struct stat st;
-	void *iaddr;
-
-	if (!name)
-		return 0;
-
-	ifd =3D open(name, O_RDONLY, 0);
-	if (ifd < 0)
-		err(1, "Opening initrd '%s'", name);
-		=

-	if (fstat(ifd, &st) < 0)
-		err(1, "fstat() on initrd '%s'", name);
-
-	iaddr =3D mmap((void *)end - st.st_size, st.st_size,
-		     PROT_READ|PROT_EXEC|PROT_WRITE,
-		     MAP_FIXED|MAP_PRIVATE, ifd, 0);
-	if (iaddr !=3D (void *)end - st.st_size)
-		err(1, "Mmaping initrd '%s' returned %p not %p",
-		    name, iaddr, (void *)end - st.st_size);
-	close(ifd);
-	verbose("mapped initrd %s size=3D%lu @ %p\n", name, st.st_size, iaddr);
-	return st.st_size;
-}
-
-/* First map /dev/zero over entire memory, then insert kernel. */
-static void map_memory(unsigned long mem)
-{
-	if (mmap(0, mem,
-		 PROT_READ|PROT_WRITE|PROT_EXEC,
-		 MAP_FIXED|MAP_PRIVATE, zero_fd, 0) !=3D (void *)0)
-		err(1, "Mmaping /dev/zero for %li bytes", mem);
-}
-
-static u32 finish(unsigned long mem, unsigned long *page_offset,
-		  const char *initrd, unsigned long *ird_size)
-{
-	u32 *pgdir =3D NULL, *linear =3D NULL;
-	int i, pte_pages;
-
-	/* This is a top of mem. */
-	*ird_size =3D load_initrd(initrd, mem);
-
-	/* Below initrd is used as top level of pagetable. */
-	pte_pages =3D 1 + (mem/getpagesize() + 1023)/1024;
-
-	pgdir =3D (u32 *)page_align(mem - *ird_size - pte_pages*getpagesize());
-	linear =3D (void *)pgdir + getpagesize();
-
-	/* Linear map all of memory at page_offset (to top of mem). */
-	if (mem > -*page_offset)
-		mem =3D -*page_offset;
-
-	for (i =3D 0; i < mem / getpagesize(); i++)
-		linear[i] =3D ((i * getpagesize()) | PAGE_PRESENT);
-	verbose("Linear %p-%p (%i-%i) =3D %#08x-%#08x\n",
-		linear, linear+i-1, 0, i-1, linear[0], linear[i-1]);
-
-	/* Now set up pgd so that this memory is at page_offset */
-	for (i =3D 0; i < mem / getpagesize(); i +=3D getpagesize()/sizeof(u32)) {
-		pgdir[(i + *page_offset/getpagesize())/1024] =

-			=3D (((u32)linear + i*sizeof(u32)) | PAGE_PRESENT);
-		verbose("Top level %lu =3D %#08x\n",
-			(i + *page_offset/getpagesize())/1024,
-			pgdir[(i + *page_offset/getpagesize())/1024]);
-	}
-
-	return (unsigned long)pgdir;
-}
-
-/* Returns the entry point */
-static u32 map_elf(int elf_fd, const Elf32_Ehdr *ehdr, unsigned long mem,
-		   unsigned long *pgdir_addr,
-		   const char *initrd, unsigned long *ird_size,
-		   unsigned long *page_offset)
-{
-	void *addr;
-	Elf32_Phdr phdr[ehdr->e_phnum];
-	unsigned int i;
-
-	/* Sanity checks. */
-	if (ehdr->e_type !=3D ET_EXEC
-	    || ehdr->e_machine !=3D EM_386
-	    || ehdr->e_phentsize !=3D sizeof(Elf32_Phdr)
-	    || ehdr->e_phnum < 1 || ehdr->e_phnum > 65536U/sizeof(Elf32_Phdr))
-		errx(1, "Malformed elf header");
-
-	if (lseek(elf_fd, ehdr->e_phoff, SEEK_SET) < 0)
-		err(1, "Seeking to program headers");
-	if (read(elf_fd, phdr, sizeof(phdr)) !=3D sizeof(phdr))
-		err(1, "Reading program headers");
-
-	map_memory(mem);
-
-	*page_offset =3D 0;
-	/* We map the loadable segments at virtual addresses corresponding
-	 * to their physical addresses (our virtual =3D=3D guest physical). */
-	for (i =3D 0; i < ehdr->e_phnum; i++) {
-		if (phdr[i].p_type !=3D PT_LOAD)
-			continue;
-
-		verbose("Section %i: size %i addr %p\n",
-			i, phdr[i].p_memsz, (void *)phdr[i].p_paddr);
-		/* We map everything private, writable. */
-		if (phdr[i].p_paddr + phdr[i].p_memsz > mem)
-			errx(1, "Segment %i overlaps end of memory", i);
-
-		/* We expect linear address space. */
-		if (!*page_offset)
-			*page_offset =3D phdr[i].p_vaddr - phdr[i].p_paddr;
-		else if (*page_offset !=3D phdr[i].p_vaddr - phdr[i].p_paddr)
-			errx(1, "Page offset of section %i different", i);
-
-		/* Recent ld versions don't page align any more. */
-		if (phdr[i].p_paddr % getpagesize()) {
-			phdr[i].p_filesz +=3D (phdr[i].p_paddr % getpagesize());
-			phdr[i].p_offset -=3D (phdr[i].p_paddr % getpagesize());
-			phdr[i].p_paddr -=3D (phdr[i].p_paddr % getpagesize());
-		}
-		addr =3D mmap((void *)phdr[i].p_paddr,
-			    phdr[i].p_filesz,
-			    PROT_READ|PROT_WRITE|PROT_EXEC,
-			    MAP_FIXED|MAP_PRIVATE,
-			    elf_fd, phdr[i].p_offset);
-		if (addr !=3D (void *)phdr[i].p_paddr)
-			err(1, "Mmaping vmlinux segment %i returned %p not %p (%p)",
-			    i, addr, (void *)phdr[i].p_paddr, &phdr[i].p_paddr);
-	}
-
-	*pgdir_addr =3D finish(mem, page_offset, initrd, ird_size);
-	/* Entry is physical address: convert to virtual */
-	return ehdr->e_entry + *page_offset;
-}
-
-static unsigned long intuit_page_offset(unsigned char *img, unsigned long =
len)
-{
-	unsigned int i, possibilities[256];
-
-	for (i =3D 0; i + 4 < len; i++) {
-		/* mov 0xXXXXXXXX,%eax */
-		if (img[i] =3D=3D 0xA1 && ++possibilities[img[i+4]] > 3)
-			return (unsigned long)img[i+4] << 24;
-	}
-	errx(1, "could not determine page offset");
-}
-
-static u32 bzimage(int fd, unsigned long mem, unsigned long *pgdir_addr,
-		   const char *initrd, unsigned long *ird_size,
-		   unsigned long *page_offset)
-{
-	gzFile f;
-	int ret, len =3D 0;
-	void *img =3D (void *)0x100000;
-
-	map_memory(mem);
-
-	f =3D gzdopen(fd, "rb");
-	if (gzdirect(f))
-		errx(1, "did not find correct gzip header");
-	while ((ret =3D gzread(f, img + len, 65536)) > 0)
-		len +=3D ret;
-	if (ret < 0)
-		err(1, "reading image from bzImage");
-
-	verbose("Unpacked size %i addr %p\n", len, img);
-	*page_offset =3D intuit_page_offset(img, len);
-	*pgdir_addr =3D finish(mem, page_offset, initrd, ird_size);
-
-	/* Entry is physical address: convert to virtual */
-	return (u32)img + *page_offset;
-}
-
-static u32 load_bzimage(int bzimage_fd, const Elf32_Ehdr *ehdr, =

-			unsigned long mem, unsigned long *pgdir_addr,
-			const char *initrd, unsigned long *ird_size,
-			unsigned long *page_offset)
-{
-	unsigned char c;
-	int state =3D 0;
-
-	/* Just brute force it. */
-	while (read(bzimage_fd, &c, 1) =3D=3D 1) {
-		switch (state) {
-		case 0:
-			if (c =3D=3D 0x1F)
-				state++;
-			break;
-		case 1:
-			if (c =3D=3D 0x8B)
-				state++;
-			else
-				state =3D 0;
-			break;
-		case 2 ... 8:
-			state++;
-			break;
-		case 9:
-			lseek(bzimage_fd, -10, SEEK_CUR);
-			if (c !=3D 0x03) /* Compressed under UNIX. */
-				state =3D -1;
-			else
-				return bzimage(bzimage_fd, mem, pgdir_addr,
-					       initrd, ird_size, page_offset);
-		}
-	}
-	errx(1, "Could not find kernel in bzImage");
-}
-
-static void *map_pages(unsigned long addr, unsigned int num)
-{
-	if (mmap((void *)addr, getpagesize() * num,
-		 PROT_READ|PROT_WRITE|PROT_EXEC,
-		 MAP_FIXED|MAP_PRIVATE, zero_fd, 0) !=3D (void *)addr)
-		err(1, "Mmaping %u pages of /dev/zero @%p", num, (void *)addr);
-	return (void *)addr;
-}
-
-static struct lguest_device_desc *
-get_dev_entry(struct lguest_device_desc *descs, u16 type, u16 num_pages)
-{
-	static unsigned long top =3D RESERVE_TOP;
-	int i;
-	unsigned long pfn =3D 0;
-
-	if (num_pages) {
-		top -=3D num_pages*getpagesize();
-		map_pages(top, num_pages);
-		pfn =3D top / getpagesize();
-	}
-
-	for (i =3D 0; i < LGUEST_MAX_DEVICES; i++) {
-		if (!descs[i].type) {
-			descs[i].features =3D descs[i].status =3D 0;
-			descs[i].type =3D type;
-			descs[i].num_pages =3D num_pages;
-			descs[i].pfn =3D pfn;
-			return &descs[i];
-		}
-	}
-	errx(1, "too many devices");
-}
-
-static void set_fd(int fd, struct devices *devices)
-{
-	FD_SET(fd, &devices->infds);
-	if (fd > devices->max_infd)
-		devices->max_infd =3D fd;
-}
-
-static struct device *new_device(struct devices *devices,
-				 struct lguest_device_desc *descs,
-				 u16 type, u16 num_pages,
-				 int fd,
-				 int (*handle_input)(int, struct device *),
-				 unsigned long watch_off,
-				 u32 (*handle_output)(int,
-						      const struct iovec *,
-						      unsigned,
-						      struct device *))
-{
-	struct device *dev =3D malloc(sizeof(*dev));
-
-	dev->next =3D devices->dev;
-	devices->dev =3D dev;
-
-	dev->fd =3D fd;
-	if (handle_input)
-		set_fd(dev->fd, devices);
-	dev->desc =3D get_dev_entry(descs, type, num_pages);
-	dev->mem =3D (void *)(dev->desc->pfn * getpagesize());
-	dev->handle_input =3D handle_input;
-	dev->watch_address =3D (unsigned long)dev->mem + watch_off;
-	dev->handle_output =3D handle_output;
-	return dev;
-}
-
-static int tell_kernel(u32 pagelimit, u32 pgdir, u32 start, u32 page_offse=
t)
-{
-	u32 args[] =3D { LHREQ_INITIALIZE,
-		       pagelimit, pgdir, start, page_offset };
-	int fd =3D open("/dev/lguest", O_RDWR);
-
-	if (fd < 0)
-		err(1, "Opening /dev/lguest");
-
-	verbose("Telling kernel limit %u, pgdir %i, e=3D%#08x page_off=3D0x%08x\n=
",
-		pagelimit, pgdir, start, page_offset);
-	if (write(fd, args, sizeof(args)) < 0)
-		err(1, "Writing to /dev/lguest");
-	return fd;
-}
-
-static void concat(char *dst, char *args[])
-{
-	unsigned int i, len =3D 0;
-
-	for (i =3D 0; args[i]; i++) {
-		strcpy(dst+len, args[i]);
-		strcat(dst+len, " ");
-		len +=3D strlen(args[i]) + 1;
-	}
-	/* In case it's empty. */
-	dst[len] =3D '\0';
-}
-
-static void *_check_pointer(unsigned long addr, unsigned int size,
-			    unsigned int line)
-{
-	if (addr >=3D RESERVE_TOP || addr + size >=3D RESERVE_TOP)
-		errx(1, "%s:%i: Invalid address %li", __FILE__, line, addr);
-	return (void *)addr;
-}
-#define check_pointer(addr,size) _check_pointer(addr, size, __LINE__)
-
-/* Returns pointer to dma->used_len */
-static u32 *dma2iov(unsigned long dma, struct iovec iov[], unsigned *num)
-{
-	unsigned int i;
-	struct lguest_dma *udma;
-
-	/* No buffers? */
-	if (dma =3D=3D 0) {
-		printf("no buffers\n");
-		return NULL;
-	}
-
-	udma =3D check_pointer(dma, sizeof(*udma));
-	for (i =3D 0; i < LGUEST_MAX_DMA_SECTIONS; i++) {
-		if (!udma->len[i])
-			break;
-
-		iov[i].iov_base =3D check_pointer(udma->addr[i], udma->len[i]);
-		iov[i].iov_len =3D udma->len[i];
-	}
-	*num =3D i;
-	return &udma->used_len;
-}
-
-static u32 *get_dma_buffer(int fd, void *addr,
-			   struct iovec iov[], unsigned *num, u32 *irq)
-{
-	u32 buf[] =3D { LHREQ_GETDMA, (u32)addr };
-	unsigned long udma;
-	u32 *res;
-
-	udma =3D write(fd, buf, sizeof(buf));
-	if (udma =3D=3D (unsigned long)-1)
-		return NULL;
-
-	/* Kernel stashes irq in ->used_len. */
-	res =3D dma2iov(udma, iov, num);
-	if (res)
-		*irq =3D *res;
-	return res;
-}
-
-static void trigger_irq(int fd, u32 irq)
-{
-	u32 buf[] =3D { LHREQ_IRQ, irq };
-	if (write(fd, buf, sizeof(buf)) !=3D 0)
-		err(1, "Triggering irq %i", irq);
-}
-
-static struct termios orig_term;
-static void restore_term(void)
-{
-	tcsetattr(STDIN_FILENO, TCSANOW, &orig_term);
-}
-
-struct console_abort
-{
-	int count;
-	struct timeval start;
-};
-
-/* We DMA input to buffer bound at start of console page. */
-static int handle_console_input(int fd, struct device *dev)
-{
-	u32 num, irq =3D 0, *lenp;
-	int len;
-	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
-	struct console_abort *abort =3D dev->priv;
-
-	lenp =3D get_dma_buffer(fd, dev->mem, iov, &num, &irq);
-	if (!lenp) {
-		warn("console: no dma buffer!");
-		iov[0] =3D discard_iov;
-		num =3D 1;
-	}
-
-	len =3D readv(dev->fd, iov, num);
-	if (len <=3D 0) {
-		warnx("Failed to get console input, ignoring console.");
-		len =3D 0;
-	}
-
-	if (lenp) {
-		*lenp =3D len;
-		trigger_irq(fd, irq);
-	}
-
-	/* Three ^C within one second?  Exit. */
-	if (len =3D=3D 1 && ((char *)iov[0].iov_base)[0] =3D=3D 3) {
-		if (!abort->count++)
-			gettimeofday(&abort->start, NULL);
-		else if (abort->count =3D=3D 3) {
-			struct timeval now;
-			gettimeofday(&now, NULL);
-			if (now.tv_sec <=3D abort->start.tv_sec+1)
-				exit(2);
-			abort->count =3D 0;
-		}
-	} else
-		abort->count =3D 0;
-
-	if (!len) {
-		restore_term();
-		return 0;
-	}
-	return 1;
-}
-
-static unsigned long peer_offset(unsigned int peernum)
-{
-	return 4 * peernum;
-}
-
-static u32 handle_tun_output(int fd, const struct iovec *iov,
-			     unsigned num, struct device *dev)
-{
-	/* Now we've seen output, we should warn if we can't get buffers. */
-	*(bool *)dev->priv =3D true;
-	return writev(dev->fd, iov, num);
-}
-
-static u32 handle_block_output(int fd, const struct iovec *iov,
-			       unsigned num, struct device *dev)
-{
-	struct lguest_block_page *p =3D dev->mem;
-	u32 irq, reply_num, *lenp;
-	int len;
-	struct iovec reply[LGUEST_MAX_DMA_SECTIONS];
-	off64_t device_len, off =3D (off64_t)p->sector * 512;
-
-	device_len =3D *(off64_t *)dev->priv;
-
-	if (off >=3D device_len)
-		err(1, "Bad offset %llu vs %llu", off, device_len);
-	if (lseek64(dev->fd, off, SEEK_SET) !=3D off)
-		err(1, "Bad seek to sector %i", p->sector);
-
-	verbose("Block: %s at offset %llu\n", p->type ? "WRITE" : "READ", off);
-
-	lenp =3D get_dma_buffer(fd, dev->mem, reply, &reply_num, &irq);
-	if (!lenp)
-		err(1, "Block request didn't give us a dma buffer");
-
-	if (p->type) {
-		len =3D writev(dev->fd, iov, num);
-		if (off + len > device_len) {
-			ftruncate(dev->fd, device_len);
-			errx(1, "Write past end %llu+%u", off, len);
-		}
-		*lenp =3D 0;
-	} else {
-		len =3D readv(dev->fd, reply, reply_num);
-		*lenp =3D len;
-	}
-
-	p->result =3D 1 + (p->bytes !=3D len);
-	trigger_irq(fd, irq);
-	return 0;
-}
-
-#define HIPQUAD(ip)				\
-	((u8)(ip >> 24)),			\
-	((u8)(ip >> 16)),			\
-	((u8)(ip >> 8)),			\
-	((u8)(ip))
-
-static void configure_device(int fd, const char *devname, u32 ipaddr,
-			     unsigned char hwaddr[6])
-{
-	struct ifreq ifr;
-	struct sockaddr_in *sin =3D (struct sockaddr_in *)&ifr.ifr_addr;
-
-	memset(&ifr, 0, sizeof(ifr));
-	strcpy(ifr.ifr_name, devname);
-	sin->sin_family =3D AF_INET;
-	sin->sin_addr.s_addr =3D htonl(ipaddr);
-	if (ioctl(fd, SIOCSIFADDR, &ifr) !=3D 0)
-		err(1, "Setting %s interface address", devname);
-	ifr.ifr_flags =3D IFF_UP;
-	if (ioctl(fd, SIOCSIFFLAGS, &ifr) !=3D 0)
-		err(1, "Bringing interface %s up", devname);
-
-	if (ioctl(fd, SIOCGIFHWADDR, &ifr) !=3D 0)
-		err(1, "getting hw address for %s", devname);
-
-	memcpy(hwaddr, ifr.ifr_hwaddr.sa_data, 6);
-}
-
-/* We send lguest_add signals while input is pending: avoids races. */
-static void wake_parent(int pipefd, struct devices *devices)
-{
-	int parent =3D getppid();
-	nice(19);
-
-	set_fd(pipefd, devices);
-
-	for (;;) {
-		fd_set rfds =3D devices->infds;
-
-		select(devices->max_infd+1, &rfds, NULL, NULL, NULL);
-		if (FD_ISSET(pipefd, &rfds)) {
-			int ignorefd;
-			if (read(pipefd, &ignorefd, sizeof(ignorefd)) =3D=3D 0)
-				exit(0);
-			FD_CLR(ignorefd, &devices->infds);
-		}
-		kill(parent, SIGUSR1);
-	}
-}
-
-/* We don't want signal to kill us, just jerk us out of kernel. */
-static void wakeup(int signo)
-{
-}
-
-static int handle_tun_input(int fd, struct device *dev)
-{
-	u32 irq =3D 0, num, *lenp;
-	int len;
-	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
-
-	lenp =3D get_dma_buffer(fd, dev->mem+peer_offset(NET_PEERNUM), iov, &num,
-			      &irq);
-	if (!lenp) {
-		if (*(bool *)dev->priv)
-			warn("network: no dma buffer!");
-		iov[0] =3D discard_iov;
-		num =3D 1;
-	}
-
-	len =3D readv(dev->fd, iov, num);
-	if (len <=3D 0)
-		err(1, "reading network");
-	if (lenp) {
-		*lenp =3D len;
-		trigger_irq(fd, irq);
-	}
-	verbose("tun input packet len %i [%02x %02x] (%s)\n", len,
-		((u8 *)iov[0].iov_base)[0], ((u8 *)iov[0].iov_base)[1],
-		lenp ? "sent" : "discarded");
-	return 1;
-}
-
-/* We use fnctl locks to reserve network slots (autocleanup!) */
-static unsigned int find_slot(int netfd, const char *filename)
-{
-	struct flock fl;
-
-	fl.l_type =3D F_WRLCK;
-	fl.l_whence =3D SEEK_SET;
-	fl.l_len =3D 1;
-	for (fl.l_start =3D 0;
-	     fl.l_start < getpagesize()/sizeof(struct lguest_net);
-	     fl.l_start++) {
-		if (fcntl(netfd, F_SETLK, &fl) =3D=3D 0)
-			return fl.l_start;
-	}
-	errx(1, "No free slots in network file %s", filename);
-}
-
-static void setup_net_file(const char *filename,
-			   struct lguest_device_desc *descs,
-			   struct devices *devices)
-{
-	int netfd;
-	struct device *dev;
-
-	netfd =3D open(filename, O_RDWR, 0);
-	if (netfd < 0) {
-		if (errno =3D=3D ENOENT) {
-			netfd =3D open(filename, O_RDWR|O_CREAT, 0600);
-			if (netfd >=3D 0) {
-				char page[getpagesize()];
-				/* 0xFFFF =3D=3D NO_GUEST */
-				memset(page, 0xFF, sizeof(page));
-				write(netfd, page, sizeof(page));
-			}
-		}
-		if (netfd < 0)
-			err(1, "cannot open net file '%s'", filename);
-	}
-
-	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_NET, 1,
-			 -1, NULL, 0, NULL);
-
-	/* This is the slot for the guest to use. */
-	dev->desc->features =3D find_slot(netfd, filename)|LGUEST_NET_F_NOCSUM;
-	/* We overwrite the /dev/zero mapping with the actual file. */
-	if (mmap(dev->mem, getpagesize(), PROT_READ|PROT_WRITE,
-			 MAP_FIXED|MAP_SHARED, netfd, 0) !=3D dev->mem)
-			err(1, "could not mmap '%s'", filename);
-	verbose("device %p@%p: shared net %s, peer %i\n", dev->desc, =

-		(void *)(dev->desc->pfn * getpagesize()), filename, =

-		dev->desc->features & ~LGUEST_NET_F_NOCSUM);
-}
-
-static u32 str2ip(const char *ipaddr)
-{
-	unsigned int byte[4];
-
-	sscanf(ipaddr, "%u.%u.%u.%u", &byte[0], &byte[1], &byte[2], &byte[3]);
-	return (byte[0] << 24) | (byte[1] << 16) | (byte[2] << 8) | byte[3];
-}
-
-/* adapted from libbridge */
-static void add_to_bridge(int fd, const char *if_name, const char *br_name)
-{
-	int r, ifidx;
-	struct ifreq ifr;
-
-	if (!*br_name)
-		errx(1, "must specify bridge name");
-
-	ifidx =3D if_nametoindex(if_name);
-	if (!ifidx)
-		errx(1, "interface %s does not exist!\n", if_name);
-
-	strncpy(ifr.ifr_name, br_name, IFNAMSIZ);
-	ifr.ifr_ifindex =3D ifidx;
-	r =3D ioctl(fd, SIOCBRADDIF, &ifr);
-	if (r !=3D -1)
-		return;
-
-	switch (errno) {
-	case ENODEV:
-		errx(1, "bridge %s does not exist!\n", br_name);
-	case EBUSY:
-		errx(1, "device %s is already a member of a bridge; "
-			"can't enslave it to bridge %s.\n", if_name, br_name);
-	case ELOOP:
-		errx(1, "device %s is a bridge device itself; "
-			"can't enslave a bridge device to a bridge device.\n",
-			if_name);
-	default:
-		err(1, "can't add %s to bridge %s\n", if_name, br_name);
-	}
-}
-
-
-static void setup_tun_net(const char *arg,
-			  struct lguest_device_desc *descs,
-			  struct devices *devices)
-{
-	struct device *dev;
-	struct ifreq ifr;
-	int netfd, ipfd;
-	u32 ipaddr;
-	const char *br_name =3D NULL;
-
-	netfd =3D open("/dev/net/tun", O_RDWR);
-	if (netfd < 0)
-		err(1, "opening /dev/net/tun");
-
-	memset(&ifr, 0, sizeof(ifr));
-	ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI;
-	strcpy(ifr.ifr_name, "tap%d");
-	if (ioctl(netfd, TUNSETIFF, &ifr) !=3D 0)
-		err(1, "configuring /dev/net/tun");
-
-	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_NET, 1,
-			 netfd, handle_tun_input,
-			 peer_offset(0), handle_tun_output);
-	dev->priv =3D malloc(sizeof(bool));
-	*(bool *)dev->priv =3D false;
-
-	ipfd =3D socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
-	if (ipfd < 0)
-		err(1, "opening IP socket");
-
-	if (!strncmp(BRIDGE_PFX, arg, strlen(BRIDGE_PFX))) {
-		ipaddr =3D INADDR_ANY;
-		br_name =3D arg + strlen(BRIDGE_PFX);
-		add_to_bridge(ipfd, ifr.ifr_name, br_name);
-	} else
-		ipaddr =3D str2ip(arg);
-
-	/* We are peer 0, rest is all NO_GUEST */
-	configure_device(ipfd, ifr.ifr_name, ipaddr, dev->mem);
-	close (ipfd);
-
-	/* You will be peer 1: we should create enough jitter to randomize */
-	dev->desc->features =3D NET_PEERNUM|LGUEST_DEVICE_F_RANDOMNESS;
-	verbose("device %p@%p: tun net %u.%u.%u.%u\n", dev->desc,
-		(void *)(dev->desc->pfn * getpagesize()),
-		HIPQUAD(ipaddr));
-	if (br_name)
-		verbose("attched to bridge: %s\n", br_name);
-}
-
-static void setup_block_file(const char *filename,
-			     struct lguest_device_desc *descs,
-			     struct devices *devices)
-{
-	int fd;
-	struct device *dev;
-	off64_t *blocksize;
-	struct lguest_block_page *p;
-
-	fd =3D open(filename, O_RDWR|O_LARGEFILE|O_DIRECT, 0);
-	if (fd < 0)
-		err(1, "Opening %s", filename);
-
-	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_BLOCK, 1,
-			 fd, NULL, 0, handle_block_output);
-	dev->desc->features =3D LGUEST_DEVICE_F_RANDOMNESS;
-	blocksize =3D dev->priv =3D malloc(sizeof(*blocksize));
-	*blocksize =3D lseek64(fd, 0, SEEK_END);
-	p =3D dev->mem;
-
-	p->num_sectors =3D *blocksize/512;
-	verbose("device %p@%p: block %i sectors\n", dev->desc, =

-		(void *)(dev->desc->pfn * getpagesize()), p->num_sectors);
-}
-
-static u32 handle_console_output(int fd, const struct iovec *iov,
-				 unsigned num, struct device*dev)
-{
-	return writev(STDOUT_FILENO, iov, num);
-}
-
-static void setup_console(struct lguest_device_desc *descs,
-			  struct devices *devices)
-{
-	struct device *dev;
-
-	if (tcgetattr(STDIN_FILENO, &orig_term) =3D=3D 0) {
-		struct termios term =3D orig_term;
-		term.c_lflag &=3D ~(ISIG|ICANON|ECHO);
-		tcsetattr(STDIN_FILENO, TCSANOW, &term);
-		atexit(restore_term);
-	}
-
-	/* We don't currently require a page for the console. */
-	dev =3D new_device(devices, descs, LGUEST_DEVICE_T_CONSOLE, 0,
-			 STDIN_FILENO, handle_console_input,
-			 4, handle_console_output);
-	dev->priv =3D malloc(sizeof(struct console_abort));
-	((struct console_abort *)dev->priv)->count =3D 0;
-	verbose("device %p@%p: console\n", dev->desc, =

-		(void *)(dev->desc->pfn * getpagesize()));
-}
-
-static const char *get_arg(const char *arg, const char *prefix)
-{
-	if (strncmp(arg, prefix, strlen(prefix)) =3D=3D 0)
-		return arg + strlen(prefix);
-	return NULL;
-}
-
-static u32 handle_device(int fd, unsigned long dma, unsigned long addr,
-			 struct devices *devices)
-{
-	struct device *i;
-	u32 *lenp;
-	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
-	unsigned num =3D 0;
-
-	lenp =3D dma2iov(dma, iov, &num);
-	if (!lenp)
-		errx(1, "Bad SEND_DMA %li for address %#lx\n", dma, addr);
-
-	for (i =3D devices->dev; i; i =3D i->next) {
-		if (i->handle_output && addr =3D=3D i->watch_address) {
-			*lenp =3D i->handle_output(fd, iov, num, i);
-			return 0;
-		}
-	}
-	warnx("Pending dma %p, addr %p", (void *)dma, (void *)addr);
-	return 0;
-}
-
-static void handle_input(int fd, int childfd, struct devices *devices)
-{
-	struct timeval poll =3D { .tv_sec =3D 0, .tv_usec =3D 0 };
-
-	for (;;) {
-		struct device *i;
-		fd_set fds =3D devices->infds;
-
-		if (select(devices->max_infd+1, &fds, NULL, NULL, &poll) =3D=3D 0)
-			break;
-
-		for (i =3D devices->dev; i; i =3D i->next) {
-			if (i->handle_input && FD_ISSET(i->fd, &fds)) {
-				if (!i->handle_input(fd, i)) {
-					FD_CLR(i->fd, &devices->infds);
-					/* Tell child to ignore it too... */
-					write(childfd, &i->fd, sizeof(i->fd));
-				}
-			}
-		}
-	}
-}
-
-int main(int argc, char *argv[])
-{
-	unsigned long mem, pgdir, entry, initrd_size, page_offset;
-	int arg, kern_fd, fd, child, pipefd[2];
-	Elf32_Ehdr hdr;
-	struct sigaction act;
-	sigset_t sigset;
-	struct lguest_device_desc *devdescs;
-	struct devices devices;
-	struct lguest_boot_info *boot =3D (void *)0;
-	const char *initrd_name =3D NULL;
-	u32 (*load)(int, const Elf32_Ehdr *ehdr, unsigned long,
-		    unsigned long *, const char *, unsigned long *,
-		    unsigned long *);
-
-	if (argv[1] && strcmp(argv[1], "--verbose") =3D=3D 0) {
-		verbose =3D true;
-		argv++;
-		argc--;
-	}
-
-	if (argc < 4)
-		errx(1, "Usage: lguest [--verbose] <mem> vmlinux "
-			"[--sharenet=3D<filename>|--tunnet=3D(<ipaddr>|bridge:<bridgename>)"
-			"|--block=3D<filename>|--initrd=3D<filename>]... [args...]");
-
-	zero_fd =3D open("/dev/zero", O_RDONLY, 0);
-	if (zero_fd < 0)
-		err(1, "Opening /dev/zero");
-
-	mem =3D memparse(argv[1]);
-	kern_fd =3D open(argv[2], O_RDONLY, 0);
-	if (kern_fd < 0)
-		err(1, "Opening %s", argv[2]);
-
-	if (read(kern_fd, &hdr, sizeof(hdr)) !=3D sizeof(hdr))
-		err(1, "Reading %s elf header", argv[2]);
-
-	if (memcmp(hdr.e_ident, ELFMAG, SELFMAG) =3D=3D 0)
-		load =3D map_elf;
-	else
-		load =3D load_bzimage;
-
-	devices.max_infd =3D -1;
-	devices.dev =3D NULL;
-	FD_ZERO(&devices.infds);
-
-	devdescs =3D map_pages(mem, 1);
-	arg =3D 3;
-	while (argv[arg] && argv[arg][0] =3D=3D '-') {
-		const char *argval;
-
-		if ((argval =3D get_arg(argv[arg], "--sharenet=3D")) !=3D NULL)
-			setup_net_file(argval, devdescs, &devices);
-		else if ((argval =3D get_arg(argv[arg], "--tunnet=3D")) !=3D NULL)
-			setup_tun_net(argval, devdescs, &devices);
-		else if ((argval =3D get_arg(argv[arg], "--block=3D")) !=3D NULL)
-			setup_block_file(argval, devdescs, &devices);
-		else if ((argval =3D get_arg(argv[arg], "--initrd=3D")) !=3D NULL)
-			initrd_name =3D argval;
-		else
-			errx(1, "unknown arg '%s'", argv[arg]);
-		arg++;
-	}
-
-	entry =3D load(kern_fd, &hdr, mem, &pgdir, initrd_name, &initrd_size,
-		     &page_offset);
-	setup_console(devdescs, &devices);
-
-	concat(boot->cmdline, argv+arg);
-	boot->max_pfn =3D mem/getpagesize();
-	boot->initrd_size =3D initrd_size;
-
-	act.sa_handler =3D wakeup;
-	sigemptyset(&act.sa_mask);
-	act.sa_flags =3D 0;
-	sigaction(SIGUSR1, &act, NULL);
-
-	pipe(pipefd);
-	child =3D fork();
-	if (child =3D=3D -1)
-		err(1, "forking");
-
-	if (child =3D=3D 0) {
-		close(pipefd[1]);
-		wake_parent(pipefd[0], &devices);
-	}
-	close(pipefd[0]);
-
-	sigemptyset(&sigset);
-	sigaddset(&sigset, SIGUSR1);
-	sigprocmask(SIG_BLOCK, &sigset, NULL);
-
-	fd =3D tell_kernel(RESERVE_TOP/getpagesize(), pgdir, entry, page_offset);
-
-	for (;;) {
-		unsigned long arr[2];
-		int readval;
-
-		sigprocmask(SIG_UNBLOCK, &sigset, NULL);
-		readval =3D read(fd, arr, sizeof(arr));
-		sigprocmask(SIG_BLOCK, &sigset, NULL);
-
-		switch (readval) {
-		case sizeof(arr):
-			handle_device(fd, arr[0], arr[1], &devices);
-			break;
-		case -1:
-			if (errno =3D=3D EINTR)
-				break;
-		default:
-			if (errno =3D=3D ENOENT) {
-				char reason[1024];
-				if (read(fd, reason, sizeof(reason)) > 0)
-					errx(1, "%s", reason);
-			}
-			err(1, "Running guest failed");
-		}
-		handle_input(fd, pipefd[1], &devices);
-	}
-}

--
