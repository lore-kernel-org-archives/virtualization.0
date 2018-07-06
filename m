From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/cirrus: flip default to 32bpp
Date: Fri,  6 Jul 2018 11:12:49 +0200
Message-ID: <20180706091249.25086-1-kraxel__26889.4561370418$1530868278$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

cirrus can handle 1024x768 (and slightly higher) with 24bpp depth.
cirrus can handle up to 800x600 with 32bpp.

The problem with 24bpp is that it is a rather unusual depth these days,
cirrus is pretty much the only relevant device still using that, and it
is a endless source of issues.  Wayland doesn't support it at all.  Bugs
in Xorg keep showing up.

So using 32bpp by default is the better choice IMO, even if it comes
with the drawback that the resolution is 800x600 only.  But hey, better
a working 800x600 display than a broken 1024x768 display ...

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirrus/cirrus_drv.c
index 69c4e352dd..e9e5a92a36 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.c
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.c
@@ -16,11 +16,11 @@
 #include "cirrus_drv.h"
 
 int cirrus_modeset = -1;
-int cirrus_bpp = 24;
+int cirrus_bpp = 32;
 
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, cirrus_modeset, int, 0400);
-MODULE_PARM_DESC(bpp, "Max bits-per-pixel (default:24)");
+MODULE_PARM_DESC(bpp, "Max bits-per-pixel (default:32)");
 module_param_named(bpp, cirrus_bpp, int, 0400);
 
 /*
-- 
2.9.3
