Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2B3AA1B9
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129728; cv=none; b=XwmD+SW8zdxYJI5fOkHJ8htqm17ZpajfJprDT8MS5Rz40PZJ4JlNDyaqSsR+T38odscB9IoEiboVNHlJ78BZczaMiWnlrpfUNYOx55IeoMLOy4FjLeyNVURkJxt9NWY/PkO9eAdLfIVhbEzzlLGGXSXzSEa/sSs5muiZFS4c1s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129728; c=relaxed/simple;
	bh=i/Jjt/aGDnEN50gU8k7zcaGyuMfCVUMe5dEWAXe8AgE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=F1fWXc58vcCHsPULF4to/pobEAiusT8AEQDFVerUHH9vJJIVCBdscWiHK6b3+g5cR1CLCa2wJe3E+kThYb/T48SXGwtHXX7M+g3nhPFbYrfenoEwp5iTOIbtTK6DXR1GwwhSE1sjPCkpuCRuWiNv1YDoz1rYk5V6SsyC2/af1Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=krRW37WA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R1eYe8hw; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="krRW37WA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R1eYe8hw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12C8C1400070;
	Tue,  3 Feb 2026 09:42:05 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 03 Feb 2026 09:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770129725;
	 x=1770216125; bh=zX+PA3NBROgw9p7re6cEnyYi9JKRb5HYhbsNkOxVVvo=; b=
	krRW37WAJGcEMMY9RhwOl/4pxiFzO4ElgUraWXjXgCSvzlnIJrS2yZUiNPUNjbYO
	x4+UYpE4JQfTsf4uJZeZxx4QY7/V80PDMr1LoAlF2Ba2vb7W+oa/LmpiER9XI3aA
	Yu4rOK/v7QsUkMEUko9AH7mt2TFlNhci2VzNTSemTs/dPJUxKQcZF+2UDsIY0SMG
	xyIbjcMe11eflojihiX/59A1O0+gOj33SGzQ2d9LfsEt2CxKVbf+DTZ/OM7ifOsp
	MwXVNMxuzGXlsGiJ6JfJ/Fu/iKrozpPShQ/24jiqw+vpKdB0VRqnEZdLfLYFXNtm
	32U/CqUFbBGYXCN6Y9nTZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770129725; x=
	1770216125; bh=zX+PA3NBROgw9p7re6cEnyYi9JKRb5HYhbsNkOxVVvo=; b=R
	1eYe8hwL6hXEcdduB+OtA1xS52tdq4Cr83dLsnhdIsFk+sH6YeUl6GqQkGmxc//A
	vNzP1QnTvlzilSA6MmdsKvYk3NEPuOutGHymbkstP+kIdObrTVo3DZwMICJdC1xz
	ZuCzxa3cPGo/B2AJ7U9fef142qXafE2puKKrQ0Q2LP0+eb9o8i3ld5iuyiQXifsr
	gvJEGTWaFZZWjZuqdBcYtQfCYovqOwNI6LGNWrNlD3ziDJSe8mVqT2EBUKch8BiV
	sdYWmlNxsoPr05+4myPgzmMFUPt3lDoXAUHqx5HdQDNybINaPHPXVKBBaQtsrOo2
	DMaJ48s8ex9TY0rR38Gsw==
X-ME-Sender: <xms:PAmCaThU8x6ebeDHJ0_YozM02A8s1BrEMGmKVJJ3KK3Uq7MjZIP9gA>
    <xme:PAmCaa3_c9pRgCc71dFn41URqOB5zrv8fy4TXtSTcXvL8iDiMAFUFa5hEPSsNeCRA
    brmChgQ-n5ivZWwAv_h29YlwSdjii7v7chb2JE3nQR94XEfxRkRpank>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukedtfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
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
X-ME-Proxy: <xmx:PAmCafGXQPYTtM9el9WigbvYuuHIBehr3-RESzWVQrVcG_uhXzFRBQ>
    <xmx:PAmCaUhIobTcSTI9iHICZOG86YPuX9JBMagTeCPjO7kFYhQ-kqscYg>
    <xmx:PAmCacs4d2vYnP99SoPqXd7D9NlOVeCCgWboE1iFvcWI6UZr2ZVgSA>
    <xmx:PAmCaXsWZqZJsNGBWvfOLa-1pObJc94aHjPOpwL2XGZ8RbKIXE1DNw>
    <xmx:PQmCaaw-Kj6qNSsTGhQ-sxUGae3gpHnsNM-nN9n1cFh2YOMHaHQQOQXt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC887700065; Tue,  3 Feb 2026 09:42:03 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-ThreadId: Ae52e6Y4Oh4g
