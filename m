Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F62FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 21 Feb 2022 07:00:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CE7A1813EF;
	Mon, 21 Feb 2022 07:00:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4wq9CxIB21ki; Mon, 21 Feb 2022 07:00:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5F11A813EE;
	Mon, 21 Feb 2022 07:00:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 379D9C0021;
	Mon, 21 Feb 2022 07:00:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C899C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:00:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 134B2404F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UcGy_MmFZSe8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:00:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 28BCB40154
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 07:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645426826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSm8KOrS6kS8NyCwUABzD6TbHfkGQCSFiSd91tlc1bI=;
 b=eeeYTULF0LASbdDw3KR1xTonRQCn0uhjxQNuEtTwyQNU0UUtfBtIi4b5uHjZsXBhdVIMux
 l09weUdljUIcOM3pDMvroLNtg9BisVCrFJgsCcowMUkZrreB85VxL2ZJtNen256c3vy+10
 qq08xSgN/Mc+JAABEsMgjVYUzPaDVmU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-193-E3VsGrAWNs2k4p_oRQNNmg-1; Mon, 21 Feb 2022 02:00:24 -0500
X-MC-Unique: E3VsGrAWNs2k4p_oRQNNmg-1
Received: by mail-pj1-f69.google.com with SMTP id
 u11-20020a17090ae00b00b001bc4cef20f1so775118pjy.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Feb 2022 23:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=vSm8KOrS6kS8NyCwUABzD6TbHfkGQCSFiSd91tlc1bI=;
 b=5LyQTto1om0tJirNHdbQFHK/jQp7dUKfI9LH7KWo5jqNvKdrNbn5JUJC982+ovGUNd
 ehbj2yZ5aHAFrnP1TIGq0qW+h8awC5dAxah0Ng20mqauQ8J0Kyv+N+DYmNym02T/siCM
 ZnLlpS9RewiN1HaIKXR2mfic9y2UjRVA+GMil3J5pubQht+femfxvJcLu4Vs1dy7Ri5y
 mIWO3MuBtZvgDm1WtzJ7RNyBGp2WgrYUPdFJjMCcccmV2N8acYsn0+nzgx9m6esWizu1
 uzjws/DZpXnp65gqUbZSNAosttdcce3OSKJZOcYHuA38YRtzDlPCj2ebkh5RYUj7G7q1
 AXgg==
X-Gm-Message-State: AOAM533bwmFJiIDW2ky4XvXtWJ96ZC6ydRzVpvCQznkkVaf/GQACDVkd
 hUGbnU9EU31zr/Re2dYtvU6hnGv7qfQYUxkpEDKUo57gHsiYLrVYavatWXfaca1BgmyO5NCIhSw
 d1HTeUktCYqsriAUQpoeDB86pyjLu+R9dD+KdlJC/1w==
X-Received: by 2002:a63:704a:0:b0:373:a701:3725 with SMTP id
 a10-20020a63704a000000b00373a7013725mr14766708pgn.101.1645426823800; 
 Sun, 20 Feb 2022 23:00:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOCsOnJpfCs2Ur27qkG8aelxMfqGd8HXrf0XQLIXFa2I9GNA2KGgrTJIAy9veH8bCg/ZRDxQ==
X-Received: by 2002:a63:704a:0:b0:373:a701:3725 with SMTP id
 a10-20020a63704a000000b00373a7013725mr14766686pgn.101.1645426823494; 
 Sun, 20 Feb 2022 23:00:23 -0800 (PST)
Received: from [10.72.12.96] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f16sm11737293pfe.52.2022.02.20.23.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Feb 2022 23:00:23 -0800 (PST)
Message-ID: <d8011051-dc45-85f6-3630-4ba0cf6179b2@redhat.com>
Date: Mon, 21 Feb 2022 15:00:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v5 20/22] virtio_net: set the default max ring num
From: Jason Wang <jasowang@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-21-xuanzhuo@linux.alibaba.com>
 <CACGkMEvZvhSb0veCynEHN3EfFu_FwbCAb8w1b0Oi3LDc=ffNaw@mail.gmail.com>
 <1644997568.827981-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt_AEw2Jh9VzkGQ2A8f8Y0nuuFxr193_vnkFpc=JyD2Sg@mail.gmail.com>
 <1645090228.2917905-1-xuanzhuo@linux.alibaba.com>
 <2a7acc5a-2c4d-2176-efd6-2aa828833587@redhat.com>
