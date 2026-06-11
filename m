Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DCE3DA5B6
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175593; cv=none; b=Wk97QrHzndRuYJd7KTZO5OOLByMY8as8/pKsGen/LcItri5rcBTIrPVaGnKd6nhLX9fvakaO1teKJ+ldbwkiwIWB41I5rcSR9h2PY27zfUB0Q9/cv25Kx2o6CW/MMGhzTjWEPLR6fpuyQfJDadkwZQHD4NwT+Ewfn8WoFonAZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175593; c=relaxed/simple;
	bh=ifamMReb0BWhkfjGxF//h0cAx/mHBlMkmlRIFK0occw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kc5aXRuiUddh+fZPnASo0Bi165tdI4v5ZcclD6kmcBg1O+njMxY30wptU+pErWwtk7WpEfMTsT5Go7is51fx8XNHy88ZsZ9OZcOAH2RERIALgsQnM3Uiva7Xe6RuNXTlqMgmJExxr1xi3onrTI9qD5q4m3MLalbKISwFyB8QjcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NAlhujsI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAlhujsI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781175591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
	b=NAlhujsIs/QD47gCZYuAxzMY7ffp5l8qiEPIaky+2KIQQEzqojs6FYwazTJTLLfS6klIDm
	Y0/9n06U4Lwv22RidppNSHsIeejcEb7rqVkEzsnUTt+0eyCksMHzXfHLnCXEri+TYet/P1
	VBk4Fa3MohgcCizYsLNhAmqPt2dcooQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-RsEV2P7RP76dSL5OrlrxLA-1; Thu, 11 Jun 2026 06:59:48 -0400
X-MC-Unique: RsEV2P7RP76dSL5OrlrxLA-1
X-Mimecast-MFC-AGG-ID: RsEV2P7RP76dSL5OrlrxLA_1781175587
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-46010bc0f1eso4681352f8f.3
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 03:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781175587; x=1781780387;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OE5i5Cs1x/Y1/tYzMUIth7XXWL2BCwQTkDQ8GlOHrbw=;
        b=g+E1kYZkY5Px8QOCADW+6OJpLpBprZg6/9/5ljHrsYeY3LA/YlVu8NrZsbM9hhfY1z
         shI8j2SvwMsD0isEgv09HP5nTKIOWqzENkkO6Cn5GScbDv6aCqp6l+kV0uLUQJwKqNiP
         MDmA7p/Ad+e6dLmEtjeWnR2t1NPMVoqxQEiQC23KSU2isH09dOhMM987odkmM3ACDhik
         AMKg4ogjwkbUEm/roymb2J4LcxOsPMguqCsr/Wn/CnjxDipCqZOyoaQTEIT8rpefeQgI
         +u/mkJCe90T4BuAIwxzBHZY2hHRAtvrrKA//ghMrxbfqAANpxPp1+Yj8ZsY5D6C4Iljg
         VMtw==
X-Forwarded-Encrypted: i=1; AFNElJ98xh0PJfoHYpg5kWBe6zTyu41FerPiKWFljxiBYQcRc8ORn2owZLmpP/o8CjoZuFYv5dHItGCVtqgsYQY2Rw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDVb5WOoc9R9SogEoZHPqFJ0Hx3psqnF8sou7VS8vRDrWNH/As
	cVe8uwWJfCpHaSnij0DdmDa5QIAV24X5ONQe9/KFQ7cXzPf1XCEc8t+1ZclMmJUWNPR4N3WhU2I
	+OrN8GR4FBND2LzlQUZsq49gzl3iD8oWca+EDGBspzhs9SvQSEk3DOTJVdEQHe74fKZNP
