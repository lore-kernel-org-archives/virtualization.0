Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90833955CF
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309777; cv=none; b=JYTJnfbJZnUENFyq++g9hb0wD/+nkIvXvFkaUss8SyMWjkZwrtGeQGE7VaYVZsbJLLRKhT+hUpY5NbquavPwUkyZjTODnKs6hLvxR9zSqIWTj2FPG2phG7MnauCIYEh0UsU8Q+BNbabknDzxLZXEc2y7YqHTIxuoSwyEnNAT3J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309777; c=relaxed/simple;
	bh=4dKLYO7/xzvYtKg4HAIvf2hSPWCkn9FdTg30Var8HtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xx05Lm+Gu7a/hm0ue3vcao+lScQciNScuEaEDe6ETxuUv+obmv2SmIn7bExlI+GqLy+lQ+aaQ0Yjp00yfRyzEPrZIcOHMPgVvYNAgCcnN8gO369eV6vfnb1a+bWjGiyqy39xMISWXlKiId4LWxwGBoEWFkyQwONgQLIUgQ6ALRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GUWT9qnu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GUWT9qnu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NR4sOBYtM0bZ0iqX/XjOc3nz+SGcL1hWjzs/0wJdl4Y=;
	b=GUWT9qnuvzJeXC8h/akWRJGjJSnJwzvyONUeG1GDi3hi2Os/hAjip0L7qEM9dA8paBh5g0
	JUElY2BllicLC9Kcki1QvDmyHCwcA5figqFdRoeGwAvXLSfsecO6GPJR/YxISvcMKYP8GV
	J/nKhiX4A65ZZ4QZJq+MLPGZoYq+W34=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-AbiZcMqKN_6PR4-oFuOFSQ-1; Mon, 01 Jun 2026 06:29:34 -0400
X-MC-Unique: AbiZcMqKN_6PR4-oFuOFSQ-1
X-Mimecast-MFC-AGG-ID: AbiZcMqKN_6PR4-oFuOFSQ_1780309774
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490af284fd8so1200535e9.3
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309774; x=1780914574;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NR4sOBYtM0bZ0iqX/XjOc3nz+SGcL1hWjzs/0wJdl4Y=;
        b=hPMKhBwv/tn8F5Fi4cKm3m9ctgfGCg6h+I0OIXg7AAE0YROMjzq1gwP6tjQbEItYjh
         rQpAbFXsQHbJXkYdigUF/fY4j5qhXxSTGe2bD2G/qopxeFNzwDYEeEJ6n7/mC1DGrtOQ
         2PQ79MSvZrjiozDUOKZbugMy7YYXSn2TB6LjpivKKrZIOMs6AD94T5D3UL5mH+FHVp+j
         KV0rbTKI0905KNFdAEKqAy/V2WfM4QL3/WvvXgsJFxfjoRTQy43wRdRXkyDy5iNAyaij
         4fcPLnZ57On7g6r4s1ubChy7yvKa8eg4RRTIY95p/EutyWwALGMHYtYYp/6aVy33Vft2
         7B1A==
X-Forwarded-Encrypted: i=1; AFNElJ9vyKI7sF357svb+ClanAIIf1CJ5BTDeg1Mz+hAUPmB0ojlHsla+usMs1LTPc35yS/5gJwoQ9hJ+KKjmUb1mw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwwKG3M1c3ukmnQJzcVbaGuPyZolSB2JndPoZuifk4aSe4haBfI
	BmjBTg2pqzr6llWMqGoDSnBtwVp8THJzb/l2KHluKMjpkcKepOokOwnumHXtN3ZEiZsP00Ct41z
	0xKSiOGrtP5TLbhXcP1mrD6WeJXRx3QDsJAb2tSXLkQAHuk19vzY6cYErK9WNJLR+wGQ2
X-Gm-Gg: Acq92OFCda5VDSC4HZhBGxLkcb3+PXzVdOY5kPe0z5laNHtUzp7Tt8qDAdsXDqIztb1
	l6NtJlLNkw1V1XFoCsed2faSG/P/fJmxJhujPD4Nl0YLEb4oMlSIv8jdFzlfEX4oX1anYS7qpyd
	ea+o/83L2JuYLtecfjjepsY7uEH1MTRhZlnAx5SRYrUM7eMl0/4zIyJvl1P47SMvv1gumsvkwyf
	f70sk7n7JXzBvvHGzdnbWNqHCp+uB4qSqMDE2bUMKcOS4VAPgBnNTg8DkFJsg2lMZnymK3pAlxi
	7dwrGQHBZwW7q/p9L6Z1yMy7PrVmNKxYqoKrGyvKUJPOGVPC0nC3a8h7ulh/kjQ5E0XUZy5slr5
	KN+zTFv2607IfCMnJsHM4XaRehUrXc953s4ohUt7JT7tSzJGfzwC+HnzQFs1YJx2i7/2usWyY+n
	iN9DQSisy77j9GXQY=
X-Received: by 2002:a05:600d:8444:20b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-490a2947c86mr142088445e9.28.1780309773583;
        Mon, 01 Jun 2026 03:29:33 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:490:44eb:c1d9 with SMTP id 5b1f17b1804b1-490a2947c86mr142087935e9.28.1780309773155;
        Mon, 01 Jun 2026 03:29:33 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a037fsm25007994f8f.4.2026.06.01.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:29:32 -0700 (PDT)
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
Subject: Re: [PATCH v4 08/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_merged()
In-Reply-To: <20260530185716.65688-9-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-9-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:29:31 +0200
Message-ID: <87eciqlfjo.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: arpUlFzXjQ_vAQceKiJyNTmobZr65eX8xWWPSN_VGcU_1780309774
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Nothing in drm_atomic_helper_damage_merged() requires the old
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

