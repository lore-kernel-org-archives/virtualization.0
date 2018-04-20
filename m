From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 6/6] virtio_console: reset on out of memory
Date: Fri, 20 Apr 2018 21:18:06 +0300
Message-ID: <1524248223-393618-7-git-send-email-mst__1215.45364750109$1524248206$gmane$org@redhat.com>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1524248223-393618-1-git-send-email-mst@redhat.com>
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
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When out of memory and we can't add ctrl vq buffers,
probe fails. Unfortunately the error handling is
out of spec: it calls del_vqs without bothering
to reset the device first.

To fix, call the full cleanup function in this case.

Cc: stable@vger.kernel.org
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e8480fe..2108551 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -2090,6 +2090,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 	spin_lock_init(&portdev->ports_lock);
 	INIT_LIST_HEAD(&portdev->ports);
+	INIT_LIST_HEAD(&portdev->list);
 
 	virtio_device_ready(portdev->vdev);
 
@@ -2107,8 +2108,15 @@ static int virtcons_probe(struct virtio_device *vdev)
 		if (!nr_added_bufs) {
 			dev_err(&vdev->dev,
 				"Error allocating buffers for control queue\n");
-			err = -ENOMEM;
-			goto free_vqs;
+			/*
+			 * The host might want to notify mgmt sw about device
+			 * add failure.
+			 */
+			__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
+					   VIRTIO_CONSOLE_DEVICE_READY, 0);
+			/* Device was functional: we need full cleanup. */
+			virtcons_remove(vdev);
+			return -ENOMEM;
 		}
 	} else {
 		/*
@@ -2139,11 +2147,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 
 	return 0;
 
-free_vqs:
-	/* The host might want to notify mgmt sw about device add failure */
-	__send_control_msg(portdev, VIRTIO_CONSOLE_BAD_ID,
-			   VIRTIO_CONSOLE_DEVICE_READY, 0);
-	remove_vqs(portdev);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
-- 
MST
