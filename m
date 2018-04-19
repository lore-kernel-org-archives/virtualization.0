From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 net 2/3] virtio_net: fix adding vids on big-endian
Date: Thu, 19 Apr 2018 08:30:49 +0300
Message-ID: <1524115776-334953-3-git-send-email-mst__43389.6755254411$1524115754$gmane$org@redhat.com>
References: <1524115776-334953-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524115776-334953-1-git-send-email-mst@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org, Mikulas Patocka <mpatocka@redhat.com>, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

Programming vids (adding or removing them) still passes
guest-endian values in the DMA buffer. That's wrong
if guest is big-endian and when virtio 1 is enabled.

Note: this is on top of a previous patch:
	virtio_net: split out ctrl buffer

Fixes: 9465a7a6f ("virtio_net: enable v1.0 support")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3d0eff53..f84fe04 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -154,7 +154,7 @@ struct control_buf {
 	struct virtio_net_ctrl_mq mq;
 	u8 promisc;
 	u8 allmulti;
-	u16 vid;
+	__virtio16 vid;
 	u64 offloads;
 };
 
@@ -1718,7 +1718,7 @@ static int virtnet_vlan_rx_add_vid(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl->vid = vid;
+	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
@@ -1733,7 +1733,7 @@ static int virtnet_vlan_rx_kill_vid(struct net_device *dev,
 	struct virtnet_info *vi = netdev_priv(dev);
 	struct scatterlist sg;
 
-	vi->ctrl->vid = vid;
+	vi->ctrl->vid = cpu_to_virtio16(vi->vdev, vid);
 	sg_init_one(&sg, &vi->ctrl->vid, sizeof(vi->ctrl->vid));
 
 	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_VLAN,
-- 
MST
