From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] virtio_console: allocate inbufs in add_port() only if
	it is needed
Date: Wed, 13 Nov 2019 10:22:37 -0500
Message-ID: <20191113102126-mutt-send-email-mst__1713.02523683465$1573658579$gmane$org@kernel.org>
References: <20191113150056.9990-1-lvivier@redhat.com>
	<20191113101929-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191113101929-mutt-send-email-mst@kernel.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Laurent Vivier <lvivier@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 13, 2019 at 10:21:11AM -0500, Michael S. Tsirkin wrote:
> On Wed, Nov 13, 2019 at 04:00:56PM +0100, Laurent Vivier wrote:
> > When we hot unplug a virtserialport and then try to hot plug again,
> > it fails:
> > 
> > (qemu) chardev-add socket,id=serial0,path=/tmp/serial0,server,nowait
> > (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> >                   chardev=serial0,id=serial0,name=serial0
> > (qemu) device_del serial0
> > (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> >                   chardev=serial0,id=serial0,name=serial0
> > kernel error:
> >   virtio-ports vport2p2: Error allocating inbufs
> > qemu error:
> >   virtio-serial-bus: Guest failure in adding port 2 for device \
> >                      virtio-serial0.0
> > 
> > This happens because buffers for the in_vq are allocated when the port is
> > added but are not released when the port is unplugged.
> > 
> > They are only released when virtconsole is removed (see a7a69ec0d8e4)
> > 
> > To avoid the problem and to be symmetric, we could allocate all the buffers
> > in init_vqs() as they are released in remove_vqs(), but it sounds like
> > a waste of memory.
> > 
> > Rather than that, this patch changes add_port() logic to ignore ENOSPC
> > error in fill_queue(), which means queue has already been filled.
> > 
> > Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > Cc: mst@redhat.com
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> > 
> > Notes:
> >     v2: making fill_queue return int and testing return code for -ENOSPC
> > 
> >  drivers/char/virtio_console.c | 24 +++++++++---------------
> >  1 file changed, 9 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index 7270e7b69262..9e6534fd1aa4 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1325,24 +1325,24 @@ static void set_console_size(struct port *port, u16 rows, u16 cols)
> >  	port->cons.ws.ws_col = cols;
> >  }
> >  
> > -static unsigned int fill_queue(struct virtqueue *vq, spinlock_t *lock)
> > +static int fill_queue(struct virtqueue *vq, spinlock_t *lock)
> >  {
> >  	struct port_buffer *buf;
> > -	unsigned int nr_added_bufs;
> > +	int nr_added_bufs;
> >  	int ret;
> >  
> >  	nr_added_bufs = 0;
> >  	do {
> >  		buf = alloc_buf(vq->vdev, PAGE_SIZE, 0);
> >  		if (!buf)
> > -			break;
> > +			return -ENOMEM;
> >  
> >  		spin_lock_irq(lock);
> >  		ret = add_inbuf(vq, buf);
> >  		if (ret < 0) {
> >  			spin_unlock_irq(lock);
> >  			free_buf(buf, true);
> > -			break;
> > +			return ret;
> >  		}
> >  		nr_added_bufs++;
> >  		spin_unlock_irq(lock);

So actually, how about handling ENOSPC specially here, and
returning success? After all queue is full as requested ...


> > @@ -1362,7 +1362,6 @@ static int add_port(struct ports_device *portdev, u32 id)
> >  	char debugfs_name[16];
> >  	struct port *port;
> >  	dev_t devt;
> > -	unsigned int nr_added_bufs;
> >  	int err;
> >  
> >  	port = kmalloc(sizeof(*port), GFP_KERNEL);
> > @@ -1421,11 +1420,9 @@ static int add_port(struct ports_device *portdev, u32 id)
> >  	spin_lock_init(&port->outvq_lock);
> >  	init_waitqueue_head(&port->waitqueue);
> >  
> > -	/* Fill the in_vq with buffers so the host can send us data. */
> > -	nr_added_bufs = fill_queue(port->in_vq, &port->inbuf_lock);
> > -	if (!nr_added_bufs) {
> > +	err = fill_queue(port->in_vq, &port->inbuf_lock);
> > +	if (err < 0 && err != -ENOSPC) {
> >  		dev_err(port->dev, "Error allocating inbufs\n");
> > -		err = -ENOMEM;
> >  		goto free_device;
> >  	}
> >  
> 
> Pls add a comment explaining that -ENOSPC happens when
> queue already has buffers (e.g. from previous detach).
> 
> 
> > @@ -2059,14 +2056,11 @@ static int virtcons_probe(struct virtio_device *vdev)
> >  	INIT_WORK(&portdev->control_work, &control_work_handler);
> >  
> >  	if (multiport) {
> > -		unsigned int nr_added_bufs;
> > -
> >  		spin_lock_init(&portdev->c_ivq_lock);
> >  		spin_lock_init(&portdev->c_ovq_lock);
> >  
> > -		nr_added_bufs = fill_queue(portdev->c_ivq,
> > -					   &portdev->c_ivq_lock);
> > -		if (!nr_added_bufs) {
> > +		err = fill_queue(portdev->c_ivq, &portdev->c_ivq_lock);
> > +		if (err < 0) {
> >  			dev_err(&vdev->dev,
> >  				"Error allocating buffers for control queue\n");
> >  			/*
> > @@ -2077,7 +2071,7 @@ static int virtcons_probe(struct virtio_device *vdev)
> >  					   VIRTIO_CONSOLE_DEVICE_READY, 0);
> >  			/* Device was functional: we need full cleanup. */
> >  			virtcons_remove(vdev);
> > -			return -ENOMEM;
> > +			return err;
> >  		}
> >  	} else {
> >  		/*
> > -- 
> > 2.23.0
