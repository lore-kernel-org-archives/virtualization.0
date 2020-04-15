From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 59/59] drm/bochs: Remove explicit drm_connector_register
Date: Wed, 15 Apr 2020 09:40:34 +0200
Message-ID: <20200415074034.175360-60-daniel.vetter@ffwll.ch>
References: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200415074034.175360-1-daniel.vetter@ffwll.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Intel Graphics Development <intel-gfx@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, virtualization@lists.linux-foundation.org, DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: virtualization@lists.linuxfoundation.org

This is leftovers from the old drm_driver->load callback
upside-down issues. It doesn't do anything for not-hotplugged
connectors since drm_dev_register takes care of that.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
---
 drivers/gpu/drm/bochs/bochs_kms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 7f4bcfad87e9..05d8373888e8 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -104,7 +104,6 @@ static void bochs_connector_init(struct drm_device *dev)
 			   DRM_MODE_CONNECTOR_VIRTUAL);
 	drm_connector_helper_add(connector,
 				 &bochs_connector_connector_helper_funcs);
-	drm_connector_register(connector);
 
 	bochs_hw_load_edid(bochs);
 	if (bochs->edid) {
-- 
2.25.1
