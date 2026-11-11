Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387229;
	b=P7CpMRcN7V8LsuDxUeWXQizanyumorqBSYlMsbGF4OaL5ndT+lJLloQetoak1dLr9CGh
	 sRPjHmRj300WvVFzeQ33CXQjBRTHDkkJ/otk97YNTE9w72gUj1zVAnBC38OO0vux1CGCN
	 OUhAHN74k8hIxjRtJkHHAbE+o1ocNxB//9Um+kzytnpYntPeIJ7p6AnzMzrRoG5ITXgSm
	 dCAOrJ05ZcXOTNPdYkLb37xYEUFfS44513AbpxJIDGHNR29WvdpPJ4q5BVqMj9W/X77rn
	 Z1O7yKENwAKdcxmrmoL5uyj7RVfzWbWDj20Pufc++2ZUqv8vptH1cVF1TkF+JvVYhXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387229;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=VRiZhzrsDkrLspAml0XRBl5rak3lI4bTzhSsupMJ/y8=;
	b=eGrDAsqsp/fgteJ0kqNSgFiqYQnj8HTC/6pusVneLQC13z+oOjUDpxiTDPNtK986pHS2
	 ngfhLrQDgQJHmPYxUGrkIeWuPlB0+UqSnSaoPEhgubVP2uXDzX7SkVzV/L+8kH6RTYa/B
	 ZcCXJw1OcTjhTYmALhoizJDrA5mqYbKYo94XE8pwWK4xuOeYVA+QwSPigI1AlHVN1I6dv
	 O0wPzrFbZVGJrSjyqrBpF0ch8HhXLdgtQynWysbwg5ygbQIn3XIKcka2KnJwPpPTVlQYC
	 tbJweR0/ahFmhcxSLMzBI62dzfEHwErsgWIHCL2TO0oaKUdQ0zgynbzqp3Quw+OgaUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=td12n49U;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E21A606A33E
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 08:53:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E21A606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=td12n49U
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jPckV706vzKsYn;
	Wed, 11 Nov 2026 09:53:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794387219; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VRiZhzrsDkrLspAml0XRBl5rak3lI4bTzhSsupMJ/y8=;
	b=td12n49UKDo56vCxSTn09U/FbdYGCk/hjrgkPwsYYmfR0Gs5QBppPCBDtVxxLchIEUwdQb
	qOgaQ7bu4TKe2ydp1VVhzS3MjouOIvhK3svhqAqL4/zeXX6snq3K7vPx9e14jLpaWSPfrN
	CC8kqaWegcbNN3dhGKGxAUSh8tFn4cT6u0zUeVOhFHv7yRgcI2X3Hx2TJKeot6Qlqt1EwC
	lXHAwJBaYus+xC2WzZaQgsfOSySsNxfufDkkyksnvgI5eJB6EDfy5i8Q8e6p4IJt1EIvEW
	KDNGmFpUTrOi351V8lzioglBOuHpSOovM/WIAIwzWjYiS+xktKSPpS25dn1MEg==
