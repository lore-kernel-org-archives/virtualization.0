From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] vhost: fix log base address
Date: Wed, 15 Apr 2015 11:37:46 +0200
Message-ID: <1429090543-4736-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Resent-Message-ID: <20150415094106.GA4806@redhat.com>
Resent-To: virtualization@lists.linux-foundation.org
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Wen Congyang <wency@cn.fujitsu.com>
List-Id: virtualization@lists.linuxfoundation.org

VHOST_SET_LOG_BASE got an incorrect address, causing
migration errors and potentially even memory corruption.

Cc: Peter Maydell <peter.maydell@linaro.org>
Reported-by: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Could you please confirm this fixes the problem for you?

 hw/virtio/vhost.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 8dd2f59..02c5604 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1016,10 +1016,13 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
     }
 
     if (hdev->log_enabled) {
+        uint64_t log_base;
+
         hdev->log_size = vhost_get_log_size(hdev);
         hdev->log = hdev->log_size ?
             g_malloc0(hdev->log_size * sizeof *hdev->log) : NULL;
-        r = hdev->vhost_ops->vhost_call(hdev, VHOST_SET_LOG_BASE, hdev->log);
+        log_base = (uint64_t)(unsigned long)log_base;
+        r = hdev->vhost_ops->vhost_call(hdev, VHOST_SET_LOG_BASE, &log_base);
         if (r < 0) {
             r = -errno;
             goto fail_log;
-- 
MST
