Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAF23939D2
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309318; cv=none; b=eTdri8F+OR1+p8dSQeCP+PUKt64M33cO8q6v1nf8UyL1KT66xIWVdMx16CZDPqEKJllJf2MBeO1JwpZVLHyUInhvDvLidKn3DFWT5ej8JyCXTavmrmA7mCbNSGM/JBhlZKMH5VIwLSyYy2BzSFHJfVtgfVjqLT4rNjbLY06rJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309318; c=relaxed/simple;
	bh=+GFFl+Rwg7JHhjyaixD5rn1nx7MuuwFPfvgFiQ+tuhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MS3QkfRNpHHvfzwYRtt9sjyMsuiMrtMIDpKvgiyVMDSbk+NujTBLah1Guth/ofIneBMN9dQ2ZqmAkrvSZ/Mvziupb3LzNpo0BiuvuKB9ebq64utg/SCL2UUTfUzfWm0Oei6OahdKidxzw2T+z2J+uYe6fBWDzqP95mM415juuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RIGsXs0c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RIGsXs0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cbduX2ADEGxdwqbVWpmygVu5C4B36x/+bcdfT1PUUqQ=;
	b=RIGsXs0cMKBwTnwVFEDAV3//WaQHg4zl1hpNPIfMrjpEzy3rLECIG3LmunqKsOsJkxE6t0
	3ZAxZPTVZye63+jVfJkCDY+0PRzolwkM2O6mvdMiSjloYb7iD9r++9tZ75H08b2whO3c0D
	NpXQYyWcqYyGOFbpcDLsVH950JSYlEc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-SdKWBhQDM5WeYctUQTXu1A-1; Mon, 01 Jun 2026 06:21:53 -0400
X-MC-Unique: SdKWBhQDM5WeYctUQTXu1A-1
X-Mimecast-MFC-AGG-ID: SdKWBhQDM5WeYctUQTXu1A_1780309312
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef616db45so1489890f8f.2
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309312; x=1780914112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbduX2ADEGxdwqbVWpmygVu5C4B36x/+bcdfT1PUUqQ=;
        b=o0mBBUo7G/uyFfMXeejZffhBbiWbSYTcHa5IeSgQAD5HgGp2uXqS3N/khw9Bji1U6X
         Ekk4Mt5gBxVP09fDfI1zDL9QYFGqC5dwrfl6Uqr0cFyRkPpw5/jzNBuEFMr3XDyNx6w7
         fKV5eZcXKbSXUNusfnY50JYorSpHIuOx0AKs1OBhlcmlnO/LIrmp7yxyOpBzrNxmhNWh
         8Df83eTWMDI+DvHl6pk+E39Sp4f4ZVheWQiRjeHL6TtKzFHBUsf054NBXuOawGb9uTAg
         lbLzfQMy2z1OpS8KuiHovjy23AIAFuk2+rFm6QF0uRm85l62BnUJeGfz1dPT1PjFIvn2
         +ELg==
X-Forwarded-Encrypted: i=1; AFNElJ+FQoj5DxFKFCUVBSTPrCezZd5bE0yIzfpf0Ee70oZCieuDG7d50a3chj+zp4s63VqNNEI8E+lAhk5X3qSo4g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/M3BTHO8R7zEFYListFUrdZrn4A2PEpas5m4xu1RXGWAnBI02
	wVoCLfA6VoE/ORO0EsHKfjaELZNmuskDKrd+76c1PZOfYcPgptgUWYPzBIgbJbn805qEAEAueEa
	rFro6cwlsx2PRJkAzbaX14wlC92UOe4A1lhUzPIO/1FJ/OS4xUMt90HVe+pelRIgqKxE7
X-Gm-Gg: Acq92OFjh9lxg6Y1HWfdgXtOUFHHSIR5Ewmx/m8Eq/i+e+M4fPPW/8lNnEhrJFN6Jo8
	/33qOoWFFF2cQ48dMFno8qVTtj+cvlA1jYlwdAuk9qlyduxUYG7Uk6tL7a7aJT1Ck3Zpmf+X3sD
	QXzgZE/lEwVXROFDlCgchFs5xSd/wgXa7PFG0rPQdSje6NwZWG8KWyqiWRg9RDvWpOvyV6xQTTQ
	Rgc5DkdPHbBSd/dQRj6n9mocThOMWqXK1pNFRmnthGtNPoaLUT5Y6U+N6kQfAi+1mLzZs/Pgyk9
	4ULyCTF8UhIV2QeJEicwsRDq/yaVsXy77+gpP6C8GNrYk3jlJsB7hvWD0gs1D8JsK5PVi2JMBpa
	1YWQYcsLiiaFBnpwddxrq2YqmxLLKqQUrF21jt54QIzUdcxRTGjvwUudTy6+wCEoMMqMI18pHh1
	yu26qeWiaE2Ex0bg8=
X-Received: by 2002:a05:600c:a415:b0:490:60cb:55f0 with SMTP id 5b1f17b1804b1-490a292febdmr182719225e9.21.1780309311981;
        Mon, 01 Jun 2026 03:21:51 -0700 (PDT)
X-Received: by 2002:a05:600c:a415:b0:490:60cb:55f0 with SMTP id 5b1f17b1804b1-490a292febdmr182718675e9.21.1780309311464;
        Mon, 01 Jun 2026 03:21:51 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d68a925sm366735475e9.2.2026.06.01.03.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:21:50 -0700 (PDT)
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
Subject: Re: [PATCH v4 04/10] drm/appletbdrm: Allocate request/response
 buffers in begin_fb_access
In-Reply-To: <20260530185716.65688-5-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-5-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:21:50 +0200
Message-ID: <87pl2alfwh.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QepiXQejPpskF0UJ-7kf1JEs3M05c9_seGN9znPZBfo_1780309312
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> In atomic_check, damage handling is not fully evaluated. Another
> atomic_check helper could trigger a full modeset and thus invalidate
> damage clips.
>
> Allocation of the request/response buffers in appletbdrm depends on
> correct damage information. Otherwise it might allocate incorrectly
> sized buffers. Allocate the buffers in the driver's begin_fb_access
> helper. It runs early during the commit when damage clipping has been
> fully evaluated.
>
> v2:
> - allocate before drm_gem_begin_shadow_fb_access() to avoid leak on error

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

