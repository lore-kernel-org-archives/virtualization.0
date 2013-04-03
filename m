From: Asias He <asias@redhat.com>
Subject: [PATCH V3 2/2] tcm_vhost: Initialize vq->last_used_idx when set
	endpoint
Date: Wed,  3 Apr 2013 14:17:38 +0800
Message-ID: <1364969858-9410-3-git-send-email-asias@redhat.com>
References: <1364969858-9410-1-git-send-email-asias@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1364969858-9410-1-git-send-email-asias@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Nicholas Bellinger <nab@linux-iscsi.org>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This patch fixes guest hang when booting seabios and guest.

  [    0.576238] scsi0 : Virtio SCSI HBA
  [    0.616754] virtio_scsi virtio1: request:id 0 is not a head!

vq->last_used_idx is initialized only when /dev/vhost-scsi is
opened or closed.

   vhost_scsi_open -> vhost_dev_init() -> vhost_vq_reset()
   vhost_scsi_release() -> vhost_dev_cleanup -> vhost_vq_reset()

So, when guest talks to tcm_vhost after seabios does, vq->last_used_idx
still contains the old valule for seabios. This confuses guest.

Fix this by calling vhost_init_used() to init vq->last_used_idx when
we set endpoint.

Signed-off-by: Asias He <asias@redhat.com>
---
 drivers/vhost/tcm_vhost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/tcm_vhost.c b/drivers/vhost/tcm_vhost.c
index 11121ea..a10efd3 100644
--- a/drivers/vhost/tcm_vhost.c
+++ b/drivers/vhost/tcm_vhost.c
@@ -865,6 +865,7 @@ static int vhost_scsi_set_endpoint(
 			/* Flushing the vhost_work acts as synchronize_rcu */
 			mutex_lock(&vq->mutex);
 			rcu_assign_pointer(vq->private_data, vs_tpg);
+			vhost_init_used(vq);
 			mutex_unlock(&vq->mutex);
 		}
 		ret = 0;
-- 
1.8.1.4
