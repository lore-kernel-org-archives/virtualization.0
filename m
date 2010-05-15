From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 1/4] drivers/char: Eliminate use after free
Date: Sat, 15 May 2010 11:45:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005151145340.15566__5268.87972741878$1273916805$gmane$org@ask.diku.dk>
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
To: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Julia Lawall <julia@diku.dk>

In each case, the first argument to send_control_msg or __send_control_msg,
respectively, has either not been successfully allocated or has been freed
at the point of the call.  In the first case, the first argument, port, is
only used to access the portdev and id fields, in order to call
__send_control_msg.  Thus it seems possible instead to call
__send_control_msg directly.  In the second case, the call to
__send_control_msg is moved up to a place where it seems like the first
argument, portdev, has been initialized sufficiently to make the call to
__send_control_msg meaningful.

This has only been compile tested.

A simplified version of the semantic match that finds this problem is as
follows: (http://coccinelle.lip6.fr/)

// <smpl>
@free@
expression E;
position p;
@@
kfree@p(E)

@@
expression free.E, subE<=free.E, E1;
position free.p;
@@

  kfree@p(E)
  ...
(
  subE = E1
|
* E
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 drivers/char/virtio_console.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 458d907..8c99bf1 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1090,7 +1090,7 @@ free_port:
 	kfree(port);
 fail:
 	/* The host might want to notify management sw about port add failure */
-	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 0);
+	__send_control_msg(portdev, id, VIRTIO_CONSOLE_PORT_READY, 0);
 	return err;
 }
 
@@ -1559,6 +1559,9 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	return 0;
 
 free_vqs:
+	/* The host might want to notify mgmt sw about device add failure */
+	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
+			   VIRTIO_CONSOLE_DEVICE_READY, 0);
 	vdev->config->del_vqs(vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
@@ -1567,9 +1570,6 @@ free_chrdev:
 free:
 	kfree(portdev);
 fail:
-	/* The host might want to notify mgmt sw about device add failure */
-	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
-			   VIRTIO_CONSOLE_DEVICE_READY, 0);
 	return err;
 }
