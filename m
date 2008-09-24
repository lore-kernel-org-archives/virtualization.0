From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: [PATCH 7/8] bio-cgroup: Add a cgroup support to dm-ioband
Date: Wed, 24 Sep 2008 19:14:32 +0900 (JST)
Message-ID: <20080924.191432.39172089.ryov__7180.30969515002$1222253035$gmane$org@valinux.co.jp>
References: <20080924.191309.189710495.ryov@valinux.co.jp>
	<20080924.191338.112608181.ryov@valinux.co.jp>
	<20080924.191402.183039492.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080924.191402.183039492.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, dm-devel@redhat.com, containers@lists.linux-foundation.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xensource.com
Cc: fernando@oss.ntt.co.jp, balbir@linux.vnet.ibm.com, xemul@openvz.org, kamezawa.hiroyu@jp.fujitsu.com, agk@sourceware.org
List-Id: virtualization@lists.linuxfoundation.org

With this patch, dm-ioband can work with the bio cgroup.

Based on 2.6.27-rc5-mm1
Signed-off-by: Ryo Tsuruta <ryov@valinux.co.jp>
Signed-off-by: Hirokazu Takahashi <taka@valinux.co.jp>

diff -Ndupr linux-2.6.27-rc5-mm1.cg2/drivers/md/dm-ioband-type.c linux-2.6.27-rc5-mm1.cg3/drivers/md/dm-ioband-type.c
--- linux-2.6.27-rc5-mm1.cg2/drivers/md/dm-ioband-type.c	2008-09-24 16:23:13.000000000 +0900
+++ linux-2.6.27-rc5-mm1.cg3/drivers/md/dm-ioband-type.c	2008-09-24 16:34:52.000000000 +0900
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
