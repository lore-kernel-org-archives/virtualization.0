Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793273032;
	b=z4QFVun5Y+Jd0WtbMeiDSS8ZYj6BWge/Pc4Fj8/NMBnUVaHLvaIZdxMayO7PZLX8P/X2
	 rn+GN9OXLjElD3ArSqM7u4J4YaS9fRUNj+tlArCP4NZ1gK5V3lg5m5dh1+5BXVLDf9Bf8
	 aS053YeLMQtQrgRcUiCZk4xL5XZ6qJz54YY1SA1KYbFgEpXF9zdH02Hz7mjzZWsHP8Xpu
	 ih9vMbTmjF0fyHuZna7g5ABo+4ZxhFaH3VKoYywgf5vrkyjnBNC0iaOdT3o+xe1tFmFUH
	 gJj5bKdZ3HTOlHsOKJ4E8yjOcMTaWNzL+LuLZzOS0rneKZoM5w6+ptnhZaIeP2tHi3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793273032;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=s4uscHTSNNyFgyqCTfvm7pgyQFz42LzvHFK7u0x0Cw0=;
	b=mfP8ILvOtpL4weQoQ8lYNrFevoAK0i/x5u0jD77eAoRIfoOwjRM0IOqBHqbm8+R20sjN
	 Oqy9ZmzFXIYjQdgrSb30HIed2haKqYSnrdsWw+3BVj05+Mn3o24XQ6MZ34jhNdFsEvQ2H
	 SW1/0X7yl0mjZgA8s8Ge3jmTICzHo8ncNPJtuob0BKc6Xhx+gscW18KAgA8Gc64UFxo2F
	 SbKaWDDye0ASTay7Vrvstco405P73a+3sSDrcKFXm2F8EDgRgZqN4icmYiOoVs6R3Oe3x
	 OE5sAsFnhDK4XxMXhKVRYbtq1R5jwcSW2noicl8z68ptRM1fWyarjWjKEBA/nMd7BSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YhheDy8E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77F6606A31C
	for <virtualization@lists.linux.dev>; Thu, 29 Oct 2026 11:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C77F6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=YhheDy8E
Received: from [IPv6:::1] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: lst@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 418BC2007F9;
	Thu, 29 Oct 2026 12:23:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793273028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4uscHTSNNyFgyqCTfvm7pgyQFz42LzvHFK7u0x0Cw0=;
	b=YhheDy8EfCQv89DyrUXN/Yqh1aav8HKOaPDt4/Y3XFIPfM2HQZksNK1Q4J8Xiva3N9Z1Am
	tkP2eX7Gmfxohg3zXmJeyevXeiaQVGhGYtgf5DW7WiXDKCn+YIxVKqJUBhnT18fBqcR9od
	pNUOxHrNlb/aeBZqcMinomv32QEtNIj5iOvnDLzi8UenUwl35U/mEBFZgBoAEnX3k3vgMh
	WQOKG6XE+gjRy2dunur160DUflwOCoaEEllxXNkae4RdWnLlHPVfWZgcVG5KwuGlYdMS4j
	K8l8J5jfGgLMMk0a9E7oE+GBGvUkDtPQtpWfP+urJK7Rg8cIfoftFRGLPfWCxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793273028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4uscHTSNNyFgyqCTfvm7pgyQFz42LzvHFK7u0x0Cw0=;
	b=YtyTqxntKVSuf0cXkpc84IWDjijQempbl/OM6z3jYncGCiwf/Ln99mK5+x8W0cyO9xO1gA
	kZBUATT4teV385wTGMVEaT2ftHDv466XZMo/nCHJ+3VBjvaefh76HC4h6ZqGpVZBZzIif0
	B0s67a7gzHS6sPKR61gN4QKr3LIKCsgfOapXu1CZ/XgwBY8WD5Dr2jHZMjCr5H6sThWMxU
	MsRJbd3Mcfr33CLRmW8Bp3z2gPWqfmC5Y9O64Vqrjxd/mFXxtXsuyhRNEFalbt43sftG6G
	xJ0leaBmncxO0k6VjKMNj5ycc2G3vyKocU53toT9hpLpEM+cmebxYVR8EEEN+Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=lst@pengutronix.de smtp.mailfrom=l.stach@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793273028; a=rsa-sha256;
	cv=none;
	b=CMz7Ii0BbFpIf3JOy1xOkUy1/GalemR2HX7An2NH4NYYc7nV9uA9ia33/CLwhOM5TIZVCO
	r5SjbN1jtUnItbnYc85Z8xd4yR28RKXjpQwR04UflRreGYa/mpCLkcKsFkvwIJI+HcAAQT
	e6tyb0XkfNDiCGGfk7D6jVoenCj3H0aH4beZaCr4Eu2G+Ql31BsMOvYsHkb91GsL5HKzlk
	3XcSZVASLqeWZ4KZWuMaxSYPs7oxi8oIKtwvZ2vU+4PLj3JdRq+wZ2/4S5M1ckb3lR6s7O
	ZyHtIMqbdSoBMc5gGXlEKgsiCFaxc5lHEpetkI/HR6kfcn8G0LRnwE1RHAFQyQ==
