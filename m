From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/2] virtio: console: Serialise control work
Date: Fri,  6 Jan 2012 16:19:07 +0530
Message-ID: <0ee4e2fc77b40f1985391ce3f9b8a2cf3f729324.1325845993.git.amit.shah@redhat.com>
References: <cover.1325845993.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1325845993.git.amit.shah@redhat.com>
In-Reply-To: <cover.1325845993.git.amit.shah@redhat.com>
References: <cover.1325845993.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>, miche@google.com, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We currently allow multiple instances of the control work handler to run
in parallel.  This isn't expected to work; serialise access by disabling
interrupts on new packets from the Host and enable them when all the
existing ones are consumed.

Testcase: hot-plug/unplug a port in a loop.  Without this patch, some
sysfs warnings are seen along with freezes.  With the patch, all works
fine.

Reported-by: Miche Baker-Harvey <miche@google.com>
Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fd2fd6f..fc54a79 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1471,6 +1471,7 @@ static void control_work_handler(struct work_struct *work)
 	portdev = container_of(work, struct ports_device, control_work);
 	vq = portdev->c_ivq;
 
+ start:
 	spin_lock(&portdev->cvq_lock);
 	while ((buf = virtqueue_get_buf(vq, &len))) {
 		spin_unlock(&portdev->cvq_lock);
@@ -1488,6 +1489,10 @@ static void control_work_handler(struct work_struct *work)
 		}
 	}
 	spin_unlock(&portdev->cvq_lock);
+	if (unlikely(!virtqueue_enable_cb(vq))) {
+		virtqueue_disable_cb(vq);
+		goto start;
+	}
 }
 
 static void out_intr(struct virtqueue *vq)
@@ -1538,6 +1543,7 @@ static void control_intr(struct virtqueue *vq)
 {
 	struct ports_device *portdev;
 
+	virtqueue_disable_cb(vq);
 	portdev = vq->vdev->priv;
 	schedule_work(&portdev->control_work);
 }
-- 
1.7.7.4
