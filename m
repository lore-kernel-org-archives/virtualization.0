Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29C933E7
	for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447267; cv=none; b=Bou2E6MYxQEqmpSxoFPoIYnUIMzh1S4YN2c7zMAiesTYZuER9bvOMGzGBhBfBocf/KqSjlQJ4oOyTS0gXU+aptIU/jjp9pRtKWmdrbwywU3ku5MbrsTbCX5rWKh8L7X04H/yRpjFFmKodXD0LgaJxsgIKEt0wveS5WzybW6kcRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447267; c=relaxed/simple;
	bh=6zJiNj1L6vIB85ihK7K/8OX+7soTd/RpprQ5f+V4x74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFhuJqrjFbTUqyYNtUN2jtgaI1FHhHS9OgjRpb3FxjKgCVSQCCiB/XyjlPjYq9GViCjcvq5UxWL7EgW13Dah/2nsrt/XmuG+xa2hBqkripT4h08e/NBPik6rak4lltlTMIhBOq6blnkNxv3CzncG48DYVuO7DDG4MzUfQmpE6DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mU+VG7hQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mU+VG7hQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1765447263;
	bh=6zJiNj1L6vIB85ihK7K/8OX+7soTd/RpprQ5f+V4x74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mU+VG7hQmQxkswGmekpUaQ3s18Lyw37XYE4C60b/4rlkvBHbrAqSg7Uv3x8RJrx4m
	 UbVhKwZi/Ac5BxVFKMkNsmmO9ynNa6uIGZMqsCikaTIL9fSpdj/fdwEq6cS/cr0PMm
	 +ODZNAvnIwX4kbTohttJu6zXZGEepf//vYc4FZRVeCLF1v/7PJb6f5K0n736vMNZA3
	 mSppa60dvaxkhO+3Y63KoI5lXKMqP6Skcez8h3R2W++ZKFkk3qHc3YLqnnT3//K+QX
	 FO8XGVfcLA+oaYCwzFNa5iel/vLgXDc2tq7ZY6rf1jcpTxAIoiKNUrwl/fhucH07kb
	 VbObVxP9msb3A==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D2DE717E1544;
	Thu, 11 Dec 2025 11:01:02 +0100 (CET)
Date: Thu, 11 Dec 2025 11:00:56 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, ogabbay@kernel.org, mamin506@gmail.com,
 lizhi.hou@amd.com, maciej.falkowski@linux.intel.com,
 karol.wachowski@linux.intel.com, tomeu@tomeuvizoso.net,
 frank.binns@imgtec.com, matt.coster@imgtec.com, yuq825@gmail.com,
 robh@kernel.org, steven.price@arm.com, adrian.larumbe@collabora.com,
 liviu.dudau@arm.com, mwen@igalia.com, kraxel@redhat.com,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com, corbet@lwn.net, dri-devel@lists.freedesktop.org,
 lima@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 01/13] drm/gem-shmem: Fix typos in documentation
Message-ID: <20251211110056.26a53786@fedora>
In-Reply-To: <20251209140141.94407-2-tzimmermann@suse.de>
References: <20251209140141.94407-1-tzimmermann@suse.de>
	<20251209140141.94407-2-tzimmermann@suse.de>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Dec 2025 14:41:58 +0100
Thomas Zimmermann <tzimmermann@suse.de> wrote:

> Fix the compile-time warnings
> 
> Warning: drm_gem_shmem_helper.c:104 function parameter 'shmem' not described in 'drm_gem_shmem_init'
> Warning: drm_gem_shmem_helper.c:104 function parameter 'size' not described in 'drm_gem_shmem_init'
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index dc94a27710e5..f4e77f75ec81 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -96,7 +96,8 @@ static int __drm_gem_shmem_init(struct drm_device *dev, struct drm_gem_shmem_obj
>  /**
>   * drm_gem_shmem_init - Initialize an allocated object.
>   * @dev: DRM device
> - * @obj: The allocated shmem GEM object.
> + * @shmem: The allocated shmem GEM object.
> + * @size: Buffer size in bytes
>   *
>   * Returns:
>   * 0 on success, or a negative error code on failure.

