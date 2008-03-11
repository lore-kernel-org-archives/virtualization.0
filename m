From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/4] virtio: handle > 2 billion page balloon targets
Date: Tue, 11 Mar 2008 23:05:23 +1100
Message-ID: <200803112305.23648.rusty__22125.373062636$1205237372$gmane$org@rustcorp.com.au>
References: <200803112303.22984.rusty@rustcorp.com.au>
	<200803112304.21680.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803112304.21680.rusty@rustcorp.com.au>
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
Cc: Jeremy Katz <katzj@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

If the host asks for a huge target towards_target() can overflow, and
we up oops as we try to release more pages than we have.  The simple
fix is to use a 64-bit value.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_balloon.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -r fd0c80dbbd95 drivers/virtio/virtio_balloon.c
--- a/drivers/virtio/virtio_balloon.c	Tue Mar 11 09:21:00 2008 +1100
+++ b/drivers/virtio/virtio_balloon.c	Tue Mar 11 11:25:52 2008 +1100
@@ -152,7 +152,7 @@ static void virtballoon_changed(struct v
 	wake_up(&vb->config_change);
 }
 
-static inline int towards_target(struct virtio_balloon *vb)
+static inline s64 towards_target(struct virtio_balloon *vb)
 {
 	u32 v;
 	__virtio_config_val(vb->vdev,
@@ -176,7 +183,7 @@ static int balloon(void *_vballoon)
 
 	set_freezable();
 	while (!kthread_should_stop()) {
-		int diff;
+		s64 diff;
 
 		try_to_freeze();
 		wait_event_interruptible(vb->config_change,
