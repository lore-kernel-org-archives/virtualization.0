Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3C51A5A4
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeAVkrlT"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4BA96821AA
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:35:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BA96821AA
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JeAVkrlT
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.401
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b7pVoDbjtiv3
	for <virtualization@lists.linux-foundation.org>;
	Fri, 24 Nov 2023 10:35:29 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5DAE181250
	for <virtualization@lists.linux-foundation.org>; Fri, 24 Nov 2023 10:35:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DAE181250
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 55260CE0023;
	Fri, 24 Nov 2023 10:35:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F50EC433C8;
	Fri, 24 Nov 2023 10:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700822122;
	bh=H+nXekQkf9XBvY1ESMqyZIEqP3DaxDh+lS5/L2SdOxA=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
	b=JeAVkrlT0JUtUSZHnsWzFlVtrXd1jk4LmmlEePsz4eSdJSF8ECxx6slpyiS7xTSOQ
	 XLVdMkamyEMILzaPLP9l2OoAPhYAMBum4iSEl40sOaT9Cd8mkbPHhsHnX6MXaeVNm1
	 pGrxLhUDuTpeFOMGoufKLUDNkMX8iFP4DS/O7HLe9OiDF5QQI//y3KLwfqtDIMdhSp
	 vLQAVDwnZm6KkPgHXLIAZ5oxN+WJhAz2gE9Yzro1Mv9UuqXZF2dbrXfpmtl87MvGuM
	 rSQr8NecK7JaxZ7HIzrdEFjEeCRY6mdY1Ww8G6aQ2tz5JQj6yGrUgDRuxbptA82BH3
	 dpyeIFuqI2h2Q==
Message-ID: <a8383fc4d59952d74816b16a1a1c322a.mripard@kernel.org>
Date: Fri, 24 Nov 2023 10:35:20 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Dmitry Osipenko" <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH v18 02/26] drm/gem: Add _locked postfix to functions
 that have unlocked counterpart
In-Reply-To: <20231029230205.93277-3-dmitry.osipenko@collabora.com>
References: <20231029230205.93277-3-dmitry.osipenko@collabora.com>
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

On Mon, 30 Oct 2023 02:01:41 +0300, Dmitry Osipenko wrote:
> Add _locked postfix to drm_gem functions that have unlocked counterpart
> functions to make GEM functions naming more consistent and intuitive in
> regards to the locking requirements.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
