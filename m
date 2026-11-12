Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473807;
	b=ZZPexh/kqpWJfpvShC6ny71kki/aLgLo22KgDWxNJlL5VdJ0wFhHL3VDGNoaHKApgiAM
	 peNdoHHEbrHt7ZiSdjh0AU/kGOtbNQf+wMIbpTFxajRG4sgxWmIjOKHh4wnigypSmK9iF
	 kdnwd07em4r4dQzD81sHXNfl9mUaKnU9EwvmC6ciyPX0ZuKIf6BVUPYpsOJGY47mGDRHY
	 0d006yk9FV8fndClaOqvkH9MU2nTA38afJiPObdKmWO+CvciqlUesPLvaK1BfbGtRglE+
	 SakEpHdIbetTfovc0odHIl7kpyMed+wmGoBaxz/I9uvvkgYTvtJHm/dFFOmd5PLT0cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473807;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=rEDyzDvctiKMCWHEwGxzSSTUsEjyrAP4XO5pemqaf/w=;
	b=MHnwkbt36iVVK9wrjeKF4BB0W1r9w7sm/jh08SGUAHasary/cb854iWAky0ZGnaP+Fj0
	 oLNieju3hG3wtmunrPDqC+Wu+F2PLbDY1XqlYSCc/RCFMcgl8L2gzfzY3IoDmujMrS6bj
	 iI+Gl1sPRLXJu/kczdCkGBLaV74g6j1kTkVINhLuzd2GxP+54NTmbcfTP4tnQ2rDrpLvF
	 UMJaKm3W8Rq16qNyo10Gr+kWaxUDOc4vq78P23Gs0umJvv9QIAauU82kCqVNQp4O58Q5i
	 4H7ny6py7ANfTVGxUBtm8sOuUbvHGolJQzqdBW0BizCEPMNKY8h1yMgDlMEMM/7nOWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=B3knZGFb;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1UQSHGCM;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6A606A8AF
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 08:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A6A606A8AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=B3knZGFb;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=1UQSHGCM
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A6871D00245
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 03:56:46 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 03:56:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794473793;
	 x=1794560193; bh=rEDyzDvctiKMCWHEwGxzSSTUsEjyrAP4XO5pemqaf/w=; b=
	B3knZGFbJoyqxhvAjg5ey4pgvXQ0+dX+2yrqxypUpfmLl52FvtNsp7+AX8SbQ/eD
	QB4o9/31f8xFXCXe56hraiMz96Up0KKZvOb2Y5C65VShVM0pPaDafBjDrSUg42VY
	tu9bgejyvmqkt1Sc9Y32autzBDXmungVYOYMmKlWzY8ke9h7yX3aXbw7wQqSIKs3
	owqqHduQlPeKvwCMeJG/2LJco0+TSA+EyuE40Mo+9A/AlkXjnBpb4ObaqIe0Doxc
	7R11bWCv4vRYIh1QpCl5N1NsJgYyvfBQVk0IZtDm5jfVeuHETVudImiaPHrGdr9O
	vc7/hsrU2ooBu9I+vxQIQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794473793; x=
	1794560193; bh=rEDyzDvctiKMCWHEwGxzSSTUsEjyrAP4XO5pemqaf/w=; b=1
	UQSHGCMZ2A3z8bSIkkWxeq6RnxTXCPrxpPWHAyytgP+bJFnjHFjyYHqv4hm0qCHi
	QYj5WIQxDSWITpVoqdkvKqOQ6WfVb701r08hcNQLu5c31R4jKN1xLVhnaNofI2HX
	7FdlCq7ohwLhQBbrPhAF/DBKK326jQC/kxRtegHB3eLgHLY3PWtxVOOFT5sBaYxH
	iEXrIpL7ps7Vq4atKdHaQMjAWH1A1hydNB2gIjGap0JgIebeP6f+c/OshDqYw/Jr
	vUJZRxhTpwPPzneK6Bk38wsyBQPOmtYPcLegI1AUZjxz+ntB7H/oAx/pXKxLSRwD
	hopHAfS59cof80uyciXMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794473793; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm2:rsa-sha256:jfxHLyYCcwAagPZC/fshPoUZYECusD6lk3A74VljGCAqhQb
	mEPnV/FNKvBIXqmk1vuFQqvIdVthiaKe3vqg4g5NqKuiXaOkxHOB3qhxjH//O67z
	cnn5+zg/2u96yQ0XEhHCUMjVnkozHoNR6JpQBgTofZ50N/E8dtlts0/NCmv2a0sC
	0Ky32J964flmed6La1EVYUeJz2+yeeZB2YElK1GX0UfxaKMqHLupseN6sxHdhKmD
	1CDCUzaC1SKLfqMbccHvRuW6r6Sshw3577z1ap0iZlyy0Oe9THL1bH6oUDolxdRC
	NlKb7Xx+yAT3pPTH6TdlGg2rcpq+lBVhgUGZM+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bxT2HtsddpIKccxw7D1EmmeuIKfYJp+MJ2nSGobHrHU=:sEmA3MCn6JLrIUaQkRNBmsF7Hz02Y0iwntBVDLMI0ZY=;
