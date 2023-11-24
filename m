Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6428199B3
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1APQeHx"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 08C4A614EB
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:48:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 08C4A614EB
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=T1APQeHx
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jOZ5_3ZiM3a2
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:48:01 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 457EC614E0
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:48:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 457EC614E0
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5D29F62133;
	Fri, 24 Nov 2023 10:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34B5C433C8;
	Fri, 24 Nov 2023 10:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822880;
	bh=LSo0ZQQHC/IsC9xQJ/PVzcvZKxNomMboWXtQ7MmvXeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1APQeHx8vfRJIlPG7GCFaf26wYHmGOanpVv73ATBPXRTYdco3PosME2XpLWX4mus
	 WG3RqeBA0h6xhaUz1FF2VGA+Dd4KqTDlshUwOPsGD2Ru7FLvxwT4rhFnFrZOUQLuk9
	 x706MGYMsRvtF40qvFhJcUDZ8OfNy9HHbXSIj3UV/gwXqazNAwmqH286hIBptKtgn+
	 HOC2w3FqnnzPMwpm/iJBbt5vh95z1ALZUExRdQC8Z4YzoEfFH1xhDVhWErhMniP21X
	 cS/HZ/3fSdc3NK4RW1w2jVK/qGxidNoKfAILkBTVjiCw/bbqMSZHcyYLvFTZ2qmxqi
	 baEGyJBJAjMeQ==
Date: Fri, 24 Nov 2023 11:47:57 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel@collabora.com, 
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 08/26] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Message-ID: <zdgmrdfugffy6ogvws3yatcebigylkalfiip2ch3cwgvjs5r65@hgakb26hmhsb>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-9-dmitry.osipenko@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i4hob2pzcy5qf62n"
Content-Disposition: inline
In-Reply-To: <20231029230205.93277-9-dmitry.osipenko@collabora.com>


--i4hob2pzcy5qf62n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 02:01:47AM +0300, Dmitry Osipenko wrote:
> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservati=
on
> lock if pages_use_count is non-zero, leveraging from atomicity of the
> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
>=20
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index 6e02643ed87e..41b749bedb11 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_s=
hmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
> =20
> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> +{
> +	int ret;
> +
> +	if (refcount_inc_not_zero(&shmem->pages_use_count))
> +		return 0;
> +
> +	dma_resv_lock(shmem->base.resv, NULL);
> +	ret =3D drm_gem_shmem_get_pages_locked(shmem);
> +	dma_resv_unlock(shmem->base.resv);
> +
> +	return ret;
> +}
> +

Wait, so the locked suffix is to indicate that we need to take the lock
before we call it? I think that's the opposite to all(?) the naming
convention we have

Especially since the function name doesn't describe what the function
does anymore, but the context in which to call it. I'm sure if I was to
use it, I would have gotten it wrong, or at the very least been very
confused about it.

Maxime

--i4hob2pzcy5qf62n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWB/XQAKCRDj7w1vZxhR
xTOjAP4kvIUjsI4/bd6ZVYnMdk1Vochj+P/U8iB648tf1v7cIgEAnBJRt077kVOy
hzkjMQ1cHLWctzPgwzfxAIRy1scsxQs=
=GYdZ
-----END PGP SIGNATURE-----

--i4hob2pzcy5qf62n--
