Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F4D3CAA5D
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172695; cv=none; b=q6HOWdWEeymRfRNw+nPP81TTRnK6jJkOoc6T1TdPl0trivxD0E1ngBEgJDZPYWA1yukklgYWqbCbVbJ71czkWsGM79asJHwrSJvBK55DQVRtPCWBKuRW/WO7Bzl2KmFxit0fJ7Yj9V8ujn5pst1656+7W+81LdoeVpA/aN2WIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172695; c=relaxed/simple;
	bh=jYECQqhOuGSVvKdTwPWyVL5AujdqMA5a0nxgPXJ1KXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A5dyvnz6SNrtI+akx7Qv4sMtCiO//tkIgyOUxxDrzLSw+ViHF2I9TB0bluHALBNlw4JYGSAYwGwl7NeXIjTTAE61RjKAEKAhpGf5AnRtxfu14RFhx2b8zXD+6yxk2PXkGMfw4gEXsi7rohbe7Pxax55ZpaycYnEUWl1Ta6IHbqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WO878pvJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WO878pvJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
	b=WO878pvJEI6JXNjjKNsvscchO1fjuTLeGTf+URHBDTn3TR+GuvWCmE8xBg9EcRqgynxJWo
	Suhs/dRPcnvHQDY/P6OkW+CSA7TXOVJMLcxIr6ntyQ0uhkqsA1A6/raQGXIX/EGw7+i7UF
	qrtQ0PU+irjjN1qED8CUhktuM6g/1A8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-Rubor-eZOvGXpsHC3pgGLg-1; Thu, 11 Jun 2026 06:11:28 -0400
X-MC-Unique: Rubor-eZOvGXpsHC3pgGLg-1
X-Mimecast-MFC-AGG-ID: Rubor-eZOvGXpsHC3pgGLg_1781172687
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-460198535bcso5015265f8f.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 03:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172687; x=1781777487;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
        b=IwyCM2Fu48qmbg1y0a+ptXKdHr8qfGn/FC5vi9tKmc3T9/NZbRYxu7NvpCUSFPJlio
         vFDhXZFLTjH3i8/wwwCabp4OSp6UTe9MhGCCmOWxGxVBmuJMEuB28DtVQykDOZywVxzN
         ke38wCjQOPsek462vhnN8NROTfDGKLbqy7S2CbxtdfWFiO2237Bqwj6/Vcjc+yEW4DEc
         0FJaOmqorxQ3epmqyC8MhRVtXr51KnoYhZNEck39BJgrTLJBRtKgE4HGbR6j1sETQmb3
         x9MB/KCu7fzJJMsS2fsv6fewFnsPlYNgXQBhmFQI80U5DyGY0DvprxFIjPXoI8+IdEAW
         Zf6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+1a3kYGUoaiwD5+rRSsMC1C7t2PzDDXmEJNETfuI0Btg6EgL1wa8SSKYc7QkEyDFTK9PjJ+RtmkC5jofTkzA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfpewBN1tA15WQZqZHnq6Twx/Y3+QE5QDQcLqr8bbcBPeMd5cM
	yFhxXFun8zSD62TSQXo5y4yzRSWj1nRAzlRJRcV6qhjaLoLPUJB01bk1Se6yD8H4YZLCPyGkx7k
	2ESAOcEa4vbK4Kp0CGkNh71bpaeN9L/oSH1HsADpJrZz1/MAk1TSNb+TjaPtKME03rsNp
X-Gm-Gg: Acq92OEpeqJTNJKQskxTKsDkCWJFYFn14SKgzXEaB0Sxlb9O3HxEQOZTK+OcBL3/anj
	+3gY90NFxdUBCWiDum+uKwhuAuSKlneRyAWCXbXRc7XmfcjoCpakjFXgnwDCnqTNDuhpTmW2kw6
	i6bA5PIHgjGFE67uqJPgAi9HVib2TTN/3UTdoju66Rokft2seRCydSD9o0ZythDU0cZzvUzL6QV
	9IEQNosa1LreIMgMv/8mAH4EmSZ64tf3gJE32hgc5K1OMUCKFZs6ZfN6lOfXiERsoctuHYGg9tz
	Sc0o1bPsu0/d4BRKGl19bizMBhXUsaFeZZKCGO+KXIz9VuJ6wmqreQY9x1KXvSgGnh7sVoCqMVr
	x3NRO1kvZcLk/iFM2QggHqGUoIoNDzQGe6gMMkdLlfi0jWx6P37KaoNfF4W6dme4BDDXSmleqsN
	EXbsA7GGRRsaF+1P4=
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id ffacd0b85a97d-460677b28camr2150171f8f.40.1781172687228;
        Thu, 11 Jun 2026 03:11:27 -0700 (PDT)
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id ffacd0b85a97d-460677b28camr2150129f8f.40.1781172686816;
        Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm63288157f8f.10.2026.06.11.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org, Zack Rusin <zackr@vmware.com>
Subject: Re: [PATCH v5 02/15] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-3-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-3-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:11:25 +0200
Message-ID: <87v7bp5quq.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: krMRI46NF4_9Rv-GVPLkyp6Spfzlq52VzTcBNLFG_9A_1781172687
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update. Commit 35ed38d58257 ("drm: Allow
> drivers to indicate the damage helpers to ignore damage clips") introduced
> ignore_damage_clips to selectively ignore damage clipping in certain
> framebuffer changes.
>
> The i915 driver does not modify the flag, but DRM's damage iterator
> will soon rely on it. Calling drm_atomic_helper_check_plane_damage()
> right before drm_atomic_helper_damage_merged() guarantees that it
> has the correct state. The i915 driver does not do this elsewhere
> so far.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Same comment here than for patch #1. I don't think this is a fix.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

