Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D5C13ADA
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kb0noODf"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 990AC41BAD
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 990AC41BAD
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=kb0noODf
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AhoLB5VVWGl3
	for <virtualization@lists.linux-foundation.org>;
	Fri, 10 Nov 2023 10:17:44 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D772B41B3D
	for <virtualization@lists.linux-foundation.org>; Fri, 10 Nov 2023 10:17:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D772B41B3D
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 3764166073F9;
	Fri, 10 Nov 2023 10:17:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1699611462;
	bh=tC5sjf8JC5T2/oyASwUzhHg2NFb01acCe9klcjlI0uY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kb0noODfQiq2ijYfkjrIhVkonAhY7ZXSwkp3IleOgNqmbC6Xh7oxHzauYZTlp7K20
	 AOEOHxqbHMt82LZPUH1OObIXxPvulwwRsizpMT8zhQARfXv2HVB9iZujGcgrxxQyhx
	 alQ58eOSwm6eX8s9rqhQs24/QH2Lw3aZSh20IhqfGFzUqgwpYORJWYEBf9R4FdzvMt
	 Ari1bqARnv2H7VYbdEQom16EjWh4IvJWr/Wm4M2H85hrEIlOy/xu8rMLzRtyc+hLrl
	 0tK0FkPF4cWKJLKDetHSVWuP/8IEdhOq9POq24Xjd2JtsXHzYyYhdcrPtHD6IsX4+x
	 +coW0J+FRJuog==
Date: Fri, 10 Nov 2023 11:17:37 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price
 <steven.price@arm.com>, Emma Anholt <emma@anholt.net>, Melissa Wen
 <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 12/26] drm/shmem-helper: Make
 drm_gem_shmem_get_pages() public
Message-ID: <20231110111737.212f9454@collabora.com>
In-Reply-To: <20231029230205.93277-13-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-13-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Oct 2023 02:01:51 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> We're going to move away from having implicit get_pages() done by
> get_pages_sgt() to ease simplify refcnt handling. Drivers will manage

Nit: ease or simplify, not both.

> get/put_pages() by themselves. Expose the drm_gem_shmem_get_pages()
> in a public drm-shmem API.
> 
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 10 +++++++++-
>  include/drm/drm_gem_shmem_helper.h     |  1 +
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 24ff2b99e75b..ca6f422c0dfc 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -227,7 +227,14 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>  }
>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>  
> -static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> +/*
> + * drm_gem_shmem_get_pages - Increase use count on the backing pages for a shmem GEM object
> + * @shmem: shmem GEM object
> + *
> + * This function Increases the use count and allocates the backing pages if
> + * use-count equals to zero.
> + */
> +int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  {
>  	int ret;
>  
> @@ -240,6 +247,7 @@ static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages);
>  
>  static int drm_gem_shmem_pin_locked(struct drm_gem_shmem_object *shmem)
>  {
> diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
> index e7b3f4c02bf5..45cd293e10a4 100644
> --- a/include/drm/drm_gem_shmem_helper.h
> +++ b/include/drm/drm_gem_shmem_helper.h
> @@ -110,6 +110,7 @@ struct drm_gem_shmem_object {
>  struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
>  void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem);
>  
> +int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem);
>  int drm_gem_shmem_pin(struct drm_gem_shmem_object *shmem);
>  void drm_gem_shmem_unpin(struct drm_gem_shmem_object *shmem);

