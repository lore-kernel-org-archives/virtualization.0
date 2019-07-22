From: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 0/5] vsock/virtio: optimizations to increase the
	throughput
Date: Mon, 22 Jul 2019 10:08:35 +0100
Message-ID: <20190722090835.GF24934__30635.2464411006$1563786539$gmane$org@stefanha-x1.localdomain>
References: <20190717113030.163499-1-sgarzare@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7180977776759916593=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190717113030.163499-1-sgarzare@redhat.com>
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
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>
List-Id: virtualization@lists.linuxfoundation.org


--===============7180977776759916593==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0rSojgWGcpz+ezC3"
Content-Disposition: inline


--0rSojgWGcpz+ezC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 01:30:25PM +0200, Stefano Garzarella wrote:
> This series tries to increase the throughput of virtio-vsock with slight
> changes.
> While I was testing the v2 of this series I discovered an huge use of mem=
ory,
> so I added patch 1 to mitigate this issue. I put it in this series in ord=
er
> to better track the performance trends.
>=20
> v4:
> - rebased all patches on current master (conflicts is Patch 4)
> - Patch 1: added Stefan's R-b
> - Patch 3: removed lock when buf_alloc is written [David];
>            moved this patch after "vsock/virtio: reduce credit update mes=
sages"
>            to make it clearer
> - Patch 4: vhost_exceeds_weight() is recently introduced, so I've solved =
some
>            conflicts

Stefano: Do you want to continue experimenting before we merge this
patch series?  The code looks functionally correct and the performance
increases, so I'm happy for it to be merged.

--0rSojgWGcpz+ezC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl01fRMACgkQnKSrs4Gr
c8jTLwgAkxfRp9mHdA/2v4fYnheHpBNa4CYfMPvJjwm3cV2wOPsoVqnPx6kFjNED
LJ54+h1tVFruOGHKnjsMYU4e9U9Aw2oLYV2FfAXJqeX6QzGM5Fp/pP7uaJt84htO
R/PUE2syWbEmd/O4BII7vdLSi6flpPHrnYE4qU585fU3C+zcSMa5J+cJKCQiE/ZD
mDwIQulVhh7pRJktNHPsi1YndADEm9ycqXU5UJYIMfoOilnT5Bri68hLS5fK410+
DMAONtomNK9EirCGpH8T6jNrLpJImwLFHsp6+VmAC6xcvDpQwR3WjIPlzkTlEb+X
DilvYlXPjDGvW6KgTTp+X70lkoIDnQ==
=2Juw
-----END PGP SIGNATURE-----

--0rSojgWGcpz+ezC3--

--===============7180977776759916593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7180977776759916593==--
