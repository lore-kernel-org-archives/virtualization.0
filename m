From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/8] MAINTAINERS: Put the virtio-console entry in correct
	alphabetical order
Date: Tue, 23 Mar 2010 18:23:09 +0530
Message-ID: <1269348796-8660-2-git-send-email-amit.shah@redhat.com>
References: <1269348796-8660-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1269348796-8660-1-git-send-email-amit.shah@redhat.com>
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

Move around the entry for virtio-console to keep the file sorted.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 MAINTAINERS |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

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
-- 
1.6.2.5
