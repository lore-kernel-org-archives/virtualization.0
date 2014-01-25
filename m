From: Leandro Dorileo <l@dorileo.org>
Subject: [PATCH] virtio_balloon: don't call virtio_has_feature() twice on
	init_vqs()
Date: Sat, 25 Jan 2014 17:59:32 -0200
Message-ID: <1390679972-1406-1-git-send-email-l__9800.15047030083$1390679999$gmane$org@dorileo.org>
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
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, mst@redhat.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Cchange init_vqs() to avoid calling twice the virtio_has_feature()
- attempting to find out if VIRTIO_BALLOON_F_STATS_VQ feature was negotiated -
consequently we prevent unnecessarily running the drivers' feature_table more
than needed.

Signed-off-by: Leandro Dorileo <l@dorileo.org>
---
 drivers/virtio/virtio_balloon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 34bdaba..41771c1 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -320,19 +320,21 @@ static int init_vqs(struct virtio_balloon *vb)
 	vq_callback_t *callbacks[] = { balloon_ack, balloon_ack, stats_request };
 	const char *names[] = { "inflate", "deflate", "stats" };
 	int err, nvqs;
+	bool stats;
 
 	/*
 	 * We expect two virtqueues: inflate and deflate, and
 	 * optionally stat.
 	 */
-	nvqs = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ) ? 3 : 2;
+	stats = virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ);
+	nvqs = stats ? 3 : 2;
 	err = vb->vdev->config->find_vqs(vb->vdev, nvqs, vqs, callbacks, names);
 	if (err)
 		return err;
 
 	vb->inflate_vq = vqs[0];
 	vb->deflate_vq = vqs[1];
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
+	if (stats) {
 		struct scatterlist sg;
 		vb->stats_vq = vqs[2];
 
-- 
1.8.5.3
