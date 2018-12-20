From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3] drm/bochs: add edid present check
Date: Thu, 20 Dec 2018 11:11:21 +0100
Message-ID: <20181220101122.16153-1-kraxel__45482.4939406992$1545300596$gmane$org@redhat.com>
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
To: dri-devel@lists.freedesktop.org
Cc: andr2000@gmail.com, daniel.vetter@ffwll.ch, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>
List-Id: virtualization@lists.linuxfoundation.org

Check header before trying to read the complete edid blob, to avoid the
log being spammed in case qemu has no edid support (old qemu or edid
support turned off).

Fixes: 01f23459cf drm/bochs: add edid support.
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_hw.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index c90a0d492f..d0b4e1cee8 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -86,9 +86,16 @@ static int bochs_get_edid_block(void *data, u8 *buf,
 
 int bochs_hw_load_edid(struct bochs_device *bochs)
 {
+	u8 header[8];
+
 	if (!bochs->mmio)
 		return -1;
 
+	/* check header to detect whenever edid support is enabled in qemu */
+	bochs_get_edid_block(bochs, header, 0, ARRAY_SIZE(header));
+	if (drm_edid_header_is_valid(header) != 8)
+		return -1;
+
 	kfree(bochs->edid);
 	bochs->edid = drm_do_get_edid(&bochs->connector,
 				      bochs_get_edid_block, bochs);
-- 
2.9.3
