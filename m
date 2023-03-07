Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C176BC6FD1A
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 06:44:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FCAD416DE;
	Tue,  7 Mar 2023 06:44:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5FCAD416DE
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iUFQsDYs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rtQsOoDbp1oK; Tue,  7 Mar 2023 06:44:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 897A2416DC;
	Tue,  7 Mar 2023 06:44:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 897A2416DC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D421C0035;
	Tue,  7 Mar 2023 06:44:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ABBBC0035
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 541CB4042B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 541CB4042B
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iUFQsDYs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 60Vi4hzfkWUk
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 958C74036A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 958C74036A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 06:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678171451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WlfUw9GqupxWS84QvutTxtsgLb5HaYbRvTSVU/DUyHY=;
 b=iUFQsDYsblfYu1hZsLbnXpul/bXTKxZh99bLwHgXi2SY4r+q0n2UdmzApH//tJrFlVqw14
 1wlqUpsLu//F/NxOKFScDlP+oFrMsQeUWfQYkKcH551BJzh1ZA5D2aWbEJ/TRvKOJvX0Yg
 1DL+HE+wH+OA9dR+xO6zdkvKoa0R4ZM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-t5Ikrku5PXWq8qxCzoJYDA-1; Tue, 07 Mar 2023 01:44:10 -0500
X-MC-Unique: t5Ikrku5PXWq8qxCzoJYDA-1
Received: by mail-oi1-f198.google.com with SMTP id
 i2-20020a056808054200b0037fa81b753bso4996895oig.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Mar 2023 22:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678171450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WlfUw9GqupxWS84QvutTxtsgLb5HaYbRvTSVU/DUyHY=;
 b=JhnNqQcqf1qhiWSY1P9mOR7rwVAR02TZGemJvv/TcqRuVnYkZKtrAzjX3HN60tE1Yn
 kbVwatVtJHbSozqntj07vbJ83ZKdq7A8UsUf2JEzWDxtOoKv5Eac5Zywnle80CMlC7jz
 VIIrGAb8zwPwc+DMyHPESZK6SUSmp31XDj6ACmjbYbir7H4o/aqUz9GV7fUsnedLc0Br
 qlhllqPA3cnZH69xsqUSBQ1qMaQnnXh3urbXPPpmLZAKcvoUNlGQYzBb+OJHm9P/uhZI
 kLAdlRPfqdP5TAKd4GpcjAdGN5divBgByafDQndHkF6aIruUFXxgRuNr1le2rCqAUPS7
 46Sg==
X-Gm-Message-State: AO0yUKUhypxEKSNsvwYtWe05isxeiZJxVgR2gL9zuZwZXfK1HM42+mi9
 TqKlGNXLT4igTI137/GD/Jfy1hAKggmzIpk07DLYpK1v7vpS7rZJ5JtkLmoL5QBpj1z/G2Cuf1P
 yRYSPRwxm6RJD/ma//yH/FDrwqL0gQsmZIU7BjHeODL2RENZrO21sPbvhpA==
X-Received: by 2002:a54:4102:0:b0:37f:ab56:ff42 with SMTP id
 l2-20020a544102000000b0037fab56ff42mr4438279oic.9.1678171449855; 
 Mon, 06 Mar 2023 22:44:09 -0800 (PST)
X-Google-Smtp-Source: AK7set9R75HMH00sdXQFZk+b6frfhZPMTEsMZEzFwiAQTNoawbhJQ7Z3maev1l1gnyPgLmoa1Chbq5EYmkMt6sUtiWQ=
X-Received: by 2002:a54:4102:0:b0:37f:ab56:ff42 with SMTP id
 l2-20020a544102000000b0037fab56ff42mr4438277oic.9.1678171449652; Mon, 06 Mar
 2023 22:44:09 -0800 (PST)
MIME-Version: 1.0
References: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
 <20230302115908.1461-12-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230302115908.1461-12-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 7 Mar 2023 14:43:58 +0800
