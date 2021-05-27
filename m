Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62C8C47089
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 03:41:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718676124C
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 03:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718676124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E34F83A8E;
	Thu, 27 May 2021 03:41:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qvl8yudpBkLI; Thu, 27 May 2021 03:41:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D39083A84;
	Thu, 27 May 2021 03:41:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05CD7C000D;
	Thu, 27 May 2021 03:41:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 413B1C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 03:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0E62260733
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 03:41:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9k82bghmagjv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 03:41:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3D5406071E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 03:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622086903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owGdohWgeueCs/0bpmzG2a18Ycc1oYO2UMZ3CQnhszs=;
 b=NYhFaDqdEJ0aipbN8587UYD4XkOnVVbJ3N5la/U5RO7bH1E4NfEkYc+lGYcWjmnOXcnBsk
 b/R9xxwL4xsa+LVTwOHd4EDk4Mi5vlPANgREVZmfZ0zNmSFSLnSPfW0K9HMJT4jIy1u8CL
 ioTSNtmZvWW1YH5lXLWAZ8s0WfWe9Kg=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-WsW7G4M_Na6LErnShzu_CQ-1; Wed, 26 May 2021 23:41:41 -0400
X-MC-Unique: WsW7G4M_Na6LErnShzu_CQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 o1-20020a17090a4201b029015c8f11f550so1694380pjg.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 20:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=owGdohWgeueCs/0bpmzG2a18Ycc1oYO2UMZ3CQnhszs=;
 b=KiHqfJJ4lT9JEm8cWVx/1wxdUcbE20gp4VmLNpefpxR+zRKBBj0gTY3+VQHdFGa/v0
 cZsWyGdL8P4rYR8o21HlxIlkJZwu+qzIZ5bdObZ4z8fu9B9wUmsw1DJ88rC+nL9Sd69g
 /1XC5cggHsX/zzq2QbxvSMvMwTu7poe6h258zQ027LqgLD9wD6NLVAs8m+l36yhJUDf2
 TSOTOQZCg9jb3sHpco45Upt2DNXyErCogCHiEFjgL987xB/fb7dTnxMbcorD9SiXzdF2
 E3Cn80RuQowgUhyn/eQ1Rz9SHu0FwwDetCVEvq8+dlY5BArDojQXNuPbDkErl8y0XUHS
 4FIQ==
X-Gm-Message-State: AOAM532q9YBdEXvSurxg8rXpYceLUaKQmQ0nRvvUBjRhy+bY1SNjC++M
 aTNT7iwiHakh+JHAr7z1qGx0t0xHW0swxa2+w/1saP+4MBh+FSC7fqk6TIMxz9trJdu2STxPQBK
 olnGhdfzSLYiWGenZD3pzSQJwWYAGHLnmETFLL2aE5uTA/zkd9pagJJgiCxVm/nTLMGfenJbxPK
 6ENm4u1/7eQfyqAyYI1A==
X-Received: by 2002:a17:902:9004:b029:f0:b40d:38d with SMTP id
 a4-20020a1709029004b02900f0b40d038dmr1348726plp.85.1622086900168; 
 Wed, 26 May 2021 20:41:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlloFsLSTo3NBjczWn6jhZffi5xMtvZghbENGdeQMOi1/9v8B7I5OYeenQXdt7FxlJZADScQ==
X-Received: by 2002:a17:902:9004:b029:f0:b40d:38d with SMTP id
 a4-20020a1709029004b02900f0b40d038dmr1348697plp.85.1622086899770; 
 Wed, 26 May 2021 20:41:39 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id 15sm545681pjt.17.2021.05.26.20.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 20:41:39 -0700 (PDT)
Subject: Re: [PATCH v3 1/4] virtio_net: move tx vq operation under tx queue
 lock
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
References: <20210526082423.47837-1-mst@redhat.com>
 <20210526082423.47837-2-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <476e9418-156d-dbc9-5105-11d2816b95f7@redhat.com>
