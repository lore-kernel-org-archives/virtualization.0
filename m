From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/5] lguest: cleanup for map_switcher()
Date: Mon, 21 Sep 2009 16:52:21 +0930
Message-ID: <200909210723.n8L7Nu5Y022168@smtp1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.osdl.org
Cc: Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>, lguest@ozlabs.org
List-Id: virtualization@lists.linuxfoundation.org

From: Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>

We can use alloc_page() instead of get_zeroed_page() and virt_to_page()

Signed-off-by: Xiao Guangrong <xiaoguangrong@cn.fujitsu.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/core.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/lguest/core.c b/drivers/lguest/core.c
index 1e2cb84..b639019 100644
--- a/drivers/lguest/core.c
+++ b/drivers/lguest/core.c
@@ -67,12 +67,11 @@ static __init int map_switcher(void)
 	 * so we make sure they're zeroed.
 	 */
 	for (i = 0; i < TOTAL_SWITCHER_PAGES; i++) {
-		unsigned long addr = get_zeroed_page(GFP_KERNEL);
-		if (!addr) {
+		switcher_page[i] = alloc_page(GFP_KERNEL|__GFP_ZERO);
+		if (!switcher_page[i]) {
 			err = -ENOMEM;
 			goto free_some_pages;
 		}
-		switcher_page[i] = virt_to_page(addr);
 	}
 
 	/*
