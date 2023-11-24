Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC01EB42
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L69sDpmu"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 437B3401D2
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:41:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 437B3401D2
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=L69sDpmu
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wMo9OuRgVFuD
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:41:11 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5EBBB40132
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:41:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EBBB40132
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 69798B8165B;
	Fri, 24 Nov 2023 10:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DADEC433C8;
	Fri, 24 Nov 2023 10:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822468;
	bh=B9wGFKlvp/YZEopRaAvdU1A2HubEm3DJLIXAlfjLLZA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=L69sDpmu9gMgz1zrB8/1oyyUf/W8N4ry1cjMHW049czR5sJm4eG5fugpYRBBKZuv4
	 W88Pn8p+EOJyPbq8U3moFuVR220+C6w/WiP+epLu7J+0iNf7PDI0lwF2DcW3NIw39D
	 oSuL+Rnu1jyCxKR9e8SbLyIpSdpje4k2huqZftU98Q51+pi9Y4JzU/DSGgcPO+RS0J
	 oV+SH4b3cmrABZlj9GcxMMSueE17XDXq0dpYHnUQdXAXR3l2CjBuGCwc5DUEm2Arh1
	 jc8FmE9NPKOLuuCHWVN5ectENAGY+uVpxn2/AWtRT/wbYAGkOC1qb4Wny7CPDFF+TH
	 lHPyI9A+eZ8wA==
Message-ID: <5b594d30e08b4acaf7aaf9b7a4419d2a.mripard@kernel.org>
Date: Fri, 24 Nov 2023 10:41:05 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 06/26] drm/shmem-helper: Add and use pages_pin_count
In-Reply-To: <20231029230205.93277-7-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-7-dmitry.osipenko@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Boris
 Brezillon" <boris.brezillon@collabora.com>, "Chia-I Wu" <olvaffe@gmail.com>,
 =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Daniel
 Vetter" <daniel@ffwll.ch>, "David Airlie" <airlied@gmail.com>, "Emma Anholt" <emma@anholt.net>, "Gerd
 Hoffmann" <kraxel@redhat.com>, "Gurchetan Singh" <gurchetansingh@chromium.org>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>, "Melissa
 Wen" <mwen@igalia.com>, "Qiang Yu" <yuq825@gmail.com>, "Steven Price" <steven.price@arm.com>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 30 Oct 2023 02:01:45 +0300, Dmitry Osipenko wrote:
> Add separate pages_pin_count for tracking of whether drm-shmem pages are
> moveable or not. With the addition of memory shrinker support to drm-shme=
m,
> the pages_use_count will no longer determine whether pages are hard-pinned
> in memory, but whether pages exist and are soft-pinned (and could be swap=
ped
> out). The pages_pin_count > 1 will hard-pin pages in memory.
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
