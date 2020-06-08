From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v5 12/13] vhost/vsock: switch to the buf API
Date: Mon, 8 Jun 2020 10:57:16 +0100
Message-ID: <20200608095716.GE83191@stefanha-x1.localdomain>
References: <20200607141057.704085-1-mst@redhat.com>
 <20200607141057.704085-13-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4478659862676583647=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200607141057.704085-13-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, eperezma@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============4478659862676583647==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GxcwvYAGnODwn7V8"
Content-Disposition: inline


--GxcwvYAGnODwn7V8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2020 at 10:11:49AM -0400, Michael S. Tsirkin wrote:
> A straight-forward conversion.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/vsock.c | 30 ++++++++++++++++++------------
>  1 file changed, 18 insertions(+), 12 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--GxcwvYAGnODwn7V8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7eC3wACgkQnKSrs4Gr
c8jwtAf+JgEio09QmwBTCC4RhAS9zTZxiNWAHCdPtESgu4E+VLcxHjEEpkF7w+Cm
pQiZHcW0mG7Y2PKAg8VkP2GvXH0gbiNSQ/7ZTOFsExePWay5vLQdYg/u21hleZae
zQ4oI905vhOEb6L92iAvzuFr0hTpIwZ1kvc+1bUAHQwLIycKalMkym1jgoyUaD2/
eFPwvzPIPZfEuorb3mmhEq98yKTDxH5U5glFjBaZWD3E3Mg9RZN3g0Iqps80abIS
Z47zkqMzxw8heuyjScbbz26hhKj6ziP1mcs3crmThZk3H1EpPqaVIcNHUTs6AE0P
pRlUbV4l4np3xvL9u4DDOb2FGjgDlA==
=6gku
-----END PGP SIGNATURE-----

--GxcwvYAGnODwn7V8--

--===============4478659862676583647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4478659862676583647==--
