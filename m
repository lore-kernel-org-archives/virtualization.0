From: Joe Perches <joe@perches.com>
Subject: [PATCH 53/62] drivers/xen/balloon.c: Remove unnecessary semicolons
Date: Sun, 28 Jun 2009 09:26:58 -0700
Message-ID: <36cb48396faf4b0382e1bee6911059e9861a3509.1246173683.git.joe@perches.com>
References: <cover.1246173664.git.joe@perches.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760022AbZF1Qk5@vger.kernel.org>
In-Reply-To: <cover.1246173664.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, Andrew Morton <akpm@linux-foundation.org>, Chris Wright <chrisw@sous-sol.org>, Jeremy Fitzhardinge <jeremy@xensource.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/xen/balloon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
index f5bbd9e..4d1b322 100644
--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -214,7 +214,7 @@ static int increase_reservation(unsigned long nr_pages)
 	page = balloon_first_page();
 	for (i = 0; i < nr_pages; i++) {
 		BUG_ON(page == NULL);
-		frame_list[i] = page_to_pfn(page);;
+		frame_list[i] = page_to_pfn(page);
 		page = balloon_next_page(page);
 	}
 
-- 
1.6.3.1.10.g659a0.dirty
