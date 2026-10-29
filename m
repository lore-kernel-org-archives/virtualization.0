Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269744;
	b=KlDOZWcntJX95v+qgmHyKhAwECWEVL7/9Q4DezNuTePUbgvDTD2euQkPJcy7mIarSxUl
	 z8Eimzg64uZeAc+2dwc+NWXKl/YKstX/2zwXZ3CB0gw6n7iHfMpNRTB3fOIk3TviUxqUt
	 2wiSYZRi/CzAD/oS9g5YMTIpIggu6TX5TFek+4eBY814sGpLOHbYPI6Ss+Bq6PzUKBznV
	 orDuez47Exw8UPPcOn4JtZdCFKjq/4iLKKB5y0ESFpwwht91Ps+L3miHG1fCZN9x5YC7m
	 Yy9R750QcJSbbHQOpZuHi/fb9MVgciegTM840dBo5IyMabPWTbxcnlSRDgwWrJWfJ8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269744;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-META:
	 X-MBO-RS-ID;
	bh=PQfG2Km+YKrxCDPAAbbWYdryEevMUab9CWpj+Sh05TA=;
	b=uWL3FpTwqmc2B0mSB9cT6VZqFFJ1za+V717JG5slKcLCzx9rO0nG0XIi2p7EUC0VwmQW
	 X27tgeFuv/TM46sqQS8YOnd5WCgo6bVs0TXqojf32VUXYK7gsn+xuw3VciGtZ5g0KNwOF
	 GUrxwYuBxvQTIoRlx6QTL2s8wKGyEKiuQvq+5fYSc19NhU962i6tEsBcMvUvDqSkmPk1S
	 5LgHrIsso7/oDIxHBIj13B13EEy0ZURZEiXWJ3hCfJ7ocP5D0eNLpJl+NVGb06PzXRwAx
	 yhajCb3GKYSSuW723+CNeVY/rg4WmQQSpKnYWz9E3SFwTG7rP2BgPhszClpl/BKtwXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=owjb1PqO;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12621606A31D
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 10:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12621606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=owjb1PqO
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jFgSW3XgszMlJf;
	Thu, 29 Oct 2026 11:28:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793269739; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PQfG2Km+YKrxCDPAAbbWYdryEevMUab9CWpj+Sh05TA=;
	b=owjb1PqOwF30L04GcK9Gww366AX2aDnKYxBGxkid6fiIMNw14Fg6DhRRdvbRSRfBeVSMQl
	WaxlytFFpjs1RJoZ5N45Sz33bL9w1qJBlyeR1eU5rt65f55C6aO6qdifwEcZ130ppK53tP
	pSveThL3uREOnABjLcdpsunrn9gRUFcZLXwXOSMIY/Byy+6Sd2LBtfvMGzoSgr9hC9w0Ly
	5xXQ0diqvtpnZBddkWZNE4v0Z6yBzfp+Ldvy08kYgCZJDjkf6XZXF1wQdHfrhUyKVv7ICE
	Oy4tVehaRM110/poQ6AB8ew8cPWmwyLlOdtLmIRxn5M7f9zit58chkxeIOjPjA==
