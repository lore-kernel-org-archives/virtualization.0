Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EF21BDF4
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173631; cv=none; b=pqDe7xmTrfU56wEJIYonGjeEPPLof5OwLJ+TS3uO7iB0UIyhITZOUV/fjDsjPiHOi3i5lLqCMi+d+Vy3GpMLIDfZ7ZQIH90ATNKsDNXbgPMT9H7buqZzEeXlMLDGwD1UvhzgrqNrz35DIXBM+HCsJZ3XGHenDEBRdhE+oqq7pTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173631; c=relaxed/simple;
	bh=jmxwkZEbRI0XAx+cYJ9cpE0ROLMlbdLaVvy/jQgXN+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Up/XbglL4lybnNiS3P405w/TP8Hq2dbLV8KirsBtbIOoMN34jbpbFq1F/6/wf4mmR5d39dnNwELUQE3v6Af14pM/+MteX98aiQSDoMcrIE/S+VwYHkjGn8TjeM3hNRlDgEI6E+fKyIfTUY/rWLQC5lihNa93ZlYAke5T7E/87cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XJdgAyCR; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XJdgAyCR"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9EB583926
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:07:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A9EB583926
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XJdgAyCR
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CeSDtmx7RPU2
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 09:07:08 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3792C837C9
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 09:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3792C837C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706173625;
	bh=jmxwkZEbRI0XAx+cYJ9cpE0ROLMlbdLaVvy/jQgXN+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XJdgAyCRCGRT5DZYiJj70aIqs9zLKE3ws7azgqOUKukhW8MrG7e30kyqaQrg6pZ/J
	 SjlBmKORjFGH0UJk9kC//JPytCbBFzL4bp9od75RK2NDfH+7O005+UUqwet/hfBx+S
	 GsL/eKTgsKTtZOC/DDaCxr6OnY+lPxCWn6lkP0SzeJgFCbFlREWsJPN51u25R61ZCy
	 nRFY5YLfNHLWDu8KndWfMdqEiOdwYwFLMJsgtv9LHCknZt9ob0UrjHmMoLVdNaDYnP
	 wJ9b9gjuSaklo5rFWUUS8ZD1E4NFN8CCMD7EeZp5hR7adRcqPzlduZ7g57t0v4r9Dp
	 rKhAqRsiXmH2g==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 44F1437813C4;
	Thu, 25 Jan 2024 09:07:04 +0000 (UTC)
Date: Thu, 25 Jan 2024 10:07:03 +0100
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
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
Message-ID: <20240125100703.76d802ad@collabora.com>
In-Reply-To: <20240105184624.508603-23-dmitry.osipenko@collabora.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-23-dmitry.osipenko@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jan 2024 21:46:16 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

>   *
>   * This function Increases the use count and allocates the backing pages if
>   * use-count equals to zero.
> + *
> + * Note that this function doesn't pin pages in memory. If your driver
> + * uses drm-shmem shrinker, then it's free to relocate pages to swap.
> + * Getting pages only guarantees that pages are allocated, and not that
> + * pages reside in memory. In order to pin pages use drm_gem_shmem_pin().

I still find this explanation confusing, if pages are allocated, they
reside in memory. The only difference between drm_gem_shmem_get_pages()
and drm_gem_shmem_pin_pages() is that the former lets the system
reclaim the memory if the buffer is idle (no unsignalled fence attached
to the dma_resv).

We also need to describe the workflow for GEM validation (that's the
TTM term for the swapin process happening when a GPU job is submitted).

1. Prepare the GPU job and initialize its fence
2. Lock the GEM resv
3. Add the GPU job fence to the resv object
4. If the GEM is evicted
   a. call drm_gem_shmem_swapin_locked()
   b. get the new sgt with drm_gem_shmem_get_pages_sgt_locked()
   c. repopulate the MMU table (driver internals)
5. Unlock the GEM dma_resv
6. Submit the GPU job

With this sequence, the GEM pages are guaranteed to stay around until
the GPU job is finished.

>   */
>  int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
