Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02AC192B9F
	for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725972580; cv=none; b=XBwwPVm64W6Ruo1dSxIMBk+CP8in+RTM11Yq/WKKnbZM1783lx++Y86gl5N0f2JmK5KBupc4U1xh0DRfL9VRGd+v0mebjZvW5PcOPPTn2YbgfK1ufg7c7n01gimsONhSAKGQuwYg2hokXzeGL0Qs1dd5rkE8vLbdbt2snikggTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725972580; c=relaxed/simple;
	bh=mgfcX2uQtqJW+4vxPdt0csDUudu1Fc2mT+vh+uOSnds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RDy/Iu0CW5sA7UTm4DsDS6vfQ4tgbI2w6NFI2SjNffoPOtTcXBKige2iduVJAbRnzWVzNukh09AaVVrWnOr4C+aZCjy5397D3/nT3hbaPoM7fXfe+KBS0/1P0DYELL3+79cIICd01W9mC3+2ZKawjJ0httd0zjAJuDQXOzj14to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZUEi1fxA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZUEi1fxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725972577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6nd62AWkPIK5gIXPiUm1JLX0Wy6uPdrxO6zecHjvld0=;
	b=ZUEi1fxAStn1fwPuDmBH6pWhIqphxwJZbSMylVl025zK5/UxkVAksNzElR/Ef7NX44ld3Q
	JHYJN9hVaYIhwId5TJZXS9CH68yvmyvgzLO9UTS2Loqlzm65v13nmcenVmdUOOjtLaSFEm
	neaCZYg/rvDpxtYVIHHW/zIHK7m5RPE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-5Q6OAfJFO2Wjq3HMbmM4iQ-1; Tue, 10 Sep 2024 08:49:36 -0400
X-MC-Unique: 5Q6OAfJFO2Wjq3HMbmM4iQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-374b981dd62so393385f8f.3
        for <virtualization@lists.linux.dev>; Tue, 10 Sep 2024 05:49:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725972575; x=1726577375;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nd62AWkPIK5gIXPiUm1JLX0Wy6uPdrxO6zecHjvld0=;
        b=BLGl+lXZyG+pXVCrqqV6pQfAPDAAV9xfIdxVECVvOC15Tw3YhGDCDar2qmUaTsj/p5
         fdsKD7gk/3c/KMHjODS79DEvzPLc7FlMe7l97rHeMU/eTkEUhgQz0U/jSOvZqVgyTXMP
         NT2KXvnQ5clslSu5sAu2n8bmZRY+1OcuqKTFk14Awrb3IO2CdPMv7jM0XorAmav2eFKh
         yoOGwaQvrlaPTR2Gy6Txc+0tbVEkCY8TESUrhRvmwjZsxf8dZngulIOMVDmsYWnHx8n4
         84LnwrL+MXbplx6mEJEosBbj+p7FKHj3SewLG/zUlMjxZJKpOdElz22t9gcZUt2JEwuF
         9pZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHUpZDYuR7RiExprySI/YTHw8S0WYaUnSDYMWOLO+iS65LL52nHuIyLPQ53pwYN9hkKpOXi5NIusJ7KBg8fg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdXw+8odO0rcCqu2rm3PL/Tsj5H1uCQRGp0qIsfXvI/U3NS0Cj
	eWcuzHQqO6OY6OyQi4lLduEmSY1oxRQXJUqvO2ZeGscANpGCTVOU4L7ClY/niCrZFRsvbp4rWT/
	QOQABOHUUkprMPodDHzhFa3igNDHmQgRoTpT5QxKc/d9ngF9PvYhKIUR8cOy/QVX8
X-Received: by 2002:adf:f744:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-37889682e0fmr9248510f8f.46.1725972575096;
        Tue, 10 Sep 2024 05:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn1VOKKhA4WLT+ujhN0UWmvu2oY3V+R+ECDiuNE+P04fsSNUprDeK4EvgDC0oQ+l+wSJkUiA==
