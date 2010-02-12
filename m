From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 4/6] virtio: console: Error out if we can't allocate buffers
	for control queue
Date: Fri, 12 Feb 2010 10:32:17 +0530
Message-ID: <1265950939-12359-5-git-send-email-amit.shah@redhat.com>
References: <1265950939-12359-1-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-2-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-3-git-send-email-amit.shah@redhat.com>
	<1265950939-12359-4-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1265950939-12359-4-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

With MULTIPORT support, the control queue is an integral part of the
functioning of the device. If we can't get any buffers allocated, the
host won't be able to relay important information and the device may not
function as intended.

Ensure 'probe' doesn't succeed until the control queue has at least one
buffer allocated for its ivq.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 0057bae..c407037 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1057,25 +1057,30 @@ static void config_intr(struct virtio_device *vdev)
 	resize_console(find_port_by_id(portdev, 0));
 }
 
-static void fill_queue(struct virtqueue *vq, spinlock_t *lock)
+static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
 {
 	struct port_buffer *buf;
-	int ret;
+	unsigned int ret;
+	int err;
 
+	ret = 0;
 	do {
 		buf = alloc_buf(PAGE_SIZE);
 		if (!buf)
 			break;
 
 		spin_lock_irq(lock);
-		ret = add_inbuf(vq, buf);
-		if (ret < 0) {
+		err = add_inbuf(vq, buf);
+		if (err < 0) {
 			spin_unlock_irq(lock);
 			free_buf(buf);
 			break;
 		}
+		ret++;
 		spin_unlock_irq(lock);
-	} while (ret > 0);
+	} while (err > 0);
+
+	return ret;
 }
 
 static int add_port(struct ports_device *portdev, u32 id)
@@ -1430,7 +1435,13 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 		INIT_WORK(&portdev->control_work, &control_work_handler);
 		INIT_WORK(&portdev->config_work, &config_work_handler);
 
-		fill_queue(portdev->c_ivq, &portdev->cvq_lock);
+		err = fill_queue(portdev->c_ivq, &portdev->cvq_lock);
+		if (!err) {
+			dev_err(&vdev->dev,
+				"Error allocating buffers for control queue\n");
+			err = -ENOMEM;
+			goto free_vqs;
+		}
 	}
 
 	for (i = 0; i < portdev->config.nr_ports; i++)
@@ -1440,6 +1451,10 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	early_put_chars = NULL;
 	return 0;
 
+free_vqs:
+	vdev->config->del_vqs(vdev);
+	kfree(portdev->in_vqs);
+	kfree(portdev->out_vqs);
 free_chrdev:
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
-- 
1.6.2.5
