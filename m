Return-Path: <SRS0=J7vq=KX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA9AC47087
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 22:25:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A897461358
	for <virtualization@archiver.kernel.org>; Fri, 28 May 2021 22:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A897461358
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54ED440E82;
	Fri, 28 May 2021 22:25:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RWSwtEGJkHQl; Fri, 28 May 2021 22:25:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AB33140ECB;
	Fri, 28 May 2021 22:25:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6DC0BC000E;
	Fri, 28 May 2021 22:25:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ADC90C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 22:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9CFDD400DE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 22:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1IcEgxxlnMxR
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 22:25:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9A445400D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 22:25:52 +0000 (UTC)
Received: by mail-ed1-x531.google.com with SMTP id o5so6522163edc.5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 15:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yrBjQ7Lx1mhxXojaT5BK59jpSBAfuzBAQF2fCcC/VrM=;
 b=h6xXfopGioGNYSxEvqJZc9IzxUg0PKrW0f6NrQBM5LMuFgYxxz4Jxs2hkpZTJvK2q5
 Ynt+/OYJSjOVrL2N4DQhWECVc0Xoj8LAQJLlc6pe5B1mJG2b2GL9fCq6c6ygw5XKMp1Y
 a8UR3mnNy7W81PZwBAVR8R+sJ+HAMFW6RNZmyUZ3mILH8440RvZBDM5ZDTjdEuVMQSNM
 M9epeJBfwuJIDQnwG5JQ15RGyb1fbg8PEuG/1LkmTctny74e/OObX0xSdWAylYSFOWOb
 puVHbeMRYyWz+hrlaNrjCP6cqXEvWX6gJmeRiy2LOED5wLI9RXd4LxMQs4vWGPDHM/lu
 MEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yrBjQ7Lx1mhxXojaT5BK59jpSBAfuzBAQF2fCcC/VrM=;
 b=IZBYxjfBZQZvpJimH/trvEsZ0jOw7VuQRkLPyse6/kDByu9AwghpegH6StEAOhPUpr
 Q1CnHyQxRlR0OpYjvMnpnAK79k8MHmDyaCLvVIBzgqDpE/g5qkh9yUIJr/WBzBRUVb3O
 TqCVMGgghH89gkBHtOKF6U1e1i2f85Aw+PWN4Y1NdQApzWNWGdn5UF4JbPXQeJmu8RPn
 KT/6zpwGdfSvwpjXlKv1NAW2/vRk7A4sKIm721fzkMlJD+vmsR6YWMTMVUS0BXejNFMu
 388hNHACkWq2ggiFB75aN1wU56G/n7cvtnQbp1fi6xgpOlBSEBL+Qp1CoBjPOziv5RaL
 2XHg==
X-Gm-Message-State: AOAM533ZCbYhZxPtXA1O4GkyN+KOAc2m7s/Ch1frvZ6EgNJ5elcU6OOz
 bNcFkqrLnYmKfOI8hJrhlpiCaWRASeQ=
X-Google-Smtp-Source: ABdhPJx4/M+YOc4UtmlTTtB+klGNAfx+YtSN6ixLmMGUQao9ABK3Wetfw5PhpJ2eK+dnye1ebPvUVQ==
X-Received: by 2002:aa7:db08:: with SMTP id t8mr12075733eds.277.1622240750433; 
 Fri, 28 May 2021 15:25:50 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com.
 [209.85.128.44])
 by smtp.gmail.com with ESMTPSA id cn21sm3296444edb.36.2021.05.28.15.25.48
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 May 2021 15:25:49 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id
 l18-20020a1ced120000b029014c1adff1edso5332724wmh.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 May 2021 15:25:48 -0700 (PDT)
X-Received: by 2002:a7b:c935:: with SMTP id h21mr2799976wml.183.1622240748511; 
 Fri, 28 May 2021 15:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-2-mst@redhat.com>
 <476e9418-156d-dbc9-5105-11d2816b95f7@redhat.com>
