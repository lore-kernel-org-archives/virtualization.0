From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 05/05] virtio_pci_modern: drop an unused function
Date: Tue, 20 Jan 2015 18:25:19 +0200
Message-ID: <1421771093-1589-6-git-send-email-mst__129.478160715912$1421771159$gmane$org@redhat.com>
References: <1421771093-1589-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1421771093-1589-1-git-send-email-mst@redhat.com>
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

release function in modern driver is unused:
it's a left-over from when each driver had
to have its own release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 68ebc20..f16e462 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -489,14 +489,6 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
 	return 0;
 }
 
-static void virtio_pci_release_dev(struct device *_d)
-{
-	struct virtio_device *vdev = dev_to_virtio(_d);
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-
-	kfree(vp_dev);
-}
-
 /* This is part of the ABI.  Don't screw with it. */
 static inline void check_offsets(void)
 {
-- 
MST
