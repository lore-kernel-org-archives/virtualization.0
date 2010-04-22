From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio: Fix GFP flags passed from the virtio balloon driver
Date: Thu, 22 Apr 2010 12:22:34 +0930
Message-ID: <201004221222.36014.rusty__44667.727725073$1271904874$gmane$org@rustcorp.com.au>
References: <20100421190704.GK3994@balbir.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100421190704.GK3994@balbir.in.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>, virtualization@lists.linux-foundation.org, kvm <kvm@vger.kernel.org>, balbir@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

From: Balbir Singh <balbir@linux.vnet.ibm.com>

The virtio balloon driver can dig into the reservation pools
of the OS to satisfy a balloon request. This is not advisable
and other balloon drivers (drivers/xen/balloon.c) avoid this
as well. The patch also adds changes to avoid printing a warning
if allocation fails, since we retry after sometime anyway.

Signed-off-by: Balbir Singh <balbir@linux.vnet.ibm.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm <kvm@vger.kernel.org>
Cc: stable@kernel.org
---
 drivers/virtio/virtio_balloon.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 369f2ee..f8ffe8c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -102,7 +102,8 @@ static void fill_balloon(struct virtio_balloon *vb, size_t num)
 	num = min(num, ARRAY_SIZE(vb->pfns));
 
 	for (vb->num_pfns = 0; vb->num_pfns < num; vb->num_pfns++) {
-		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY);
+		struct page *page = alloc_page(GFP_HIGHUSER | __GFP_NORETRY |
+					__GFP_NOMEMALLOC | __GFP_NOWARN);
 		if (!page) {
 			if (printk_ratelimit())
 				dev_printk(KERN_INFO, &vb->vdev->dev,