Message-ID: <CACGkMEsbmN6Tnsz3kAOraY1=QVNvids91RW3EDwWAP=N7jEAng@mail.gmail.com>
Subject: Re: [PATCH vhost v1 11/12] virtio_ring: separate the logic of
 reset/enable from virtqueue_resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

T24gVGh1LCBNYXIgMiwgMjAyMyBhdCA3OjU54oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBUaGUgc3Vic2VxdWVudCByZXNldCBmdW5jdGlvbiB3
aWxsIHJldXNlIHRoZXNlIGxvZ2ljLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFu
emh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYyB8IDU4ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19y
aW5nLmMKPiBpbmRleCA1MDBjYjg1NjNmMmIuLjVhYjkxMzZhMzYzZSAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYwo+IEBAIC0yMjE1LDYgKzIyMTUsNDMgQEAgc3RhdGljIGludCB2aXJ0cXVldWVfcmVz
aXplX3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0pCj4gICAgICAgICByZXR1
cm4gLUVOT01FTTsKPiAgfQo+Cj4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX2Rpc2FibGVfYW5kX3Jl
Y3ljbGUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdm9pZCAoKnJlY3ljbGUpKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lk
ICpidWYpKQo+ICt7Cj4gKyAgICAgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2
cShfdnEpOwo+ICsgICAgICAgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYgPSB2cS0+dnEudmRl
djsKPiArICAgICAgIHZvaWQgKmJ1ZjsKPiArICAgICAgIGludCBlcnI7Cj4gKwo+ICsgICAgICAg
aWYgKCF2cS0+d2Vfb3duX3JpbmcpCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRVBFUk07Cj4g
Kwo+ICsgICAgICAgaWYgKCF2ZGV2LT5jb25maWctPmRpc2FibGVfdnFfYW5kX3Jlc2V0KQo+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsKPiArCj4gKyAgICAgICBpZiAoIXZkZXYtPmNv
bmZpZy0+ZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0KQo+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVO
T0VOVDsKPiArCj4gKyAgICAgICBlcnIgPSB2ZGV2LT5jb25maWctPmRpc2FibGVfdnFfYW5kX3Jl
c2V0KF92cSk7Cj4gKyAgICAgICBpZiAoZXJyKQo+ICsgICAgICAgICAgICAgICByZXR1cm4gZXJy
Owo+ICsKPiArICAgICAgIHdoaWxlICgoYnVmID0gdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVm
KF92cSkpICE9IE5VTEwpCj4gKyAgICAgICAgICAgICAgIHJlY3ljbGUoX3ZxLCBidWYpOwo+ICsK
PiArICAgICAgIHJldHVybiAwOwo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9lbmFi
bGVfYWZ0ZXJfcmVzZXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICt7Cj4gKyAgICAgICBzdHJ1
Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ICsgICAgICAgc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYgPSB2cS0+dnEudmRldjsKPiArCj4gKyAgICAgICBpZiAodmRldi0+
Y29uZmlnLT5lbmFibGVfdnFfYWZ0ZXJfcmVzZXQoX3ZxKSkKPiArICAgICAgICAgICAgICAgcmV0
dXJuIC1FQlVTWTsKPiArCj4gKyAgICAgICByZXR1cm4gMDsKPiArfQo+Cj4gIC8qCj4gICAqIEdl
bmVyaWMgZnVuY3Rpb25zIGFuZCBleHBvcnRlZCBzeW1ib2xzLgo+IEBAIC0yODM2LDEzICsyODcz
LDggQEAgaW50IHZpcnRxdWV1ZV9yZXNpemUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVt
LAo+ICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSwgdm9pZCAqYnVmKSkKPiAgewo+ICAgICAgICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAq
dnEgPSB0b192dnEoX3ZxKTsKPiAtICAgICAgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2ID0g
dnEtPnZxLnZkZXY7Cj4gLSAgICAgICB2b2lkICpidWY7Cj4gICAgICAgICBpbnQgZXJyOwo+Cj4g
LSAgICAgICBpZiAoIXZxLT53ZV9vd25fcmluZykKPiAtICAgICAgICAgICAgICAgcmV0dXJuIC1F
UEVSTTsKCkFueSByZWFzb24gdG8gbW92ZSB0aGlzIGJ1dCBrZWVwIHRoZSBudW1fbWF4IGNoZWNr
PwoKPiAtCj4gICAgICAgICBpZiAobnVtID4gdnEtPnZxLm51bV9tYXgpCj4gICAgICAgICAgICAg
ICAgIHJldHVybiAtRTJCSUc7Cj4KPiBAQCAtMjg1MiwyOCArMjg4NCwxNiBAQCBpbnQgdmlydHF1
ZXVlX3Jlc2l6ZShzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsIHUzMiBudW0sCj4gICAgICAgICBpZiAo
KHZxLT5wYWNrZWRfcmluZyA/IHZxLT5wYWNrZWQudnJpbmcubnVtIDogdnEtPnNwbGl0LnZyaW5n
Lm51bSkgPT0gbnVtKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMDsKPgo+IC0gICAgICAgaWYg
KCF2ZGV2LT5jb25maWctPmRpc2FibGVfdnFfYW5kX3Jlc2V0KQo+IC0gICAgICAgICAgICAgICBy
ZXR1cm4gLUVOT0VOVDsKPiAtCj4gLSAgICAgICBpZiAoIXZkZXYtPmNvbmZpZy0+ZW5hYmxlX3Zx
X2FmdGVyX3Jlc2V0KQo+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsKPiAtCj4gLSAg
ICAgICBlcnIgPSB2ZGV2LT5jb25maWctPmRpc2FibGVfdnFfYW5kX3Jlc2V0KF92cSk7Cj4gKyAg
ICAgICBlcnIgPSB2aXJ0cXVldWVfZGlzYWJsZV9hbmRfcmVjeWNsZShfdnEsIHJlY3ljbGUpOwo+
ICAgICAgICAgaWYgKGVycikKPiAgICAgICAgICAgICAgICAgcmV0dXJuIGVycjsKPgo+IC0gICAg
ICAgd2hpbGUgKChidWYgPSB2aXJ0cXVldWVfZGV0YWNoX3VudXNlZF9idWYoX3ZxKSkgIT0gTlVM
TCkKPiAtICAgICAgICAgICAgICAgcmVjeWNsZShfdnEsIGJ1Zik7CgpJIHdvbmRlciBpZiBpdCBt
YWtlcyBzZW5zZSB0byBmYWN0b3Igb3V0IHJlY3ljbGUoKSB0byBiZSB1c2VkIGJ5IG90aGVyCmZh
Y2lsaXRpZXMgaW4gdGhlIGZ1dHVyZT8KClRoYW5rcwoKCj4gLQo+ICAgICAgICAgaWYgKHZxLT5w
YWNrZWRfcmluZykKPiAgICAgICAgICAgICAgICAgZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZV9wYWNr
ZWQoX3ZxLCBudW0pOwo+ICAgICAgICAgZWxzZQo+ICAgICAgICAgICAgICAgICBlcnIgPSB2aXJ0
cXVldWVfcmVzaXplX3NwbGl0KF92cSwgbnVtKTsKPgo+IC0gICAgICAgaWYgKHZkZXYtPmNvbmZp
Zy0+ZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0KF92cSkpCj4gLSAgICAgICAgICAgICAgIHJldHVybiAt
RUJVU1k7Cj4gLQo+IC0gICAgICAgcmV0dXJuIGVycjsKPiArICAgICAgIHJldHVybiB2aXJ0cXVl
dWVfZW5hYmxlX2FmdGVyX3Jlc2V0KF92cSk7Cj4gIH0KPiAgRVhQT1JUX1NZTUJPTF9HUEwodmly
dHF1ZXVlX3Jlc2l6ZSk7Cj4KPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
