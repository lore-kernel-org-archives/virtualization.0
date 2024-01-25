Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09E1130E52
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218929; cv=none; b=YfOXPcoxo5tX4Aruv+bmOMDEXvYJZR4Qc4cDwJJbSsrlL2vir7vQBumfXrptP8GSN3TZfRoICCnlo+xdhPWSaao0cmvL7eEGu9/DbMCtz7N0mSYxUAXq9ru2yEDBFvEvPVH2EF2/yGqoje5wOJmP1vHMHiuHvHCwcvwgzYRlfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218929; c=relaxed/simple;
	bh=6qkcZYWngfmRTvoOwp5UnpiufJBrssnD1F59vptg1wY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=J5VrVGKojbGaxEYpBRMNTqoOVpyhoxx3uaOHnSG56Y3KECRfl5MOSNI5pHtZOGrx9DI9CpzkW/ZaQcsE+n3o91ScVtsYY0J5AHX0Tdt35wmZqGlVmCjfHnmAShdz4lAhe0myBVtfFaqdJ7afGjF5jHatI67ayH3cAbSoKvAOI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I5KffNlJ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I5KffNlJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68DE9844E2
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 21:42:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68DE9844E2
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=I5KffNlJ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PWnESI8BF-_F
	for <virtualization@lists.linux-foundation.org>;
	Thu, 25 Jan 2024 21:42:02 +0000 (UTC)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 98E4583E13
	for <virtualization@lists.linux-foundation.org>; Thu, 25 Jan 2024 21:42:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98E4583E13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706218920;
	bh=6qkcZYWngfmRTvoOwp5UnpiufJBrssnD1F59vptg1wY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=I5KffNlJy4qUnAehVXlDMpPEWTV7OGsIeSJlAox5l7zB9E2csGaYrZXUiTt9xEjRu
	 1wSHngLecv9nUrZZn4lK8E3BaQyzHkupXZ+00Y9dp2nxCDeYOlM2bxcNKNl1v50hKl
	 vbw2F9hUDKfA51s87p4ygh9gU02b6CINPP2ILYS9lAYc+gG8dCnqpEFQqSKq9FGiT7
	 hH4JAu0etmynZD1NexRS/bBPKzSMpU+qNoYBO5CjfYxTK/XtVlTCwvqwMpd1nCNvFu
	 mmmESnUNfoNGGwGFyIrYq2t3Ko4TX+LE7pYVe8mcLAEoMGpy7Lm5aZKCYu5VFr2M4J
	 evd9vc0KwWfRA==
Received: from [100.109.49.129] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dmitry.osipenko)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2C1A037813DA;
	Thu, 25 Jan 2024 21:41:59 +0000 (UTC)
Message-ID: <f5d94271-9b6a-4a8d-9cb7-dac055dda92c@collabora.com>
Date: Fri, 26 Jan 2024 00:41:56 +0300
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
In-Reply-To: <20240105184624.508603-18-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 21:46, Dmitry Osipenko wrote:
>  	for (i = page_offset; i < page_offset + NUM_FAULT_PAGES; i++) {
> +		/* Can happen if the last fault only partially filled this
> +		 * section of the pages array before failing. In that case
> +		 * we skip already filled pages.
> +		 */
> +		if (pages[i])
> +			continue;
> +
>  		pages[i] = shmem_read_mapping_page(mapping, i);

Although, the shmem_read_mapping_page() should return same page if it
was already allocated, isn't it? I.e. there was no bug here and the
fixes/stable tags not needed.

-- 
Best regards,
Dmitry

