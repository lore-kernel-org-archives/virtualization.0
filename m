Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483310;
	b=jIFy4UJR9+Ik61OXQIOC+MAdaU3ORkuulMneHkweLjAvcDLTRgm7Rfl2mWrlt2QVflBk
	 MJbiuggBuU9D/vcnFMM0QqEh9y+mTGBtQPzMF5dPJdDjz6q7HGfCgU+lBaIjjXPkIDh3X
	 x1sUQQWM2ZBlaacbqkzMDuxCIx5sgr9h3jMtbPCb4At3gCiLP1rF7SUp0IGT3OgauLKWg
	 jw1Zx6j7+LxCS5ZfQDOeOh1soKtvVauzkhp+jgvbBP5n5FUFa+Y1NdXRd1j/oPwXcthLJ
	 GNwXgPjy9vfQ2bY8PW7MvRn9+Coht5ENGgFx646aGETAJAvnZOtV2kO9m+wKBD99iQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483310;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=FpibZxpHOkegx/nWCVPd2wzoEHQ0LrdmDgeGw81ilYs=;
	b=qJaFFPT3Q4ue8bgXWHcF+I6Pf1yEF7fW2UXO8NdS5gGhy3jVEkuTkzmRjeUc4ou5cy+p
	 cQcVV1iLw+WVbkilGiuXOCSDwCu56wlJ5QmrO5pgsurH8p9WinWbgBZbM/T29tiJKFFa/
	 SckIhsvVawERtl0uDdBIUGdnwoPuUbs+Qb0/svI9Qye8rOk/8vViTIEFGXpa7jOaM3IAy
	 8wPddVqNk4lydt0fMBtlD49OWbhiPL6WggO/ynNr3pEzSdOIfHdMo2aaHHFFexZ8BkK56
	 8ce2iGtY2CfEhoBDCMfXDrTPhZA1oy2ynF4xpDUZEgYAr7nOZ+RS4A7KwejONII6Ihw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=YnjyECYZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EoYAqh2K;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3A606A321
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 11:35:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95B3A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=YnjyECYZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=EoYAqh2K
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA96B7A0157
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 06:35:08 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 12 Nov 2026 06:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794483296;
	 x=1794569696; bh=FpibZxpHOkegx/nWCVPd2wzoEHQ0LrdmDgeGw81ilYs=; b=
	YnjyECYZ5KqjOOxhuESWXFBKhCb+g4+aQMsE/ayy4dx7HTII8DY5qC6L8N5Oq4B9
	aFFXcVADNerTxuZ4qxGAhtHAqG7Ds9FiWH14HZS5/r8aFrj90hogyx0r63B7GN4c
	HTIWiMrRFywAvU3cu6PSxo2mEo2wHUJDFH+hYNAWajiu/5LbHOW97cdZvILz0fXn
	zhXASZyR+cnTWGJUeUnrDTYmxAotShzqzAc1UE0CnIEEVgGEdHO51b+oEE2B2vkk
	EwZnIwY5apX3sJ8oP4as/cbvF9EiHf3aJu6JQzQ//ouQdy8tS+4ndhErxFr8A4/6
	Tmv0hIqSBbeHpYbwFYmXBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794483296; x=
	1794569696; bh=FpibZxpHOkegx/nWCVPd2wzoEHQ0LrdmDgeGw81ilYs=; b=E
	oYAqh2Knmf/M2+WL/lYcoYF9Ubw58FO6mJetTaHFy5/LP16KrM7LNtkQamogUqAp
	X7qOCs4RlUds7Dc8mnpN9h2grKnPJ044gBRfEW1iMn2iEBAFLPpMj9oeDvbhgMLq
	b6uWz+Nbru7IoqVwpNkOKvRNUjKULEjAX6ea+yAVxCmTyRnMRXeVafaghHJ5HyIS
	1ULFS78SN1e76eEVZlzBDFGTJ05IuWbSK4eaq6hnSXhgZHneGIY0notj7lBz74rL
	uL+9I12v2l4s1bQvCH1OtwBpPFca9Z1PmeL2NX+n5X1QzfSwPjyPMXPwQxPltDzp
	cspv0AX5xv2pYGnj9IjMw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794483296; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm2:rsa-sha256:e17VSDg0SYlx26VLMMuRnxz6LS5nKONSl1sSn5/U7H1EzFg
	T9Bx+t3UkikCC1ODwdvpo3zx5yW2IHYjwH0mpsq2yOveBZ0V3Vc48vNCEJhny/4K
	R91yHCKnfRpe9Y4/yWbAiw1gEYY0+8MYXVYqOsjLv2PqynYIyXP0m+6wV5V4/A2H
	wzWNzEGsBWcKke481+x8pVXjT31ZFBVOfyCtiJJbd/C6Q5yEmqPhbsobqgbUFiN9
	g8msBPos6XZwcKF/tcLJTRwdDFhI/iwqvAgAmzZwKadhdIgCuIH216+rRKFvw6Tg
	vQzzr6jw0FPLEttCE7e9ewnJyqYOZ6dszjCaYVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LrLjs6XTKWCSSNotOqYUK9bd4P/Tv2a4idtoIaia+Eo=:caBZPj8plx3VSvs+ge8aezudfEqyHYXFIacZdzWX234=;
