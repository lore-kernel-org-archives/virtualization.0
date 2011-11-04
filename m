From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] xen-gntalloc: signedness bug in add_grefs()
Date: Fri, 4 Nov 2011 21:24:36 +0300
Message-ID: <20111104182436.GE5796__18825.4820219756$1321323113$gmane$org@elgon.mountain>
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
To: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
Cc: kernel-janitors@vger.kernel.org, xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

gref->gref_id is unsigned so the error handling didn't work.
gnttab_grant_foreign_access() returns an int type, so we can add a
cast here, and it doesn't cause any problems.
gnttab_grant_foreign_access() can return a variety of errors
including -ENOSPC, -ENOSYS and -ENOMEM.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index 23c60cf..e1c4c6e 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -135,7 +135,7 @@ static int add_grefs(struct ioctl_gntalloc_alloc_gref *op,
 		/* Grant foreign access to the page. */
 		gref->gref_id = gnttab_grant_foreign_access(op->domid,
 			pfn_to_mfn(page_to_pfn(gref->page)), readonly);
-		if (gref->gref_id < 0) {
+		if ((int)gref->gref_id < 0) {
 			rc = gref->gref_id;
 			goto undo;
 		}
