Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364111350E8
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 21:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219083; cv=none; b=jPkiH2wIU6hcoBRTuMRmKHnlHawry5Cz0LxRWOIc4LXwwyLCEFtIsLVw4D2Tlf2dhLK/bUV4bChs3DHWR5Vj6iGcGyOjOXoEdGPtpXGNZ9NyD0SeK8Tegmy2vZ8TXR4MbN4os70r1OuRTfxLQlHQi1T+o/RjlLyYZIJXLW5Dp2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219083; c=relaxed/simple;
	bh=VKagnVmAZwzDPUwQEySN1O/dZJAvWl37niOmwVB/dyA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=tMRuSmtGfEWCj5Yp0G2GQiRNIPeIsZKLlDAHudHD9RHnVCl/Vv/MoI2snlSdv3/4MsyMWK2MpyU42aF2fr/6V9dgBwrmnRFxERMj8corZ8/Men3bFzgldlzwhhwMNgYHiKGs3ovjzThQygGhudOCCR33h3YeSl3fN4TfjPWaiAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=zH4YsQQ1; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="zH4YsQQ1"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95037436AC
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 21:44:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95037436AC
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=zH4YsQQ1
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RqEshKpEt25s
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 21:44:40 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F4B143685
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 21:44:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F4B143685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706219078;
	bh=VKagnVmAZwzDPUwQEySN1O/dZJAvWl37niOmwVB/dyA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=zH4YsQQ1l9xhDsaiFEXIwuiTiRpBtb9WAEHZF0IB1pCL1ARKClVhCLvtpJyejW385
	 MlZFZt3zOuBKgPCaCvbQqBeL7/fr1NdvMzbmvLXwOHAiMiLpf+t7BMzs0FN3Tp1x75
	 IZKk9/Q3MJ7nS/GfTLDHT1p0P+VEXeTEgosFRqNr4pNPdD9UedKbdo4BIXNQJ6hlOO
	 ekPlOo1/mAejbQgzUJQP9o0hPQi/9EPAkzgxCWYjhuKgpCjvBaUXJkafrEzi0znmNU
	 pr1RO2ZHuCXoiznbl/hNxf05pxnDwTd4ruetDWaCJCayfu7El6UbOZpD0cmK746ct3
	 yAH/351PiykNA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 647DE37813DA;
	Thu, 25 Jan 2024 21:44:37 +0000 (UTC)
Message-ID: <dd49d49d-7ead-4b66-8ddf-07e4012b10d6@collabora.com>
Date: Fri, 26 Jan 2024 00:44:34 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 17/30] drm/panfrost: Fix the error path in
 panfrost_mmu_map_fault_addr()
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
To: Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org,
 David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Emma Anholt <emma@anholt.net>,
 Melissa Wen <mwen@igalia.com>
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-18-dmitry.osipenko@collabora.com>
 <f5d94271-9b6a-4a8d-9cb7-dac055dda92c@collabora.com>
In-Reply-To: <f5d94271-9b6a-4a8d-9cb7-dac055dda92c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/24 00:41, Dmitry Osipenko wrote:
> On 1/5/24 21:46, Dmitry Osipenko wrote:
>>  	for (i = page_offset; i < page_offset + NUM_FAULT_PAGES; i++) {
>> +		/* Can happen if the last fault only partially filled this
>> +		 * section of the pages array before failing. In that case
>> +		 * we skip already filled pages.
>> +		 */
>> +		if (pages[i])
>> +			continue;
>> +
>>  		pages[i] = shmem_read_mapping_page(mapping, i);
> 
> Although, the shmem_read_mapping_page() should return same page if it
> was already allocated, isn't it? I.e. there was no bug here and the
> fixes/stable tags not needed.

Scratch that, I forgot that the patch is about the unbalanced
get/put_pages

-- 
Best regards,
Dmitry

