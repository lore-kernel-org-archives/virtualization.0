From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH] hw/virtio-scsi: Set max_target=0 during vhost-scsi operation
Date: Wed, 11 Jul 2012 20:55:28 +0000
Message-ID: <1342040128-29176-1-git-send-email-nab__827.950603752647$1342040313$gmane$org@linux-iscsi.org>
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
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Zhi Yong Wu <wuzhy@cn.ibm.com>, target-devel <target-devel@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

This QEMU patch sets VirtIOSCSIConfig->max_target=0 for vhost-scsi operation
to restrict virtio-scsi LLD guest scanning to max_id=0 (a single target ID
instance) when connected to individual tcm_vhost endpoints as requested by
Paolo.

This ensures that virtio-scsi LLD only attempts to scan target IDs up to
VIRTIO_SCSI_MAX_TARGET when connected via virtio-scsi-raw.

It's currently cut against Zhi's qemu vhost-scsi tree here:

   https://github.com/wuzhy/qemu/tree/vhost-scsi

Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/virtio-scsi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
index e38cdd0..71276b6 100644
--- a/hw/virtio-scsi.c
+++ b/hw/virtio-scsi.c
@@ -523,7 +523,11 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
     stl_raw(&scsiconf->sense_size, s->sense_size);
     stl_raw(&scsiconf->cdb_size, s->cdb_size);
     stl_raw(&scsiconf->max_channel, VIRTIO_SCSI_MAX_CHANNEL);
-    stl_raw(&scsiconf->max_target, VIRTIO_SCSI_MAX_TARGET);
+    if (s->vhost_scsi) {
+        stl_raw(&scsiconf->max_target, 0);
+    } else {
+        stl_raw(&scsiconf->max_target, VIRTIO_SCSI_MAX_TARGET);
+    }
     stl_raw(&scsiconf->max_lun, VIRTIO_SCSI_MAX_LUN);
 }
 
-- 
1.7.2.5
