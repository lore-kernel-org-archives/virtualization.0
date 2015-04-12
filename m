From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 1/2] virtio_balloon: header update for virtio 1
Date: Sun, 12 Apr 2015 17:00:44 +0200
Message-ID: <1428849904-28953-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

add modern header.
This patch is for virtio 1.0 branch, doesn't
apply to master.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/virtio-balloon.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index f863bfe..79eca67 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -56,6 +56,12 @@ typedef struct VirtIOBalloonStat {
     uint64_t val;
 } QEMU_PACKED VirtIOBalloonStat;
 
+typedef struct virtio_balloon_stat_modern {
+       uint16_t tag;
+       uint8_t reserved[6];
+       uint64_t val;
+} VirtIOBalloonStatModern;
+
 typedef struct VirtIOBalloon {
     VirtIODevice parent_obj;
     VirtQueue *ivq, *dvq, *svq;
-- 
MST
