Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E451AA1D3
	for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113058; cv=none; b=OKdUba8yOIQKf7ijz60Jhj711jFNoNCx7WhSjJ0FqChCc/3+y8700gZXC0lVBZudUObK1V3hWryuMjK3PLduDoPcgwDMiCgu6v2xzpjzA/uRSSZBNiUsopv6w26+icU353oiJOxzR1KAK+/AB7Z56ayAouDoFaymRsmTtsL4Z2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113058; c=relaxed/simple;
	bh=HPhmvemy/H7PuCgN7J+9+iiaJBBtMf5EEORTvAdK7hc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKGgW1Bc2c2iAJYzU/Hsiq3/2+2kK36pjdBH/MxLmXO4tfXkoAHaqkKJ/z8NmXZtrrjHFs2cPAoG0U+eY1WLLYp72rZOcZH7QYymSjXNWmavgR44ATAl5rG5VLqels07Jqd8aQe3PfesQpR2GQTIBBEMYWTDxSQuyktTgvPzYqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dv4C6agT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv4C6agT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732113055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HPhmvemy/H7PuCgN7J+9+iiaJBBtMf5EEORTvAdK7hc=;
	b=dv4C6agTV54eyEsdkOrgbxG4KEZo0gRvyNnj/fBmbUoL1pHtsTSP7bhai4SZL2/4GhXhno
	krSgi03jXxjci45lrNNVn64LJ4XIrfjyON+FMgBwQO8BboHP+541a1l3Im//J0dPQLX68d
	5xZbD+28hixIDlvDjiVfCtZvVxKPZwU=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-DlmLj2ObOPyddkACiOAYrQ-1; Wed, 20 Nov 2024 09:30:53 -0500
X-MC-Unique: DlmLj2ObOPyddkACiOAYrQ-1
X-Mimecast-MFC-AGG-ID: DlmLj2ObOPyddkACiOAYrQ
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e9b1383da2so6499449a91.3
        for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 06:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732113052; x=1732717852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMaVfU9xtl9jCnZwV3bp7ALlJWztWPDTsfcs4kOcUr4=;
        b=D+rrK0LP9MKgCw8Yy0gqRJ8ME3Jbe9r3A6/UyYYdI+WlrGWt1qf03WBHpWN8xBcyVh
         qS4kilpr+rXHk5oitLfpNJeklumwwy08O9XA4yUmFcjzmGJQ4sRad0NR566BPK9DD8y8
         /rKW1/Q2AFosprSSn33GcpP68zi/f/UCOqZ3natEVhajHCuxpFZTnmZ3JEZiTWcFrZqc
         34OVvKs6yVXXbGWUKw4MdfNnvNLWfRKkWw4j/k/9YB+iCKRPVH/C648dANBRabh5SEUl
         ExrCcbevAHLj+EsTqDCMdAd8RBLNIbjKWZFP83dY0FOqFHeu8xagR+1JPL0qDTw8FNL8
         czDw==
X-Gm-Message-State: AOJu0Yw1nTXW1NZkRM2Q0S0N6iNs5TRBeIMplZkXjYxYiENCQZKGTF0u
	/u96UItwademHvrZUp5UL0jNjfVUE5NJf9g9y/wCOeOonGmm0dshKW2X3DS9Lok53dtcER2QHYE
	KtU8EiXgiaI3/uQKIZBemrSzZ8UVMCpNHc0G7STS8M4Ofh2Q1mUF4TWc0d7S9f/WN
X-Received: by 2002:a17:90b:3881:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2eaca6fdca2mr3531597a91.15.1732113051809;
        Wed, 20 Nov 2024 06:30:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECdkxl+S+2db1pctE3VVYMcpzPK6h3n3Y5C+YW4i4MDyKHmQUKlg5WY2488lvUjDv3+OYg8g==
X-Received: by 2002:a17:90b:3881:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2eaca6fdca2mr3531540a91.15.1732113051300;
        Wed, 20 Nov 2024 06:30:51 -0800 (PST)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02eca46sm1348721a91.7.2024.11.20.06.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 06:30:50 -0800 (PST)
Message-ID: <67f6b7e9ff32593bf66f72ff1269458c3733ecae.camel@redhat.com>
Subject: Re: [PATCH] drm/bochs: Replace deprecated PCI implicit devres
From: Philipp Stanner <pstanner@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 20 Nov 2024 15:30:40 +0100
In-Reply-To: <20241017125145.34729-2-pstanner@redhat.com>
References: <20241017125145.34729-2-pstanner@redhat.com>
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GBBP8clNGsNEGrluugnu8xDpIk6RMirQfoKno7pIiGU_1732113052
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2024-10-17 at 14:51 +0200, Philipp Stanner wrote:
> bochs uses pcim_enable_device(), which causes pci_request_region() to
> implicitly set up devres callbacks which will release the region on
> driver detach. Despite this, the driver calls pci_release_regions()
> manually on driver teardown.
>=20
> Implicit devres has been deprecated in PCI in commit 81fcf28e74a3
> ("PCI:
> Document hybrid devres hazards").
>=20
> Replace the calls to pci_request_region() with ones to always-managed
> pcim_request_region(). Remove the unnecessary call to
> pci_release_regions().

Just saw that this patch is still floating around. Anyone feeling
responsible for bochs who could review this?


P.


>=20
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> =C2=A0drivers/gpu/drm/tiny/bochs.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tiny/bochs.c
> b/drivers/gpu/drm/tiny/bochs.c
> index 31fc5d839e10..888f12a67470 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -217,7 +217,7 @@ static int bochs_hw_init(struct drm_device *dev)
> =C2=A0
> =C2=A0=09if (pdev->resource[2].flags & IORESOURCE_MEM) {
> =C2=A0=09=09/* mmio bar with vga and bochs registers present */
> -=09=09if (pci_request_region(pdev, 2, "bochs-drm") !=3D 0) {
> +=09=09if (pcim_request_region(pdev, 2, "bochs-drm") !=3D 0)
> {
> =C2=A0=09=09=09DRM_ERROR("Cannot request mmio region\n");
> =C2=A0=09=09=09return -EBUSY;
> =C2=A0=09=09}
> @@ -258,7 +258,7 @@ static int bochs_hw_init(struct drm_device *dev)
> =C2=A0=09=09size =3D min(size, mem);
> =C2=A0=09}
> =C2=A0
> -=09if (pci_request_region(pdev, 0, "bochs-drm") !=3D 0)
> +=09if (pcim_request_region(pdev, 0, "bochs-drm") !=3D 0)
> =C2=A0=09=09DRM_WARN("Cannot request framebuffer, boot fb still
> active?\n");
> =C2=A0
> =C2=A0=09bochs->fb_map =3D ioremap(addr, size);
> @@ -302,7 +302,7 @@ static void bochs_hw_fini(struct drm_device *dev)
> =C2=A0=09=09release_region(VBE_DISPI_IOPORT_INDEX, 2);
> =C2=A0=09if (bochs->fb_map)
> =C2=A0=09=09iounmap(bochs->fb_map);
> -=09pci_release_regions(to_pci_dev(dev->dev));
> +
> =C2=A0=09drm_edid_free(bochs->drm_edid);
> =C2=A0}
> =C2=A0

