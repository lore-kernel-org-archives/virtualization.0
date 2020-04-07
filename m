From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v7 08/19] virtio_input: pull in slab.h
Date: Mon, 6 Apr 2020 21:07:43 -0400
Message-ID: <20200407010700.446571-9-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In preparation to virtio header changes, include slab.h directly as
this module is using it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 5ae529671b3d..efaf65b0f42d 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -3,6 +3,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/input.h>
+#include <linux/slab.h>
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
-- 
MST
