Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE926087E
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609441; cv=none; b=WbQqAOuCPs7kFAYZBMV9Cd5PvWu6g7toig6xy/y847A/LIFexuf96UsmaWXnKvtmzZWPrtJUNo0xwVpBzV5LbOlK8Bq5zDlyZTAxqPb9RiQT2AK34iXffs3NhOiWiPtDDUBgU9lbR8LgxkYNDC5DL19prUBmDDFcL+dTzQLPF8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609441; c=relaxed/simple;
	bh=pvTVYZQvoWE9TYRSfVKQhlX6lvtPW1b9pCFx1Xl/zbk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TOAR1WMloGc1N74A0pysIHKAaFGFyvopryjBajEnZB1OSQKqJ+y9lrU1w0U4xATsCvdIsEjvrw7z5WST2IAfEmCmDLLwXlM1wViuM6YIx/EDiiWZNThXxe3oEWT9F5bbaWpz9Tx4bXm+/Qh/pSfo0ZL3aZbpPgadN9sxlZPBaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Bwt9Vxx7; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bwt9Vxx7"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 310A241B23
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 10:10:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 310A241B23
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=Bwt9Vxx7
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v-MB5rnpqszu
	for <virtualization@lists.linux-foundation.org>;
	Tue, 30 Jan 2024 10:10:38 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 610EF41B1B
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jan 2024 10:10:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 610EF41B1B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706609436;
	bh=pvTVYZQvoWE9TYRSfVKQhlX6lvtPW1b9pCFx1Xl/zbk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bwt9Vxx7XAVrOtbWrBb7G+/IYQ+vog5Ze2jE+wOBgZQqlI16QYW4m05otZWBw0KP4
	 Ttk7ggDeV4kKwQo5xwNFYvHFY/3i6ODDbOIHxDzOi8W2QiQmK1q9k+iApJq8PHTvac
	 paw++6waKYNiQP3WNaq4FUI8O5zXgRcDvaBsLSH/hbPV4QLmTNLK8Mu0kim5lw1ogQ
	 5iSnDI2LlwRH6mzYyj6nAUfwWwgtAsgO9EOmtyUnFRUqThSQR/uPEqfYh6BCtbgxGn
	 JfUXMxjE+RcNb2GlDKzpPHOpQK+fA3NnZx7GfJE/yPO2xRdzDq1hx5PqnHWTAaZ9HQ
	 /DExCDuRUIJIA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4F68D3782079;
	Tue, 30 Jan 2024 10:10:35 +0000 (UTC)
Date: Tue, 30 Jan 2024 11:10:33 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>, David Airlie
 <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>, Qiang Yu
 <yuq825@gmail.com>, Steven Price <steven.price@arm.com>, Emma Anholt
 <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Message-ID: <20240130111033.5c01054b@collabora.com>
In-Reply-To: <Zbi0lQG15vz6iHJK@phenom.ffwll.local>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
	<20240105184624.508603-10-dmitry.osipenko@collabora.com>
	<ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
	<20240126111827.70f8726c@collabora.com>
	<d467e5a4-6b61-4cad-8e38-c4495836a0d6@collabora.com>
	<Zbi0lQG15vz6iHJK@phenom.ffwll.local>
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

On Tue, 30 Jan 2024 09:34:29 +0100
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Fri, Jan 26, 2024 at 07:43:29PM +0300, Dmitry Osipenko wrote:
> > On 1/26/24 13:18, Boris Brezillon wrote:  
> > > On Thu, 25 Jan 2024 18:24:04 +0100
> > > Daniel Vetter <daniel@ffwll.ch> wrote:
> > >   
> > >> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:  
> > >>> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
> > >>> lock if pages_use_count is non-zero, leveraging from atomicity of the
> > >>> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
> > >>>
> > >>> Acked-by: Maxime Ripard <mripard@kernel.org>
> > >>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > >>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> > >>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > >>> ---
> > >>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
> > >>>  1 file changed, 15 insertions(+), 4 deletions(-)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > >>> index cacf0f8c42e2..1c032513abf1 100644
> > >>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> > >>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> > >>> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
> > >>>  }
> > >>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
> > >>>  
> > >>> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
> > >>> +{
> > >>> +	int ret;    
> > >>
> > >> Just random drive-by comment: a might_lock annotation here might be good,
> > >> or people could hit some really interesting bugs that are rather hard to
> > >> reproduce ...  
> > > 
> > > Actually, being able to acquire a ref in a dma-signalling path on an
> > > object we know for sure already has refcount >= 1 (because we previously
> > > acquired a ref in a path where dma_resv_lock() was allowed), was the
> > > primary reason I suggested moving to this atomic-refcount approach.
> > > 
> > > In the meantime, drm_gpuvm has evolved in a way that allows me to not
> > > take the ref in the dma-signalling path (the gpuvm_bo object now holds
> > > the ref, and it's acquired/released outside the dma-signalling path).
> > > 
> > > Not saying we shouldn't add this might_lock(), but others might have
> > > good reasons to have this function called in a path where locking
> > > is not allowed.  
> > 
> > For Panthor the might_lock indeed won't be a appropriate, thanks for
> > reminding about it. I'll add explanatory comment to the code.  
> 
> Hm these kind of tricks feel very dangerous to me. I think it would be
> good to split up the two cases into two functions:
> 
> 1. first one does only the atomic_inc and splats if the refcount is zero.
> I think something in the name that denotes that we're incrementing a
> borrowed pages reference would be good here, so like get_borrowed_pages
> (there's not really a naming convention for these in the kernel).
> Unfortunately no rust so we can't enforce that you provide the right kind
> of borrowed reference at compile time.

Yeah, I also considered adding a dedicated function for that use case
at some point, instead of abusing get_pages(). Given I no longer need
it, we can probably add this might_lock() and defer the addition of this
get_borrowed_pages() helper until someone actually needs it.

> 
> 2. second one has the might_lock.
> 
> This way you force callers to think what they're doing and ideally
> document where the borrowed reference is from, and ideally document that
> in the code. Otherwise we'll end up with way too much "works in testing,
> but is a nice CVE" code :-/

Totally agree with you on that point.
