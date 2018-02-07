From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/bochs: make structure bochs_bo_driver static
Date: Wed,  7 Feb 2018 11:13:53 +0000
Message-ID: <20180207111353.30261-1-colin.king__15675.9863989011$1518001943$gmane$org@canonical.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, virtualization@lists.linux-foundation.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Colin Ian King <colin.king@canonical.com>

The structure bochs_bo_driver is local to the source and does not need to
be in global scope, so make it static.

Cleans up sparse warning:
drivers/gpu/drm/bochs/bochs_mm.c:197:22: warning: symbol 'bochs_bo_driver'
was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/bochs/bochs_mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 704e879711e4..b1d5aee46316 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -194,7 +194,7 @@ static struct ttm_tt *bochs_ttm_tt_create(struct ttm_bo_device *bdev,
 	return tt;
 }
 
-struct ttm_bo_driver bochs_bo_driver = {
+static struct ttm_bo_driver bochs_bo_driver = {
 	.ttm_tt_create = bochs_ttm_tt_create,
 	.ttm_tt_populate = ttm_pool_populate,
 	.ttm_tt_unpopulate = ttm_pool_unpopulate,
-- 
2.15.1
