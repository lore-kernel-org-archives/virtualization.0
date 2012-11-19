From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 156/493] virtio: remove use of __devinit
Date: Mon, 19 Nov 2012 13:21:45 -0500
Message-ID: <1353349642-3677-156-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gregkh@linuxfoundation.org
Cc: virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au> 
Cc: "Michael S. Tsirkin" <mst@redhat.com> 
Cc: virtualization@lists.linux-foundation.org 
---
 drivers/virtio/virtio_mmio.c | 2 +-
 drivers/virtio/virtio_pci.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 5584f48..6e0047b 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -440,7 +440,7 @@ static struct virtio_config_ops virtio_mmio_config_ops = {
 
 /* Platform device */
 
-static int __devinit virtio_mmio_probe(struct platform_device *pdev)
+static int virtio_mmio_probe(struct platform_device *pdev)
 {
 	struct virtio_mmio_device *vm_dev;
 	struct resource *mem;
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 9bd7fb2..325e847 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -676,7 +676,7 @@ static void virtio_pci_release_dev(struct device *_d)
 }
 
 /* the PCI probing function */
-static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
+static int virtio_pci_probe(struct pci_dev *pci_dev,
 				      const struct pci_device_id *id)
 {
 	struct virtio_pci_device *vp_dev;
-- 
1.8.0
