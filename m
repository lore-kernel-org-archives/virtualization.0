Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CEF38737E
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309038; cv=none; b=qr2QXppbLWHsP+U606IHGdVyVAcNoLq95HSR8O9f5uhohRP1R22k1E8QVs+Co/yoxW/xnnzT0Cvapz33M3QbCQWosvh49CPIPP+mLVlVHIpd1NP40zNBufk/97JHZrcbZeVPokusvSN54fdDb1ERqf6syE6LlANpOy32E4YKW8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309038; c=relaxed/simple;
	bh=//fpv6KtnZGPacElQOdywvJfvUtWfzycEBrOQGiMPzk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nqRRxvDmSBXORVrdDxEKbRxoFPVW8MPb1yqEsjiHBvCZ/mBW3vj7UWUxOGRC4P6BnYz8CzGvd8k6rtVURyVEnFQxGbu9YqeRzG5m+6m0mADKXaURdGzMKOYVEGOZC6y2zsAORMxhtmOL+aItKZV6YNDjzrA5PM8Drk/ePqr3VnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cm3beCCB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cm3beCCB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ec/J4tNvrAMdwkOq5RTOf80WrT+IRWDMG7cFT7/0gaw=;
	b=cm3beCCBOspZrZgSIjSu4rsiqwB80huWfTEp/VIqTwTM4TYaE1Xo+1Vz1atf9oACNFOpgw
	+brAjRtH2v9og93KfBNIhEXCzpEre9ZStpOIeJcD5/QGmBehT73g7zjyKBu5vPYirTBXqS
	pRpbJP2RxkyYtk8hf9w2zjhoPWhLhko=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-NR05lNtcPpmV70t4PCOjwA-1; Mon, 01 Jun 2026 06:16:03 -0400
X-MC-Unique: NR05lNtcPpmV70t4PCOjwA-1
X-Mimecast-MFC-AGG-ID: NR05lNtcPpmV70t4PCOjwA_1780308962
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490a763180bso11035975e9.0
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780308962; x=1780913762;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ec/J4tNvrAMdwkOq5RTOf80WrT+IRWDMG7cFT7/0gaw=;
        b=S6h1Fq7IT+aYNJVnvB49s01/Qj31LXa0Kn+p0VIo49DyMSiSQTSuLvmaC67yvOWE/6
         /JtMCL4EY6LidRnZyqG5GR8uEZq6GDNuH88uirQIbY3ZZk6i96pC7Eym2qygxgjfiOnf
         snlD1QOIfcDn2x8HD/WhXC7Hxq3fXzUeP90Z9CuDlviGIjHnT3rq7OgD5JJLOSslfFdJ
         w6OH/p1LMwbLtcdD2hGJTWK6QitEVrc6b5k6Qy+uIiHlYfrIRcsAkAPFYCvdIGb2aVZS
         MK8PksTqR929XRh8QjqYVDEOxbF03dkcw4uBBAeNW1IqJqDu/XQRVQf+7iMBNkOgb/5c
         c9AA==
X-Forwarded-Encrypted: i=1; AFNElJ+OfR4pU/Exjx6gNOHrsqN7igyidA0D747FsdxS00zCBD8VZnE5JIG58z/h837LZFvR6bojEYN+2fLUlDazpA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxyyxrqGHPAwsFgQnyMREBb90VJKqO2RXjGO0qAdxdwRSgch4sX
	AbgFiDSU1wfjIdaI/RUUOg2ebzAl0elYeeMNCLHZLo8Q9PHHJJPPEG/XUBFcun6WUbLuuc+KHn6
	iOPLf6buIPjh11e7EvBJTwCmzZ40TE8toqRfJRAYOmHSxz+QjN8x3m9e2yQCRtvMJraTv
