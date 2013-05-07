From: Asias He <asias@redhat.com>
Subject: [PATCH] vhost-scsi: Enable VIRTIO_RING_F_EVENT_IDX
Date: Tue,  7 May 2013 14:51:49 +0800
Message-ID: <1367909509-11494-1-git-send-email-asias@redhat.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

It is disabled as a workaround. Now userspace bits works fine with it.
So, let's enable it.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/scsi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index d860b58..5531ebc 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -160,14 +160,8 @@ enum {
 	VHOST_SCSI_VQ_IO = 2,
 };
 
-/*
- * VIRTIO_RING_F_EVENT_IDX seems broken. Not sure the bug is in
- * kernel but disabling it helps.
- * TODO: debug and remove the workaround.
- */
 enum {
-	VHOST_SCSI_FEATURES = (VHOST_FEATURES & (~VIRTIO_RING_F_EVENT_IDX)) |
-			      (1ULL << VIRTIO_SCSI_F_HOTPLUG)
+	VHOST_SCSI_FEATURES = VHOST_FEATURES | (1ULL << VIRTIO_SCSI_F_HOTPLUG)
 };
 
 #define VHOST_SCSI_MAX_TARGET	256
-- 
1.8.1.4
