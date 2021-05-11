Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78654C433ED
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 19:07:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E592B6162B
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 19:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E592B6162B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FE9B839CF;
	Tue, 11 May 2021 19:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xEYTVVgStvEV; Tue, 11 May 2021 19:07:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7F5FD83938;
	Tue, 11 May 2021 19:07:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55E99C000E;
	Tue, 11 May 2021 19:07:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2C1FC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 19:07:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9D0740596
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 19:07:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YhKKBuARy2wt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 19:07:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE924403E5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 19:07:02 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id b25so14766712oic.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 12:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z+2tFNovZUcDgEPPmQYv2lYlE9Duihn50lxuJ1yOCWQ=;
 b=PIXgT4XG2X+/uIY36jt05vZQkE2YO+G0mpeL+fHV2dF/yYj5lBYYKPtKL5PzdK3MCU
 nnBXHvQ6pSfmOGpcgm7v8V1NNO9/IRr9s9D5DBAIelqnemp7oDG+l+8KwSM/bQ9Z0laz
 nuLcOzhi+8D+I2Ts04EHFsbdXOH6WH1HC9mVZhauXT1HhTLTAHRIxGc6m8w/j7Z4TK9W
 Votlfrv2HeXCMrVYE1XBO583Lok6h58fQ3fh8FHqgc++TtxzBMs1yHCijG3fehF5/vpK
 F55TNfhN2iSknoEIF/EpFnhCB3eRUY2OCO5J7GzPaZsnCIrMlDLfe53+d4OPEYkR01Ys
 S+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z+2tFNovZUcDgEPPmQYv2lYlE9Duihn50lxuJ1yOCWQ=;
 b=FqcB7BqvNiSPi/LT2a4YLqQvNjDLDjQn84xWq9Rz5qIMqgsoN9LGSEG2IF8FUcnIC9
 bf5HNRCOSfFzQqSxWhHezPObv0Qzj6WK5OxdHulvWzzCU0O/ktjPZpG5RIRmE6kfT/kE
 MG1R2wieV48QLUcHoRgPvtJ4L1kZQsltP/n5RDySieASUWIBNloiMjl0kZ5bX29lXwGD
 GGlWiBPSdpSkeyWKPTwxRA8cgdH9ssPIaGQrceKgoPXQmUn+yl0xeRxQisbwG5lD8S+D
 zQoDOlftB+6dSUL71vlKyZNrrIlrue4U/K6CynJ8ErLNN17ertXFumqlIYLm4arbkq0f
 oi1A==
X-Gm-Message-State: AOAM5306xZOZgq90fP2OShXaQGBFzf8ek2wfSx/7q1SW7eUX5H92NUh4
 Jaq0qx1krlK7uJZBr0LE6AlwDZ9jxOPIbD1Jx3rx+Q==
X-Google-Smtp-Source: ABdhPJytx2Ma0JJmf+z8DC+uACG6GOimDVEGBico4qHJLO1COURF9YCesedmqBiEjti+TEHg7vH6tjvjomo87/9obp0=
X-Received: by 2002:aca:4887:: with SMTP id
 v129mr22547971oia.137.1620760021914; 
 Tue, 11 May 2021 12:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com>
 <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
 <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
In-Reply-To: <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 11 May 2021 22:06:50 +0300
Message-ID: <CAOEp5Of78_c7bGJNSCN7i+xw_N5q=MMGgr8EjnSR9moR+ugExg@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgMTE6MzMgQU0gWXVyaSBCZW5kaXRvdmljaAo8eXVyaS5i
ZW5kaXRvdmljaEBkYXluaXguY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgTWF5IDExLCAyMDIxIGF0
IDk6NTAgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4K
PiA+IOWcqCAyMDIxLzUvMTEg5LiL5Y2IMTI6NDIsIFl1cmkgQmVuZGl0b3ZpY2gg5YaZ6YGTOgo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBZdXJpIEJlbmRpdG92aWNoIDx5dXJpLmJlbmRpdG92aWNoQGRh
eW5peC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgIGRyaXZlcnMvbmV0L3R1bi5jIHwgMiArLQo+ID4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4gPgo+
ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdHVuLmMgYi9kcml2ZXJzL25ldC90dW4uYwo+
ID4gPiBpbmRleCA4NGY4MzI4MDYzMTMuLmEzNTA1NGY5ZDk0MSAxMDA2NDQKPiA+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvdHVuLmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdHVuLmMKPiA+ID4gQEAg
LTI4MTIsNyArMjgxMiw3IEBAIHN0YXRpYyBpbnQgc2V0X29mZmxvYWQoc3RydWN0IHR1bl9zdHJ1
Y3QgKnR1biwgdW5zaWduZWQgbG9uZyBhcmcpCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICBh
cmcgJj0gfihUVU5fRl9UU080fFRVTl9GX1RTTzYpOwo+ID4gPiAgICAgICAgICAgICAgIH0KPiA+
ID4KPiA+ID4gLSAgICAgICAgICAgICBhcmcgJj0gflRVTl9GX1VGTzsKPiA+ID4gKyAgICAgICAg
ICAgICBhcmcgJj0gfihUVU5fRl9VRk98VFVOX0ZfVVNPKTsKPiA+Cj4gPgo+ID4gSXQgbG9va3Mg
dG8gbWUga2VybmVsIGRvZXNuJ3QgdXNlICJVU08iLCBzbyBUVU5fRl9VRFBfR1NPX0w0IGlzIGEg
YmV0dGVyCj4gPiBuYW1lIGZvciB0aGlzCj4KPiBObyBwcm9ibGVtLCBJIGNhbiBjaGFuZ2UgaXQg
aW4gdjIKPgo+ICBhbmQgSSBndWVzcyB3ZSBzaG91bGQgdG9nZ2xlIE5FVElGX0ZfVURQX0dTT19s
NCBoZXJlPwo+Cj4gTm8sIHdlIGRvIG5vdCwgYmVjYXVzZSB0aGlzIGluZGljYXRlcyBvbmx5IHRo
ZSBmYWN0IHRoYXQgdGhlIGd1ZXN0IGNhbgo+IHNlbmQgbGFyZ2UgVURQIHBhY2tldHMgYW5kIGhh
dmUgdGhlbSBzcGxpdHRlZCB0byBVRFAgc2VnbWVudHMuCj4KPiA+Cj4gPiBBbmQgaG93IGFib3V0
IG1hY3Z0YXA/Cj4KPiBXZSB3aWxsIGNoZWNrIGhvdyB0byBkbyB0aGF0IGZvciBtYWN2dGFwLiBX
ZSB3aWxsIHNlbmQgYSBzZXBhcmF0ZQo+IHBhdGNoIGZvciBtYWN2dGFwIG9yIGFzayBmb3IgYWR2
aWNlLgo+CgpJJ2xsIGFkZCB0aGlzIGZlYXR1cmUgdG8gdGhlIHRhcC5jIGFsc28gKEFGQUlVIHRo
aXMgd2lsbCBlbmFibGUgdGhlClVTTyBmb3IgbWFjdnRhcCkuClBsZWFzZSBjb3JyZWN0IG1lIGlm
IEknbSBtaXN0YWtlbi4KCj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4KPiA+ID4gICAgICAgfQo+ID4g
Pgo+ID4gPiAgICAgICAvKiBUaGlzIGdpdmVzIHRoZSB1c2VyIGEgd2F5IHRvIHRlc3QgZm9yIG5l
dyBmZWF0dXJlcyBpbiBmdXR1cmUgYnkKPiA+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
