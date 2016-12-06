From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 01/10] virtio_console: drop unused config fields
Date: Tue, 6 Dec 2016 17:40:32 +0200
Message-ID: <1481038106-24899-2-git-send-email-mst@redhat.com>
References: <1481038106-24899-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1481038106-24899-1-git-send-email-mst@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

struct ports_device includes a config field including the whole
virtio_console_config, but only max_nr_ports in there is ever updated or
used. The rest is unused and in fact does not even mirror the
device config. Drop everything except max_nr_ports,
saving some memory.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/virtio_console.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5649234..8b00e79 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -152,8 +152,8 @@ struct ports_device {
 	spinlock_t c_ivq_lock;
 	spinlock_t c_ovq_lock;
 
-	/* The current config space is stored here */
-	struct virtio_console_config config;
+	/* max. number of ports this device can hold */
+	u32 max_nr_ports;
 
 	/* The virtio device we're associated with */
 	struct virtio_device *vdev;
@@ -1649,11 +1649,11 @@ static void handle_control_message(struct virtio_device *vdev,
 			break;
 		}
 		if (virtio32_to_cpu(vdev, cpkt->id) >=
-		    portdev->config.max_nr_ports) {
+		    portdev->max_nr_ports) {
 			dev_warn(&portdev->vdev->dev,
 				"Request for adding port with "
 				"out-of-bound id %u, max. supported id: %u\n",
-				cpkt->id, portdev->config.max_nr_ports - 1);
+				cpkt->id, portdev->max_nr_ports - 1);
 			break;
 		}
 		add_port(portdev, virtio32_to_cpu(vdev, cpkt->id));
@@ -1894,7 +1894,7 @@ static int init_vqs(struct ports_device *portdev)
 	u32 i, j, nr_ports, nr_queues;
 	int err;
 
-	nr_ports = portdev->config.max_nr_ports;
+	nr_ports = portdev->max_nr_ports;
 	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
 
 	vqs = kmalloc(nr_queues * sizeof(struct virtqueue *), GFP_KERNEL);
@@ -2047,13 +2047,13 @@ static int virtcons_probe(struct virtio_device *vdev)
 	}
 
 	multiport = false;
-	portdev->config.max_nr_ports = 1;
+	portdev->max_nr_ports = 1;
 
 	/* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
 	if (!is_rproc_serial(vdev) &&
 	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
 				 struct virtio_console_config, max_nr_ports,
-				 &portdev->config.max_nr_ports) == 0) {
+				 &portdev->max_nr_ports) == 0) {
 		multiport = true;
 	}
 
-- 
MST
