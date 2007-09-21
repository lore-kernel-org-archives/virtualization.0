From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH 1/6] virtio interace
Date: Fri, 21 Sep 2007 21:37:28 +1000
Message-ID: <1190374648.27805.4.camel@localhost.localdomain>
References: <1190289808.7262.223.camel@localhost.localdomain>
	<1190290140.7262.228.camel@localhost.localdomain>
	<46F2674A.2050403@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46F2674A.2050403@qumranet.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-09-20 at 14:27 +0200, Avi Kivity wrote: 
> Rusty Russell wrote:
> > +struct virtio_backend_ops virtio_backend_ops;
> > +EXPORT_SYMBOL_GPL(virtio_backend_ops);
> 
> Suggest calling this virtio_transport_ops rather than the too-generic 
> virtio_backend_ops.  Especially since Xen uses backend for something 
> completely different.

Hi Avi,

Agreed, fixed.  I actually don't like this interface at all, but it is
simple until we determine something better.

> > +/**
> > + * virtqueue_ops - operations for virtqueue abstraction layer
> > + * @new_vq: create a new virtqueue
> > + *	config: the virtio_config_space field describing the queue
> > + *	off: the offset in the config space of the queue configuration
> > + *	len: the length of the virtio_config_space field
> >   
> 
> 'off, len' are really a magic cookie.  Why does the interface care about 
> their meaning?

off is a cookie, len isn't.  The driver does "get me the foo field" and
it returns off + len.  If it wants to read or write the foo field it
needs that length.

In practice, drivers use the virtio_config_vq() convenience interface
which does "find field, hand to ops->new_vq".

> > + *	callback: the driver callback when the queue is used.
> >   
> 
> Missing callback return value description.

Indeed, that's always made me uncomfortable.  Fixed.  Although it's
possible that an explicit disable hook is better...

> > + * @kick: update after add_buf
> > + *	vq: the struct virtqueue
> > + *	After one or more add_buf calls, invoke this to kick the virtio layer.
> >   
> 
> 'the other side'

Thanks, fixed.

> I'm not thrilled about reusing pci ids.  Maybe the s390 can say whether 
> this is a real issue.

I doubt it: it's not a problem for lguest.  But I wonder if I've chosen
the right fields...

Rusty.
