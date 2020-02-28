From: Ram Muthiah <rammuthiah@google.com>
Subject: [PATCH RESEND] virtio: virtio_pci_legacy: Remove default y from Kconfig
Date: Fri, 28 Feb 2020 15:27:36 -0800
Message-ID: <20200228232736.182780-1-rammuthiah@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-team@android.com, Ram Muthiah <rammuthiah@google.com>
List-Id: virtualization@lists.linuxfoundation.org

The legacy pci driver should no longer be default enabled. QEMU has
implemented support for Virtio 1 for virtio-pci since June 2015
on SHA dfb8e184db75.

Signed-off-by: Ram Muthiah <rammuthiah@google.com>
---
 drivers/virtio/Kconfig | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 078615cf2afc..eacd0b90d32b 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -26,7 +26,6 @@ config VIRTIO_PCI
 
 config VIRTIO_PCI_LEGACY
 	bool "Support for legacy virtio draft 0.9.X and older devices"
-	default y
 	depends on VIRTIO_PCI
 	---help---
           Virtio PCI Card 0.9.X Draft (circa 2014) and older device support.
@@ -36,11 +35,6 @@ config VIRTIO_PCI_LEGACY
 	  If disabled, you get a slightly smaller, non-transitional driver,
 	  with no legacy compatibility.
 
-          So look out into your driveway.  Do you have a flying car?  If
-          so, you can happily disable this option and virtio will not
-          break.  Otherwise, leave it set.  Unless you're testing what
-          life will be like in The Future.
-
 	  If unsure, say Y.
 
 config VIRTIO_PMEM
-- 
2.25.0.265.gbab2e86ba0-goog
