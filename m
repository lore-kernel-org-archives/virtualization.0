From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [PATCH] virtio_console: free unused buffers with virtio port
Date: Tue, 5 Mar 2019 02:09:06 -0500 (EST)
Message-ID: <444210313.9669582.1551769746169.JavaMail.zimbra__3420.30963381461$1551770600$gmane$org@redhat.com>
References: <20190304130511.14450-1-pagupta@redhat.com>
	<20190304142506-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190304142506-mutt-send-email-mst@kernel.org>
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
Cc: arnd@arndb.de, amit@kernel.org, Gal Hammer <ghammer@redhat.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xiaohli@redhat.com
List-Id: virtualization@lists.linuxfoundation.org


Hello Michael,

Thanks for your reply.

> 
> On Mon, Mar 04, 2019 at 06:35:11PM +0530, Pankaj Gupta wrote:
> >   The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> >   deffered detaching of unused buffer to virtio device unplug time.
> > 
> >   This causes unplug/replug of single port in virtio device with an
> >   error "Error allocating inbufs\n". As we don't free the unused buffers
> >   attached with the port. Re-plug the same port tries to allocate new
> >   buffers in virtqueue and results in this error if queue is full.
> > 
> >   This patch removes the unused buffers in vq's when we unplug the port.
> >   This is the best we can do as we cannot call device_reset because virtio
> >   device is still active. This was the working behaviour before the change
> >   introduced in commit b3258ff1d6.
> > 
> >   Reported-by: Xiaohui Li <xiaohli@redhat.com>
> >   Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")
> >   Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> 
> I think if you do this you need to add support
> in the packed ring.

o.k. I will look at the implementation details for "support
of packed ring" for virtio_console. This will take some time.

Meanwhile "virtio_console" port hotplug/unplug is broken in upstream.
Can we accept this patch as it fixes the upstream and together
with parent patch(b3258ff1d6) does nice cleanups as well.

Thanks,
Pankaj  

> 
> > ---
> >  drivers/char/virtio_console.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index fbeb71953526..5fbf2ac73111 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1506,15 +1506,25 @@ static void remove_port(struct kref *kref)
> >          kfree(port);
> >  }
> >  
> > +static void remove_unused_bufs(struct virtqueue *vq)
> > +{
> > +        struct port_buffer *buf;
> > +
> > +        while ((buf = virtqueue_detach_unused_buf(vq)))
> > +                free_buf(buf, true);
> > +}
> > +
> >  static void remove_port_data(struct port *port)
> >  {
> >          spin_lock_irq(&port->inbuf_lock);
> >          /* Remove unused data this port might have received. */
> >          discard_port_data(port);
> > +        remove_unused_bufs(port->in_vq);
> >          spin_unlock_irq(&port->inbuf_lock);
> >  
> >          spin_lock_irq(&port->outvq_lock);
> >          reclaim_consumed_buffers(port);
> > +        remove_unused_bufs(port->out_vq);
> >          spin_unlock_irq(&port->outvq_lock);
> >  }
> >  
> > @@ -1950,11 +1960,9 @@ static void remove_vqs(struct ports_device *portdev)
> >          struct virtqueue *vq;
> >  
> >          virtio_device_for_each_vq(portdev->vdev, vq) {
> > -                struct port_buffer *buf;
> >  
> >                  flush_bufs(vq, true);
> > -                while ((buf = virtqueue_detach_unused_buf(vq)))
> > -                        free_buf(buf, true);
> > +                remove_unused_bufs(vq);
> >          }
> >          portdev->vdev->config->del_vqs(portdev->vdev);
> >          kfree(portdev->in_vqs);
> > --
> > 2.20.1
> 
