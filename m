From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] drivers/xen/grant-table.c: add error-handling code on failure
	of gnttab_resume
Date: Sun, 15 Apr 2012 11:27:12 +0200
Message-ID: <1334482032-12339-1-git-send-email-Julia.Lawall__7756.50884393162$1334595172$gmane$org@lip6.fr>
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
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, xen-devel@lists.xensource.com, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Jump to the label ini_nomem as done on the failure of the page allocations
above.

The code at ini_nomem is modified to accommodate different return values.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/xen/grant-table.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index b4d4eac..f100ce2 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -1029,6 +1029,7 @@ int gnttab_init(void)
 	int i;
 	unsigned int max_nr_glist_frames, nr_glist_frames;
 	unsigned int nr_init_grefs;
+	int ret;
 
 	nr_grant_frames = 1;
 	boot_max_nr_grant_frames = __max_nr_grant_frames();
@@ -1047,12 +1048,16 @@ int gnttab_init(void)
 	nr_glist_frames = (nr_grant_frames * GREFS_PER_GRANT_FRAME + RPP - 1) / RPP;
 	for (i = 0; i < nr_glist_frames; i++) {
 		gnttab_list[i] = (grant_ref_t *)__get_free_page(GFP_KERNEL);
-		if (gnttab_list[i] == NULL)
+		if (gnttab_list[i] == NULL) {
+			ret = -ENOMEM;
 			goto ini_nomem;
+		}
 	}
 
-	if (gnttab_resume() < 0)
-		return -ENODEV;
+	if (gnttab_resume() < 0) {
+		ret = -ENODEV;
+		goto ini_nomem;
+	}
 
 	nr_init_grefs = nr_grant_frames * GREFS_PER_GRANT_FRAME;
 
@@ -1070,7 +1075,7 @@ int gnttab_init(void)
 	for (i--; i >= 0; i--)
 		free_page((unsigned long)gnttab_list[i]);
 	kfree(gnttab_list);
-	return -ENOMEM;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(gnttab_init);