Message-ID: <a2e7519ab463dec876aa806d91961456f31a725a.camel@mailbox.org>
Subject: Re: [PATCH 0/3] dma-buf: dma-fence: Remove dma_fence_init64()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Philipp Stanner <phasta@kernel.org>, Min Ma <mamin506@gmail.com>, Lizhi
 Hou	 <lizhi.hou@amd.com>, Oded Gabbay <ogabbay@kernel.org>, "Rob Herring
 (Arm)"	 <robh@kernel.org>, Tomeu Vizoso <tomeu@tomeuvizoso.net>, Karol
 Wachowski	 <karol.wachowski@linux.intel.com>, Andrzej Kacprowski	
 <andrzej.kacprowski@linux.intel.com>, Heiko Stuebner <heiko@sntech.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Felix Kuehling <Felix.Kuehling@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>, David Airlie	 <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Lucas Stach
 <l.stach@pengutronix.de>, Russell King	 <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,  Jani Nikula
 <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Alessio Belle	
 <alessio.belle@imgtec.com>, Luigi Santivetti <luigi.santivetti@imgtec.com>,
  Qiang Yu <yuq825@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov	 <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang	 <jesszhan0024@gmail.com>, Sean
 Paul <sean@poorly.run>, Marijn Suijten	 <marijn.suijten@somainline.org>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, Boris
 Brezillon <boris.brezillon@collabora.com>, Steven Price	
 <steven.price@arm.com>, =?ISO-8859-1?Q?Adri=E1n?= Larumbe	
 <adrian.larumbe@collabora.com>, Liviu Dudau <liviu.dudau@arm.com>, Dave
 Airlie	 <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Matthew
 Brost	 <matthew.brost@intel.com>, Natalie Vock <nat@pixelcluster.dev>, Arun
 Pravin	 <arunpravin.paneerselvam@amd.com>, Matthew Auld
 <matthew.auld@intel.com>,  Thomas =?ISO-8859-1?Q?Hellstr=F6m?=	
 <thomas.hellstrom@linux.intel.com>, Melissa Wen <mwen@igalia.com>, 
 =?ISO-8859-1?Q?Ma=EDra?= Canal	 <mcanal@igalia.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>,  Raspberry Pi Kernel Maintenance	
 <kernel-list@raspberrypi.com>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Gurchetan Singh
 <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, Zack Rusin
 <zack.rusin@broadcom.com>,  Broadcom internal kernel review list	
 <bcm-kernel-feedback-list@broadcom.com>, Thierry Reding	
 <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Neill Kapron	 <nkapron@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Alice Ryhl
 <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>,  Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>,  Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
  Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>, Alexandre Courbot	 <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,  Sunil Khatri
 <sunil.khatri@amd.com>, Prike Liang <Prike.Liang@amd.com>, Vitaly Prosyak	
 <vitaly.prosyak@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, Timur
 =?ISO-8859-1?Q?Krist=F3f?=	 <timur.kristof@gmail.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>,  David Rosca <david.rosca@amd.com>, Marco
 Crivellari <marco.crivellari@suse.com>, Krzysztof Karas	
 <krzysztof.karas@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Shixiong Ou
 <oushixiong@kylinos.cn>, Jouni =?ISO-8859-1?Q?H=F6gander?=	
 <jouni.hogander@intel.com>, Joel Fernandes <joelagnelf@nvidia.com>, Thadeu
 Lima de Souza Cascardo	 <cascardo@igalia.com>, Pierre-Eric Pelloux-Prayer	
 <pierre-eric.pelloux-prayer@amd.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Michael Bommarito <michael.bommarito@gmail.com>, Sam Day <me@samcday.com>,
 Gabriel Prostitis	 <prostitisgabriel@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-usb@vger.kernel.org
Date: Wed, 11 Nov 2026 09:53:25 +0100
In-Reply-To: <20261105113529.1989375-2-phasta@kernel.org>
References: <20261105113529.1989375-2-phasta@kernel.org>
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
X-MBO-RS-ID: bc6accce8d8b9e73737
X-MBO-RS-META: pdph9mgme6uj6kihqyt55uq9zqcpmeni

On Thu, 2026-11-05 at 12:35 +0100, Philipp Stanner wrote:
> We recently had a discussion about reworking dma_fence init to close a
> race-window [1].
>=20
> The community agreement seems to have been that we can get rid of
> dma_fence_init64(), so let's do that already. In the meantime we can
> continue our discussions regarding the race in [1].
>=20
> This also touches the Rust dma_fence, which actually should use 64-bit
> seqnos (was forgotten so far). Rust fence has no users currently, so
> needs no backporting, so I would like to address that in a distinct
> patch.
>=20
> Tested on Nouveau with and without the SEQNO64 flag. Nouveau also uses
> the USER flag, so I hope we're fine.
>=20
>=20
> P.
>=20
> [1] https://lore.kernel.org/dri-devel/20261029095542.1526750-3-phasta@ker=
nel.org/
>=20
>=20
> Philipp Stanner (3):
> =C2=A0 dma-buf: dma-fence: Add flags parameter to dma_fence_init()
> =C2=A0 dma-buf: Port users of dma_fence_init64()
> =C2=A0 dma-buf: dma-fence: Remove dma_fence_init64()

@Christian, what do you think, shall we go on with this one?


P.
