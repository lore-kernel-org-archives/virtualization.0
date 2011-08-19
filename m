From: Ian Campbell <ian.campbell@citrix.com>
Subject: [PATCH 59/75] virtionet: convert to SKB paged frag API.
Date: Fri, 19 Aug 2011 14:27:31 +0100
Message-ID: <1313760467-8598-59-git-send-email-ian.campbell__11690.6712567017$1313770465$gmane$org@citrix.com>
References: <1313760393.5010.356.camel@zakaz.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1313760393.5010.356.camel@zakaz.uk.xensource.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ian Campbell <ian.campbell@citrix.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/virtio_net.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 0c7321c..52667a8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -149,7 +149,7 @@ static void set_skb_frag(struct sk_buff *skb, struct page *page,
 	f = &skb_shinfo(skb)->frags[i];
 	f->size = min((unsigned)PAGE_SIZE - offset, *len);
 	f->page_offset = offset;
-	f->page = page;
+	__skb_frag_set_page(f, page);
 
 	skb->data_len += f->size;
 	skb->len += f->size;
-- 
1.7.2.5
