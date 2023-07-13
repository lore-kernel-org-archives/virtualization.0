Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD133EB64DD
	for <virtualization@archiver.kernel.org>; Thu, 13 Jul 2023 05:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 77933402F5;
	Thu, 13 Jul 2023 05:09:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77933402F5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQkf2d5h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uLXZ2JaaBMKX; Thu, 13 Jul 2023 05:09:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0556740166;
	Thu, 13 Jul 2023 05:09:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0556740166
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCA04C0072;
	Thu, 13 Jul 2023 05:09:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 752A5C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:09:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4CEE941DCF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:09:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CEE941DCF
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gQkf2d5h
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMXsdJeoGQkg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:09:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 178D54089D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 178D54089D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jul 2023 05:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689224940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8kNRJ+zYS2lROi4P6cQEoQQ/hyKnPVPTaZqyOcniZQA=;
 b=gQkf2d5hXHCS7ruvf1Yx95Khgjcj1IFn+baV7AXLMtL6RDIrW2pcGNquUdqvKVEL6LlyJ7
 BP0+WpCilJfMlBmuK4OW3MerePendVRhngUBAnTJWXinNnRG3xZRu7CxxfFi6j7xgUAz0w
 s+c+z9DLKiXJXY95y3Nf3SAL16wSQZo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-ABKxFKWNP2epVJaB0rfBqQ-1; Thu, 13 Jul 2023 01:08:59 -0400
X-MC-Unique: ABKxFKWNP2epVJaB0rfBqQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b69825cca2so8335721fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 22:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689224938; x=1691816938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8kNRJ+zYS2lROi4P6cQEoQQ/hyKnPVPTaZqyOcniZQA=;
 b=k3LTvFldo6shanb9Ow70y3d4hA6lI58iYVVImmHhZzRznQNZXsvMPii3DVNXMiGFbJ
 4OBN96AQJnXyzsVZVq02djSMv+zp88WAVI5asLjOkRFIMxLjZQktG1Kh1GNo9JO01b5b
 LTdYKod6tCrIq7fo5Z3kbKlYsINxDBU37ftgjejqOjVodcVpNDb27JqHlTFc/XJ+BTeY
 Iv7NABrxC4rB23PQM9ZR9SSoCSoCIGCLAbmaHahSiLpn1oRtSFv5+yi24+uMSMKTU/Pr
 3sn1ZQlD1cIlby+4aO1S7xeZMccC5OF9eqp1nmzVJohRrIb60Gp3FeQBbMHRNPtjU2kc
 QA8A==
X-Gm-Message-State: ABy/qLYsvLzyGw8FnfVbq/BY0RWHr59AZRZ3siGOk4Fs7gInTb+pWFPm
 kOITUsgtNzlJLkgBdTQYQ2TZvR7KA0xriYLsIlEzxFOEl01E8Sj0aw7zkdFK5i1Zzo/f+uJg6Oz
 g1hxPvnMp296PvroqIeZdkYRCndiKxl0tNmT1a4ww2TgIkMBrOYIK8Lby9Q==
X-Received: by 2002:a2e:a369:0:b0:2b6:e73c:67ea with SMTP id
 i9-20020a2ea369000000b002b6e73c67eamr1501206ljn.17.1689224937990; 
 Wed, 12 Jul 2023 22:08:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGR5K26HpVvtrIofuGEY0Xvuu/Vym0st4XIV8w4e2l9Nmms7f9AaKoPEsyxxyx+QzhGhx+HX1njIyYIMffieRM=
X-Received: by 2002:a2e:a369:0:b0:2b6:e73c:67ea with SMTP id
 i9-20020a2ea369000000b002b6e73c67eamr1501198ljn.17.1689224937717; Wed, 12 Jul
 2023 22:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230711042437.69381-1-shannon.nelson@amd.com>
 <20230711042437.69381-4-shannon.nelson@amd.com>
In-Reply-To: <20230711042437.69381-4-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Jul 2023 13:08:46 +0800
Message-ID: <CACGkMEvhYViMrj1ctZ9EWj0bbPKUQw68tm85-qidQZR4TLP=vw@mail.gmail.com>
Subject: Re: [PATCH v2 virtio 3/5] pds_vdpa: clean and reset vqs entries
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev@vger.kernel.org, drivers@pensando.io,
 virtualization@lists.linux-foundation.org, brett.creeley@amd.com,
 mst@redhat.com
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

