From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] Remove -static from Documentation/lguest/Makefile
Date: Fri, 20 Jul 2007 22:02:53 +1000
Message-ID: <1184932973.10380.293.camel__48578.4392025836$1184933274$gmane$org@localhost.localdomain>
References: <200707192313.44106.caglar@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-9
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707192313.44106.caglar@pardus.org.tr>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: caglar@pardus.org.tr
Cc: LKML <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-07-19 at 23:13 +0300, S.=C7a=F0lar Onur wrote:
> Hi;
>=20
> Remove -static from Documentation/lguest/Makefile, most distros only pr=
ovides shared library form of zlib in their default installation.=20
> And shared linking also provides litte tiny security for hypotetical se=
curity problems will be introduced by zlib :).

Unfortunately, this introduces a security hole.  See, the guest can
access all memory up to LGUEST_GUEST_TOP, or 0xB8000000 on my machine.
Without -static, we look like this:

>  cat /proc/4137/maps=20
b7e0b000-b7e0d000 rw-p b7e0b000 00:00 0=20
b7e0d000-b7f35000 r-xp 00000000 03:03 17069      /lib/tls/libc-2.3.6.so
b7f35000-b7f3a000 r--p 00127000 03:03 17069      /lib/tls/libc-2.3.6.so
b7f3a000-b7f3c000 rw-p 0012c000 03:03 17069      /lib/tls/libc-2.3.6.so
b7f3c000-b7f3f000 rw-p b7f3c000 00:00 0=20
b7f3f000-b7f52000 r-xp 00000000 03:03 389723     /usr/lib/libz.so.1.2.3
b7f52000-b7f53000 rw-p 00012000 03:03 389723     /usr/lib/libz.so.1.2.3
b7f5b000-b7f5d000 rw-p b7f5b000 00:00 0=20
b7f5d000-b7f5e000 r-xp b7f5d000 00:00 0          [vdso]
b7f5e000-b7f73000 r-xp 00000000 03:03 16351      /lib/ld-2.3.6.so
b7f73000-b7f75000 rw-p 00014000 03:03 16351      /lib/ld-2.3.6.so
b8000000-b8004000 r-xp 00000000 03:04
2485028    /home/rusty/linux-2.6.22-git13/Documentation/lguest/lguest
b8004000-b8005000 rw-p 00004000 03:04
2485028    /home/rusty/linux-2.6.22-git13/Documentation/lguest/lguest
bfecd000-bfee3000 rw-p bfecd000 00:00 0          [stack]

Whee!  Guest can overwrite our libc, libz, ld.so.  Also, we allocate
pages for virtual devices from B8000000 down, so we might not run very
far if we've blatted those libraries.

The correct solution is to allocate upwards, and then hand the top
address we got to the kernel as the highest accessible guest address.

How's this?
=3D=3D=3D
Link lguest example launcher non-static

S.Caglar Onur points out that many distributions don't ship a static
zlib.  Unfortunately the launcher currently maps virtual device memory
where shared libraries want to go.

The solution is to pre-scan the args to figure out how much memory we
have, then allocate devices above that, rather than down from the top.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r d9973bf15010 Documentation/lguest/Makefile
--- a/Documentation/lguest/Makefile	Fri Jul 20 21:40:49 2007 +1000
+++ b/Documentation/lguest/Makefile	Fri Jul 20 21:41:44 2007 +1000
@@ -11,8 +11,7 @@ include $(KBUILD_OUTPUT)/.config
 include $(KBUILD_OUTPUT)/.config
 LGUEST_GUEST_TOP :=3D ($(CONFIG_PAGE_OFFSET) - 0x08000000)
=20
-CFLAGS:=3D-Wall -Wmissing-declarations -Wmissing-prototypes -O3 \
-	-static -DLGUEST_GUEST_TOP=3D"$(LGUEST_GUEST_TOP)" -Wl,-T,lguest.lds
+CFLAGS:=3D-Wall -Wmissing-declarations -Wmissing-prototypes -O3 -Wl,-T,l=
guest.lds
 LDLIBS:=3D-lz
=20
 all: lguest.lds lguest
diff -r d9973bf15010 Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Fri Jul 20 21:40:49 2007 +1000
+++ b/Documentation/lguest/lguest.c	Fri Jul 20 21:55:07 2007 +1000
@@ -47,12 +47,14 @@ static bool verbose;
 #define verbose(args...) \
 	do { if (verbose) printf(args); } while(0)
 static int waker_fd;
+static u32 top;
=20
 struct device_list
 {
 	fd_set infds;
 	int max_infd;
=20
+	struct lguest_device_desc *descs;
 	struct device *dev;
 	struct device **lastdev;
 };
