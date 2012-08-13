From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [RFC-v2 2/6] vhost: Pass device path to vhost_dev_init()
Date: Mon, 13 Aug 2012 08:35:13 +0000
Message-ID: <1344846917-7411-3-git-send-email-nab__29216.6227860891$1344847168$gmane$org@linux-iscsi.org>
References: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1344846917-7411-1-git-send-email-nab@linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: target-devel <target-devel@vger.kernel.org>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

The path to /dev/vhost-net is currently hardcoded in vhost_dev_init().
This needs to be changed so that /dev/vhost-scsi can be used.  Pass in
the device path instead of hardcoding it.

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/vhost.c     |    5 +++--
 hw/vhost.h     |    3 ++-
 hw/vhost_net.c |    2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vhost.c b/hw/vhost.c
index 0fd8da8..d0ce5aa 100644
--- a/hw/vhost.c
+++ b/hw/vhost.c
@@ -747,14 +747,15 @@ static void vhost_eventfd_del(MemoryListener *listener,
 {
 }
 
-int vhost_dev_init(struct vhost_dev *hdev, int devfd, bool force)
+int vhost_dev_init(struct vhost_dev *hdev, int devfd, const char *devpath,
+                   bool force)
 {
     uint64_t features;
     int r;
     if (devfd >= 0) {
         hdev->control = devfd;
     } else {
-        hdev->control = open("/dev/vhost-net", O_RDWR);
+        hdev->control = open(devpath, O_RDWR);
         if (hdev->control < 0) {
             return -errno;
         }
diff --git a/hw/vhost.h b/hw/vhost.h
index 80e64df..0c47229 100644
--- a/hw/vhost.h
+++ b/hw/vhost.h
@@ -44,7 +44,8 @@ struct vhost_dev {
     bool force;
 };
 
-int vhost_dev_init(struct vhost_dev *hdev, int devfd, bool force);
+int vhost_dev_init(struct vhost_dev *hdev, int devfd, const char *devpath,
+                   bool force);
 void vhost_dev_cleanup(struct vhost_dev *hdev);
 bool vhost_dev_query(struct vhost_dev *hdev, VirtIODevice *vdev);
 int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev);
diff --git a/hw/vhost_net.c b/hw/vhost_net.c
index ecaa22d..df2c4a3 100644
--- a/hw/vhost_net.c
+++ b/hw/vhost_net.c
@@ -109,7 +109,7 @@ struct vhost_net *vhost_net_init(NetClientState *backend, int devfd,
         (1 << VHOST_NET_F_VIRTIO_NET_HDR);
     net->backend = r;
 
-    r = vhost_dev_init(&net->dev, devfd, force);
+    r = vhost_dev_init(&net->dev, devfd, "/dev/vhost-net", force);
     if (r < 0) {
         goto fail;
     }
-- 
1.7.2.5
