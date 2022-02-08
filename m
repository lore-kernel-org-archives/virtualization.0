Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8F4C433FE
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3232160BF1;
	Tue,  8 Feb 2022 03:00:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EFCmacAILpvN; Tue,  8 Feb 2022 03:00:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B3605607F6;
	Tue,  8 Feb 2022 03:00:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B977C0011;
	Tue,  8 Feb 2022 03:00:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8A9CC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 972BB60803
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:00:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id D1e6MQ5kYfBw
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:00:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A17F4607F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644289199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ur/XVUARqlEylrl75WMsGXRxz0bKGIVFgoVCSK+68pc=;
 b=d2PYgbgkH/Kcf9lByrfy/K+Wnyey04CUSk6I5uoDAKgdRLs8skWGqmh9Tv5wdgJje43yux
 Xj+DdcnIg1KvnYWJ+3fPuNA9I12SnOB/QfF3zgtDwVld91rffTAIPpx2Ge9bg5uub6Uoq2
 ZE1pPiCIdJI/wnbhtUaWtwQ/IPBDgh0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-246-6yGvGNn2PQCSZX8nku3TeQ-1; Mon, 07 Feb 2022 21:59:57 -0500
X-MC-Unique: 6yGvGNn2PQCSZX8nku3TeQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 f24-20020aa782d8000000b004bc00caa4c0so8638818pfn.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 18:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=Ur/XVUARqlEylrl75WMsGXRxz0bKGIVFgoVCSK+68pc=;
 b=AsD5GjEeL1y/nQjf5z4q+cHUqKCDlBGJUu7DqELEAB8PA0HmPFYPoTHXHEs2qm2RN8
 6XeZQ+Z3NU5S3QCvFif+XbZV1zaReQ68BvnFxJWy+UOybXsQTGH+LVfYrp4KEvVetl9K
 S19k/gqqr3IIIZ/U3QP2G4QKXC83SQPGP6vpkaKZyv2IvSnvygvxMnCw+7r0UsrPpUXC
 xRa4a5gN21M2BPgoSahVX6/DIX2vlMx2fCb0mJ5cqvFCWZXQdD5e/etmKDIzSViF3b2z
 ecnB/J266uNhg/6sLyI3k/jdReagg02gQhVCZfEH8oirsgKg6J6+fL/u648oTibSxqdD
 d+Ag==
X-Gm-Message-State: AOAM5320F2WzYq72EK5uYtEvWZYH5G9XHduHcxgb5p9Zb0Ib7iZl1lsX
 B7xbvdqka8vcGLUySKJzSYkG6hKun626FdO7Axl/YZVVHOnr5aonYOL0ptOF6E32olZPrgAK0en
 4dz1lQD74ZkZUeG9jkmLa+Y7Zg+OAETlqO06PAmdpKw==
X-Received: by 2002:a17:90a:4291:: with SMTP id
 p17mr2091900pjg.126.1644289195744; 
 Mon, 07 Feb 2022 18:59:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw66uwPUuiCvtKOAmk3ev+B5LJnqGSuJHyL+yJsXiATMQiVAvJGYVXYkgiixcW3KyH9wSlZ6w==
X-Received: by 2002:a17:90a:4291:: with SMTP id
 p17mr2091878pjg.126.1644289195452; 
 Mon, 07 Feb 2022 18:59:55 -0800 (PST)
Received: from [10.72.13.233] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id m21sm13834878pfk.26.2022.02.07.18.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 18:59:54 -0800 (PST)
Message-ID: <7d1e2d5b-a9a1-cbb7-4d80-89df1cb7bf15@redhat.com>
Date: Tue, 8 Feb 2022 10:59:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v3 00/17] virtio pci support VIRTIO_F_RING_RESET
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1644213739.5846965-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1644213739.5846965-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
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

