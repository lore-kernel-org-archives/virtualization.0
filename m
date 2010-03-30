From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 1/4] MAINTAINERS: Put the virtio-console entry in correct
	alphabetical order
Date: Tue, 30 Mar 2010 15:47:34 +1030
Message-ID: <201003301547.34731.rusty@rustcorp.com.au>
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
To: virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Amit Shah <amit.shah@redhat.com>

Move around the entry for virtio-console to keep the file sorted.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 MAINTAINERS |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 449d444..e3548dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2474,12 +2474,6 @@ L:	linuxppc-dev@ozlabs.org
 S:	Odd Fixes
 F:	drivers/char/hvc_*
 
-VIRTIO CONSOLE DRIVER
-M:	Amit Shah <amit.shah@redhat.com>
-L:	virtualization@lists.linux-foundation.org
-S:	Maintained
-F:	drivers/char/virtio_console.c
-
 iSCSI BOOT FIRMWARE TABLE (iBFT) DRIVER
 M:	Peter Jones <pjones@redhat.com>
 M:	Konrad Rzeszutek Wilk <konrad@kernel.org>
@@ -5961,6 +5955,13 @@ S:	Maintained
 F:	Documentation/filesystems/vfat.txt
 F:	fs/fat/
 
+VIRTIO CONSOLE DRIVER
+M:	Amit Shah <amit.shah@redhat.com>
+L:	virtualization@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/char/virtio_console.c
+F:	include/linux/virtio_console.h
+
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 L:	kvm@vger.kernel.org
