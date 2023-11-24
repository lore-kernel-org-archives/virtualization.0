Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC41A278
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dTGLHLRk"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF58941D92
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:48:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EF58941D92
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dTGLHLRk
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ya03cFLp1Tr7
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:48:49 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25708418F7
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:48:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25708418F7
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 4E190B83008;
	Fri, 24 Nov 2023 10:48:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D963C433C8;
	Fri, 24 Nov 2023 10:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822927;
	bh=zysSZGvXrCbjCkNU5T+HVpgGk/opMa6u/fjLGWPdamA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTGLHLRkeWT7p2NtFKIaJPtU0xmJtdVXzOJTjqJ24XPyj6Az8c9s6/XRvnCB5fUr3
	 X6RVHahwnCGE5cIoe1l+aVNJMxGdDT8TXfWopsFBtpeEbRkM79Mh+JZUaboJwnnUi6
	 CTrlLz1+sRoQdzHiGAKBIQcUVnsTL0vDX28TOmfL5XRYWJDBfO1ZfyNsctD9iDVrUv
	 rHXj0jarstAfAHeLJV2KBmOLCDKs5vpqgtTUfb0gfJ+0HwRIYBWnAbIL+Fu+ZIcVXs
	 QBUDBU12X/eHss4YmdyUqhil//rSPydelKJ3UdcNj1ZwTpuFfuljf8USFKN+fOneoB
	 plgyAnkRdNZgQ==
Date: Fri, 24 Nov 2023 11:48:44 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel@collabora.com, 
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 09/26] drm/shmem-helper: Switch
 drm_gem_shmem_vmap/vunmap to use pin/unpin
Message-ID: <mvcfua6pzigfuaziynxmrzwkxpc3qphil7b6bbim43m63iajw7@zhizwn4pqgmi>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-10-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4lop2eds5vd4c6em"
Content-Disposition: inline
In-Reply-To: <20231029230205.93277-10-dmitry.osipenko@collabora.com>


--4lop2eds5vd4c6em
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 02:01:48AM +0300, Dmitry Osipenko wrote:
> The vmapped pages shall be pinned in memory and previously get/put_pages()
> were implicitly hard-pinning/unpinning the pages. This will no longer be
> the case with addition of memory shrinker because pages_use_count > 0 won=
't
> determine anymore whether pages are hard-pinned (they will be soft-pinned=
),
> while the new pages_pin_count will do the hard-pinning. Switch the
> vmap/vunmap() to use pin/unpin() functions in a preparation of addition
> of the memory shrinker support to drm-shmem.
>=20
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

The naming convention discussion aside, and once it's settled and fixed:
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--4lop2eds5vd4c6em
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWB/jAAKCRDj7w1vZxhR
xa3pAP9hrcOY656LtJ0jepRAz3Rd+bj52uTM2ZvzdbEGSMjhwQEAj7bIm9/CTTzB
VnDL++pXP/ULo/+hXA7txBt3hwH+Awk=
=aWnC
-----END PGP SIGNATURE-----

--4lop2eds5vd4c6em--
