Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F6B1C6A1
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9d7m5tb"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1693F41A1A
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:35:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1693F41A1A
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=F9d7m5tb
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -7.101
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFRpFBUDwQm3
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:35:04 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E1E441A0A
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:35:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E1E441A0A
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D172E62123;
	Fri, 24 Nov 2023 10:35:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F3BC433C7;
	Fri, 24 Nov 2023 10:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822102;
	bh=bTOxPls9oEkOieAEKp1Eghoi+o3SdE6s04+l2qTLwmI=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=F9d7m5tbfY6gNbZF9XgVO1y+R9k+ex3AqCRXvGShoG0t+9OreKJiWv3QNy9GnkyGk
	 NGDNHUrOaTe4rDjTw4xY9KM1GlAVOLSn3tlsbIMr3QxYU3lhENxdFuqoLxREuNN97u
	 zk65Ks5GpriKZOU+xFmBGVIZEhGeJ6HKo6gx1Ter+4tybGidopeB7aTm3vEnMtBu1N
	 QTbztPv2jARzk6e74b4e3ElK4nzgl2V6CKJBuUNxAZyvEav1wQhYmmm3F/LqyVqL9a
	 r/x9otF9P46BK96skhK4aQ96UVfbSoKBNUxOf7Y1zTB48LehKDNtDnCXCvcAS0aslF
	 gniFuG49No6MQ==
Message-ID: <18807000ad1d33a0925c5470faf20fca.mripard@kernel.org>
Date: Fri, 24 Nov 2023 10:34:59 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 01/26] drm/gem: Change locked/unlocked postfix of
 drm_gem_v/unmap() function names
In-Reply-To: <20231029230205.93277-2-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-2-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:40 +0300, Dmitry Osipenko wrote:
> Make drm/gem API function names consistent by having locked function
> use the _locked postfix in the name, while the unlocked variants don't
> use the _unlocked postfix. Rename drm_gem_v/unmap() function names to
> make them consistent with the rest of the API functions.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
