Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1494EC636CC
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 03:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8D614813D4;
	Tue,  7 Feb 2023 03:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8D614813D4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=7rY8scGP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jQC_ehGBjki8; Tue,  7 Feb 2023 03:27:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1ACAE8137C;
	Tue,  7 Feb 2023 03:27:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1ACAE8137C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF509C0032;
	Tue,  7 Feb 2023 03:27:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12E57C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 03:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CD4FE409FD
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 03:27:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CD4FE409FD
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=7rY8scGP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AZWE6C-Nm83t
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 03:27:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6F666409FB
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6F666409FB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 03:27:43 +0000 (UTC)
Received: by mail-vs1-xe2f.google.com with SMTP id a24so14946211vsl.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Feb 2023 19:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZ/mrmJlqmnVt82aHOUrWzMk7/Vts23//ynlk42Gb2I=;
 b=7rY8scGPrJj8K6pOW2C5C3iG5ShGX3vJTHKEdLzsAGPO/6c5ieHmS08cJfrY69DghV
 YTFukr8S5+OKKqG8cgX4QKv6rvj1h25IpJX76xsaUquQjWEXBkpbSqqrRA3UL5vID5ii
 jgcpz+n4eE2sSs50Sz4sZEDenoL4Vshpy1itv1EXdNyCerFmFkBlU9wJyU+IqDvaSaeu
 hmr7babtRG5CP1bslOOuEi5yQ87GcSbEtlFj/Zi2xbP/DEZ5an4L/7ZNjoDYBdHknCN+
 WJGeP/cY3HgMGhtPDMIDpKIeASkcTbE2bXxi0+rg38SQz6PXSXTvtGHt7tnR1hdB0q4A
 4N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZ/mrmJlqmnVt82aHOUrWzMk7/Vts23//ynlk42Gb2I=;
 b=kd7mkr8mKSSrO3sEiNBp6yvglqqe36lw46qNlHusWdIXav/8+3CL+Kys2CMYwq6R0m
 Vsj0T+1TXZGZPc1tTXBAPW+kaZRfrlYbwD96Eb8siiJ4GPI3KZ46acx4I6j3MT8mB1Sb
 7/lWhZoWeiQBMjfPQjSnSmJyzzaNpDS+VCDQSqS8Lvrxts8JqVtMm679Rg3ROnuQ1Uyu
 F6sjKTWwG14x0dgiPYsyZGTroEf0M+Fxoop5A+KknGWySiwsIC+1VU+4IcCMMJNm2z2m
 +HjgaGwNwgIzQSGuAIkmvGVoyNZAsPh852PanM/KyqCVhzqHA3DSCgCwXlcQduxweFOt
 tefQ==
X-Gm-Message-State: AO0yUKWcyshk84f7916cjxl7+y9rXsYyj8SXGz2uwHJ4PSMjmoqhY2YB
 WCeqDXl3g25/lAaa4o7v+x1NHmHbOytlRmrnjaErQw==
X-Google-Smtp-Source: AK7set8vwQTyyrw2mI6WSHOv5KfVg0pjlIbtoO3lTtGG3+xS+VgMzPaWdvEqTn/k4uJjeQkGRY25cG5rzBswGSoyWbs=
X-Received: by 2002:a67:e10e:0:b0:3d3:d797:33c3 with SMTP id
 d14-20020a67e10e000000b003d3d79733c3mr385421vsl.51.1675740462297; Mon, 06 Feb
 2023 19:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <HE1PR0401MB2331582DC0401DFA4EB5540C88D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
 <CANXvt5pCnC=7DaPkFi4v1WUbzrgETVL03aAi=aq-uBFFxqhTyA@mail.gmail.com>
In-Reply-To: <CANXvt5pCnC=7DaPkFi4v1WUbzrgETVL03aAi=aq-uBFFxqhTyA@mail.gmail.com>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 7 Feb 2023 12:27:31 +0900
Message-ID: <CANXvt5p5DvOpqZui9ogv+tHiE4yJUeNnuQHi+=2-MypacQZ5DA@mail.gmail.com>
Subject: Re: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
 function
