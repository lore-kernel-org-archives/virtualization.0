Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BDBC433F5
	for <virtualization@archiver.kernel.org>; Tue, 14 Dec 2021 03:13:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 752E14047D;
	Tue, 14 Dec 2021 03:13:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XYV9vc5K0Ewa; Tue, 14 Dec 2021 03:13:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1F54C4043A;
	Tue, 14 Dec 2021 03:13:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7831C001E;
	Tue, 14 Dec 2021 03:13:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36CAEC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1417040469
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:13:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QWqlxQOMGf9Q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:13:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 587874043A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Dec 2021 03:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639451602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=99hHa+R8DxpGc57uFm6oCLjvQUYhFLts8EwSb1a/bxk=;
 b=Wh2JowtTgsxQS0zrUhrEQKiK86/wgfckkAy1DRfHcTejsWIfGos01YpkA57VGOJP8XQTMz
 mfSP1eVUblRWZJWaV0b/VGAk6uG/60GhTEbsdMxAhJz69ewOE48TwSrHqc5PReNlzUCJqz
 SQEL6oI0mnJiiFTyw4yeB5iLVtWEtuI=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-141-wFBxluRbNFiUVmCW7yptiA-1; Mon, 13 Dec 2021 22:13:19 -0500
X-MC-Unique: wFBxluRbNFiUVmCW7yptiA-1
Received: by mail-lf1-f69.google.com with SMTP id
 s11-20020a195e0b000000b0041c0a47fb77so8328163lfb.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 19:13:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=99hHa+R8DxpGc57uFm6oCLjvQUYhFLts8EwSb1a/bxk=;
 b=Y1tfofe3OXPF8Ctq9a/pIxNfGSmCYDtSxnpXXJbhmhGeDCeBwMoKEdkfiH+umcs+m/
 Jat2szdx4CKcaanPpRTil5veEA98ylCDPXuj/nK4CNJNVflwlSQjfcOxOenR+0pFceGB
 vZf5LWeC/gFCwsPC/U8O3qFwPC70pHNnMSvic4whow5JP9ebETK98TzlXGtvmlqJ0H38
 yZQYGMop+CtBOk8d01YJXaqd7G8I/n4J6MzWOR2gkPdgNh4fknA1xf0YAzVWFxPzzDPR
 NatXXXy207M2ERPvSIMIXEOB945DHv8iEQZC8FcUh2XlsBPOPN4GGIJDAHqs4vIAXgcb
 INaA==
X-Gm-Message-State: AOAM530rUQSwv8Ng2tbw9Jdv4ZdXY5gsfGUveeM+J0dAWIrwoa7DyplT
 u5pkYs3Yp3BOyt5Ef3tMvgrsz3wmUrUl7DVRaogTlPzFPkKSmKn+49okEpY5KxBob+JlQzBkD3o
 P19E4WJsZZ3UoYgV/jcwcqGXCCeLDm+NZGo2g6TS8+GG68cTjql6E4acKfw==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr2321126lfi.498.1639451597762; 
 Mon, 13 Dec 2021 19:13:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZ1HCIVLCKmLXdf3Yl2yAjouNx1OCPxPcR7jWZs3VxYTOSPUyURuqCGeB00yGBqOXmIWH1kqW4dvobsBNeN9Y=
X-Received: by 2002:ac2:518b:: with SMTP id u11mr2321107lfi.498.1639451597577; 
 Mon, 13 Dec 2021 19:13:17 -0800 (PST)
MIME-Version: 1.0
References: <20211213045012.12757-1-mengensun@tencent.com>
 <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
In-Reply-To: <CACGkMEtLso8QjvmjTQ=S_bbGxu11O_scRa8GT7z6MXfJbfzfRg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 14 Dec 2021 11:13:06 +0800
Message-ID: <CACGkMEukGbDcxJe3nGFkeBNenniJdMkFMRnrN4OOfDsCb7ZPuA@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: make copy len check in xdp_linearize_page
To: mengensun8801@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: MengLong Dong <imagedong@tencent.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev <netdev@vger.kernel.org>,
 mengensun <mengensun@tencent.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 ZhengXiong Jiang <mungerjiang@tencent.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 davem <davem@davemloft.net>, linux-kernel <linux-kernel@vger.kernel.org>
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

