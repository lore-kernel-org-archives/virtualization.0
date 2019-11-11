From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 11/14] vsock: add multi-transports support
Date: Mon, 11 Nov 2019 18:17:40 +0100
Message-ID: <20191111171740.xwo7isdmtt7ywibo__25604.7436081403$1573492680$gmane$org@steredhat>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-12-sgarzare@redhat.com>
	<MWHPR05MB33761FE4DA27130C72FC5048DA740@MWHPR05MB3376.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <MWHPR05MB33761FE4DA27130C72FC5048DA740@MWHPR05MB3376.namprd05.prod.outlook.com>
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

On Mon, Nov 11, 2019 at 01:53:39PM +0000, Jorgen Hansen wrote:
> > From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> > Sent: Wednesday, October 23, 2019 11:56 AM
> 
> Thanks a lot for working on this!
> 

Thanks to you for the reviews!

> > With the multi-transports support, we can use vsock with nested VMs (using
> > also different hypervisors) loading both guest->host and
> > host->guest transports at the same time.
> > 
> > Major changes:
> > - vsock core module can be loaded regardless of the transports
> > - vsock_core_init() and vsock_core_exit() are renamed to
> >   vsock_core_register() and vsock_core_unregister()
> > - vsock_core_register() has a feature parameter (H2G, G2H, DGRAM)
> >   to identify which directions the transport can handle and if it's
> >   support DGRAM (only vmci)
> > - each stream socket is assigned to a transport when the remote CID
> >   is set (during the connect() or when we receive a connection request
> >   on a listener socket).
> 
> How about allowing the transport to be set during bind as well? That
> would allow an application to ensure that it is using a specific transport,
> i.e., if it binds to the host CID, it will use H2G, and if it binds to something
> else it will use G2H? You can still use VMADDR_CID_ANY if you want to
> initially listen to both transports.

Do you mean for socket that will call the connect()?

