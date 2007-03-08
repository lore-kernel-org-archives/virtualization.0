From: Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC/PATCH LGUEST X86_64 08/13] lguest64 user header.
Date: Thu, 08 Mar 2007 12:39:02 -0500
Message-ID: <1173375542.32170.10.camel@localhost.localdomain>
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

plain text document attachment (lguest64-user.patch)
This patch adds the header used by the lguest64 loader.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>
Signed-off-by: Glauber de Oliveira Costa <glommer@gmail.com>
Cc: Chris Wright <chrisw@sous-sol.org>


Index: work-pv/include/asm-x86_64/lguest_user.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- /dev/null
+++ work-pv/include/asm-x86_64/lguest_user.h
@@ -0,0 +1,88 @@
+#ifndef _ASM_LGUEST_USER
+#define _ASM_LGUEST_USER
+
+/* Everything the "lguest" userspace program needs to know. */
+/* They can register up to 32 arrays of lguest_dma. */
+#define LGUEST_MAX_DMA		32
+
+/* How many devices?  Assume each one wants up to two dma arrays per devic=
e. */
+#define LGUEST_MAX_DEVICES (LGUEST_MAX_DMA/2)
+
+/* At most we can dma 16 lguest_dma in one op. */
+#define LGUEST_MAX_DMA_SECTIONS	16
+
+struct lguest_dma
+{
+	/* 0 if free to be used, filled by hypervisor. */
+ 	u64 used_len;
+	u64 addr[LGUEST_MAX_DMA_SECTIONS];
+	u16 len[LGUEST_MAX_DMA_SECTIONS];
+};
+
+/* This is found at address 0. */
+struct lguest_boot_info
+{
+	u32 max_pfn;
+	u32 initrd_size;
+	char cmdline[256];
+};
+
+struct lguest_block_page
+{
+	/* 0 is a read, 1 is a write. */
+	int type;
+	u32 sector; 	/* Offset in device =3D sector * 512. */
+	u32 bytes;	/* Length expected to be read/written in bytes */
+	/* 0 =3D pending, 1 =3D done, 2 =3D done, error */
+	int result;
+	u32 num_sectors; /* Disk length =3D num_sectors * 512 */
+};
+
+/* There is a shared page of these. */
+struct lguest_net
+{
+	union {
+		unsigned char mac[6];
+		struct {
+			u8 promisc;
+			u8 pad;
+			u16 guestid;
+		};
+	};
+};
+
+/* lguest_device_desc->type */
+#define LGUEST_DEVICE_T_CONSOLE	1
+#define LGUEST_DEVICE_T_NET	2
+#define LGUEST_DEVICE_T_BLOCK	3
+
+/* lguest_device_desc->status.  256 and above are device specific. */
+#define LGUEST_DEVICE_S_ACKNOWLEDGE	1 /* We have seen device. */
+#define LGUEST_DEVICE_S_DRIVER		2 /* We have found a driver */
+#define LGUEST_DEVICE_S_DRIVER_OK	4 /* Driver says OK! */
+#define LGUEST_DEVICE_S_REMOVED		8 /* Device has gone away. */
+#define LGUEST_DEVICE_S_REMOVED_ACK	16 /* Driver has been told. */
+#define LGUEST_DEVICE_S_FAILED		128 /* Something actually failed */
+
+#define LGUEST_NET_F_NOCSUM		0x4000 /* Don't bother checksumming */
+#define LGUEST_DEVICE_F_RANDOMNESS	0x8000 /* IRQ is fairly random */
+
+/* We have a page of these descriptors in the lguest_device page. */
+struct lguest_device_desc {
+	u16 type;
+	u16 features;
+	u16 status;
+	u16 num_pages;
+	u64 pfn;
+};
+
+/* Write command first word is a request. */
+enum lguest_req
+{
+	LHREQ_INITIALIZE, /* + pfnlimit, pgdir, start, pageoffset */
+	LHREQ_GETDMA, /* + addr (returns &lguest_dma, irq in ->used_len) */
+	LHREQ_IRQ, /* + irq */
+};
+
+
+#endif /* _ASM_LGUEST_USER */

--
