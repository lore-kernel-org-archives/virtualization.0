From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] drm/core: Remove drm_dev_unref() and it's uses
Date: Thu, 26 Apr 2018 14:06:57 +0200
Message-ID: <20180426120657.GB11985__17318.1510800079$1524744314$gmane$org@ulmo>
References: <20180426102819.6985-1-vthakkar1994@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5289696078634333737=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180426102819.6985-1-vthakkar1994@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, alexandre.belloni@bootlin.com, heiko@sntech.de, airlied@linux.ie, gustavo@padovan.org, linus.walleij@linaro.org, joonas.lahtinen@linux.intel.com, stefan@agner.ch, hjc@rock-chips.com, eric@anholt.net, benjamin.gaignard@linaro.org, nouveau@lists.freedesktop.org, marex@denx.de, David1.Zhou@amd.com, linux-samsung-soc@vger.kernel.org, jy0922.shim@samsung.com, linux-rockchip@lists.infradead.org, tomi.valkeinen@ti.com, linux@armlinux.org.uk, krzk@kernel.org, jonathanh@nvidia.com, z.liuxinliang@hisilicon.com, maxime.ripard@bootlin.com, kong.kongxinwei@hisilicon.com, kgene@kernel.org, bskeggs@redhat.com, linux-arm-msm@vger.kernel.org, ck.hu@mediatek.com, airlied@redhat.com, virtualization@lists.linux-foundation.org, robdclark@gmail.com, linux-tegra@vger.kernel.org, puck.chen@hisilicon.com, intel-gfx@lists.freedesktop.org, maarten.lankhorst@li
List-Id: virtualization@lists.linuxfoundation.org


--===============5289696078634333737==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 03:58:19PM +0530, Vaishali Thakkar wrote:
> It's been a while since we introduced drm_dev{get/put} functions
> to replace reference/unreference in drm subsystem for the
> consistency purpose. So, with this patch, let's just replace
> all current use cases of drm_dev_unref() with drm_dev_put and remove
> the function itself.
>=20
> Coccinelle was used for mass-patching.
>=20
> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>

Yes, please.

Acked-by: Thierry Reding <treding@nvidia.com>

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlrhwOAACgkQ3SOs138+
s6EGqg/+JmUt+aqBk15/OXUKzwedusn2nurTmzPRqGoZEK54C7+31kYWTZJrfyn8
0YB/LnpBFLPsv0n2h5NAxTqdrk3XwnZnsh74EFMWWLT0xj05ieLMg/TfbQmwM8p/
keZqR/h1C6MpS5KXblD2tM7Gx7Nsp35RdhchLobvvXR2yUDxZO4afSKCehyeVnuv
57JIN5zMp+bQkuBMwjIEcCIqOxjQv5ISLzifNFdmHWLIJ3RO6W17MyrFYJzzQEqe
x2PLjnaaSashIqtezCM8y3K04QvclybTHT9uQ1SB7YmEj+R4U/ywLLWkDr346hNL
uVsx2P4Rgnj9y0hqaf5f37Z0peThUWU0vcNRcHCfNPrzJhZa1EQDXkeLItACiSNO
+qJFncLsqNYuV/Pq5gcPLaQe3C88Uh//dL3HKN3b/3OfmXmQbVVH7XKRWng2U0Fm
oTxpOG1l/GSEwkr/gjpuebN2VkxmITYLHjKc2QYZtD2j49gB0CPEsK/pPC5vmdso
/OmBBSlkvG6wqmCwW7FfXD+m+rtV5s3pFTL99/37lKE6jLqteXbZB1eXWjCktDSG
SA8grVw8+LiTmKyNAhg+B85bgGm7TVuym+DqkzUaMjkdQlISjMGCX6jMHtjila0+
skm7Hqo/qwKR+I3JOa0TMtFKmKero2xpRcSk8EFI2fnUy1UBwoo=
=nKx9
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

--===============5289696078634333737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
--===============5289696078634333737==--
