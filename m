Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9C27F0
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p/qa+RJd"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AC69A8215E
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:40:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AC69A8215E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p/qa+RJd
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9bOW2kRNXVAG
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:40:29 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 145DC82153
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:40:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 145DC82153
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4E55E62135;
	Fri, 24 Nov 2023 10:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0480C433C7;
	Fri, 24 Nov 2023 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822428;
	bh=y+1TDiBAnMt4VxdCKGR5QS2biqH47tvAiQJ9i4yez2Y=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=p/qa+RJdm7WokbrVvywi9obaB050hb9y0zng38ZwWloP45PRz9232CjxOYzodFL8L
	 gRibElH+QG/dcvyBOrWEQED3vZjkhgtvRO5jbcTTOzHXl8kJR/SHt51HgicJgDeK6t
	 FnC5SWQYnR15tJhpZFgGipbCieJveCjAfpWuZzbnyF8RPh5dDt99LCC65nIFbYNSp6
	 FiGYFMdrKwQ+xpUTiO5gbQVwNBlfKEcl39Y3h01GRO/KwBKd71tFV3ohenFQK4m8d0
	 RyxAnwN1W8Rv+7n6JjcXMwcWRNcuP1XBOes1rA1hxsvmlCZYCapgbcKHVP/vT17+SO
	 ojiNCUBS7DoLg==
Message-ID: <74226af80ecee1c3544c1bcf66565514.mripard@kernel.org>
Date: Fri, 24 Nov 2023 10:40:25 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 05/26] drm/shmem-helper: Remove obsoleted is_iomem
 test
In-Reply-To: <20231029230205.93277-6-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-6-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:44 +0300, Dmitry Osipenko wrote:
> Everything that uses the mapped buffer should be agnostic to is_iomem.
> The only reason for the is_iomem test is that we're setting shmem->vaddr
> to the returned map->vaddr. Now that the shmem->vaddr code is gone, remove
> the obsoleted is_iomem test to clean up the code.
>=20
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
