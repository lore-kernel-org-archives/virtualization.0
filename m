From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] virtio_console: free unused buffers with virtio port
Date: Mon, 11 Mar 2019 02:36:17 -0400
Message-ID: <20190311023544-mutt-send-email-mst__17031.0438190185$1552286189$gmane$org@kernel.org>
References: <20190304130511.14450-1-pagupta@redhat.com>
	<1061079510.11168464.1552283891949.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1061079510.11168464.1552283891949.JavaMail.zimbra@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pankaj Gupta <pagupta@redhat.com>
Cc: arnd@arndb.de, amit@kernel.org, Gal Hammer <ghammer@redhat.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xiaohli@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Mar 11, 2019 at 01:58:11AM -0400, Pankaj Gupta wrote:
> 
> > 
> > The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
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
> 
> ping.
> 
> This patch fixes a regression in upstream kernel, virtio_console driver.
> Can we please have this merged.
> 
> Thanks,
> Pankaj

Sorry, no, I don't think that's a full fix.

> > 
> >   Reported-by: Xiaohui Li <xiaohli@redhat.com>
> >   Fixes: b3258ff1d6 ("virtio_console: free buffers after reset")
> >   Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > ---
> >  drivers/char/virtio_console.c | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > index fbeb71953526..5fbf2ac73111 100644
> > --- a/drivers/char/virtio_console.c
> > +++ b/drivers/char/virtio_console.c
> > @@ -1506,15 +1506,25 @@ static void remove_port(struct kref *kref)
> >  	kfree(port);
> >  }
> >  
> > +static void remove_unused_bufs(struct virtqueue *vq)
> > +{
> > +	struct port_buffer *buf;
> > +
> > +	while ((buf = virtqueue_detach_unused_buf(vq)))
> > +		free_buf(buf, true);
> > +}
> > +
> >  static void remove_port_data(struct port *port)
> >  {
> >  	spin_lock_irq(&port->inbuf_lock);
> >  	/* Remove unused data this port might have received. */
> >  	discard_port_data(port);
> > +	remove_unused_bufs(port->in_vq);
> >  	spin_unlock_irq(&port->inbuf_lock);
> >  
> >  	spin_lock_irq(&port->outvq_lock);
> >  	reclaim_consumed_buffers(port);
> > +	remove_unused_bufs(port->out_vq);
> >  	spin_unlock_irq(&port->outvq_lock);
> >  }
> >  
> > @@ -1950,11 +1960,9 @@ static void remove_vqs(struct ports_device *portdev)
> >  	struct virtqueue *vq;
> >  
> >  	virtio_device_for_each_vq(portdev->vdev, vq) {
> > -		struct port_buffer *buf;
> >  
> >  		flush_bufs(vq, true);
> > -		while ((buf = virtqueue_detach_unused_buf(vq)))
> > -			free_buf(buf, true);
> > +		remove_unused_bufs(vq);
> >  	}
> >  	portdev->vdev->config->del_vqs(portdev->vdev);
> >  	kfree(portdev->in_vqs);
> > --
> > 2.20.1
> > 
> > 
