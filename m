Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6EAC433EF
	for <virtualization@archiver.kernel.org>; Wed, 23 Feb 2022 03:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 055DF40608;
	Wed, 23 Feb 2022 03:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uGmbftMLqHuJ; Wed, 23 Feb 2022 03:03:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7F78340105;
	Wed, 23 Feb 2022 03:03:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65722C001A;
	Wed, 23 Feb 2022 03:03:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8301C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D59C68194A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H3q06RcChNDq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:02:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC95F8188B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 03:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645585377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+0q+jh2qKTCIyved+I1gUvhKjGilFgjtPdZLjrNhn8=;
 b=engBO7KclTCrShAXZ1/8Q13R+3hHFcEgVNXq17cdGj9hVRJteZAQQONHpBdJ15uD2cVszh
 Fcs3tVJH83wNbTT5tGHsGx8xxF5FfNQPb1DH8ubDyopx/ZkwtLGw2gspaJIs0fxv0Hwnpj
 cU0kAlcX31tjgkAmD8LAbkueQENWzxE=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-YWdsE227NGaxb6P_2fK-xg-1; Tue, 22 Feb 2022 22:02:56 -0500
X-MC-Unique: YWdsE227NGaxb6P_2fK-xg-1
Received: by mail-lf1-f71.google.com with SMTP id
 a5-20020ac25205000000b00443a34a9472so3008203lfl.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 19:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/+0q+jh2qKTCIyved+I1gUvhKjGilFgjtPdZLjrNhn8=;
 b=HYCRU1ds8MSS7mz2SFuRA8i+BHiVnEenSayTJF5abAcLh8cFFJpPHM7mB/D9OYoML+
 N3P4QXovdfxH7dcLlyJRLPvLJaO8Xs9GQHbfC/sWBLELuLnF9h5az4xZRDzGXU1Eta8b
 3yT23AcgCXbdD/LaPdwTKdUj7e7l/gywckRYHbX1Oto+ljdeA8MhhfyniSOLKrUwkcAM
 1Uphieb03h9wEUdQOO9J0CIJEOa9DWO+Uson0xzLOeCJZuDrltUBxseS+iUn9Fm+DYo5
 uGmmLOrdYbvRH5xCnc7wc+h95fqaaE4PLKBd7obDmJcdUmsPsDVMu05/wtxOWiV+OimP
 opKw==
X-Gm-Message-State: AOAM530rwyNX47f7Vc3oJr84B83CF02PoRMKas1s3m0YS3GTenf7EtGb
 5j+Bx8RiAuCbev6EImNSR+qouOnoKLDx12FZd9V2uwPDMHeqVRBtQbAD6PubF5Xn5SmjJQy7r35
 gTbtbzaz6Ez+cdhUsDaV54tZmwwiGP8GN7WcqAMSiuKjtnV8Nhl7fGqftkg==
X-Received: by 2002:ac2:508a:0:b0:443:169a:b27 with SMTP id
 f10-20020ac2508a000000b00443169a0b27mr19037762lfm.257.1645585375084; 
 Tue, 22 Feb 2022 19:02:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRRdVmjrWqJd1F7tGFt3NngvS9vSUjo0xKljsiPL6/Il8rMl94p7NnmHSXo+aoQcUwo6XJuNL+rHMfCcV0FZw=
X-Received: by 2002:ac2:508a:0:b0:443:169a:b27 with SMTP id
 f10-20020ac2508a000000b00443169a0b27mr19037755lfm.257.1645585374866; Tue, 22
 Feb 2022 19:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20220210085124.15466-1-xuanzhuo@linux.alibaba.com>
 <20220210085124.15466-5-xuanzhuo@linux.alibaba.com>
 <8415ceb8-310f-f6be-9de9-2742810f2a21@redhat.com>
In-Reply-To: <8415ceb8-310f-f6be-9de9-2742810f2a21@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 23 Feb 2022 11:02:43 +0800
Message-ID: <CACGkMEtKVE2NdWiu=2+LjMkm8TZiAHYu9kRsdXD+v3k6i20J2A@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] virtio: virtqueue_add() support predma
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 virtualization <virtualization@lists.linux-foundation.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

