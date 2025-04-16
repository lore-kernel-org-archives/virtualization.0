Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48B326296
	for <virtualization@lists.linux.dev>; Wed, 16 Apr 2025 07:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788472; cv=pass; b=IhTshTeY+ebM6eLkc5t1xe2ow1jJLNTo7HNhartdsPEubYLNAk7cXfvfIG7GFBA0uWY+rCDaEbxxJpU1RLxTwP7gha8k6EzXw4Trpd+szNswDB/E+Z9YYXHDwSnGLo3wDI2xf1g0TtQkijHHShlbgMLvc/M1hsFGNfS8plLwPnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788472; c=relaxed/simple;
	bh=9cykmAjG+/L2DhiJdupnrvnvVuoog7pfOiPWGVsHOyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMV3c9ENQM8IbGfjpciQONfxgPyt6QeJ6vguCgAK/U6Uhu+xm0D8s85tAsWzFk9gWeoI/fQ+jqYBYRYIX5/hNZodTsUVlUpFeWKRUzKjr8ci3rpv3NPcXLMIVxwwT0kXSh5eR5G9xjL0NyL0ssTj4kUhGDPRi+7PwOdzov79+ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=S5c3Oq1f; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="S5c3Oq1f"
ARC-Seal: i=1; a=rsa-sha256; t=1744788460; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jzHMALNnVZclRFpYdMUQWgN9AdOD8nhv1KCiugwdDSW0do9aK/6QE0pcsIdaFAMRV7U0yUuL47+6kSVDSDpK654xnRh9fcNBXCRofUWUavRptEm5jvr01xK55N5qSR18SQY3vbIfpi9XHM96aZd7DuyEwdF8s85eCThfeqtDRKs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744788460; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OvO+rifxs7u3SlGDXC7e5wWDU550XI2j4P8n5PbX5ek=; 
	b=RKyUhP0czcrraxkwEQe2w5Dx8HCSRV2X65bg2b5OsH2n5HF0WVVWCYzHWE/sXlBjGh16W0d0PYqBAhX3ZjcWQV0yEKG77yIk9Phhvo2JL3uFYXT4nm2YS8nWq7i5PSCQIPGIC5F1tcbjwBT+hvBqlKutXHyRwoEqZrmNIAo+mIM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744788460;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OvO+rifxs7u3SlGDXC7e5wWDU550XI2j4P8n5PbX5ek=;
	b=S5c3Oq1f4V5bkHMtvcSz1lpuJZ/J/FWuVax2n/3Almv6yGHQV2YnymOAgH7to8yD
	ZQG2fCPreCkhTtzKw3tKZib0rE6nK9NlutzOiU7Ln07WCjE1eH0i50PsZOl71LAWCxc
	5d7NF0xrrkmwwnZB9Mq5Fbglb9uS8f+OYHCPdMpc=
Received: by mx.zohomail.com with SMTPS id 1744788457648268.5754601252454;
	Wed, 16 Apr 2025 00:27:37 -0700 (PDT)
Message-ID: <b74f2219-9e5d-4736-9a70-194cc4e50b96@collabora.com>
Date: Wed, 16 Apr 2025 10:27:34 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] drm/virtio: Avoid struct drm_gem_object.import_attach
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
References: <20250414131507.566072-1-tzimmermann@suse.de>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20250414131507.566072-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/14/25 16:11, Thomas Zimmermann wrote:
> Avoid the use of struct drm_gem_object.import_attach to get the
> object's dma-buf or test for an imported buffer. The import_attach
> field in struct drm_gem_object is an artifact of the import process,
> but should not be used otherwise.
> 
> The helper drm_gem_is_imported() tests if a GEM object's buffer
> has been imported into the driver. The corresponding dma-buf is
> referenced by the object itself. Both cases avoid import_attach.
> 
> Thomas Zimmermann (2):
>   drm/virtio: Test for imported buffers with drm_gem_is_imported()
>   drm/virtio: Use dma_buf from GEM object instance
> 
>  drivers/gpu/drm/virtio/virtgpu_plane.c | 8 ++++----
>  drivers/gpu/drm/virtio/virtgpu_prime.c | 7 +++----
>  2 files changed, 7 insertions(+), 8 deletions(-)
> 

Applied to misc-next, thanks!

-- 
Best regards,
Dmitry
