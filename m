From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 1/1] virtio_serial: A char device for simple guest <->
	host communication
Date: Wed, 5 Aug 2009 10:42:08 +0530
Message-ID: <20090805051208.GA5957@amit-x200.redhat.com>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
	<1248717876-17630-2-git-send-email-amit.shah@redhat.com>
	<200908050933.42709.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908050933.42709.rusty@rustcorp.com.au>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Aug 05 2009 [09:33:40], Rusty Russell wrote:
> On Tue, 28 Jul 2009 03:34:33 am Amit Shah wrote:
> > We expose multiple char devices ("ports") for simple communication
> > between the host userspace and guest.
> 
> Hi Amit,
> 
>    OK, seems like it's time for some serious review.  Below.

Thanks! :-)

> > +config VIRTIO_SERIAL
> > +	tristate "Virtio serial"
> > +	select VIRTIO
> > +	select VIRTIO_RING
> > +	help
> > +	  Virtio serial device driver for simple guest and host communication
> 
> depends on VIRTIO
> Do not "select VIRTIO_RING" -- this code doesn't explicitly rely on it.

OK

> > +static int major = 60; /* from the experimental range */
> 
> This will obviously need to change before it goes in.

Yes. Once everything's OK'ed I'll CC Alan.

> > +
> > +static struct virtio_serial_port *get_port_from_id(u32 id)
> > +{
> > +	struct virtio_serial_port *port;
> > +	struct list_head *ptr;
> > +
> > +	list_for_each(ptr, &virtserial.port_head) {
> > +		port = list_entry(ptr, struct virtio_serial_port, next);
> 
> list_for_each_entry, same with the others.

OK

> > +static int get_id_from_port(struct virtio_serial_port *port)
> > +{
> > +	struct virtio_serial_port *match;
> > +	struct list_head *ptr;
> > +
> > +	list_for_each(ptr, &virtserial.port_head) {
> > +		match = list_entry(ptr, struct virtio_serial_port, next);
> > +
> > +		if (match == port)
> > +			return MINOR(port->dev->devt);
> > +	}
> > +	return VIRTIO_SERIAL_BAD_ID;
> > +}
> 
> Why does this exist?  Seems weird to loop, given you have the pointer already?

Hm, yes. Remnant from older code which used an array for storing port
structures. So the id was found by iterating and returning the index
where it was found. While converting the array to a linked list I just
changed this mechanically. Thanks for spotting it!

> > +static ssize_t virtserial_read(struct file *filp, char __user *ubuf,
> > +			       size_t count, loff_t *offp)
> > +{
> > +	struct list_head *ptr, *ptr2;
> > +	struct virtio_serial_port *port;
> > +	struct virtio_serial_port_buffer *buf;
> > +	ssize_t ret;
> > +
> > +	port = filp->private_data;
> > +
> > +	ret = -EINTR;
> > +	if (list_empty(&port->readbuf_head)) {
> > +		if (filp->f_flags & O_NONBLOCK)
> > +			return -EAGAIN;
> > +
> > +		if (wait_for_completion_interruptible(&port->have_data) < 0)
> > +			return ret;
> > +	}
> 
> I don't think this code works. What protects from two simultaneous readers?
> Who resets the completion? It's more normal to use a waitqueue and
> wait_event_interruptible().

Yes, I'm going to switch this now that I have to use waitqueues for
poll().

> > +	list_for_each_safe(ptr, ptr2, &port->readbuf_head) {
> > +		buf = list_entry(ptr, struct virtio_serial_port_buffer, list);
> > +
> > +		/* FIXME: other buffers further in this list might
> > +		 * have data too
> > +		 */
> > +		if (count > buf->len - buf->offset)
> > +			count = buf->len - buf->offset;
> > +
> > +		ret = copy_to_user(ubuf, buf->buf + buf->offset, count);
> > +
> > +		/* Return the number of bytes actually copied */
> > +		ret = count - ret;
> > +
> > +		buf->offset += ret;
> > +
> > +		if (buf->len - buf->offset == 0) {
> > +			list_del(&buf->list);
> > +			kfree(buf->buf);
> > +			kfree(buf);
> > +		}
> > +		/* FIXME: if there's more data requested and more data
> > +		 * available, return it.
> > +		 */
> > +		break;
> 
> There's nothing wrong with short reads here.

If there were more buffers queued up, we could easily go fetch data from
them and return as much data as was requested. (BTW I've already
implemented that in my git tree.)

> > +	}
> > +	return ret;
> 
> This can return -EINTR; if you hadn't assigned ret = -EINTR unconditionally
> above, gcc would have given you a warning about that path :)

Control would come here only if there was some data to be read. We check
for list_empty above. Not enough?

> > +static ssize_t virtserial_write(struct file *filp, const char __user *ubuf,
> > +				size_t count, loff_t *offp)
> > +{
> > +	struct virtqueue *out_vq;
> > +	struct virtio_serial_port *port;
> > +	struct virtio_serial_id id;
> > +	struct vbuf *vbuf;
> > +	size_t offset, size;
> > +	ssize_t ret;
> > +	int i, id_len;
> > +
> > +	port = filp->private_data;
> > +	id.id = get_id_from_port(port);
> > +	out_vq = virtserial.out_vq;
> > +
> > +	id_len = sizeof(id);
> > +
> > +	ret = -EFBIG;
> > +	vbuf = kzalloc(sizeof(struct vbuf), GFP_KERNEL);
> > +	if (!vbuf)
> > +		return ret;
> 
> -ENOMEM is normal here.

write(2) doesn't mention a return type of ENOMEM so I avoided it. But
there's also a note saying other types of errors are possible. So I'll
switch this to -ENOMEM.

> > +static long virtserial_ioctl(struct file *filp, unsigned int ioctl,
> > +			     unsigned long arg)
> > +{
> > +	struct virtio_serial_port *port;
> > +	long ret;
> > +
> > +	port = filp->private_data;
> > +
> > +	ret = -EINVAL;
> > +	switch (ioctl) {
> > +	default:
> > +		break;
> > +	}
> > +	return ret;
> > +}
> 
> I thought -ENOTTY was normal for invalid ioctls? In which case, just don't
> implement this function.

The ioctl was introduced for getting the 'name' of the port earlier.
With that gone, there's no use for this currently. No harm removing.

And right; it should be ENOTTY.

> > +static int virtserial_release(struct inode *inode, struct file *filp)
> > +{
> > +	filp->private_data = NULL;
> > +	return 0;
> > +}
> 
> This seems redundant.

It is. I added it recently just because some other drivers were doing
it. But will remove.

> > +static unsigned int virtserial_poll(struct file *filp, poll_table *wait)
> > +{
> > +	pr_notice("%s\n", __func__);
> > +	return 0;
> > +}
> 
> And you're going to want to implement this, too.

Already in my git tree.

> > +static void virtio_serial_rx_work_handler(struct work_struct *work)
> > +{
> > +	struct virtio_serial_port *port = NULL;
> > +	struct virtio_serial_port_buffer *buf;
> > +	struct virtqueue *vq;
> > +	char *tmpbuf;
> > +	unsigned int tmplen;
> > +
> > +	vq = virtserial.in_vq;
> > +	while ((tmpbuf = vq->vq_ops->get_buf(vq, &tmplen))) {
> > +		port = get_port_from_buf(tmpbuf);
> > +		if (!port) {
> > +			/* No valid index at start of
> > +			 * buffer. Drop it.
> > +			 */
> > +			pr_debug("%s: invalid index in buffer, %c %d\n",
> > +				 __func__, tmpbuf[0], tmpbuf[0]);
> > +			break;
> 
> leak?

Yes! and below too, in the !buf case.

> > +		}
> > +		buf = kzalloc(sizeof(struct virtio_serial_port_buffer),
> > +			      GFP_KERNEL);
> > +		if (!buf)
> > +			break;
> > +
> > +		buf->buf = tmpbuf;
> > +		buf->len = tmplen;
> > +		buf->offset = sizeof(struct virtio_serial_id);
> > +		list_add_tail(&buf->list, &port->readbuf_head);
> > +
> > +		complete(&port->have_data);
> > +	}
> > +	/* Allocate buffers for all the ones that got used up */
> > +	schedule_work(&virtserial.queue_work);
> > +}
> 
> Why do the allocation in a separate workqueue?

This is also done during probe and port hot-add case. And I guess if
some host process is sending lots of data, we could defer the allocation
to another workqueue and just allocate the empty space in one deferred
workqueue call rather than having to alloc them after each read.

> > +static __u32 get_ports_map_size(__u32 max_ports)
> > +{
> > +	return sizeof(__u32) * ((max_ports + 31) / 32);
> > +}
> 
> The __ versions are for user-visible headers only.

Ouch.

> > +static int virtserial_probe(struct virtio_device *vdev)
> > +{
> > +	struct virtqueue *vqs[3];
> 
> 3?

Remnant from control queue. Already fixed.

> > +	const char *vq_names[] = { "input", "output" };
> > +	vq_callback_t *vq_callbacks[] = { rx_intr, tx_intr };
> > +	u32 i, map;
> > +	int ret, map_i;
> > +	u32 max_nr_ports;
> > +
> > +	vdev->config->get(vdev, offsetof(struct virtio_serial_config,
> > +					 max_nr_ports),
> > +			  &max_nr_ports,
> > +			  sizeof(max_nr_ports));
> > +	virtserial.config = kmalloc(sizeof(struct virtio_serial_config)
> > +				    + get_ports_map_size(max_nr_ports),
> > +				    GFP_KERNEL);
> 
> kmalloc not checked.

Indeed.

> > +static void virtserial_remove(struct virtio_device *vdev)
> > +{
> > +	struct list_head *ptr, *ptr2;
> > +	char *buf;
> > +	int len;
> > +
> > +	unregister_chrdev(major, "virtio-serial");
> > +	class_destroy(virtserial.class);
> > +
> > +	cancel_work_sync(&virtserial.rx_work);
> > +
> > +	/* Free up the unused buffers in the receive queue */
> > +	while ((buf = virtserial.in_vq->vq_ops->get_buf(virtserial.in_vq, &len)))
> > +		kfree(buf);
> 
> This won't quite work.  get_buf gets *used* buffers.  You need to track
> buffers yourself and delete them after del_vqs.

Oh ok. Is there no way to get them from the vq? How about a new helper
to get those buffers? /me needs to look.

> > +/* IOCTL-related */
> > +#define VIRTIO_SERIAL_IO 0xAF
> 
> ??

This is some unused IOCTL. Anyway, it should be gone.

Thanks a lot for your review, Rusty!

		Amit
