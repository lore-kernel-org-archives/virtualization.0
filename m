From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 05/19] virtgpu: pull in uaccess.h
Date: Mon, 6 Apr 2020 21:16:37 -0400
Message-ID: <20200407011612.478226-6-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

In preparation to virtio header changes, include uaccess.h directly as
this file is using copy to/from user.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 205ec4abae2b..289dabbce477 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -27,6 +27,7 @@
 
 #include <linux/file.h>
 #include <linux/sync_file.h>
+#include <linux/uaccess.h>
 
 #include <drm/drm_file.h>
 #include <drm/virtgpu_drm.h>
-- 
MST
