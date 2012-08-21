From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [RFC-v3 5/5] virtio-scsi: Set max_target=0 during vhost-scsi operation
Date: Tue, 21 Aug 2012 20:52:11 +0000
Message-ID: <1345582331-22593-6-git-send-email-nab__1132.14769303358$1345582619$gmane$org@linux-iscsi.org>
References: <1345582331-22593-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1345582331-22593-1-git-send-email-nab@linux-iscsi.org>
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

From: Nicholas Bellinger <nab@linux-iscsi.org>

This QEMU patch sets VirtIOSCSIConfig->max_target=0 for vhost-scsi operation
to restrict virtio-scsi LLD guest scanning to max_id=0 (a single target ID
instance) when connected to individual tcm_vhost endpoints.

This ensures that virtio-scsi LLD only attempts to scan target IDs up to
VIRTIO_SCSI_MAX_TARGET when connected via virtio-scsi-raw.

Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Zhi Yong Wu <wuzhy@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 hw/virtio-scsi.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/hw/virtio-scsi.c b/hw/virtio-scsi.c
index edda097..ab5ca72 100644
--- a/hw/virtio-scsi.c
+++ b/hw/virtio-scsi.c
@@ -546,7 +546,11 @@ static void virtio_scsi_get_config(VirtIODevice *vdev,
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
