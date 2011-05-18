From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC] vhost: fix enable notify: write out last avail value we
	saw
Date: Thu, 19 May 2011 00:13:39 +0300
Message-ID: <20110518211339.GA26122__33905.3765674636$1305753293$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Krishna Kumar2 <krkumar2@in.ibm.com>, habanero@linux.vnet.ibm.com, kvm@vger.kernel.org, steved@us.ibm.com, netdev@vger.kernel.org, Shirley Ma <mashirle@us.ibm.com>, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com, Tom Lendacky <tahm@linux.vnet.ibm.com>, avi@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

With RX ring and mergeable buffers, vhost-net sometimes
enables notifications when ring is not empty - just
doesn't have enough entries for the incoming packet.

To get event when entries are added in this case,
we should always write out the last index value
we saw into event index field, which is ahead
of the index we have consumed.

Otherwise we get a kick, see that there are not enough
entries in the ring, reenable notifications
but since last used index was not updated
we don't get any more events.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

This bugfix is on top of my patchset, I'm working on addressing
Rusty's comments for that now.

Will push to my git tree event idx branch for everyone's testing pleasure
shortly.


 drivers/vhost/vhost.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 2aea4cb..1267a3d 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1438,7 +1438,7 @@ bool vhost_enable_notify(struct vhost_dev *dev, struct vhost_virtqueue *vq)
 			return false;
 		}
 	} else {
-		r = put_user(vq->last_avail_idx, vhost_avail_event(vq));
+		r = put_user(vq->avail_idx, vhost_avail_event(vq));
 		if (r) {
 			vq_err(vq, "Failed to update avail event index at %p: %d\n",
 			       vhost_avail_event(vq), r);
-- 
1.7.5.53.gc233e
