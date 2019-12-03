From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 0/3] vsock: support network namespace
Date: Tue, 3 Dec 2019 09:26:49 +0000
Message-ID: <20191203092649.GB153510__17834.8774484888$1575365225$gmane$org@stefanha-x1.localdomain>
References: <20191128171519.203979-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1416234420332745454=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191128171519.203979-1-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: linux-hyperv@vger.kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1416234420332745454==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2019 at 06:15:16PM +0100, Stefano Garzarella wrote:
> Hi,
> now that we have multi-transport upstream, I started to take a look to
> support network namespace (netns) in vsock.
>=20
> As we partially discussed in the multi-transport proposal [1], it could
> be nice to support network namespace in vsock to reach the following
> goals:
> - isolate host applications from guest applications using the same ports
>   with CID_ANY
> - assign the same CID of VMs running in different network namespaces
> - partition VMs between VMMs or at finer granularity
>=20
> This preliminary implementation provides the following behavior:
> - packets received from the host (received by G2H transports) are
>   assigned to the default netns (init_net)
> - packets received from the guest (received by H2G - vhost-vsock) are
>   assigned to the netns of the process that opens /dev/vhost-vsock
>   (usually the VMM, qemu in my tests, opens the /dev/vhost-vsock)
>     - for vmci I need some suggestions, because I don't know how to do
>       and test the same in the vmci driver, for now vmci uses the
>       init_net
> - loopback packets are exchanged only in the same netns
>=20
> Questions:
> 1. Should we make configurable the netns (now it is init_net) where
>    packets from the host should be delivered?

Yes, it should be possible to have multiple G2H (e.g. virtio-vsock)
devices and to assign them to different net namespaces.  Something like
net/core/dev.c:dev_change_net_namespace() will eventually be needed.

> 2. Should we provide an ioctl in vhost-vsock to configure the netns
>    to use? (instead of using the netns of the process that opens
>    /dev/vhost-vsock)

Creating the vhost-vsock instance in the process' net namespace makes
sense.  Maybe wait for a use case before adding an ioctl.

> 3. Should we provide a way to disable the netns support in vsock?

The code should follow CONFIG_NET_NS semantics.  I'm not sure what they
are exactly since struct net is always defined, regardless of whether
network namespaces are enabled.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3mKlkACgkQnKSrs4Gr
c8h54wf/eNE48AsDKZkZl+68dw3paeS7KLIQEPgUklUhfhqp/IHdX9uG2R88hvCl
rMCQbGHSMQ+yb7gPxN1+0tVXFX7Rf2Cqed4Lwqfq0VvufS80FUk4GiQZKKgk4LRv
/8x4or61TnKGbApxbJnQ+zdj1OirmGwrO8jEt4beMPgsfY80yzl6GcKwYwsOYzeg
w+28vrKtnprab8l8D0DnVIggTtyep72rsGdeOi4KtSmrUoM8GVExUDmwBQtUJ4xo
5+OJJjQ+EzPuKWxGIahFrZAHDGerrVHWyltH/LTq+BU0VNR+Ta726WWzDKVx7v6d
YQm7/TdSAT3l9Id0uVC9+DEM455UIw==
=v5qS
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

--===============1416234420332745454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1416234420332745454==--
