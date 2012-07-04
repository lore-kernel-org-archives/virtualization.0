From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: [PATCH 6/6] virtio-scsi: Set shost->max_id=1 for tcm_vhost WWPNs
Date: Wed,  4 Jul 2012 04:24:06 +0000
Message-ID: <1341375846-27882-7-git-send-email-nab__10608.2946913832$1341376059$gmane$org@linux-iscsi.org>
References: <1341375846-27882-1-git-send-email-nab@linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1341375846-27882-1-git-send-email-nab@linux-iscsi.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Zhi Yong Wu <wuzhy@cn.ibm.com>, Anthony Liguori <aliguori@linux.vnet.ibm.com>, linux-scsi <linux-scsi@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, lf-virt <virtualization@lists.linux-foundation.org>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

From: Nicholas Bellinger <nab@linux-iscsi.org>

This is currently required for connecting to tcm_vhost in order to prevent
the client LUN scan from detecting the same tcm_vhost WWPN on multiple target
IDs.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Cc: Zhi Yong Wu <wuzhy@cn.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
---
 drivers/scsi/virtio_scsi.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 391b30d..8711951 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -475,7 +475,10 @@ static int __devinit virtscsi_probe(struct virtio_device *vdev)
 	shost->cmd_per_lun = min_t(u32, cmd_per_lun, shost->can_queue);
 	shost->max_sectors = virtscsi_config_get(vdev, max_sectors) ?: 0xFFFF;
 	shost->max_lun = virtscsi_config_get(vdev, max_lun) + 1;
-	shost->max_id = virtscsi_config_get(vdev, max_target) + 1;
+	/*
+	 * Currently required for tcm_vhost to function..
+	 */
+	shost->max_id = 1;
 	shost->max_channel = 0;
 	shost->max_cmd_len = VIRTIO_SCSI_CDB_SIZE;
 	err = scsi_add_host(shost, &vdev->dev);
-- 
1.7.2.5
