From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] trans_virtio: use virtqueue_xxx wrappers
Date: Tue, 13 Apr 2010 16:11:50 +0300
Message-ID: <20100413131150.GA25652@redhat.com>
References: <20100413130604.GA25574@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100413130604.GA25574@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Switch trans_virtio to new virtqueue_xxx wrappers.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/9p/trans_virtio.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 7eb78ec..dcfbe99 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -137,7 +137,7 @@ static void req_done(struct virtqueue *vq)
 
 	P9_DPRINTK(P9_DEBUG_TRANS, ": request done\n");
 
-	while ((rc = chan->vq->vq_ops->get_buf(chan->vq, &len)) != NULL) {
+	while ((rc = virtqueue_get_buf(chan->vq, &len)) != NULL) {
 		P9_DPRINTK(P9_DEBUG_TRANS, ": rc %p\n", rc);
 		P9_DPRINTK(P9_DEBUG_TRANS, ": lookup tag %d\n", rc->tag);
 		req = p9_tag_lookup(chan->client, rc->tag);
@@ -209,13 +209,13 @@ p9_virtio_request(struct p9_client *client, struct p9_req_t *req)
 
 	req->status = REQ_STATUS_SENT;
 
-	if (chan->vq->vq_ops->add_buf(chan->vq, chan->sg, out, in, req->tc) < 0) {
+	if (virtqueue_add_buf(chan->vq, chan->sg, out, in, req->tc) < 0) {
 		P9_DPRINTK(P9_DEBUG_TRANS,
 			"9p debug: virtio rpc add_buf returned failure");
 		return -EIO;
 	}
 
-	chan->vq->vq_ops->kick(chan->vq);
+	virtqueue_kick(chan->vq);
 
 	P9_DPRINTK(P9_DEBUG_TRANS, "9p debug: virtio request kicked\n");
 	return 0;
-- 
1.7.0.2.280.gc6f05