For listener socket the "[PATCH net-next 14/14] vsock: fix bind() behaviour
taking care of CID" provides this behaviour.
Since the listener sockets don't use any transport specific callback
(they don't send any data to the remote peer), but they are used as placeholder,
we don't need to assign them to a transport.

> 
> 
> >   The remote CID is used to decide which transport to use:
> >   - remote CID > VMADDR_CID_HOST will use host->guest transport
> >   - remote CID <= VMADDR_CID_HOST will use guest->host transport
> > - listener sockets are not bound to any transports since no transport
> >   operations are done on it. In this way we can create a listener
> >   socket, also if the transports are not loaded or with VMADDR_CID_ANY
> >   to listen on all transports.
> > - DGRAM sockets are handled as before, since only the vmci_transport
> >   provides this feature.
> > 
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > RFC -> v1:
> > - documented VSOCK_TRANSPORT_F_* flags
> > - fixed vsock_assign_transport() when the socket is already assigned
> >   (e.g connection failed)
> > - moved features outside of struct vsock_transport, and used as
> >   parameter of vsock_core_register()
> > ---
> >  drivers/vhost/vsock.c                   |   5 +-
> >  include/net/af_vsock.h                  |  17 +-
> >  net/vmw_vsock/af_vsock.c                | 237 ++++++++++++++++++------
> >  net/vmw_vsock/hyperv_transport.c        |  26 ++-
> >  net/vmw_vsock/virtio_transport.c        |   7 +-
> >  net/vmw_vsock/virtio_transport_common.c |  28 ++-
> >  net/vmw_vsock/vmci_transport.c          |  31 +++-
> >  7 files changed, 270 insertions(+), 81 deletions(-)
> > 
> 
> 
> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c index
> > d89381166028..dddd85d9a147 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -130,7 +130,12 @@ static struct proto vsock_proto = {  #define
> > VSOCK_DEFAULT_BUFFER_MAX_SIZE (1024 * 256)  #define
> > VSOCK_DEFAULT_BUFFER_MIN_SIZE 128
> > 
> > -static const struct vsock_transport *transport_single;
> > +/* Transport used for host->guest communication */ static const struct
> > +vsock_transport *transport_h2g;
> > +/* Transport used for guest->host communication */ static const struct
> > +vsock_transport *transport_g2h;
> > +/* Transport used for DGRAM communication */ static const struct
> > +vsock_transport *transport_dgram;
> >  static DEFINE_MUTEX(vsock_register_mutex);
> > 
> >  /**** UTILS ****/
> > @@ -182,7 +187,7 @@ static int vsock_auto_bind(struct vsock_sock *vsk)
> >  	return __vsock_bind(sk, &local_addr);
> >  }
> > 
> > -static int __init vsock_init_tables(void)
> > +static void vsock_init_tables(void)
> >  {
> >  	int i;
> > 
> > @@ -191,7 +196,6 @@ static int __init vsock_init_tables(void)
> > 
> >  	for (i = 0; i < ARRAY_SIZE(vsock_connected_table); i++)
> >  		INIT_LIST_HEAD(&vsock_connected_table[i]);
> > -	return 0;
> >  }
> > 
> >  static void __vsock_insert_bound(struct list_head *list, @@ -376,6 +380,62
> > @@ void vsock_enqueue_accept(struct sock *listener, struct sock
> > *connected)  }  EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
> > 
> > +/* Assign a transport to a socket and call the .init transport callback.
> > + *
> > + * Note: for stream socket this must be called when vsk->remote_addr is
> > +set
> > + * (e.g. during the connect() or when a connection request on a
> > +listener
> > + * socket is received).
> > + * The vsk->remote_addr is used to decide which transport to use:
> > + *  - remote CID > VMADDR_CID_HOST will use host->guest transport
> > + *  - remote CID <= VMADDR_CID_HOST will use guest->host transport  */
> > +int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock
> > +*psk) {
> > +	const struct vsock_transport *new_transport;
> > +	struct sock *sk = sk_vsock(vsk);
> > +
> > +	switch (sk->sk_type) {
> > +	case SOCK_DGRAM:
> > +		new_transport = transport_dgram;
> > +		break;
> > +	case SOCK_STREAM:
> > +		if (vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
> > +			new_transport = transport_h2g;
> > +		else
> > +			new_transport = transport_g2h;
> > +		break;
> 
> You already mentioned that you are working on a fix for loopback
> here for the guest, but presumably a host could also do loopback.

IIUC we don't support loopback in the host, because in this case the
application will use the CID_HOST as address, but if we are in a nested
VM environment we are in trouble.

Since several people asked about this feature at the KVM Forum, I would like
to add a new VMADDR_CID_LOCAL (i.e. using the reserved 1) and implement
loopback in the core.

What do you think?

> If we select transport during bind to a specific CID, this comment

Also in this case, are you talking about the peer that will call
connect()?

> Isn't relevant, but otherwise, we should look at the local addr as
> well, since a socket with local addr of host CID shouldn't use
> the guest to host transport, and a socket with local addr > host CID
> shouldn't use host to guest.

Yes, I agree, in my fix I'm looking at the local addr, and in L1 I'll
not allow to assign a CID to a nested L2 equal to the CID of L1 (in
vhost-vsock)

Maybe we can allow the host loopback (using CID_HOST), only if there isn't
G2H loaded, but also in this case I'd like to move the loopback in the vsock
core, since we can do that, also if there are no transports loaded.

> 
> 
> > +	default:
> > +		return -ESOCKTNOSUPPORT;
> > +	}
> > +
> > +	if (vsk->transport) {
> > +		if (vsk->transport == new_transport)
> > +			return 0;
> > +
> > +		vsk->transport->release(vsk);
> > +		vsk->transport->destruct(vsk);
> > +	}
> > +
> > +	if (!new_transport)
> > +		return -ENODEV;
> > +
> > +	vsk->transport = new_transport;
> > +
> > +	return vsk->transport->init(vsk, psk); }
> > +EXPORT_SYMBOL_GPL(vsock_assign_transport);
> > +
> > +static bool vsock_find_cid(unsigned int cid) {
> > +	if (transport_g2h && cid == transport_g2h->get_local_cid())
> > +		return true;
> > +
> > +	if (transport_h2g && cid == VMADDR_CID_HOST)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static struct sock *vsock_dequeue_accept(struct sock *listener)  {
> >  	struct vsock_sock *vlistener;
> 
> 
> > diff --git a/net/vmw_vsock/vmci_transport.c
> > b/net/vmw_vsock/vmci_transport.c index 5955238ffc13..2eb3f16d53e7
> > 100644
> > --- a/net/vmw_vsock/vmci_transport.c
> > +++ b/net/vmw_vsock/vmci_transport.c
> 
> > @@ -1017,6 +1018,15 @@ static int vmci_transport_recv_listen(struct sock
> > *sk,
> >  	vsock_addr_init(&vpending->remote_addr, pkt->dg.src.context,
> >  			pkt->src_port);
> > 
> > +	err = vsock_assign_transport(vpending, vsock_sk(sk));
> > +	/* Transport assigned (looking at remote_addr) must be the same
> > +	 * where we received the request.
> > +	 */
> > +	if (err || !vmci_check_transport(vpending)) {
> 
> We need to send a reset on error, i.e.,
>   vmci_transport_send_reset(sk, pkt);

Good catch, I'll fix in the v2.

Thanks,
Stefano
