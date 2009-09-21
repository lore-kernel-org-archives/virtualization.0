From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: [PATCH 4/5] lguest: cleanup for map_switcher()
Date: Mon, 21 Sep 2009 16:52:21 +0930
Message-ID: <20090921072352.BF18BB7CF1@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/lguest>,
	<mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/lguest>
List-Post: <mailto:lguest-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/lguest>,
	<mailto:lguest-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Sender: lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Errors-To: lguest-bounces+glkvl-lguest=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Cc: Xiao Guangrong <xiaoguangrong-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org>, lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

From: Xiao Guangrong <xiaoguangrong-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org>

We can use alloc_page() instead of get_zeroed_page() and virt_to_page()

Signed-off-by: Xiao Guangrong <xiaoguangrong-BthXqXjhjHXQFUHtdCDX3A@public.gmane.org>
Signed-off-by: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
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
