Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDA2557C
	for <virtualization@lists.linux.dev>; Sun,  2 Feb 2025 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738516689; cv=pass; b=jXInOTgEKbtRcATHh4UxE5++3IY58tb05UaQ6anUrxucj1wzeV9yKotUMCmAnsg15FjFsZVU6ng9ieUyjKt35mRFlUumbO/oOYAKIwgZhHzlNvUH1vq6dlhp40r+ALcpPUtYpnLGrxA1ge2cO7pZzb1JbW7rKkdBNXX8zezF1DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738516689; c=relaxed/simple;
	bh=2p7amcAToW0LuxP263LUflNbfI1cAm4MZxJdDIQCaSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PkHYkrHnSxaXXaXqj/WFHUq/Nr4kXQM+H0O7tcHwpERlIXpRiW7ACxo7lROuTkSYYYUUuFr/Sdm9cX0YIKNFt4+m/KQCHjH3akbvewpaSRQStBuUfgjJkjt8MkbOS1lcsdn0Wd6c5rxbrse40yytnkPfYkYZmLf89CsNp8By7Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=c6fM4DhB; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="c6fM4DhB"
ARC-Seal: i=1; a=rsa-sha256; t=1738516678; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e4pxc2FLCEXzOdlFOI/jgu8M0yESAGJWJnBuSDpMM5SRAJzMcemVWDkh3AVO9UoaC9by7Nq/dO+VuUyptMwNkzXZgfOjhxodtoy45SkqO58RFSJhF7tDta/sHzIgRNJ7J14hIKqS8P3JdIytM0yV7o3PcrSm2v0kRP/ILTUf7Uc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1738516678; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X/vlOnLkPRBbjPH4Q6TlcEVhimS3kOUQzFNFBD7KWFM=; 
	b=JevBlmf8hsGHSiXyy/WvYuCh2oi0gmZlowiSIrS0vKTtEnQsdmles7q2V/8EGO+NuszGoZp945HUQVznZDv58PFt47TlHRFKaYArUylTJbXuhEGKkXHlrL3bVX45vuyBWGpazCex0tIvyUNVW+f9VPk18TRfWxPE3zxKyMEuWYY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1738516678;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=X/vlOnLkPRBbjPH4Q6TlcEVhimS3kOUQzFNFBD7KWFM=;
	b=c6fM4DhBYTp7quzY7c+hUZHSTLjrNYIjothC+X0cW993zAZ7ij+R+PVPbM2HflRh
	OYnH5rgunDcK6Zj6zdOmjjh8MIUcZQQmmbXmyYZzTf3hvT1Qty2zV3CHxwg+FEDZXkc
	yyMXL/79dDjTmum5C4JHpO1Yednleui4JauU5j6U=
Received: by mx.zohomail.com with SMTPS id 1738516672033583.4125691983685;
	Sun, 2 Feb 2025 09:17:52 -0800 (PST)
Message-ID: <75cf3adc-400e-44a6-b653-bee1f0cb43ec@collabora.com>
Date: Sun, 2 Feb 2025 20:17:47 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/virtio: Add drm_panic support
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, airlied@redhat.com,
 kraxel@redhat.com, gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 daniel@ffwll.ch, jfalempe@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250130090517.201356-1-ryasuoka@redhat.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250130090517.201356-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

On 1/30/25 12:05, Ryosuke Yasuoka wrote:
...
> +static int virtio_drm_get_scanout_buffer(struct drm_plane *plane,
> +					 struct drm_scanout_buffer *sb)
> +{
> +	struct virtio_gpu_object *bo;
> +
> +	if (!plane->state || !plane->state->fb || !plane->state->visible)
> +		return -ENODEV;
> +
> +	bo = gem_to_virtio_gpu_obj(plane->state->fb->obj[0]);
> +	if (virtio_gpu_is_vram(bo) || bo->base.base.import_attach)
> +		return -ENODEV;
> +
> +	/* try to vmap it if possible */
> +	if (!bo->base.vaddr) {
> +		int ret;
> +
> +		ret = drm_gem_shmem_vmap(&bo->base, &sb->map[0]);

drm_gem_shmem_vmap() requires BO resv to be locked, it also may invoke
drm_gem_shmem_get_pages() that sleeps. This function can't be used in
atomic context.

For the starter, let's reject !bo->base.vaddr BOs. Normally, shmem FB
BOs are always vmapped.

-- 
Best regards,
Dmitry
