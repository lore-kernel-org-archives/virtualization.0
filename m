From: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH 02/21] Staging: hv: Simplify the code for blkvsc_getgeo()
Date: Fri, 22 Apr 2011 14:55:07 -0700
Message-ID: <1303509326-3094-2-git-send-email-kys@microsoft.com>
References: <1303509246-3053-1-git-send-email-kys@microsoft.com>
	<1303509326-3094-1-git-send-email-kys@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1303509326-3094-1-git-send-email-kys@microsoft.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Sender: devel-bounces@linuxdriverproject.org
Errors-To: devel-bounces@linuxdriverproject.org
To: gregkh@suse.de, linux-kernel@vger.kernel.org, devel@linuxdriverproject.org, virtualization@lists.osdl.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>
List-Id: virtualization@lists.linuxfoundation.org

We are making up the geometry anyway, keep it simple.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Hank Janssen <hjanssen@microsoft.com>
---
 drivers/staging/hv/blkvsc_drv.c |   84 +++++---------------------------------
 1 files changed, 11 insertions(+), 73 deletions(-)

diff --git a/drivers/staging/hv/blkvsc_drv.c b/drivers/staging/hv/blkvsc_drv.c
index 3b47495..f5cc522 100644
--- a/drivers/staging/hv/blkvsc_drv.c
+++ b/drivers/staging/hv/blkvsc_drv.c
@@ -278,82 +278,20 @@ static int blkvsc_open(struct block_device *bdev, fmode_t mode)
 
 static int blkvsc_getgeo(struct block_device *bd, struct hd_geometry *hg)
 {
-	sector_t total_sectors = get_capacity(bd->bd_disk);
-	sector_t cylinder_times_heads = 0;
-	sector_t temp = 0;
+	sector_t nsect = get_capacity(bd->bd_disk);
+	sector_t cylinders = nsect;
 
-	int sectors_per_track = 0;
-	int heads = 0;
-	int cylinders = 0;
-	int rem = 0;
-
-	if (total_sectors > (65535 * 16 * 255))
-		total_sectors = (65535 * 16 * 255);
-
-	if (total_sectors >= (65535 * 16 * 63)) {
-		sectors_per_track = 255;
-		heads = 16;
-
-		cylinder_times_heads = total_sectors;
-		/* sector_div stores the quotient in cylinder_times_heads */
-		rem = sector_div(cylinder_times_heads, sectors_per_track);
-	} else {
-		sectors_per_track = 17;
-
-		cylinder_times_heads = total_sectors;
-		/* sector_div stores the quotient in cylinder_times_heads */
-		rem = sector_div(cylinder_times_heads, sectors_per_track);
-
-		temp = cylinder_times_heads + 1023;
-		/* sector_div stores the quotient in temp */
-		rem = sector_div(temp, 1024);
-
-		heads = temp;
-
-		if (heads < 4)
-			heads = 4;
-
-
-		if (cylinder_times_heads >= (heads * 1024) || (heads > 16)) {
-			sectors_per_track = 31;
-			heads = 16;
-
-			cylinder_times_heads = total_sectors;
-			/*
-			 * sector_div stores the quotient in
-			 * cylinder_times_heads
-			 */
-			rem = sector_div(cylinder_times_heads,
-					 sectors_per_track);
-		}
-
-		if (cylinder_times_heads >= (heads * 1024)) {
-			sectors_per_track = 63;
-			heads = 16;
-
-			cylinder_times_heads = total_sectors;
-			/*
-			 * sector_div stores the quotient in
-			 * cylinder_times_heads
-			 */
-			rem = sector_div(cylinder_times_heads,
-					 sectors_per_track);
-		}
-	}
-
-	temp = cylinder_times_heads;
-	/* sector_div stores the quotient in temp */
-	rem = sector_div(temp, heads);
-	cylinders = temp;
-
-	hg->heads = heads;
-	hg->sectors = sectors_per_track;
+	/*
+	 * We are making up these values; let us keep it simple.
+	 */
+	hg->heads = 0xff;
+	hg->sectors = 0x3f;
+	sector_div(cylinders, hg->heads * hg->sectors);
 	hg->cylinders = cylinders;
-
-	DPRINT_INFO(BLKVSC_DRV, "CHS (%d, %d, %d)", cylinders, heads,
-		    sectors_per_track);
-
+	if ((sector_t)(hg->cylinders + 1) * hg->heads * hg->sectors < nsect)
+		hg->cylinders = 0xffff;
 	return 0;
+
 }
 
 
-- 
1.7.4.1
