Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA2394794
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309354; cv=none; b=Fsez+/1Wh4Sr3lG6ohcdMsKT9CypXOd8QLk3/iprSEHlGd17iuhtA0fSWrAdU//DuMDucw8AC0b22NuWszi+uuy5ARawWmUTI1PnB8hQrGbi1qZRqizTEa+vuUIcPBKOGtBdUoru2MUXt2fh4qkxDTF1iUobngh8fFCOXD4q7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309354; c=relaxed/simple;
	bh=NRFqPa3kJwcSLBJ2wEeOqlBygR75BmmbNgByz+aBuPw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DrOWsBlWQYHjgCh/y5RZ/1q3LCc+Ycp10ZMNY9pa7yd3jeNKdZFPrOz2I/D4yejDAbpIlWSIGQ4rQT5CYgBhZSDJwWAAglAWeKlwLVxm10kcxXyhnqaqZY8M155zOuY1pDQEZ3RtXvJUidUaj1d96sxFxraXEcLnf7JCKsZ0pUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSYLxoKp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSYLxoKp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780309350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UYSWdrjn4aqQxQd0Cf2jKHSTVgv+zTIrZalUlPmgVOc=;
	b=bSYLxoKp47E/g20dYXnk/KBmPiuD6kuB5VYYgv+lSrlfAcJufofpMPzqNqUHTfJxbdmZAH
	KutMBC3O03ezR9Utbf4TaUBKJ5rwz+KwBAh/8oDHd8TifhZoP//XGpbMKguBCqFzpsILdX
	T1f0OK5k2WlEs2K4Q350Ftz4G5MjC+w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-F50YjxT-MNu_jCoEUe9UWQ-1; Mon, 01 Jun 2026 06:22:27 -0400
X-MC-Unique: F50YjxT-MNu_jCoEUe9UWQ-1
X-Mimecast-MFC-AGG-ID: F50YjxT-MNu_jCoEUe9UWQ_1780309347
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490af284fd8so1141615e9.3
        for <virtualization@lists.linux.dev>; Mon, 01 Jun 2026 03:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309346; x=1780914146;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYSWdrjn4aqQxQd0Cf2jKHSTVgv+zTIrZalUlPmgVOc=;
        b=ILgD5niK/WQWm2Z2BzOGOPVmLprh14a/rVrtWah9ygR38rAoAGDnAwVt8KXQhsHkhO
         BjQqldGGYGXKyh2F/md/JC0njj2kkDUvxM229kTfwIePP6OXWgv8xjjHQ9QcGDTIg0NT
         80L7U+d4xV2xYTG7OWx5cfX6acpOcKRnLuy41ixa+VLMHV1E8/YuYcO8fdzigd0LdFlI
         18pLHh9KISfnRErn/+VVGk5PDZM8d4NXTJow4JPybVhuQKyyIiADyCzBNkb8f6TopKBo
         KNsGXy6uDjGesDUAucB9yi2ilSrRBL8HtVB5aoTLXeYldCcqXZphX8rfp2PCkHNQ1Ixy
         IncQ==
X-Forwarded-Encrypted: i=1; AFNElJ8zPxEwFECv/k2KFwUx3v0XqkI5Hu3YSTgI97FsfrdHlNOg5RAyQ8rj2nY2y2HU1CBS14OnsePPsZq9EYiQMw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyaq7QJJmm7JNBfrYOcd47ZofrOClFyHGpxek88L1fST85eG7p/
	ADXe2KNcEhEdeAf3Qy9q/QT3cxTokHZvBAqom3c0R0+Razc58eaZ4YlNEIppSdZ1sCWeU7gDGhI
	ZLmBZzABtOKcJ6I8aCizxM8EUFjsVHE8/YXfbUyek+rI+IJqiAhsHya1DhEQU28LRexk6
X-Gm-Gg: Acq92OETUczPs8ca+rQ5mF3TwS4bTeGcXz8HF/J+Ykdjhl/gN9dqwagM554paZ+Izo5
	F//WLC8248i1I2adY3waCrvHQKNkBy1oZxU7G8+xyHMQ/0A7Hb7iTEhF95pYGGvNXXq9bqSQMTl
	rt8QmcKyfQbwNTnMEeFBgTBMJxxqWvqq9cq20CAGmOBWqi/TzummkA7Exb/OCh+n4eLEeLOyIM4
	VU4uNJWKRv5lBBc3ZO/qRRW3Mm8JrpgePN1BTQzXPKJomRwfesogawB4ojjO1JYj/JerKw1Py2z
	eI6OGgd40VIDNG7ypyfq3txp9JQDbUcsnCMJKatUxThlte7F6If5C7h6MJ1tTt/Ihy/3ly5eG1A
	CyTNWxIWWolUiqetPki3lbhy6Qsq4Ws3IxjQv92bZyBJzlxPFgV2xVMMsTvJqR/VGsolCdX+mBo
	uic4+X0Z/0MAEmmgE=
X-Received: by 2002:a05:600d:848c:10b0:490:a1a9:4ffe with SMTP id 5b1f17b1804b1-490a291197bmr137427805e9.12.1780309346515;
        Mon, 01 Jun 2026 03:22:26 -0700 (PDT)
X-Received: by 2002:a05:600d:848c:10b0:490:a1a9:4ffe with SMTP id 5b1f17b1804b1-490a291197bmr137427265e9.12.1780309346037;
        Mon, 01 Jun 2026 03:22:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490aaebf4f1sm74962075e9.12.2026.06.01.03.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 03:22:25 -0700 (PDT)
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
Subject: Re: [PATCH v4 05/10] drm/atomic_helper: Do not evaluate plane
 damage before atomic_check
In-Reply-To: <20260530185716.65688-6-tzimmermann@suse.de>
References: <20260530185716.65688-1-tzimmermann@suse.de>
 <20260530185716.65688-6-tzimmermann@suse.de>
Date: Mon, 01 Jun 2026 12:22:24 +0200
Message-ID: <87mrxelfvj.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IqGwIPoo9SBfAcuIcahn0bD79j37w2BVaNirMSfSeDE_1780309347
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Remove the call to drm_atomic_helper_check_plane_damage() from before
> calling the atomic_check helpers. The call has no longer any purpose,
> as the actual evaluation happens after running atomic_check.
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

