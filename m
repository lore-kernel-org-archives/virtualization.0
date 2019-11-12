From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 11/14] vsock: add multi-transports support
Date: Tue, 12 Nov 2019 11:36:30 +0100
Message-ID: <20191112103630.vd3kbk7xnplv6rey__31633.6916921259$1573555011$gmane$org@steredhat>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-12-sgarzare@redhat.com>
	<MWHPR05MB33761FE4DA27130C72FC5048DA740@MWHPR05MB3376.namprd05.prod.outlook.com>
	<20191111171740.xwo7isdmtt7ywibo@steredhat>
	<MWHPR05MB33764F82AFA882B921A11E56DA770@MWHPR05MB3376.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <MWHPR05MB33764F82AFA882B921A11E56DA770@MWHPR05MB3376.namprd05.prod.outlook.com>
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
To: Jorgen Hansen <jhansen@vmware.com>
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 12, 2019 at 09:59:12AM +0000, Jorgen Hansen wrote:
> > From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> > Sent: Monday, November 11, 2019 6:18 PM
> > To: Jorgen Hansen <jhansen@vmware.com>
> > Subject: Re: [PATCH net-next 11/14] vsock: add multi-transports support
> > 
> > On Mon, Nov 11, 2019 at 01:53:39PM +0000, Jorgen Hansen wrote:
> > > > From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> > > > Sent: Wednesday, October 23, 2019 11:56 AM
> > >
> > > Thanks a lot for working on this!
> > >
> > 
> > Thanks to you for the reviews!
> > 
> > > > With the multi-transports support, we can use vsock with nested VMs
> > (using
> > > > also different hypervisors) loading both guest->host and
> > > > host->guest transports at the same time.
> > > >
> > > > Major changes:
> > > > - vsock core module can be loaded regardless of the transports
> > > > - vsock_core_init() and vsock_core_exit() are renamed to
> > > >   vsock_core_register() and vsock_core_unregister()
> > > > - vsock_core_register() has a feature parameter (H2G, G2H, DGRAM)
> > > >   to identify which directions the transport can handle and if it's
> > > >   support DGRAM (only vmci)
> > > > - each stream socket is assigned to a transport when the remote CID
> > > >   is set (during the connect() or when we receive a connection request
> > > >   on a listener socket).
> > >
> > > How about allowing the transport to be set during bind as well? That
> > > would allow an application to ensure that it is using a specific transport,
> > > i.e., if it binds to the host CID, it will use H2G, and if it binds to something
> > > else it will use G2H? You can still use VMADDR_CID_ANY if you want to
> > > initially listen to both transports.
> > 
> > Do you mean for socket that will call the connect()?
> 
> I was just thinking that in general we know the transport at that point, so we
> could ensure that the socket would only see traffic from the relevant transport,
> but as you mention below -  the updated bind lookup, and the added checks
> when selecting transport should also take care of this, so that is fine.
>  
> > For listener socket the "[PATCH net-next 14/14] vsock: fix bind() behaviour
> > taking care of CID" provides this behaviour.
> > Since the listener sockets don't use any transport specific callback
> > (they don't send any data to the remote peer), but they are used as
> > placeholder,
> > we don't need to assign them to a transport.
> > 
> > >
> > >
> > > >   The remote CID is used to decide which transport to use:
> > > >   - remote CID > VMADDR_CID_HOST will use host->guest transport
> > > >   - remote CID <= VMADDR_CID_HOST will use guest->host transport
> > > > - listener sockets are not bound to any transports since no transport
> > > >   operations are done on it. In this way we can create a listener
> > > >   socket, also if the transports are not loaded or with VMADDR_CID_ANY
> > > >   to listen on all transports.
> > > > - DGRAM sockets are handled as before, since only the vmci_transport
> > > >   provides this feature.
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > > RFC -> v1:
> > > > - documented VSOCK_TRANSPORT_F_* flags
> > > > - fixed vsock_assign_transport() when the socket is already assigned
> > > >   (e.g connection failed)
> > > > - moved features outside of struct vsock_transport, and used as
> > > >   parameter of vsock_core_register()
> > > > ---
> > > >  drivers/vhost/vsock.c                   |   5 +-
> > > >  include/net/af_vsock.h                  |  17 +-
> > > >  net/vmw_vsock/af_vsock.c                | 237 ++++++++++++++++++------
> > > >  net/vmw_vsock/hyperv_transport.c        |  26 ++-
> > > >  net/vmw_vsock/virtio_transport.c        |   7 +-
> > > >  net/vmw_vsock/virtio_transport_common.c |  28 ++-
> > > >  net/vmw_vsock/vmci_transport.c          |  31 +++-
> > > >  7 files changed, 270 insertions(+), 81 deletions(-)
> > > >
> > >
> > >
> > > > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index
> > > > d89381166028..dddd85d9a147 100644
> > > > --- a/net/vmw_vsock/af_vsock.c
> > > > +++ b/net/vmw_vsock/af_vsock.c
> > > > @@ -130,7 +130,12 @@ static struct proto vsock_proto = {  #define
> > > > VSOCK_DEFAULT_BUFFER_MAX_SIZE (1024 * 256)  #define
> > > > VSOCK_DEFAULT_BUFFER_MIN_SIZE 128
> > > >
> > > > -static const struct vsock_transport *transport_single;
> > > > +/* Transport used for host->guest communication */ static const struct
> > > > +vsock_transport *transport_h2g;
> > > > +/* Transport used for guest->host communication */ static const struct
> > > > +vsock_transport *transport_g2h;
> > > > +/* Transport used for DGRAM communication */ static const struct
> > > > +vsock_transport *transport_dgram;
> > > >  static DEFINE_MUTEX(vsock_register_mutex);
> > > >
> > > >  /**** UTILS ****/
> > > > @@ -182,7 +187,7 @@ static int vsock_auto_bind(struct vsock_sock *vsk)
> > > >  	return __vsock_bind(sk, &local_addr);
> > > >  }
> > > >
> > > > -static int __init vsock_init_tables(void)
> > > > +static void vsock_init_tables(void)
> > > >  {
> > > >  	int i;
> > > >
> > > > @@ -191,7 +196,6 @@ static int __init vsock_init_tables(void)
> > > >
> > > >  	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++)
> > > >  		INIT_LIST_HEAD(&vsock_connected_table[i]);
> > > > -	return 0;
> > > >  }
> > > >
> > > >  static void __vsock_insert_bound(struct list_head *list, @@ -376,6
> > +380,62
> > > > @@ void vsock_enqueue_accept(struct sock *listener, struct sock
> > > > *connected)  }  EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
> > > >
> > > > +/* Assign a transport to a socket and call the .init transport callback.
> > > > + *
> > > > + * Note: for stream socket this must be called when vsk->remote_addr
> > is
> > > > +set
> > > > + * (e.g. during the connect() or when a connection request on a
> > > > +listener
> > > > + * socket is received).
> > > > + * The vsk->remote_addr is used to decide which transport to use:
> > > > + *  - remote CID > VMADDR_CID_HOST will use host->guest transport
> > > > + *  - remote CID <= VMADDR_CID_HOST will use guest->host transport
> > */
> > > > +int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock
> > > > +*psk) {
> > > > +	const struct vsock_transport *new_transport;
> > > > +	struct sock *sk = sk_vsock(vsk);
> > > > +
> > > > +	switch (sk->sk_type) {
> > > > +	case SOCK_DGRAM:
> > > > +		new_transport = transport_dgram;
> > > > +		break;
> > > > +	case SOCK_STREAM:
> > > > +		if (vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
> > > > +			new_transport = transport_h2g;
> > > > +		else
> > > > +			new_transport = transport_g2h;
> > > > +		break;
> > >
> > > You already mentioned that you are working on a fix for loopback
> > > here for the guest, but presumably a host could also do loopback.
> > 
> > IIUC we don't support loopback in the host, because in this case the
> > application will use the CID_HOST as address, but if we are in a nested
> > VM environment we are in trouble.
> 
> If both src and dst CID are CID_HOST, we should be fairly sure that this
> Is host loopback, no? If src is anything else, we would do G2H.
> 

The problem is that we don't know the src until we assign a transport
looking at the dst. (or if the user bound the socket to CID_HOST before
the connect(), but it is not very common)

So if we are in a L1 and the user uses the local guest CID, it works, but if
it uses the HOST_CID, the packet will go to the L0.

If we are in L0, it could be simple, because we can simply check if G2H
is not loaded, so any packet to CID_HOST, is host loopback.

I think that if the user uses the IOCTL_VM_SOCKETS_GET_LOCAL_CID, to set
the dest CID for the loopback, it works in both cases because we return the
HOST_CID in L0, and always the guest CID in L1, also if a H2G is loaded to
handle the L2.

Maybe we should document this in the man page.

But I have a question: Does vmci support the host loopback?
I've tried, and it seems not.

Also vhost-vsock doesn't support it, but virtio-vsock does.

> > 
> > Since several people asked about this feature at the KVM Forum, I would like
> > to add a new VMADDR_CID_LOCAL (i.e. using the reserved 1) and implement
> > loopback in the core.
> > 
> > What do you think?
> 
> What kind of use cases are mentioned in the KVM forum for loopback? One concern
> is that we have to maintain yet another interprocess communication mechanism,
> even though other choices exist already  (and those are likely to be more efficient
> given the development time and specific focus that went into those). To me, the
> local connections are mainly useful as a way to sanity test the protocol and transports.
> However, if loopback is compelling, it would make sense have it in the core, since it
> shouldn't need a specific transport. 

The common use cases is for developer point of view, and to test the
protocol and transports as you said.

People that are introducing VSOCK support in their projects, would like to
test them on their own PC without starting a VM.

The idea is to move the code to handle loopback from the virtio-vsock,
in the core, but in another series :-)

> 
> > 
> > > If we select transport during bind to a specific CID, this comment
> > 
> > Also in this case, are you talking about the peer that will call
> > connect()?
> 
> The same thought as mentioned in the beginning - but as mentioned
> above, I agree that your updated bind and transport selection should
> handle this as well.

Got it.

Thanks,
Stefano