Date: Tue, 03 Feb 2026 15:41:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Jason Wang" <jasowang@redhat.com>,
 "Xie Yongji" <xieyongji@bytedance.com>,
 "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <a4612499-6a67-4d6b-946f-dc038ec2b6fd@app.fastmail.com>
In-Reply-To: 
 <CAJaqyWeZes2nUFQNaq5NmXN7127eh+bNFQbB7yX73TuZ0=xRng@mail.gmail.com>
References: <20260202095940.1358613-1-arnd@kernel.org>
 <20260202095940.1358613-2-arnd@kernel.org>
 <CAJaqyWeJs4u6G46gEg=-G6o3u6LsgzVC03fTGR=O_qd_HujLuw@mail.gmail.com>
 <30db98bd-8361-46f5-aec1-ffbc4e8574dd@app.fastmail.com>
 <20260202114412-mutt-send-email-mst@kernel.org>
 <34d3ce77-84b2-476c-a678-e092831041ae@app.fastmail.com>
 <20260203053142-mutt-send-email-mst@kernel.org>
 <CAJaqyWeZes2nUFQNaq5NmXN7127eh+bNFQbB7yX73TuZ0=xRng@mail.gmail.com>
Subject: Re: [PATCH 2/2] vduse: fix compat handling for
 VDUSE_IOTLB_GET_FD/VDUSE_VQ_GET_INFO
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026, at 15:13, Eugenio Perez Martin wrote:
> On Tue, Feb 3, 2026 at 11:35=E2=80=AFAM Michael S. Tsirkin <mst@redhat=
.com> wrote:
>> Along with it or no, surely before the release.
>> Given 32 on 64 with this apparently has been broken forever,
>> I will merge this just based on even you did not bother testing compa=
t, I am
>> inclined to say I am merging this but not rebasing because
>> of this.
>>
>> Oh and we got lucky this didn't leak kernel stack info.
>>
>> Eugenio, note for the future: please help make sure UAPI
>> structs do not have hidden padding.
>>
>
> Sure. I'm trying to find an automatic way to check for this but with
> no luck :(. Arnd, did you use some tool for this or you just found it
> by visual inspection? I'm trying pahole and -Wpadded but the output
> includes a lot of struct not related to uapi.
>
> I guess it is possible to filter it with some clang or awk machinery,
> but I'm asking in case I avoid developing something already existing.

I have the patch series, but it's not quite ready for submission.
In total, I annotated around 10% of the structure definitions
(500 files) in include/uapi/ to shut up -Wpadded for all the
existing structures with holes in them.

In the end I turn on the check with

--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -6,7 +6,7 @@
 #
 # -std=3Dc90 (equivalent to -ansi) catches the violation of those.
 # We cannot go as far as adding -Wpedantic since it emits too many warn=
ings.
-UAPI_CFLAGS :=3D -std=3Dc90 -Werror=3Dimplicit-function-declaration
+UAPI_CFLAGS :=3D -std=3Dc90 -Werror=3Dimplicit-function-declaration -We=
rror=3Dpadded
=20
 # when cross-compiling with a minimal toolchain, use nolibc headers
 UAPI_CFLAGS +=3D -I$(srctree)/tools/include/nolibc/

which of course warns for all the existing holes. I will continue
to send fixes for new instances in the meantime, as I'm testing
linux-next.

      Arnd