@@ -324,8 +326,7 @@ static int tell_kernel(u32 pgdir, u32 st
 static int tell_kernel(u32 pgdir, u32 start, u32 page_offset)
 {
 	u32 args[] =3D { LHREQ_INITIALIZE,
-		       LGUEST_GUEST_TOP/getpagesize(), /* Just below us */
-		       pgdir, start, page_offset };
+		       top/getpagesize(), pgdir, start, page_offset };
 	int fd;
=20
 	fd =3D open_or_die("/dev/lguest", O_RDWR);
@@ -382,7 +383,7 @@ static void *_check_pointer(unsigned lon
 static void *_check_pointer(unsigned long addr, unsigned int size,
 			    unsigned int line)
 {
-	if (addr >=3D LGUEST_GUEST_TOP || addr + size >=3D LGUEST_GUEST_TOP)
+	if (addr >=3D top || addr + size >=3D top)
 		errx(1, "%s:%i: Invalid address %li", __FILE__, line, addr);
 	return (void *)addr;
 }
@@ -629,24 +630,26 @@ static void handle_input(int fd, struct=20
 	}
 }
=20
-static struct lguest_device_desc *new_dev_desc(u16 type, u16 features,
-					       u16 num_pages)
-{
-	static unsigned long top =3D LGUEST_GUEST_TOP;
-	struct lguest_device_desc *desc;
-
-	desc =3D malloc(sizeof(*desc));
-	desc->type =3D type;
-	desc->num_pages =3D num_pages;
-	desc->features =3D features;
-	desc->status =3D 0;
-	if (num_pages) {
-		top -=3D num_pages*getpagesize();
-		map_zeroed_pages(top, num_pages);
-		desc->pfn =3D top / getpagesize();
-	} else
-		desc->pfn =3D 0;
-	return desc;
+static struct lguest_device_desc *
+new_dev_desc(struct lguest_device_desc *descs,
+	     u16 type, u16 features, u16 num_pages)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < LGUEST_MAX_DEVICES; i++) {
+		if (!descs[i].type) {
+			descs[i].type =3D type;
+			descs[i].features =3D features;
+			descs[i].num_pages =3D num_pages;
+			if (num_pages) {
+				map_zeroed_pages(top, num_pages);
+				descs[i].pfn =3D top/getpagesize();
+				top +=3D num_pages*getpagesize();
+			}
+			return &descs[i];
+		}
+	}
+	errx(1, "too many devices");
 }
=20
 static struct device *new_device(struct device_list *devices,
@@ -669,7 +672,7 @@ static struct device *new_device(struct=20
 	dev->fd =3D fd;
 	if (handle_input)
 		set_fd(dev->fd, devices);
-	dev->desc =3D new_dev_desc(type, features, num_pages);
+	dev->desc =3D new_dev_desc(devices->descs, type, features, num_pages);
 	dev->mem =3D (void *)(dev->desc->pfn * getpagesize());
 	dev->handle_input =3D handle_input;
 	dev->watch_key =3D (unsigned long)dev->mem + watch_off;
@@ -866,30 +869,6 @@ static void setup_tun_net(const char *ar
 		verbose("attached to bridge: %s\n", br_name);
 }
=20
-/* Now we know how much memory we have, we copy in device descriptors */
-static void map_device_descriptors(struct device_list *devs, unsigned lo=
ng mem)
-{
-	struct device *i;
-	unsigned int num;
-	struct lguest_device_desc *descs;
-
-	/* Device descriptor array sits just above top of normal memory */
-	descs =3D map_zeroed_pages(mem, 1);
-
-	for (i =3D devs->dev, num =3D 0; i; i =3D i->next, num++) {
-		if (num =3D=3D LGUEST_MAX_DEVICES)
-			errx(1, "too many devices");
-		verbose("Device %i: %s\n", num,
-			i->desc->type =3D=3D LGUEST_DEVICE_T_NET ? "net"
-			: i->desc->type =3D=3D LGUEST_DEVICE_T_CONSOLE ? "console"
-			: i->desc->type =3D=3D LGUEST_DEVICE_T_BLOCK ? "block"
-			: "unknown");
-		descs[num] =3D *i->desc;
-		free(i->desc);
-		i->desc =3D &descs[num];
-	}
-}
-
 static void __attribute__((noreturn))
 run_guest(int lguest_fd, struct device_list *device_list)
 {
@@ -934,8 +913,8 @@ static void usage(void)
=20
 int main(int argc, char *argv[])
 {
-	unsigned long mem, pgdir, start, page_offset, initrd_size =3D 0;
-	int c, lguest_fd;
+	unsigned long mem =3D 0, pgdir, start, page_offset, initrd_size =3D 0;
+	int i, c, lguest_fd;
 	struct device_list device_list;
 	void *boot =3D (void *)0;
 	const char *initrd_name =3D NULL;
@@ -945,6 +924,15 @@ int main(int argc, char *argv[])
 	device_list.lastdev =3D &device_list.dev;
 	FD_ZERO(&device_list.infds);
=20
+	/* We need to know how much memory so we can allocate devices. */=20
+	for (i =3D 1; i < argc; i++) {
+		if (argv[i][0] !=3D '-') {
+			mem =3D top =3D atoi(argv[i]) * 1024 * 1024;
+			device_list.descs =3D map_zeroed_pages(top, 1);
+			top +=3D getpagesize();
+			break;
+		}
+	}
 	while ((c =3D getopt_long(argc, argv, "v", opts, NULL)) !=3D EOF) {
 		switch (c) {
 		case 'v':
@@ -974,15 +962,11 @@ int main(int argc, char *argv[])
 	setup_console(&device_list);
=20
 	/* First we map /dev/zero over all of guest-physical memory. */
-	mem =3D atoi(argv[optind]) * 1024 * 1024;
 	map_zeroed_pages(0, mem / getpagesize());
=20
 	/* Now we load the kernel */
 	start =3D load_kernel(open_or_die(argv[optind+1], O_RDONLY),
 			    &page_offset);
-
-	/* Write the device descriptors into memory. */
-	map_device_descriptors(&device_list, mem);
=20
 	/* Map the initrd image if requested */
 	if (initrd_name) {
