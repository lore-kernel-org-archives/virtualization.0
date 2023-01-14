Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DC8C3DA78
	for <virtualization@archiver.kernel.org>; Sat, 14 Jan 2023 00:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71DE8608F5;
	Sat, 14 Jan 2023 00:23:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 71DE8608F5
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=g1I67Yiw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BVxTKFBnWCSl; Sat, 14 Jan 2023 00:23:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0C1916061B;
	Sat, 14 Jan 2023 00:23:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C1916061B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6804C0033;
	Sat, 14 Jan 2023 00:23:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C887C002D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 00:23:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C35D04019D
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 00:23:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C35D04019D
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=g1I67Yiw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wFJpupAMg6ji
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 00:23:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9AE86400C8
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9AE86400C8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 14 Jan 2023 00:23:48 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id jl4so25018480plb.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Jan 2023 16:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uyFe8Hiv6O2mfH/Vj1+Wj64Z370Ezwp6JCjnN4tqvqo=;
 b=g1I67YiwFjVYKgsHUYTIW+SYpmSr2e+PZPoR7G2RJkG/N+SkGyQwD4jGjV/Qz1Gpj8
 HMJJ99VwQ3z+qE6bK+L7cJxfaC0DJWe/TlgjBlUEAnAKF14+eFXwzGIi690SMDF0IqeT
 zAH8wVcwJcVBABT2DUePs+sQg6dlwXgzmsTn37XR0rdUgQabIet7QgyA37U5Ef1POA9/
 5uiAmr8kXe63qR9H/y/WcVtwmMCJMCC3XGxNRc2FwO+ydkb2FikrtlRm67QEP+IHxXtU
 UGlvyI0o4To+M8lNhw5pbt+xdR12XNFrVHDOVG0DuCYHb+bKaAQ5cZq9+eBe9YT+Pd49
 6sKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uyFe8Hiv6O2mfH/Vj1+Wj64Z370Ezwp6JCjnN4tqvqo=;
 b=pQUF7HhsIECiiivMF1mTNjxXmTClxGQa3V83MZiLUQhoyNfAirNrxNGtGA8mjVGti5
 MM6i1LuwXN33IdZDQEOPSjfryMHL+QS8ZD/QriipKXXcfGlNNbtCQH+vSMLsb4lZduAv
 4KC5mKVfJ56gP8mpHO95OMVDGmubLtxVmWhYByj1I//aAz2S5YTDPfsgR7g2i7PlIX00
 qFdIwgB6KZlVGIe4XYW+ON99On6FzHSBiwp76Tf1CV8kOVQFw36xzpJORAodr3oeLcYe
 iEr4YS3p2zzds7vvQmnefmdxBniG8wRuMBF+td3cSubHaonwtniDEHe4HANW1jdgukaC
 VGgw==
X-Gm-Message-State: AFqh2kpjRm2wlm10u5EopNbQuAfRHdm53RIskGJUudQv3Vv72lCTQ7PV
 A/Dds6bblNBusmgjyscTJU4nkU2+FTASR/doRcQ=
X-Google-Smtp-Source: AMrXdXsg1K15MKq3iirRL4kK4FUxxwT5OGX76KLekIccfKRRmZOFqsAdltrfdYEstzEk9J/YGDimbibbPqig5Kc/AQQ=
X-Received: by 2002:a17:902:82c7:b0:192:9101:a65a with SMTP id
 u7-20020a17090282c700b001929101a65amr113612plz.111.1673655827946; Fri, 13 Jan
 2023 16:23:47 -0800 (PST)
MIME-Version: 1.0
References: <20230113223619.162405-1-parav@nvidia.com>
 <20230113223619.162405-2-parav@nvidia.com>
 <92b98f45dcd65facac78133c6250d9d96ea1a25f.camel@gmail.com>
 <PH0PR12MB5481C03EDED7C2D67395FCA4DCC29@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481C03EDED7C2D67395FCA4DCC29@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 13 Jan 2023 16:23:36 -0800
