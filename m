Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730C6C74A5B
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 03:16:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E14064064C;
	Fri, 17 Mar 2023 03:16:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E14064064C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfVYcT5A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xFyt9VG4XOCu; Fri, 17 Mar 2023 03:16:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 732A740168;
	Fri, 17 Mar 2023 03:16:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 732A740168
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B377C0035;
	Fri, 17 Mar 2023 03:16:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C0A4C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:16:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 72FC460FB6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 72FC460FB6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfVYcT5A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jrVGRk60o2DT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:16:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B06326104D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B06326104D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679022989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyXyPraOfpu6YyrqIEJxbPcG2JsIkoncm8Yly449Jxk=;
 b=LfVYcT5A9K/673oxjaGikZRGtvtY4kXUBduOaddntBqybP157F57+1JOTFIcrTgKapbKs9
 JBTZdoWjh0b+R9D9Y0iZ39XRK0a7ZNd3uPmyAS9rSKzREDLkFb7VoNjjAJy5yaO4mtCtiL
 sv2ZPcvZJEBdlZOjDmmI/WIdnU9B/iY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-29AWe6M6NQyTMXZtXpx7hA-1; Thu, 16 Mar 2023 23:16:28 -0400
X-MC-Unique: 29AWe6M6NQyTMXZtXpx7hA-1
Received: by mail-ot1-f71.google.com with SMTP id
 r23-20020a05683001d700b0068bc6c8621eso1658469ota.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679022987;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyXyPraOfpu6YyrqIEJxbPcG2JsIkoncm8Yly449Jxk=;
 b=VupH2f1KFnk9fqAkjLMLbx7C4EGraoPHICcGP1fv82Dgqr/qdUQ9K7v41ewOqE41RV
 h8EUEpyHQZyXBYbqA0DW3NUv+5Z9iisEf3dwqOQ4LrAzYN1usWP9UrtESv7QADVKMwfG
 Vsyzr/8tcQ9xM1Ni8Gpgb0hfp69skxJRjGCqxeH5zFnq4aiP1qSZ+lEEG2Ox8kGZCMhz
 nXRqZGLaz0SuSeyvAADJmgLSeeDoBMyZhCDOEBgYYj79U01zo8qi+2gacE/y9yw+dEZO
 fVev+zn4NxUw0KirmAk79Rmu3YvX942+oXTtxaj296oaV6+ZitAH5AcEqgYVu/UAcPwf
 iClg==
X-Gm-Message-State: AO0yUKUF7RXcMPA4HlPsU/BtJLXm2MvYJkIv7v2kmKE4jiTH062VcKjw
 lRGGIUPi3aBIImJDGoTTK80ba/I4NXne30eSkjqvbis/N43396vZPm21qWXJfgnJ8wcbSpUvX+3
 eJSXwNFErudSt8lqkZSK6MzhzwaZNX+w6CqE1SxQBawowd7l6HMVjmQUgUA==
X-Received: by 2002:a05:6808:5c3:b0:386:9bb5:a786 with SMTP id
 d3-20020a05680805c300b003869bb5a786mr2385087oij.9.1679022987308; 
 Thu, 16 Mar 2023 20:16:27 -0700 (PDT)
X-Google-Smtp-Source: AK7set9A5ACOZgAsg+wAyKUpMu/4KjlUxB0yBHiwoTsCGNCO+RKxq/GXT572ZkUHju2y6DsqM4aKUfNEdcxlWdXku/U=
X-Received: by 2002:a05:6808:5c3:b0:386:9bb5:a786 with SMTP id
 d3-20020a05680805c300b003869bb5a786mr2385077oij.9.1679022987084; Thu, 16 Mar
 2023 20:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230315185458.11638-1-feliu@nvidia.com>
 <20230315185458.11638-2-feliu@nvidia.com>
In-Reply-To: <20230315185458.11638-2-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Mar 2023 11:16:16 +0800
Message-ID: <CACGkMEvPtS9pGqkxr6=UJj7myQZw8A2qMdV2CnPtksDESvn5Gg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] virtio_ring: Allow non power of 2 sizes for packed
 virtqueue
To: Feng Liu <feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

