Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47608263C8F
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309206; cv=none; b=E9V7hEw9isQECZhNvwDMd03Mz8e1/3ui3okfJmUdXwPXxGTG+7KfNotNdvAkVynv+iTeP14NMyGGyNshEMwcTsSJzdMirJNkoNBtjM20iWZLfWim+y6fYVTH14fpIBrjxc3uhv2EIXrubOPGIQ7u9g5L9KtwpRFqXtCmEZp0V0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309206; c=relaxed/simple;
	bh=o3mo65fLt7N33RYK+WAo3bfYLXxMeZQmBkFurOPJA88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S4ghs+Lc2toSy8SOWozRqxKp5lOJXJiadWHMo3DbO+7OilZRdJdxAc1Tf/o65Y8u7qSVrBTJO76vA0t0LiumONMvBo1eMrHYiLem04AzWN9Ub5YjZCJvBKbp/GQRsmIbb979+TL2AFsXGYgiEQWH42vcnCAvI/CohzkatRcuM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1BzJoW1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1BzJoW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2pmaS/rwYkc2+fCZTYV9toIp0r3BjOevXJeqgzIBH1c=;
	b=D1BzJoW1QrTNa3quIfK/fBkzaVAKXEqGng7o8JtD8uwbTghyYEfzOqt4NCEY3wlg0SxLOU
	urb7yuOay8RQbrdPBHW+Kv/D3XF2ajhLW6+1BwfUJuJbwtWho3ofmJ/9xre43uPV11R/ln
	cRw1taIAEVtfEeB2cEreHBf8bHp2rKs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-KU458YIxP8-odK-Rf6IREQ-1; Mon, 01 Jun 2026 06:20:01 -0400
X-MC-Unique: KU458YIxP8-odK-Rf6IREQ-1
X-Mimecast-MFC-AGG-ID: KU458YIxP8-odK-Rf6IREQ_1780309200
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45eed49ee63so2758401f8f.3
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309200; x=1780914000;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pmaS/rwYkc2+fCZTYV9toIp0r3BjOevXJeqgzIBH1c=;
        b=PoZqcrrL2dJ0/zZ+oL071L57Y6VD5x1pxaIMG9YuV8DCjVPzgTMGZycIRIQCuLjvO6
         yAGp+pznPoMXmWRaR1hHJAA7xoKq3I2EaIFZL0gnjB6JMsRL/mpqMJX2kAseBzvHuKeI
         cPOiqvb5v+N8obVCx0dIX9iN4jyGIxIO6+Uq2/k7JtwEXib1chY8/bK+asmYukyAwhSn
         Db03poI36L1qBqyrJAuzEs8lrBeM198Kmxi2KvqFkqBXMZZNivpRTIVAlpW/5DbOo5mP
         6B+E+uMfkAAnLT3tYKyb0RG3ZiXq0VvoDeSDkHGy6+dJA2xZZbPf0E/V7EAEeCGVkjU5
         xnbA==
X-Forwarded-Encrypted: i=1; AFNElJ/TZfDf4lgwbu50DxIS2vEcqQOunBQtbZ3LJlXT18Mz28xoVVOmWT21mYtaKr4FLZv66SACta5HJMjaFXIt/g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcFq0Lt+86WjvKjPN8ivnEtQ8/7XMztMopEuuBLHtevl8NGdzH
	wqIEDidivE09in56D17TJLCCgIzv+6poT9UStsZwVlulyFi32SGRpdYZ/0LIABF7fZJQNp/Dzwh
	rSgMiFLr3X/9ZR+qD2y7C1qFpTt9yc7cTpZ7Mw0tBNTGewnJVJlSXxM9UjawWwuhhNfTI
X-Gm-Gg: Acq92OEeinxa7v6/glCnDhx4T6Syj0R6Wz4yN2Ovqx4Iset7e76u4sR7i2XE0NtOlDG
	xvRSrozqGuTTaLM7WJbCPXOKW6Tf1E5PuZdlOPo+XIrnRE5f9BI3i00KT+NmaHoXXpnf4KpfNjX
	4Q7XXd3vXL0TdHay5WTyMMJNSSM0aWE0HWTkC+4LWK0VIcfsmHxhpe/j6+bfMW4x7UEl0P3/R2L
	TgBI2nYbJRMxytcgJQVUi83bzmUmq+lOJCnQWUOy0uxjgyd7pvZe0UPppKMhl2n0KxN9mfGG5zT
	TvLaEGxs88jHGIaR6IbfYuuLqLJs7/w/GkErhgttAlX/0Amsibhm6eMVA9Luggr2z7RuzvAT9Sm
	70scuP+ufawGsCjkYFGyRh+nvbDsCIXGBn7yzwjLjlx0h1RkThJbV/K7X+C14alU+bu7xzFlknE
	PcaADShsCLF7KueBQ=
X-Received: by 2002:a05:6000:2581:b0:45e:f8d0:d22c with SMTP id ffacd0b85a97d-45ef8d0d485mr18400666f8f.25.1780309199693;
        Mon, 01 Jun 2026 03:19:59 -0700 (PDT)
X-Received: by 2002:a05:6000:2581:b0:45e:f8d0:d22c with SMTP id ffacd0b85a97d-45ef8d0d485mr18400611f8f.25.1780309199267;
        Mon, 01 Jun 2026 03:19:59 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm24570236f8f.17.2026.06.01.03.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:19:58 -0700 (PDT)
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
Subject: Re: [PATCH v4 02/10] drm/atomic-helpers: Evaluate plane damage
 after atomic_check
In-Reply-To: <20260530185716.65688-3-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-3-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:19:57 +0200
Message-ID: <87v7c2lfzm.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yW7h5a70x0bIF37iNjL_fRllCVfQ-P2TW5OZGr7Or4I_1780309200
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Each plane's and CRTC's atomic_check might trigger a full modeset. As
> this affects the plane's damage handling, evaluate damage clips after
> running the atomic_check helpers.
>
> Examples can be found in a number of drivers, such as ast, gud, ingenic,
> mgag200 or vmwgfx, which all set mode_changed in the CRTC state to true.
> Ingenic even re-evaluates damage information in its plane's atomic_check.
> Doing this after the atomic_check helpers ran benefits all drivers.
>
> There's already a damage evaluation before the calls to atomic_check.
> With a few fixes to drivers, this can be removed.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 51f39edc31ed..4c37299e8ccb 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1065,6 +1065,10 @@ drm_atomic_helper_check_planes(struct drm_device *dev,
>  		}
>  	}
>  
> +	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
> +		drm_atomic_helper_check_plane_damage(state, new_plane_state);
> +	}
> +

I wonder if it's worth to mention this in the drm_atomic_helper_check_planes()
function kernel-doc comment. But regardless, the change makes sense to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

