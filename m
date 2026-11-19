Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795083624;
	b=SPLMvtoTIXSH2Hn9o7HAiLK5lEfoxX+vih4oIIwA+IPKfyYeSjAsebFCmwoFbp/vCgBt
	 Bd6N0FSAA89xQ62M8cWu2itd1uSONJCJDsBJ2bxG55NxNpIlPUm33PtkqzK9CO6qctFsZ
	 TZq9cKjKWHBk2AmxkmevWUIRwAX/fOj8xXWO+pERN9i4tK2GvOTC08MwQmiUguz4QbY3u
	 RnfGVeiqzShfnO12U2HjCNv0MV2sU6cBrLIsbHxv00MDEX0wpP4OoQTinK+D4BoPkldy4
	 A9kAwRPwy6rabE0Bzx/bCUWHkc6kgtbwjBqqNGXKPzrvrq1o7HzaQBNe+FaWoLtWxaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795083624;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=kMLYuvKF8dKdiwmDA59a1qSto363i7DFLCqovWncpVM=;
	b=J/5pX02MeohmRfYMTuiBXEZxzoz250SBhF0uDOnIS7Q1mZ8HQT3THjuaiR/OW7GTEIGt
	 ApNRzDNmswTyTivffsMahGNX6Rkz8r/+whVqMEJSa4IwKKmCeUBsChjcLuQ1D96X3JO9P
	 zcIMi2E5ploDpf7C6Le34dWggXjThGp2r4lF7aDz01zERDgaLW1s/xVBwDiLeQNT5ffHJ
	 wegt2fS+bE3n/NxD4ZvcoD6sA9Y53ogUQ/586JIQEpNPFaFDDvPBPR+45hIJmZjGY/UZJ
	 fBkvnonqq/mhC6qfsbYZi5NsRwfaZWWvY5V81MVnC4/ZVth8neySBp7iD76onCBCR/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wrFrTipr;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28917606A332
	for <virtualization@lists.linux.dev>; Thu, 19 Nov 2026 10:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28917606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wrFrTipr
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jVZGq6rjlzMm1S;
	Thu, 19 Nov 2026 11:20:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795083620; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMLYuvKF8dKdiwmDA59a1qSto363i7DFLCqovWncpVM=;
	b=wrFrTiprp0Ygwj7fisQqKLfMWazzJwQS8HPNFqbCcn3xMC23c+XlYnmWGpPY6OwTsCFYcG
	pjdBV2XlPMgXizD5IHA860ywzUkD+zPnBEGC3P1iYty0h7dFnuiza4M6w6o0En4MdrFa29
	+z8/8pstoFJyzCxAaLcosYSfYnFvqRobT36nmnUt0/xlqfaGVRZ2fcD0Ifm0zgDEtu/5+n
	P8Q5PrjWKULrK0PMh7Putf64gTqx4d0cgQar9yKkwd/OUN6051FoFULV5Tr2btX33lJYti
	3up4UWipIuXn1wiDtyGvTg7fYqQDSjJUVFutoAn1IjQz0zTDogOUfQ0NPiL7ZQ==
Message-ID: <11c1451c97fa27ec3379965d13a6eea64e386cc3.camel@mailbox.org>
Subject: Re: [PATCH v2 0/3] dma-buf: dma-fence: Remove dma_fence_init64()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sunil Khatri
 <sunil.khatri@amd.com>,  Vitaly Prosyak <vitaly.prosyak@amd.com>, Prike
 Liang <Prike.Liang@amd.com>, Thomas =?ISO-8859-1?Q?Hellstr=F6m?=	
 <thomas.hellstrom@linux.intel.com>, Tvrtko Ursulin
 <tvrtko.ursulin@igalia.com>,  David Rosca <david.rosca@amd.com>, Timur
 =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?ISO-8859-1?Q?Ma=EDra?= Canal	 <mcanal@igalia.com>, Raspberry Pi Kernel
 Maintenance	 <kernel-list@raspberrypi.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-usb@vger.kernel.org, rust-for-linux@vger.kernel.org
Date: Thu, 19 Nov 2026 11:20:14 +0100
In-Reply-To: <20261118134522.1646892-2-phasta@kernel.org>
References: <20261118134522.1646892-2-phasta@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: e0df46cc69f1b87359b
X-MBO-RS-META: 4qqptwxqro4tns8nyafutn165yabqokk

On Wed, 2026-11-18 at 14:45 +0100, Philipp Stanner wrote:
> Philipp Stanner (3):
> =C2=A0 dma-buf: dma-fence: Add flags parameter to dma_fence_init()
> =C2=A0 dma-buf: Port users of dma_fence_init64()
> =C2=A0 dma-buf: dma-fence: Remove dma_fence_init64()

Applied to drm-misc-next with the Rbs.

Thx guys.

P.
