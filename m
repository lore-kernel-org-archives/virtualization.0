From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/bochs: add edid present check
Date: Tue, 18 Dec 2018 08:33:39 +0100
Message-ID: <20181218073339.12160-1-kraxel__46292.0228405439$1545118300$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Check first two header bytes before trying to read the edid blob,
to avoid the log being spammed in case qemu has no edid support (old
qemu or edid turned off).

Fixes: 01f23459cf drm/bochs: add edid support.
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_hw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index c90a0d492f..f91e049625 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -89,6 +89,10 @@ int bochs_hw_load_edid(struct bochs_device *bochs)
 	if (!bochs->mmio)
 		return -1;
 
+	if (readb(bochs->mmio + 0) != 0x00 ||
+	    readb(bochs->mmio + 1) != 0xff)
+		return -1;
+
 	kfree(bochs->edid);
 	bochs->edid = drm_do_get_edid(&bochs->connector,
 				      bochs_get_edid_block, bochs);
-- 
2.9.3
