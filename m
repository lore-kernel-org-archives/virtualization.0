From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/2] virtio_console: free unused buffers with port
	delete
Date: Mon, 12 Aug 2019 05:18:41 -0400
Message-ID: <20190812051642-mutt-send-email-mst@kernel.org>
References: <20190809064847.28918-1-pagupta@redhat.com>
	<20190809064847.28918-2-pagupta@redhat.com>
	<20190810141019-mutt-send-email-mst@kernel.org>
	<361928616.7829318.1565588208467.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <361928616.7829318.1565588208467.JavaMail.zimbra@redhat.com>
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
Cc: arnd@arndb.de, amit@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xiaohli@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Aug 12, 2019 at 01:36:48AM -0400, Pankaj Gupta wrote:
> 
> > 
> > On Fri, Aug 09, 2019 at 12:18:46PM +0530, Pankaj Gupta wrote:
> > > The commit a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > > deferred detaching of unused buffer to virtio device unplug time.
> > > This causes unplug/replug of single port in virtio device with an
> > > error "Error allocating inbufs\n". As we don't free the unused buffers
> > > attached with the port. Re-plug the same port tries to allocate new
> > > buffers in virtqueue and results in this error if queue is full.
> > 
> > So why not reuse the buffers that are already there in this case?
> > Seems quite possible.
> 
> I took this approach because reusing the buffers will involve tweaking
> the existing core functionality like managing the the virt queue indexes.

I don't see why frankly, if you keep a list of outstanding
buffers on plug you can assume they have been added.

> Compared to that deleting the buffers while hot-unplugging port is simple
> and was working fine before. It seems logically correct as well.   
> 
> I agree we need a spec change for this.
> 
> > 
> > > This patch removes the unused buffers in vq's when we unplug the port.
> > > This is the best we can do as we cannot call device_reset because virtio
> > > device is still active.
> > > 
> > > Reported-by: Xiaohui Li <xiaohli@redhat.com>
> > > Fixes: a7a69ec0d8e4 ("virtio_console: free buffers after reset")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > 
> > This is really a revert of a7a69ec0d8e4, just tagged confusingly.
> > 
> > And the original is also supposed to be a bugfix.
> > So how will the original bug be fixed?
> 
> Yes, Even I was confused while adding this tag.
> I will remove remove 'fixes' tag completely for this patch?
> because its a revert to original behavior which also is a bugfix.
> 
> > 
> > "this is the best we can do" is rarely the case.
> > 
> > I am not necessarily against the revert. But if we go that way then what
> > we need to do is specify the behaviour in the spec, since strict spec
> > compliance is exactly what the original patch was addressing.
> 
> Agree.
> 
> > 
> > In particular, we'd document that console has a special property that
> > when port is detached virtqueue is considered stopped, device must not
> > use any buffers, and it is legal to take buffers out of the device.
> 
> Yes. This documents the exact scenario. Thanks.
> You want me to send a patch for the spec change?
> 
> Best regards,
> Pankaj

Go ahead.

> > 
> > 
> > 
> > > ---
> > >  drivers/char/virtio_console.c | 14 +++++++++++---
> > >  1 file changed, 11 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
> > > index 7270e7b69262..e8be82f1bae9 100644
> > > --- a/drivers/char/virtio_console.c
> > > +++ b/drivers/char/virtio_console.c
> > > @@ -1494,15 +1494,25 @@ static void remove_port(struct kref *kref)
> > >          kfree(port);
> > >  }
> > >  
> > > +static void remove_unused_bufs(struct virtqueue *vq)
> > > +{
> > > +        struct port_buffer *buf;
> > > +
> > > +        while ((buf = virtqueue_detach_unused_buf(vq)))
> > > +                free_buf(buf, true);
> > > +}
> > > +
> > >  static void remove_port_data(struct port *port)
> > >  {
> > >          spin_lock_irq(&port->inbuf_lock);
> > >          /* Remove unused data this port might have received. */
> > >          discard_port_data(port);
> > > +        remove_unused_bufs(port->in_vq);
> > >          spin_unlock_irq(&port->inbuf_lock);
> > >  
> > >          spin_lock_irq(&port->outvq_lock);
> > >          reclaim_consumed_buffers(port);
> > > +        remove_unused_bufs(port->out_vq);
> > >          spin_unlock_irq(&port->outvq_lock);
> > >  }
> > >  
> > > @@ -1938,11 +1948,9 @@ static void remove_vqs(struct ports_device *portdev)
> > >          struct virtqueue *vq;
> > >  
> > >          virtio_device_for_each_vq(portdev->vdev, vq) {
> > > -                struct port_buffer *buf;
> > >  
> > >                  flush_bufs(vq, true);
> > > -                while ((buf = virtqueue_detach_unused_buf(vq)))
> > > -                        free_buf(buf, true);
> > > +                remove_unused_bufs(vq);
> > >          }
> > >          portdev->vdev->config->del_vqs(portdev->vdev);
> > >          kfree(portdev->in_vqs);
> > > --
> > > 2.21.0
> > 