To: Frank Li <frank.li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, "Michael S. Tsirkin" <mst@redhat.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Ren Zhijie <renzhijie2@huawei.com>, Jon Mason <jdmason@kudzu.us>,
 Bjorn Helgaas <bhelgaas@google.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

MjAyM+W5tDLmnIg35pelKOeBqykgMTA6NDMgU2h1bnN1a2UgTWllIDxtaWVAaWdlbC5jby5qcD46
Cj4KPiAyMDIz5bm0MuaciDTml6Uo5ZyfKSA2OjQ4IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29t
PjoKPiA+Cj4gPiA+IGZvdW5kYXRpb24ub3JnCj4gPiA+IFN1YmplY3Q6IFtFWFRdIFtSRkMgUEFU
Q0ggMC80XSBQQ0k6IGVuZHBvaW50OiBJbnRyb2R1Y2UgYSB2aXJ0aW8tbmV0IEVQCj4gPiA+IGZ1
bmN0aW9uCj4gPiA+Cj4gPgo+ID4gVGhlIGRlcGVuZGVudCBFRE1BIHBhdGNoIGNhbid0IGJlIGFw
cGxpZWQgYXQgbGFzdCBsaW51eC1uZXh0Lgo+ID4gQ2FuIHlvdSBwcm92aWRlIGEgZ2l0IGxpbms/
IFNvIEkgY2FuIHRyeSBkaXJlY3RseS4KPiBTb3JyeSwgSSd2ZSBtaXNzZWQgaXQuIFRoZSBlbWJl
ZGRlZCBETUEncyBwYXRjaHNldCBpcwo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBj
aS8yMDIzMDExMzE3MTQwOS4zMDQ3MC0xLVNlcmdleS5TZW1pbkBiYWlrYWxlbGVjdHJvbmljcy5y
dS8KPiBhbmQsIG1lcmdlZCB0byBhIHBjaS9kd2MgYnJhbmNoIG9uIGtlcm5lbC9naXQvbHBpZXJh
bGlzaS9wY2kuZ2l0IC4gVGhlCj4gbGluayBpcyBoZXJlOgo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2xwaWVyYWxpc2kvcGNpLmdpdC9jb21taXQvP2g9
cGNpL2R3YwpJbiBhZGRpdGlvbiwgdGhlIHBhdGNoZXMgYXJlIG1lcmdlZCBpbnRvIG5leHQtMjAy
MzAxMzEgLgpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9u
ZXh0L2xpbnV4LW5leHQuZ2l0L3RhZy8/aD1uZXh0LTIwMjMwMTMxCgo+IEknbGwgYWRkIHRoZSBp
bmZvcm1hdGlvbiB0byBhIGNvdmVyIGxldHRlciBmcm9tIHRoZSBuZXh0IHN1Ym1pc3Npb24uCj4g
PiBGcmFuawo+ID4KPiA+ID4KPiA+ID4gQWJvdXQgdGhpcyBwYXRjaHNldCBoYXMgNCBwYXRjaGVz
LiBUaGUgZmlyc3Qgb2YgdHdvIHBhdGNoIGlzIGxpdHRsZSBjaGFuZ2VzCj4gPiA+IHRvIHZpcnRp
by4gVGhlIHRoaXJkIHBhdGNoIGFkZCBBUElzIHRvIGVhc2lseSBhY2Nlc3MgdmlydGlvIGRhdGEg
c3RydWN0dXJlCj4gPiA+IG9uIFBDSWUgSG9zdCBzaWRlIG1lbW9yeS4gVGhlIGxhc3Qgb25lIGlu
dHJvZHVjZSBhIHZpcnRpby1uZXQgRVAgZGV2aWNlCj4gPiA+IGZ1bmN0aW9uLiBEZXRhaWxzIGFy
ZSBpbiBjb21taXQgcmVzcGVjdGl2ZWx5Lgo+ID4gPgo+ID4KPiBCZXN0LAo+IFNodW5zdWtlCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