X-ME-Sender: <xms:NH_1asWKISFAZPfViYwtF0t1h1O_t_TUK-yUOcamOFfpOmsJjSP4yg>
    <xme:NH_1arbnH92k8S1-bT0BlraQyd9qZk0y0Sn00uORJAF8vwlxDDfIbDO0bjykC8awK
    bmkq2V7jpdyyeJMnsesd2PBlWQc6-IxQ5LTwSVYBMhTPwlK8kfbKFQb>
X-ME-Proxy-Cause: dmFkZTE3ND7a5+W1Z07eormEvJEB+XP9yRNxmJWlhqo4nFZBM2kAyJQF7ZgJlr2V+yFcEa
    l9MRmavypBJJ+1A3waVwnEHhrM4U0pZpCmMYKIXvfnZkXMGbKdecZtrxLKkn6LEq19o5fE
    gPq8WxneDUi3v4xiFBdFxJqhhRjF9l4qFHfKxbM/8/kEKMzoow8MOCqc8EgLK/YGye/NOx
    vJ+BeW0pJ1MEvAjPtKHXRRQgaz1GtmTJKeuhP2oScGxUjAxi6NvtA3CvTfeHnIQJVEo9ZV
    dg2D6P1vG5wAmVpHBLy1jTDsA3jHwbynxf2/c8p8S1vmmHEGJ6xAPZTTV5Umrrj1UI3Khs
    rJijqRdX01D2IUPunT3qBzgERFBVZ8jYBYw1H3yAWZItZ9j4airbtb5XjMvlG++YM1xjMj
    nmYen9siqd5jtfWF+5rxuSCWu//0CHbbjZOuheK/lwuiWNnUidGYUvyWOFd9E2OfMRQyJo
    NHUJLrgFmF/YLzCIRd6QgoB46bEjyL4va2ECLKod74mkfUM9Bt3nKjoMZsBw6FKGE9i6pb
    kcdlCi+42mrcvNt9/oRYrgd7nZbADhLRxQvbPjTXfqJ8XvHIJ7OuVZ6HyNF9xugO4WyMQv
    IHitba4dtlHe8UFBYfWm9s4Tizbuv07yoIS03Wj6UhMEjI5BgOKm5i1NzONA
X-ME-Proxy: <xmx:OX_1atJeGP10qV3r_BB9LlbDWvzjzAT8IKY6g0XHpnMofHCEovQSTw>
    <xmx:OX_1ajjzmcyTWNa03jroLuvYNjQrc-9N6_xxwGxAK_v1HHphOwD9Lg>
    <xmx:OX_1ahRgitGd4zqX3yfmA8xLG4zFwqJjTP381SaWrv0nOrdNocAf6w>
    <xmx:OX_1aoabTMJLtPTZZWDyERW41w-hFW-0kPrJfUFDo4kw2bxAwi0xvA>
    <xmx:QX_1apsoJxByQcSYtOm475IyTqWu9-y7wuRQ59vqRM_Lw5w34HoWDLYb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1A43C32A0099; Thu, 12 Nov 2026 03:56:20 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AD8wiEBgakfZ
