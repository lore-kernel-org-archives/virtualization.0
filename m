From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_net: fix mergeable bufs error handling
Date: Wed, 29 Mar 2017 15:37:37 +0300
Message-ID: <1490791050-22046-1-git-send-email-mst__17157.7130946845$1490791071$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On xdp error we try to free head_skb without having
initialized it, that's clearly bogus.

Fixes: f600b6905015 ("virtio_net: Add XDP support")
Cc: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 11773d6..e0fb3707 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -570,7 +570,7 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 	u16 num_buf;
 	struct page *page;
 	int offset;
-	struct sk_buff *head_skb, *curr_skb;
+	struct sk_buff *head_skb = NULL, *curr_skb;
 	struct bpf_prog *xdp_prog;
 	unsigned int truesize;
 
-- 
MST
