Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F795C636CD
	for <virtualization@archiver.kernel.org>; Tue,  7 Feb 2023 10:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0AAE818DC;
	Tue,  7 Feb 2023 10:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D0AAE818DC
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=3bRuHxRH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NuCj1oP71i9Y; Tue,  7 Feb 2023 10:56:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C99881385;
	Tue,  7 Feb 2023 10:56:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C99881385
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28C8BC0032;
	Tue,  7 Feb 2023 10:56:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14803C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFB3260E85
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFB3260E85
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=igel-co-jp.20210112.gappssmtp.com
 header.i=@igel-co-jp.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=3bRuHxRH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f4tJyunnoJde
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:56:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A37D760E7D
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A37D760E7D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Feb 2023 10:56:14 +0000 (UTC)
Received: by mail-vs1-xe2f.google.com with SMTP id g3so4472096vsr.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Feb 2023 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eh6n76XKXwkWQFKv24FSFfZ2Z3Kdasw4AtrqkamX9UM=;
 b=3bRuHxRHNfgNh/U9x9Z0OChjKOxnf23Qq1s4ZVRqD79+wZUL3y8dYHCJeVVYw1Gk3b
 caFgoAj4BGpbB+0rddJneTJyACwZLBM6oQl/WHJeMWQ/6e4Eg9Wgc81z6oRhBaT2LPOk
 TREvubm1ognsVxQVgdkm3yflazGy+YytqGO/PSuPpzgzteTqkd8nDf/Z0jB0pmYTGx0f
 Iv2nysL/rN50+2lL8dMnGzsEmOSkxwVYeiihvE65fw4LTPl3C++Mi/tvdJ5cNL0orluK
 yawkySoBZSGlZgkj5UFYBdkSCKPEAgJHit9yaXBwYo53kzzwmEHg19LBY7Tl9wEFolVa
 GM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eh6n76XKXwkWQFKv24FSFfZ2Z3Kdasw4AtrqkamX9UM=;
 b=QAotNZlg/orpvaq+m0llsia9GqJWoX7G0CLRAIbaHNaRR32eNcGA72u4gFWKgwRc4G
 4UpgDYJGVVba1H25GCanGj2Zjw2ntZ69Y8lD2Kq+Tj1XEzi8b6lxC6AjXoF7aDoZbfVT
 wVW8k3cbkISJ6N+amA9P+x4a1lUGHBxtvbH2r95at3L3l8kyZPFVGTHTFNiyiJnTFwK2
 Ha5b7FZjaweb3Unk3OIeSGePgD7cUL40UrMwzvKgPCpZIIqZxtpOtCuC8l/nCuEcKATN
 VKepQbp7tj6jYRDlc72cjI61mRvzq2mexKmmq3IHe2X7rWm6HnV85OMFK5In9S/4W4DF
 SZCQ==
X-Gm-Message-State: AO0yUKXcIKAR3x+JrVIjZB5Sv0jT7CGQRzPhM+W6Y0s6N3xzzg9BSA2R
 XijI4BID+CfGnYwuN4aojx9jTnYbm4b2fDkOU93hDw==
X-Google-Smtp-Source: AK7set/+QocsElN2HAp7zqZEXhXbN49fvEFr+puDDmo2Tj8R93i+EnA3nNuF3VGJjfw7/LYPrLlggfaxFNUmNo4A9B8=
X-Received: by 2002:a67:e10e:0:b0:3d3:d797:33c3 with SMTP id
 d14-20020a67e10e000000b003d3d79733c3mr564644vsl.51.1675767373472; Tue, 07 Feb
 2023 02:56:13 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp>
 <20230203100418.2981144-5-mie@igel.co.jp>
 <20230203052114-mutt-send-email-mst@kernel.org>
 <HE1PR0401MB23313FC60955EADE8A00133088D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB23313FC60955EADE8A00133088D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From: Shunsuke Mie <mie@igel.co.jp>
