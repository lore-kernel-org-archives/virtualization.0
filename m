Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3C3154A6
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="chJFgsWQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8452D81551
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 11:38:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8452D81551
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=chJFgsWQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.101
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nl9mBXncxejG
	for <virtualization@lists.linux-foundation.org>;
	Mon, 20 Nov 2023 11:38:06 +0000 (UTC)
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB272814C9
	for <virtualization@lists.linux-foundation.org>; Mon, 20 Nov 2023 11:38:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB272814C9
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madras.collabora.co.uk (Postfix) with ESMTPSA id 359F96602F1D;
	Mon, 20 Nov 2023 11:38:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1700480284;
	bh=lX9d/Us0h3a8J02mdLie/YqRrpifDkBDv3KBw5ibIks=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=chJFgsWQJyiQmfayqPlZ/ywdBeuH/DLNWFm9e+lVYjoPy31JHLrAFwQkqgLrm4MKX
	 TKOAq+/8SPGa0jMFfX2Wfn05kUMuCE81IH5j0kWlVBjIDbBB08LQub3NrbLMXYAvU3
	 mW7Q/Hme2Utumxsb4KUPawimjE9/8o4BTIVxwnkatOEQQfQ6Y/uZSlR+0kP1MySz38
	 jlmwiCSQLA3nLUpg8acg8wBYqxRxS5NLPvwMNMPEjieCzJh78Giapyo24mBtYyv2eT
	 rQGfliib8CnQQEkoolLnEoU8zPOV+n5TZkytqmh3rIW4nWZocO7eOZUEXXrgzd8d9O
	 X2MoeZ71QhnIw==
Message-ID: <97c673e2-66ee-80de-3ad7-d8f02a56a3f6@collabora.com>
Date: Mon, 20 Nov 2023 14:38:00 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v18 11/26] drm/shmem-helper: Prepare drm_gem_shmem_free()
 to shrinker addition
Content-Language: en-US
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20231029230205.93277-1-dmitry.osipenko@collabora.com>
 <20231029230205.93277-12-dmitry.osipenko@collabora.com>
 <20231110111601.5d6bd1ab@collabora.com>
 <bd2308d6-38e5-6042-3da8-fb436f67a88e@collabora.com>
 <20231120121942.4eef9e03@collabora.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20231120121942.4eef9e03@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/20/23 14:19, Boris Brezillon wrote:
...
>>>> -		dma_resv_lock(shmem->base.resv, NULL);
>>>> -
>>>>  		drm_WARN_ON(obj->dev, refcount_read(&shmem->vmap_use_count));
>>>>  
>>>>  		if (shmem->sgt) {
>>>> @@ -157,8 +171,6 @@ void drm_gem_shmem_free(struct drm_gem_shmem_object *shmem)
>>>>    
>>> If you drop the dma_resv_lock/unlock(), you should also replace the
>>> drm_gem_shmem_put_pages_locked() by a drm_gem_shmem_free_pages() in this
>>> commit.  
>>
>> drm_gem_shmem_put_pages_locked() is exported by a later patch of this
>> series, it's not worthwhile to remove this function
> 
> I'm not talking about removing drm_gem_shmem_put_pages_locked(), but
> replacing the drm_gem_shmem_put_pages_locked() call you have in
> drm_gem_shmem_free() by a drm_gem_shmem_free_pages(), so you don't end
> up with a lockdep warning when you stop exactly here in the patch
> series, which is important if we want to keep things bisectable.

Indeed, there is assert_locked() there. Thanks for the clarification :)

-- 
Best regards,
Dmitry

