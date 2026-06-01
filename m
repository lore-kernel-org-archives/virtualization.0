Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106D3955F5
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309268; cv=none; b=cCPtHl0v1Y0msLIchyQ1mKNkHpSlfgdAtUomi0UwypiVL3j+UWZYPukLLMK/7azPclAXI75IwZqgKN53uvyTIOGx+GpTMs9n/GZuwaTsGdzDKbLzTVqpPV1u2khXqMNSFBNsbgKe+3aLQLrJXdW0e1JfGJZatlA5KO4ZQbi6PjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309268; c=relaxed/simple;
	bh=326g4EpO+TBbZXT0k/fdB+P1jFfmFRBJEf+jFr0a2Gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YShKrKJqTC+IeSs7qG7RaY292OVEQqnKmiQ4xiKTY3/EZRmwFx2lZBATVDVsWnRc2WdLPBSoE1bQ4h6Fronc7A14v5HpD7QtC2g9axF3HWD7285q43cxqFE+i7r8IF1h2O0CPJyJaTJNrRJL7gtpbN0G1q4VB9hcQDy1Jr5dv+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KAtM/UDx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAtM/UDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PtraVy72eIuUfdejQSU7WTEFINXM3tMuzrGKzIN4pEs=;
	b=KAtM/UDxNWrpIwUx+YuOR7YiLLxd24/sqjoW6kczVrgbDpr2+smz+HDNCIBHwQgSz5u47t
	MT69a1FQJxoT7BxJVHb31QETHze1iNMUDw/Yqep5eohEBEbDadu4HGtYOU8oIGxich/ri+
	SqL9wBJVcDHLcO6zpCfijGvp/lmEufo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-tgDUX5BjPaiUBC5nafa9og-1; Mon, 01 Jun 2026 06:21:00 -0400
X-MC-Unique: tgDUX5BjPaiUBC5nafa9og-1
X-Mimecast-MFC-AGG-ID: tgDUX5BjPaiUBC5nafa9og_1780309259
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a762e646so11692705e9.0
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309259; x=1780914059;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtraVy72eIuUfdejQSU7WTEFINXM3tMuzrGKzIN4pEs=;
        b=JUfWxupaG9ZXO6omCr42wb8HPgZfbYERz+mhEy9YNXL6Ar4uOl6jMMMqvdN3bsAeXZ
         k6Z8E/IV+AznOflPSbV/3jESCOOoZlKPV7+E9IcsOoScnnxQlmQOBDJnj5G4/MoSprjl
         XQ7DOUS3EsUeq4Npp30C3VFeUwta1Btxj6uvO07ccuBrnbhr9cznppxWpzwV9jByPzBQ
         iKUut/Gx6W41XgPkSeo25sD1X+sD6iv9s3HurDBUyRtCTOzfbjooKEP3x3F5yiLofGto
         Fe6v4GR14FBLKrAArw/+I7VdbtJsCw9rfxyi7p5ygdn4lLQ5GqtcnqictSv1Rytc5XlG
         fVjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qJcipakjcOK31htrv/pWFoVUKbrUzl7pndJ0RJYoTfzrkKh4rs8ayFTGY0WJBtwxVPxGqhpt30LwOiHvh5A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy7fDy4Hw4fw0iLibhVgN0lg6BoiT8bjlJ6tHIH8BHW4BXamkP0
	z9SUva4sPj3xSvsA6KlpIyKtMUKVU2ury9I1ttuFC+2VFc5LQMpzCvizA4Q/szHGcNEepqqmLKe
	vlmZX6nz3ZQ2mqdJW0PjTGGo4lpanIzZxJjD+Cer+JgStqWQKCtW4Xo7v9CUhhuxGWuD6
X-Gm-Gg: Acq92OF7UO2wu9n447OjA6GxWsaKGKvx9RO8mmCRA7j/zkNavQ+YVbpenKDKy0vZvYE
	4pG6KC2hgAhA8pV1QNmDdZino8AYRJuX24Fi01hxEdfrwTjGaSGknx1GQ2LsIF2m2U/znUwA1jC
	Kz9wNOHRdeyILI+t5mkjuPnf0u33tk7isbAlh7fXZyMb7MPavNfSO7nemTjspsy57CX4mN4e6WR
	6vnWphmcYBV0yLx6FUGUNC/Dc6MMa7Xjm1aSXMRHbqC1ha1J88rzF6DMqnTGM00ZcfWa71cGO0c
	o6eJaNFnPLdsl7+otVuVd02na74Ww1Srk1FTYVoxE0PiE9doCwLfqiJkgFepLuV3L3gsLt76OjQ
	M66SoEzVwOsj8hpcbnOzc3nm4wvFCHDqVvba/UEI5CvR7z1zJL169EXx0c8dk0r62sy1w4kQ8fh
	En4NwAKz/9mkFSQqg=
X-Received: by 2002:a05:600c:1992:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490adb67fc0mr29782655e9.26.1780309258842;
        Mon, 01 Jun 2026 03:20:58 -0700 (PDT)
X-Received: by 2002:a05:600c:1992:b0:490:adb6:793d with SMTP id 5b1f17b1804b1-490adb67fc0mr29781855e9.26.1780309258391;
        Mon, 01 Jun 2026 03:20:58 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490aeacecfasm19237985e9.4.2026.06.01.03.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:20:57 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 03/10] drm/ingenic: Remove calls to
 drm_atomic_helper_check_plane_damage()
In-Reply-To: <20260530185716.65688-4-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-4-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:20:56 +0200
Message-ID: <87se76lfxz.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XAXNGh4ho67HMlgtqdkR5qlhXJBbJUZfNgc_2xq3SPo_1780309259
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Atomic helpers call drm_atomic_helper_check_plane_damage() after the
> atomic_check anyway. See atomic_helper_check_planes(). Remove the calls
> from the planes' atomic_check.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

