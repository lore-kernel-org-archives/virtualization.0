Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882889;
	b=2KaklCazJVbAV++XM6nWUl+uO62SJFseIU7UJUE6Q2RCg7xdlGuk13gRL5HA066yDwiY
	 s+6+xYgp36DIBrCmY25l+S37b1l8F0/a55bJkwk18B3WafPZ1Ok9zizWeP/A9ZFsUegSl
	 dw56ukc/g/JF+Fjf/F9hk3nGdU/wGz0zq13/69smsp/3YBad2n3Q7akTpl/KccwSeOrxe
	 BCp28EXje6ResxmbHBT/xfXuyzjFKtvxPTMSy0U/CTtfnfsg/xyiLpGOyzhvKnmR33KmP
	 U3oXprErSn/byrnK423/6EiIFez6fnsHYFrRniumZwIfdLWB+uTzasgwNBax5NNgm3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882889;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=67Meo6SWs+PIUkmgdxjnuHYFvOEQPXfe0YgYIuPIdiI=;
	b=4EfcpBXHesZB7XlrDnlARfZD5ezj8+8gexTn7wfT477zeA342cSTeTB7k8b85duMZnjH
	 CbQmc0RqepGEiM0xO4Ry8zj+A8jtC3xxVEo6DCyn4pfXM0z8a2sRYcQ0ug1ZCgPkkQfW7
	 gET8ylzl29LXa7ZteRR5H2IPnzHKP1VlQstekCphmgNp/sMSYsWE0e2YtXXTdyov+IkZw
	 2XW6Wh4Lc645wLEpDVxD4Sg9KXI6VoMfcJEJ/mRlYSbw2ONJlKc71ry4sZGpV9l2c0nWR
	 DXWjeM/6ZEOi2l/lfzDgAOtDlDrUcdPyJoAMz3M6EhMfX1xpEmjNNT3ArFz5u2USnhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wM2nZbKY;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EE606A326
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 12:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED9EE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=wM2nZbKY
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jL2Cn6kBvzKm4y;
	Thu, 05 Nov 2026 13:48:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1793882885; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67Meo6SWs+PIUkmgdxjnuHYFvOEQPXfe0YgYIuPIdiI=;
	b=wM2nZbKYrnIh8WX0WuDbNcfZq7+PooA56MChjL9DGOkNxnqcR5H6N6DkYcnsMhJ91+6G9m
	fX55ivHqzSW18hVVAspkRqwAEfvqack2bx4nNg6C/eGF1MtTa0nKvN3GpVKXCCRbUabTJc
	5sX8voXKpVOjjeCcOqWlvVNf2glTSSyRlGZVJ90TuoEvLRIWvoZoiNpWLMvoJRLtpGDwlO
	dwK47qW32ajvyuYJt0YMb4iYF/gGzauu9Ahh5ANSo6IEUoxI2KQH5E/s67LcdXBmop4VBB
	T0J8XXPRXKvLWig/4xYxl0x0zfMDF3+ztxFng0w32JjKeR77Tj/78hWdKIQIIg==
Message-ID: <f284e3b9501acca2cf41fd19409004de84a36e15.camel@mailbox.org>
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Add flags parameter to
 dma_fence_init()
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Tvrtko
 Ursulin <tursulin@ursulin.net>, Philipp Stanner <phasta@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	etnaviv@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	imagination@lists.freedesktop.org, lima@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
	nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
	linux-tegra@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-usb@vger.kernel.org
Date: Thu, 05 Nov 2026 13:48:03 +0100
In-Reply-To: <005b77fd-5bd2-4ae5-a0c0-cff3f1f6c680@amd.com>
References: <20261105113529.1989375-2-phasta@kernel.org>
	 <20261105113529.1989375-3-phasta@kernel.org>
	 <2f377d0f-2760-4465-ac68-b62210b33bd6@ursulin.net>
	 <005b77fd-5bd2-4ae5-a0c0-cff3f1f6c680@amd.com>
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
X-MBO-RS-ID: c917e2613df30c27150
X-MBO-RS-META: zhysmcuaysmzyh6mji5yjtb3gu8yuuhx

-Cc rust-for-linux, since it was typo'ed and now misses the thread anyways.=
.

On Thu, 2026-11-05 at 13:35 +0100, Christian K=C3=B6nig wrote:
> On 11/5/26 13:06, Tvrtko Ursulin wrote:
> >=20
> > [I aggresively rewrote the To: list because my SMTP won't let me
> > send this as it was.]
> >=20
> > On 05/11/2026 11:35, Philipp Stanner wrote:
> > > Currently, there are two init functions for dma_fence,
> > > dma_fence_init()
> > > and dma_fence_init64().
> > >=20
> > > Since more future user options for dma_fence initialization would
> > > require distinct init functions, too, it is better to do this in
> > > a
> > > unified way.
> >=20
> > Why not add something like dma_fence_init_flags() and leave the 99%
> > of the callers out of the (huge) diff? Ie. just port
> > dma_fence_init64() to dma_fence_init_flags().
>=20
> Well one advantage of the Linux kernel is to avoid such wrappers. I
> think having more than one function for the same thing basically just
> adds more confusion.

Do you think all future users would want SEQNO64 by default, btw?

>=20
> That's also why I would really like to just have one
> dma_fence_signal() and not like five (or was it four?) variants.

It should be dma_fence_signal(fence, error), anihilating
dma_fence_set_error(), which is just another massive incentive to add
race conditions.


P.
