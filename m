From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] vhost/scsi: drop unnecessary smp_mb__after_atomic()
Date: Tue, 16 Apr 2019 11:47:48 +0100
Message-ID: <20190416104748.26942-1-stefanha__46811.8418751814$1555411690$gmane$org@redhat.com>
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
To: kvm@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

The vhost_scsi.ko code used several atomic variables at one point.
Later they were dropped or converted to regular ints protected by a
mutex.

The commit that made these changes left an unused smp_mb__after_atomic()
in vhost_scsi_set_endpoint().  It was previously used after incrementing
vhost_scsi->vhost_ref_cnt but this field has been dropped:

  -     atomic_inc(&vs->vhost_ref_cnt);
        smp_mb__after_atomic_inc();

Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Fixes: 101998f6fcd680 ("tcm_vhost: Post-merge review changes requested by MST")
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/vhost/scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 618fb6461017..c090d177bd75 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1443,7 +1443,6 @@ vhost_scsi_set_endpoint(struct vhost_scsi *vs,
 			tpg->tv_tpg_vhost_count++;
 			tpg->vhost_scsi = vs;
 			vs_tpg[tpg->tport_tpgt] = tpg;
-			smp_mb__after_atomic();
 			match = true;
 		}
 		mutex_unlock(&tpg->tv_tpg_mutex);
-- 
2.20.1
