From: Maciek Fijalkowski <macfij7@wp.pl>
Subject: [PATCH 1/3] Fix ERROR: trailing statements should be on next line
Date: Sun, 14 May 2017 19:51:28 +0200
Message-ID: <20170514175130.18664-1-macfij7__37704.1798354641$1494947299$gmane$org@wp.pl>
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
To: mst@redhat.com
Cc: Maciej Fijalkowski <macfij7@wp.pl>, jasonwang@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Maciej Fijalkowski <macfij7@wp.pl>

Signed-off-by: Maciej Fijalkowski <macfij7@wp.pl>
---
 drivers/net/virtio_net.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 9320d96..f20dfb8 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -217,7 +217,8 @@ static void give_pages(struct receive_queue *rq, struct page *page)
 	struct page *end;
 
 	/* Find end of list, sew whole thing into vi->rq.pages. */
-	for (end = page; end->private; end = (struct page *)end->private);
+	for (end = page; end->private; end = (struct page *)end->private)
+		;
 	end->private = (unsigned long)rq->pages;
 	rq->pages = page;
 }
-- 
2.4.11