X-ME-Sender: <xms:UqT1asJlqyiyyIypv7wjKPJ9lHZ4L4cP4JeT9jTkIAnyAnwO4uj5ag>
    <xme:UqT1am9zzTRNILYWl5sBNEECXIDd5mHUoOkovydHISaB_MfOSPgBXKFeqXG6sUAnm
    TIuHDmjBLIa78wscurRNaxv9g-jg67zFAV3PTKaOBf_HtICSd0ADG0cUA>
X-ME-Proxy-Cause: dmFkZTFK6NqHhcvznJICrUy/D/REKnqcZEEPxcmeVbqSM/sH0tEH4MlhHzwubOud3I7xCZ
    nREf/SCeRN3WTSxr53ekKjNkoeLgpEJs5urD1/PA3o2atIbiI/NqMdbga4WzwAwMLtYZ6M
    g9wFUGTEOmpXYzjzK9On5HW9cVzMWqAYlx/bYQ1R5RVqZZARJ3ah6bS6Hb7DKTN+3ITNhN
    25hYTSTE4KFT5WWR/bCD1zQulC9fpiIoQTwVpHiOO+TXtva9ezDSSYqcNMlUs3dVzLB8Ua
    ee6nq1ZeuK2wjkieQK44K9yCD1LxPt5h9F/VCy4zZBHyLneRDGN3aphYXMbGTO/eMhh4gw
    7Q+tYUI3Sw8I1/2TcdjW9OAK76ncriH2Jy6uu5YDDZkP4V5JFV1lzBZYxM1KSpUhkFLJqD
    FUUlY5ijAMmgVcahPXUKnn7ptM5Dhp146Pjp7t9LKG0hp4H3j2ebQrUYk7CPa7R47HZqcZ
    wRDqG8Hz0RFTRI4CWwU7sEvcIBC8qXuTl3Oqhc1vbL/iMEd9V0FDMtz9h0kXFz3WpA3EGE
    +AR168DYzFjnr/nkbQWNuy98Ow3hAGNAOq6kMs1UJBkgZaKywh5q6uVbvRPEX4kb5XLPwo
    KQ5vszXkt/F7xUNHFSFfdp/7RRpRLdvaE03bFNZPayUSgxOd+8xrqM+yvkng
X-ME-Proxy: <xmx:WKT1ate0JSmoljTP-1RvObYglimMb3meuI6LWzSKhIqS161hEmakMg>
    <xmx:WKT1alkRLCwtkeL289w15sRJI_h9Kl2o7gWJq1zj_lp9iyEoMvFfGw>
    <xmx:WKT1aiHaPi7iX7ijag6QKLzhk2icR_DyPcoc7lQI6QBRB_C_Cep4ag>
    <xmx:WKT1ag9ByCoR9wJ701SeJXf3gCON-Apr0Pu_xNxmAv_ysbIxA8BZ8w>
    <xmx:YKT1at2vfJVpoavGotgby5sfMSO1WVKloXsk31C4yR7PRsWzAogLoiYV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1866332A009F; Thu, 12 Nov 2026 06:34:42 -0500 (EST)
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
Date: Thu, 12 Nov 2026 12:34:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Matthew Wilcox" <willy@infradead.org>,
 "Kirill A. Shutemov" <kas@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Amit Shah" <amit@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Zi Yan" <ziy@nvidia.com>,
 "Bernd Schubert" <bschubert@ddn.com>, "Hugh Dickins" <hughd@google.com>,
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
Message-Id: <b90d4bcb-b865-4a41-8496-78d751c03dfb@app.fastmail.com>
In-Reply-To: <bf186643-780c-40e0-bde6-f2af90404a18@app.fastmail.com>
References: <20261110145241.536019-1-kas@kernel.org>
 <20261110145241.536019-2-kas@kernel.org>
 <avNuQqLf9CG9dSsE@casper.infradead.org>
 <20261111-heimreisen-ungeziefer-empfunden-a892571f2c07@brauner>
 <20261111-thunfisch-wirbt-waldrand-822275b2d3b1@brauner>
 <CAHk-=wjPY=kfgnmtx4COEQjD5UzKx9m2-=KLGAZP4d=RKEH+pg@mail.gmail.com>
 <20261111-stumpf-montag-miterleben-c4e2feac8090@brauner>
 <CAHk-=wjGXBnme-N+HvbzHH40ftb7Suc=kZVT5cuintQWyMHJ7Q@mail.gmail.com>
 <e94bdf7c-eae6-4f64-bf93-0aeedca1a22e@app.fastmail.com>
 <32ad880e-5946-4703-9c6f-43ff59da39af@kernel.org>
 <3eb60948-8fc9-4682-87c2-c113e54e7d4e@app.fastmail.com>
 <4d6a3d68-3fc7-446e-9f59-f61d7475e22e@kernel.org>
 <bf186643-780c-40e0-bde6-f2af90404a18@app.fastmail.com>
Subject: Re: [PATCH 1/4] virtio_console: copy pipe buffers in splice_write()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 12, 2026, at 11:56, Arnd Bergmann wrote:
>
> I'll do some more build testing on this version before I post
> them to the list.

Posted with a somewhat shorter Cc list at
https://lore.kernel.org/linux-arm-kernel/20261112112528.1116405-1-arnd@kernel.org/T/#t

    Arnd
