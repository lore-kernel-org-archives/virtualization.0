From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 1/2] KVM: s390: virtio-ccw: Handle command rejects.
Date: Fri,  7 Jun 2013 12:37:10 +0200
Message-ID: <1370601431-46381-2-git-send-email-cornelia.huck__16634.5237907537$1370601481$gmane$org@de.ibm.com>
References: <1370601431-46381-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1370601431-46381-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

A command reject for a ccw may happen if we run on a host not supporting
a certain feature. We want to be able to handle this as special case of
command failure, so let's split this off from the generic -EIO error code.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 779dc51..d6c7aba 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -639,8 +639,15 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 	     (SCSW_STCTL_ALERT_STATUS | SCSW_STCTL_STATUS_PEND))) {
 		/* OK */
 	}
-	if (irb_is_error(irb))
-		vcdev->err = -EIO; /* XXX - use real error */
+	if (irb_is_error(irb)) {
+		/* Command reject? */
+		if ((scsw_dstat(&irb->scsw) & DEV_STAT_UNIT_CHECK) &&
+		    (irb->ecw[0] & SNS0_CMD_REJECT))
+			vcdev->err = -EOPNOTSUPP;
+		else
+			/* Map everything else to -EIO. */
+			vcdev->err = -EIO;
+	}
 	if (vcdev->curr_io & activity) {
 		switch (activity) {
 		case VIRTIO_CCW_DOING_READ_FEAT:
-- 
1.8.1.6
