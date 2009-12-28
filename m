From: Avi Kivity <avi@redhat.com>
Subject: [PATCH v2] virtio-blk physical block size
Date: Mon, 28 Dec 2009 18:39:23 +0200
Message-ID: <1262018363-15871-1-git-send-email-avi__1521.31276340715$1262018410$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch adds a physical block size attribute to virtio disks,
corresponding to /sys/devices/.../physical_block_size.  It is defined as
the request alignment which will not trigger RMW cycles.  This can be
important for modern disks which use 4K physical sectors (though they
still support 512 logical sectors), and for file-backed disk images (which
have both the underlying filesystem block size and their own allocation
granularity to consider).

Installers use this to align partitions to physical block boundaries.

Note the spec already defined blk_size as the performance rather than
minimum alignment.  However the driver interpreted this as the logical
block size, so I updated the spec to match the driver assuming the driver
predates the spec and that this is an error.

Signed-off-by: Avi Kivity <avi@redhat.com>

--

v2: feature bit 7 was already used by an undocumented feature; use a new bit

--- virtio-spec-0.8.3.lyx.orig	2009-12-28 17:42:40.000000000 +0200
+++ virtio-spec-0.8.3.lyx	2009-12-28 18:37:39.000000000 +0200
@@ -4138,6 +4138,19 @@
 (10) Maximum total sectors in an I/O.
 \end_layout
 
+\begin_layout Description
+VIRTIO_BLK_F_PHYS_BLK_SIZE(11) Physical block size of disk (writes aligned
+ to this will not trigger read-modify-write cycles) is in 
+\begin_inset Quotes erd
+\end_inset
+
+phys_blk_size
+\begin_inset Quotes erd
+\end_inset
+
+.
+\end_layout
+
 \end_deeper
 \begin_layout Description
 Device
@@ -4214,6 +4227,11 @@
 
 \begin_layout Plain Layout
 
+    u32 phys_blk_size;
+\end_layout
+
+\begin_layout Plain Layout
+
 };
 \end_layout
 
@@ -4241,9 +4259,9 @@
 
 \begin_layout Enumerate
 If the VIRTIO_BLK_F_BLK_SIZE feature is negotiated, the blk_size field can
- be read to determine the optimal sector size for the driver to use.
+ be read to determine the sector size for the driver to use.
  This does not effect the units used in the protocol (always 512 bytes),
- but awareness of the correct value can effect performance.
+ but requests must be aligned to this size.
 \end_layout
 
 \begin_layout Enumerate
@@ -4257,6 +4275,13 @@
  No requests should be submitted which go beyond this limit.
 \end_layout
 
+\begin_layout Enumerate
+If the VIRTIO_BLK_F_PHYS_BLK_SIZE feature is negotiated, the phys_blk_size
+ field should be read to determine the hardware block size.
+ Smaller writes are liable to require read-modify-write cycles on behalf
+ of the underlying hardware, however they are still supported.
+\end_layout
+
 \begin_layout Section*
 Device Operation
 \end_layout
