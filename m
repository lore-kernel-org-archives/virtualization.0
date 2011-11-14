From: Sasha Levin <levinsasha928@gmail.com>
Subject: [RFC 2/5] virtio-pci: Fix compilation issue
Date: Tue, 15 Nov 2011 01:43:14 +0200
Message-ID: <1321314197-5265-3-git-send-email-levinsasha928@gmail.com>
References: <20111114181854.GA24953@redhat.com>
	<1321314197-5265-1-git-send-email-levinsasha928@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1321314197-5265-1-git-send-email-levinsasha928@gmail.com>
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
Cc: kvm@vger.kernel.org, mst@redhat.com, virtualization@lists.linux-foundation.org, penberg@kernel.org, Sasha Levin <levinsasha928@gmail.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Sasha Levin <levinsasha928@gmail.com>
---
 drivers/virtio/virtio_pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 7625434..d242fcc 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -129,10 +129,10 @@ static void __iomem *virtio_pci_map_cfg(struct virtio_pci_device *vp_dev, u8 cap
         bir &= VIRTIO_PCI_CAP_CFG_BIR_MASK;
         size >>= VIRTIO_PCI_CAP_CFG_SIZE_SHIFT;
         size &= VIRTIO_PCI_CAP_CFG_SIZE_MASK;
-        off >>= VIRTIO_PCI_CAP_CFG_OFF_SHIFT;
-        off &= VIRTIO_PCI_CAP_CFG_OFF_MASK;
+        offset >>= VIRTIO_PCI_CAP_CFG_OFF_SHIFT;
+        offset &= VIRTIO_PCI_CAP_CFG_OFF_MASK;
 	/* Align offset appropriately */
-	off &= ~(align - 1);
+	offset &= ~(align - 1);
 
 	/* It's possible for a device to supply a huge config space,
 	 * but we'll never need to map more than a page ATM. */
-- 
1.7.8.rc1
