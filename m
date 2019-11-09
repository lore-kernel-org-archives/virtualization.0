From: Amit Shah <amit@infradead.org>
Subject: Re: [PATCH] virtio_console: allocate inbufs in add_port() only if
	it is needed
Date: Sat, 09 Nov 2019 06:49:12 +0100
Message-ID: <46cc3d4a8d4b2279ce8b3cba5e061ac14b2a0c84.camel@infradead.org>
References: <20191018164718.15999-1-lvivier@redhat.com>
	<20191106085548-mutt-send-email-mst@kernel.org>
	<83d88904-1626-8dd6-9e5c-7abcee27bcd0@redhat.com>
	<20191106095707-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191106095707-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Amit Shah <amit@kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2019-11-06 at 10:03 -0500, Michael S. Tsirkin wrote:
> On Wed, Nov 06, 2019 at 03:02:25PM +0100, Laurent Vivier wrote:
> > On 06/11/2019 14:56, Michael S. Tsirkin wrote:
> > > On Fri, Oct 18, 2019 at 06:47:18PM +0200, Laurent Vivier wrote:
> > > > When we hot unplug a virtserialport and then try to hot plug
> > > > again,
> > > > it fails:
> > > > 
> > > > (qemu) chardev-add
> > > > socket,id=serial0,path=/tmp/serial0,server,nowait
> > > > (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> > > >                   chardev=serial0,id=serial0,name=serial0
> > > > (qemu) device_del serial0
> > > > (qemu) device_add virtserialport,bus=virtio-serial0.0,nr=2,\
> > > >                   chardev=serial0,id=serial0,name=serial0
> > > > kernel error:
> > > >   virtio-ports vport2p2: Error allocating inbufs
> > > > qemu error:
> > > >   virtio-serial-bus: Guest failure in adding port 2 for device
> > > > \
> > > >                      virtio-serial0.0
> > > > 
> > > > This happens because buffers for the in_vq are allocated when
> > > > the port is
> > > > added but are not released when the port is unplugged.
> > > > 
> > > > They are only released when virtconsole is removed (see
> > > > a7a69ec0d8e4)
> > > > 
> > > > To avoid the problem and to be symmetric, we could allocate all
> > > > the buffers
> > > > in init_vqs() as they are released in remove_vqs(), but it
> > > > sounds like
> > > > a waste of memory.
> > > > 
> > > > Rather than that, this patch changes add_port() logic to only
> > > > allocate the
> > > > buffers if the in_vq has available free slots.
> > > > 
> > > > Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after
> > > > reset")
> > > > Cc: mst@redhat.com
> > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > > ---
> > > >  drivers/char/virtio_console.c | 17 +++++++++++------
> > > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/char/virtio_console.c
> > > > b/drivers/char/virtio_console.c
> > > > index 7270e7b69262..77105166fe01 100644
> > > > --- a/drivers/char/virtio_console.c
> > > > +++ b/drivers/char/virtio_console.c
> > > > @@ -1421,12 +1421,17 @@ static int add_port(struct ports_device
> > > > *portdev, u32 id)
> > > >  	spin_lock_init(&port->outvq_lock);
> > > >  	init_waitqueue_head(&port->waitqueue);
> > > >  
> > > > -	/* Fill the in_vq with buffers so the host can send us
> > > > data. */
> > > > -	nr_added_bufs = fill_queue(port->in_vq, &port-
> > > > >inbuf_lock);
> > > > -	if (!nr_added_bufs) {
> > > > -		dev_err(port->dev, "Error allocating
> > > > inbufs\n");
> > > > -		err = -ENOMEM;
> > > > -		goto free_device;
> > > > +	/* if the in_vq has not already been filled (the port
> > > > has already been
> > > > +	 * used and unplugged), fill the in_vq with buffers so
> > > > the host can
> > > > +	 * send us data.
> > > > +	 */
> > > > +	if (port->in_vq->num_free != 0) {
> > > > +		nr_added_bufs = fill_queue(port->in_vq, &port-
> > > > >inbuf_lock);
> > > > +		if (!nr_added_bufs) {
> > > > +			dev_err(port->dev, "Error allocating
> > > > inbufs\n");
> > > > +			err = -ENOMEM;
> > > > +			goto free_device;
> > > > +		}
> > > >  	}
> > > >  
> > > >  	if (is_rproc_serial(port->portdev->vdev))
> > > 
> > > Well fill_queue will just add slots as long as it can.
> > > So on a full queue it does nothing. How does this patch help?
> > 
> > Yes, but in this case it returns 0 and so add_port() fails and
> > exits
> > with -ENOMEM and the device is freed. It's what this patch tries to
> > avoid.
> > 
> > Thanks,
> > Laurent
> 
> Oh I see. However it's a bit asymmetrical to special case ring full.
> How about making fill_queue return int and testing return code for
> -ENOSPC instead? Will also help propagate errors correctly.

Yes, I like this better too.

Can you call out which commit introduced this behaviour / regression?

> 
> And I guess CC stable?
> 
