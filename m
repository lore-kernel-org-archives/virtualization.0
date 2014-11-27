From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v5 31/45] vhost/net: virtio 1.0 byte swap
Date: Thu, 27 Nov 2014 14:32:39 +0200
Message-ID: <1417091078-24611-32-git-send-email-mst__28227.8833831244$1417091717$gmane$org@redhat.com>
References: <1417091078-24611-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1417091078-24611-1-git-send-email-mst@redhat.com>
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
Cc: thuth@linux.vnet.ibm.com, kvm@vger.kernel.org, rusty@au1.ibm.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, dahi@linux.vnet.ibm.com, pbonzini@redhat.com, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/net.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index dce5c58..cae22f9 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -416,7 +416,7 @@ static void handle_tx(struct vhost_net *net)
 			struct ubuf_info *ubuf;
 			ubuf = nvq->ubuf_info + nvq->upend_idx;
 
-			vq->heads[nvq->upend_idx].id = head;
+			vq->heads[nvq->upend_idx].id = cpu_to_vhost32(vq, head);
 			vq->heads[nvq->upend_idx].len = VHOST_DMA_IN_PROGRESS;
 			ubuf->callback = vhost_zerocopy_callback;
 			ubuf->ctx = nvq->ubufs;
@@ -500,6 +500,7 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 	int headcount = 0;
 	unsigned d;
 	int r, nlogs = 0;
+	u32 len;
 
 	while (datalen > 0 && headcount < quota) {
 		if (unlikely(seg >= UIO_MAXIOV)) {
@@ -527,13 +528,14 @@ static int get_rx_bufs(struct vhost_virtqueue *vq,
 			nlogs += *log_num;
 			log += *log_num;
 		}
-		heads[headcount].id = d;
-		heads[headcount].len = iov_length(vq->iov + seg, in);
-		datalen -= heads[headcount].len;
+		heads[headcount].id = cpu_to_vhost32(vq, d);
+		len = iov_length(vq->iov + seg, in);
+		heads[headcount].len = cpu_to_vhost32(vq, len);
+		datalen -= len;
 		++headcount;
 		seg += in;
 	}
-	heads[headcount - 1].len += datalen;
+	heads[headcount - 1].len = cpu_to_vhost32(vq, len - datalen);
 	*iovcount = seg;
 	if (unlikely(log))
 		*log_num = nlogs;
-- 
MST