Message-ID: <d0610126883f23bec3472f41e528aae786f27c8c.camel@pengutronix.de>
Subject: Re: [RFC PATCH 0/6] dma-buf: Phase out is_signaled() race
From: Lucas Stach <l.stach@pengutronix.de>
To: phasta@kernel.org, Min Ma <mamin506@gmail.com>, Lizhi Hou
 <lizhi.hou@amd.com>,  Oded Gabbay <ogabbay@kernel.org>, "Rob Herring (Arm)"
 <robh@kernel.org>, Tomeu Vizoso	 <tomeu@tomeuvizoso.net>, Karol Wachowski
 <karol.wachowski@linux.intel.com>,  Andrzej Kacprowski
 <andrzej.kacprowski@linux.intel.com>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
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
Date: Thu, 29 Oct 2026 12:23:45 +0100
In-Reply-To: <3565783722927fa48a30f48b063ef99bcd703eab.camel@mailbox.org>
References: <20261029095542.1526750-3-phasta@kernel.org>
		 <abca3f0039b07999e29558690c27fef23292bea3.camel@pengutronix.de>
	 <3565783722927fa48a30f48b063ef99bcd703eab.camel@mailbox.org>
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

Am Donnerstag, dem 29.10.2026 um 11:28 +0100 schrieb Philipp Stanner:
> On Thu, 2026-10-29 at 11:23 +0100, Lucas Stach wrote:
> > Hi Philipp, hi Christian,
>=20
> Jo Lucas
>=20
> >=20
> > Am Donnerstag, dem 29.10.2026 um 10:55 +0100 schrieb Philipp Stanner:
>=20
> [=E2=80=A6]
>=20
> > I think we would all be interested in the actual use-case that's
> > sensitive to this kind of latency.
>=20
> Me too.
>=20
> Let me use this opportunity to stress that in the future, in DRM,
> whenever we have [to accept] a racy "optimization", both commit
> messages and code comments must document why it exists and who
> requested it with what proof.
>=20
I don't fully agree that this is a racy optimization. To me it seems
the most critical issue here is that "fence is signaled" is under
specified.

Does it purely mean that the actual hardware operation that the fence
is guarding is done? In that case the current implementation is fine,
as the bit is only set after the HW told us that it is done. This is
the interpretation I would assume was the original intent behind the
current implementation.

Does it mean that the hardware is done and all registered callbacks
have been run, even if the actual work is done in a (indefinitely)
deferred worker? You mentioning explosions caused by the pure signal
state check outside the lock would imply that some consumers of the
fence took the signaled state to mean this interpretation.

> Would save us lots of time when those things are discussed >5 years
> later.
>=20
> >=20
> > However, I wonder if this is even an issue anymore with the lock
> > inlined into the fence structure.
>=20
> Almost no one uses inline-lock so far. So unfortunately, we might
> regress old drivers, maybe.
>=20
> But sounds as if you're in favor of phasing the locklessness out :)
>=20
I'm in favor of ripping out hard to reason optimizations if they turn
out to not provide any optimization after all. However, before going in
either direction we need to clarify the fence signal state interface.=C2=A0

Either we keep the (in my interpretation) original intent of the signal
state only telling about HW progress state and thus declare some
current uses as wrong usage of the interface, which need to be fixed.
Or we need to include the SW callbacks too, but then your current lock
approach only guards against code directly executed in the callback
functions. If the implementation of the callback defers anything to a
worker this may still be racy.
And that's also my criticism to this patchset now that I thought a bit
more about this: by simply putting things under the lock you serialized
more of the SW state without actually better defining the guarantees
that this changed fence interface provides or doesn't provide to the
consumers.

Regards,
Lucas
