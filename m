From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: virtio-balloon: check for freezer in kthread loop
Date: Thu, 16 Apr 2009 21:14:04 -0300
Message-ID: <20090417001404.GA20251@amt.cnet>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


Break out of wait_event_interruptible() if freezing has been requested,
in the vballoon thread. Without this change vballoon refuses to stop and
the system can't suspend.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 5926826..9c76a06 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -190,7 +190,8 @@ static int balloon(void *_vballoon)
 		try_to_freeze();
 		wait_event_interruptible(vb->config_change,
 					 (diff = towards_target(vb)) != 0
-					 || kthread_should_stop());
+					 || kthread_should_stop()
+					 || freezing(current));
 		if (diff > 0)
 			fill_balloon(vb, diff);
 		else if (diff < 0)
