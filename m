From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4/6] virtio_console: drop custom control queue cleanup
Date: Fri, 20 Apr 2018 21:18:03 +0300
Message-ID: <1524248223-393618-5-git-send-email-mst__33711.8127187297$1524248207$gmane$org@redhat.com>
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

We now cleanup all VQs on device removal - no need
to handle the control VQ specially.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 26a66ff..2d87ce5 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1988,21 +1988,6 @@ static void remove_vqs(struct ports_device *portdev)
 	kfree(portdev->out_vqs);
 }
 
-static void remove_controlq_data(struct ports_device *portdev)
-{
-	struct port_buffer *buf;
-	unsigned int len;
-
-	if (!use_multiport(portdev))
-		return;
-
-	while ((buf = virtqueue_get_buf(portdev->c_ivq, &len)))
-		free_buf(buf, true);
-
-	while ((buf = virtqueue_detach_unused_buf(portdev->c_ivq)))
-		free_buf(buf, true);
-}
-
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -2163,7 +2148,6 @@ static void virtcons_remove(struct virtio_device *vdev)
 	 * have to just stop using the port, as the vqs are going
 	 * away.
 	 */
-	remove_controlq_data(portdev);
 	remove_vqs(portdev);
 	kfree(portdev);
 }
@@ -2208,7 +2192,6 @@ static int virtcons_freeze(struct virtio_device *vdev)
 	 */
 	if (use_multiport(portdev))
 		virtqueue_disable_cb(portdev->c_ivq);
-	remove_controlq_data(portdev);
 
 	list_for_each_entry(port, &portdev->ports, list) {
 		virtqueue_disable_cb(port->in_vq);
-- 
MST
