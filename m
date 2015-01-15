From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] virtio_pci: Kconfig grammar fix
Date: Thu, 15 Jan 2015 14:18:30 +0200
Message-ID: <1421324298-21749-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This drivers -> this driver.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 00b2286..8286b63 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -12,7 +12,7 @@ config VIRTIO_PCI
 	depends on PCI
 	select VIRTIO
 	---help---
-	  This drivers provides support for virtio based paravirtual device
+	  This driver provides support for virtio based paravirtual device
 	  drivers over PCI.  This requires that your VMM has appropriate PCI
 	  virtio backends.  Most QEMU based VMMs should support these devices
 	  (like KVM or Xen).
-- 
MST
