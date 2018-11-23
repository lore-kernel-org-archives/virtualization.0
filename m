From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net-next 2/3] vhost_net: support in order feature
Date: Fri, 23 Nov 2018 11:00:15 +0800
Message-ID: <20181123030016.4924-3-jasowang__14459.4352612787$1542941943$gmane$org@redhat.com>
References: <20181123030016.4924-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181123030016.4924-1-jasowang@redhat.com>
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
List-Id: virtualization@lists.linuxfoundation.org

This makes vhost_net to support in order feature. This is as simple as
use datacopy path when it was negotiated. An alternative is not to
advertise in order when zerocopy is enabled which tends to be
suboptimal consider zerocopy may suffer from e.g HOL issues.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index d919284f103b..bdf5de5a7eb2 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -74,7 +74,8 @@ enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
 			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
-			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
+			 (1ULL << VIRTIO_F_IOMMU_PLATFORM) |
+	                 (1ULL << VIRTIO_F_IN_ORDER)
 };
 
 enum {
@@ -971,7 +972,8 @@ static void handle_tx(struct vhost_net *net)
 	vhost_disable_notify(&net->dev, vq);
 	vhost_net_disable_vq(net, vq);
 
-	if (vhost_sock_zcopy(sock))
+	if (vhost_sock_zcopy(sock) &&
+	    !vhost_has_feature(vq, VIRTIO_F_IN_ORDER))
 		handle_tx_zerocopy(net, sock);
 	else
 		handle_tx_copy(net, sock);
-- 
2.17.1
