From: Pankaj Gupta <pagupta@redhat.com>
Subject: [PATCH v4 2/2] virtio_console: free unused buffers with port delete
Date: Tue, 13 Aug 2019 19:35:29 +0530
Message-ID: <20190813140529.12939-3-pagupta__32884.131807235$1565705161$gmane$org@redhat.com>
References: <20190813140529.12939-1-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190813140529.12939-1-pagupta@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com, amit@kernel.org
Cc: pagupta@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
deferred detaching of unused buffer to virtio device unplug time.
This causes unplug/replug of single port in virtio device with an
error "Error allocating inbufs\n". As we don't free the unused buffers
attached with the port. Re-plug the same port tries to allocate new
buffers in virtqueue and results in this error if queue is full.
This patch reverts this commit by removing the unused buffers in vq's
when we unplug the port.

Reported-by: Xiaohui Li <xiaohli@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
---
 drivers/char/virtio_console.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7270e7b69262..e8be82f1bae9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1494,15 +1494,25 @@ static void remove_port(struct kref *kref)
 	kfree(port);
 }
 
+static void remove_unused_bufs(struct virtqueue *vq)
+{
+	struct port_buffer *buf;
+
+	while ((buf = virtqueue_detach_unused_buf(vq)))
+		free_buf(buf, true);
+}
+
 static void remove_port_data(struct port *port)
 {
 	spin_lock_irq(&port->inbuf_lock);
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
+	remove_unused_bufs(port->in_vq);
 	spin_unlock_irq(&port->inbuf_lock);
 
 	spin_lock_irq(&port->outvq_lock);
 	reclaim_consumed_buffers(port);
+	remove_unused_bufs(port->out_vq);
 	spin_unlock_irq(&port->outvq_lock);
 }
 
@@ -1938,11 +1948,9 @@ static void remove_vqs(struct ports_device *portdev)
 	struct virtqueue *vq;
 
 	virtio_device_for_each_vq(portdev->vdev, vq) {
-		struct port_buffer *buf;
 
 		flush_bufs(vq, true);
-		while ((buf = virtqueue_detach_unused_buf(vq)))
-			free_buf(buf, true);
+		remove_unused_bufs(vq);
 	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
-- 
2.21.0
