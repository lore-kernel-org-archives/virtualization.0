From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v7 05/19] virtgpu: pull in uaccess.h
Date: Mon, 6 Apr 2020 21:07:36 -0400
Message-ID: <20200407010700.446571-6-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In preparation to virtio header changes, include uaccess.h directly as
this file is using copy to/from user.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 205ec4abae2b..2342a8baa5f8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -27,6 +27,7 @@
 
 #include <linux/file.h>
 #include <linux/sync_file.h>
+#include <linux/uacess.h>
 
 #include <drm/drm_file.h>
 #include <drm/virtgpu_drm.h>
-- 
MST
