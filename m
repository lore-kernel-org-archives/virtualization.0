From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v5 11/13] vhost/scsi: switch to buf APIs
Date: Mon, 8 Jun 2020 10:57:12 +0100
Message-ID: <20200608095712.GD83191@stefanha-x1.localdomain>
References: <20200607141057.704085-1-mst@redhat.com>
 <20200607141057.704085-12-mst@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7937025780558049637=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200607141057.704085-12-mst@redhat.com>
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, eperezma@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============7937025780558049637==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Content-Disposition: inline


--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 07, 2020 at 10:11:46AM -0400, Michael S. Tsirkin wrote:
> Switch to buf APIs. Doing this exposes a spec violation in vhost scsi:
> all used bufs are marked with length 0.
> Fix that is left for another day.
>=20
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/vhost/scsi.c | 73 ++++++++++++++++++++++++++------------------
>  1 file changed, 44 insertions(+), 29 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7eC3gACgkQnKSrs4Gr
c8jC3Af+LPXirMBmRcs7FQbxFSgLfLDjpnub+fLUo+dN0CH5ElfkoqGW6HJ8d7er
qlDKL+3ZPm1i0cRsqnN+xg6qZ2UKbC83RHrZ1z12NzkrluuFD4knW3/gjyyQPXvw
N8QQvguhNCO6DJ5yj8njHLuaAi44jkigVA5kFA5e8EFjsGHSQhoamQH23M/89rey
FOot5VmlwGfXtL216ALh6oIoLPuVvrQlQA6iVZGxXP4hgv+z7mJXzLmfJ7l2UnkB
OrdaqlvJcy4ZpKXZtVl5kfLbvRMuuv6a1OeLKW/FU2pJKxa5gn8WGdek5o5XrmpP
Uf/M6MvauUK5c9F369S2pWsEv+mqag==
=6nV4
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--

--===============7937025780558049637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============7937025780558049637==--
