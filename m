From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/6] virtio_console: don't tie bufs to a vq
Date: Wed, 25 Apr 2018 07:50:16 +0200
Message-ID: <20180425055016.GD30843__22601.7967834652$1524635303$gmane$org@kroah.com>
References: <1524248223-393618-1-git-send-email-mst@redhat.com>
	<1524248223-393618-2-git-send-email-mst@redhat.com>
	<20180421073005.GA3744@kroah.com>
	<20180424215318-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20180424215318-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 24, 2018 at 09:56:33PM +0300, Michael S. Tsirkin wrote:
> On Sat, Apr 21, 2018 at 09:30:05AM +0200, Greg Kroah-Hartman wrote:
> > On Fri, Apr 20, 2018 at 09:18:01PM +0300, Michael S. Tsirkin wrote:
> > > an allocated buffer doesn't need to be tied to a vq -
> > > only vq->vdev is ever used. Pass the function the
> > > just what it needs - the vdev.
> > > 
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > ---
> > >  drivers/char/virtio_console.c | 14 +++++++-------
> > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index 468f061..3e56f32 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -422,7 +422,7 @@ static void reclaim_dma_bufs(void)
> > >  	}
> > >  }
> > >  
> > > -static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
> > > +static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size,
> > >  				     int pages)
> > >  {
> > >  	struct port_buffer *buf;
> > > @@ -445,16 +445,16 @@ static struct port_buffer *alloc_buf(struct virtqueue *vq, size_t buf_size,
> > >  		return buf;
> > >  	}
> > >  
> > > -	if (is_rproc_serial(vq->vdev)) {
> > > +	if (is_rproc_serial(vdev)) {
> > >  		/*
> > >  		 * Allocate DMA memory from ancestor. When a virtio
> > >  		 * device is created by remoteproc, the DMA memory is
> > >  		 * associated with the grandparent device:
> > >  		 * vdev => rproc => platform-dev.
> > >  		 */
> > > -		if (!vq->vdev->dev.parent || !vq->vdev->dev.parent->parent)
> > > +		if (!vdev->dev.parent || !vdev->dev.parent->parent)
> > >  			goto free_buf;
> > > -		buf->dev = vq->vdev->dev.parent->parent;
> > > +		buf->dev = vdev->dev.parent->parent;
> > >  
> > >  		/* Increase device refcnt to avoid freeing it */
> > >  		get_device(buf->dev);
> > > @@ -838,7 +838,7 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
> > >  
> > >  	count = min((size_t)(32 * 1024), count);
> > >  
> > > -	buf = alloc_buf(port->out_vq, count, 0);
> > > +	buf = alloc_buf(port->portdev->vdev, count, 0);
> > >  	if (!buf)
> > >  		return -ENOMEM;
> > >  
> > > @@ -957,7 +957,7 @@ static ssize_t port_fops_splice_write(struct pipe_inode_info *pipe,
> > >  	if (ret < 0)
> > >  		goto error_out;
> > >  
> > > -	buf = alloc_buf(port->out_vq, 0, pipe->nrbufs);
> > > +	buf = alloc_buf(port->portdev->vdev, 0, pipe->nrbufs);
> > >  	if (!buf) {
> > >  		ret = -ENOMEM;
> > >  		goto error_out;
> > > @@ -1374,7 +1374,7 @@ static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
> > >  
> > >  	nr_added_bufs = 0;
> > >  	do {
> > > -		buf = alloc_buf(vq, PAGE_SIZE, 0);
> > > +		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0);
> > >  		if (!buf)
> > >  			break;
> > >  
> > > -- 
> > > MST
> > 
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> 
> Thanks!
> I have some questions about this one:
> 
> Cc: <stable@vger.kernel.org> # 3.3.x: a1f84a3: sched: Check for idle
> Cc: <stable@vger.kernel.org> # 3.3.x: 1b9508f: sched: Rate-limit newidle
> Cc: <stable@vger.kernel.org> # 3.3.x: fd21073: sched: Fix affinity logic
> Cc: <stable@vger.kernel.org> # 3.3.x
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> 1. what does the kernel version mean? can I omit it?

Did you read the document?, it explains that the version can be used to
say "this kernel version and newer"

> 2. so when I rebase to add the tag, this changes commit IDs for
>    following tags in the same tree, breaking their tags
>    in the process. Pretty annoying. Any idea how to do it better?

You only put tags there if you want me to pick up pre-requisite patches
that are already in Linus's tree.  If you have a patch series that all
needs to go into stable, just add the "cc: stable@" to the tags on all
of them and I'll pick them up in the correct order then.

hope this helps,

greg k-h
