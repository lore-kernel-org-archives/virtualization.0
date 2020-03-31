From: Huacai Chen <chenhc@lemote.com>
Subject: [PATCH Resend] drm/qxl: Use correct notify port address when creating cursor ring
Date: Tue, 31 Mar 2020 14:18:08 +0800
Message-ID: <1585635488-17507-1-git-send-email-chenhc@lemote.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org, spice-devel@lists.freedesktop.org, Fuxin Zhang <zhangfx@lemote.com>, Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>, stable@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The command ring and cursor ring use different notify port addresses
definition: QXL_IO_NOTIFY_CMD and QXL_IO_NOTIFY_CURSOR. However, in
qxl_device_init() we use QXL_IO_NOTIFY_CMD to create both command ring
and cursor ring. This doesn't cause any problems now, because QEMU's
behaviors on QXL_IO_NOTIFY_CMD and QXL_IO_NOTIFY_CURSOR are the same.
However, QEMU's behavior may be change in future, so let's fix it.

P.S.: In the X.org QXL driver, the notify port address of cursor ring
      is correct.

Cc: <stable@vger.kernel.org>
Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/gpu/drm/qxl/qxl_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index bfc1631..9bdbe0d 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -218,7 +218,7 @@ int qxl_device_init(struct qxl_device *qdev,
 				&(qdev->ram_header->cursor_ring_hdr),
 				sizeof(struct qxl_command),
 				QXL_CURSOR_RING_SIZE,
-				qdev->io_base + QXL_IO_NOTIFY_CMD,
+				qdev->io_base + QXL_IO_NOTIFY_CURSOR,
 				false,
 				&qdev->cursor_event);
 
-- 
2.7.0
