Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F7B1E7C15;
	Fri, 24 Jan 2025 22:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759528; cv=none; b=orguzzh3pC4+hubIgkxgkZqGYug4kPhj/cM2q/gsjsv8UPebtaB1O2VoVI+GNhtbbyxKRACQ7rh3vXMNSMtPUecjA7lDyDC46EofcwHPg8UrnVadzrbq7RT9Xl5psEtyNRmeEqMVaXB4xziu9+LPoF0VZLiQVcm4FTfUKrme7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759528; c=relaxed/simple;
	bh=/93Ha41Q21AAZHCv7BUfdQaIjWnvH30El2DSHtnFFp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVJ9uMzNlaOILHA8aI68ad88ozm9ySV09oXn2Btyc0pWMqMAH7tv9yst5VchbQZte2mBNlh0hD86JdugXBuUBX/QCMLDQgnDZJAqpDNYTSBILSMyvz4JPVoy57CmcQ165XfxqtkbSpRZjq3QumvdSQMKgKbmvBSz/MKyB58OnL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4cqhCQ2; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4cqhCQ2"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e399e904940so3874537276.2;
        Fri, 24 Jan 2025 14:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737759525; x=1738364325; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=01g7VfIvMNEOaWq6cCJdpppjwXYnS+hFYnb/xI342vU=;
        b=I4cqhCQ2DUmF9yhU7a0xJR9VojO1dPBh+z+H4K3TmNQb3ZnW7kbZ9VlMie5F0hO1+w
         NjRhBCCZpp+bnld0uNSRaBQF5akAlnit/Rkyagks6AsyjqLz5h7cDx7rq6XDuXBZH8Bf
         7TqHsOgb1dEt7FvdkimzN5vmv7FKX8LzAAFxgTa14uzyllVPgR5uuBYwz5vt73IsFWZ2
         +19nL48xMAneWAAncWLSHEGpvDlqXE5UbtxJVbPJuwl9n01TDfHx2pksK0Ub2rM8NziB
         nnwr4ji+KplNOA0uHHn+tI8MGtC4Nm91VOU9+OfhjYTAlMD95EbXSMUmnrwHfkAWT+6Q
         P1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737759525; x=1738364325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01g7VfIvMNEOaWq6cCJdpppjwXYnS+hFYnb/xI342vU=;
        b=pgDFozXokgldq0O9vUjATl1kq+BaV5ODlAC3r9NeniU+W6TyGzcWvnCbjsEg0V6CdP
         CgLk7kG+mannueRSKnCjh2hD8m8wIxfwywKfIUNXKQAf99R7LwS3skQYRrFo4NQqOUsD
         VmKuWm3jymFOVCN0cUSnsWPDUDfkII6LHcq01rYg4xDqh+HQAutl6SBaVqKSd3u6VJ54
         XrnTFq8cKMF3geFLyg9zB0vzqDkAWf6PA1fkf3jKXht1HVxjTAHrFF/ka0I1m1FNh0Zd
         jrEhCO26lE7WvHilcf7YrLI9AQ3bWtmfkTaJznJKNDjb6vHveyNZyjEtkRjMMoT85TiV
         fXoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOnp7pFHlM/IDe2blC+ukGlrGZF/eaN2bg67OVQnPcm3KQ7slozM/CiOv8GbqOBeFvUymoCNPHxArINNM7D3U=@lists.linux.dev, AJvYcCV1qV1GMC2oc9lt2dAzffmSU0HFl/XZNuEzBxgOE19Vh66MJH6nCVyKvgw4gvcXgcbas6LB7A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1eDFMhLqSmXLvXeIXnaC5hro8/9DAutkedHX4wlYprhHpwCpA
	IZ2AQiotxwOmHoBflxS00Bkodn8LILknGYB1HP6YdGaa9M33Y//5TTAuC4bABHxl0pNm39/H2X6
	kvXRpWMFUnguJo1I6qBnEIDSY83M=
X-Gm-Gg: ASbGncuw4OZ8UkVdE2p/4L8mHvqe/6uUrVPW+13bv+/hhxABqjnNd5jpSKfIS+C9UpC
	C66AujJmiLr7HhGA05SInxsBIcGgoeAYdBgvxBVb72F5IDm9vWa76bTXOfyuQF3M=
X-Google-Smtp-Source: AGHT+IEVBcD+CmGBESa7IU5MYg0rbfDjOSFuoXmzKfBgSK9QGJJWFRFyXFg6HVZ0R9P6cura5tbEBPVueLzrh4uh67A=
X-Received: by 2002:a05:6902:709:b0:e58:33d2:6a24 with SMTP id
 3f1490d57ef6-e5833d26bebmr7334673276.21.1737759525734; Fri, 24 Jan 2025
 14:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250124-virtgpu-mixed-page-size-v1-1-480403790bac@gmail.com> <a55eecdc-76cc-432e-a4b3-90e8753088ac@collabora.com>
In-Reply-To: <a55eecdc-76cc-432e-a4b3-90e8753088ac@collabora.com>
From: Sasha Finkelstein <fnkl.kernel@gmail.com>
Date: Fri, 24 Jan 2025 23:58:34 +0100
X-Gm-Features: AWEUYZloMhoMIJiSQa9eMVpuRbfncotGHx1micWWVWVbtUX-Bb2DTmadzJhTzP0
Message-ID: <CAMT+MTSHi26NduO4+2hc-CPwRXQ6qJ0=DwZq=4Tt1vNd7RKyvQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/virtio: Align host mapping request to maximum
 platform page size
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>, 
	Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 Jan 2025 at 23:52, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> > -     ret = drm_mm_insert_node(&vgdev->host_visible_mm, &vram->vram_node,
> > -                              bo->base.base.size);
> > +     ret = drm_mm_insert_node_generic(&vgdev->host_visible_mm, &vram->vram_node,
> > +                                      bo->base.base.size, MAX_PAGE_SIZE, 0, 0);
>
> This change only reserves extra space in the memory allocator, but
> doesn't change actual size of allocated BO. Instead, you likely need to
> replace all ALIGN(size, PAGE_SIZE) occurrences in the driver code with
> ALIGN(args->size, MAX_PAGE_SIZE)

This approach is good enough for my usecase, where the vmm can
cope with sub-page gpu allocations (by rounding up to full page),
but can't deal with non page aligned ones.
