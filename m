From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/4] qxl: read monitors config at boot
Date: Wed,  8 Mar 2017 10:19:06 +0100
Message-ID: <1488964751-22763-7-git-send-email-kraxel__909.798386465077$1488964832$gmane$org@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-rpi-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, David Airlie <airlied@linux.ie>, catalin.marinas@arm.com, will.deacon@arm.com, "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, eric@anholt.net, stefan.wahren@i2se.com, f.fainelli@gmail.com, lee@kernel.org, linux@armlinux.org.uk, bcm-kernel-feedback-list@broadcom.com, Dave Airlie <airlied@redhat.com>, devicetree@vger.kernel.org, rjui@broadcom.com, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, sbranden@broadcom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Try to read the client monitors config at driver load time, even without
explicit notification.  So in case that info was filled before the driver
loaded and we've missed the notifications because of that the settings
will still be used.

With that place we now have to take care to properly handle a empty client
monitors config, so we don't trip over an uninitialized client monitors
config.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 2b99496..cf99ace 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -81,6 +81,10 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 			   qdev->rom->client_monitors_config_crc);
 		return MONITORS_CONFIG_BAD_CRC;
 	}
+	if (!num_monitors) {
+		DRM_DEBUG_KMS("no client monitors configured\n");
+		return status;
+	}
 	if (num_monitors > qdev->monitors_config->max_allowed) {
 		DRM_DEBUG_KMS("client monitors list will be truncated: %d < %d\n",
 			      qdev->monitors_config->max_allowed, num_monitors);
@@ -1192,6 +1196,7 @@ int qxl_modeset_init(struct qxl_device *qdev)
 		qdev_output_init(&qdev->ddev, i);
 	}
 
+	qxl_display_read_client_monitors_config(qdev);
 	qdev->mode_info.mode_config_initialized = true;
 
 	drm_mode_config_reset(&qdev->ddev);
-- 
1.8.3.1
