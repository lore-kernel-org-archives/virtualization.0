From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 13/28] virtio: console: Create a buffer pool for
	sending data to host
Date: Wed, 2 Dec 2009 14:49:58 +0530
Message-ID: <20091202091958.GA28265@amit-x200.redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-13-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-14-git-send-email-amit.shah@redhat.com>
	<200912021900.35219.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200912021900.35219.rusty@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On (Wed) Dec 02 2009 [19:00:35], Rusty Russell wrote:
> On Sat, 28 Nov 2009 05:20:36 pm Amit Shah wrote:
> > The old way of sending data to the host was to populate one buffer and
> > then wait till the host consumed it before sending the next chunk of
> > data.
> > 
> > Also, there was no support to send large chunks of data.
> > 
> > We now maintain a per-device list of buffers that are ready to be
> > passed on to the host.
> > 
> > This patch adds support to send big chunks in multiple buffers of
> > PAGE_SIZE each to the host.
> > 
> > When the host consumes the data and signals to us via an interrupt, we
> > add the consumed buffer back to our unconsumed list.
> > 
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> > ---
> >  drivers/char/virtio_console.c |  159 +++++++++++++++++++++++++++++++++-------
> >  1 files changed, 131 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index e8dabae..3111e4c 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -67,9 +67,13 @@ struct ports_device {
> >  	struct work_struct rx_work;
> >  
> >  	struct list_head unused_read_head;
> > +	struct list_head unused_write_head;
> >  
> >  	/* To protect the list of unused read buffers and the in_vq */
> >  	spinlock_t read_list_lock;
> > +
> > +	/* To protect the list of unused write buffers and the out_vq */
> > +	spinlock_t write_list_lock;
> >  };
> 
> Let's simplify this a little with a single "buffer_lock" or such in the
> previous patch.

You mean a common lock for the in_vq and out_vq?

> > +	if (!in_count)
> >  		return 0;
> 
> Not necessary: if it happens all we'll do is gratuitously kick the host.

Will drop.

> > +	in_offset = 0; /* offset in the user buffer */
> > +	spin_lock_irqsave(&port->portdev->write_list_lock, irqf);
> > +	while (in_count - in_offset) {
> 
> while (in_offset < in_count) seems clearer to me here.

Sure.

> > +		copy_size = min(in_count - in_offset, PAGE_SIZE);
> 
> Shouldn't you be using buf->size here?

You mean introduce a new field in the buf struct and put the size there?
Yes, I'll do that.

> > +		spin_unlock_irqrestore(&port->portdev->write_list_lock, irqf);
> > +
> > +		/*
> > +		 * Since we're not sure when the host will actually
> > +		 * consume the data and tell us about it, we have
> > +		 * to copy the data here in case the caller
> > +		 * frees the in_buf
> > +		 */
> > +		memcpy(buf->buf, in_buf + in_offset, copy_size);
> > +
> > +		buf->len = copy_size;
> > +		sg_init_one(sg, buf->buf, buf->len);
> > +
> > +		spin_lock_irqsave(&port->portdev->write_list_lock, irqf);
> 
> Dropping the lock here seems gratuitous.

In a later patch when we add support for reading from userspace, we'll add
a copy_from_user here, so dropping the lock is done in this patch to
reduce the noise in the diff for easier reviewing.

> > +/*
> > + * This function is only called from the init routine so the spinlock
> > + * for the unused_write_head list isn't taken
> > + */
> > +static void alloc_write_bufs(struct ports_device *portdev)
> > +{
> > +	struct port_buffer *buf;
> > +	int i;
> > +
> > +	for (i = 0; i < 30; i++) {
> 
> 30?

Yeah; 30 is an arbitrary number. Basically just enough to have two
simultaneous 'copy /dev/vport0p2 > blah' run without having to return a
number < requested bytes. (libc uses 32k buffers for transfers.)


>  And why aren't we allocating these somehow as they're
> consumed?

Used-up buffers get added to the list again once host has consumed them
in tx_intr.

> >  	fill_receive_queue(portdev);
> > +	alloc_write_bufs(portdev);
> 
> What happens if this fails?

Hm, if not a single buf got allocated, any write() requests will not
succeed. dev_warn()?

		Amit
