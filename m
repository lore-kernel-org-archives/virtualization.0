From: Vincent Legoll <vincent.legoll@gmail.com>
Subject: [PATCH] virtio: make VIRTIO a menuconfig to ease disabling it all
Date: Sat,  9 Dec 2017 16:26:57 +0100
Message-ID: <20171209152657.4762-1-vincent.legoll__3438.21280771426$1513195119$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc: Vincent Legoll <vincent.legoll@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

No need to get into the submenu to disable all VIRTIO-related
config entries.

This makes it easier to disable all VIRTIO config options
without entering the submenu. It will also enable one
to see that en/dis-abled state from the outside menu.

This is only intended to change menuconfig UI, not change
the config dependencies.

Signed-off-by: Vincent Legoll <vincent.legoll@gmail.com>
---
 drivers/virtio/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index cff773f15b7e..d485a63a8233 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -5,7 +5,10 @@ config VIRTIO
 	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
 	  or CONFIG_S390_GUEST.
 
-menu "Virtio drivers"
+menuconfig VIRTIO_MENU
+	bool "Virtio drivers"
+
+if VIRTIO_MENU
 
 config VIRTIO_PCI
 	tristate "PCI driver for virtio devices"
@@ -79,4 +82,4 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
 
 	 If unsure, say 'N'.
 
-endmenu
+endif # VIRTIO_MENU
-- 
2.14.1
