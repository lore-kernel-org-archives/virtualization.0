Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3742AA3;
	Sun, 19 Jan 2025 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737303502; cv=none; b=KSV7vXp3TKQt8ToDm06smYOvCuhZFEW7p6HybESZZnzuIGEMva/Xg6IMDEK+k1D2zeQ4F+hnCfwHLOGjWn9YxsJRIwgx7Ht3u1FgzC89wko7QGZrdukDjNP7lTGPr0extifTp9qS+c2BjA/ucNcp2Azo+LmemzeoII1U57dF8w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737303502; c=relaxed/simple;
	bh=LAvJdSCTXPEjGK/+bn6A/GB+sDQ1V1X+W3Hx0D7sW94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kkzReOuzutteJlpicQlUcpF2DpQG0X+bUFE+5t0m3W0/S/vjA9ADOUHhSOio3WJyko9pQGhtlp+9/WQFbyJc6TVfK+M8lcXHFgpa+L790xhIZlFRSx7KqHJ/Kh4lfg8bSEOhSJS6vkUw7X+TGuhE2Dg1p5G0PVxuNRU2nCGoTxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2M6JWJg; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2M6JWJg"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e39779a268bso5497546276.1;
        Sun, 19 Jan 2025 08:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737303500; x=1737908300; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1sCj+Wpz58VXqoPHcsWC/oHPWAfJKC+x/UNR2bGR9uk=;
        b=b2M6JWJg0oOQQW/NOsNfVmGgpFId1x25pfb4K0UEaYDsWiX8mj6dD4cYS0oeCAjQmw
         G0+9qB6E47GOH9q5nhIXfdACFUdou01PeU37D6QXrcW5Vl3ic/WvYG6AWlIP9+GeHeGU
         FRh85hVAFzIUEE4qwi7g81XbFDWsyalFEg2R7rRaZseFCtpbjzOq/gmzFx5nPZPlC+5H
         GaxBemqWClePfweujF0P1OKYj/owwPA+jo8gQSKIV5excYvYBhlN33swa+W6iiwI009h
         ONVXCcZ6EnxQag2YWLMMwAPJIcITnYPSDdRg+QJu08xbg3lVg3jry8Jy8L6c90fSYwz6
         jwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737303500; x=1737908300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sCj+Wpz58VXqoPHcsWC/oHPWAfJKC+x/UNR2bGR9uk=;
        b=Xb0Op9Fc+5t4xUh3VUpzMfPA5EADLfbOroa9bM9DYrHDUxbXWdMSJcMRbuOLHbMKCD
         DwadJvSFHN3xa/wkR4qcY0iPNYSM/XkZScKqupVKLRPkovt0elnvR2MmuUpXaxWXrcUR
         TMds0Nce7kzYKxJiCbNEirHBYW8yg8l2oRe56Fw0IDb1r8PMJbH8+Tb/CDOYZu2xP5tJ
         7XOxGd2ZfGDpKfkSq/cFDwodM4kTlSBuZPVRZuuqZh/4NhQmqQCP2FNnDf3+FMG+lgPQ
         9U/9OQEtFJ2xCaMNKmRJREEP/jA47/8bWI5v286MkQEyOxvwZF/F+lmdqHV+GPo+lxus
         PIgg==
X-Forwarded-Encrypted: i=1; AJvYcCVFEa8+RhYZTptuQpPzyQVUcwMBQTbKSRcXA/IqXaogSvSxva0+rSx/HTglhcWAcYGrSpkfcyWVm5J/1HVbnTk=@lists.linux.dev, AJvYcCXoIFD/NQS7f4cINtAdoxHExc+i0mF30/DAV3dEBDXrgnarzScNymYRtq3UdhkWvscuQNxbqg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwE9lDJyyQo5Tvi8PAxTMlDsBX1UnrFFBXlcArZIyiUx4V4P2yc
	JvDhCPabdwya+sIdl4wlaDlwYL0cQy14EdBBfWvdT+SukInKfNgMUFBdOGfCatQViZxr0vSAW5A
	v6AVBX8En9ZEbFAQvAK/Hvi66oaE=
X-Gm-Gg: ASbGncv/qC6dsrECl/66/DS2KW/D/HwrJBKtC3z2+XVm/XCu40tIW4wupUGx8MCVR9B
	dugkWzL19KYAiPgnJN7Y7PlqrgmMccBEsq2RaD4CbX0RDtFVd4saH
X-Google-Smtp-Source: AGHT+IE3CgHFn2hIrsTZPvTj0bIi1h7yRhFooguMB6B3KtYJttaNGjo7EYiOR9ob4BBPgMCOTedrzRZrca/qC5r4WoQ=
X-Received: by 2002:a25:a187:0:b0:e57:167f:65ee with SMTP id
 3f1490d57ef6-e57a3c20f59mr10007404276.17.1737303500121; Sun, 19 Jan 2025
 08:18:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250109-virtgpu-gem-partial-map-v1-1-a914b48776bd@gmail.com> <2f51584c-0590-432b-a4db-7a2af99cde15@collabora.com>
In-Reply-To: <2f51584c-0590-432b-a4db-7a2af99cde15@collabora.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Sun, 19 Jan 2025 17:18:09 +0100
X-Gm-Features: AbW1kvakcvtitImS5grWZ5T9Zu8aGtCBBjHwTPnICAN4Pw5_vi91Hx-_1Z63IHs
Message-ID: <CAMT+MTT11xg-14KrcqUTx3DxF=1NnYZAMY8RoZFoTesc0zEiVA@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Support partial maps of GEM objects
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Jan 2025 at 12:50, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> >       ret = io_remap_pfn_range(vma, vma->vm_start,
> > -                              vram->vram_node.start >> PAGE_SHIFT,
> > +                              (vram->vram_node.start >> PAGE_SHIFT) + vma->vm_pgoff,
> >                                vm_size, vma->vm_page_prot);
> >       return ret;
> >  }
>
> The vma->vm_pgoff is fake in DRM, it's used for looking up DRM GEM
> object based on the vma->vm_pgoff value when mmap is invoked.

If my understanding is correct, vm_pgoff gets "unfaked" by
https://elixir.bootlin.com/linux/v6.12.6/source/drivers/gpu/drm/virtio/virtgpu_vram.c#L48

> vma->vm_pgoff should be treated as zero here. Hence we can map a part of
> GEM, but only from its start. See drm_gem_mmap().

I've had a "v0" (not on ml) of this patch that always treated vma->vm_pgoff as
zero. This broke when anything tried to mmap with a non-zero offset. Adding
vm_pgoff made it work correctly.

> Please correct vma->vm_pgoff in v2.

I need apps to be able to mmap with a non-zero offset for my usecase.
While the correct value may be something else other than what is in
the current patch, 0 is definitely incorrect for at least some workloads.
