Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242F1DFC5
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 16:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706287418; cv=none; b=SeBsxgFKBwesESnTw+KmPKqCB+Ea72Y579RPtmJYwedMKPQZYj6zNzd2evaAfOACV4SFmcAFWUQnr3NS4KgcnXrubj1DuLtfqqoezv+1KE7a0lmcVb/8nY0kSe0qyWVh5AEFCyvBNKKlxn8b5MLD9EA59OjrBIdI1YlnArQPao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706287418; c=relaxed/simple;
	bh=U6u3xgf4R+utqvmtwCD7pg1WXxuAovEW7noxe87GDmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QfgwdFoXCU6qIHw39b+qKlDVuGjkNnOsPPAxP7jrhGTdTQ2KKzAtbQMnTPzWdVMT9nFaZ7qCXepzm245QXZ0gLT8LrjwYJAqAO9dHbqroaXZxLM6/U1Zl0y/PINGsYgNzs3JQ/i2loGNHpTTcqqrWi0J6CiYopuU7BWu+kJuVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KeswJROh; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KeswJROh"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 446704092A
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 16:43:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 446704092A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KeswJROh
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wj0aFtAi5pES
	for <virtualization@lists.linux-foundation.org>;
	Fri, 26 Jan 2024 16:43:35 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 69DC640929
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 16:43:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 69DC640929
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706287413;
	bh=U6u3xgf4R+utqvmtwCD7pg1WXxuAovEW7noxe87GDmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KeswJROhwGGRCE5tdZ1RC8zLadqOPmPE3UK2Yj5P5hgbG7FBPfNCxYkwMYNE+SKwd
	 DX6GBQiHWaaIhiby6QrQjjW1qb01imlJGar0H58w0ZXPj4Ig74w7iN/dBhp+rCJMfp
	 U1x8qHsm+S8XWiZe2bhGxGBqyOwVSlqtEjRf6THeYOgu8ceW/2h9FNH4SNQSYPgC2Q
	 vCcyVSZzLEGNQ9Kz0Z1aRA19OxbfqZAcasBM+kXiB2wYcSGMwQcTvSXkvwS+pTKH1R
	 Iove7Or8j6Dtwzb+a5PJc70/zZs8HnXriVfNq36SpeachhYK8w6V4KaLxjrNApzXXy
	 7oqzT/l5MaLNA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0146F378201D;
	Fri, 26 Jan 2024 16:43:31 +0000 (UTC)
Message-ID: <d467e5a4-6b61-4cad-8e38-c4495836a0d6@collabora.com>
Date: Fri, 26 Jan 2024 19:43:29 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 09/30] drm/shmem-helper: Add and use lockless
 drm_gem_shmem_get_pages()
Content-Language: en-US
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
 <ZbKZNCbZoV4ovWTH@phenom.ffwll.local> <20240126111827.70f8726c@collabora.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240126111827.70f8726c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 13:18, Boris Brezillon wrote:
> On Thu, 25 Jan 2024 18:24:04 +0100
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
>> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
>>> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
>>> lock if pages_use_count is non-zero, leveraging from atomicity of the
>>> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
>>>
>>> Acked-by: Maxime Ripard <mripard@kernel.org>
>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>>> ---
>>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
>>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> index cacf0f8c42e2..1c032513abf1 100644
>>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>>> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>>>  }
>>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>>>  
>>> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>>> +{
>>> +	int ret;  
>>
>> Just random drive-by comment: a might_lock annotation here might be good,
>> or people could hit some really interesting bugs that are rather hard to
>> reproduce ...
> 
> Actually, being able to acquire a ref in a dma-signalling path on an
> object we know for sure already has refcount >= 1 (because we previously
> acquired a ref in a path where dma_resv_lock() was allowed), was the
> primary reason I suggested moving to this atomic-refcount approach.
> 
> In the meantime, drm_gpuvm has evolved in a way that allows me to not
> take the ref in the dma-signalling path (the gpuvm_bo object now holds
> the ref, and it's acquired/released outside the dma-signalling path).
> 
> Not saying we shouldn't add this might_lock(), but others might have
> good reasons to have this function called in a path where locking
> is not allowed.

For Panthor the might_lock indeed won't be a appropriate, thanks for
reminding about it. I'll add explanatory comment to the code.

-- 
Best regards,
Dmitry

