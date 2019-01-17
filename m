From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Subject: [PATCH net 6/7] virtio_net: Use xdp_return_frame to free xdp_frames
	on destroying vqs
Date: Thu, 17 Jan 2019 20:20:44 +0900
Message-ID: <1547724045-2726-7-git-send-email-makita.toshiaki__30274.944791063$1547754894$gmane$org@lab.ntt.co.jp>
References: <1547724045-2726-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1547724045-2726-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jesper Dangaard Brouer <brouer@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

put_page() can work as a fallback for freeing xdp_frames, but the
appropriate way is to use xdp_return_frame().

Fixes: cac320c850ef ("virtio_net: convert to use generic xdp_frame and xdp_return_frame API")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ae93f0e..996de69 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2668,7 +2668,7 @@ static void free_unused_bufs(struct virtnet_info *vi)
 			if (!is_xdp_raw_buffer_queue(vi, i))
 				dev_kfree_skb(buf);
 			else
-				put_page(virt_to_head_page(buf));
+				xdp_return_frame(buf);
 		}
 	}
 
-- 
1.8.3.1
