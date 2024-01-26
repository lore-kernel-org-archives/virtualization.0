Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751EA67A07
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706260525; cv=none; b=K9+fWHvJnQpxS3j4gtJ7pTUHxVPAFdrbTUK5RXg4BnlD5x5eMasWJ3KoEWr191YGyAdkpu2ejRew6jylobXEjxAlKDHeU2ftQP7nN8JWywQqA867LIBagH1D2CTTeLeXM6ER76RKZfTNzLuWl1f7tzDVHhhKqwxTdnb+kLsITyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706260525; c=relaxed/simple;
	bh=A4Bu9DBeMohqV6ojHawhAsegNEGOWtq+rjrBZb62rOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pf+gGXYZ/pj8MVuaO2W3ZnsGbAtLyZLG54vLjRszTIvu8jP4PzZZLXG2FJ1E7WG8fgt74tEmJeyk+23jlK9h4XI2g5ESk6IoHH6+ewEC6wTLGXLf1UBPvEJQ5b3LtbAS9R++M9eQSx4vbxiHOZLRk5y0bFMbrDWMHna+ikVMNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XFtnuKH/; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XFtnuKH/"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E0B39402B1
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 09:15:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0B39402B1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XFtnuKH/
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X-MGAAiOptoU
	for <virtualization@lists.linux-foundation.org>;
	Fri, 26 Jan 2024 09:15:23 +0000 (UTC)
X-Greylist: delayed 437 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 26 Jan 2024 09:15:22 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D73FE40292
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D73FE40292
	for <virtualization@lists.linux-foundation.org>; Fri, 26 Jan 2024 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706260083;
	bh=A4Bu9DBeMohqV6ojHawhAsegNEGOWtq+rjrBZb62rOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XFtnuKH/yy0vN6U0GKaSbQxuJRJwi85TPpZapfqm0zNj09H+H4pLbdif9YOjKAnbT
	 CgizO/+3tdmOPxrRavCPLOlJCFuGYEYYdptJv8nPKIFrr3z0z7v+89JZT9IHRdi8Aq
	 EmUYTkVdUZB2KLS79O3RoZYS1SGtwUPbL/pUH78Oi8TFkqRnybZAUw1HWvhIIh4Ek0
	 24FuFvw6t9ZVSpLk45qkCVubxoy/KPHvtndztHwN3YawPuWFt9dIJ9H/lfrE4nsNHH
	 K0c5aH13HPg7sBHJYyPExioM128Qnu694FvZmbY3aH2oKWH27f++Im5eIIz55bie+7
	 2D8kWg8FKzGxA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 25188378107C;
	Fri, 26 Jan 2024 09:08:02 +0000 (UTC)
Message-ID: <cda2af2e-15d5-4e60-af5c-dcb5f4e87f14@collabora.com>
Date: Fri, 26 Jan 2024 10:08:01 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 17/30] drm/panfrost: Fix the error path in
 panfrost_mmu_map_fault_addr()
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Qiang Yu <yuq825@gmail.com>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20240105184624.508603-1-dmitry.osipenko@collabora.com>
 <20240105184624.508603-18-dmitry.osipenko@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240105184624.508603-18-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 05/01/24 19:46, Dmitry Osipenko ha scritto:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> If some the pages or sgt allocation failed, we shouldn't release the
> pages ref we got earlier, otherwise we will end up with unbalanced
> get/put_pages() calls. We should instead leave everything in place
> and let the BO release function deal with extra cleanup when the object
> is destroyed, or let the fault handler try again next time it's called.
> 
> Fixes: 187d2929206e ("drm/panfrost: Add support for GPU heap allocations")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


