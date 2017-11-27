From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 00/13] remove_conflicting_framebuffers() cleanup
Date: Mon, 27 Nov 2017 11:33:57 +0100
Message-ID: <20171127103357.GA23154__6038.26870578832$1512195386$gmane$org@ulmo>
References: <cover.1511544782.git.mirq-linux@rere.qmqm.pl>
	<20171127103044.faakzch7ehlkc3or@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1987888848128913969=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171127103044.faakzch7ehlkc3or@phenom.ffwll.local>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Alex Deucher <alexander.deucher@amd.com>, Chen-Yu Tsai <wens@csie.org>, amd-gfx@lists.freedesktop.org, linux-tegra@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, virtualization@lists.linux-foundation.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org


--===============1987888848128913969==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 11:30:44AM +0100, Daniel Vetter wrote:
> On Fri, Nov 24, 2017 at 06:53:25PM +0100, Micha=C5=82 Miros=C5=82aw wrote:
> > This series cleans up duplicated code for replacing firmware FB
> > driver with proper DRI driver and adds handover support to
> > Tegra driver.
> >=20
> > The last patch is here because it uses new semantics of
> > remove_conflicting_framebuffers() from this series. This
> > can be considered independently, though.
>=20
> Except for that patches I've commented on:
>=20
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>=20
> Since this is for tegra and Thierry has drm-misc commit rights, it's
> probably simplest when Thierry pushes this all to drm-misc once driver
> maintainers had a chance to look at it.

Will do.

Thierry

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlob6hMACgkQ3SOs138+
s6HDmg//epA2Mwel33nzL0o4tjaoCbjOoIP37o+3k5ne5n3wP8EUVIK0fgzQnc0R
dBjm+5Cci+L6jPAbnJ/zztHIagdo+aznqZ1Ap1C4FAAX15F1yfPWa/WX8s55QHzW
xW1Eg82UHHWweLXfNja+/VYu3iA1FPUpRNZAEG0aKXBrZIyUdC2wIKkvIuv7otCS
LSYv8pqA+wYerBFWU2eMTIwTV+D8JGV1fCZ/qmDu8JAjmpg8IjdIAqX4WWA2gasw
sG0/5NQrAr4aESNQNbqcVZ1zKf1cTLKBnolWw/ZJAqfWUBq2sh7TLl7vUVEneiow
sRNxpU2xWy2dq9PcfV/LSmJlcUfoRDdtVQoimti3ljRv/qnUlXG27Elv4YXG1bOv
ZN0Ual4e2NP+nAas3K24R/0ZgpDa1PcLpsfR+bLAaluc7FBPbWq4A63u2etjLXQQ
mLRf4hqN1GfRStWS+jxEaf93ks7MRO/4w+1pvOba0o/Uj6Pf4WLQxdYr0li7EFuh
bV9daOKc6qvN0VBWUgNmkuIzT+MHORcg589MnepBI2iDpZ0fk38B4PdwwfBhsl7n
7F9lEI9YnOSXIE0uGBcxVFijDYiyJ+wjG7KKCCmJitavMRIQV9TgKUWXloBXcUDM
LsIJjp3qZSEBFD8o8nJwVUH9OcA47YiPFC1+54SDfAO4Qm8+zaI=
=udpx
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

--===============1987888848128913969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============1987888848128913969==--
