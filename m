From: Lepton Wu <ytht.net@gmail.com>
Subject: [PATCH] drm/cirrus: add create_handle support.
Date: Wed,  8 Nov 2017 10:55:37 -0800
Message-ID: <20171108185537.56167-1-ytht.net@gmail.com>
References: <20171108125659.oyjzylx26zmz7753@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171108125659.oyjzylx26zmz7753@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: airlied@redhat.com, kraxel@redhat.com
Cc: Lepton Wu <ytht.net@gmail.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Add create_handle support to cirrus fb. Without this, screenshot tool
in chromium OS can't work.

Signed-off-by: Lepton Wu <ytht.net@gmail.com>
---
 drivers/gpu/drm/cirrus/cirrus_main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/cirrus/cirrus_main.c b/drivers/gpu/drm/cirrus/cirrus_main.c
index b5f528543956..26df1e8cd490 100644
--- a/drivers/gpu/drm/cirrus/cirrus_main.c
+++ b/drivers/gpu/drm/cirrus/cirrus_main.c
@@ -13,6 +13,14 @@
 
 #include "cirrus_drv.h"
 
+static int cirrus_create_handle(struct drm_framebuffer *fb,
+				struct drm_file* file_priv,
+				unsigned int* handle)
+{
+	struct cirrus_framebuffer *cirrus_fb = to_cirrus_framebuffer(fb);
+
+	return drm_gem_handle_create(file_priv, cirrus_fb->obj, handle);
+}
 
 static void cirrus_user_framebuffer_destroy(struct drm_framebuffer *fb)
 {
@@ -24,6 +32,7 @@ static void cirrus_user_framebuffer_destroy(struct drm_framebuffer *fb)
 }
 
 static const struct drm_framebuffer_funcs cirrus_fb_funcs = {
+	.create_handle = cirrus_create_handle,
 	.destroy = cirrus_user_framebuffer_destroy,
 };
 
-- 
2.15.0.403.gc27cc4dac6-goog
