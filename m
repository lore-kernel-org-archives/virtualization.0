From: James Morris <jmorris@redhat.com>
Subject: [PATCH] fix boot crash when freeing initrd memory
Date: Wed, 1 Nov 2006 17:36:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44.0611011729170.31570-100000@redline.boston.redhat.com>
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
List-Id: virtualization@lists.linuxfoundation.org

I'm triggering this BUG_ON during boot, which happens while freeing initrd =

memory:

 EIP is at free_init_pages+0x37/0xac
 [<c01143f1>] free_initrd_mem+0x11/0x13
 [<c03ce259>] free_initrd+0x13/0x29
 [<c03cf647>] populate_rootfs+0xdc/0xe2
 [<c01003af>] init+0x42/0x253
 [<c0103bbb>] kernel_thread_helper+0x7/0x10


I'm not sure why this memory isn't aligned now.

The patch below allows my system to boot.  Any clues about the correct fix
appreciated.


Signed-off-by: James Morris <jmorris@redhat.com>


---

 arch/i386/mm/init.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -purN -X dontdiff linux-pv-2.6.p/arch/i386/mm/init.c linux-pv-2.6.x/ar=
ch/i386/mm/init.c
--- linux-pv-2.6.p/arch/i386/mm/init.c	2006-11-01 16:46:49.000000000 -0500
+++ linux-pv-2.6.x/arch/i386/mm/init.c	2006-11-01 17:18:20.000000000 -0500
@@ -787,7 +787,7 @@ void free_init_pages(char *what, unsigne
 	unsigned long addr;
 =

 	BUG_ON(begin !=3D ALIGN(begin, PAGE_SIZE));
-	BUG_ON(end !=3D ALIGN(end, PAGE_SIZE));
+	WARN_ON(end !=3D ALIGN(end, PAGE_SIZE));
 =

 	for (addr =3D begin; addr < end; addr +=3D PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
