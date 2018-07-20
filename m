From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 1/9] vhost_net: drop unnecessary parameter
Date: Fri, 20 Jul 2018 08:15:13 +0800
Message-ID: <1532045721-4958-2-git-send-email-jasowang__48877.2848308601$1532045628$gmane$org@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index b224036..1a8175a 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -430,7 +430,6 @@ static int vhost_net_enable_vq(struct vhost_net *n,
 
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_virtqueue *vq,
-				    struct iovec iov[], unsigned int iov_size,
 				    unsigned int *out_num, unsigned int *in_num,
 				    bool *busyloop_intr)
 {
@@ -512,9 +511,8 @@ static void handle_tx(struct vhost_net *net)
 			vhost_zerocopy_signal_used(net, vq);
 
 		busyloop_intr = false;
-		head = vhost_net_tx_get_vq_desc(net, vq, vq->iov,
-						ARRAY_SIZE(vq->iov),
-						&out, &in, &busyloop_intr);
+		head = vhost_net_tx_get_vq_desc(net, vq, &out, &in,
+						&busyloop_intr);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
-- 
2.7.4
