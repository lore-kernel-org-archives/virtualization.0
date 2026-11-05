Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870112;
	b=Ya5mYbITLh3q9FeChO6u3wBmnuWGRtIZuR2g6rCJjMpINgkzLMYnVxJ8KyqItxam3pr0
	 R+8NJxfBsd2Dg+qaleOB41NCg7FGIgJFPYJXUTZEwe7YI2iBCE2j3CTNnB9xfxbeX3ypx
	 PhQTYkR3IN3W2Uc6fTQc/JyImIkydTjP8SBmV7Mzq6wE+HdbZnA/fC8YoTXdIqVAv3QV6
	 Er6A7w6CkqTHOSnuSdaem1p5vltK2ylu4SCnHply6I7USlNPUbAVEo1A/4Hh3dauOSVIB
	 rYSRIQE4/bBTGNo5J9tLqnzeaBpyks4iMqIHdtAAmrjS9AuV0Shrfre5rP0ukewwxVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870112;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=yuu8MRbvZ8Q99gVGDEWGPtvGQgcdEiYL3ohtAsA9Mfg=;
	b=ODCn32EhwT+GU3j+8REI+fdzFc6iS/R20iFN9O8Bk65JPARFRtrLEQqlj7jI1LjtJDHj
	 e62655WY+OlZA+Rfyoz3fkvQxyK+Z/7EGBtpiFOfiJdbbDB2BHNxqOVfgMAJdAKIU6lLz
	 snXMpg87ACC7yfK0mS7FtocV8St7VYInNVlSuyM9nk0B5C652G2cFkbtJXawHdH8TGbfl
	 N9kmgqEriEpnrYsE0E0tdP4UN47qvnn41xyjG3uFu+AAt9AIz7DSPGWO5F7b8c3/jvRD3
	 f/r+gzZrW0Qdn4aZC0vOKi/z5WOkyKCWmnSDeA8M1x8OF4Tkqyfj6ftCvgdbpW2EU6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFAS48f0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4078F606A32C;
	Thu,  5 Nov 2026 09:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bFAS48f0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B561F000C1;
	Thu,  5 Nov 2026 09:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793870111;
	bh=yuu8MRbvZ8Q99gVGDEWGPtvGQgcdEiYL3ohtAsA9Mfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bFAS48f0dLcspAEXkjkArw9f5g1sLZat7q01f+HKggEbmSs8nuly01Er89M9cFC+E
	 aJelUDSseJymE+2CsLiDv70w3W0f6o/p8FxgDHcsOPwgv1/JMp5POhaS6WYnvYb7K8
	 zUzkNI/hkDRyloSNnZbNr8XotLbG+h1F+jOL0Hkb0Avr9U7fYBRpfR9C0mcxiQBR3s
	 vMTD9J5x5SQw0X/qL4Os/hOqj2LHOa1MTSUUKJIb4NDus9wXA/2kpJ9BHnn9SLC4gw
	 1auncQlq+pWnfmu6Sf7Gd8Hf0QutCtTy+KqQdynzeHMD3cDRsYlcu6hbTs5fM0MRzR
	 2QGNBnbRrZdUQ==
Date: Thu, 5 Nov 2026 10:15:08 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	amd-gfx@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Inki Dae <inki.dae@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Peter Griffin <peter.griffin@linaro.org>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	linux-samsung-soc@vger.kernel.org, Alison Wang <alison.wang@nxp.com>, 
	Stefan Agner <stefan@agner.ch>, Huacai Chen <chenhuacai@kernel.org>, 
	Icenowy Zheng <zhengxingda@iscas.ac.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
	Mingcong Bai <jeffbai@aosc.io>, Qianhai Wu <wuqianhai@loongson.cn>, 
	Xi Ruoyao <xry111@xry111.site>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	linux-renesas-soc@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou <rgallaispou@gmail.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	linux-sunxi@lists.linux.dev, Jonathan Hunter <jonathanh@nvidia.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Thierry Reding <thierry.reding@kernel.org>, 
	linux-tegra@vger.kernel.org, Alexey Brodkin <abrodkin@synopsys.com>, 
	Alex Lanzano <lanzano.alex@gmail.com>, Chia-I Wu <olvaffe@gmail.com>, David Airlie <airlied@redhat.com>, 
	Dmitry Osipenko <dmitry.osipenko@collabora.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, virtualization@lists.linux.dev, 
	Haneen Mohammed <hamohammed.sa@gmail.com>, Louis Chauvet <louis.chauvet@bootlin.com>, 
	Melissa Wen <melissa.srw@gmail.com>, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-amlogic@lists.infradead.org, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	Danilo Krummrich <dakr@kernel.org>, Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH v3 00/37] drm/connector: Convert all drivers to
 atomic_create_state and remove reset
Message-ID: <auxJBtexUg6oHcs9@houat>
References: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="2zvnwa2sqytkzb4j"
Content-Disposition: inline
In-Reply-To: <20261030-drm-no-more-connector-reset-v3-0-30e71d92c327@kernel.org>


--2zvnwa2sqytkzb4j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/37] drm/connector: Convert all drivers to
 atomic_create_state and remove reset
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 04:13:30PM +0100, Maxime Ripard wrote:
> This is a follow-up to the plane and CRTC reset removal series, and
> part of a larger effort to remove the reset hook from all KMS objects.
>=20
> The connector reset hook is overloaded: it is called both at probe
> time to create the initial software state and during suspend/resume to
> reset hardware and software state. These two roles have different
> requirements, and the reset hook is not fallible, making error
> handling difficult for the initial state allocation path.
>=20
> While reset has the semantics to reset both the software and hardware
> state, the vast majority of implementations and all the helpers only
> reset the software state, making them equivalent to
> atomic_create_state in practice. The atomic_create_state hook makes
> this explicit: it only allocates and initializes a pristine state
> without any side effect, and returns the state pointer or an ERR_PTR
> on failure.
>=20
> This series converts all connector drivers tree-wide from the reset hook
> to atomic_create_state, then removes the reset hook from struct
> drm_connector_funcs entirely. The conversions were done using a
> combination of Coccinelle semantic patches, mechanical one-line
> replacements and manual adjustments.
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Applied to drm-misc-next

Maxime

--2zvnwa2sqytkzb4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCauxJHAAKCRAnX84Zoj2+
dpi6AYDFcyxVth1IfzYJl7Mk/wdU/UrwZChOoRG3vJ2c4jm3YXPwmaZCDBG4hPm/
E3dp1WQBf2Htv+GDvQkXS9avpT+uRjkpFRqowDqfaE0gXWHKwBFuo13bOFi12DLC
XPBNQCk6+w==
=O+mF
-----END PGP SIGNATURE-----

--2zvnwa2sqytkzb4j--
