From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] virtio-net: add missing virtqueue kick when flushing
	packets
Date: Fri, 13 Apr 2018 14:58:25 +0800
Message-ID: <1523602705-5155-1-git-send-email-jasowang__8420.83730171925$1523602614$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ktaka@nii.ac.jp, Daniel Borkmann <daniel@iogearbox.net>
List-Id: virtualization@lists.linuxfoundation.org

We tends to batch submitting packets during XDP_TX. This requires to
kick virtqueue after a batch, we tried to do it through
xdp_do_flush_map() which only makes sense for devmap not XDP_TX. So
explicitly kick the virtqueue in this case.

Reported-by: Kimitoshi Takahashi <ktaka@nii.ac.jp>
Tested-by: Kimitoshi Takahashi <ktaka@nii.ac.jp>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 2337460..d8e1aea 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1269,7 +1269,9 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 {
 	struct receive_queue *rq =
 		container_of(napi, struct receive_queue, napi);
-	unsigned int received;
+	struct virtnet_info *vi = rq->vq->vdev->priv;
+	struct send_queue *sq;
+	unsigned int received, qp;
 	bool xdp_xmit = false;
 
 	virtnet_poll_cleantx(rq);
@@ -1280,8 +1282,13 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
 	if (received < budget)
 		virtqueue_napi_complete(napi, rq->vq, received);
 
-	if (xdp_xmit)
+	if (xdp_xmit) {
+		qp = vi->curr_queue_pairs - vi->xdp_queue_pairs +
+		     smp_processor_id();
+		sq = &vi->sq[qp];
+		virtqueue_kick(sq->vq);
 		xdp_do_flush_map();
+	}
 
 	return received;
 }
-- 
2.7.4
