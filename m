From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv4 0/6] qemu-kvm: vhost net support
Date: Tue, 3 Nov 2009 13:03:49 +0200
Message-ID: <20091103110349.GB3375__22587.8073405058$1257246623$gmane$org@redhat.com>
References: <20091102222320.GA15153@redhat.com>
	<4AEF641F.7080106@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AEF641F.7080106@codemonkey.ws>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <anthony@codemonkey.ws>
Cc: Mark McLoughlin <markmc@redhat.com>, avi@redhat.com, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Nov 02, 2009 at 04:58:39PM -0600, Anthony Liguori wrote:
> Hi Michael,
>
> I'll reserve individual patch review until they're in a mergable state,  
> but I do have some comments about the overall integration architecture.
>
> Generally speaking, I think the integration unnecessarily invasive.  It  
> adds things to the virtio infrastructure that shouldn't be there like  
> the irqfd/queuefd bindings.  It also sneaks in things like raw backend  
> support which really isn't needed.
>
> I think we can do better.  Here's what I suggest:
>
> The long term goal should be to have a NetDevice interface that looks  
> very much like virtio-net but as an API, not an ABI.  Roughly, it would  
> look something like:
>
> struct NetDevice {
>   int add_xmit(NetDevice *dev, struct iovec *iov, int iovcnt, void *token);
>   int add recv(NetDevice *dev, struct iovec *iov, int iovcnt, void *token);
>
>   void *get_xmit(NetDevice *dev);
>   void *get_recv(NetDevice *dev);
>
>   void kick(NetDevice *dev);
>
>   ...
> };
>
> That gives us a better API for use with virtio-net, e1000, etc.

This is not much different from what we have now with VLANClientState,
is it?

> Assuming we had this interface, I think a natural extension would be:
>
> int add_ring(NetDevice *dev, void *address);
> int add_kickfd(NetDevice *dev, int fd);
>
> For slot management, it really should happen outside of the NetDevice  
> structure.  We'll need a slot notifier mechanism such that we can keep  
> this up to date as things change.

Yes.

> vhost-net because a NetDevice.  It can support things like the e1000 by  
> doing ring translation behind the scenes.

And the point would be?

> virtio-net can be fast pathed  
> in the case that we're using KVM but otherwise, it would also rely on  
> the ring translation.

Won't it be easier to just keep using existing code?

>  N.B. in the case vhost-net is fast pathed, it  requires a different
>  device in QEMU that uses a separate virtio  transport.  We should
>  reuse as much code as possible obviously.  It  doesn't make sense to
>  have all of the virtio-pci code and virtio-net  code in place when we
>  aren't using it.

Note that all of virtio-pci and setup parts of virtio-net are reused.
The only things we are *not* re-using are send/receive and callbacks in
virtio-net.

> All this said, I'm *not* suggesting you have to implement all of this to  
> get vhost-net merged.  Rather, I'm suggesting that we should try to  
> structure the current vhost-net implementation to complement this  
> architecture assuming we all agree this is the sane thing to do.  That  
> means I would make the following changes to your series:
>
> - move vhost-net support to a VLANClientState backend.
> - do not introduce a raw socket backend
> - if for some reason you want to back to tap and raw, those should be  
> options to the vhost-net backend.
> - when fast pathing with vhost-net, we should introduce interfaces to  
> VLANClientState similar to add_ring and add_kickfd.  They'll be very  
> specific to vhost-net for now, but that's okay.
> - sort out the layering of vhost-net within the virtio infrastructure.   
> vhost-net should really be it's own qdev device.
>  I don't see very much  
> code reuse happening right now so I don't understand why it's not that  
> way currently.
> Regards,
>
> Anthony Liguori

What you propose short-term is workable.  So basically, vhost would be
an option supported by backends.  virtio net would go ahead and activate
it if available and other frontends will ignore it and just keep
injecting packets through regular interfaces.

-- 
MST
