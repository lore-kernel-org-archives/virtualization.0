Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777272BE05B
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770072880; cv=none; b=SpOR5f65xvxPTonPWxiQ7A+U/ho11LvLvonjEB9yDQwcbSXXc0BSHKeS7Adtl40MLIo1as4IBPE1vDOhxDCidKNTzdDhPNCHdd1w4GuJm9c4hzSIkvvFz3pHY/8Zf/Q+cA0Lrs/TsDT2u+sjze6W4+Aak7YEJH0R8Cg9nAe80+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770072880; c=relaxed/simple;
	bh=kO2OdjGJkl5cG1pUcA6A+dYqrqKpdB9d5eYHNdrcMiw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PuoBISPBxPdFiYPMO/EE8/9LZDNSL0JYLHWYPtl/l0/Z3SwSuMXxLdC2xWsY+0CejNJXeys+BOcIHLMpm+r77eHJU1nqlFDjTE0XZi8qT/RY9H88IAfSOAcXm5djBGaOJNyFB5BXe/WBquEbkHvNyLHpgBtGgvNfTknBRJGaOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ck0yhdDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pw9Bhim9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ck0yhdDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pw9Bhim9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFB40140013E;
	Mon,  2 Feb 2026 17:54:38 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 02 Feb 2026 17:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770072878;
	 x=1770159278; bh=ow7F9Go20V5fmmV9x+7vVu68DePix131nFmr3pVXz/0=; b=
	ck0yhdDZtAdAYqQ0vUCaaTNT//mqjnh/drqIrG5KzICuznjK/7ACmHi1H5hdNiie
	CRWevAis7FzGaNlGhIyPuTyHsOSX8m/BrUDYeLYf1/IBduM474/TWyIy3PZ+PqGC
	ANwcsDrjguM67fghbTuZDfArOsR/9s31n4ZAmRLjxNYjCyym/azl4ccwdv5hNnNP
	PTzXvkwwo7+YsuyJFO5ta/S7BJff6BMTc6ortyOd/vIJxhDoI73hqJOr2qynfmYI
	RliAt1tb8nd5zit9KRcHZVcrZeM558RCWP3V+tYf1QiLv1nQVZyUX9d+2KhFgXk9
	iXAfnl/zNdIgehBa1vZE+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770072878; x=
	1770159278; bh=ow7F9Go20V5fmmV9x+7vVu68DePix131nFmr3pVXz/0=; b=p
	w9Bhim9HQ4mZni1lExjHWAzxsKNRKJu+myTxSV08WJqnjY2I1aFN6CvAkfrUgolK
	t0pi7hN2Aix1Bim07OdGRWbcP8Bk7oxkVBz6TrJJ+aVmAeWm+XmrII+uJ0O5VQuV
	r3lyWwtYssgZbKcRHtKva70YKS3N2uT//10ijh2hU3XV47fcEGbU339flf/5jaiN
	5gEsb4rd0kggzfLeq9FcJuGOnuflZHPryfC9Y/iRmk3LVrpCxeYwsp5qcgKOphjh
	DXjW0qV6T4NGisNyegplx1BjoN6eScOtEZAS0JokbvNfQ4z8o0qAvWOaY9YntK3W
	utbznnP1QPNylbDo6iG+g==
X-ME-Sender: <xms:LSuBaXxHxm5T3UcG7w6bX7T_WTWnnz7xf2J6Lxtaay9ud-_YHShvPg>
    <xme:LSuBaaGrhJhRRlYA7OCHIU97KSgu_BsHe54PQz0yJ6DLcgMc6Zf9Cs2s0eKwYBBc8
    b08y1fIL2tTf27GCE899ANtjd4xRuGZ0t8F95UnI4MC1_-KmYelMBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopeigihgvhihonhhgjhhisegshihtvggurghntggvrdgtohhmpdhrtg
    hpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhguvghrshdr
    rhhogigvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopeiguhgrnhiihhhuoheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehvihhrthhurghlihiirght
    ihhonheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopegvphgvrhgviihmrg
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehmshhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrg
    hrtghordgtrhhivhgvlhhlrghrihesshhushgvrdgtohhm
X-ME-Proxy: <xmx:LSuBaXUfAgMCnc72M_YoioKuJEpYW9S7cxj_ih2rYH4G_PYNmfyXTA>
    <xmx:LSuBaXyTeGi1WqYciA6Iq5dbe9Np5bqpMaznxUHbQORON8hsaT22SQ>
    <xmx:LSuBae_1otegJaeJw4JJpNvDw35zVtN2Ee7e0onKdHPtBw5eAvRKAg>
    <xmx:LSuBac_2I5bahtSugbrCqhB9eVNP3YoDxm_J2PPdj-buH5loa493KQ>
    <xmx:LiuBaY9MfjOggP8mBNDGuNFggI95ezPm5P7P8WFvG-M3Aq88LYAgSnJf>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B487F700065; Mon,  2 Feb 2026 17:54:37 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Ae52e6Y4Oh4g
Date: Mon, 02 Feb 2026 23:54:17 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Jason Wang" <jasowang@redhat.com>,
 "Xie Yongji" <xieyongji@bytedance.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <34d3ce77-84b2-476c-a678-e092831041ae@app.fastmail.com>
In-Reply-To: <20260202114412-mutt-send-email-mst@kernel.org>
References: <20260202095940.1358613-1-arnd@kernel.org>
 <20260202095940.1358613-2-arnd@kernel.org>
 <CAJaqyWeJs4u6G46gEg=-G6o3u6LsgzVC03fTGR=O_qd_HujLuw@mail.gmail.com>
 <30db98bd-8361-46f5-aec1-ffbc4e8574dd@app.fastmail.com>
 <20260202114412-mutt-send-email-mst@kernel.org>
Subject: Re: [PATCH 2/2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Feb 2, 2026, at 17:45, Michael S. Tsirkin wrote:
> On Mon, Feb 02, 2026 at 12:59:03PM +0100, Arnd Bergmann wrote:
>
> I think .compat_ioctl would be cleaner frankly. Just look at
> all the ifdefery. And who knows what broken-ness userspace
> comes up with with this approach. Better use the standard approach.

Sent now.

I'm not sure it's much better because there is quite a bit of
code duplication, and reducing that would be a larger rework.

It may be best to hold off on patch 2 for the coming merge window
since the compat ioctl code has apparently always been broken for
x86 here.

I hope we can at least get patch 1/2 merged along with the
new code though, otherwise it would get a lot harder to sort
it out properly, with the v2 struct members overlapping the
old padding fields.

     Arnd