T24gV2VkLCBGZWIgMjMsIDIwMjIgYXQgMTE6MDEgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4KPgo+IOWcqCAyMDIyLzIvMTAg5LiL5Y2INDo1MSwgWHVhbiBaaHVv
IOWGmemBkzoKPiA+IHZpcnR1cXVlX2FkZCgpIGFkZHMgcGFyYW1ldGVyIHByZWRtYS4KPiA+Cj4g
PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+
ID4gLS0tCj4gPiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxMSArKysrKystLS0t
LQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQo+
ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXggY2ZiMDI4Y2EyMzhlLi5jZjlkMTE4NjY4
ZjEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysg
Yi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBAQCAtMTc4MCw3ICsxNzgwLDggQEAg
c3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgaW5fc2dzLAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqZGF0YSwKPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHZvaWQgKmN0eCwKPiA+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGdmcF90IGdmcCkKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdmcF90
IGdmcCwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJvb2wgcHJlZG1hKQo+Cj4K
PiBzZyBpcyBhc3N1bWVkIHRvIHVzZSBkbWEgYWRkcmVzcywgc28gSSB3b25kZXIgd2hldGhlciAi
c2dfaXNfcGh5cyIgaXMgYQo+IGJldHRlciBuYW1lPwoKU3BlYWsgdG9vIGZhc3QsIEkgd2FzIHdy
b25nIGhlcmUsIEkgdGhpbmsgd2Ugc2hvdWxkIGJlIGNvbnNpc3RlbnQKaGVyZSwgc28gInByZW1h
cHBlZCIgc2hvdWxkIGJlIGJldHRlci4KClRoYW5rcwoKPgo+IFRoYW5rcwo+Cj4KPiA+ICAgewo+
ID4gICAgICAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+Cj4g
PiBAQCAtMTgyMSw3ICsxODIyLDcgQEAgaW50IHZpcnRxdWV1ZV9hZGRfc2dzKHN0cnVjdCB2aXJ0
cXVldWUgKl92cSwKPiA+ICAgICAgICAgICAgICAgICAgICAgICB0b3RhbF9zZysrOwo+ID4gICAg
ICAgfQo+ID4gICAgICAgcmV0dXJuIHZpcnRxdWV1ZV9hZGQoX3ZxLCBzZ3MsIHRvdGFsX3NnLCBv
dXRfc2dzLCBpbl9zZ3MsCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICBkYXRhLCBOVUxM
LCBnZnApOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgZGF0YSwgTlVMTCwgZ2ZwLCBm
YWxzZSk7Cj4gPiAgIH0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2FkZF9zZ3Mp
Owo+ID4KPiA+IEBAIC0xODQzLDcgKzE4NDQsNyBAQCBpbnQgdmlydHF1ZXVlX2FkZF9vdXRidWYo
c3RydWN0IHZpcnRxdWV1ZSAqdnEsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRh
dGEsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIGdmcF90IGdmcCkKPiA+ICAgewo+ID4gLSAg
ICAgcmV0dXJuIHZpcnRxdWV1ZV9hZGQodnEsICZzZywgbnVtLCAxLCAwLCBkYXRhLCBOVUxMLCBn
ZnApOwo+ID4gKyAgICAgcmV0dXJuIHZpcnRxdWV1ZV9hZGQodnEsICZzZywgbnVtLCAxLCAwLCBk
YXRhLCBOVUxMLCBnZnAsIGZhbHNlKTsKPiA+ICAgfQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQTCh2
aXJ0cXVldWVfYWRkX291dGJ1Zik7Cj4gPgo+ID4gQEAgLTE4NjUsNyArMTg2Niw3IEBAIGludCB2
aXJ0cXVldWVfYWRkX2luYnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgIHZvaWQgKmRhdGEsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgZ2ZwX3QgZ2Zw
KQo+ID4gICB7Cj4gPiAtICAgICByZXR1cm4gdmlydHF1ZXVlX2FkZCh2cSwgJnNnLCBudW0sIDAs
IDEsIGRhdGEsIE5VTEwsIGdmcCk7Cj4gPiArICAgICByZXR1cm4gdmlydHF1ZXVlX2FkZCh2cSwg
JnNnLCBudW0sIDAsIDEsIGRhdGEsIE5VTEwsIGdmcCwgZmFsc2UpOwo+ID4gICB9Cj4gPiAgIEVY
UE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9hZGRfaW5idWYpOwo+ID4KPiA+IEBAIC0xODg5LDcg
KzE4OTAsNyBAQCBpbnQgdmlydHF1ZXVlX2FkZF9pbmJ1Zl9jdHgoc3RydWN0IHZpcnRxdWV1ZSAq
dnEsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqY3R4LAo+ID4gICAgICAgICAgICAg
ICAgICAgICAgIGdmcF90IGdmcCkKPiA+ICAgewo+ID4gLSAgICAgcmV0dXJuIHZpcnRxdWV1ZV9h
ZGQodnEsICZzZywgbnVtLCAwLCAxLCBkYXRhLCBjdHgsIGdmcCk7Cj4gPiArICAgICByZXR1cm4g
dmlydHF1ZXVlX2FkZCh2cSwgJnNnLCBudW0sIDAsIDEsIGRhdGEsIGN0eCwgZ2ZwLCBmYWxzZSk7
Cj4gPiAgIH0KPiA+ICAgRVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX2FkZF9pbmJ1Zl9jdHgp
Owo+ID4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
