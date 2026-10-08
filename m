Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com [165.173.182.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2263F1052
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444854; cv=pass; b=aRQPcNDJs+Y3VADy0Eh1L2sye/GNtLV9WNXBB1Z4McJRQ0wFSXLhKkfKWQPkNIrKsI/8Q41xq7J21y0jZajebQquH7wFLNDTRMfabyWgKBzT2413VddhF+udp/Yhf9BPajDGIa6dLaqZviZmEPRnE3uYyDJmCIfYuPR3bTpNLgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444854; c=relaxed/simple;
	bh=poW2hJOolFF/fNYHQtxj9zyIw1Fphk+8AKVZ10FxhXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXC2IBEs5E1ER7HJRLSu9mjSQnRrOHTBe6ZTnRAvziPCL/onadj1fBRoFb+5mr9Sv0d96DXxyBrAtzi0EfMeYXJJov2WKgfmVidvxLCfToyeRDHvRO69qRAjaxiXSCNT/jhshY1UDFg5RQgXlB68TT5Zjrdf0V01Fc0N8TyQy80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=VfMI44Yg; arc=pass smtp.client-ip=165.173.182.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="VfMI44Yg"
ARC-Seal: i=1; a=rsa-sha256; t=1791444796; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mTXh61NiLKraP85kc4UaugKyB1TEwN0hWZoFoa6N2LdPKFsF8F+1gyhuph+qjOCSOfEXwlHiykBA4oE+cdgOHN/eaCw24q5M7SZa6TP0b7VMAE4+e8Po9eZUUnQ2z3+SK9qJwpqCckEjYMtngq2P+voMJk1mSvbRVc4Bpsu8+4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791444796; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NT1FtZat0efjcSWI1PONK/4auTqiGUlP1uANOzVuEYM=; 
	b=IPfureZKksdFt+/6AE8DFadXNrbxuNSVKhggKc40JShVTWe1CL+3ARyFSsbMNTkDVXKumS2DMZuxq+gtHJRptw0Sn3XrZrraqoyDaNjuZm8zpIVfnkuzfMefBpagyTymCm8zWWEvvnlFge8L+CEiHkAtFQfXRVV5q9DqCMSWRGk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791444796;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=NT1FtZat0efjcSWI1PONK/4auTqiGUlP1uANOzVuEYM=;
	b=VfMI44Yg7//sz5ycJDAf9JSZtWZSa1pmQYKPNq22N9ciru+ejpI9JPpfntufUJpC
	C5r/FM+5sI59fLzbrExFMAzaor0PkEok3LmCTyyGxuTZdMoI9av/P/w56f5hQbqlV7Z
	wwQTdkhjyMuevhBOL0sqlvYuwINU5/A0WM5xiDR8=
Received: by smtp.zohomail.com with SMTPS id 1791444795885952.4681401339243;
	Thu, 8 Oct 2026 00:33:15 -0700 (PDT)
Message-ID: <8b0fbe1a-1410-42d7-8031-611795ae39d9@collabora.com>
Date: Thu, 8 Oct 2026 10:33:11 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
To: Val Packett <val@invisiblethingslab.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261006154913.2689067-2-val@invisiblethingslab.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20261006154913.2689067-2-val@invisiblethingslab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 10/6/26 18:42, Val Packett wrote:
> VIRTIO_GPU_F_BLOB_ALIGNMENT is designed for GPU rendering context types,
> however VIRTIO_GPU_CAPSET_CROSS_DOMAIN is not one of those. Resources
> created under cross-domain contexts are arbitrary shared system memory
> files, which includes unusual things like Wayland keymaps received
> from the host compositor. Do not enforce alignment requirements there.
> 
> Fixes: 47248e0d8264 ("drm/virtio: honor blob_alignment requirements")
> Signed-off-by: Val Packett <val@invisiblethingslab.com>
> ---
> 
> v2: also check has_virgl_3d to prevent dereferencing NULL vfpriv
> v1: https://lore.kernel.org/all/20261006004044.2242154-1-val@invisiblethingslab.com/
> 
> ~val
> 
> ---
>  drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> index 3ddd5481d6bc..4d5ae062834d 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
> @@ -551,7 +551,9 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>  	params->blob_flags = rc_blob->blob_flags;
>  	params->blob_hints = rc_blob->blob_hints;
>  
> -	if (vgdev->has_blob_alignment &&
> +	if (vgdev->has_blob_alignment && vgdev->has_virgl_3d &&
> +	    (vfpriv->context_init & VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=
> +	    VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
>  	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>  		return -EINVAL;
>  

What userspace has this problem and why it re-purposes virtio-gpu to act
as udmabuf for arbitrary data that never reaches host?

-- 
Best regards,
Dmitry
