From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio: console: Enable call to hvc_remove() on console port
	remove
Date: Mon, 14 Mar 2011 17:45:48 +0530
Message-ID: <9c2f9e719157c3330a60963a1da96f68589aa0f4.1300104945.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

This call was disabled as hot-unplugging one virtconsole port led to
another virtconsole port freezing.

Upon testing it again, this now works, so enable it.

In addition, a bug was found in qemu wherein removing a port of one type
caused the guest output from another port to stop working.  I doubt it
was just this bug that caused it (since disabling the hvc_remove() call
did allow other ports to continue working), but since it's all solved
now, we're fine with hot-unplugging of virtconsole ports.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   11 -----------
 1 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 84b164d..838568a 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1280,18 +1280,7 @@ static void unplug_port(struct port *port)
 		spin_lock_irq(&pdrvdata_lock);
 		list_del(&port->cons.list);
 		spin_unlock_irq(&pdrvdata_lock);
-#if 0
-		/*
-		 * hvc_remove() not called as removing one hvc port
-		 * results in other hvc ports getting frozen.
-		 *
-		 * Once this is resolved in hvc, this functionality
-		 * will be enabled.  Till that is done, the -EPIPE
-		 * return from get_chars() above will help
-		 * hvc_console.c to clean up on ports we remove here.
-		 */
 		hvc_remove(port->cons.hvc);
-#endif
 	}
 
 	/* Remove unused data this port might have received. */
-- 
1.7.4
