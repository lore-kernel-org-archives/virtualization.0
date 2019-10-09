From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 10/13] vsock: add multi-transports support
Date: Wed, 9 Oct 2019 14:11:23 +0100
Message-ID: <20191009131123.GK5747__42428.4858907171$1570626702$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-11-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3392423860032156658=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-11-sgarzare@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============3392423860032156658==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IA03tywDYuoVKXrw"
Content-Disposition: inline


--IA03tywDYuoVKXrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2019 at 01:27:00PM +0200, Stefano Garzarella wrote:
> RFC:
> - I'd like to move MODULE_ALIAS_NETPROTO(PF_VSOCK) to af_vsock.c.
>   @Jorgen could this break the VMware products?

What will cause the vmw_vsock_vmci_transport.ko module to be loaded
after you remove MODULE_ALIAS_NETPROTO(PF_VSOCK)?  Perhaps
drivers/misc/vmw_vmci/vmci_guest.c:vmci_guest_probe_device() could do
something when the guest driver loads.  There would need to be something
equivalent for the host side too.

This will solve another issue too.  Today the VMCI transport can be
loaded if an application creates an AF_VSOCK socket during early boot
before the virtio transport has been probed.  This happens because the
VMCI transport uses MODULE_ALIAS_NETPROTO(PF_VSOCK) *and* it does not
probe whether this system is actually a VMware guest.

If we instead load the core af_vsock.ko module and transports are only
loaded based on hardware feature probing (e.g. the presence of VMware
guest mode, a virtio PCI adapter, etc) then transports will be
well-behaved.

> - DGRAM sockets are handled as before, I don't know if make sense work
>   on it now, or when another transport will support DGRAM. The big
>   issues here is that we cannot link 1-1 a socket to transport as
>   for stream sockets since DGRAM is not connection-oriented.

Let's ignore DGRAM for now since only VMCI supports it and we therefore
do not require multi-transport support.

> diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
> index 86f8f463e01a..2a081d19e20d 100644
> --- a/include/net/af_vsock.h
> +++ b/include/net/af_vsock.h
> @@ -94,7 +94,13 @@ struct vsock_transport_send_notify_data {
>  	u64 data2; /* Transport-defined. */
>  };
> =20
> +#define VSOCK_TRANSPORT_F_H2G		0x00000001
> +#define VSOCK_TRANSPORT_F_G2H		0x00000002
> +#define VSOCK_TRANSPORT_F_DGRAM		0x00000004

Documentation comments, please.

> +void vsock_core_unregister(const struct vsock_transport *t)
> +{
> +	mutex_lock(&vsock_register_mutex);
> +
> +	/* RFC-TODO: maybe we should check if there are open sockets
> +	 * assigned to that transport and avoid the unregistration
> +	 */

If unregister() is only called from module_exit() functions then holding
a reference to the transport module would be enough to prevent this
case.  The transport could only be removed once all sockets have been
destroyed (and dropped their transport module reference).

--IA03tywDYuoVKXrw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d3HoACgkQnKSrs4Gr
c8hckgf/ZTFwJLw3fxdGNwt8fds62hVvtGGsVru3VbLN9WrtPanY8WHTVxqC18Vp
pF78jglD8L0LV3gjDG4rc5A4Op4a/ND2IjjaEwixZzEeuzkxO+tw/zuGsEQM63jz
Kckudl+xi6pD5hgxV4a3qH07yLcdBdDXyUdbrHOpxfhvvOEAHaNLdXZhXjvtrrtd
XnsSEr9/3Be4cTcwhN1+nugiFit8xhonF/zYnIv3rZsouWpJnwUKcy4fEazCSRTz
6yWFh/iRSwq/5roe5KrD6rJFh4XoW3VDF4oVQKwZ8vaviYSl1kw8AJY/W7tErbrd
yneRuN0muehGfAMpX1z/jwcR05p6Hg==
=sE/v
-----END PGP SIGNATURE-----

--IA03tywDYuoVKXrw--

--===============3392423860032156658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============3392423860032156658==--
