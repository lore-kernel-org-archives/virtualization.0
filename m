Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D340DFA1
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 07:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773474178; cv=none; b=gWuAXAW3Kas3FOtLHAMz1uKYOXfUh/aaJK1v7RmE1RmVFONkjZfZxyfbm3VguCLRrbLot5qtNu3ZU0TO+4d9G/h+yS3z2cV0uWKrugPpoIn4Ks1qsZWJGvbDMJy9igIqnQa/u4jGhxr+Ev3YDbBA4KYwBCZRTvFD7QvxuRDhAAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773474178; c=relaxed/simple;
	bh=jEIeMUVtrBaxSQiAcp/eBis1RLnQ6/4DbywJ5L93jVo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=auuauq9vx0G5iozKlf82bIG0FbCvUSIAf+h53kPVQafJCPW4eFZJZOg/fh/LDxRbl9Ld0W12O9ZcMmCFwHrSV4r3wLdXC+qecMsO99xVU8D38uWn4HVOM37/vm8iP+yOECKvdHbn9mlHDdgT6tStH00159FVSinvI2uYi5/lWlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Opowub4r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Opowub4r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A90C19425;
	Sat, 14 Mar 2026 07:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773474177;
	bh=jEIeMUVtrBaxSQiAcp/eBis1RLnQ6/4DbywJ5L93jVo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Opowub4rBxZT6VAXGz+O5hR2Zl4m7GJ3TRkJygnJOtegj0L/XkXt0uGOzSzrmoZqv
	 0p3ZZulESp4MKRXkfn3hzFT8bqpPa0MarZ9/XKqK2vlz5WvJUeTvqBan8BZdKgMwmM
	 UeBkEYehsow9CiDD2VCQOKstXif1x48dFylBIuqrC+sp6Y4ZG+pF1q47ouq246r1Uz
	 PB9EWcJYFwVhfU228GLOL+jXx8L1Cd27gbGBMeUah/fx+8gAr7v/PVlBirRvNHy/LX
	 AD+sNIzBDGpS2h1Fkqj7IKnjv4iwq3pFqvvTBVyKgTPwpJnAi9Bt2uNIBjwl/cD0oI
	 G9xfOEEU5zVhw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6EE46F40068;
	Sat, 14 Mar 2026 03:42:56 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sat, 14 Mar 2026 03:42:56 -0400
X-ME-Sender: <xms:gBG1abnjJa1NGpsf05kMbWLXYVwMCg0DHfUrCltqpcG2tsc4jBOhVQ>
    <xme:gBG1aZr_1Pte4uv7b78TP4rIysuF-Ze2uDclSnhpr9u4kNemL3XPscEgdhC8R36nq
    aNguMvEhHbRzKK8Pt-w0jbBRXAsHOi-Li9hBpCxIkIM3NIziTCqhE-N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgihu
    rghniihhuhhosehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtoheplhhinh
    hugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthho
    pehvihhrthhurghlihiirghtihhonheslhhishhtshdrlhhinhhugidruggvvhdprhgtph
    htthhopegvphgvrhgviihmrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhgrshho
    figrnhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmshhtsehrvgguhhgrthdrtg
    homhdprhgtphhtthhopegurghnihgvlhesthhhihhnghihrdhjphdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:gBG1acCmrh-Dq4cUGJajzWrnMQwE0D2GYK0uxWcGRxp1vUuy2SijTg>
    <xmx:gBG1aTc1uq2iwvgJsqDmCPF8ncutZwTNpjKegpTCuwxzA-H8aD4UyA>
    <xmx:gBG1aT1CTIasQccW0MO-ue2K3dVDryhijooFZbaJB-86W_AKuFHggw>
    <xmx:gBG1aSi42Lmb6-XBYCZrw3GYr9HnXCL1yUsMr6JUU3ozDvRMbbwqGw>
    <xmx:gBG1aUlVoRQJPV4XLozPBJfQt4YeyuMBjDS3Dkzy-9ksxL_GWW_wZLC->
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3EBAD700065; Sat, 14 Mar 2026 03:42:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: A_JFFDpqd1hJ
Date: Sat, 14 Mar 2026 08:42:34 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Daniel Palmer" <daniel@thingy.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Jason Wang" <jasowang@redhat.com>, "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org
Message-Id: <32d021cc-0179-45de-b832-f122698211fb@app.fastmail.com>
In-Reply-To: <20260314030612.1949420-3-daniel@thingy.jp>
References: <20260314030612.1949420-1-daniel@thingy.jp>
 <20260314030612.1949420-3-daniel@thingy.jp>
Subject: Re: [PATCH 2/2] virtio-mmio: Use raw io accessors to avoid arch issues
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Mar 14, 2026, at 04:06, Daniel Palmer wrote:
> virtio-mmio registers are always little endian even on machines
> where peripheral registers are normally big endian.
>
> At least on nommu, non-coldfire, m68k (see: arch/m68k/include/asm/io_no.h)
> readl() and friends are defined to the raw versions. So the value from
> the bus is returned as is.
>
> Since virtio-mmio is a bit special and will always be little endian
> even if that is different to the machine's convention use the raw
> accessors and do the endian swap, where needed, in house.
>
> There are some places in the code where the little endian values are
> actually wanted and we currently swap those back again. If we don't
> swap them in the first place maybe that saves some unneeded swapping?
>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>

I don't think this is safe to do in portable code

> -
> +/*
> + * The virtio registers are always little endian, even on machines
> + * where everything else is big endian. readl()/write() could use the
> + * value from the bus as-is or endian swap it from little endian.
> + * To avoid confusion use the raw accessors and do the swap here.
> + */
> +#define virtio_mmio_readl(addr)		le32_to_cpu(__raw_readl(addr))
> +#define virtio_mmio_writel(value, addr)	__raw_writel(cpu_to_le32(value), addr)

The __raw accessors are not well-defined across architectures and
don't technically guarantee anything about the access beyond being
usable as part of a memory access to byte data behind a bridge.
In particular using these for MMIO registers (real or emulated)
misses the bits about

 - atomicity of the access
 - emulating them from virtualization host
 - actual endianess
 - ordering against memory or MMIO accesses

I think a better approach would be to change the dragonball
specific device drivers to just use iowrite32_be/ioread32_be
instead of writel/readl, and make the behavior consistent
with the rest of Linux (including io_mm.h and coldfire),
using the generic definition:

diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index 516371d5587a..c39db8798ef2 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -96,15 +96,6 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 		__raw_writel(swab32(value), addr);
 }
 
-#else
-
-#define readb __raw_readb
-#define readw __raw_readw
-#define readl __raw_readl
-#define writeb __raw_writeb
-#define writew __raw_writew
-#define writel __raw_writel
-
 #endif /* IOMEMBASE */
 
 #if defined(CONFIG_PCI)

Can you try if this works?

   Arnd