In-Reply-To: <476e9418-156d-dbc9-5105-11d2816b95f7@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 28 May 2021 18:25:11 -0400
X-Gmail-Original-Message-ID: <CA+FuTSccMS4qEyexAuzjcuevS8KwaruJih5_0hgiOFz4BpDHzA@mail.gmail.com>
Message-ID: <CA+FuTSccMS4qEyexAuzjcuevS8KwaruJih5_0hgiOFz4BpDHzA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] virtio_net: move tx vq operation under tx queue
 lock
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, Wei Wang <weiwan@google.com>,
 David Miller <davem@davemloft.net>
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

T24gV2VkLCBNYXkgMjYsIDIwMjEgYXQgMTE6NDEgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIxLzUvMjYg5LiL5Y2INDoyNCwgTWljaGFlbCBT
LiBUc2lya2luIOWGmemBkzoKPiA+IEl0J3MgdW5zYWZlIHRvIG9wZXJhdGUgYSB2cSBmcm9tIG11
bHRpcGxlIHRocmVhZHMuCj4gPiBVbmZvcnR1bmF0ZWx5IHRoaXMgaXMgZXhhY3RseSB3aGF0IHdl
IGRvIHdoZW4gaW52b2tpbmcKPiA+IGNsZWFuIHR4IHBvbGwgZnJvbSByeCBuYXBpLgo+ID4gU2Ft
ZSBoYXBwZW5zIHdpdGggbmFwaS10eCBldmVuIHdpdGhvdXQgdGhlCj4gPiBvcHBvcnR1bmlzdGlj
IGNsZWFuaW5nIGZyb20gdGhlIHJlY2VpdmUgaW50ZXJydXB0OiB0aGF0IHJhY2VzCj4gPiB3aXRo
IHByb2Nlc3NpbmcgdGhlIHZxIGluIHN0YXJ0X3htaXQuCj4gPgo+ID4gQXMgYSBmaXggbW92ZSBl
dmVyeXRoaW5nIHRoYXQgZGVhbHMgd2l0aCB0aGUgdnEgdG8gdW5kZXIgdHggbG9jay4KClRoaXMg
cGF0Y2ggYWxzbyBkaXNhYmxlcyBjYWxsYmFja3MgZHVyaW5nIGZyZWVfb2xkX3htaXRfc2ticwpw
cm9jZXNzaW5nIG9uIHR4IGludGVycnVwdC4gU2hvdWxkIHRoYXQgYmUgYSBzZXBhcmF0ZSBjb21t
aXQsIHdpdGggaXRzCm93biBleHBsYW5hdGlvbj8KPiA+Cj4gPiBGaXhlczogYjkyZjFlNjc1MWE2
ICgidmlydGlvLW5ldDogdHJhbnNtaXQgbmFwaSIpCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVs
IFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBp
bmRleCBhYzBjMTQzZjk3YjQuLjEyNTEyZDEwMDJlYyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBA
QCAtMTUwOCw2ICsxNTA4LDggQEAgc3RhdGljIGludCB2aXJ0bmV0X3BvbGxfdHgoc3RydWN0IG5h
cGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0KQo+ID4gICAgICAgc3RydWN0IHZpcnRuZXRfaW5m
byAqdmkgPSBzcS0+dnEtPnZkZXYtPnByaXY7Cj4gPiAgICAgICB1bnNpZ25lZCBpbnQgaW5kZXgg
PSB2cTJ0eHEoc3EtPnZxKTsKPiA+ICAgICAgIHN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsKPiA+
ICsgICAgIGludCBvcGFxdWU7Cj4gPiArICAgICBib29sIGRvbmU7Cj4gPgo+ID4gICAgICAgaWYg
KHVubGlrZWx5KGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHZpLCBpbmRleCkpKSB7Cj4gPiAgICAg
ICAgICAgICAgIC8qIFdlIGRvbid0IG5lZWQgdG8gZW5hYmxlIGNiIGZvciBYRFAgKi8KPiA+IEBA
IC0xNTE3LDEwICsxNTE5LDI4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsX3R4KHN0cnVjdCBu
YXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiA+Cj4gPiAgICAgICB0eHEgPSBuZXRkZXZf
Z2V0X3R4X3F1ZXVlKHZpLT5kZXYsIGluZGV4KTsKPiA+ICAgICAgIF9fbmV0aWZfdHhfbG9jayh0
eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpOwo+ID4gKyAgICAgdmlydHF1ZXVlX2Rpc2FibGVf
Y2Ioc3EtPnZxKTsKPiA+ICAgICAgIGZyZWVfb2xkX3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gPiAr
Cj4gPiArICAgICBvcGFxdWUgPSB2aXJ0cXVldWVfZW5hYmxlX2NiX3ByZXBhcmUoc3EtPnZxKTsK
PiA+ICsKPiA+ICsgICAgIGRvbmUgPSBuYXBpX2NvbXBsZXRlX2RvbmUobmFwaSwgMCk7Cj4gPiAr
Cj4gPiArICAgICBpZiAoIWRvbmUpCj4gPiArICAgICAgICAgICAgIHZpcnRxdWV1ZV9kaXNhYmxl
X2NiKHNxLT52cSk7Cj4gPiArCj4gPiAgICAgICBfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+ID4K
PiA+IC0gICAgIHZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlKG5hcGksIHNxLT52cSwgMCk7Cj4gPiAr
ICAgICBpZiAoZG9uZSkgewo+ID4gKyAgICAgICAgICAgICBpZiAodW5saWtlbHkodmlydHF1ZXVl
X3BvbGwoc3EtPnZxLCBvcGFxdWUpKSkgewoKU2hvdWxkIHRoaXMgYWxzbyBiZSBpbnNpZGUgdGhl
IGxvY2ssIGFzIGl0IG9wZXJhdGVzIG9uIHZxPwoKSXMgdGhlcmUgYW55dGhpbmcgdGhhdCBpcyBu
b3QgYWxsb3dlZCB0byBydW4gd2l0aCB0aGUgbG9jayBoZWxkPwoKPiA+ICsgICAgICAgICAgICAg
ICAgICAgICBpZiAobmFwaV9zY2hlZHVsZV9wcmVwKG5hcGkpKSB7Cj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBfX25ldGlmX3R4X2xvY2sodHhxLCByYXdfc21wX3Byb2Nlc3Nvcl9p
ZCgpKTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZpcnRxdWV1ZV9kaXNhYmxl
X2NiKHNxLT52cSk7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX25ldGlmX3R4
X3VubG9jayh0eHEpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19uYXBpX3Nj
aGVkdWxlKG5hcGkpOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgIH0KPiA+ICsgICAgICAgICAg
ICAgfQo+ID4gKyAgICAgfQo+Cj4KPiBJbnRlcmVzdGluZywgdGhpcyBsb29rcyBsaWtlIHNvbWVo
d28gYSBvcGVuLWNvZGVkIHZlcnNpb24gb2YKPiB2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZSgpLiBJ
IHdvbmRlciBpZiB3ZSBjYW4gc2ltcGx5IGtlZXAgdXNpbmcKPiB2aXJ0cXVldWVfbmFwaV9jb21w
bGV0ZSgpIGJ5IHNpbXBseSBtb3ZpbmcgdGhlIF9fbmV0aWZfdHhfdW5sb2NrKCkgYWZ0ZXIKPiB0
aGF0Ogo+Cj4gbmV0aWZfdHhfbG9jayh0eHEpOwo+IGZyZWVfb2xkX3htaXRfc2ticyhzcSwgdHJ1
ZSk7Cj4gdmlydHF1ZXVlX25hcGlfY29tcGxldGUobmFwaSwgc3EtPnZxLCAwKTsKPiBfX25ldGlm
X3R4X3VubG9jayh0eHEpOwoKQWdyZWVkLiBBbmQgc3Vic2VxdWVudCBibG9jawoKICAgICAgIGlm
IChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQogICAgICAgICAgICAgICBu
ZXRpZl90eF93YWtlX3F1ZXVlKHR4cSk7CgphcyB3ZWxsCgo+Cj4gVGhhbmtzCj4KPgo+ID4KPiA+
ICAgICAgIGlmIChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tCX0ZSQUdTKQo+ID4gICAg
ICAgICAgICAgICBuZXRpZl90eF93YWtlX3F1ZXVlKHR4cSk7Cj4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