T24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgMjo1NeKAr0FNIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEu
Y29tPiB3cm90ZToKPgo+IEFjY29yZGluZyB0byB0aGUgVmlydGlvIFNwZWNpZmljYXRpb24sIHRo
ZSBRdWV1ZSBTaXplIHBhcmFtZXRlciBvZiBhCj4gdmlydHF1ZXVlIGNvcnJlc3BvbmRzIHRvIHRo
ZSBtYXhpbXVtIG51bWJlciBvZiBkZXNjcmlwdG9ycyBpbiB0aGF0Cj4gcXVldWUsIGFuZCBpdCBk
b2VzIG5vdCBoYXZlIHRvIGJlIGEgcG93ZXIgb2YgMiBmb3IgcGFja2VkIHZpcnRxdWV1ZXMuCj4g
SG93ZXZlciwgdGhlIHZpcnRpb19wY2lfbW9kZXJuIGRyaXZlciBlbmZvcmNlZCBhIHBvd2VyIG9m
IDIgY2hlY2sgZm9yCj4gdmlydHF1ZXVlIHNpemVzLCB3aGljaCBpcyB1bm5lY2Vzc2FyeSBhbmQg
cmVzdHJpY3RpdmUgZm9yIHBhY2tlZAo+IHZpcnR1cXVldWUuCj4KPiBTcGxpdCB2aXJ0cXVldWUg
c3RpbGwgbmVlZHMgdG8gY2hlY2sgdGhlIHZpcnRxdWV1ZSBzaXplIGlzIHBvd2VyX29mXzIKPiB3
aGljaCBoYXMgYmVlbiBkb25lIGluIHZyaW5nX2FsbG9jX3F1ZXVlX3NwbGl0IG9mIHRoZSB2aXJ0
aW9fcmluZyBsYXllci4KPgo+IFRvIHZhbGlkYXRlIHRoaXMgY2hhbmdlLCB3ZSB0ZXN0ZWQgdmFy
aW91cyB2aXJ0cXVldWUgc2l6ZXMgZm9yIHBhY2tlZAo+IHJpbmdzLCBpbmNsdWRpbmcgMTI4LCAy
NTYsIDUxMiwgMTAwLCAyMDAsIDUwMCwgYW5kIDEwMDAsIHdpdGgKPiBDT05GSUdfUEFHRV9QT0lT
T05JTkcgZW5hYmxlZCwgYW5kIGFsbCB0ZXN0cyBwYXNzZWQgc3VjY2Vzc2Z1bGx5Lgo+Cj4gU2ln
bmVkLW9mZi1ieTogRmVuZyBMaXUgPGZlbGl1QG52aWRpYS5jb20+Cj4gUmV2aWV3ZWQtYnk6IEpp
cmkgUGlya28gPGppcmlAbnZpZGlhLmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+Cj4gLS0tCj4gdjAgLT4gdjEKPiBmZWVkYmFja3MgZnJv
bSBKYXNvbiBXYW5nIGFuZCBNaWNoYWVsIFMuIFRzaXJraW4KPiAtIHJlbW92ZSBwb3dlcl9vZl8y
IGNoZWNrIG9mIHZpcnRxdWV1ZSBzaXplCj4KPiB2MSAtPiB2Mgo+IGZlZWRiYWNrcyBmcm9tIFBh
cmF2IFBhbmRpdCBhbmQgSmlyaSBQaXJrbwo+IC0ga2VlcCBwb3dlcl9vZl8yIGNoZWNrIG9mIHNw
bGl0IHZpcnRxdWV1ZSBpbiB2cmluZ19hbGxvY19xdWV1ZV9zcGxpdCBvZgo+ICAgdmlydGlvX3Jp
bmcgbGF5ZXIuCj4gLS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgfCA1
IC0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcGNpX21vZGVybi5jCj4gaW5kZXggOWU0OTZlMjg4Y2ZhLi42ZTcxMzkwNGQ4ZTggMTAwNjQ0
Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+ICsrKyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMKPiBAQCAtMzEwLDExICszMTAsNiBAQCBzdGF0
aWMgc3RydWN0IHZpcnRxdWV1ZSAqc2V0dXBfdnEoc3RydWN0IHZpcnRpb19wY2lfZGV2aWNlICp2
cF9kZXYsCj4gICAgICAgICBpZiAoIW51bSB8fCB2cF9tb2Rlcm5fZ2V0X3F1ZXVlX2VuYWJsZSht
ZGV2LCBpbmRleCkpCj4gICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9FTlQpOwo+
Cj4gLSAgICAgICBpZiAoIWlzX3Bvd2VyX29mXzIobnVtKSkgewo+IC0gICAgICAgICAgICAgICBk
ZXZfd2FybigmdnBfZGV2LT5wY2lfZGV2LT5kZXYsICJiYWQgcXVldWUgc2l6ZSAldSIsIG51bSk7
Cj4gLSAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FSU5WQUwpOwo+IC0gICAgICAgfQo+
IC0KPiAgICAgICAgIGluZm8tPm1zaXhfdmVjdG9yID0gbXNpeF92ZWM7Cj4KPiAgICAgICAgIC8q
IGNyZWF0ZSB0aGUgdnJpbmcgKi8KPiAtLQo+IDIuMzQuMQo+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
