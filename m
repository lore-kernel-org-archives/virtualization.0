Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3F233953
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309745; cv=none; b=BA0gWTg3hNd/Sad+wNxwnNikxKWcQrDWxc17TkdatjzD0nZ9jEJszRSCVXoqT2r6/gEq0OAwm6Oq9nkb8XiKFQSb8vZO4T2P75pFjT32wdVUOrTVH2Gna2XrcJlhq6R5mIxrccMPbYKWIfew4ow7gRZA/t0mXHKGYFVQNs+bWo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309745; c=relaxed/simple;
	bh=fWhbb8RP2B9GFzJgG02F16ZQKziy0+yRxPE3hHDevpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eFvlSya3D0/2r7RtGGlpbGpE9HIICKTh6Tf0OjwM6WnYgupNWzgp+l09GjWOYlni9AXGC83gcX1N2OB0MbTS/QdKAQ/tZqJleGO2UDtSkxuhSiCSOpyUp7P/YHZ29m3PNovPPNm6FyyiNWjiKLLDVzq9M4M1PGSs2o0YePMENPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ya46cfdP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ya46cfdP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rR3vdJBAgyYpZ/mB0zSfLOFP8KAbUlqalAgRbWXUhZ4=;
	b=Ya46cfdPCpfK3KOJatoUvbcW6GqOT7VEuVcn8wDVFsHmfrxCb8XC20CKiRpmKxPv1G3FGt
	b7UQHfhJpPFYZRmGLGoRkshCtAFjP4kREH0YH8f/vKRxUZg8Zi5oHnyYlu7UbWWzCBtcW5
	BhZzCXCsJR4y+M/q1NQeWb4d2XojD5M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-WdTFloFdMp25qLc0j_o2-A-1; Mon, 01 Jun 2026 06:28:59 -0400
X-MC-Unique: WdTFloFdMp25qLc0j_o2-A-1
X-Mimecast-MFC-AGG-ID: WdTFloFdMp25qLc0j_o2-A_1780309739
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a762e646so11755735e9.0
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309738; x=1780914538;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rR3vdJBAgyYpZ/mB0zSfLOFP8KAbUlqalAgRbWXUhZ4=;
        b=lyVDTtIrJkSRZ8/0qGxLubKFZr/z6F0XvP76ePsdsvY9KWlo2TLaTLkrHcnpgQjMj9
         lURtI6+SsYlhNbn068xUEXIeA3oojSQQtVc8tFkv+umllySuUQWnW+qICEAD+J+4yjGw
         kuCvgHtO3XVCB+a3pKbXHO4eN8TTGYAaa0UHhfPhPvhcDfnuyJ1/gCtP1oFu2ldv12Ig
         vP+YW4yMa68ZL48Qxx2pSCINw9W0jQeNM+kt6Zq1N59dMPewjVhwqKFTMJa5L/47S7z9
         Bq16KXeEzjbo6JyHR/4am1NWrr9Yd9Mt560HrJKAS6Nqr03YrbVz5+jklnKliErr8u+8
         wwdA==
X-Forwarded-Encrypted: i=1; AFNElJ8Cs9u8wR27ZEJHxqBVGT+A60+KwMeXcCKpZsdBWw7OSFruK3o8B0qrRfZQFJ7dc/RBfYEv7zbQ6NfmaG1qvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKlLXOpgWn/JBK5KVCm2JpBNeKp3EMF/y5k7dZMFX0h0OdbOBV
	CIKMzwCx70jt0QqnRXw676BDWaQJtpBqo3/dzmLirShGwOeM2eiyFq7Wnuc4gxdr9BrriBOXNGQ
	VvoGKVR0bbMB3SDDmr3G5laUXFfwz1cLhBnVZuFWIGSt3efxL1qBoGmRmna54w5tYvYfW
X-Gm-Gg: Acq92OF450DImxw+sAgeLhpQeMmA7NoxebmJh4hjML157PvUXe4uRBooqrWmdanGhHS
	yD/AEZSLrZNHsH0R4pRAS35A91oIfS5+loeFjSJarnsy7Ut0fbHwE7OXntZYAYpDYuIs1TmbDFf
	fCH4VucPcjtPnNSD4d5vXQ9UwzOjjfT39O6u+lrf9Vd8H2rYWSqGcd2Uh97QitvJLGg2wSZetqt
	RCACMfsO6V6dUqPcFQrhyELxSTqQIbpuzgPkjiwn/TE42NLjSlVgJnF9MT0LIOvPn0TZKUVcdyi
	a2lawU+rs/zg4Xd8bsubOFshGVynDHiRm9EhD+AANkUDga0f2f0m7DUemLciTpQW6sCb/6qSAm6
	inkYioPBxEq/LeyKJNmVc4X0lHUC8WSvh5bM/BifODKfDmQoFdFPhUUifj17Wp/P8uBLn9NV7Yh
	B5Ii3rZ3eJAxVkOfs=
X-Received: by 2002:a05:600c:a214:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-490a2948f0cmr117371405e9.25.1780309738541;
        Mon, 01 Jun 2026 03:28:58 -0700 (PDT)
X-Received: by 2002:a05:600c:a214:b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-490a2948f0cmr117370965e9.25.1780309738117;
        Mon, 01 Jun 2026 03:28:58 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ae3901cesm8445615e9.7.2026.06.01.03.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:28:57 -0700 (PDT)
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
Subject: Re: [PATCH v4 07/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_iter_init()
In-Reply-To: <20260530185716.65688-8-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-8-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:28:56 +0200
Message-ID: <87h5nmlfkn.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EorNk3BoknlT19CXgGfCohZS5tJxJhmAsEavqqp9t-k_1780309739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Nothing in drm_atomic_helper_damage_iter_init() requires the old
> plane state. Remove the parameter and mass-convert callers.
>
> Most callers now no longer require the old plane state in their plane's
> atomic_update helper. Remove it as well.
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

