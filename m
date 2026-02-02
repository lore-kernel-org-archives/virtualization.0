Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242E83644D4
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770034039; cv=none; b=W9bm8dkGi1uVlBKaP+KzqiRwdWED8XRm5S/sVEXHGiYiPN5wVm+7Cm/Pi5CUYTlrfHDllDgXb3RzopTlCaMN2QalA3ogwWojv1rjxml5gj2Io50agmYz2PD7xA54fu4/VZAcda+KU4UJN3X6Kpz4WNyNZqN6V7MkEqssTAe+5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770034039; c=relaxed/simple;
	bh=42NxHONkRxxl2c7nMa+di69abEvgE3dEdDQ3EZH0ki0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PlXMFVEXoKwMM+O/S1xYRLaNp+78qJ/o1Hb2jzwDeQ4gzqIJ2DMMe5xKelzdiyNYbrwoUPC2uWtE36cR/0n/NSB7oO9TkPaoZtMl2DymE0IBSGRMHaTIbkR8ED8TXSmvXCw1iymIZ1alDCEeyDBc65sg8f02QklL7cmUK6uD1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=p2IqFizF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LWN69xcK; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="p2IqFizF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LWN69xcK"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 48DA47A0118;
	Mon,  2 Feb 2026 07:07:17 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 07:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770034037;
	 x=1770120437; bh=ttfX/vVZTtwIHHtsk0Vs/aH33Xnzgvg13v/bByVDe8I=; b=
	p2IqFizFVcYqob9ddecAt0B5cVeApJheyQKcYuqf3z4Zgpb1ZIQI6FDtsS3ppKJm
	jkCcfk1VArSlAJkj48dkX2TD76j2yBBMdU1h2X68DleeuWg7rm/85f+OVhDQfu1S
	aFkx46UcJCWwV4Uq1qSCYa2CglmZgBfTLvOMHfo/c00R+C/GGxqLgvPaaDKgC7vI
	3GuKN97zFWOwCsuBac5QV2B5NUTswsEdSx7f3dCzGJw13fIVjjldnclRSYg+0XAA
	ehaqug2sSPydxhFdDTL0zDbGkfoVBjEZNzruQIanLrwGeEPSkhvLEo/4p9kyg3cW
	jIvTKhyV6wZ/z75yTxjNHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770034037; x=
	1770120437; bh=ttfX/vVZTtwIHHtsk0Vs/aH33Xnzgvg13v/bByVDe8I=; b=L
	WN69xcK6oLsv85LTchysd7GDHkNNl1XIXyRnkeoWSg3+NzRdGI0XiJqJR7p9BwrU
	da3aLFxR0tmhjDwe2aLJgzzlcG5iWdatEkjt4jUngj7QllVHOJm1eF9rQtyAX6Yi
	8LkCZ7aMgB201WAcq+YD3V7NEKDZxUTfxFcVQ76rcUfCR5kzNvab1fhL5V1xGCPL
	NP10AFhtExssz6VW3WaFsyLI8f7LxHm2dxFH99NlDXk3e9o57J4Z6U0i8U2/+Qyy
	C07iJsQDcBMlhYaolRpi4GVnxvX2tFeGWzvpbBBMoDIP2RaPGH7WPOxsACm8bSG1
	xQKBgpk8V53dlSaVMcTCw==
X-ME-Sender: <xms:dJOAaWzZY8eCk2wdRY5MCdCI9S4tOMqL1XqcHHheLakGg4esgKNNWw>
    <xme:dJOAadFu-Y2lLRBh8W-Q68Nr-qiHrTyB6j2EMASxpOyh-bAxydCmFdgcW1Ce8-GgT
    gqE7DW7fw3RYtU06egl5HVyZDIyVpo32NNNtzvMzNQmhwvtb4O-kU4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeejiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeigihgvhihonhhgjhhisegshihtvggurghntggvrdgtohhmpdhrtg
    hpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdr
    rhhogigvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopeiguhgrnhiihhhuoheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehvihhrthhurghlihiirght
    ihhonheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegvphgvrhgviihmrg
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehmshhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrg
    hrtghordgtrhhivhgvlhhlrghrihesshhushgvrdgtohhm