Date: Thu, 27 May 2021 11:41:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210526082423.47837-2-mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNS8yNiDPws7nNDoyNCwgTWljaGFlbCBTLiBUc2lya2luINC0tcA6Cj4gSXQncyB1
bnNhZmUgdG8gb3BlcmF0ZSBhIHZxIGZyb20gbXVsdGlwbGUgdGhyZWFkcy4KPiBVbmZvcnR1bmF0
ZWx5IHRoaXMgaXMgZXhhY3RseSB3aGF0IHdlIGRvIHdoZW4gaW52b2tpbmcKPiBjbGVhbiB0eCBw
b2xsIGZyb20gcnggbmFwaS4KPiBTYW1lIGhhcHBlbnMgd2l0aCBuYXBpLXR4IGV2ZW4gd2l0aG91
dCB0aGUKPiBvcHBvcnR1bmlzdGljIGNsZWFuaW5nIGZyb20gdGhlIHJlY2VpdmUgaW50ZXJydXB0
OiB0aGF0IHJhY2VzCj4gd2l0aCBwcm9jZXNzaW5nIHRoZSB2cSBpbiBzdGFydF94bWl0Lgo+Cj4g
QXMgYSBmaXggbW92ZSBldmVyeXRoaW5nIHRoYXQgZGVhbHMgd2l0aCB0aGUgdnEgdG8gdW5kZXIg
dHggbG9jay4KPgo+IEZpeGVzOiBiOTJmMWU2NzUxYTYgKCJ2aXJ0aW8tbmV0OiB0cmFuc21pdCBu
YXBpIikKPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
Pgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMjIgKysrKysrKysrKysrKysr
KysrKysrLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPiBpbmRleCBhYzBjMTQzZjk3YjQuLjEyNTEyZDEwMDJlYyAxMDA2NDQK
PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiBAQCAtMTUwOCw2ICsxNTA4LDggQEAgc3RhdGljIGludCB2aXJ0bmV0X3BvbGxf
dHgoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0KQo+ICAgCXN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpID0gc3EtPnZxLT52ZGV2LT5wcml2Owo+ICAgCXVuc2lnbmVkIGludCBpbmRl
eCA9IHZxMnR4cShzcS0+dnEpOwo+ICAgCXN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsKPiArCWlu
dCBvcGFxdWU7Cj4gKwlib29sIGRvbmU7Cj4gICAKPiAgIAlpZiAodW5saWtlbHkoaXNfeGRwX3Jh
d19idWZmZXJfcXVldWUodmksIGluZGV4KSkpIHsKPiAgIAkJLyogV2UgZG9uJ3QgbmVlZCB0byBl
bmFibGUgY2IgZm9yIFhEUCAqLwo+IEBAIC0xNTE3LDEwICsxNTE5LDI4IEBAIHN0YXRpYyBpbnQg
dmlydG5ldF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiAg
IAo+ICAgCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgaW5kZXgpOwo+ICAgCV9f
bmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpOwo+ICsJdmlydHF1ZXVl
X2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiAgIAlmcmVlX29sZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+
ICsKPiArCW9wYXF1ZSA9IHZpcnRxdWV1ZV9lbmFibGVfY2JfcHJlcGFyZShzcS0+dnEpOwo+ICsK
PiArCWRvbmUgPSBuYXBpX2NvbXBsZXRlX2RvbmUobmFwaSwgMCk7Cj4gKwo+ICsJaWYgKCFkb25l
KQo+ICsJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7Cj4gKwo+ICAgCV9fbmV0aWZfdHhf
dW5sb2NrKHR4cSk7Cj4gICAKPiAtCXZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlKG5hcGksIHNxLT52
cSwgMCk7Cj4gKwlpZiAoZG9uZSkgewo+ICsJCWlmICh1bmxpa2VseSh2aXJ0cXVldWVfcG9sbChz
cS0+dnEsIG9wYXF1ZSkpKSB7Cj4gKwkJCWlmIChuYXBpX3NjaGVkdWxlX3ByZXAobmFwaSkpIHsK
PiArCQkJCV9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpOwo+ICsJ
CQkJdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiArCQkJCV9fbmV0aWZfdHhfdW5sb2Nr
KHR4cSk7Cj4gKwkJCQlfX25hcGlfc2NoZWR1bGUobmFwaSk7Cj4gKwkJCX0KPiArCQl9Cj4gKwl9
CgoKSW50ZXJlc3RpbmcsIHRoaXMgbG9va3MgbGlrZSBzb21laHdvIGEgb3Blbi1jb2RlZCB2ZXJz
aW9uIG9mIAp2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZSgpLiBJIHdvbmRlciBpZiB3ZSBjYW4gc2lt
cGx5IGtlZXAgdXNpbmcgCnZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlKCkgYnkgc2ltcGx5IG1vdmlu
ZyB0aGUgX19uZXRpZl90eF91bmxvY2soKSBhZnRlciAKdGhhdDoKCm5ldGlmX3R4X2xvY2sodHhx
KTsKZnJlZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKdmlydHF1ZXVlX25hcGlfY29tcGxldGUo
bmFwaSwgc3EtPnZxLCAwKTsKX19uZXRpZl90eF91bmxvY2sodHhxKTsKClRoYW5rcwoKCj4gICAK
PiAgIAlpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyICsgTUFYX1NLQl9GUkFHUykKPiAgIAkJbmV0
aWZfdHhfd2FrZV9xdWV1ZSh0eHEpOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
