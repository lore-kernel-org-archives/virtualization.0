From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 01/10] virtio_pci: add isr field
Date: Mon, 8 Dec 2014 17:16:35 +0200
Message-ID: <1418051779-27748-2-git-send-email-mst@redhat.com>
References: <1418051779-27748-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418051779-27748-1-git-send-email-mst@redhat.com>
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

Use isr field instead of direct access to ioaddr.
This way generalizes easily to virtio 1.0.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 9be59d9..ee1b54c 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -40,6 +40,9 @@ struct virtio_pci_device
 	/* the IO mapping for the PCI config space */
 	void __iomem *ioaddr;
 
+	/* the IO mapping for ISR operation */
+	void __iomem *isr;
+
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
@@ -248,7 +251,7 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 
 	/* reading the ISR has the effect of also clearing it so it's very
 	 * important to save off the value. */
-	isr = ioread8(vp_dev->ioaddr + VIRTIO_PCI_ISR);
+	isr = ioread8(vp_dev->isr);
 
 	/* It's definitely not us if the ISR was not high */
 	if (!isr)
@@ -719,6 +722,8 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 		goto out_req_regions;
 	}
 
+	vp_dev->isr = vp_dev->ioaddr + VIRTIO_PCI_ISR;
+
 	pci_set_drvdata(pci_dev, vp_dev);
 	pci_set_master(pci_dev);
 
-- 
MST
