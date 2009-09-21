From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/5] lguest: use PGDIR_SHIFT for PAE code to allow different
	PAGE_OFFSET
Date: Mon, 21 Sep 2009 16:52:21 +0930
Message-ID: <200909210723.n8L7Nrks022145@smtp1.linux-foundation.org>
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
Cc: lguest@ozlabs.org, Matias Zabaljauregui <zabaljauregui@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org


We still assume the Guest and Host have the same PAGE_OFFSET settings,
but now we don't assume 0xC0000000.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: Matias Zabaljauregui <zabaljauregui@gmail.com>
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