Date: Thu, 12 Nov 2026 09:55:48 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Matthew Wilcox" <willy@infradead.org>,
 "Kirill A. Shutemov" <kas@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amit Shah" <amit@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Zi Yan" <ziy@nvidia.com>, "Bernd Schubert" <bschubert@ddn.com>,
 "Hugh Dickins" <hughd@google.com>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 virtualization@lists.linux.dev, Netdev <netdev@vger.kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 "Malin Jonsson" <malin.jonsson@est.tech>,
 "Richard Weinberger" <richard@nod.at>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>, "Nishanth Menon" <nm@ti.com>,
 "Frank Li" <frank.li@nxp.com>
Message-Id: <e94bdf7c-eae6-4f64-bf93-0aeedca1a22e@app.fastmail.com>
In-Reply-To: 
 <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org>
 <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
 <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
 <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
 <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Nov 11, 2026, at 20:26, Linus Torvalds wrote:
> On Wed, 11 Nov 2026 at 10:53, Christian Brauner <brauner@kernel.org> wrote:
>>
>> If that's the official new stance than I'm very happy.
>
> I definitely want to remove HIGHMEM entirely in the not too distant
> future. And before we remove it, we can most definitely document the
> fact that we will not be worried about insane users.
>
> And things like security issues count as "insane user": if you use
> HIGHMEM outside of controlled embedded setups or museum pieces you get
> to keep both pieces when it breaks.
>
> IOW, it's legacy. We should aim to not introduce *new* bugs to it, but
> if there are pre-existing bugs they very much count as "don't care",
> this will be removed soon.

Agreed. There is also the option of adding Kconfig dependencies to
mark things that are known broken with highmem when we either know
that it is buggy, or we have a good reason to break something that
none of those remaining users should be using.

> I think the only reason it wasn't removed a couple of years ago
> already is basically a few old 32-bit ARM platforms that still used
> it.
>
> Those platforms still exist, and I predict that they'll still exist
> next year, but if those users have to stay at the current LTS kernel,
> that's fine.

I tried to push for what I thought was an aggressive timeline
last year, but that would still keep the Arm bits for a couple more
LTS releases and only gradually reduce the scope of highmem in the
meantime, removing support from architectures, file systems, and
drivers where possible. See https://lwn.net/Articles/1051010/
for a summary of my talk in Tokyo, including the slides and
a link to the video for anyone wanting more details.

I also prepared a number of patches towards this, but have so
far not been great at following up to get them merged, sorry
about that.
I definitely still want to revisit this soon, in particular the
bits about defaulting to VMSPLIT_2G_OPT, and probably my patch
to allow having (limited) discontiguous lowmem on Arm systems
with a large MMIO hole.

Scope-wise I think we absolutely need zsmalloc (zram/zswap)
on arm32 to work with GFP_HIGHUSER, but enough people have told me
that they still expect to need anonymous memory and ext4 page
cache for a while, and probably powerpc32. The majority
of __GFP_HIGHMEM allocations can probably just be converted
to use lowmem, which would eliminate a good chunk of kmap()
calls as well. In my attempts to do that, I came across two
problems I'd have to solve though:

 - Movable allocations (GFP_HIGHUSER_MOVABLE) imply highmem.
   while I think only 64-bit architectures support movable
   pages today, we cannot currently express an allocation
   that should be movable on 64-bit but lowmem on 32-bit.

 - Internal users of tmpfs (in particular DRM/GEM) usually
   don't want highmem or movable pages, but actual tmpfs
   does default to GFP_HIGHUSER_MOVABLE. Separating the two
   is complicated.

I added a few people to Cc here that I believe care about
having several more LTS releases with some highmem support
because of existing customer requirements.

     Arnd
