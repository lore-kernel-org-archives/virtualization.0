Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3443F1655
	for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 12:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781784270; cv=none; b=oSjMT0x4sSXPBtbTyVAkyd/dUrgjlVJG9MzaI0SlLdYfmO+G7Gu6Q5yUcutbzYlEitPkKcR4uiSHHypUUq/DQcTYZtShxNNpreYC8V0hkwhxL/pyJBBGBqWo/1S6lsgDBrKFbtTulqyLx39WrEFkNSSC1xW8zyTHnCrCxUwUEAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781784270; c=relaxed/simple;
	bh=PGrulkOi4vbSdwFg2NTCNnI4GCxlVqTllhhY5hYd3EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fFk0UWEOWtFHzhb7K6H9Zc9zWGt7ZP22E6+3NDHWc2G9UXytzCBr87tTvfRnhi6jA6PBgIXmgdH+a/T/NlFiRY+mgXONWVjIlUjFriV/BCItgSCiuG0L/FI8k1hQ4YB1q9Nkq6FdmB+Q9xiYvjdhqGBktqY1KP0+JpcgHS+tr6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yfxy3/dQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yfxy3/dQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781784268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+pOZSqz1O2VTIqqvS3ojvh29ubyOWOZiXnKa/bsUbI=;
	b=Yfxy3/dQObvYweEHWYDTT3FaZBjv8W71KXhxiyGEl5DnkjmrZpWWmwaa/q7b2jTACXzwUX
	7K+Ai7BX2T4WjFkETQJmdJk4WCH3SI+Dx0oF+XN3aIpLzWLYJH3T890PVANS1TnQhhtp4T
	PK7KxnrkKMJM0FSH4ni+pFXo6CdPFFQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-7mIt5U-PPTefGf491gWlpw-1; Thu, 18 Jun 2026 08:04:24 -0400
X-MC-Unique: 7mIt5U-PPTefGf491gWlpw-1
X-Mimecast-MFC-AGG-ID: 7mIt5U-PPTefGf491gWlpw_1781784264
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c081f1976d2so27687766b.2
        for <virtualization@lists.linux.dev>; Thu, 18 Jun 2026 05:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781784264; x=1782389064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+pOZSqz1O2VTIqqvS3ojvh29ubyOWOZiXnKa/bsUbI=;
        b=nv9kr4bYhYEldp6arxYi7fnN5+RuoN+N83Awct+YWUrfj/cuMT4k8vwzYRwUIow7MC
         VzCShtoOyk3HJ73Nwv+5X3fbgjMICULaMOSFwGchIVqwJwlVXTLF7cafypT8tVvsnyi7
         GaLC634vNjMjSSWPk1OiC/Joy7zgZr1NHJU6meoJ7DtLbuB/BAElFgspHpENJtIyXbj1
         SrAvbrZ8u0/OrBOIolXsWP7g0E3K9FYQLF71VqoyYfFQ+YwqN5YFRkTwSzYMyPBg6FhW
         BTaKhYkokGJ2/DTp0hyINE4Eq8bD8X0u1fRktYAfziQFIftvcUhweW28JR5gWjipMxco
         9hWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/B2hUGfCU2/SWm6bLR20sBCX6ezieKeJu4R8LG4P1NSqnJOPR6ui1Xa2hJ3UHxF5T3aCG6P5ilVaXljrfLoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwUBC3o0QX0AJ4ij90Rid5IJFGYATvX1mhrb0aom1tePgblblE
	lKba3azHGs5RBUtbOooLxr9h9SmC3CP+9q7H2fK2378vSReQAdzZLIuROxXGmVtgU9Fb79qjclE
	jtA1fzrfai6YREMCn3LBncpuVCQFGvUX5+v2nlR6/Mt++FtHadebqkKlo2H59HFxVT98C
X-Gm-Gg: AfdE7clvx3mqBNHcarAcQRFMkU/T/X0tNzcPrQJKm1ZylwGxjqQwTOBRv+OKL5vIRm7
	edPEMsa91yP4ksww7tcbbkAqGLHwotF/tHqN5OonJ272Asn+7M9uHmfbeudShFYXER2RRgXXBRj
	2onnb2wUuoiaoZi+UUQduHa0Ey9lycOrbDPQ50Eb2V+X/ZgfOB4tUPrIdyZbbV8TfDXZ91q+K16
	ZWGh91/yeOhJ0xyG9tq9lAhZR+mFBQUEUBYiyrYSiZS1Oh3q2iGS7Z5/vcgGTdhb993CvJIxGeg
	wBA63803AK/zsdStd5F6LciVOdLR/3C7Io/bFXCRmiTmDAi9oyPUa9TFAersdsADbcsyzToUdyK
	patK/oSd96IBhQfGyVSUsIPtlMNBl4npB
X-Received: by 2002:a17:907:1c18:b0:bde:137a:45a8 with SMTP id a640c23a62f3a-c05a4e0e7ffmr561929566b.39.1781784263469;
        Thu, 18 Jun 2026 05:04:23 -0700 (PDT)
X-Received: by 2002:a17:907:1c18:b0:bde:137a:45a8 with SMTP id a640c23a62f3a-c05a4e0e7ffmr561923466b.39.1781784262837;
        Thu, 18 Jun 2026 05:04:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-461eaa0d1c7sm19541358f8f.7.2026.06.18.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 05:04:22 -0700 (PDT)
Date: Thu, 18 Jun 2026 08:04:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	rppt@kernel.org, ljs@kernel.org, akpm@linux-foundation.org,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tools: Fix tools/virtio test build
Message-ID: <20260618080405-mutt-send-email-mst@kernel.org>
References: <913D9291164C65D4+20260618095642.510565-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <913D9291164C65D4+20260618095642.510565-1-chenyichong@uniontech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 41OuFqIB-6lwpwfJhLEBniG3OyiSAnsnjZYOZpKijK8_1781784264
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2026 at 05:56:40PM +0800, Yichong Chen wrote:
> This series fixes build failures hit by:
> 
>   make -C tools/virtio test
> 
> Patch 1 adds tools/virtio compatibility definitions needed by
> recent virtio headers when building vhost_net_test.
> 
> Patch 2 makes tools/include/linux/overflow.h include stdint.h
> for SIZE_MAX, which is used by its size helper functions.
> 
> With the series applied, make -C tools/virtio test builds
> virtio_test, vringh_test and vhost_net_test successfully.
> 
> Yichong Chen (2):
>   tools/virtio: Add missing compat definitions for vhost_net_test
>   tools/include: Include stdint.h for SIZE_MAX in overflow.h


which commit is this on top of?

>  tools/include/linux/overflow.h       |  2 +
>  tools/virtio/linux/completion.h      |  9 +++++
>  tools/virtio/linux/device.h          |  1 +
>  tools/virtio/linux/dma-mapping.h     |  1 +
>  tools/virtio/linux/mod_devicetable.h | 14 +++++++
>  tools/virtio/linux/slab.h            |  4 ++
>  tools/virtio/linux/virtio_features.h | 56 ++++++++++++++++++++++++++++
>  7 files changed, 87 insertions(+)
>  create mode 100644 tools/virtio/linux/completion.h
>  create mode 100644 tools/virtio/linux/mod_devicetable.h
>  create mode 100644 tools/virtio/linux/virtio_features.h
> 
> -- 
> 2.51.0

