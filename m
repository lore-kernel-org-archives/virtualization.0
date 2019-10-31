From: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH net-next 11/14] vsock: add multi-transports support
Date: Thu, 31 Oct 2019 09:54:42 +0100
Message-ID: <20191031085442.vkb5tnchfsa6n4dh__10384.6781583101$1572512098$gmane$org@steredhat>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-12-sgarzare@redhat.com>
	<CAGxU2F7n48kBy_y2GB=mcvraK=mw_2Jn8=2hvQnEOWqWuT9OjA@mail.gmail.com>
	<MWHPR05MB3376E623764F54D39D8135A9DA600@MWHPR05MB3376.namprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <MWHPR05MB3376E623764F54D39D8135A9DA600@MWHPR05MB3376.namprd05.prod.outlook.com>
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
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, kvm <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 30, 2019 at 03:40:05PM +0000, Jorgen Hansen wrote:
> > From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> > > +/* Assign a transport to a socket and call the .init transport callback.
> > > + *
> > > + * Note: for stream socket this must be called when vsk->remote_addr
> > > +is set
> > > + * (e.g. during the connect() or when a connection request on a
> > > +listener
> > > + * socket is received).
> > > + * The vsk->remote_addr is used to decide which transport to use:
> > > + *  - remote CID > VMADDR_CID_HOST will use host->guest transport
> > > + *  - remote CID <= VMADDR_CID_HOST will use guest->host transport
> > > +*/ int vsock_assign_transport(struct vsock_sock *vsk, struct
> > > +vsock_sock *psk) {
> > > +       const struct vsock_transport *new_transport;
> > > +       struct sock *sk = sk_vsock(vsk);
> > > +
> > > +       switch (sk->sk_type) {
> > > +       case SOCK_DGRAM:
> > > +               new_transport = transport_dgram;
> > > +               break;
> > > +       case SOCK_STREAM:
> > > +               if (vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
> > > +                       new_transport = transport_h2g;
> > > +               else
> > > +                       new_transport = transport_g2h;
> > 
> > I just noticed that this break the loopback in the guest.
> > As a fix, we should use 'transport_g2h' when remote_cid <=
> > VMADDR_CID_HOST or remote_cid is the id of 'transport_g2h'.
> > 
> > To do that we also need to avoid that L2 guests can have the same CID of L1.
> > For vhost_vsock I can call vsock_find_cid() in vhost_vsock_set_cid()
> > 
> > @Jorgen: for vmci we need to do the same? or it is guaranteed, since it's
> > already support nested VMs, that a L2 guests cannot have the same CID as
> > the L1.
> 
> As far as I can tell, we have the same issue with the current support for nested VMs in
> VMCI. If we have an L2 guest with the same CID as the L1 guest, we will always send to
> the L2 guest, and we may assign an L2 guest the same CID as L1. It should be straight
> forward to avoid this, though.
> 

Yes, I think so.

For the v2 I'm exposing the vsock_find_cid() to the transports, in this
way I can reject requests to set the same L1 CID for L2 guests.

Thanks,
Stefano
