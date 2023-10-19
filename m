Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF13CDB482
	for <virtualization@archiver.kernel.org>; Thu, 19 Oct 2023 04:24:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E745820D2;
	Thu, 19 Oct 2023 04:24:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E745820D2
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OwrV3AAl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bb9O8M4DiCTB; Thu, 19 Oct 2023 04:24:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BEDE282089;
	Thu, 19 Oct 2023 04:24:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BEDE282089
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9338DC0071;
	Thu, 19 Oct 2023 04:24:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB386C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 04:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B7110821C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 04:24:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B7110821C5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qImZmrULU-Jk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 04:24:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97B2482089
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Oct 2023 04:24:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97B2482089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697689445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uje06+IDMOt/vx/J8KUApszxQg4fGF227v/uCWaECeA=;
 b=OwrV3AAlHd30Gw31oYAQLEPVa6I6nE9ML3g0L0gOJ/98GQtC7asLQv6JKv5/zpvipCFMw2
 hewjLcX3bZmobryDF6Z/afE994Xf4IeFyd0nzRLfdCxAafGmeU4GP2l8CDfk/I2/yoO3LD
 EPugL/oKq7yMSOtyQdO9aaqKxA8W6Kk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-Vj-U7xbJPrqfQ8OPEv3anw-1; Thu, 19 Oct 2023 00:24:01 -0400
X-MC-Unique: Vj-U7xbJPrqfQ8OPEv3anw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-507b8ac8007so3337078e87.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 21:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697689440; x=1698294240;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uje06+IDMOt/vx/J8KUApszxQg4fGF227v/uCWaECeA=;
 b=XnzLHK/GZ7Mc5FodEFpxmksBXFqHEVx1I3sS2wDH/Ym48IcRxWfsBv5qKd4iCipfk9
 7EzkkmcyUkBCxopEbLlmepWLajG6T4hpXRfZ3z+q0ghAXE30470tEfxeewlgt+gXBBZt
 jphkgg546rZ1W4VNu2sjwFVtbGUkiBigxTEAA1L/Xl3YMiquqLUue16+AOAfigeZsVve
 aSXaBmz+yOc2uno6ALYQRNFuDKpPYUhVnLMgJtBOBiVhFYzlju4E2bzZzUA6KpevGRzp
 zOvaZfS7AW8s+agY6CNfRif9HOsF1JwtDD/2HonOnUD+xK44D7+Q2cYQ3qhjEBytohM5
 hE2Q==
X-Gm-Message-State: AOJu0Ywx2HJ5IbRkIEQSoWCkHfhm9QFN6Y3fL6NNefAY/c8deoZZkC2F
 nCEPbu0VGmc/8hKOanFIf16XS5qyPDX0lpN00E5eKHDnFacLCRl8HCHhkm6q38guiC/eNksXK5C
 LYev5bn4pJdqFD4sJN8O/2YP1yn6au5Od13wBpVLm97OTGpL2W06RSZjnGA==
X-Received: by 2002:a19:ee14:0:b0:500:7685:83d with SMTP id
 g20-20020a19ee14000000b005007685083dmr568831lfb.48.1697689439817; 
 Wed, 18 Oct 2023 21:23:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0cSd1leA1z1IEbWaSrC+PUAKHLFPVSoCz7pyb25FZIitCtvt4UQzpR1S+XpCSPSBkYRmEQ65C+ZNEeRGxNQA=
X-Received: by 2002:a19:ee14:0:b0:500:7685:83d with SMTP id
 g20-20020a19ee14000000b005007685083dmr568824lfb.48.1697689439457; Wed, 18 Oct
 2023 21:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231016120033.26933-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Oct 2023 12:23:48 +0800
