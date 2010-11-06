From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] Char: virtio_console, fix memory leak
Date: Sat,  6 Nov 2010 10:06:50 +0100
Message-ID: <1289034412-24278-2-git-send-email-jslaby__3443.0299456746$1289034486$gmane$org@suse.cz>
References: <1289034412-24278-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1289034412-24278-1-git-send-email-jslaby@suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jirislaby@gmail.com
Cc: Amit Shah <amit.shah@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Stanse found that in init_vqs, memory is leaked under certain
circumstanses (the fail path order is incorrect). Fix that by checking
allocations in one turn and free all of them at once if some fails
(some may be NULL, but this is OK).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Amit Shah <amit.shah@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/virtio_console.c |   37 +++++++++----------------------------
 1 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 6c1b676..896a2ce 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1547,31 +1547,16 @@ static int init_vqs(struct ports_device *portdev)
 	nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;
 
 	vqs = kmalloc(nr_queues * sizeof(struct virtqueue *), GFP_KERNEL);
-	if (!vqs) {
-		err = -ENOMEM;
-		goto fail;
-	}
 	io_callbacks = kmalloc(nr_queues * sizeof(vq_callback_t *), GFP_KERNEL);
-	if (!io_callbacks) {
-		err = -ENOMEM;
-		goto free_vqs;
-	}
 	io_names = kmalloc(nr_queues * sizeof(char *), GFP_KERNEL);
-	if (!io_names) {
-		err = -ENOMEM;
-		goto free_callbacks;
-	}
 	portdev->in_vqs = kmalloc(nr_ports * sizeof(struct virtqueue *),
 				  GFP_KERNEL);
-	if (!portdev->in_vqs) {
-		err = -ENOMEM;
-		goto free_names;
-	}
 	portdev->out_vqs = kmalloc(nr_ports * sizeof(struct virtqueue *),
 				   GFP_KERNEL);
-	if (!portdev->out_vqs) {
+	if (!vqs || !io_callbacks || !io_names || !portdev->in_vqs ||
+			!portdev->out_vqs) {
 		err = -ENOMEM;
-		goto free_invqs;
+		goto free;
 	}
 
 	/*
@@ -1605,7 +1590,7 @@ static int init_vqs(struct ports_device *portdev)
 					      io_callbacks,
 					      (const char **)io_names);
 	if (err)
-		goto free_outvqs;
+		goto free;
 
 	j = 0;
 	portdev->in_vqs[0] = vqs[0];
@@ -1621,23 +1606,19 @@ static int init_vqs(struct ports_device *portdev)
 			portdev->out_vqs[i] = vqs[j + 1];
 		}
 	}
-	kfree(io_callbacks);
 	kfree(io_names);
+	kfree(io_callbacks);
 	kfree(vqs);
 
 	return 0;
 
-free_names:
-	kfree(io_names);
-free_callbacks:
-	kfree(io_callbacks);
-free_outvqs:
+free:
 	kfree(portdev->out_vqs);
-free_invqs:
 	kfree(portdev->in_vqs);
-free_vqs:
+	kfree(io_names);
+	kfree(io_callbacks);
 	kfree(vqs);
-fail:
+
 	return err;
 }
 
-- 
1.7.3.1
