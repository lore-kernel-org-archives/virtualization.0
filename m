From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] virtio console: don't manually set or finalize
	VIRTIO_CONSOLE_F_MULTIPORT.
Date: Wed, 09 Mar 2011 13:25:30 +1030
Message-ID: <87ei6hknod.fsf@rustcorp.com.au>
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
To: Amit Shah <amit.shah@redhat.com>
Cc: alexey.kardashevskiy@au1.ibm.com, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

That's already been done by the virtio infrastructure before the probe
function is called.

Reported-by: alexey.kardashevskiy@au1.ibm.com
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1680,17 +1680,12 @@ static int __devinit virtcons_probe(stru
 	portdev->config.max_nr_ports = 1;
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
 		multiport = true;
-		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
-
 		vdev->config->get(vdev, offsetof(struct virtio_console_config,
 						 max_nr_ports),
 				  &portdev->config.max_nr_ports,
 				  sizeof(portdev->config.max_nr_ports));
 	}
 
-	/* Let the Host know we support multiple ports.*/
-	vdev->config->finalize_features(vdev);
-
 	err = init_vqs(portdev);
 	if (err < 0) {
 		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