T24gTW9uLCBEZWMgMTMsIDIwMjEgYXQgNToxNCBQTSDlrZnokpnmgakgPG1lbmdlbnN1bjg4MDFA
Z21haWwuY29tPiB3cm90ZToKPgo+IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IOS6
jjIwMjHlubQxMuaciDEz5pel5ZGo5LiAIDE1OjQ55YaZ6YGT77yaCj4gPgo+ID4gT24gTW9uLCBE
ZWMgMTMsIDIwMjEgYXQgMTI6NTAgUE0gPG1lbmdlbnN1bjg4MDFAZ21haWwuY29tPiB3cm90ZToK
PiA+ID4KPiA+ID4gRnJvbTogbWVuZ2Vuc3VuIDxtZW5nZW5zdW5AdGVuY2VudC5jb20+Cj4gPiA+
Cj4gPiA+IHhkcF9saW5lYXJpemVfcGFnZSBhc3VtZSByaW5nIGVsZW0gc2l6ZSBpcyBzbWFsbGVy
IHRoZW4gcGFnZSBzaXplCj4gPiA+IHdoZW4gY29weSB0aGUgZmlyc3QgcmluZyBlbGVtLCBidXQs
IHRoZXJlIG1heSBiZSBhIGVsZW0gc2l6ZSBiaWdnZXIKPiA+ID4gdGhlbiBwYWdlIHNpemUuCj4g
PiA+Cj4gPiA+IGFkZF9yZWN2YnVmX21lcmdlYWJsZSBtYXkgYWRkIGEgaG9sZSB0byByaW5nIGVs
ZW0sIHRoZSBob2xlIHNpemUgaXMKPiA+ID4gbm90IHN1cmUsIGFjY29yZGluZyBFV01BLgo+ID4K
PiA+IFRoZSBsb2dpYyBpcyB0byB0cnkgdG8gYXZvaWQgZHJvcHBpbmcgcGFja2V0cyBpbiB0aGlz
IGNhc2UsIHNvIEkKPiA+IHdvbmRlciBpZiBpdCdzIGJldHRlciB0byAiZml4IiB0aGUgYWRkX3Jl
Y3ZidWZfbWVyZ2VhYmxlKCkuCj4KCkFkZGluZyBsaXN0cyBiYWNrLgoKPiB0dXJuIHRvIFhEUCBn
ZW5lcmljIGlzIHNvIGRpZmZpY3VsdHkgZm9yIG1lLCBoZXJlIGNhbiAiZml4IiB0aGUKPiBhZGRf
cmVjdmJ1Zl9tZXJnZWFibGUgbGluayBmb2xsb3c6Cj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IGluZGV4
IDM2YTRiN2MxOTVkNS4uMDZjZThiYjEwYjQ3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0xMzE1LDYg
KzEzMTUsNyBAQCBzdGF0aWMgaW50IGFkZF9yZWN2YnVmX21lcmdlYWJsZShzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aSwKPiAgICAgICAgICAgICAgICAgYWxsb2NfZnJhZy0+b2Zmc2V0ICs9IGhvbGU7
Cj4gICAgICAgICB9Cj4gKyAgICAgICBsZW4gPSBtaW4obGVuLCBQQUdFX1NJWkUgLSByb29tKTsK
PiAgICAgICAgIHNnX2luaXRfb25lKHJxLT5zZywgYnVmLCBsZW4pOwo+ICAgICAgICAgY3R4ID0g
bWVyZ2VhYmxlX2xlbl90b19jdHgobGVuLCBoZWFkcm9vbSk7CgpUaGVuIHRoZSB0cnVlc2l6ZSBo
ZXJlIGlzIHdyb25nLgoKPiAgICAgICAgIGVyciA9IHZpcnRxdWV1ZV9hZGRfaW5idWZfY3R4KHJx
LT52cSwgcnEtPnNnLCAxLCBidWYsIGN0eCwgZ2ZwKTsKPgo+IGl0IHNlZW1zIGEgcnVsZSB0aGF0
LCBsZW5ndGggb2YgZWxlbSBnaXZpbmcgdG8gdnJpbmcgaXMgYXdheSBzbWFsbGVyCj4gb3IgZXF1
YWxsIHRoZW4gUEFHRV9TSVpFCgpJdCBhaW1zIHRvIGJlIGNvbnNpc3RlbnQgdG8gd2hhdCBFV01B
IHRyaWVzIHRvIGRvOgoKICAgICAgICBsZW4gPSBoZHJfbGVuICsgY2xhbXBfdCh1bnNpZ25lZCBp
bnQsIGV3bWFfcGt0X2xlbl9yZWFkKGF2Z19wa3RfbGVuKSwKICAgICAgICAgICAgICAgICAgICAg
ICAgcnEtPm1pbl9idWZfbGVuLCBQQUdFX1NJWkUgLSBoZHJfbGVuKTsKClRoYW5rcwoKPgo+ID4K
PiA+IE9yIGFub3RoZXIgaWRlYSBpcyB0byBzd2l0Y2ggdG8gdXNlIFhEUCBnZW5lcmljIGhlcmUg
d2hlcmUgd2UgY2FuIHVzZQo+ID4gc2tiX2xpbmVhcml6ZSgpIHdoaWNoIHNob3VsZCBiZSBtb3Jl
IHJvYnVzdCBhbmQgd2UgY2FuIGRyb3AgdGhlCj4gPiB4ZHBfbGluZWFyaXplX3BhZ2UoKSBsb2dp
YyBjb21wbGV0ZWx5Lgo+ID4KPiA+IFRoYW5rcwo+ID4KPiA+ID4KPiA+ID4gc28sIGZpeCBpdCBi
eSBjaGVjayBjb3B5IGxlbixpZiBjaGVja2VkIGZhaWxlZCwganVzdCBkcm9wcGVkIHRoZQo+ID4g
PiB3aG9sZSBmcmFtZSwgbm90IG1ha2UgdGhlIG1lbW9yeSBkaXJ0eSBhZnRlciB0aGUgcGFnZS4K
PiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1ieTogbWVuZ2Vuc3VuIDxtZW5nZW5zdW5AdGVuY2VudC5j
b20+Cj4gPiA+IFJldmlld2VkLWJ5OiBNZW5nTG9uZyBEb25nIDxpbWFnZWRvbmdAdGVuY2VudC5j
b20+Cj4gPiA+IFJldmlld2VkLWJ5OiBaaGVuZ1hpb25nIEppYW5nIDxtdW5nZXJqaWFuZ0B0ZW5j
ZW50LmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA2ICsr
KysrLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJp
dmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IGluZGV4IDM2YTRiN2MxOTVkNS4uODQ0YmRiZDY3
ZmY3IDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gKysr
IGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IEBAIC02NjIsOCArNjYyLDEyIEBAIHN0
YXRpYyBzdHJ1Y3QgcGFnZSAqeGRwX2xpbmVhcml6ZV9wYWdlKHN0cnVjdCByZWNlaXZlX3F1ZXVl
ICpycSwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHBh
Z2Vfb2ZmLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNp
Z25lZCBpbnQgKmxlbikKPiA+ID4gIHsKPiA+ID4gLSAgICAgICBzdHJ1Y3QgcGFnZSAqcGFnZSA9
IGFsbG9jX3BhZ2UoR0ZQX0FUT01JQyk7Cj4gPiA+ICsgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2U7
Cj4gPiA+Cj4gPiA+ICsgICAgICAgaWYgKCpsZW4gPiBQQUdFX1NJWkUgLSBwYWdlX29mZikKPiA+
ID4gKyAgICAgICAgICAgICAgIHJldHVybiBOVUxMOwo+ID4gPiArCj4gPiA+ICsgICAgICAgcGFn
ZSA9IGFsbG9jX3BhZ2UoR0ZQX0FUT01JQyk7Cj4gPiA+ICAgICAgICAgaWYgKCFwYWdlKQo+ID4g
PiAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4gPiA+Cj4gPiA+IC0tCj4gPiA+IDIuMjcu
MAo+ID4gPgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
