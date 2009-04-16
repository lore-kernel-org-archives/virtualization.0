From: Ryo Tsuruta <ryov@valinux.co.jp>
Subject: [PATCH 5/5] bio-cgroup: Add a cgroup support to dm-ioband
Date: Thu, 16 Apr 2009 21:31:56 +0900 (JST)
Message-ID: <20090416.213156.112612071.ryov__9418.11818997866$1239885571$gmane$org@valinux.co.jp>
References: <20090416.212931.71100972.ryov@valinux.co.jp>
	<20090416.213019.104045053.ryov@valinux.co.jp>
	<20090416.213105.189713999.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20090416.213105.189713999.ryov@valinux.co.jp>
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
List-Id: virtualization@lists.linuxfoundation.org

With this patch, dm-ioband can work with the bio cgroup.

Based on 2.6.30-rc1
Signed-off-by: Hirokazu Takahashi <taka@valinux.co.jp>
Signed-off-by: Ryo Tsuruta <ryov@valinux.co.jp>

---
 drivers/md/dm-ioband-type.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

Index: linux-2.6.30-rc1/drivers/md/dm-ioband-type.c
===================================================================
--- linux-2.6.30-rc1.orig/drivers/md/dm-ioband-type.c
+++ linux-2.6.30-rc1/drivers/md/dm-ioband-type.c
@@ -6,6 +6,7 @@
  * This file is released under the GPL.
  */
 #include <linux/bio.h>
+#include <linux/biotrack.h>
 #include "dm.h"
 #include "dm-bio-list.h"
 #include "dm-ioband.h"
@@ -53,14 +54,7 @@ static int ioband_node(struct bio *bio)
 
 static int ioband_cgroup(struct bio *bio)
 {
-	/*
-	 * This function should return the ID of the cgroup which
-	 * issued "bio". The ID of the cgroup which the current
-	 * process belongs to won't be suitable ID for this purpose,
-	 * since some BIOs will be handled by kernel threads like aio
-	 * or pdflush on behalf of the process requesting the BIOs.
-	 */
-	return 0;	/* not implemented yet */
+	return get_bio_cgroup_id(bio);
 }
 
 struct group_type dm_ioband_group_type[] = {
