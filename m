From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/5] VSOCK: support fill data to mergeable rx buffer
	in host
Date: Thu, 13 Dec 2018 15:46:16 +0000
Message-ID: <20181213154616.GM23318__30347.2854699523$1544715881$gmane$org@stefanha-x1.localdomain>
References: <5C10D4FB.6070009@huawei.com>
	<20181212.110944.1077302806391053539.davem@davemloft.net>
	<5C11CDF4.4040405@huawei.com>
	<20181212.215905.1657023590815103551.davem@davemloft.net>
	<5C120D69.10201@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9068602472177792121=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5C120D69.10201@huawei.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============9068602472177792121==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EE8jvUPYYQjJtG7J"
Content-Disposition: inline


--EE8jvUPYYQjJtG7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 03:42:33PM +0800, jiangyiwen wrote:
> On 2018/12/13 13:59, David Miller wrote:
> > From: jiangyiwen <jiangyiwen@huawei.com>
> > Date: Thu, 13 Dec 2018 11:11:48 +0800
> >=20
> >> I hope Host can fill fewer bytes into rx virtqueue, so
> >> I keep structure virtio_vsock_mrg_rxbuf_hdr one byte
> >> alignment.
> >=20
> > The question is if this actully matters.
> >=20
> > Do you know?
> >=20
> > If the obejct this is embeeded inside of is at least 2 byte aligned,
> > you are marking it packed for nothing.
> >=20
> > There are only %100 downsides to using the packed attribute.
> >=20
> > Simply define your datastructures properly, with fixed sized types,
> > and all padding defined explicitly.
> >=20
> > .
> >=20
>=20
> Hi David,
>=20
> Thanks a lot, I need to send number buffers from Host to Guest, so I think
> we need to keep the structure size the same between host and guest.
> But after your reminder, I feel my code may exist a serious problem,
> that in mergeable mode, I send the total structure virtio_vsock_pkt
> from Host to Guest, however, this structure size may be different
> under different compilers (Guest and Host are different). Then, Guest
> may parse the wrong packet length.
>=20
> David, I want to ask if there is such a problem?
>=20
> In addition, why I send total virtio_vsock_pkt structure from Host to Gue=
st?
> - In order to avoid to allocate virtio_vsock_pkt memory when receiving
>   packets, in case of insufficient memory, it may have some advantages, a=
nd
>   we may keep consistent with old version.

Yes, virtio_vsock_pkt is internal driver state and should not be part of
the host<->guest interface (also for security reasons it's not good to
expose internal state structs across the interface).

Stefan

--EE8jvUPYYQjJtG7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcEn7IAAoJEJykq7OBq3PIDswH/iNEtTreNge1H6Z5Q7lpBG1n
T/FWMkzYUCPNRi8ZRhAkkLUttsRUs2gDdeyNIBce9pKwxcFzxQAnRbhcxF384v5V
q2BbuMT+Lr/7rZmgtwrNV2L9vwKGu5ohuddmPF/c8La2tIYkQ+Gdl/7V+gPZ55LR
ArUOcgK3czSs0YUftno9XN0sL9aqZ0rz5es2x5WMRGpI0LXFl/vyP5Ig5GDkA1Ou
Gj4uaMJUiYN3mU7P9j0H45kCGQBCJH6aelcrAIS6d6xuj2uHF5b2vRFOZhCFwXYg
mMWG6Uw3sGZuRAFwiFnzs1uOfzwahMimzG7pJGl9w+NUUbzN+Dxmd/t1ZEUQCY8=
=K2zb
-----END PGP SIGNATURE-----

--EE8jvUPYYQjJtG7J--

--===============9068602472177792121==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============9068602472177792121==--
