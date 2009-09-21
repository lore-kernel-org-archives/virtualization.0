From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: [PATCH 3/5] lguest: use PGDIR_SHIFT for PAE code to allow
	different PAGE_OFFSET
Date: Mon, 21 Sep 2009 16:52:21 +0930
Message-ID: <20090921072352.1A008B7C87@ozlabs.org>
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
Cc: lguest-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org


We still assume the Guest and Host have the same PAGE_OFFSET settings,
but now we don't assume 0xC0000000.

Signed-off-by: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Cc: Matias Zabaljauregui <zabaljauregui-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/lguest/page_tables.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/lguest/page_tables.c b/drivers/lguest/page_tables.c
--- a/drivers/lguest/page_tables.c
+++ b/drivers/lguest/page_tables.c
@@ -996,11 +996,9 @@ static unsigned long setup_pagetables(st
 	if (copy_to_user(&pgdir[0], &pgd, sizeof(pgd)) != 0)
 		return -EFAULT;
 	/*
-	 * And the third PGD entry (ie. addresses 3G-4G).
-	 *
-	 * FIXME: This assumes that PAGE_OFFSET for the Guest is 0xC0000000.
+	 * And the other PGD entry to make the linear mapping at PAGE_OFFSET
 	 */
-	if (copy_to_user(&pgdir[3], &pgd, sizeof(pgd)) != 0)
+	if (copy_to_user(&pgdir[KERNEL_PGD_BOUNDARY], &pgd, sizeof(pgd)))
 		return -EFAULT;
 #else
 	/*