Message-ID: <CACGkMEvU+nhC=Qaj_gWGi3osGgTYdwVDav4-1fs2BrbvDOEpyg@mail.gmail.com>
Subject: Re: [PATCH net-next v1 02/19] virtio_net: unify the code for
 recycling the xmit ptr
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gVGhlcmUgYXJlIHR3byBjb21wbGV0ZWx5IHNpbWls
YXIgYW5kIGluZGVwZW5kZW50IGltcGxlbWVudGF0aW9ucy4gVGhpcwo+IGlzIGluY29udmVuaWVu
dCBmb3IgdGhlIHN1YnNlcXVlbnQgYWRkaXRpb24gb2YgbmV3IHR5cGVzLiBTbyBleHRyYWN0IGEK
PiBmdW5jdGlvbiBmcm9tIHRoaXMgcGllY2Ugb2YgY29kZSBhbmQgY2FsbCB0aGlzIGZ1bmN0aW9u
IHVuaWZvcm1seSB0bwo+IHJlY292ZXIgb2xkIHhtaXQgcHRyLgo+Cj4gU2lnbmVkLW9mZi1ieTog
WHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgfCA3NiArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCA0MyBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBpbmRleCAzZDg3Mzg2ZDgyMjAuLjZjZjc3YjZhY2RhYiAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiBAQCAtMzUyLDYgKzM1MiwzMCBAQCBzdGF0aWMgc3RydWN0IHhkcF9mcmFtZSAqcHRyX3Rv
X3hkcCh2b2lkICpwdHIpCj4gICAgICAgICByZXR1cm4gKHN0cnVjdCB4ZHBfZnJhbWUgKikoKHVu
c2lnbmVkIGxvbmcpcHRyICYgflZJUlRJT19YRFBfRkxBRyk7Cj4gIH0KPgo+ICtzdGF0aWMgdm9p
ZCBfX2ZyZWVfb2xkX3htaXQoc3RydWN0IHNlbmRfcXVldWUgKnNxLCBib29sIGluX25hcGksCj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0bmV0X3NxX3N0YXRzICpzdGF0
cykKPiArewo+ICsgICAgICAgdW5zaWduZWQgaW50IGxlbjsKPiArICAgICAgIHZvaWQgKnB0cjsK
PiArCj4gKyAgICAgICB3aGlsZSAoKHB0ciA9IHZpcnRxdWV1ZV9nZXRfYnVmKHNxLT52cSwgJmxl
bikpICE9IE5VTEwpIHsKPiArICAgICAgICAgICAgICAgaWYgKCFpc194ZHBfZnJhbWUocHRyKSkg
ewo+ICsgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBza19idWZmICpza2IgPSBwdHI7Cj4g
Kwo+ICsgICAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCJTZW50IHNrYiAlcFxuIiwgc2ti
KTsKPiArCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3RhdHMtPmJ5dGVzICs9IHNrYi0+bGVu
Owo+ICsgICAgICAgICAgICAgICAgICAgICAgIG5hcGlfY29uc3VtZV9za2Ioc2tiLCBpbl9uYXBp
KTsKPiArICAgICAgICAgICAgICAgfSBlbHNlIHsKPiArICAgICAgICAgICAgICAgICAgICAgICBz
dHJ1Y3QgeGRwX2ZyYW1lICpmcmFtZSA9IHB0cl90b194ZHAocHRyKTsKPiArCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgc3RhdHMtPmJ5dGVzICs9IHhkcF9nZXRfZnJhbWVfbGVuKGZyYW1lKTsK
PiArICAgICAgICAgICAgICAgICAgICAgICB4ZHBfcmV0dXJuX2ZyYW1lKGZyYW1lKTsKPiArICAg
ICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICBzdGF0cy0+cGFja2V0cysrOwo+ICsgICAg
ICAgfQo+ICt9Cj4gKwo+ICAvKiBDb252ZXJ0aW5nIGJldHdlZW4gdmlydHF1ZXVlIG5vLiBhbmQg
a2VybmVsIHR4L3J4IHF1ZXVlIG5vLgo+ICAgKiAwOnJ4MCAxOnR4MCAyOnJ4MSAzOnR4MSAuLi4g
Mk46cnhOIDJOKzE6dHhOIDJOKzI6Y3ZxCj4gICAqLwo+IEBAIC03NDYsMzcgKzc3MCwxOSBAQCBz
dGF0aWMgdm9pZCB2aXJ0bmV0X3JxX3NldF9wcmVtYXBwZWQoc3RydWN0IHZpcnRuZXRfaW5mbyAq
dmkpCj4KPiAgc3RhdGljIHZvaWQgZnJlZV9vbGRfeG1pdChzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3Es
IGJvb2wgaW5fbmFwaSkKPiAgewo+IC0gICAgICAgdW5zaWduZWQgaW50IGxlbjsKPiAtICAgICAg
IHVuc2lnbmVkIGludCBwYWNrZXRzID0gMDsKPiAtICAgICAgIHVuc2lnbmVkIGludCBieXRlcyA9
IDA7Cj4gLSAgICAgICB2b2lkICpwdHI7Cj4gKyAgICAgICBzdHJ1Y3QgdmlydG5ldF9zcV9zdGF0
cyBzdGF0cyA9IHt9Owo+Cj4gLSAgICAgICB3aGlsZSAoKHB0ciA9IHZpcnRxdWV1ZV9nZXRfYnVm
KHNxLT52cSwgJmxlbikpICE9IE5VTEwpIHsKPiAtICAgICAgICAgICAgICAgaWYgKGxpa2VseSgh
aXNfeGRwX2ZyYW1lKHB0cikpKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNr
X2J1ZmYgKnNrYiA9IHB0cjsKPiAtCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcHJfZGVidWco
IlNlbnQgc2tiICVwXG4iLCBza2IpOwo+IC0KPiAtICAgICAgICAgICAgICAgICAgICAgICBieXRl
cyArPSBza2ItPmxlbjsKPiAtICAgICAgICAgICAgICAgICAgICAgICBuYXBpX2NvbnN1bWVfc2ti
KHNrYiwgaW5fbmFwaSk7Cj4gLSAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHhkcF9mcmFtZSAqZnJhbWUgPSBwdHJfdG9feGRwKHB0cik7Cj4g
LQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGJ5dGVzICs9IHhkcF9nZXRfZnJhbWVfbGVuKGZy
YW1lKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICB4ZHBfcmV0dXJuX2ZyYW1lKGZyYW1lKTsK
PiAtICAgICAgICAgICAgICAgfQo+IC0gICAgICAgICAgICAgICBwYWNrZXRzKys7Cj4gLSAgICAg
ICB9Cj4gKyAgICAgICBfX2ZyZWVfb2xkX3htaXQoc3EsIGluX25hcGksICZzdGF0cyk7Cj4KPiAg
ICAgICAgIC8qIEF2b2lkIG92ZXJoZWFkIHdoZW4gbm8gcGFja2V0cyBoYXZlIGJlZW4gcHJvY2Vz
c2VkCj4gICAgICAgICAgKiBoYXBwZW5zIHdoZW4gY2FsbGVkIHNwZWN1bGF0aXZlbHkgZnJvbSBz
dGFydF94bWl0Lgo+ICAgICAgICAgICovCj4gLSAgICAgICBpZiAoIXBhY2tldHMpCj4gKyAgICAg
ICBpZiAoIXN0YXRzLnBhY2tldHMpCj4gICAgICAgICAgICAgICAgIHJldHVybjsKPgo+ICAgICAg
ICAgdTY0X3N0YXRzX3VwZGF0ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNwKTsKPiAtICAgICAgIHNx
LT5zdGF0cy5ieXRlcyArPSBieXRlczsKPiAtICAgICAgIHNxLT5zdGF0cy5wYWNrZXRzICs9IHBh
Y2tldHM7Cj4gKyAgICAgICBzcS0+c3RhdHMuYnl0ZXMgKz0gc3RhdHMuYnl0ZXM7Cj4gKyAgICAg
ICBzcS0+c3RhdHMucGFja2V0cyArPSBzdGF0cy5wYWNrZXRzOwo+ICAgICAgICAgdTY0X3N0YXRz
X3VwZGF0ZV9lbmQoJnNxLT5zdGF0cy5zeW5jcCk7Cj4gIH0KPgo+IEBAIC05MTUsMTUgKzkyMSwx
MiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IG4sIHN0cnVjdCB4ZHBfZnJhbWUgKipm
cmFtZXMsIHUzMiBmbGFncykKPiAgewo+ICAgICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkg
PSBuZXRkZXZfcHJpdihkZXYpOwo+ICsgICAgICAgc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3Rh
dHMgPSB7fTsKPiAgICAgICAgIHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSA9IHZpLT5ycTsKPiAg
ICAgICAgIHN0cnVjdCBicGZfcHJvZyAqeGRwX3Byb2c7Cj4gICAgICAgICBzdHJ1Y3Qgc2VuZF9x
dWV1ZSAqc3E7Cj4gLSAgICAgICB1bnNpZ25lZCBpbnQgbGVuOwo+IC0gICAgICAgaW50IHBhY2tl
dHMgPSAwOwo+IC0gICAgICAgaW50IGJ5dGVzID0gMDsKPiAgICAgICAgIGludCBueG1pdCA9IDA7
Cj4gICAgICAgICBpbnQga2lja3MgPSAwOwo+IC0gICAgICAgdm9pZCAqcHRyOwo+ICAgICAgICAg
aW50IHJldDsKPiAgICAgICAgIGludCBpOwo+Cj4gQEAgLTk0MiwyMCArOTQ1LDcgQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAgICAgICB9
Cj4KPiAgICAgICAgIC8qIEZyZWUgdXAgYW55IHBlbmRpbmcgb2xkIGJ1ZmZlcnMgYmVmb3JlIHF1
ZXVlaW5nIG5ldyBvbmVzLiAqLwo+IC0gICAgICAgd2hpbGUgKChwdHIgPSB2aXJ0cXVldWVfZ2V0
X2J1ZihzcS0+dnEsICZsZW4pKSAhPSBOVUxMKSB7Cj4gLSAgICAgICAgICAgICAgIGlmIChsaWtl
bHkoaXNfeGRwX2ZyYW1lKHB0cikpKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0
IHhkcF9mcmFtZSAqZnJhbWUgPSBwdHJfdG9feGRwKHB0cik7Cj4gLQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgIGJ5dGVzICs9IHhkcF9nZXRfZnJhbWVfbGVuKGZyYW1lKTsKPiAtICAgICAgICAg
ICAgICAgICAgICAgICB4ZHBfcmV0dXJuX2ZyYW1lKGZyYW1lKTsKPiAtICAgICAgICAgICAgICAg
fSBlbHNlIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2tfYnVmZiAqc2tiID0g
cHRyOwo+IC0KPiAtICAgICAgICAgICAgICAgICAgICAgICBieXRlcyArPSBza2ItPmxlbjsKPiAt
ICAgICAgICAgICAgICAgICAgICAgICBuYXBpX2NvbnN1bWVfc2tiKHNrYiwgZmFsc2UpOwo+IC0g
ICAgICAgICAgICAgICB9Cj4gLSAgICAgICAgICAgICAgIHBhY2tldHMrKzsKPiAtICAgICAgIH0K
PiArICAgICAgIF9fZnJlZV9vbGRfeG1pdChzcSwgZmFsc2UsICZzdGF0cyk7Cj4KPiAgICAgICAg
IGZvciAoaSA9IDA7IGkgPCBuOyBpKyspIHsKPiAgICAgICAgICAgICAgICAgc3RydWN0IHhkcF9m
cmFtZSAqeGRwZiA9IGZyYW1lc1tpXTsKPiBAQCAtOTc1LDggKzk2NSw4IEBAIHN0YXRpYyBpbnQg
dmlydG5ldF94ZHBfeG1pdChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgICAgICAgfQo+ICBv
dXQ6Cj4gICAgICAgICB1NjRfc3RhdHNfdXBkYXRlX2JlZ2luKCZzcS0+c3RhdHMuc3luY3ApOwo+
IC0gICAgICAgc3EtPnN0YXRzLmJ5dGVzICs9IGJ5dGVzOwo+IC0gICAgICAgc3EtPnN0YXRzLnBh
Y2tldHMgKz0gcGFja2V0czsKPiArICAgICAgIHNxLT5zdGF0cy5ieXRlcyArPSBzdGF0cy5ieXRl
czsKPiArICAgICAgIHNxLT5zdGF0cy5wYWNrZXRzICs9IHN0YXRzLnBhY2tldHM7Cj4gICAgICAg
ICBzcS0+c3RhdHMueGRwX3R4ICs9IG47Cj4gICAgICAgICBzcS0+c3RhdHMueGRwX3R4X2Ryb3Bz
ICs9IG4gLSBueG1pdDsKPiAgICAgICAgIHNxLT5zdGF0cy5raWNrcyArPSBraWNrczsKPiAtLQo+
IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
