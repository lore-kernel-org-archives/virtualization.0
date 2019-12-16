From: Daniel Verkamp <dverkamp@chromium.org>
Subject: [PATCH] virtio-balloon: request nvqs based on features
Date: Mon, 16 Dec 2019 15:14:29 -0800
Message-ID: <20191216231429.38202-1-dverkamp@chromium.org>
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
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: virtualization@lists.linux-foundation.org
Cc: Liang Li <liang.z.li@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

After 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT"),
the virtio-balloon device unconditionally specifies 4 virtqueues as the
argument to find_vqs(), which means that 5 MSI-X vectors are required in
order to assign one vector per VQ plus one for configuration changes.

However, in cases where the virtio device only provides exactly as many
MSI-X vectors as required for the features it implements (e.g. 3 for the
basic configuration of inflate + deflate + config), this results in the
selection of the fallback configuration where one interrupt vector is
used for all VQs instead of having one VQ per vector.

Restore the logic that chose nvqs conditionally based on enabled
features, which was removed as part of the aforementioned commit.
This is slightly more complex than just incrementing a counter of the
number of VQs, since the queue for a given feature is assigned a fixed
index.

Signed-off-by: Daniel Verkamp <dverkamp@chromium.org>
---
 drivers/virtio/virtio_balloon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 93f995f6cf36..67c6318d77c7 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -465,6 +465,7 @@ static int init_vqs(struct virtio_balloon *vb)
 	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
 	const char *names[VIRTIO_BALLOON_VQ_MAX];
 	int err;
+	unsigned nvqs;
 
 	/*
 	 * Inflateq and deflateq are used unconditionally. The names[]
@@ -475,20 +476,24 @@ static int init_vqs(struct virtio_balloon *vb)
 	names[VIRTIO_BALLOON_VQ_INFLATE] = "inflate";
 	callbacks[VIRTIO_BALLOON_VQ_DEFLATE] = balloon_ack;
 	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
+	nvqs = VIRTIO_BALLOON_VQ_DEFLATE + 1;
+
 	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
 	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
 		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
 		callbacks[VIRTIO_BALLOON_VQ_STATS] = stats_request;
+		nvqs = VIRTIO_BALLOON_VQ_STATS + 1;
 	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
 		names[VIRTIO_BALLOON_VQ_FREE_PAGE] = "free_page_vq";
 		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
+		nvqs = VIRTIO_BALLOON_VQ_FREE_PAGE + 1;
 	}
 
-	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
+	err = vb->vdev->config->find_vqs(vb->vdev, nvqs,
 					 vqs, callbacks, names, NULL, NULL);
 	if (err)
 		return err;
-- 
2.24.1.735.g03f4e72817-goog