X-Gm-Gg: Acq92OGX5nrw0UbxBDg4enIIkbjW3Jpr7BQyOqO8vRKVNyzoumSxQk/BFoByZfMnKT4
	SUV97FSX0UgsgIn9RhNQesEFVCumXSjddc4mvRXbHLN1ZvGHtvb+9JaGKnCuqLMyR6EGcxPERab
	ZrqYiqF0OzAAJxttpjIRZMGxhCTbTejIPVcvy63jl/HcFgJLoJmR0LWDflSXqNVziZjWKJ00Aau
	iSpO8ODmIpYyp7/tHmSvao7G4vV3A8dgEoJZi1S70XAY9oldwn6en1AUBGYQN3NCYnaHr3Gf0kH
	ep6IQcb0DY2f7jcLiKI3Rci03JvihDE2VK+KPxA1IfwBQWJrBN7tamTDnR85gPDQs3BhHi4o3/Z
	EZmHKGa5NpXi66ooU8wfX8hM84RYuX54+GEx8YqKEuAut70lqCRN4h1PCnIvt6UoP1Z49N+OpGS
	VXcEhvpjloUZLuH28=
X-Received: by 2002:a05:600c:1c06:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490a29838b6mr211911505e9.24.1780308962204;
        Mon, 01 Jun 2026 03:16:02 -0700 (PDT)
X-Received: by 2002:a05:600c:1c06:b0:490:a298:3859 with SMTP id 5b1f17b1804b1-490a29838b6mr211910935e9.24.1780308961705;
        Mon, 01 Jun 2026 03:16:01 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef32fabcasm23621879f8f.0.2026.06.01.03.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:16:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklinux@outlook.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v4 01/10] drm/damage-helper: Do not alter damage clips
 on modeset, but ignore them
In-Reply-To: <20260530185716.65688-2-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-2-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:16:00 +0200
Message-ID: <87y0gylg67.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MnhtB2ckLNX2TrFAWtlp7CAT0Qb55-rbY_IM75lwKPA_1780308962
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> User space supplies rectangles for damage clipping in a plane property.
> For full mode sets, drivers still require a full plane update. In this
> case, leave the information as-is and set the ignore_damage_clips flag
> instead. The damage iterator will later ignore any damage information.
>
> Also fixes a bug where ignore_damage_clips was not cleared across plane-
> state duplications.
>
> Leaving the damage information as-is might be helpful to drivers that
> benefit from this information even on full modesets (e.g., for cache
> management). It will also help with consolidating the damage-handling
> logic.
>
> Also add a new unit test that evaluates the ignore_damage_clips flag. It
> sets two damage clips plus the flag and tests if the reported damage
> covers the entire framebuffer.
>
> v4:
> - slightly reword the commit description
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
> Acked-by: Zack Rusin <zack.rusin@broadcom.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.10+
> ---
>  drivers/gpu/drm/drm_atomic_state_helper.c     |  1 +
>  drivers/gpu/drm/drm_damage_helper.c           |  6 ++--
>  .../gpu/drm/tests/drm_damage_helper_test.c    | 28 +++++++++++++++++++
>  3 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> index cc70508d4fdb..84d5231ccac1 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -359,6 +359,7 @@ void __drm_atomic_helper_plane_duplicate_state(struct drm_plane *plane,
>  	state->fence = NULL;
>  	state->commit = NULL;
>  	state->fb_damage_clips = NULL;
> +	state->ignore_damage_clips = false;
>  	state->color_mgmt_changed = false;
>  }

I would split this as a separate patch since is the bug you are fixing for
commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to
ignore damage clips").

>  EXPORT_SYMBOL(__drm_atomic_helper_plane_duplicate_state);
> diff --git a/drivers/gpu/drm/drm_damage_helper.c b/drivers/gpu/drm/drm_damage_helper.c
> index 74a7f4252ecf..945fac8dc27b 100644
> --- a/drivers/gpu/drm/drm_damage_helper.c
> +++ b/drivers/gpu/drm/drm_damage_helper.c
> @@ -78,10 +78,8 @@ void drm_atomic_helper_check_plane_damage(struct drm_atomic_commit *state,
>  		if (WARN_ON(!crtc_state))
>  			return;
>  
> -		if (drm_atomic_crtc_needs_modeset(crtc_state)) {
> -			drm_property_blob_put(plane_state->fb_damage_clips);
> -			plane_state->fb_damage_clips = NULL;
> -		}
> +		if (drm_atomic_crtc_needs_modeset(crtc_state))
> +			plane_state->ignore_damage_clips = true;
>  	}
>  }

This makes sense to me as well and I agree that re-using the flag for this
is better than making plane_state->fb_damage_clips == NULL the condition.

As mentioned though, I would make it a separate patch. Both changes look
good to me:

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

