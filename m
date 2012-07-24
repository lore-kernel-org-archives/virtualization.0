From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [RFC 5/9] virtio-scsi: Add wwpn and tgpt properties
Date: Tue, 24 Jul 2012 22:34:02 +0000
Message-ID: <1343169246-17636-6-git-send-email-nab__4745.03088412366$1343169485$gmane$org@linux-iscsi.org>
References: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1343169246-17636-1-git-send-email-nab@linux-iscsi.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>

A vhost-scsi device must be bound to a tcm_vhost target port.  This will
be done by issuing an ioctl to the device with the wwpn and tgpt.  This
patch adds these properties to the virtio-scsi-pci device:

  qemu -device virtio-scsi-pci,wwpn=$TARGET_WWN,tgpt=$TPGT

Future patches will open /dev/vhost-scsi and issue the ioctl.

This patch also moves the virtio_scsi_init() prototype to
hw/virtio-scsi.h where the VirtIOSCSIConf structure is defined.  I think
this is cleaner than defining it in hw/virtio.h.

(v2: Use modern VirtIOSCSIConf define in virtio-scsi.h)

Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Signed-off-by: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/virtio-scsi.c |    2 ++
 hw/virtio-scsi.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
index 0a5ac40..4a787d3 100644
--- a/hw/virtio-scsi.c
+++ b/hw/virtio-scsi.c
@@ -13,6 +13,8 @@
  *
  */
 
+#include "qemu-common.h"
+#include "qemu-error.h"
 #include "virtio-scsi.h"
 #include <hw/scsi.h>
 #include <hw/scsi-defs.h>
diff --git a/hw/virtio-scsi.h b/hw/virtio-scsi.h
index 4bc889d..74e9422 100644
--- a/hw/virtio-scsi.h
+++ b/hw/virtio-scsi.h
@@ -22,6 +22,7 @@
 #define VIRTIO_ID_SCSI  8
 
 struct VirtIOSCSIConf {
+    VHostSCSI *vhost_scsi;
     uint32_t num_queues;
     uint32_t max_sectors;
     uint32_t cmd_per_lun;
-- 
1.7.2.5
