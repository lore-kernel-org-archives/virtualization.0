From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH 11/13] vsock: add 'transport_hg' to handle g2h\h2g
	transports
Date: Wed, 9 Oct 2019 14:16:43 +0100
Message-ID: <20191009131643.GL5747__31875.6359441736$1570627019$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-12-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2003499781538441833=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190927112703.17745-12-sgarzare@redhat.com>
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


--===============2003499781538441833==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1hKfHPzOXWu1rh0v"
Content-Disposition: inline


--1hKfHPzOXWu1rh0v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 27, 2019 at 01:27:01PM +0200, Stefano Garzarella wrote:
> VMCI transport provides both g2h and h2g behaviors in a single
> transport.
> We are able to set (or not) the g2h behavior, detecting if we
> are in a VMware guest (or not), but the h2g feature is always set.
> This prevents to load other h2g transports while we are in a
> VMware guest.

In the vhost_vsock.ko case we only register the h2g transport when
userspace has loaded the module (by opening /dev/vhost-vsock).

VMCI has something kind of similar: /dev/vmci and the
vmci_host_active_users counter.  Maybe we can use this instead of
introducing the transport_hg concept?

--1hKfHPzOXWu1rh0v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2d3bsACgkQnKSrs4Gr
c8iGmQf8CrTUBmiSd3MH3EamjJ8bZk3tA9Ej+1ywL//u+F4Qx3lKOoX+rWnMK5O0
pkoMAUGpvkKpC23xoV8gFfS9jtRax71aGCjFHnCDj6AoIOu/EwdqWTN28DjF0pF/
v2D3y2FJtItZeyB2JxnV/ouq9wnglcYDXuvVzwlIGvQi7cV2pj4TyVUzo55Qbtqb
+pbmGCQ845YsfBrmNGA28L7r7OiGp0XCXkrNiTpmgBvQpkUiYg5sKxbWZQj13dKU
UMBAQV8O4rNjJuEW/9oGehzTzq7JqwiA0TPRGlqkdfovgqA3m0dvSAVbZm/D74al
Y7NuoOX5k8zZlatP7hk+KQoph/MKrg==
=Wk8M
-----END PGP SIGNATURE-----

--1hKfHPzOXWu1rh0v--

--===============2003499781538441833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============2003499781538441833==--