X-Gm-Gg: Acq92OHpiN9o31D2t7WZfhCZM0o71F+nBBREXbNwLYW3ODAdvQvAH3Tcy8qthl/B4dg
	vASr24Cn3mNZGYIQaoyq+ONI3RaRDq0cEU7RzqXnyRogUuoZGQDNT8oY7vgc2riIpPYYptgZJCm
	93nT7GDuhJFIUy8fqZWP5otcDpnC7egWsGdv/CqgyfVsPKthgMtgDfHeU0CYi+vnIHryjG+nMhb
	3wY7UY7hsehTYovFbwgbgleFK43XIk6vN5Rwf31C0MFfA0iZf4fQ6KSTEL7gXLATpdaBvbkN+xm
	qqohxP9o4uq5jzU5DvCo9njbGXfLhIWRgIIV69yaJWjQCQRWJtojtdxHiINanQPKeiWNBQ4rkrc
	2XM7egG/ZjjYQ2DB/Dtz9MGvVt7+aoZWtXqCgMvmihpYPdmTE7AW/FdkhgBZgN8TNgOzUoUYw0W
	dyLuXuGtyOsGm2Uew=
X-Received: by 2002:a05:6000:710:b0:460:1c5b:f25f with SMTP id ffacd0b85a97d-460677b1af7mr3240519f8f.20.1781175587101;
        Thu, 11 Jun 2026 03:59:47 -0700 (PDT)
X-Received: by 2002:a05:6000:710:b0:460:1c5b:f25f with SMTP id ffacd0b85a97d-460677b1af7mr3240484f8f.20.1781175586716;
        Thu, 11 Jun 2026 03:59:46 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2dcde3sm81947989f8f.1.2026.06.11.03.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:59:46 -0700 (PDT)
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
 amd-gfx@lists.freedesktop.org, Zack Rusin <zackr@vmware.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 01/15] drm/amd/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <45aec54a-ec80-48ed-9bcc-84e7bccc11eb@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-2-tzimmermann@suse.de>
 <87y0gl5qw8.fsf@ocarina.mail-host-address-is-not-set>
 <45aec54a-ec80-48ed-9bcc-84e7bccc11eb@suse.de>
Date: Thu, 11 Jun 2026 12:59:44 +0200
Message-ID: <87mrx15om7.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FOTgfzVGHcsjyCgHssmmtf6-HHoJbY8MmRIe1GAaSIA_1781175587
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Hi Javier
>
> Am 11.06.26 um 12:10 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>>
>> Hello Thomas,
>>
>>> The mode-setting pipeline can disabled damage clippings for a commit
>>> by setting ignore_damage_clips in struct drm_plane_state. The commit
>>> will then do a full display update.
>>>
>>> Test the flag in DCN code and do a full update in DCN code if it has
>>> been set.
>>>
>>> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
>>> to ignore damage clips") introduced ignore_damage_clips to selectively
>>> ignore damage clipping in certain framebuffer changes. This driver does
>>> not do that, but DRM's damage iterator will soon rely on the flag.
>>> Therefore supporting it here as well make sense for consistency.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
>> I don't think that a Fixes tag is correct here? Your patch series
>> is changing the 'struct drm_plane_state.ignore_damage_clips' and
>> the changes make sense, but definitely isn't a fix in my opinion.
>
> But shouldn't we have added this test in amdgpu and the other drivers as 
> part of commit 35ed38d58257 ? Sure, these drivers don't use
> ignore_damage_clips, but it's still an inconsistency wrt damage

I don't think so, since the original scope of ignore_damage_clips was for DRM
driver of virtual devices (namely virtio-gpu and vmwgfx). These do per-buffer
uploads instead of per-plane uploads, and so there was a need to force a full
plane update if the framebuffer attached to the plane was changed.

Your series are now extending the scope of ignore_damage_clips to be used by
core helpers and force a full plane update when doing a modeset. This makes
sense to me but it wasn't the original intention of the propery and that is
why I don't think that should be considered a fix.

The only patch that IMO is really a fix for commit 35ed38d58257 is patch #6.
Because is true that the plane state ignore_damage_clips was carried over
when the state was duplicated.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