X-ME-Proxy: <xmx:dJOAadZoWdTHbMwLDl5ogKLIButEWT5uc--foij-k_fFcuZgx_8HUQ>
    <xmx:dJOAaQNSu7QbGGv-QRkVpaLYu6nBPATPb6ek2uKexGRtUJjDjRbWDw>
    <xmx:dJOAabXWhTwl6_uVeupYTPj7e6B_J8BxUHMPZ6DPTYd_d8ofz1oGNg>
    <xmx:dJOAaVJGbRvzf_uqeCWhd9DghIJmiwXc50QjY5R408HL5vzfwdPtRw>
    <xmx:dZOAac--h7IogPau9tX0CSDZ-MDVwzmsOh3Dp_JzjteppJgZo25SsmoY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E815D700069; Mon,  2 Feb 2026 07:07:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: AdUKGF-S8qY3
Date: Mon, 02 Feb 2026 13:06:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Jason Wang" <jasowang@redhat.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 "Xie Yongji" <xieyongji@bytedance.com>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Ashwini Sahu" <ashwini@wisig.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <2941167c-822c-4f37-a3ce-803bb94ab566@app.fastmail.com>
In-Reply-To: 
 <CAJaqyWeLYCTmOAqOPuLZWaJWGn8Tg3uf4DtYTZYpvZUCXxxYzg@mail.gmail.com>
References: <20260202095940.1358613-1-arnd@kernel.org>
 <CAJaqyWcrjuQAp=sTfpiQsBu4pS7sxix-ggS4BPCzxyDwW5MZQQ@mail.gmail.com>
 <CAJaqyWeLYCTmOAqOPuLZWaJWGn8Tg3uf4DtYTZYpvZUCXxxYzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vduse: avoid adding implicit padding
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026, at 12:50, Eugenio Perez Martin wrote:
> On Mon, Feb 2, 2026 at 12:28=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
>> >                 ret =3D -EFAULT;
>> > -               if (cmd =3D=3D VDUSE_IOTLB_GET_FD2) {
>> > -                       if (copy_from_user(&entry, argp, sizeof(ent=
ry)))
>> > -                               break;
>> > -               } else {
>> > -                       if (copy_from_user(&entry.v1, argp,
>> > -                                          sizeof(entry.v1)))
>> > -                               break;
>> > -               }
>> > +               if (copy_from_user(&entry, argp, _IOC_SIZE(cmd)))
>>
>> I did not know about _IOC_SIZE and I like how it reduces the complexi=
ty, thanks!
>>
>> As a proposal, maybe we can add MIN(_IOC_SIZE, sizeof(entry)) ? Not
>> sure if it is too much boilerplate for nothing as the compiler should
>> make the code identical and the uapi ioctl part should never change.
>> But it seems to me future changes to the code are better tied with the
>> MIN.
>> I'm ok with not including MIN() either way.

I think it's more readable without the MIN(), but I don't mind
adding it either.

>> >   */
>> >  struct vduse_iotlb_entry_v2 {
>> > -       struct vduse_iotlb_entry v1;
>> > +       __u64 offset;
>> > +       __u64 start;
>> > +       __u64 last;
>> > +       __u8 perm;
>> > +       __u8 padding[7];
>> >         __u32 asid;
>> > -       __u32 reserved[12];
>> > +       __u32 reserved[11];
>
> (I hit "Send" too early).
>
> We could make this padding[3] so reserved keeps being [12]. This way
> the struct members keep the same alignment between the commits. Not
> super important as there should not be a lot of users of this right
> now, we're just introducing it.

I think that is too risky, as it would overlay 'asid' on top of
previously uninitialized padding fields coming from userspace
on most architectures. Since there was previously no is_mem_zero()
check for the padding, I don't think it should be reused at all.

    Arnd
