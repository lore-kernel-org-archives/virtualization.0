From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 2/2] virtio: console: Disable callbacks for virtqueues at
	start of S4 freeze
Date: Fri,  6 Jan 2012 16:19:08 +0530
Message-ID: <a2f6a8acbe7f66f36f3fcede19ed72808673ff9c.1325845993.git.amit.shah@redhat.com>
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

To ensure we don't receive any more interrupts from the host after we
enter the freeze function, disable all vq interrupts.

There wasn't any problem seen due to this in tests, but applying this
patch makes the freeze case more robust.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fc54a79..c1c45d8 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1860,10 +1860,18 @@ static int virtcons_freeze(struct virtio_device *vdev)
 
 	vdev->config->reset(vdev);
 
+	virtqueue_disable_cb(portdev->c_ivq);
 	cancel_work_sync(&portdev->control_work);
+	/*
+	 * Once more: if control_work_handler() was running, it would
+	 * enable the cb as the last step.
+	 */
+	virtqueue_disable_cb(portdev->c_ivq);
 	remove_controlq_data(portdev);
 
 	list_for_each_entry(port, &portdev->ports, list) {
+		virtqueue_disable_cb(port->in_vq);
+		virtqueue_disable_cb(port->out_vq);
 		/*
 		 * We'll ask the host later if the new invocation has
 		 * the port opened or closed.
-- 
1.7.7.4
