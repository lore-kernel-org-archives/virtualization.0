From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH net 3/4] virtio-net: reset num_buf to 1 after linearizing
	packet
Date: Mon, 21 May 2018 16:35:05 +0800
Message-ID: <1526891706-18516-4-git-send-email-jasowang__44470.7362833016$1526891719$gmane$org@redhat.com>
References: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1526891706-18516-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, jasowang@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

If we successfully linearize the packets, num_buf were set to zero
which was wrong since we now have only 1 buffer to be used for e.g in
the error path of receive_mergeable(). Zero num_buf will lead the code
try to pop the buffers of next packet and drop it. Fixing this by set
num_buf to 1 if we successfully linearize the packet.

Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/virtio_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 6260d65..165a922 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -722,6 +722,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 						      &len);
 			if (!xdp_page)
 				goto err_xdp;
+			num_buf = 1;
 			offset = VIRTIO_XDP_HEADROOM;
 		} else {
 			xdp_page = page;
-- 
2.7.4
