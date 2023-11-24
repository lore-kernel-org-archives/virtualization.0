Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787BBA43
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv8zz3+x"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9305141DCE
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:48:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9305141DCE
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Nv8zz3+x
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xTSwYbwXWi-V
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:48:56 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9ACB41D92
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:48:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9ACB41D92
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A7F0B62156;
	Fri, 24 Nov 2023 10:48:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4192C433C7;
	Fri, 24 Nov 2023 10:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822934;
	bh=kFNGBEV5KZVkGa0eNZHwyRy+Zdp7kSVSo5j7XiYUfFA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=Nv8zz3+x3ChUMdQEo3BExPH42WyXDDU6UihftL7511gbsoQpDDgl3vzQh+KWKHlm2
	 S7hjuLEwuJbJF4gGiqaG4GhOqbjp2PAqD7fsaxMgmI01a4QKxU6hgofrKRd8W7lnPa
	 E/yqeH13d5lTUkgbY5CLmip6hd1RTrGMFb0BmNvtvUqaFO3Rbeqq5d2yLF0ElKJgEL
	 d67ACiflF+1nsBPhYzSeKwVHYLcNa9LH7rYykM9BfSyMwEyw9A1yXHMIN7BTzRgzvE
	 xbZnarKTGcGU2vi/hjq8vwsqj40so7FqkX20R5Vv5JacvtPJYiJr8SrBTmU8HBW2yM
	 jHlO7V0FALPfw==
Message-ID: <812abc1247327534cb3e044006a54513.mripard@kernel.org>
Date: Fri, 24 Nov 2023 10:48:51 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 10/26] drm/shmem-helper: Use refcount_t for
 vmap_use_count
In-Reply-To: <20231029230205.93277-11-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-11-dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Chia-I Wu" <olvaffe@gmail.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Emma Anholt" <emma@anholt.net>, "Gerd
 Hoffmann" <kraxel@redhat.com>, "Gurchetan Singh" <gurchetansingh@chromium.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Melissa
 Wen" <mwen@igalia.com>, "Qiang Yu" <yuq825@gmail.com>, "Steven Price" <steven.price@arm.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 30 Oct 2023 02:01:49 +0300, Dmitry Osipenko wrote:
> Use refcount_t helper for vmap_use_count to make refcounting consistent
> with pages_use_count and pages_pin_count that use refcount_t. This also
> makes vmapping to benefit from the refcount_t's overflow checks.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