In-Reply-To: <2a7acc5a-2c4d-2176-efd6-2aa828833587@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIyLzIvMjEg5LiK5Y2IMTE6NDAsIEphc29uIFdhbmcg5YaZ6YGTOgo+Cj4g5ZyoIDIw
MjIvMi8xNyDkuIvljYg1OjMwLCBYdWFuIFpodW8g5YaZ6YGTOgo+PiBPbiBUaHUsIDE3IEZlYiAy
MDIyIDE1OjIxOjI2ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiAKPj4g
d3JvdGU6Cj4+PiBPbiBXZWQsIEZlYiAxNiwgMjAyMiBhdCAzOjUyIFBNIFh1YW4gWmh1byAKPj4+
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4+Pj4gT24gV2VkLCAxNiBGZWIg
MjAyMiAxMjoxNDozMSArMDgwMCwgSmFzb24gV2FuZyAKPj4+PiA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+Pj4+IE9uIE1vbiwgRmViIDE0LCAyMDIyIGF0IDQ6MTQgUE0gWHVhbiBaaHVv
IAo+Pj4+PiA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Pj4+Pj4gU2V0cyB0
aGUgZGVmYXVsdCBtYXhpbXVtIHJpbmcgbnVtIGJhc2VkIG9uIAo+Pj4+Pj4gdmlydGlvX3NldF9t
YXhfcmluZ19udW0oKS4KPj4+Pj4+Cj4+Pj4+PiBUaGUgZGVmYXVsdCBtYXhpbXVtIHJpbmcgbnVt
IGlzIDEwMjQuCj4+Pj4+IEhhdmluZyBhIGRlZmF1bHQgdmFsdWUgaXMgcHJldHR5IHVzZWZ1bCwg
SSBzZWUgMzJLIGlzIHVzZWQgYnkgCj4+Pj4+IGRlZmF1bHQgZm9yIElGQ1ZGLgo+Pj4+Pgo+Pj4+
PiBSZXRoaW5rIHRoaXMsIGhvdyBhYm91dCBoYXZpbmcgYSBkaWZmZXJlbnQgZGVmYXVsdCB2YWx1
ZSBiYXNlZCBvbiAKPj4+Pj4gdGhlIHNwZWVkPwo+Pj4+Pgo+Pj4+PiBXaXRob3V0IFNQRUVEX0RV
UExFWCwgd2UgdXNlIDEwMjQuIE90aGVyd2lzZQo+Pj4+Pgo+Pj4+PiAxMGcgNDA5Ngo+Pj4+PiA0
MGcgODE5Mgo+Pj4+IFdlIGNhbiBkZWZpbmUgZGlmZmVyZW50IGRlZmF1bHQgdmFsdWVzIG9mIHR4
IGFuZCByeCBieSB0aGUgd2F5LiAKPj4+PiBUaGlzIHdheSBJIGNhbgo+Pj4+IGp1c3QgdXNlIGl0
IGluIHRoZSBuZXcgaW50ZXJmYWNlIG9mIGZpbmRfdnFzKCkuCj4+Pj4KPj4+PiB3aXRob3V0IFNQ
RUVEX0RVUExFWDrCoCB0eCA1MTIgcnggMTAyNAo+Pj4+Cj4+PiBBbnkgcmVhc29uIHRoYXQgVFgg
aXMgc21hbGxlciB0aGFuIFJYPwo+Pj4KPj4gSSd2ZSBzZWVuIHNvbWUgTklDIGRyaXZlcnMgd2l0
aCBkZWZhdWx0IHR4IHNtYWxsZXIgdGhhbiByeC4KPgo+Cj4gSW50ZXJlc3RpbmcsIGRvIHRoZXkg
dXNlIGNvbWJpbmVkIGNoYW5uZWxzPwoKCkFkZGluZyBMaW5nIFNoYW4uCgpJIHNlZSAzMksgaXMg
dXNlZCBmb3IgSUZDVkYgYnkgZGVmYXVsdCwgdGhpcyBpcyBhbm90aGVyIGNhbGwgZm9yIHRoZSAK
dGhpcyBwYXRjaDoKCiMgZXRodG9vbCAtZyBldGgwClJpbmcgcGFyYW1ldGVycyBmb3IgZXRoMDoK
UHJlLXNldCBtYXhpbXVtczoKUlg6wqDCoMKgIMKgwqDCoCAzMjc2OApSWCBNaW5pOsKgwqDCoCAw
ClJYIEp1bWJvOsKgwqDCoCAwClRYOsKgwqDCoCDCoMKgwqAgMzI3NjgKQ3VycmVudCBoYXJkd2Fy
ZSBzZXR0aW5nczoKUlg6wqDCoMKgIMKgwqDCoCAzMjc2OApSWCBNaW5pOsKgwqDCoCAwClJYIEp1
bWJvOsKgwqDCoCAwClRYOsKgwqDCoCDCoMKgwqAgMzI3NjgKClRoYW5rcwoKCj4KPgo+Pgo+PiBP
bmUgcHJvYmxlbSBJIGhhdmUgbm93IGlzIHRoYXQgaW5zaWRlIHZpcnRuZXRfcHJvYmUsIGluaXRf
dnFzIGlzIAo+PiBiZWZvcmUgZ2V0dGluZwo+PiBzcGVlZC9kdXBsZXguIEknbSBub3Qgc3VyZSwg
Y2FuIHRoZSBsb2dpYyB0byBnZXQgc3BlZWQvZHVwbGV4IGJlIHB1dCAKPj4gYmVmb3JlCj4+IGlu
aXRfdnFzPyBJcyB0aGVyZSBhbnkgcmlzaz8KPj4KPj4gQ2FuIHlvdSBoZWxwIG1lPwo+Cj4KPiBU
aGUgZmVhdHVyZSBoYXMgYmVlbiBuZWdvdGlhdGVkIGR1cmluZyBwcm9iZSgpLCBzbyBJIGRvbid0
IHNlZSBhbnkgcmlzay4KPgo+IFRoYW5rcwo+Cj4KPj4KPj4gVGhhbmtzLgo+Pgo+Pj4gVGhhbmtz
Cj4+Pgo+Pj4+IFRoYW5rcy4KPj4+Pgo+Pj4+Cj4+Pj4+IGV0Yy4KPj4+Pj4KPj4+Pj4gKFRoZSBu
dW1iZXIgYXJlIGp1c3QgY29waWVkIGZyb20gdGhlIDEwZy80MGcgZGVmYXVsdCBwYXJhbWV0ZXIg
ZnJvbQo+Pj4+PiBvdGhlciB2ZW5kb3JzKQo+Pj4+Pgo+Pj4+PiBUaGFua3MKPj4+Pj4KPj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4+
Pj4+PiAtLS0KPj4+Pj4+IMKgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDQgKysrKwo+Pj4+
Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPj4+Pj4+IGluZGV4IGE0ZmZkN2NkZjYyMy4uNzdlNjFmZTBiMmNlIDEwMDY0NAo+Pj4+Pj4g
LS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPj4+Pj4+IEBAIC0zNSw2ICszNSw4IEBAIG1vZHVsZV9wYXJhbShuYXBpX3R4
LCBib29sLCAwNjQ0KTsKPj4+Pj4+IMKgICNkZWZpbmUgR09PRF9QQUNLRVRfTEVOIChFVEhfSExF
TiArIFZMQU5fSExFTiArIEVUSF9EQVRBX0xFTikKPj4+Pj4+IMKgICNkZWZpbmUgR09PRF9DT1BZ
X0xFTsKgIDEyOAo+Pj4+Pj4KPj4+Pj4+ICsjZGVmaW5lIFZJUlRORVRfREVGQVVMVF9NQVhfUklO
R19OVU0gMTAyNAo+Pj4+Pj4gKwo+Pj4+Pj4gwqAgI2RlZmluZSBWSVJUTkVUX1JYX1BBRCAoTkVU
X0lQX0FMSUdOICsgTkVUX1NLQl9QQUQpCj4+Pj4+Pgo+Pj4+Pj4gwqAgLyogQW1vdW50IG9mIFhE
UCBoZWFkcm9vbSB0byBwcmVwZW5kIHRvIHBhY2tldHMgZm9yIHVzZSBieSAKPj4+Pj4+IHhkcF9h
ZGp1c3RfaGVhZCAqLwo+Pj4+Pj4gQEAgLTMwNDUsNiArMzA0Nyw4IEBAIHN0YXRpYyBpbnQgdmly
dG5ldF9maW5kX3ZxcyhzdHJ1Y3QgCj4+Pj4+PiB2aXJ0bmV0X2luZm8gKnZpKQo+Pj4+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN0eFtyeHEydnEo
aSldID0gdHJ1ZTsKPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+Pj4KPj4+Pj4+ICvCoMKg
wqDCoMKgwqAgdmlydGlvX3NldF9tYXhfcmluZ19udW0odmktPnZkZXYsIAo+Pj4+Pj4gVklSVE5F
VF9ERUZBVUxUX01BWF9SSU5HX05VTSk7Cj4+Pj4+PiArCj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKg
IHJldCA9IHZpcnRpb19maW5kX3Zxc19jdHgodmktPnZkZXYsIHRvdGFsX3ZxcywgdnFzLCAKPj4+
Pj4+IGNhbGxiYWNrcywKPj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5hbWVzLCBjdHgsIE5VTEwpOwo+Pj4+
Pj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQo+Pj4+Pj4gLS0gCj4+Pj4+PiAyLjMxLjAKPj4+
Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