T24gVHVlLCBKdWwgMTEsIDIwMjMgYXQgMTI6MjXigK9QTSBTaGFubm9uIE5lbHNvbiA8c2hhbm5v
bi5uZWxzb25AYW1kLmNvbT4gd3JvdGU6Cj4KPiBNYWtlIHN1cmUgdGhhdCB3ZSBpbml0aWFsaXpl
IHRoZSB2cXNbXSBlbnRyaWVzIHRoZSBzYW1lCj4gd2F5IGJvdGggZm9yIGluaXRpYWwgc2V0dXAg
YW5kIGFmdGVyIGEgdnEgcmVzZXQuCj4KPiBGaXhlczogMTUxY2M4MzRmM2RkICgicGRzX3ZkcGE6
IGFkZCBzdXBwb3J0IGZvciB2ZHBhIGFuZCB2ZHBhbWdtdCBpbnRlcmZhY2VzIikKPiBTaWduZWQt
b2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KCkFja2VkLWJ5
OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IC0tLQo+ICBkcml2
ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgfCAyNCArKysrKysrKysrKysrKysrKy0tLS0tLS0KPiAg
MSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jIGIvZHJpdmVycy92ZHBhL3Bkcy92
ZHBhX2Rldi5jCj4gaW5kZXggNWI1NjZlMGVlZjBhLi4wNGEzNjI2NDhiMDIgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3Bkcy92
ZHBhX2Rldi5jCj4gQEAgLTQyOCw2ICs0MjgsMTcgQEAgc3RhdGljIHZvaWQgcGRzX3ZkcGFfc2V0
X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LCB1OCBzdGF0dXMpCj4gICAgICAg
ICB9Cj4gIH0KPgo+ICtzdGF0aWMgdm9pZCBwZHNfdmRwYV9pbml0X3Zxc19lbnRyeShzdHJ1Y3Qg
cGRzX3ZkcGFfZGV2aWNlICpwZHN2LCBpbnQgcWlkLAo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHZvaWQgX19pb21lbSAqbm90aWZ5KQo+ICt7Cj4gKyAgICAgICBtZW1zZXQo
JnBkc3YtPnZxc1txaWRdLCAwLCBzaXplb2YocGRzdi0+dnFzWzBdKSk7Cj4gKyAgICAgICBwZHN2
LT52cXNbcWlkXS5xaWQgPSBxaWQ7Cj4gKyAgICAgICBwZHN2LT52cXNbcWlkXS5wZHN2ID0gcGRz
djsKPiArICAgICAgIHBkc3YtPnZxc1txaWRdLnJlYWR5ID0gZmFsc2U7Cj4gKyAgICAgICBwZHN2
LT52cXNbcWlkXS5pcnEgPSBWSVJUSU9fTVNJX05PX1ZFQ1RPUjsKPiArICAgICAgIHBkc3YtPnZx
c1txaWRdLm5vdGlmeSA9IG5vdGlmeTsKPiArfQo+ICsKPiAgc3RhdGljIGludCBwZHNfdmRwYV9y
ZXNldChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+ICB7Cj4gICAgICAgICBzdHJ1Y3Qg
cGRzX3ZkcGFfZGV2aWNlICpwZHN2ID0gdmRwYV90b19wZHN2KHZkcGFfZGV2KTsKPiBAQCAtNDUw
LDggKzQ2MSw3IEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfcmVzZXQoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZHBhX2RldikKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2
LCAiJXM6IHJlc2V0X3ZxIGZhaWxlZCBxaWQgJWQ6ICVwZVxuIiwKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIGksIEVSUl9QVFIoZXJyKSk7Cj4gICAg
ICAgICAgICAgICAgICAgICAgICAgcGRzX3ZkcGFfcmVsZWFzZV9pcnEocGRzdiwgaSk7Cj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgbWVtc2V0KCZwZHN2LT52cXNbaV0sIDAsIHNpemVvZihwZHN2
LT52cXNbMF0pKTsKPiAtICAgICAgICAgICAgICAgICAgICAgICBwZHN2LT52cXNbaV0ucmVhZHkg
PSBmYWxzZTsKPiArICAgICAgICAgICAgICAgICAgICAgICBwZHNfdmRwYV9pbml0X3Zxc19lbnRy
eShwZHN2LCBpLCBwZHN2LT52cXNbaV0ubm90aWZ5KTsKPiAgICAgICAgICAgICAgICAgfQo+ICAg
ICAgICAgfQo+Cj4gQEAgLTY0MCwxMSArNjUwLDExIEBAIHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2
X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPiAgICAg
ICAgIHBkc192ZHBhX2NtZF9zZXRfbWFjKHBkc3YsIHBkc3YtPm1hYyk7Cj4KPiAgICAgICAgIGZv
ciAoaSA9IDA7IGkgPCBwZHN2LT5udW1fdnFzOyBpKyspIHsKPiAtICAgICAgICAgICAgICAgcGRz
di0+dnFzW2ldLnFpZCA9IGk7Cj4gLSAgICAgICAgICAgICAgIHBkc3YtPnZxc1tpXS5wZHN2ID0g
cGRzdjsKPiAtICAgICAgICAgICAgICAgcGRzdi0+dnFzW2ldLmlycSA9IFZJUlRJT19NU0lfTk9f
VkVDVE9SOwo+IC0gICAgICAgICAgICAgICBwZHN2LT52cXNbaV0ubm90aWZ5ID0gdnBfbW9kZXJu
X21hcF92cV9ub3RpZnkoJnBkc3YtPnZkcGFfYXV4LT52ZF9tZGV2LAo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSwgJnBkc3Yt
PnZxc1tpXS5ub3RpZnlfcGEpOwo+ICsgICAgICAgICAgICAgICB2b2lkIF9faW9tZW0gKm5vdGlm
eTsKPiArCj4gKyAgICAgICAgICAgICAgIG5vdGlmeSA9IHZwX21vZGVybl9tYXBfdnFfbm90aWZ5
KCZwZHN2LT52ZHBhX2F1eC0+dmRfbWRldiwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaSwgJnBkc3YtPnZxc1tpXS5ub3RpZnlfcGEpOwo+ICsgICAg
ICAgICAgICAgICBwZHNfdmRwYV9pbml0X3Zxc19lbnRyeShwZHN2LCBpLCBub3RpZnkpOwo+ICAg
ICAgICAgfQo+Cj4gICAgICAgICBwZHN2LT52ZHBhX2Rldi5tZGV2ID0gJnZkcGFfYXV4LT52ZHBh
X21kZXY7Cj4gLS0KPiAyLjE3LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