Message-ID: <3565783722927fa48a30f48b063ef99bcd703eab.camel@mailbox.org>
Subject: Re: [RFC PATCH 0/6] dma-buf: Phase out is_signaled() race
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Philipp Stanner
 <phasta@kernel.org>,  Min Ma <mamin506@gmail.com>, Lizhi Hou
 <lizhi.hou@amd.com>, Oded Gabbay <ogabbay@kernel.org>,  "Rob Herring (Arm)"
	 <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Karol Wachowski	
 <karol.wachowski@linux.intel.com>, Andrzej Kacprowski	
 <andrzej.kacprowski@linux.intel.com>, Sumit Semwal
 <sumit.semwal@linaro.org>,  Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter	 <simona@ffwll.ch>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Russell King	
 <linux+etnaviv@armlinux.org.uk>, Christian Gmeiner
 <christian.gmeiner@gmail.com>,  Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, Alessio
 Belle	 <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>,  Qiang Yu <yuq825@gmail.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov	 <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Jessica Zhang	
 <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, Marijn Suijten	
 <marijn.suijten@somainline.org>, Lyude Paul <lyude@redhat.com>, Danilo
 Krummrich <dakr@kernel.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price	 <steven.price@arm.com>,
 =?ISO-8859-1?Q?Adri=E1n?= Larumbe	 <adrian.larumbe@collabora.com>, Liviu
 Dudau <liviu.dudau@arm.com>, Dave Airlie	 <airlied@redhat.com>, Gerd
 Hoffmann <kraxel@redhat.com>, Matthew Brost	 <matthew.brost@intel.com>,
 Natalie Vock <nat@pixelcluster.dev>, Arun Pravin	
 <arunpravin.paneerselvam@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 Thomas =?ISO-8859-1?Q?Hellstr=F6m?=	 <thomas.hellstrom@linux.intel.com>,
 Melissa Wen <mwen@igalia.com>,  =?ISO-8859-1?Q?Ma=EDra?= Canal	
 <mcanal@igalia.com>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance	 <kernel-list@raspberrypi.com>, Dmitry
 Osipenko <dmitry.osipenko@collabora.com>,  Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Zack Rusin
 <zack.rusin@broadcom.com>,  Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Thierry Reding	
 <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Sunil Khatri <sunil.khatri@amd.com>, Kees
 Cook	 <kees@kernel.org>, Jesse Zhang <jesse.zhang@amd.com>, Timur
 =?ISO-8859-1?Q?Krist=F3f?=	 <timur.kristof@gmail.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>,  Kexin Sun <kexinsun@smail.nju.edu.cn>,
 Prike Liang <Prike.Liang@amd.com>, David Rosca	 <david.rosca@amd.com>,
 Krzysztof Karas <krzysztof.karas@intel.com>, Marco Crivellari
 <marco.crivellari@suse.com>, Shixiong Ou <oushixiong@kylinos.cn>, Jouni
 =?ISO-8859-1?Q?H=F6gander?=	 <jouni.hogander@intel.com>, Thadeu Lima de
 Souza Cascardo <cascardo@igalia.com>,  Pierre-Eric Pelloux-Prayer
 <pierre-eric.pelloux-prayer@amd.com>, Joel Fernandes
 <joelagnelf@nvidia.com>, Al Viro <viro@zeniv.linux.org.uk>,  Neill Kapron
 <nkapron@google.com>, Michael Bommarito <michael.bommarito@gmail.com>, Sam
 Day <me@samcday.com>,  Gabriel Prostitis <prostitisgabriel@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-usb@vger.kernel.org
Date: Thu, 29 Oct 2026 11:28:39 +0100
In-Reply-To: <abca3f0039b07999e29558690c27fef23292bea3.camel@pengutronix.de>
References: <20261029095542.1526750-3-phasta@kernel.org>
	 <abca3f0039b07999e29558690c27fef23292bea3.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-META: j7weafhpcaunystyo7r38dam3cyszcnz
X-MBO-RS-ID: 051d97976afa34da498

On Thu, 2026-10-29 at 11:23 +0100, Lucas Stach wrote:
> Hi Philipp, hi Christian,

Jo Lucas

>=20
> Am Donnerstag, dem 29.10.2026 um 10:55 +0100 schrieb Philipp Stanner:

[=E2=80=A6]

> I think we would all be interested in the actual use-case that's
> sensitive to this kind of latency.

Me too.

Let me use this opportunity to stress that in the future, in DRM,
whenever we have [to accept] a racy "optimization", both commit
messages and code comments must document why it exists and who
requested it with what proof.

Would save us lots of time when those things are discussed >5 years
later.

>=20
> However, I wonder if this is even an issue anymore with the lock
> inlined into the fence structure.

Almost no one uses inline-lock so far. So unfortunately, we might
regress old drivers, maybe.

But sounds as if you're in favor of phasing the locklessness out :)


P.
