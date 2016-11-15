From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH] vhost/scsi: Remove unused but set variable
Date: Tue, 15 Nov 2016 14:40:15 +0000
Message-ID: <20161115144015.GA17672__5282.47245024449$1479220855$gmane$org@stefanha-x1.localdomain>
References: <20161111132710.25804-1-tklauser@distanz.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5133331331998713192=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20161111132710.25804-1-tklauser@distanz.ch>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Tobias Klauser <tklauser@distanz.ch>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============5133331331998713192==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 11, 2016 at 02:27:10PM +0100, Tobias Klauser wrote:
> Remove the unused but set variable se_tpg in vhost_scsi_nexus_cb() to
> fix the following GCC warning when building with 'W=3D1':
>=20
>   drivers/vhost/scsi.c:1752:26: warning: variable =E2=80=98se_tpg=E2=80=
=99 set but not used
>=20
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  drivers/vhost/scsi.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYKx5PAAoJEJykq7OBq3PImQcH/Aoa5H9+lNxRYg8r2gWqmK2q
tmr1SFEOp5+cvnlV3JtvMgdlxtX75JQBxlZmysV6e1SBGefZbfdv56HnKLXzQajS
6c2+78i5A9SLcXCh+PG+q4VcNwQ3TXHA6TZoq/VFEjgYAxV8GaXCpzcj6mSfg7G2
PWx0UxExCM/1lRJg15RSHtWtiD1yJ2BcYUz/gUvLZWw00FIrYoJo/em/weMSHrpl
eeXF+IvSIFcxbpMYPeqiMJW0q8PrHvbDD/RE8qqBOo1GtIIsB1A48j/KpTcx8Uv4
jfemoid0F1ognvqzt4rW7QpOVJ/YaaA4GS0nnRqAufT0Bd1LgJkALcWRA2nC6jI=
=9RfQ
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--

--===============5133331331998713192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5133331331998713192==--
