Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8582C25A640
	for <virtualization@lists.linux.dev>; Sat, 14 Mar 2026 15:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773500796; cv=none; b=dsx9lYDdkS2A/EJmxlmkbiL7RGkNwerHzCKB+Tfzd4ApmFSlMrmkXTVMzZ4+HXIWyTxS9OSmk1mg4QhO01Cm8+IwiZ4E3h8LomSGPzdsSgDlBilrTiNHOuKfS4W76dt1i647xkO36H46c3VzdwU79ssdHeomaVQvDervmd9sTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773500796; c=relaxed/simple;
	bh=DjOIWh8mP+tqOLjeXPcpIXgFoeFhMfd14g70z2kWO84=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=mCOsWI0cz67/RbbKjC/M4eILXyUnTEveMN3peEKzTB4F83oFhG5GrsbYRg3ph4csCAVXPOPn1ojsyu6nvy+Uk0W1Pi5tr3mLI+nG03D+Gtu/ItpiooUxjXZO4utSiCZiJr74Hwv2cqf+OPIMSD1m3V169fb8WZM6x0Uuj5F59qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbchEqE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbchEqE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5891C2BC87;
	Sat, 14 Mar 2026 15:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773500796;
	bh=DjOIWh8mP+tqOLjeXPcpIXgFoeFhMfd14g70z2kWO84=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=mbchEqE4NMQeabuC4Ex1aAcyPlsmSXnr97klLLQD+st9XmxiqBC5W0f/Cuvc6qjkQ
	 /S4j3qljV4HTLH/3Htw56pNln+IEdSKxn99Xh0pdDegUOFb7gLlQ2LPpV1uuiqNMWs
	 FyrtrJwFpagdT9gWZb3u4RV5tzL/ovWGvJRXfXNmtLKHTbLZEflUn3kHmEa1l5ilww
	 a37m+HIOQ37yVOzTda005jKnFT1wlOW5vHpQc7kJ1xjXWSvSNK6UCbFUxwHw9h2ggI
	 VZhXypJMnGY0bvcLVhO0d0Duoe/10qPshQ9po9IqelCFf6skf4PS3isIaLF/dSn4K/
	 qG2AXdu0oC+bQ==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id BAAB5F40068;
	Sat, 14 Mar 2026 11:06:34 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Sat, 14 Mar 2026 11:06:34 -0400
X-ME-Sender: <xms:enm1aaKK2lij2vTJ_J8CAgZWvs_QTKhaADF0u4uVOpv_8V5ejOjVHA>
    <xme:enm1ac9mgVIfnR2Ws9-I3JN_r1T7jkmbVc2yUsdI7J71ciE8vo3GZ-MtAvytG1jeI
    UbZs2yhKAdGRhxNb52E_SVt2hjlQ7oelgaz7oqLFzCGvcf5I7B07jk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledvkeelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:enm1aTESzz5kMU-ZBzNqCu8dtE-OK8p2NNeEtAy4kCd8_DrQ48DAWw>
    <xmx:enm1aVR6OxmgAiVJ9iBlsWRixErn2UXVVDa6aHWQ6q8sMMxulz_6dg>
    <xmx:enm1aZa9Kk3wL6B_QGzbrOjSk6YmZ1rkRFy8Apo2BPCp_XiqvAMGsw>
    <xmx:enm1aQ0zcS3EqGEeEZX7FvMAAM8JkkfgnwAvwiw7u-qvJylb9pDChQ>
    <xmx:enm1acpmEywECUF5AfWo_3KdyycODolBkkMszkc-K18pfyghEHx4ZYdy>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8CEAC700065; Sat, 14 Mar 2026 11:06:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: A_JFFDpqd1hJ
Date: Sat, 14 Mar 2026 16:06:13 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Daniel Palmer" <daniel@thingy.jp>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org
Message-Id: <ada73dc9-edf5-458c-8849-9f9db23ff304@app.fastmail.com>
In-Reply-To: 
 <CAFr9PXmG6=NjscnsS=DHgyiyCsNSh8kaGyO1ujPHOsFySZhjMw@mail.gmail.com>
References: <20260314030612.1949420-1-daniel@thingy.jp>
 <20260314030612.1949420-3-daniel@thingy.jp>
 <32d021cc-0179-45de-b832-f122698211fb@app.fastmail.com>
 <CAFr9PXmG6=NjscnsS=DHgyiyCsNSh8kaGyO1ujPHOsFySZhjMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-mmio: Use raw io accessors to avoid arch issues
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Mar 14, 2026, at 09:32, Daniel Palmer wrote:
> On Sat, 14 Mar 2026 at 16:42, Arnd Bergmann <arnd@kernel.org> wrote:
>> -
>> -#define readb __raw_readb
>> -#define readw __raw_readw
>> -#define readl __raw_readl
>> -#define writeb __raw_writeb
>> -#define writew __raw_writew
>> -#define writel __raw_writel
>> -
>>  #endif /* IOMEMBASE */
>>
>>  #if defined(CONFIG_PCI)
>>
>> Can you try if this works?
>
> This builds but doesn't boot on my devicetree'd dragonball branch. I
> don't think it's possible to boot the stuff that is in mainline (and
> you wouldn't know if it booted or not due to the lack of a serial
> driver). I think I can fix my stuff so it works with the changes in
> readl() etc but I think there are a few other people that have their
> own 68000 trees for weird custom boards and I guess this might break
> their stuff. Not saying we should force a change onto virtio-mmio
> because of weird hobby projects. Not sure what to do.

I don't think you need to worry about breaking stuff that is not
upstream: it is the expected cost of maintaining custom patches,
and you probably know who those people are so you can warn them.

I tried to find dragonball specific drivers in the source tree
but couldn't find anything that actually uses readl/writel.
Since it didn't boot for you, there is clearly something, but
I wonder if most of that is just your own out-of-tree code that
works around the endianess bug in asm/io.h by having the opposite
bug in the driver, i.e. using readl() or ioread32() to read a
big-endian word where it should have been ioread32_be().

     Arnd
