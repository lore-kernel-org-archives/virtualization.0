Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12037B400
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172734; cv=none; b=u1h3fWfAuHJ/9SiRwtpqUraZPe8csHXwZN6jHlAuPQ314r2gl8UKENSBeUxYy78mu8V8JSUzdu370Vls5PVqdxYAXbwIDR/96vBglyXra2/TsmQRTQ07ZV8DlU2p5QyAJs1RjbXq6Zc8w4P/KayH8yfeqpx/9kKFvrxqGHUmae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172734; c=relaxed/simple;
	bh=0DTkubvoxHBUMHmj/JTP8y1M7mVG+8twCULO8Aq9NZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gIMRkKwrELVWFrxxt7JvMrW3GiDMaaxI8FI+D/XnU2InFdfLEyNFOormWTnS59NIaUgVaic0VGEkc8XX+b1oeJ7OQne8gnsp0YJgmATM2R2rsiySV1eMOkoRqWAkYuGE5Rv4OAh5fieJoZ6+4vchnsmSyN/T9rdGOQ40LRrktmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieBjdwc6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieBjdwc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
	b=ieBjdwc6wqKBKPFZy30ARGnn3RTFJF5UQ2IyUD8GOP5OQN2DTP5LetZeRvW3CiRx3KPMWj
	NWajnAil7BUrqFTeUpZkgu20ogPiEM7IFGNrMcK5W3hxymlyim8/MBTpzCAiH5Ey5NHO69
	RmPVZQGOCYzDzm2qk1rW/Ciw7TLo0qU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-UclxeMjgMsKDdCSd6m0Qhw-1; Thu, 11 Jun 2026 06:12:09 -0400
X-MC-Unique: UclxeMjgMsKDdCSd6m0Qhw-1
X-Mimecast-MFC-AGG-ID: UclxeMjgMsKDdCSd6m0Qhw_1781172728
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso36863875e9.1
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 03:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172728; x=1781777528;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0r9Bb05wU768Bts6kNipr0zjojivSJzgQogOHI5wH0=;
        b=Se8XQ9GAhzh2MX9IcddcL43dV7lcuV4jBMmXw1Ut60QF2QnUU7Bagp6PEZRdu4vsDI
         T3wR9ulKXfvEkoDSaQ56CJjZK2Qq5iTaiGaQWFFb9eTwLiaTB9mChj/GW2htfbLrGT7R
         e6uDPs+jyf+Xgc69KBou4DnQeTU5RyHzTyIOzNXOvdFute7/0D4in81OvbJkwEVdJjC2
         /uHIlXz/KEXyF3uIOZrmNJTSTNxwdQhG+ZmUBiiyN70VxooMynd+fIM+BCBhpLkWq6+v
         5PJAF4ulcbvJRHMHTyrCYJzboGPL3NQ7CoDg4tki/4X2wSkklmVojeMROzB7/ZjOFE+a
         J4rg==
X-Forwarded-Encrypted: i=1; AFNElJ8bKgaXeiocgL89Y3AcTs7y/zzh1GmTX5kz3eSjLmVnf5/RgXthgYrgr9qcTwM+185gAy9MVjjbmMxdliJ+/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyvIIMMBlHv1HS4b80LH+cYe5X6zJAAAhARfCGKg3amJ+f06bug
	MHhLOurVVgXqI82JeC/Wvhul2ji8z9fN+0ZFD11VGOzSDk0wMFbnbYYcYXOWhmE79Ixk6s2/VMb
	33MgSy/x7qBnWbyC/ZcDTRBW0kbCxn52ibIQD2EeZUd9WWI6r8Wa2mhUJbeeGo+olC5Xp
X-Gm-Gg: Acq92OGtLcUm2fg6izH/KZzLrnzI8jDEhKDFZdIf6q5X+yTlnL/h5Br9OAB2iThjUXL
	2L1g9CXtUjeb/tdboZeSZy9oI7shPpqoLyXpREK5Q1evbg9gO6IqEgIA7u+Jx04OWvGOJcKD2cS
	VB5cS/lxHFLXXO+8FY1vN7jYBQBJw457leY4yll0uTtKMnJHSGQjxp8+dri2si+8Ic/HcCKppWd
	fvBcsMrDlQLTgwuyJ+VzyCKVtZO2lzZBWF6odKeUwekQ4mdzRK1r+/Liyi8RbX0+a1G9+zJZU2g
	gXRUovuiOvVqlwQkWRs4F98lAWdPj+LPW4j7RiS0OREOpCpEvvgLSkpJrmTOIxT9QC6N/kF8lwj
	Nj2o9/GYaypyYGygluxc9UYzyC+Neh9sM1MSXJ33pLFUFMbwdTBEOv6vwZY2GOJ+D8TSb/UqLmg
	sPoNZsiA9Vwg3ssMY=
X-Received: by 2002:a05:600c:a39b:b0:490:c08b:b24b with SMTP id 5b1f17b1804b1-490e5607e3cmr15876205e9.26.1781172728121;
        Thu, 11 Jun 2026 03:12:08 -0700 (PDT)
X-Received: by 2002:a05:600c:a39b:b0:490:c08b:b24b with SMTP id 5b1f17b1804b1-490e5607e3cmr15875655e9.26.1781172727683;
        Thu, 11 Jun 2026 03:12:07 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e2d09a85sm51975965e9.14.2026.06.11.03.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:12:07 -0700 (PDT)
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
 Zack Rusin <zackr@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5 03/15] drm/vboxvideo: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-4-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-4-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:12:06 +0200
Message-ID: <87se6t5qtl.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rg6Tv-87dsyy2NCDg7lism9Oew75YZU7168DF9LTYBU_1781172728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update.
>
> Test the flag in the primary plane's atomic_update and do a full update
> if it has been set.
>
> Commit 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers
> to ignore damage clips") introduced ignore_damage_clips to selectively
> ignore damage clipping in certain framebuffer changes. Vboxvideo does not
> do that, but DRM's damage iterator will soon rely on the flag. Therefore
> supporting it here as well make sense for consistency.
>
> While at it, also replace uint32_t with the preferred u32.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

And for this one as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

