From: Hirokazu Takahashi <taka@valinux.co.jp>
Subject: [PATCH 4/4] BIO tracking take2
Date: Tue, 20 May 2008 21:04:05 +0900 (JST)
Message-ID: <20080520.210405.107683253.taka__35958.5347855047$1211285758$gmane$org@valinux.co.jp>
References: <20080520.205949.127764004.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080520.205949.127764004.taka@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, dm-devel@redhat.com, containers@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, agk@sourceware.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

With this patch, dm-ioband can work with the bio cgroup.


Signed-off-by: Hirokazu Takahashi <taka@valinux.co.jp>


diff -dupr linux-2.6.26-rc2.cg2/drivers/md/dm-ioband-type.c linux-2.6.26-rc2/drivers/md/dm-ioband-type.c
--- linux-2.6.26-rc2.cg2/drivers/md/dm-ioband-type.c	2008-05-19 13:51:23.000000000 +0900
+++ linux-2.6.26-rc2/drivers/md/dm-ioband-type.c	2008-05-19 18:40:10.000000000 +0900
@@ -6,6 +6,7 @@
  * This file is released under the GPL.
  */
 #include <linux/bio.h>
+#include <linux/biocontrol.h>
 #include "dm.h"
 #include "dm-bio-list.h"
 #include "dm-ioband.h"
@@ -53,13 +54,13 @@ static int ioband_node(struct bio *bio)
 
 static int ioband_cgroup(struct bio *bio)
 {
-  /*
-   * This function should return the ID of the cgroup which issued "bio".
-   * The ID of the cgroup which the current process belongs to won't be
-   * suitable ID for this purpose, since some BIOs will be handled by kernel
-   * threads like aio or pdflush on behalf of the process requesting the BIOs.
-   */
-	return 0;	/* not implemented yet */
+	struct io_context *ioc = get_bio_cgroup_iocontext(bio);
+	int id = 0;
+	if (ioc) {
+		id = ioc->id;
+		put_io_context(ioc);
+	}
+	return id;
 }
 
 struct group_type dm_ioband_group_type[] = {
