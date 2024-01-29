Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A754F91
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jan 2024 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518879; cv=none; b=mBckGJw9odFRGSQNPnEnR8raxS8wCJoZz40iDRWgA3j1yRnxJipjE9ySLUMoRuF8r77M5yDBMB1LJWzQa7QiqIEjmMrM6WTZAl+gYpq3rv5pWd48gVxNaLQiyA2A+CZ+wj1D54jwZXLVp6eJqBcUkTb1AgjRKTXXFqcUtmeN8b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518879; c=relaxed/simple;
	bh=dbkjy2ApaTrI1tg/tWH38LMmQK4tCXE60dntBSxmttQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXFz0FpQ+weZTkbaTLpwuvsqwBEXSDoCHE3iGVaRW6iC9uifKmbVrvOG32pwhweGcoFiprOLFzF15xLg/LsGp1UFWJ54Th0UG9Ljwp8DGHI0jvlY4Z8H4oW+QqLCE3wwzVyDL1aC9uzar4qpceYnY4dLemOdjJLekzN4ApjQaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ztfJnuwv; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ztfJnuwv"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6023440AA3
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jan 2024 09:01:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6023440AA3
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ztfJnuwv
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wcz35EmfZIiB
	for <virtualization@lists.linux-foundation.org>;
	Mon, 29 Jan 2024 09:01:16 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6310940A74
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jan 2024 09:01:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6310940A74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706518874;
	bh=dbkjy2ApaTrI1tg/tWH38LMmQK4tCXE60dntBSxmttQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ztfJnuwvtxR+aEZAbUN8CqdwOda9dMtDLZ6GehCc/+Hb4ioDyu05MEAFy3XbJS6Xx
	 Wia8ikiEZhRQ0W41vTYLg+0yN3+8CcQ8wIbCGhCoJiUM5pw8GQ676E0UdbRAKrNW+L
	 5U/BNcePpl9wgSIXGLx/nhVkOu9D4O0INrpkBY1JWHjn3ujB0cLH05/8jwQ22kLgur
	 EPb0TWuVsd253crwfMq44kOnXEx+bTxdZb3IdZehMrt3UZOVvQT8J9WiJkvZosVCTK
	 zeaLjXK9U1Biw+z1njFMa0OZBkQGgmWUVk7jMaqMrAsSXVobkwVby0gct/b1qqO7Xm
	 OjIjyQX7gWmSA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5A4F137814A4;
	Mon, 29 Jan 2024 09:01:13 +0000 (UTC)
Date: Mon, 29 Jan 2024 10:01:12 +0100
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
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
Message-ID: <20240129100112.35c73f18@collabora.com>
In-Reply-To: <20240105184624.508603-23-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-23-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jan 2024 21:46:16 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> +/**
> + * drm_gem_shmem_swapin_locked() - Moves shmem GEM back to memory and enables
> + *                                 hardware access to the memory.
> + * @shmem: shmem GEM object
> + *
> + * This function moves shmem GEM back to memory if it was previously evicted
> + * by the memory shrinker. The GEM is ready to use on success.
> + *
> + * Returns:
> + * 0 on success or a negative error code on failure.
> + */
> +int drm_gem_shmem_swapin_locked(struct drm_gem_shmem_object *shmem)
> +{
> +	int err;
> +
> +	dma_resv_assert_held(shmem->base.resv);
> +
> +	if (!shmem->evicted)
> +		return 0;

Shouldn't we have a drm_gem_shmem_shrinker_update_lru_locked() even if
the object wasn't evicted, such that idle->busy transition moves the BO
to the list tail?

> +
> +	err = drm_gem_shmem_acquire_pages(shmem);
> +	if (err)
> +		return err;
> +
> +	shmem->evicted = false;
> +
> +	drm_gem_shmem_shrinker_update_lru_locked(shmem);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(drm_gem_shmem_swapin_locked);
> +
