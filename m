Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A51332A1
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 15:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083148; cv=none; b=Ii7Ypc/mJNWVpo4xL5GR2vHqFE62t1vBCDhk5ofqqgVKM6ggibRxntPL+3fjq1XOdvLQB1xaeWsQrWqTO2qFtMGxIeM9Z62W2ddLZMwNKO9CU5o7frqGVguTBlSJmw3M9c4rpBZVNEIVmXEAkikIYZf1Fq5K3bS6emlnZfYMQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083148; c=relaxed/simple;
	bh=LABYyFBeV0mjcyzGLhWHOx/KnOxrelvD3raugbPJlCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ogEIh2izRWDbMXXjxFkYQe6I1+dIR3JbAHCKBtI8tni6IrZvPJ8BTxjk6/juT6pcJRm/wLHxCB7o39VtigeONwFuWfxG5H44CpZMUHZe4vN0pqpNAqxugtI//pIfor7Ol8hhjCktEr0lj/kTTo27ne/MeO4CczoWYgrcMOYAwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dVDkbnsK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dVDkbnsK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724083145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+lBBukJN6JiKBp75v/VlDPyHSmNFKIveb2GLDvy/Rr8=;
	b=dVDkbnsKAryTZhq41VeLUTsk19VEITPlwGi1zTGYtdcBCTu9afljOfytg8uNJgKJjfQq6f
	Z9Fx6nu6WBg7OGQBWWaeGW5dHOVD+Tt4U+0nsPXkxOTdUL05RgS3pQU6s1y05sCojvikCt
	MD0DUrb5l5nhhOYEnxlqDsqJA6JtRig=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-X1W9sNcMO1S40e5hfnm9gw-1; Mon, 19 Aug 2024 11:59:03 -0400
X-MC-Unique: X1W9sNcMO1S40e5hfnm9gw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-201f464e3e8so37038945ad.3
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 08:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724083142; x=1724687942;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+lBBukJN6JiKBp75v/VlDPyHSmNFKIveb2GLDvy/Rr8=;
        b=XgFFbW+nE+nIlM5bPjjbJ+x7tKRpG7SORT+vNH7i+L/IjkG5kD8yhf7EXtV5BW+oty
         g8a9/NerHoN/4CyxINeevFKsy44VXculVCB/4D3Y/0BZf3mXTFXvpmdLoE7qhK4876ae
         YuvMdxWOmBJMcmOKw3hV0vrJ+txMoemQxak4QNuUZiYDFLXZKq6JlBbIrzUhX9jfBKJ3
         spqCraHq7yWbz/gV0hrY56WoQvIiv/QOwawsYvKsOcSFluawqvM/Z3xexGYY29o/4+GL
         bIktdi8kSZQMvvanTc71jAtB4H6pNCpbN8smb0I4OMZBJ854pK+HV5k6rSziiAGaA76m
         /UHA==
X-Forwarded-Encrypted: i=1; AJvYcCWifzvB/gUgAWUmELCsRzC0Lx+/45lGg6bbrvNwngZCajhx9UKIMsgqhq9WyPx6PASpRgha2ZECJs4pUjfKbJnA98DU61mS/lr+318pBSY=
X-Gm-Message-State: AOJu0YxpHY5aCqGRnlRB1fP9beJID6LPTmiIBPEgpIAToN3CvCanAAR3
	K31c2ElP3gyvM3AV1EGKmwqB0CJIUt9el+1molkOcqZEi5BLWAFNg43lDsURvXHMNSU7PKbo4h3
	7WptI+JJti6iH9uQmKHWT/DVPhqQ8Uv498kQUonfNOq7PR54sF1JlbXHbBbE3tZGE
X-Received: by 2002:a17:902:ea10:b0:1fd:a7a7:20b7 with SMTP id d9443c01a7336-202195eb41fmr96419755ad.30.1724083142372;
        Mon, 19 Aug 2024 08:59:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH//CoKy62gMwxSVl4ocYAobc0CKDnBpRj2m0lVJBGbDwWstmLXSyJQhOGDJbjskItoR3YtOA==
X-Received: by 2002:a17:902:ea10:b0:1fd:a7a7:20b7 with SMTP id d9443c01a7336-202195eb41fmr96419535ad.30.1724083142023;
        Mon, 19 Aug 2024 08:59:02 -0700 (PDT)
Received: from localhost ([181.120.144.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f037560bsm64074435ad.148.2024.08.19.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:59:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, David Airlie
 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Daniel
 Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: Re: [PATCH] drm/virtio: Use XRGB8888 also for big endian systems
In-Reply-To: <20240816131310.1008205-1-jfalempe@redhat.com>
References: <20240816131310.1008205-1-jfalempe@redhat.com>
Date: Mon, 19 Aug 2024 17:58:58 +0200
Message-ID: <874j7gld19.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

Helo Jocelyn,

AFAICT your patch is doing two things:

> Mesa doesn't support BGRX8888, that means most wayland compositors
> doesn't work on big endian guests.
>

1) Dropping the BGR{A,X}8888 support.

> Also the colors are inverted when testing a s390x VM on a s390x host.
> So I fixed the DRM_FORMAT -> VIRTIO_GPU_FORMAT on big endian guests.
> It may break big-endian guest on little-endian host, but then the
> fix should be in qemu, because we don't know the host endianess in
> the guest VM.
>

2) Fix the format translation to take into account the guest endianess.

Maybe is better to split the changes in two separate patches ?

> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

The patch makes sense to me though from your explanations.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

