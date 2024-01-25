Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8113A256
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219547; cv=none; b=KueYnRk0YrKgBIer+A9in92X0J192DxaE48Po5+g5sYDPahD87ThaR2PZ7SezP75v/y1tKS4+1YhtJ0jdvj6Exzibqyp8g+pnGV6RD2u8c4tlNF62Vc2u6hQgOeLbxpukI1BNhhqwKNWu0Yp965JtFfOD++CFKguzoBulXoiYgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219547; c=relaxed/simple;
	bh=HmHb/1j56mYypkJHtCxMuyE8iJQuLLhZ2r3pRbNJ0Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pZkrpybxihXlWcbCa3Kt8EVHB+IJYTMJJZ7kwfvFiodEglwCkTeVAKFBIJUjO53wlXSRMJ4kuU285KHSUsBjM28fESfbMdEfNGVNhGE9t885/VE/2G4x5+8CvxdkXdkt7ADJUNt29pwDl+zm6Uo5arH/PzUaO7lmc+i3jInh2og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DjKPBOn5; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DjKPBOn5"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C02E46FBBE
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 21:52:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C02E46FBBE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=DjKPBOn5
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wnj-9vocgIBX
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 21:52:25 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1512A6FACB
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 21:52:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1512A6FACB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706219543;
	bh=HmHb/1j56mYypkJHtCxMuyE8iJQuLLhZ2r3pRbNJ0Ek=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DjKPBOn5DkLFgqwP0WrFz5zmWSBPLMUa00i2AzL5gujzFWsxBQJZtLk7yLL4Fk3mw
	 qmf8pOZT2aIxEOOBFymm2cbk1Njwpow9/hYB9Dk8zf/mhLP307VzkWdqq4xBJF8wLf
	 tlsvHel51nr4LS9KByd5zZvHCDSOwM61iCe7TAo8h0bWYUdSRNwZixl4i54JTwVIm6
	 yFQaOuEc9iAfV7ZRTQ4jdqHSm1HsPVgPgqP/FIYD2UOvIMWRoFH4wpvvrVhztuII52
	 DN7YkZbkTJfLwGjonrp80UCfEH/C+yzfA/rfDazDfJeZw/6PzT2FLOrO2Mlo4WEFVO
	 a/Iznos2DQfjg==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C958D37813DA;
	Thu, 25 Jan 2024 21:52:21 +0000 (UTC)
Message-ID: <ddcae9fe-6155-4542-898c-bfb06e8721b8@collabora.com>
Date: Fri, 26 Jan 2024 00:52:19 +0300
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
To: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-10-dmitry.osipenko@collabora.com>
 <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ZbKZNCbZoV4ovWTH@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/25/24 20:24, Daniel Vetter wrote:
> On Fri, Jan 05, 2024 at 09:46:03PM +0300, Dmitry Osipenko wrote:
>> Add lockless drm_gem_shmem_get_pages() helper that skips taking reservation
>> lock if pages_use_count is non-zero, leveraging from atomicity of the
>> refcount_t. Make drm_gem_shmem_mmap() to utilize the new helper.
>>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> ---
>>  drivers/gpu/drm/drm_gem_shmem_helper.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> index cacf0f8c42e2..1c032513abf1 100644
>> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
>> @@ -226,6 +226,20 @@ void drm_gem_shmem_put_pages_locked(struct drm_gem_shmem_object *shmem)
>>  }
>>  EXPORT_SYMBOL_GPL(drm_gem_shmem_put_pages_locked);
>>  
>> +static int drm_gem_shmem_get_pages(struct drm_gem_shmem_object *shmem)
>> +{
>> +	int ret;
> 
> Just random drive-by comment: a might_lock annotation here might be good,
> or people could hit some really interesting bugs that are rather hard to
> reproduce ...
> -Sima

Thanks for the suggestion!

-- 
Best regards,
Dmitry