Date: Tue, 7 Feb 2023 19:56:02 +0900
Message-ID: <CANXvt5qjgVKccRcsARSkDF+boVkVi7h=AMHC+iWyOfp4dJ-_tQ@mail.gmail.com>
Subject: Re: [EXT] Re: [RFC PATCH 4/4] PCI: endpoint: function: Add EP
 function driver to provide virtio net device
To: Frank Li <frank.li@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Takanari Hayama <taki@igel.co.jp>, Manivannan Sadhasivam <mani@kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

MjAyM+W5tDLmnIg05pelKOWcnykgNzoxNSBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT46Cj4K
PiA+Cj4gPiBDYXV0aW9uOiBFWFQgRW1haWwKPiA+Cj4gPiBPbiBGcmksIEZlYiAwMywgMjAyMyBh
dCAwNzowNDoxOFBNICswOTAwLCBTaHVuc3VrZSBNaWUgd3JvdGU6Cj4gPiA+IEFkZCBhIG5ldyBl
bmRwb2ludChFUCkgZnVuY3Rpb24gZHJpdmVyIHRvIHByb3ZpZGUgdmlydGlvLW5ldCBkZXZpY2Uu
IFRoaXMKPiA+ID4gZnVuY3Rpb24gbm90IG9ubHkgc2hvd3MgdmlydGlvLW5ldCBkZXZpY2UgZm9y
IFBDSWUgaG9zdCBzeXN0ZW0sIGJ1dCBhbHNvCj4gPiA+IHByb3ZpZGVzIHZpcnRpby1uZXQgZGV2
aWNlIHRvIEVQIHNpZGUobG9jYWwpIHN5c3RlbS4gVmlydHVhbHkgdGhvc2UgbmV0d29yawo+ID4g
PiBkZXZpY2VzIGFyZSBjb25uZWN0ZWQsIHNvIHdlIGNhbiB1c2UgdG8gY29tbXVuaWNhdGUgb3Zl
ciBJUCBsaWtlIGEgc2ltcGxlCj4gPiA+IE5JQy4KPiA+ID4KPiA+ID4gQXJjaGl0ZWN0dXJlIG92
ZXJ2aWV3IGlzIGZvbGxvd2luZzoKPiA+ID4KPiA+ID4gdG8gSG9zdCAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICB0byBFbmRwb2ludAo+ID4gPiBuZXR3b3JrIHN0YWNrIHwgICAgICAgICAg
ICAgICAgIG5ldHdvcmsgc3RhY2sKPiA+ID4gICAgICAgfCAgICAgICB8ICAgICAgICAgICAgICAg
ICAgICAgICB8Cj4gPiA+ICstLS0tLS0tLS0tLSsgfCAgICAgICArLS0tLS0tLS0tLS0rICAgKy0t
LS0tLS0tLS0tKwo+ID4gPiB8dmlydGlvLW5ldCB8IHwgICAgICAgfHZpcnRpby1uZXQgfCAgIHx2
aXJ0aW8tbmV0IHwKPiA+ID4gfGRyaXZlciAgICAgfCB8ICAgICAgIHxFUCBmdW5jdGlvbnwtLS18
ZHJpdmVyICAgICB8Cj4gPiA+ICstLS0tLS0tLS0tLSsgfCAgICAgICArLS0tLS0tLS0tLS0rICAg
Ky0tLS0tLS0tLS0tKwo+ID4gPiAgICAgICB8ICAgICAgIHwgICAgICAgICAgICAgfAo+ID4gPiAr
LS0tLS0tLS0tLS0rIHwgKy0tLS0tLS0tLS0tKwo+ID4gPiB8UENJZUMgICAgICB8IHwgfFBDSWVD
ICAgICAgfAo+ID4gPiB8Um9vdGNvbXBsZXh8LXwtfEVuZHBvaW50ICAgfAo+ID4gPiArLS0tLS0t
LS0tLS0rIHwgKy0tLS0tLS0tLS0tKwo+ID4gPiAgIEhvc3Qgc2lkZSAgIHwgICAgICAgICAgRW5k
cG9pbnQgc2lkZQo+ID4gPgo+ID4gPiBUaGlzIGRyaXZlciB1c2VzIFBDSWUgRVAgZnJhbWV3b3Jr
IHRvIHNob3cgdmlydGlvLW5ldCAocGNpKSBkZXZpY2UgSG9zdAo+ID4gPiBzaWRlLCBhbmQgZ2Vu
ZXJhdGUgdmlydHVhbCB2aXJ0aW8tbmV0IGRldmljZSBhbmQgcmVnaXN0ZXIgdG8gRVAgc2lkZS4K
PiA+ID4gQSBjb21tdW5pY2F0aW9uIGRhdGUKPiA+Cj4gPiBkYXRhPwo+ID4KPiA+ID4gaXMgZGly
YWN0bHkKPiA+Cj4gPiBkaXJlY3RseT8KPiA+Cj4gPiA+IHRyYW5zcG9ydGVkIGJldHdlZW4gdmly
dHF1ZXVlIGxldmVsCj4gPiA+IHdpdGggZWFjaCBvdGhlciB1c2luZyBQQ0llIGVtYmVkZGVkIERN
QSBjb250cm9sbGVyLgo+ID4gPgo+ID4gPiBieSBhIGxpbWl0YXRpb24gb2YgdGhlIGhhcmR3YXJl
IGFuZCBMaW51eCBFUCBmcmFtZXdvcmssIHRoaXMgZnVuY3Rpb24KPiA+ID4gZm9sbG93cyBhIHZp
cnRpbyBsZWdhY3kgc3BlY2lmaWNhdGlvbi4KPiA+Cj4gPiB3aGF0IGV4YWN0bHkgaXMgdGhlIGxp
bWl0YXRpb24gYW5kIHdoeSBkb2VzIGl0IGZvcmNlIGxlZ2FjeT8KPiA+Cj4gPiA+IFRoaXMgZnVu
Y3Rpb24gZHJpdmVyIGhhcyBiZWVkIHRlc3RlZCBvbiBTNCBSY2FyIChyOGE3NzlmYS1zcGlkZXIp
IGJvYXJkIGJ1dAo+ID4gPiBqdXN0IHVzZSB0aGUgUENJZSBFUCBmcmFtZXdvcmsgYW5kIGRlcGVu
ZHMgb24gdGhlIFBDSWUgRURNQS4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogU2h1bnN1a2Ug
TWllIDxtaWVAaWdlbC5jby5qcD4KPiA+ID4gU2lnbmVkLW9mZi1ieTogVGFrYW5hcmkgSGF5YW1h
IDx0YWtpQGlnZWwuY28uanA+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy9wY2kvZW5kcG9pbnQv
ZnVuY3Rpb25zL0tjb25maWcgICAgICAgIHwgIDEyICsKPiA+ID4gIGRyaXZlcnMvcGNpL2VuZHBv
aW50L2Z1bmN0aW9ucy9NYWtlZmlsZSAgICAgICB8ICAgMSArCj4gPiA+ICAuLi4vcGNpL2VuZHBv
aW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZuZXQtZXAuYyAgfCAzNDMgKysrKysrKysrKwo+Cj4gSXQg
aXMgYWN0dWFsbHkgdGhhdCBub3QgcmVsYXRlZCB2bmV0LiBKdXN0IHZpcnRpby4KPiBJIHRoaW5r
IHBjaS1lcGYtdmlydGlvLmMgaXMgYmV0dGVyLgpZZXMsIGl0IGhhdmUgdG8gYmUuCj4gPiA+ICAu
Li4vcGNpL2VuZHBvaW50L2Z1bmN0aW9ucy9wY2ktZXBmLXZuZXQtcmMuYyAgfCA2MzUgKysrKysr
KysrKysrKysrKysrCj4KPiBJdCBpcyBlcGYgZHJpdmVyLiByYyBpcyBxdWl0ZSBjb25mdXNlZC4K
PiBNYXliZSB5b3UgY2FuIGNvbWJpbmUgcGNpLWVwZi12bmV0LWVwLmMgYW5kIHBjaS1lcGYtdm5l
dC1yYy5jIHRvIG9uZSBmaWxlLgpJIGFncmVlLiBUcnkgdG8gY29tYmluZSB0aGVtCj4gPiA+ICBk
cml2ZXJzL3BjaS9lbmRwb2ludC9mdW5jdGlvbnMvcGNpLWVwZi12bmV0LmMgfCAzODcgKysrKysr
KysrKysKPgo+IFRoaXMgZmlsZSBzZXR1cCBkbWEgdHJhbnNmZXIgYWNjb3JkaW5nIHZpcnRpby1y
aW5nLgo+IEhvdyBhYm91dCBwY2ktZXBmLXZpcnRpby1kbWEuYyA/CkkgYXR0ZW1wdCB0byByZWFy
cmFuZ2UgdGhlIGxvY2F0aW9uIG9mIGNvZGUgYW5kIGZpbGVuYW1lcy4KPiA+ID4gKwo+ID4gPiAr
ICAgICBlcGZfdm5ldF9yY19zZXRfY29uZmlnMTYodm5ldCwgVklSVElPX1BDSV9JU1IsCj4gPiBW
SVJUSU9fUENJX0lTUl9RVUVVRSk7Cj4gPiA+ICsgICAgIC8qCj4gPiA+ICsgICAgICAqIEluaXRp
YWxpemUgdGhlIHF1ZXVlIG5vdGlmeSBhbmQgc2VsZWN0b3IgdG8gb3V0c2lkZSBvZiB0aGUgYXBw
cm9wcmlhdGUKPiA+ID4gKyAgICAgICogdmlydHF1ZXVlIGluZGV4LiBJdCBpcyB1c2VkIHRvIGRl
dGVjdCBjaGFuZ2Ugd2l0aCBwb2xsaW5nLiBUaGVyZSBpcyBubwo+ID4gPiArICAgICAgKiBvdGhl
ciB3YXlzIHRvIGRldGVjdCBob3N0IHNpZGUgZHJpdmVyIHVwZGF0ZWluZyB0aG9zZSB2YWx1ZXMK
PiA+ID4gKyAgICAgICovCj4KPiBJIGFtIHRyeSB0byB1c2UgZ2ljLWl0cyBvciBvdGhlciBtc2kg
Y29udHJvbGxlciBhcyBkb29yYmVsbC4KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9pbXgvMjAy
MjExMjUxOTI3MjkuMTcyMjkxMy0xLUZyYW5rLkxpQG54cC5jb20vVC8jdQo+Cj4gYnV0IGl0IG1h
eSBuZWVkIHVwZGF0ZSBob3N0IHNpZGUgcGNpIHZpcnRpbyBkcml2ZXIuClRoYW5rcywgaXMgaXQg
cG9zc2libGUgdG8gdXNlICBNU0ktWCBhcyB3ZWxsPyBUaGUgdmlydGlvIHNwZWMKaW5kaWNhdGVz
IHRvIHVzZSBsZWdhY3kgaXJxIG9yCk1TSS1YIG9ubHkuCj4gPiA+ICsgICAgIGVwZl92bmV0X3Jj
X3NldF9jb25maWcxNih2bmV0LCBWSVJUSU9fUENJX1FVRVVFX05PVElGWSwKPiA+IGRlZmF1bHRf
cWluZGV4KTsKPiA+ID4gKyAgICAgZXBmX3ZuZXRfcmNfc2V0X2NvbmZpZzE2KHZuZXQsIFZJUlRJ
T19QQ0lfUVVFVUVfU0VMLAo+ID4gZGVmYXVsdF9xaW5kZXgpOwo+ID4gPiArICAgICAvKiBUaGlz
IHBmbiBpcyBhbHNvIHNldCB0byAwIGZvciB0aGUgcG9sbGluZyBhcyB3ZWxsICovCj4gPiA+ICsg
ICAgIGVwZl92bmV0X3JjX3NldF9jb25maWcxNih2bmV0LCBWSVJUSU9fUENJX1FVRVVFX1BGTiwg
MCk7Cj4gPiA+ICsKPiA+IC0tCj4gPiA+IDIuMjUuMQo+CkJlc3QsClNodW5zdWtlLgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