X-Received: by 2002:adf:f744:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-37889682e0fmr9248486f8f.46.1725972574606;
        Tue, 10 Sep 2024 05:49:34 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb8afc9sm112219705e9.44.2024.09.10.05.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 05:49:34 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: pbonzini@redhat.com, seanjc@google.com, kvm@vger.kernel.org, Yan Zhao
 <yan.y.zhao@intel.com>, Kevin Tian <kevin.tian@intel.com>,
 kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bochs: use devm_ioremap_wc() to map framebuffer
In-Reply-To: <20240909131643.28915-1-yan.y.zhao@intel.com>
References: <20240909131643.28915-1-yan.y.zhao@intel.com>
Date: Tue, 10 Sep 2024 14:49:33 +0200
Message-ID: <87a5gf4qsi.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Yan Zhao <yan.y.zhao@intel.com> writes:

> Opt for devm_ioremap_wc() over devm_ioremap() when mapping the framebuffer.
>
> Using devm_ioremap() results in the VA being mapped with PAT=UC-, which
> considerably slows down drm_fb_memcpy(). In contrast, devm_ioremap_wc()
> maps the VA with PAT set to WC, leading to better performance on platforms
> where access to UC memory is much slower than WC memory.
>
> Here's the performance data measured in a guest on the physical machine
> "Sapphire Rapids XCC".
> With host KVM honors guest PAT memory types, the effective memory type
> for this framebuffer range is
> - WC when devm_ioremap_wc() is used
> - UC- when devm_ioremap() is used.
>
> The data presented is an average from 10 execution runs.
>
> Cycles: Avg cycles of executed bochs_primary_plane_helper_atomic_update()
>         from VM boot to GDM show up
> Cnt:    Avg cnt of executed bochs_primary_plane_helper_atomic_update()
>         from VM boot to GDM show up
> T:      Avg time of each bochs_primary_plane_helper_atomic_update().
>
>  -------------------------------------------------
> |            | devm_ioremap() | devm_ioremap_wc() |
> |------------|----------------|-------------------|
> |  Cycles    |    211.545M    |   0.157M          |
> |------------|----------------|-------------------|
> |  Cnt       |     142        |   1917            |
> |------------|----------------|-------------------|
> |  T         |    0.1748s     |   0.0004s         |
>  -------------------------------------------------
>
> Note:
> Following the rebase to [3], the previously reported GDM failure on the
> VGA device [1] can no longer be reproduced, thanks to the memory management
> improvements made in [2]. Despite this, I have proceeded to submit this
> patch because of the noticeable performance improvements it provides.
>
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>

FWIW, this patch (alone) resolves the observed issue, thanks!

Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

I, however, share Paolo's concern around existing VMs which KVM's change
is effectively breaking.

> Closes: https://lore.kernel.org/all/87jzfutmfc.fsf@redhat.com/#t
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> Link: https://lore.kernel.org/all/87jzfutmfc.fsf@redhat.com/#t [1]
> Link: https://patchwork.freedesktop.org/series/138086 [2]
> Link: https://gitlab.freedesktop.org/drm/misc/kernel/-/tree/drm-misc-next [3]
> ---
> v2:
> - Rebased to the latest drm-misc-next branch. [2]
> - Updated patch log to match the base code.
>
> v1: https://lore.kernel.org/all/20240909051529.26776-1-yan.y.zhao@intel.com
> ---
>  drivers/gpu/drm/tiny/bochs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 69c5f65e9853..9055b1dd66df 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -268,7 +268,7 @@ static int bochs_hw_init(struct bochs_device *bochs)
>  	if (!devm_request_mem_region(&pdev->dev, addr, size, "bochs-drm"))
>  		DRM_WARN("Cannot request framebuffer, boot fb still active?\n");
>  
> -	bochs->fb_map = devm_ioremap(&pdev->dev, addr, size);
> +	bochs->fb_map = devm_ioremap_wc(&pdev->dev, addr, size);
>  	if (bochs->fb_map == NULL) {
>  		DRM_ERROR("Cannot map framebuffer\n");
>  		return -ENOMEM;

-- 
Vitaly

