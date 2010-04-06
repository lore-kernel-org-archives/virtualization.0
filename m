From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 10/10] virtio: console: Add support for nonblocking
	write()s
Date: Tue, 6 Apr 2010 20:24:31 +0530
Message-ID: <20100406145431.GA2677@amit-x200.redhat.com>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
	<1270475654-399-10-git-send-email-amit.shah@redhat.com>
	<1270475654-399-11-git-send-email-amit.shah@redhat.com>
	<201004061242.58840.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201004061242.58840.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Tue) Apr 06 2010 [12:42:58], Rusty Russell wrote:
> On Mon, 5 Apr 2010 11:24:14 pm Amit Shah wrote:
> > If the host port is not open, a write() should either just return if the
> > file is opened in non-blocking mode, or block till the host port is
> > opened.
> > 
> > Also, don't spin till host consumes data for nonblocking ports. For
> > non-blocking ports, we can do away with the spinning and reclaim the
> > buffers consumed by the host on the next write call or on the condition
> > that'll make poll return.
> 
> I'm only reading the patch so I might have missed it, but what's the
> locking going on here?
> 
> Can we race thinking we're full or not full incorrectly?

Turns out just this much on top of this patch should be sufficient.


diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 0c632ee..6541f76 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -158,6 +158,9 @@ struct port {
 	 */
 	spinlock_t inbuf_lock;
 
+	/* Protect the operations on the out_vq. */
+	spinlock_t outbuf_lock;
+
 	/* The IO vqs for this port */
 	struct virtqueue *in_vq, *out_vq;
 
@@ -409,12 +412,15 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 static void reclaim_consumed_buffers(struct port *port)
 {
 	void *buf;
+	unsigned long flags;
 	unsigned int len;
 
+	spin_lock_irqsave(&port->outbuf_lock, flags);
 	while ((buf = port->out_vq->vq_ops->get_buf(port->out_vq, &len))) {
 		kfree(buf);
 		port->outvq_full = false;
 	}
+	spin_unlock_irqrestore(&port->outbuf_lock, flags);
 }
 
 static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
@@ -423,6 +429,7 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
 	struct scatterlist sg[1];
 	struct virtqueue *out_vq;
 	ssize_t ret;
+	unsigned long flags;
 	unsigned int len;
 
 	out_vq = port->out_vq;
@@ -430,6 +437,9 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
 	reclaim_consumed_buffers(port);
 
 	sg_init_one(sg, in_buf, in_count);
+
+	spin_lock_irqsave(&port->outbuf_lock, flags);
+
 	ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, in_buf);
 
 	/* Tell Host to go! */
@@ -437,14 +447,14 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
 
 	if (ret < 0) {
 		in_count = 0;
-		goto fail;
+		goto done;
 	}
 
 	if (ret == 0)
 		port->outvq_full = true;
 
 	if (nonblock)
-		return in_count;
+		goto done;
 
 	/*
 	 * Wait till the host acknowledges it pushed out the data we
@@ -454,7 +464,8 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
 	 */
 	while (!out_vq->vq_ops->get_buf(out_vq, &len))
 		cpu_relax();
-fail:
+done:
+	spin_unlock_irqrestore(&port->outbuf_lock, flags);
 	/*
 	 * We're expected to return the amount of data we wrote -- all
 	 * of it
@@ -1009,6 +1020,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	}
 
 	spin_lock_init(&port->inbuf_lock);
+	spin_lock_init(&port->outbuf_lock);
 	init_waitqueue_head(&port->waitqueue);
 
 	/* Fill the in_vq with buffers so the host can send us data. */
