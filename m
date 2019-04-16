From: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] vhost-scsi: remove incorrect memory barrier
Date: Tue, 16 Apr 2019 10:56:08 +0200
Message-ID: <1555404968-39927-1-git-send-email-pbonzini__15579.4970154361$1555404984$gmane$org@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, virtualization@lists.linux-foundation.org, stefanha@redhat.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

At this point, vs_tpg is not public at all; tv_tpg_vhost_count
is accessed under tpg->tv_tpg_mutex; tpg->vhost_scsi is
accessed under vhost_scsi_mutex.  Therefor there are no atomic
operations involved at all here, just remove the barrier.

Reported-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/vhost/scsi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 618fb6461017..c090d177bd75 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1443,7 +1443,6 @@ static void vhost_scsi_flush(struct vhost_scsi *vs)
 			tpg->tv_tpg_vhost_count++;
 			tpg->vhost_scsi = vs;
 			vs_tpg[tpg->tport_tpgt] = tpg;
-			smp_mb__after_atomic();
 			match = true;
 		}
 		mutex_unlock(&tpg->tv_tpg_mutex);
-- 
1.8.3.1
