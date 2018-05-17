From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 01/24] drm/cirrus: Place GEM BOs in drm_framebuffer
Date: Thu, 17 May 2018 15:54:08 +0200
Message-ID: <20180517135408.GB26515__27306.5445981503$1526565139$gmane$org@ulmo>
References: <CAPj87rPKDwBK7qoOoY2zXoS6T02toATPRsk=39m_OBr=s1kXTw@mail.gmail.com>
	<20180330141138.28987-1-daniels@collabora.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4424983190254658322=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180330141138.28987-1-daniels@collabora.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Stone <daniels@collabora.com>
Cc: Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


--===============4424983190254658322==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 03:11:15PM +0100, Daniel Stone wrote:
> Since drm_framebuffer can now store GEM objects directly, place them
> there rather than in our own subclass. As this makes the framebuffer
> create_handle and destroy functions the same as the GEM framebuffer
> helper, we can reuse those.
>=20
> Signed-off-by: Daniel Stone <daniels@collabora.com>
> Cc: Dave Airlie <airlied@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/gpu/drm/cirrus/cirrus_drv.h   |  1 -
>  drivers/gpu/drm/cirrus/cirrus_fbdev.c |  8 ++++----
>  drivers/gpu/drm/cirrus/cirrus_main.c  | 25 ++++---------------------
>  drivers/gpu/drm/cirrus/cirrus_mode.c  |  4 ++--
>  4 files changed, 10 insertions(+), 28 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlr9iYAACgkQ3SOs138+
s6G9lg/9HlYwQfqYPoSyMu5Gh6/k/I/5jT4fqwTzPmv0OD5sP1Aors0THjJrNAWb
hnn4byKksVf9TyylwvQLc+FcaHd/oN3LDMA/20FNT6aFNeWYzdA97XrMwdqXZbb/
efcdbxbzryBKA23axTdwdosrBuL88C1LolUONvuXE67tMylYqZXa7OOvx66pPShB
cYS/znESJeVdZbk22NMmxNTKQertAmBNZijBTRIUVO+N5s37TPeQyMlHKffF6GNF
VOfmi5r0ehTvbjhUplRx7K4gDpMRRPk1h7kY44FCvs/okvv0+O0I9N4PAg38bky6
ff6mBNq6XgM/inXs2BDdCZmrREZLC7Ph7zRwbppdrmWJvsL1xSMNKNhJsDFgmKnq
RGokkgyquzG7d5h6Bb0f4Eqv//4UGJE+UcInWAl035yIzzhBBknBJfZhhmpeHDXj
K6RfjdV51pEVOPH56sLwfX3Npq/5DtH1d6BN+PB3jKVNyw71lMPqWrKO0JRcbKC9
FZfpzE4EUU1fTwvzjNNUuDkXDS6IU4dgjMO/K2t+yrlvi+y5EFnwchttFGSV9xxd
WIEfAk3K16CDVtxtzROjyXzIQAb/67naMua41lEojVa12nloEG+oyA0Y1Y7ze4GD
rqIfgiWTiGRiu5WN9djpzBpsi2J8KjuThdwAMpOo/1FfcEHT70E=
=OZYx
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--

--===============4424983190254658322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============4424983190254658322==--