Message-ID: <CAKgT0UenRh4gdcOOg3t7+JXXyu06daXE8U8a38oxUQWQ3UnQVg@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] virtio_net: Fix short frame length check
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gRnJpLCBKYW4gMTMsIDIwMjMgYXQgMzozNyBQTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRp
YS5jb20+IHdyb3RlOgo+Cj4KPiA+IEZyb206IEFsZXhhbmRlciBIIER1eWNrIDxhbGV4YW5kZXIu
ZHV5Y2tAZ21haWwuY29tPgo+ID4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDEzLCAyMDIzIDY6MjQg
UE0KPiA+Cj4gPiBPbiBTYXQsIDIwMjMtMDEtMTQgYXQgMDA6MzYgKzAyMDAsIFBhcmF2IFBhbmRp
dCB3cm90ZToKPiA+ID4gQSBzbWFsbGVzdCBFdGhlcm5ldCBmcmFtZSBkZWZpbmVkIGJ5IElFRUUg
ODAyLjMgaXMgNjAgYnl0ZXMgd2l0aG91dAo+ID4gPiBhbnkgcHJlZW1ibGUgYW5kIENSQy4KPiA+
ID4KPiA+ID4gQ3VycmVudCBjb2RlIG9ubHkgY2hlY2tzIGZvciBtaW5pbWFsIDE0IGJ5dGVzIG9m
IEV0aGVybmV0IGhlYWRlciBsZW5ndGguCj4gPiA+IENvcnJlY3QgaXQgdG8gY29uc2lkZXIgdGhl
IG1pbmltdW0gRXRoZXJuZXQgZnJhbWUgbGVuZ3RoLgo+ID4gPgo+ID4gPiBGaXhlczogMjk2Zjk2
ZmNmYzE2ICgiTmV0IGRyaXZlciB1c2luZyB2aXJ0aW8iKQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQ
YXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jIHwgMiArLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4gPiA+Cj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgaW5kZXgKPiA+ID4gNzcyM2Iy
YTQ5ZDhlLi5kNDVlMTQwYjY4NTIgMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYwo+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gQEAgLTEy
NDgsNyArMTI0OCw3IEBAIHN0YXRpYyB2b2lkIHJlY2VpdmVfYnVmKHN0cnVjdCB2aXJ0bmV0X2lu
Zm8gKnZpLAo+ID4gc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxLAo+ID4gPiAgICAgc3RydWN0IHNr
X2J1ZmYgKnNrYjsKPiA+ID4gICAgIHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9tcmdfcnhidWYgKmhk
cjsKPiA+ID4KPiA+ID4gLSAgIGlmICh1bmxpa2VseShsZW4gPCB2aS0+aGRyX2xlbiArIEVUSF9I
TEVOKSkgewo+ID4gPiArICAgaWYgKHVubGlrZWx5KGxlbiA8IHZpLT5oZHJfbGVuICsgRVRIX1pM
RU4pKSB7Cj4gPiA+ICAgICAgICAgICAgIHByX2RlYnVnKCIlczogc2hvcnQgcGFja2V0ICVpXG4i
LCBkZXYtPm5hbWUsIGxlbik7Cj4gPiA+ICAgICAgICAgICAgIGRldi0+c3RhdHMucnhfbGVuZ3Ro
X2Vycm9ycysrOwo+ID4gPiAgICAgICAgICAgICBpZiAodmktPm1lcmdlYWJsZV9yeF9idWZzKSB7
Cj4gPgo+ID4gSSdtIG5vdCBzdXJlIEkgYWdyZWUgd2l0aCB0aGlzIGNoYW5nZSBhcyBwYWNrZXRz
IGFyZSBvbmx5IDYwQiBpZiB0aGV5IGhhdmUgZ29uZQo+ID4gYWNyb3NzIHRoZSB3aXJlIGFzIHRo
ZXkgYXJlIHVzdWFsbHkgcGFkZGVkIG91dCBvbiB0aGUgdHJhbnNtaXQgc2lkZS4gVGhlcmUgbWF5
Cj4gPiBiZSBjYXNlcyB3aGVyZSBzb2Z0d2FyZSByb3V0ZWQgcGFja2V0cyBtYXkgbm90IGJlIDYw
Qi4KPiA+Cj4gRG8geW91IG1lYW4gTGludXgga2VybmVsIHNvZnR3YXJlPyBBbnkgbGluayB0byBp
dCB3b3VsZCBiZSBoZWxwZnVsLgoKVGhlIHByb2JsZW0gaXMgdGhlcmUgYXJlIHNldmVyYWwgc29m
dHdhcmUgcGF0aHMgaW52b2x2ZWQgYW5kIHRoYXQgaXMKd2h5IEkgYW0gd2FudGluZyB0byBiZSBj
YXV0aW91cy4gQXMgSSByZWNhbGwgdGhpcyB3b3VsZCBpbXBhY3QgUWVtdQppdHNlbGYsIERQREss
IHRoZSBMaW51eCBLZXJuZWwgYW5kIHNldmVyYWwgb3RoZXJzIGlmIEkgYW0gbm90Cm1pc3Rha2Vu
LiBUaGF0IGlzIHdoeSBJIGFtIHRlbmRpbmcgdG8gZXJyIG9uIHRoZSBzaWRlIG9mIGNhdXRpb24g
YXMKdGhpcyBpcyBhIHByZXR0eSBzaWduaWZpY2FudCBjaGFuZ2UuCgo+ID4gQXMgc3VjaCByYXRo
ZXIgdGhhbiBjaGFuZ2luZyBvdXQgRVRIX0hMRU4gZm9yIEVUSF9aTEVOIEkgd29uZGVyIGlmIHdl
Cj4gPiBzaG91bGQgbG9vayBhdCBtYXliZSBtYWtpbmcgdGhpcyBhICI8PSIgY29tcGFyaXNvbiBp
bnN0ZWFkIHNpbmNlIHRoYXQgaXMgdGhlCj4gPiBvbmx5IGNhc2UgSSBjYW4gdGhpbmsgb2Ygd2hl
cmUgdGhlIHBhY2tldCB3b3VsZCBlbmQgdXAgYmVpbmcgZW50aXJlbHkgZW1wdHkKPiA+IGFmdGVy
IGV0aF90eXBlX3RyYW5zIGlzIGNhbGxlZCBhbmQgd2Ugd291bGQgYmUgcGFzc2luZyBhbiBza2Ig
d2l0aCBsZW5ndGggMC4KPgo+IEkgbGlrZWx5IGRpZG7igJl0IHVuZGVyc3RhbmQgeW91ciBjb21t
ZW50Lgo+IFRoaXMgZHJpdmVyIGNoZWNrIGlzIGJlZm9yZSBjcmVhdGluZyB0aGUgc2tiIGZvciB0
aGUgcmVjZWl2ZWQgcGFja2V0Lgo+IFNvLCBwdXJwb3NlIGlzIHRvIG5vdCBldmVuIHByb2Nlc3Mg
dGhlIHBhY2tldCBoZWFkZXIgb3IgcHJlcGFyZSB0aGUgc2tiIGlmIGl0IG5vdCBhbiBFdGhlcm5l
dCBmcmFtZS4KPgo+IEl0IGlzIGludGVyZXN0aW5nIHRvIGtub3cgd2hlbiB3ZSBnZXQgPCA2MEIg
ZnJhbWUuCgpJZiBJIHJlY2FsbCwgYSBVRFB2NCBmcmFtZSBjYW4gZWFzaWx5IGRvIGl0IHNpbmNl
IEV0aGVybmV0IGlzIDE0QiwgSVAKaGVhZGVyIGlzIDIwLCBhbmQgVURQIGlzIG9ubHkgOCBzbyB0
aGF0IG9ubHkgY29tZXMgdG8gNDJCIGlmIEkgcmVjYWxsCmNvcnJlY3RseS4gU2ltaWxhcmx5IEkg
dGhpbmsgYSBUQ1B2NCBGcmFtZSBjYW4gYmUgYXMgc21hbGwgYXMgNTRCIGlmCnlvdSBkaXNhYmxl
IGFsbCB0aGUgb3B0aW9uIGhlYWRlcnMuCgpBIHF1aWNrIGFuZCBkaXJ0eSB0ZXN0IHdvdWxkIGJl
IHRvIHJ1biBzb21ldGhpbmcgbGlrZSBhIG5ldHBlcmYgVURQX1JSCnRlc3QuIEkga25vdyBpbiB0
aGUgY2FzZSBvZiB0aGUgbmV0d29yayBzdGFjayB3ZSBzZWUgdGhlIHRyYW5zbWl0cwp0aGF0IGdv
IG91dCBhcmUgbGVzcyB0aGFuIDYwQiB1bnRpbCB0aGV5IGFyZSBwYWRkZWQgb24geG1pdCwgdXN1
YWxseQpieSB0aGUgZGV2aWNlLiBNeSBjb25jZXJuIGlzIHdhbnRpbmcgdG8gbWFrZSBzdXJlIGFs
bCB0aG9zZSBwYXRocyBhcmUKY292ZXJlZCBiZWZvcmUgd2UgYXNzdW1lIHRoYXQgYWxsIHRoZSBw
YWNrZXRzIHdpbGwgYmUgcGFkZGVkLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
