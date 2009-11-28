From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 14/28] virtio: console: Separate out console-specific data
	into a separate struct
Date: Sat, 28 Nov 2009 12:20:37 +0530
Message-ID: <1259391051-7752-15-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-10-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-11-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-12-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-13-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-14-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-14-git-send-email-amit.shah@redhat.com>
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

Move out console-specific stuff into a separate struct from 'struct
port' as we need to maintain two lists: one for all the ports (which
includes consoles) and one only for consoles since the hvc callbacks
only give us the vtermno.

This makes console handling cleaner.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   57 ++++++++++++++++++++++++++--------------
 1 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 3111e4c..da8a3ff 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -52,6 +52,24 @@ static struct ports_driver_data pdrvdata;
 
 DEFINE_SPINLOCK(pdrvdata_lock);
 
+/* This struct holds information that's relevant only for console ports */
+struct console {
+	/* We'll place all consoles in a list in the pdrvdata struct */
+	struct list_head list;
+
+	/* The hvc device associated with this console port */
+	struct hvc_struct *hvc;
+
+	/*
+	 * This number identifies the number that we used to register
+	 * with hvc in hvc_instantiate() and hvc_alloc(); this is the
+	 * number passed on by the hvc callbacks to us to
+	 * differentiate between the other console ports handled by
+	 * this driver
+	 */
+	u32 vtermno;
+};
+
 /*
  * This is a per-device struct that stores data common to all the
  * ports for that device (vdev->priv).
@@ -103,15 +121,11 @@ struct port {
 	 */
 	spinlock_t readbuf_list_lock;
 
-	/* For console ports, hvc != NULL and these are valid. */
-	/* The hvc device */
-	struct hvc_struct *hvc;
-
-	/* We'll place all consoles in a list in the pdrvdata struct */
-	struct list_head list;
-
-	/* Our vterm number. */
-	u32 vtermno;
+	/*
+	 * The entries in this struct will be valid if this port is
+	 * hooked up to an hvc console
+	 */
+	struct console cons;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -120,12 +134,15 @@ static int (*early_put_chars)(u32, const char *, int);
 static struct port *find_port_by_vtermno(u32 vtermno)
 {
 	struct port *port;
+	struct console *cons;
 	unsigned long flags;
 
 	spin_lock_irqsave(&pdrvdata_lock, flags);
-	list_for_each_entry(port, &pdrvdata.consoles, list) {
-		if (port->vtermno == vtermno)
+	list_for_each_entry(cons, &pdrvdata.consoles, list) {
+		if (cons->vtermno == vtermno) {
+			port = container_of(cons, struct port, cons);
 			goto out;
+		}
 	}
 	port = NULL;
 out:
@@ -297,7 +314,7 @@ static void resize_console(struct port *port)
 		vdev->config->get(vdev,
 				  offsetof(struct virtio_console_config, rows),
 				  &ws.ws_row, sizeof(u16));
-		hvc_resize(port->hvc, ws);
+		hvc_resize(port->cons.hvc, ws);
 	}
 }
 
@@ -444,7 +461,7 @@ static void rx_work_handler(struct work_struct *work)
 	struct port *port;
 	struct port_buffer *buf;
 	unsigned int tmplen;
-	bool activity = false;
+	bool console_activity = false;
 
 	portdev = container_of(work, struct ports_device, rx_work);
 
@@ -458,9 +475,9 @@ static void rx_work_handler(struct work_struct *work)
 		list_add_tail(&buf->list, &port->readbuf_head);
 		spin_unlock_irq(&port->readbuf_list_lock);
 
-		activity |= hvc_poll(port->hvc);
+		console_activity |= hvc_poll(port->cons.hvc);
 	}
-	if (activity)
+	if (console_activity)
 		hvc_kick();
 
 	fill_receive_queue(portdev);
@@ -531,10 +548,10 @@ static int __devinit add_port(struct ports_device *portdev)
 	 * pointers.  The final argument is the output buffer size: we
 	 * can do any size, so we put PAGE_SIZE here.
 	 */
-	port->vtermno = pdrvdata.next_vtermno;
-	port->hvc = hvc_alloc(port->vtermno, 0, &hv_ops, PAGE_SIZE);
-	if (IS_ERR(port->hvc)) {
-		err = PTR_ERR(port->hvc);
+	port->cons.vtermno = pdrvdata.next_vtermno;
+	port->cons.hvc = hvc_alloc(port->cons.vtermno, 0, &hv_ops, PAGE_SIZE);
+	if (IS_ERR(port->cons.hvc)) {
+		err = PTR_ERR(port->cons.hvc);
 		goto free;
 	}
 
@@ -544,7 +561,7 @@ static int __devinit add_port(struct ports_device *portdev)
 	/* Add to vtermno list. */
 	spin_lock_irq(&pdrvdata_lock);
 	pdrvdata.next_vtermno++;
-	list_add(&port->list, &pdrvdata.consoles);
+	list_add(&port->cons.list, &pdrvdata.consoles);
 	spin_unlock_irq(&pdrvdata_lock);
 
 	return 0;
-- 
1.6.2.5
