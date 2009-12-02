From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 12/28] virtio: console: Buffer data that comes in from
	the host
Date: Wed, 2 Dec 2009 14:54:06 +0530
Message-ID: <20091202092406.GB28265@amit-x200.redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-12-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-13-git-send-email-amit.shah@redhat.com>
	<200912021414.20206.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200912021414.20206.rusty@rustcorp.com.au>
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
Cc: Shirley Ma <mashirle@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Dec 02 2009 [14:14:20], Rusty Russell wrote:
> On Sat, 28 Nov 2009 05:20:35 pm Amit Shah wrote:
> > The console could be flooded with data from the host; handle
> > this situation by buffering the data.
> 
> All this complexity makes me really wonder if we should just
> have the host say the max # ports it will ever use, and just do this
> really dumbly.  Yes, it's a limitation, but it'd be much simpler.

As in make sure the max nr ports is less than 255 and have per-port vqs?
And then the buffering will be done inside the vqs themselves?

> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -65,6 +65,23 @@ struct ports_device {
> >  	 * interrupt
> >  	 */
> >  	struct work_struct rx_work;
> > +
> > +	struct list_head unused_read_head;
> 
> You should name lists after plurals, rather than using "head" which is
> an implementation detail.  eg. "queued_inbufs" and below "used_inbufs".

OK.

> Though Shirly Ma was working on a "destroy_bufs" patch which would avoid
> your need for this list at all, AFAICT.
> 
> > +		/* Return the number of bytes actually copied */
> > +		ret = copy_size;
> > +		buf->offset += ret;
> > +		out_offset += ret;
> > +		out_count -= ret;
> 
> We don't actually use ret.

In a later patch, when copy_to_user is added, ret will be used. So I
kept it this way to reduce the noise in the diffs later.

> > +		if (buf->len - buf->offset == 0) {
> 
> I prefer the simpler "if (buf->offset == buf->len)" myself.

Will update.

> > +			spin_lock_irqsave(&port->readbuf_list_lock, flags);
> > +			list_del(&buf->list);
> > +			spin_unlock_irqrestore(&port->readbuf_list_lock, flags);
> > +			kfree(buf->buf);
> > +			kfree(buf);
> 
> Does it become cleaner later to have this in a separate function?  Usually
> I prefer matching alloc and free fns.

Adding a function is easy, sure. I should've done that though; something
that got overlooked.

> > +static struct port_buffer *get_buf(size_t buf_size)
> > +{
> > +	struct port_buffer *buf;
> > +
> > +	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
> > +	if (!buf)
> > +		goto out;
> > +	buf->buf = kzalloc(buf_size, GFP_KERNEL);
> > +	if (!buf->buf) {
> > +		kfree(buf);
> > +		goto out;
> 
> No, that would return non-NULL.  I'd stick with the standard multi-part exit:
> 
> 	if (!buf)
> 		goto fail;
> 	buf->buf = kzalloc(buf_size, GFP_KERNEL);
> 	if (!buf->buf)
> 		goto fail_free_buf;
> 	buf->len = buf_size;
> 	return buf;
> 
> fail_free_buf:
> 	kfree(buf);
> fail:
> 	return NULL;

Ow, indeed.

Thanks! 

		Amit
