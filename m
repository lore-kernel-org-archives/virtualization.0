Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358541D6A1
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cXWnvuH2"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3EAD405B7
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 09:08:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A3EAD405B7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=cXWnvuH2
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B53Eb6Yz_IuU
	for <virtualization@lists.linux-foundation.org>;
	Thu, 23 Nov 2023 09:08:36 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B96A94049C
	for <virtualization@lists.linux-foundation.org>; Thu, 23 Nov 2023 09:08:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B96A94049C
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id B73B86607377;
	Thu, 23 Nov 2023 09:08:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700730513;
	bh=BIHodNmsBiGjHqmmU2/SA/mIIzueNfft8YCTcpkLTgU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cXWnvuH2n9K2VzAsDkgwZW6+wVffZIAgGJPyIyl4iY6CA5ZEZLHdwnS/E6UzU/ju/
	 6sFmHXVuEb31W1jwWXksIzQLoYFfRv5f+C9VqCUvh4hHs/AZf7/YBEIZPEncVEN3uV
	 AAUO/q2UlgCcyEGw8444Agt0CLXNfeSqHhLXgCSO1UjWM5WO8WlwOtE8198AbDX7p4
	 Re1gN18WWsPBREhAUxkQsHRq0d6yA44PpLx6quYZ9Slpi6z8fMl8cD6NQXUptuRocp
	 +2QKYnE3GWBCIfi+hn1a6kzP4jNGhfhuBftAnL+HXKzlQofFiGrSRQx2q11hHncSwp
	 GR6eTwumf6icQ==
Date: Thu, 23 Nov 2023 10:08:29 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Qiang Yu <yuq825@gmail.com>, Steven Price
 <steven.price@arm.com>, Emma Anholt <emma@anholt.net>, Melissa Wen
 <mwen@igalia.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v18 22/26] drm/shmem-helper: Don't free refcounted GEM
Message-ID: <20231123100829.2e4addd0@collabora.com>
In-Reply-To: <2faf1111-9646-21e3-feb3-f59c955bc719@collabora.com>
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
	<20231029230205.93277-23-dmitry.osipenko@collabora.com>
	<20231113105438.60896fdf@collabora.com>
	<2faf1111-9646-21e3-feb3-f59c955bc719@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Nov 2023 01:30:24 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 11/13/23 12:54, Boris Brezillon wrote:
> > On Mon, 30 Oct 2023 02:02:01 +0300
> > Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> >   
> >> Don't free refcounted shmem object to prevent use-after-free bug that
> >> is worse than a memory leak.
> >>
> >> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >> ---
> >>  drivers/gpu/drm/drm_gem_shmem_helper.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> index 6dd087f19ea3..4253c367dc07 100644
> >> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> >> @@ -203,9 +203,10 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
> >>  	if (obj->import_attach)
> >>  		drm_prime_gem_destroy(obj, shmem->sgt);
> >>  
> >> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
> >> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count));
> >> -	drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count));
> >> +	if (drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count)) ||
> >> +	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_use_count)) ||
> >> +	    drm_WARN_ON(obj->dev, refcount_read(&shmem->pages_pin_count)))
> >> +		return;  
> > 
> > I guess you're worried about ->sgt being referenced by the driver after
> > the GEM is destroyed. If we assume drivers don't cache the sgt and
> > always call get_pages_sgt() when they need it that shouldn't be an
> > issue. What we really don't want to release is the pages themselves,
> > but the GPU MMU might still have active mappings pointing to these
> > pages.
> > 
> > In any case, I'm not against leaking the GEM object when any of these
> > counters are not zero, but can we at least have a comment in the
> > code explaining why we're doing that, so people don't have to go look
> > at the git history to figure it out.  
> 
> This patch is a minor improvement, it doesn't address any specific
> issue. This should be a common pattern in kernel. If you're giving a
> warning and know about the inevitable catastrophe, then avoid it if you can.

Sure, I'm just asking that we add a comment to explain why we leak
memory here. Is that too much to ask?
