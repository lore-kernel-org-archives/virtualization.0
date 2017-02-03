From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] Revert "vring: Force use of DMA API for ARM-based systems
	with legacy devices"
Date: Fri, 3 Feb 2017 05:49:11 +0200
Message-ID: <1486093716-17120-1-git-send-email-mst__8453.53388363055$1486093766$gmane$org@redhat.com>
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

This reverts commit c7070619f3408d9a0dffbed9149e6f00479cf43b.

This has been shown to regress on some ARM systems:

by forcing on DMA API usage for ARM systems, we have inadvertently
kicked open a hornets' nest in terms of cache-coherency. Namely that
unless the virtio device is explicitly described as capable of coherent
DMA by firmware, the DMA APIs on ARM and other DT-based platforms will
assume it is non-coherent. This turns out to cause a big problem for the
likes of QEMU and kvmtool, which generate virtio-mmio devices in their
guest DTs but neglect to add the often-overlooked "dma-coherent"
property; as a result, we end up with the guest making non-cacheable
accesses to the vring, the host doing so cacheably, both talking past
each other and things going horribly wrong.

We are working on a safer work-around.

Fixes: c7070619f340 ("vring: Force use of DMA API for ARM-based systems with legacy devices")
Reported-by: Robin Murphy <robin.murphy@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---

I'll merge this for 4.10. Let's fix it properly for 4.11.

 drivers/virtio/virtio_ring.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7e38ed7..409aeaa 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -159,13 +159,6 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	if (xen_domain())
 		return true;
 
-	/*
-	 * On ARM-based machines, the DMA ops will do the right thing,
-	 * so always use them with legacy devices.
-	 */
-	if (IS_ENABLED(CONFIG_ARM) || IS_ENABLED(CONFIG_ARM64))
-		return !virtio_has_feature(vdev, VIRTIO_F_VERSION_1);
-
 	return false;
 }
 
-- 
MST
