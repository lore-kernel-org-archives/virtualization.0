From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 22/23] drm/qxl: use kernel mode db
Date: Fri, 18 Jan 2019 13:20:19 +0100
Message-ID: <20190118122020.27596-23-kraxel__28458.7079695941$1547814092$gmane$org@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Add all standard modes from the kernel's video mode data base.
Keep a few non-standard modes in the qxl mode list.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 926fcb49b2..df768b0c83 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -262,34 +262,20 @@ static int qxl_add_monitors_config_modes(struct drm_connector *connector)
 static struct mode_size {
 	int w;
 	int h;
-} common_modes[] = {
-	{ 640,  480},
+} extra_modes[] = {
 	{ 720,  480},
-	{ 800,  600},
-	{ 848,  480},
-	{1024,  768},
 	{1152,  768},
-	{1280,  720},
-	{1280,  800},
 	{1280,  854},
-	{1280,  960},
-	{1280, 1024},
-	{1440,  900},
-	{1400, 1050},
-	{1680, 1050},
-	{1600, 1200},
-	{1920, 1080},
-	{1920, 1200}
 };
 
-static int qxl_add_common_modes(struct drm_connector *connector)
+static int qxl_add_extra_modes(struct drm_connector *connector)
 {
 	int i, ret = 0;
 
-	for (i = 0; i < ARRAY_SIZE(common_modes); i++)
+	for (i = 0; i < ARRAY_SIZE(extra_modes); i++)
 		ret += qxl_add_mode(connector,
-				    common_modes[i].w,
-				    common_modes[i].h,
+				    extra_modes[i].w,
+				    extra_modes[i].h,
 				    false);
 	return ret;
 }
@@ -1010,7 +996,8 @@ static int qxl_conn_get_modes(struct drm_connector *connector)
 			pheight = head->height;
 	}
 
-	ret += qxl_add_common_modes(connector);
+	ret += drm_add_modes_noedid(connector, 8192, 8192);
+	ret += qxl_add_extra_modes(connector);
 	ret += qxl_add_monitors_config_modes(connector);
 	drm_set_preferred_mode(connector, pwidth, pheight);
 	return ret;
-- 
2.9.3
