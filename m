From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [RFC PATCH 10/13] vsock: add multi-transports support
Date: Thu, 10 Oct 2019 14:55:21 +0200
Message-ID: <20191010125521.mf7elqjpwhwjhwpo__35549.8399863549$1570712140$gmane$org@steredhat>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-11-sgarzare@redhat.com>
	<20191009131123.GK5747@stefanha-x1.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20191009131123.GK5747@stefanha-x1.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 09, 2019 at 02:11:23PM +0100, Stefan Hajnoczi wrote:
> On Fri, Sep 27, 2019 at 01:27:00PM +0200, Stefano Garzarella wrote:
> > RFC:
> > - I'd like to move MODULE_ALIAS_NETPROTO(PF_VSOCK) to af_vsock.c.
> >   @Jorgen could this break the VMware products?
> 
> What will cause the vmw_vsock_vmci_transport.ko module to be loaded
> after you remove MODULE_ALIAS_NETPROTO(PF_VSOCK)?  Perhaps
> drivers/misc/vmw_vmci/vmci_guest.c:vmci_guest_probe_device() could do
> something when the guest driver loads.

Good idea, maybe we can call some function provided by vmci_transport
to register it as a guest (I'll remove the type from the transport
and I add it as a parameter of vsock_core_register())

>                                         There would need to be something
> equivalent for the host side too.

Maybe in the vmci_host_do_init_context().

> 
> This will solve another issue too.  Today the VMCI transport can be
> loaded if an application creates an AF_VSOCK socket during early boot
> before the virtio transport has been probed.  This happens because the
> VMCI transport uses MODULE_ALIAS_NETPROTO(PF_VSOCK) *and* it does not
> probe whether this system is actually a VMware guest.
> 
> If we instead load the core af_vsock.ko module and transports are only
> loaded based on hardware feature probing (e.g. the presence of VMware
> guest mode, a virtio PCI adapter, etc) then transports will be
> well-behaved.

Yes, I completely agree with you. I'll try to follow your suggestion,

> 
> > - DGRAM sockets are handled as before, I don't know if make sense work
> >   on it now, or when another transport will support DGRAM. The big
> >   issues here is that we cannot link 1-1 a socket to transport as
> >   for stream sockets since DGRAM is not connection-oriented.
> 
> Let's ignore DGRAM for now since only VMCI supports it and we therefore
> do not require multi-transpor) support.

Okay :)

> 
> > diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> > index 86f8f463e01a..2a081d19e20d 100644
> > --- a/include/net/af_vsock.h
> > +++ b/include/net/af_vsock.h
> > @@ -94,7 +94,13 @@ struct vsock_transport_send_notify_data {
> >  	u64 data2; /* Transport-defined. */
> >  };
> >  
> > +#define VSOCK_TRANSPORT_F_H2G		0x00000001
> > +#define VSOCK_TRANSPORT_F_G2H		0x00000002
> > +#define VSOCK_TRANSPORT_F_DGRAM		0x00000004
> 
> Documentation comments, please.

I'll fix!

> 
> > +void vsock_core_unregister(const struct vsock_transport *t)
> > +{
> > +	mutex_lock(&vsock_register_mutex);
> > +
> > +	/* RFC-TODO: maybe we should check if there are open sockets
> > +	 * assigned to that transport and avoid the unregistration
> > +	 */
> 
> If unregister() is only called from module_exit() functions then holding
> a reference to the transport module would be enough to prevent this
> case.  The transport could only be removed once all sockets have been
> destroyed (and dropped their transport module reference).

Yes. I did this in
"[RFC PATCH 12/13] vsock: prevent transport modules unloading".

Maybe I can merge it in this patch...

Thanks,
Stefano
