Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40613C9A6
	for <virtualization@lists.linux.dev>; Fri,  4 Oct 2024 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029615; cv=none; b=ok9iZwO7OGmcxwYgqSxr0ypt5kMfm+mGIFN8+rPQMhZLgk3Xk+jlvq3I8mdnttBI8hYdtb1dyK3/H82x4QbBuJmsbrigwJP0rLGQIIdp0stUNcgj/YJUAGB6HqQHppKPgeb0YzXr9N6jxi01675O4vYL9SNBKKXzjyMDh7MXq2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029615; c=relaxed/simple;
	bh=E/PEMchp08iifpW6j1+EEBnfAdnnGwBHV2UTDOpXHCM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=smxRmK6Cot/EkPj0sgvtjjEtaHpWQkPmSCjYMaHCr0M4DQMVyG4fGJcyatX4mpuq++16Lqplg/RAlr9f/tVpceR/FIwGgjNQcdhDV8oTVwmUFNvC4Zf9ba8F3+AW5iZtpRaqvnA7Mtuo+nAqSRVxKdsG7pa4uE92WjP0Suv/qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zmzu3w50; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zmzu3w50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728029612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NpYh7CaaC2KedHFZZYXaVZ0k0qPF+A1BsqzYj4Bl5RY=;
	b=Zmzu3w50zqWhshRlzvNJcVC7U3UuIYieMgTp9jFTVGzve8cAn4RRG/PPeHtuiCn+6EFcOD
	eBzHxTKEs0Gu4/kpAygItjHwCVzceEj0rbowCy9VClgUwVsXijxyUBoPWiRflWa6QW1Lop
	ZQQ9eJtQsc/ccxzK1mnJlbGyCm4R1v8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-tzILE8ZeNTmipYb8oiUrkg-1; Fri, 04 Oct 2024 04:13:31 -0400
X-MC-Unique: tzILE8ZeNTmipYb8oiUrkg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-6e2317d1cb7so30052127b3.3
        for <virtualization@lists.linux.dev>; Fri, 04 Oct 2024 01:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728029611; x=1728634411;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NpYh7CaaC2KedHFZZYXaVZ0k0qPF+A1BsqzYj4Bl5RY=;
        b=D1GIo2U7UcvrN1Q0xQjKC7wpsh8w4/bEut+k1of22rfzXOrh7QU5w1OXcWm315RUPs
         gAIJxFIEVFEBWEpDbLnO7Y6haU+7bdANrNCn2/laTLTRlPueUxpdbjdl05PMexmRH0aq
         3aeMX0sUe45iSmPsgeEge+F1OLmthU4Gfs5I2VCtIj5dJaKdKyOLQyXjAt8kL3x+VSln
         zmmAZA2cgdYV/WpNnvsKM/Q+iA75YYqNkizujsb7iEaCbyj7XsDbHXFv9RrEcNvoIWIa
         rU2oVz8WAO7m3uCwDmLp6qdXZVjMrFJyCwWVfyiizi12u2cppX0QVRZiDmFb5Ek9sFK4
         Untg==
X-Gm-Message-State: AOJu0YyjdAhxUU/T+OI/iPXbHm9SNXmechUVTtuW1/eqrv+8v2Y98oLq
	x8XCihS0oAaz9ekCAhLGOCszDoxsSoyfpDFt94dgdMK/v5swoazT8eteMtBsZlfgOeeXkmCIcFV
	V6TdRmO8TePIlWmjQtpXeNwt5533V8ViocQnqagRR8Sz71Vj2IXUBt57CqbfHFXL/
X-Received: by 2002:a05:6902:2507:b0:e26:1190:8fe0 with SMTP id 3f1490d57ef6-e28936d5653mr1267259276.17.1728029611217;
        Fri, 04 Oct 2024 01:13:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK5NlqbQGEp0Ckx0DC5l7AAujsY01ZLTLP3SLW77axNkOTOrjPPpu8ShJ+Oi/XIM1S/ke/HA==
X-Received: by 2002:a05:6902:2507:b0:e26:1190:8fe0 with SMTP id 3f1490d57ef6-e28936d5653mr1267251276.17.1728029610859;
        Fri, 04 Oct 2024 01:13:30 -0700 (PDT)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae6b3dae76sm116919385a.113.2024.10.04.01.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 01:13:30 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, kraxel@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Kees Bakker <kees@ijzerbout.nl>
Subject: Re: [PATCH] drm/bochs: Return error from correct pointer
In-Reply-To: <20241004075404.41743-1-tzimmermann@suse.de>
References: <20241004075404.41743-1-tzimmermann@suse.de>
Date: Fri, 04 Oct 2024 10:13:27 +0200
Message-ID: <8734lcnv4o.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> In probe, return the error code from the variable bochs, not dev. The
> variable dev has not been initialized at this point. In the case of an
> allocation error, the returned value would have been undefined.
>
> Reported-by: Kees Bakker <kees@ijzerbout.nl>
> Closes: https://lore.kernel.org/dri-devel/8c5bfc12-cbcc-4102-9826-494060df4179@ijzerbout.nl/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 04826f588682 ("drm/bochs: Allocate DRM device in struct bochs_device")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: virtualization@lists.linux.dev
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

