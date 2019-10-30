From: Jorgen Hansen via Virtualization
	<virtualization@lists.linux-foundation.org>
Subject: RE: [PATCH net-next 11/14] vsock: add multi-transports support
Date: Wed, 30 Oct 2019 15:40:05 +0000
Message-ID: <MWHPR05MB3376E623764F54D39D8135A9DA600__33099.2077988171$1572450026$gmane$org@MWHPR05MB3376.namprd05.prod.outlook.com>
References: <20191023095554.11340-1-sgarzare@redhat.com>
	<20191023095554.11340-12-sgarzare@redhat.com>
	<CAGxU2F7n48kBy_y2GB=mcvraK=mw_2Jn8=2hvQnEOWqWuT9OjA@mail.gmail.com>
Reply-To: Jorgen Hansen <jhansen@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGxU2F7n48kBy_y2GB=mcvraK=mw_2Jn8=2hvQnEOWqWuT9OjA@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: 'Stefano Garzarella' <sgarzare@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Arnd Bergmann <arnd@arndb.de>, kvm <kvm@vger.kernel.org>, "Michael S.
	Tsirkin" <mst@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Stefan Hajnoczi <stefanha@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "David S.
	Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org

> From: Stefano Garzarella [mailto:sgarzare@redhat.com]
> > +/* Assign a transport to a socket and call the .init transport callback.
> > + *
> > + * Note: for stream socket this must be called when vsk->remote_addr
> > +is set
> > + * (e.g. during the connect() or when a connection request on a
> > +listener
> > + * socket is received).
> > + * The vsk->remote_addr is used to decide which transport to use:
> > + *  - remote CID > VMADDR_CID_HOST will use host->guest transport
> > + *  - remote CID <= VMADDR_CID_HOST will use guest->host transport
> > +*/ int vsock_assign_transport(struct vsock_sock *vsk, struct
> > +vsock_sock *psk) {
> > +       const struct vsock_transport *new_transport;
> > +       struct sock *sk = sk_vsock(vsk);
> > +
> > +       switch (sk->sk_type) {
> > +       case SOCK_DGRAM:
> > +               new_transport = transport_dgram;
> > +               break;
> > +       case SOCK_STREAM:
> > +               if (vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
> > +                       new_transport = transport_h2g;
> > +               else
> > +                       new_transport = transport_g2h;
> 
> I just noticed that this break the loopback in the guest.
> As a fix, we should use 'transport_g2h' when remote_cid <=
> VMADDR_CID_HOST or remote_cid is the id of 'transport_g2h'.
> 
> To do that we also need to avoid that L2 guests can have the same CID of L1.
> For vhost_vsock I can call vsock_find_cid() in vhost_vsock_set_cid()
> 
> @Jorgen: for vmci we need to do the same? or it is guaranteed, since it's
> already support nested VMs, that a L2 guests cannot have the same CID as
> the L1.

As far as I can tell, we have the same issue with the current support for nested VMs in
VMCI. If we have an L2 guest with the same CID as the L1 guest, we will always send to
the L2 guest, and we may assign an L2 guest the same CID as L1. It should be straight
forward to avoid this, though.