CuWcqCAyMDIyLzIvNyDkuIvljYgyOjAyLCBYdWFuIFpodW8g5YaZ6YGTOgo+IE9uIE1vbiwgNyBG
ZWIgMjAyMiAxMTozOTozNiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+IE9uIFdlZCwgSmFuIDI2LCAyMDIyIGF0IDM6MzUgUE0gWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4+PiA9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQo+Pj4gVGhlIHZpcnRpbyBzcGVjIGFscmVhZHkgc3VwcG9ydHMgdGhlIHZpcnRpbyBxdWV1ZSBy
ZXNldCBmdW5jdGlvbi4gVGhpcyBwYXRjaCBzZXQKPj4+IGlzIHRvIGFkZCB0aGlzIGZ1bmN0aW9u
IHRvIHRoZSBrZXJuZWwuIFRoZSByZWxldmFudCB2aXJ0aW8gc3BlYyBpbmZvcm1hdGlvbiBpcwo+
Pj4gaGVyZToKPj4+Cj4+PiAgICAgIGh0dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlv
LXNwZWMvaXNzdWVzLzEyNAo+Pj4KPj4+IEFsc28gcmVnYXJkaW5nIE1NSU8gc3VwcG9ydCBmb3Ig
cXVldWUgcmVzZXQsIEkgcGxhbiB0byBzdXBwb3J0IGl0IGFmdGVyIHRoaXMKPj4+IHBhdGNoIGlz
IHBhc3NlZC4KPj4+Cj4+PiAjMTQtIzE3IGlzIHRoZSBkaXNhYmxlL2VuYWJsZSBmdW5jdGlvbiBv
ZiByeC90eCBwYWlyIGltcGxlbWVudGVkIGJ5IHZpcnRpby1uZXQKPj4+IHVzaW5nIHRoZSBuZXcg
aGVscGVyLgo+PiBPbmUgdGhpbmcgdGhhdCBjYW1lIHRvIG1pbmQgaXMgdGhlIHN0ZWVyaW5nLiBF
LmcgaWYgd2UgZGlzYWJsZSBhbiBSWCwKPj4gc2hvdWxkIHdlIHN0b3Agc3RlZXJpbmcgcGFja2V0
cyB0byB0aGF0IHF1ZXVlPwo+IFllcywgd2Ugc2hvdWxkIHJlc2VsZWN0IGEgcXVldWUuCj4KPiBU
aGFua3MuCgoKTWF5YmUgYSBzcGVjIHBhdGNoIGZvciB0aGF0PwoKVGhhbmtzCgoKPgo+PiBUaGFu
a3MKPj4KPj4+IFRoaXMgZnVuY3Rpb24gaXMgbm90IGN1cnJlbnRseSByZWZlcmVuY2VkIGJ5IG90
aGVyCj4+PiBmdW5jdGlvbnMuIEl0IGlzIG1vcmUgdG8gc2hvdyB0aGUgdXNhZ2Ugb2YgdGhlIG5l
dyBoZWxwZXIsIEkgbm90IHN1cmUgaWYgdGhleQo+Pj4gYXJlIGdvaW5nIHRvIGJlIG1lcmdlZCB0
b2dldGhlci4KPj4+Cj4+PiBQbGVhc2UgcmV2aWV3LiBUaGFua3MuCj4+Pgo+Pj4gdjM6Cj4+PiAg
ICAxLiBrZWVwIHZxLCBpcnEgdW5yZWxlYXNlZAo+Pj4KPj4+IFh1YW4gWmh1byAoMTcpOgo+Pj4g
ICAgdmlydGlvX3BjaTogc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBhZGQgcXVldWVfbm90
aWZ5X2RhdGEKPj4+ICAgIHZpcnRpbzogcXVldWVfcmVzZXQ6IGFkZCBWSVJUSU9fRl9SSU5HX1JF
U0VUCj4+PiAgICB2aXJ0aW86IHF1ZXVlX3Jlc2V0OiBzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMg
YWRkIGNhbGxiYWNrcyBmb3IKPj4+ICAgICAgcXVldWVfcmVzZXQKPj4+ICAgIHZpcnRpbzogcXVl
dWVfcmVzZXQ6IGFkZCBoZWxwZXIKPj4+ICAgIHZyaXRpb19yaW5nOiBxdWV1ZV9yZXNldDogZXh0
cmFjdCB0aGUgcmVsZWFzZSBmdW5jdGlvbiBvZiB0aGUgdnEgcmluZwo+Pj4gICAgdmlydGlvX3Jp
bmc6IHF1ZXVlX3Jlc2V0OiBzcGxpdDogYWRkIF9fdnJpbmdfaW5pdF92aXJ0cXVldWUoKQo+Pj4g
ICAgdmlydGlvX3Jpbmc6IHF1ZXVlX3Jlc2V0OiBzcGxpdDogc3VwcG9ydCBlbmFibGUgcmVzZXQg
cXVldWUKPj4+ICAgIHZpcnRpb19yaW5nOiBxdWV1ZV9yZXNldDogcGFja2VkOiBzdXBwb3J0IGVu
YWJsZSByZXNldCBxdWV1ZQo+Pj4gICAgdmlydGlvX3Jpbmc6IHF1ZXVlX3Jlc2V0OiBhZGQgdnJp
bmdfcmVzZXRfdmlydHF1ZXVlKCkKPj4+ICAgIHZpcnRpb19wY2k6IHF1ZXVlX3Jlc2V0OiB1cGRh
dGUgc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBhbmQKPj4+ICAgICAgb3B0aW9uIGZ1bmN0
aW9ucwo+Pj4gICAgdmlydGlvX3BjaTogcXVldWVfcmVzZXQ6IHJlbGVhc2UgdnEgYnkgdnBfZGV2
LT52cXMKPj4+ICAgIHZpcnRpb19wY2k6IHF1ZXVlX3Jlc2V0OiBzZXR1cF92cSB1c2UgdnJpbmdf
c2V0dXBfdmlydHF1ZXVlKCkKPj4+ICAgIHZpcnRpb19wY2k6IHF1ZXVlX3Jlc2V0OiBzdXBwb3J0
IFZJUlRJT19GX1JJTkdfUkVTRVQKPj4+ICAgIHZpcnRpb19uZXQ6IHZpcnRuZXRfdHhfdGltZW91
dCgpIGZpeCBzdHlsZQo+Pj4gICAgdmlydGlvX25ldDogdmlydG5ldF90eF90aW1lb3V0KCkgc3Rv
cCByZWYgc3EtPnZxCj4+PiAgICB2aXJ0aW9fbmV0OiBzcGxpdCBmcmVlX3VudXNlZF9idWZzKCkK
Pj4+ICAgIHZpcnRpb19uZXQ6IHN1cHBvcnQgcGFpciBkaXNhYmxlL2VuYWJsZQo+Pj4KPj4+ICAg
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jICAgICAgICAgICAgICAgfCAyMjAgKysrKysrKysrKysr
KysrKysrKysrKy0tLQo+Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jICAg
ICB8ICA2MiArKysrLS0tCj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfY29tbW9uLmgg
ICAgIHwgIDExICstCj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbGVnYWN5LmMgICAg
IHwgICA1ICstCj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgICAgIHwg
MTIwICsrKysrKysrKysrKystCj4+PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJu
X2Rldi5jIHwgIDI4ICsrKysKPj4+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAg
ICAgICAgfCAxNDQgKysrKysrKysrKystLS0tLQo+Pj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5o
ICAgICAgICAgICAgICAgICB8ICAgMSArCj4+PiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oICAgICAgICAgIHwgIDc1ICsrKysrKysrLQo+Pj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpb19w
Y2lfbW9kZXJuLmggICAgICB8ICAgMiArCj4+PiAgIGluY2x1ZGUvbGludXgvdmlydGlvX3Jpbmcu
aCAgICAgICAgICAgIHwgIDQyICsrKy0tCj4+PiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9f
Y29uZmlnLmggICAgIHwgICA3ICstCj4+PiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNp
LmggICAgICAgIHwgICAyICsKPj4+ICAgMTMgZmlsZXMgY2hhbmdlZCwgNjE4IGluc2VydGlvbnMo
KyksIDEwMSBkZWxldGlvbnMoLSkKPj4+Cj4+PiAtLQo+Pj4gMi4zMS4wCj4+PgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
