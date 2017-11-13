From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next V2] vhost_net: conditionally enable tx polling
Date: Mon, 13 Nov 2017 11:45:34 +0800
Message-ID: <1510544734-6142-1-git-send-email-jasowang__42201.1818890043$1510544746$gmane$org@redhat.com>
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
To: mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Wei Xu <wexu@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We always poll tx for socket, this is sub optimal since this will
slightly increase the waitqueue traversing time and more important,
vhost could not benefit from commit 9e641bdcfa4e ("net-tun:
restructure tun_do_read for better sleep/wakeup efficiency") even if
we've stopped rx polling during handle_rx(), tx poll were still left
in the waitqueue.

Pktgen from a remote host to VM over mlx4 on two 2.00GHz Xeon E5-2650
shows 11.7% improvements on rx PPS. (from 1.28Mpps to 1.44Mpps)

Cc: Wei Xu <wexu@redhat.com>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from V1:
- don't try to disable tx polling during start
- poll tx on error unconditonally
---
 drivers/vhost/net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 68677d9..8d626d7 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -471,6 +471,7 @@ static void handle_tx(struct vhost_net *net)
 		goto out;
 
 	vhost_disable_notify(&net->dev, vq);
+	vhost_net_disable_vq(net, vq);
 
 	hdr_size = nvq->vhost_hlen;
 	zcopy = nvq->ubufs;
@@ -556,6 +557,7 @@ static void handle_tx(struct vhost_net *net)
 					% UIO_MAXIOV;
 			}
 			vhost_discard_vq_desc(vq, 1);
+			vhost_net_enable_vq(net, vq);
 			break;
 		}
 		if (err != len)
-- 
2.7.4
