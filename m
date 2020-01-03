From: Daniel Verkamp <dverkamp@chromium.org>
Subject: [PATCH v2 2/2] virtio-pci: check name when counting MSI-X vectors
Date: Fri,  3 Jan 2020 10:40:45 -0800
Message-ID: <20200103184044.73568-2-dverkamp__39920.8722914167$1578076884$gmane$org@chromium.org>
References: <20200103184044.73568-1-dverkamp@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200103184044.73568-1-dverkamp@chromium.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

VQs without a name specified are not valid; they are skipped in the
later loop that assigns MSI-X vectors to queues, but the per_vq_vectors
loop above that counts the required number of vectors previously still
counted any queue with a non-NULL callback as needing a vector.

Add a check to the per_vq_vectors loop so that vectors with no name are
not counted to make the two loops consistent.  This prevents
over-counting unnecessary vectors (e.g. for features which were not
negotiated with the device).

Cc: stable@vger.kernel.org
Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---

v1:
https://lists.linuxfoundation.org/pipermail/virtualization/2019-December/044828.html

 drivers/virtio/virtio_pci_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index f2862f66c2ac..222d630c41fc 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -294,7 +294,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 		/* Best option: one for change interrupt, one per vq. */
 		nvectors = 1;
 		for (i = 0; i < nvqs; ++i)
-			if (callbacks[i])
+			if (names[i] && callbacks[i])
 				++nvectors;
 	} else {
 		/* Second best: one for change, shared for all vqs. */
-- 
2.24.1.735.g03f4e72817-goog
