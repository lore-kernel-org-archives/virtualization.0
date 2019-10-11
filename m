From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC PATCH 07/13] vsock: handle buffer_size sockopts in the core
Date: Fri, 11 Oct 2019 09:27:14 +0100
Message-ID: <20191011082714.GF12360__33623.8599427574$1570783001$gmane$org@stefanha-x1.localdomain>
References: <20190927112703.17745-1-sgarzare@redhat.com>
	<20190927112703.17745-8-sgarzare@redhat.com>
	<20191009123026.GH5747@stefanha-x1.localdomain>
	<20191010093254.aluys4hpsfcepb42@steredhat>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1237859863142675809=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191010093254.aluys4hpsfcepb42@steredhat>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-hyperv@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1237859863142675809==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y/WcH0a6A93yCHGr"
Content-Disposition: inline


--Y/WcH0a6A93yCHGr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 11:32:54AM +0200, Stefano Garzarella wrote:
> On Wed, Oct 09, 2019 at 01:30:26PM +0100, Stefan Hajnoczi wrote:
> > On Fri, Sep 27, 2019 at 01:26:57PM +0200, Stefano Garzarella wrote:
> > Another issue is that this patch drops the VIRTIO_VSOCK_MAX_BUF_SIZE
> > limit that used to be enforced by virtio_transport_set_buffer_size().
> > Now the limit is only applied at socket init time.  If the buffer size
> > is changed later then VIRTIO_VSOCK_MAX_BUF_SIZE can be exceeded.  If
> > that doesn't matter, why even bother with VIRTIO_VSOCK_MAX_BUF_SIZE
> > here?
> >=20
>=20
> The .notify_buffer_size() should avoid this issue, since it allows the
> transport to limit the buffer size requested after the initialization.
>=20
> But again the min set by the user can not be respected and in the
> previous implementation we forced it to VIRTIO_VSOCK_MAX_BUF_SIZE.
>=20
> Now we don't limit the min, but we guarantee only that vsk->buffer_size
> is lower than VIRTIO_VSOCK_MAX_BUF_SIZE.
>=20
> Can that be an acceptable compromise?

I think so.

Setting buffer sizes was never tested or used much by userspace
applications that I'm aware of.  We should probably include tests for
changing buffer sizes in the test suite.

Stefan

--Y/WcH0a6A93yCHGr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2gPOIACgkQnKSrs4Gr
c8hnpAf/bZLlTd0r+EaHBLvVtn6u74O2zVoTaaQWQnOazMVH14CZaHHOu1c41TX7
Q0re/sK84wgqeIYkL3oZytOaV0XcGl6gisahwdaj2B0vFbihvsFYpvh7RDO3HQ68
w1qOfDkUS9sTi3UYClbO7gHJfF/29ekUBFgoscFN8DwmqhMZ0BmjlQbI5G7Bx/vb
BsykLfJ1+i+pjEwaf7OnJWjg/D/XEcMgWuwt3TDu4weM4m7URnromXRaunFLetC5
rq7dPRsobckPtCGqpZlg9p9YRqCfyVJKOd/by5XeJVT/0aC5fi0t/gHLBSwCpL3R
6nAoSm1TARBDHhE/TRKT7m4aV/5H3Q==
=76ga
-----END PGP SIGNATURE-----

--Y/WcH0a6A93yCHGr--

--===============1237859863142675809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1237859863142675809==--
