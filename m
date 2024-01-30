Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AD56B98
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603679; cv=none; b=E2bq1GtIH5pTjmo1WyQUVxUwHeR6qBN/fnmsVgSBzawg3Lp+LEYnFgY6wMfRunvRIgXcm3IL+QLB520JfdzPOcN5RtglIsaLtxt7uqNt+g39SXH0I3rEoZlAoIG6I7e4FggWDvtlYsWueRLMDUVtHlmYYQbbHp9jefonF3OtjF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603679; c=relaxed/simple;
	bh=QPi9hZzAmAQnGpjqKJGPTf9pYceX3vVYfjquOOScukk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3jVx5GkrRdC5GxBCDP7iqzzRWX8Mj6mc5qoXanqTl46WG/0J2R08/azOSGIqk81/HcGPIKIyS6MY1vjN6D1t87VeYKzJuQ/tg6Zox1exgRhiD++hYw+/VKbB1U+u0sR4uZjHK0FP1/+LhHNR3jYk+5KF9mwXOkzmnmZnLGZu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=f1keHoK0; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="f1keHoK0"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95BD8419CE
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 08:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95BD8419CE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.a=rsa-sha256 header.s=google header.b=f1keHoK0
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.998
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jJaUDJg-wDdx
	for <virtualization@lists.linux-foundation.org>;
	Tue, 30 Jan 2024 08:34:35 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E34F74033F
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 08:34:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E34F74033F
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-55f3e2ef98bso76038a12.0
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 00:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1706603672; x=1707208472; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8A/F0qjSBSUkCN1wUoX6X3MUwGOk7GLAJ8sdI6nLy84=;
        b=f1keHoK0aJFaPU4mNkso9d53N1x5beYXzCE20HCMkSn4zRIxMhe7QEMuAkTcnjy4b5
         Gj/MdYVq6Io0pAp/JJc+Ar24AFleTM3pF/WMkZYfgCTcKFVKB/CxRt7FAmkr5zzwT84t
         cqs+VIt6FJAtvzlJZ6Z4UGRxQpXwu8zeGjcls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706603672; x=1707208472;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8A/F0qjSBSUkCN1wUoX6X3MUwGOk7GLAJ8sdI6nLy84=;
        b=W+63XxPXnvJMydVuf/eD4efaWDTEO907MqEdX5BTLSiqDVsz2DmH8ejBuqsX+BkVHr
         AVUklPAMAb7gXSkYPHyvkL/aZloAfpYByHM48gQuyyN0vSPR9tkHLmqozyKv3FfzjZcw
         QGbR+EJOS5V4aNYutvsHyob++Jq3wT+U3SOsrndTo6X4Bu9Hb4oM/gA2ZWs2rsqAdatP
         xhnCh44jjXVDeGeZLsGBWxFFjXJftrxI+kVUarP/9gx2BI7ie7PtxtusVm3k6wiWKuDN
         jjdQWzcxv6fAGiCYu6x8UqoxTGI/MA/DOIZh+Mq0nYShlm6FpbzL72qbJJNdaGMc5q+P
         uo3Q==
X-Gm-Message-State: AOJu0YyVJ6b+wuok6/k1mT6e+h0V6xSueUEA4i77Yi41tVekEBguFB+r
	lSusuIc8Bap2GlhY6vXamwc7r9Gy/3hgrt+DyN/W7JEmrLvPKhycQxubcqqniVQ=
X-Google-Smtp-Source: AGHT+IFoBU0SlfO62YFQyBv5072jSKi3i4eibji92GBY7EfnrbEorrPEFCoLGaBtQ3uSEA6MKeKnRg==
X-Received: by 2002:a17:907:7d89:b0:a2c:4b28:90d5 with SMTP id oz9-20020a1709077d8900b00a2c4b2890d5mr7611829ejc.2.1706603672306;
        Tue, 30 Jan 2024 00:34:32 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id vx3-20020a170907a78300b00a363346802asm198856ejc.19.2024.01.30.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:34:31 -0800 (PST)
Date: Tue, 30 Jan 2024 09:34:29 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Message-ID: <Zbi0lQG15vz6iHJK@phenom.ffwll.local>
Mail-Followup-To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
	Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
 <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
 <20240126111827.70f8726c@collabora.com>
 <d467e5a4-6b61-4cad-8e38-c4495836a0d6@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d467e5a4-6b61-4cad-8e38-c4495836a0d6@collabora.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Fri, Jan 26, 2024 at 07:43:29PM +0300, Dmitry Osipenko wrote:
> On 1/26/24 13:18, Boris Brezillon wrote:
> > On Thu, 25 Jan 2024 18:24:04 +0100
> > Daniel Vetter <daniel@ffwll.ch> wrote:
> > 
> >> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
> >>> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
> >>> lock if pages_use_count is non-zero, leveraging from atomicity of the
> >>> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
> >>>
> >>> Acked-by: Maxime Ripard <mripard@kernel.org>
> >>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> >>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> >>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> ---
> >>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
> >>>  1 file changed, 15 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >>> index cacf0f8c42e2..1c032513abf1 100644
> >>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> >>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >>> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
> >>>  
> >>> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> >>> +{
> >>> +	int ret;  
> >>
> >> Just random drive-by comment: a might_lock annotation here might be good,
> >> or people could hit some really interesting bugs that are rather hard to
> >> reproduce ...
> > 
> > Actually, being able to acquire a ref in a dma-signalling path on an
> > object we know for sure already has refcount >= 1 (because we previously
> > acquired a ref in a path where dma_resv_lock() was allowed), was the
> > primary reason I suggested moving to this atomic-refcount approach.
> > 
> > In the meantime, drm_gpuvm has evolved in a way that allows me to not
> > take the ref in the dma-signalling path (the gpuvm_bo object now holds
> > the ref, and it's acquired/released outside the dma-signalling path).
> > 
> > Not saying we shouldn't add this might_lock(), but others might have
> > good reasons to have this function called in a path where locking
> > is not allowed.
> 
> For Panthor the might_lock indeed won't be a appropriate, thanks for
> reminding about it. I'll add explanatory comment to the code.

Hm these kind of tricks feel very dangerous to me. I think it would be
good to split up the two cases into two functions:

1. first one does only the atomic_inc and splats if the refcount is zero.
I think something in the name that denotes that we're incrementing a
borrowed pages reference would be good here, so like get_borrowed_pages
(there's not really a naming convention for these in the kernel).
Unfortunately no rust so we can't enforce that you provide the right kind
of borrowed reference at compile time.

2. second one has the might_lock.

This way you force callers to think what they're doing and ideally
document where the borrowed reference is from, and ideally document that
in the code. Otherwise we'll end up with way too much "works in testing,
but is a nice CVE" code :-/

Cheers, Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
