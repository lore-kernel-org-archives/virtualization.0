From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 04/11] virtio_console: Rename jump labels in virtcons_probe()
Date: Wed, 14 Sep 2016 16:03:15 +0200
Message-ID: <b1201791-5078-ca9d-e5af-df6ebd05d67b__28009.4667374671$1473861861$gmane$org@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	<020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <020438b9-a7f8-0050-04c1-43382ba60b75@users.sourceforge.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, Amit Shah <amit.shah@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Michael S. Tsirkin" <mst@redhat.com>, Rusty Russell <rusty@rustcorp.com.au>
Cc: Julia Lawall <julia.lawall@lip6.fr>, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 14 Sep 2016 14:24:05 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/virtio_console.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 004314e..768bbb7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2037,7 +2037,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 	portdev = kmalloc(sizeof(*portdev), GFP_KERNEL);
 	if (!portdev) {
 		err = -ENOMEM;
-		goto fail;
+		goto exit;
 	}
 
 	/* Attach this portdev to this virtio_device, and vice-versa. */
@@ -2051,7 +2051,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 			"Error %d registering chrdev for device %u\n",
 			portdev->chr_major, vdev->index);
 		err = portdev->chr_major;
-		goto free;
+		goto free_port;
 	}
 
 	multiport = false;
@@ -2068,7 +2068,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 	err = init_vqs(portdev);
 	if (err < 0) {
 		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
-		goto free_chrdev;
+		goto unregister;
 	}
 
 	spin_lock_init(&portdev->ports_lock);
@@ -2091,7 +2091,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 			dev_err(&vdev->dev,
 				"Error allocating buffers for control queue\n");
 			err = -ENOMEM;
-			goto free_vqs;
+			goto send_control_message;
 		}
 	} else {
 		/*
@@ -2121,17 +2121,16 @@ static int virtcons_probe(struct virtio_device *vdev)
 		wait_for_completion(&early_console_added);
 
 	return 0;
-
-free_vqs:
+ send_control_message:
 	/* The host might want to notify mgmt sw about device add failure */
 	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
 			   VIRTIO_CONSOLE_DEVICE_READY, 0);
 	remove_vqs(portdev);
-free_chrdev:
+ unregister:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
-free:
+ free_port:
 	kfree(portdev);
-fail:
+ exit:
 	return err;
 }
 
-- 
2.10.0
