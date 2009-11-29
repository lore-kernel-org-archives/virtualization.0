From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio: set pci bus master enable bit
Date: Sun, 29 Nov 2009 17:52:01 +0200
Message-ID: <20091129155200.GA6667__41779.1817723357$1259511082$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>, "Michael S. Tsirkin" <mst@redhat.com>, Mark McLoughlin <markmc@redhat.com>, linux-kernel@vger.kernel.org, virtualization@li
List-Id: virtualization@lists.linuxfoundation.org

As all virtio devices perform DMA, we
must enable bus mastering for them to be
spec compliant.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 28d9cf7..717bae1 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -648,6 +648,7 @@ static int __devinit virtio_pci_probe(struct pci_dev *pci_dev,
 		goto out_req_regions;
 
 	pci_set_drvdata(pci_dev, vp_dev);
+	pci_set_master(pci_dev);
 
 	/* we use the subsystem vendor/device id as the virtio vendor/device
 	 * id.  this allows us to use the same PCI vendor/device id for all
-- 
1.6.5.2.143.g8cc62
