Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6DA55E50
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jan 2024 09:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520334; cv=none; b=EjDmuxt7PLp3CPfgwiJ+sVlY0+AWj0ZatOQeSxo49bYhiMvKK03P0uIBNq7OKO4OpfilHEkwIwvYoKXnwBb/wMFmNpt93IeSa1d7cwP88njhfDeycr8N2WV1QKqAHvb+BNJKJFTwOvsTjXlTq0+2TeY7ZbxiLDJ2MIwOrGpq6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520334; c=relaxed/simple;
	bh=ZeASRK9OQU0zk9iDytgg8kPkaNP8KWri+NPgrypJ/KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBcndXBst+o6qbxQdoRp5jhNur3AsLMoLG2kgt6UQN0pZcNJKgbyFXN1SLYDRS4vlJmov30bWEoMlprdyw7EN6NhCToPCXLBQsTUvGfrxiVUmjecJtL+gsyMZ/loOLI0IZkzijEXh3w9hJLFR41v14FabDtbo0HlsY3ireoW5M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3dWWHEru; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3dWWHEru"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB39641692
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jan 2024 09:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB39641692
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=3dWWHEru
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vKSTTBf_rapZ
	for <virtualization@lists.linux-foundation.org>;
	Mon, 29 Jan 2024 09:25:32 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 24D3841691
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jan 2024 09:25:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24D3841691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706520330;
	bh=ZeASRK9OQU0zk9iDytgg8kPkaNP8KWri+NPgrypJ/KY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3dWWHEruMWT62ux6ztq3I+1FA3TnZsmeUjbKb2HiRI0njatR9x1yAbwn/KxQWFt7k
	 /AeGxYmbZrVqoJiIe1vjWJsqLE/JlGMVOFYf/OSHvPss28vYYzXZnZolLhO9FvOcMB
	 KBXvUakaOBVZrsKRDNOwnEdLuparFW0i/sY/VunFzjieWBUS2yYeCo+uJRDH+wDi1l
	 FiK5M/UfeAPPF9xxbZSbdLfzq8Lh8PcePRQzUA52HHrpyxOGlmj/0eB09+0IDod8tl
	 bY0hZJ11+DMmefPVR1vuuh/iBfz6iFtvkUrGDUx2u8gdJBrYl+e8dK9zK2upo24F+P
	 yUJ5U4Oll2QOA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C647F37814B0;
	Mon, 29 Jan 2024 09:25:28 +0000 (UTC)
Message-ID: <e062b0dc-6630-42f9-b3ca-ac4bc0597190@collabora.com>
Date: Mon, 29 Jan 2024 12:25:26 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 22/30] drm/shmem-helper: Add common memory shrinker
Content-Language: en-US
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-23-dmitry.osipenko@collabora.com>
 <20240129100112.35c73f18@collabora.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20240129100112.35c73f18@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 12:01, Boris Brezillon wrote:
> On Fri,  5 Jan 2024 21:46:16 +0300
> Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:
> 
>> +/**
>> + * drm_gem_shmem_swapin_locked() - Moves shmem GEM back to memory and enables
>> + *                                 hardware access to the memory.
>> + * @shmem: shmem GEM object
>> + *
>> + * This function moves shmem GEM back to memory if it was previously evicted
>> + * by the memory shrinker. The GEM is ready to use on success.
>> + *
>> + * Returns:
>> + * 0 on success or a negative error code on failure.
>> + */
>> +int drm_gem_shmem_swapin_locked(struct drm_gem_shmem_object *shmem)
>> +{
>> +	int err;
>> +
>> +	dma_resv_assert_held(shmem->base.resv);
>> +
>> +	if (!shmem->evicted)
>> +		return 0;
> 
> Shouldn't we have a drm_gem_shmem_shrinker_update_lru_locked() even if
> the object wasn't evicted, such that idle->busy transition moves the BO
> to the list tail?

Seems so, good catch. I'll double-check and remove it in the next version.

-- 
Best regards,
Dmitry

