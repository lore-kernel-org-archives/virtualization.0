Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20482EB64DD
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 08:03:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9D42F8131B;
	Tue, 27 Jun 2023 08:03:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9D42F8131B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dj1MWroo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fgFlPenbA6av; Tue, 27 Jun 2023 08:03:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2A09E8132C;
	Tue, 27 Jun 2023 08:03:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2A09E8132C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1019C007C;
	Tue, 27 Jun 2023 08:03:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C78E7C0DD4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8B86E416DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B86E416DD
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dj1MWroo
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OFaB4UFdusYt
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CBEC4416D6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CBEC4416D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 08:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687853022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eV3eQXIpI7GK86spQgbBgb9YP8fkr4Uc5ICkyIAxi2s=;
 b=dj1MWrooHuO3rMvF2pXjhmFV7JWfLuYm2ABUX7mMjsc8Lrs/Y5MmtLFtp7w7tz82uLfFFV
 TUAPZZP01sXUoqmBobLw8+D9EVtMwQGw1sn7uRvcprrrBbxqAniO/eCizbxQjXLTa72XrR
 1HY6YmTjrZoFFxtio0HQbWGGL7xssN8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-a3zHAmKcMsGR1sGDP05pvA-1; Tue, 27 Jun 2023 04:03:40 -0400
X-MC-Unique: a3zHAmKcMsGR1sGDP05pvA-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b699c5f238so18213151fa.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 01:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687853019; x=1690445019;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eV3eQXIpI7GK86spQgbBgb9YP8fkr4Uc5ICkyIAxi2s=;
 b=NK3BwJtPPDY4u9jcEoIYP+xvNdtSBI6U9WoaTGfW2ozBW4F4TxEDfbHiT+19dpvQ8M
 2BS5SAmmXqc14FsFT1zgqAhen5OGGrzxksA6fO/Oq0T8/+WSB2042jDjjwWjBgCwjG+c
 ybbQTO+h967LH92DAiDU5f5vP2bCMgNsRtqAhk044EjAoln55neE3DyBzhzP3HORT0hG
 bLGgB9P6XZN53vA2XTds+doTrUjNB+dMU5HxfqGsn1Zr6BUHjpwa90scTyb6fEPjPC9g
 Fh/gw+aWyKxZARHclFw/Mwf0p7d1sO1G51urj8fC4mLPiyW18nugSHaTgPz/YAX3uW5x
 XUjA==
X-Gm-Message-State: AC+VfDzjbpYFArT/Helvp8Z39o3vKM4ggZ6EXZfysghbMi3mwHy9lsXX
 5v0XYUj60KzN52l8RBmRv/h27lw3/rAI2PKo5r8ALdkWNNabP8vl8v7O0lNmfl1PKHu1UqSmStl
 9uZFoKaaAIWX+X7nbc08cRxPA01QufxLb7NiR9bbGBTD8raqHwy6smMINCA==
X-Received: by 2002:a05:651c:8f:b0:2b6:a17b:a120 with SMTP id
 15-20020a05651c008f00b002b6a17ba120mr3522018ljq.22.1687853018834; 
 Tue, 27 Jun 2023 01:03:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xju1Kw8PXR4eNgtQmaSoMhLrIsFLXo1LyKXcgnZgXB4na1UrEhIvvI/ONUbs4VdgeXtddNPmkh0ZyvZ27O0Q=
X-Received: by 2002:a05:651c:8f:b0:2b6:a17b:a120 with SMTP id
 15-20020a05651c008f00b002b6a17ba120mr3521994ljq.22.1687853018639; Tue, 27 Jun
 2023 01:03:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230602092206.50108-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:03:26 +0800
Message-ID: <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
Subject: Re: [PATCH vhost v10 03/10] virtio_ring: split: support add premapped
 buf
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

T24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjIy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBJZiB0aGUgdnEgaXMgdGhlIHByZW1hcHBlZCBtb2Rl
LCB1c2UgdGhlIHNnX2RtYV9hZGRyZXNzKCkgZGlyZWN0bHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jIHwgNDYgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkK
Pgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IDJhZmRmYjllM2UzMC4uMTgyMTJjM2UwNTZiIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTU5OCw4ICs1OTgsMTIgQEAgc3RhdGljIGlubGlu
ZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAgICAg
ICAgICAgICAgIGZvciAoc2cgPSBzZ3Nbbl07IHNnOyBzZyA9IHNnX25leHQoc2cpKSB7Cj4gICAg
ICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBhZGRyOwo+Cj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgaWYgKHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBETUFfVE9fREVWSUNFLCAmYWRk
cikpCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7
Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZxLT5wcmVtYXBwZWQpIHsKPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHIgPSBzZ19kbWFfYWRkcmVzcyhzZyk7Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsKPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1BX1RPX0RFVklDRSwgJmFkZHIp
KQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3Jl
bGVhc2U7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQoKQnR3LCBJIHdvbmRlciB3aGV0aGVy
IG9yIG5vdCBpdCB3b3VsZCBiZSBzaW1wbGUgdG8gaW1wbGVtZW50IHRoZQp2cS0+cHJlbWFwcGVk
IGNoZWNrIGluc2lkZSB2cmluZ19tYXBfb25lX3NnKCkgYXNzdW1pbmcgdGhlCiF1c2VfZG1hX2Fw
aSBpcyBkb25lIHRoZXJlIGFzIHdlbGwuCgo+Cj4gICAgICAgICAgICAgICAgICAgICAgICAgcHJl
diA9IGk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgLyogTm90ZSB0aGF0IHdlIHRydXN0IGlu
ZGlyZWN0IGRlc2NyaXB0b3IKPiBAQCAtNjE0LDggKzYxOCwxMiBAQCBzdGF0aWMgaW5saW5lIGlu
dCB2aXJ0cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgICAgICAgICAg
ICAgICAgZm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0gc2dfbmV4dChzZykpIHsKPiAgICAgICAg
ICAgICAgICAgICAgICAgICBkbWFfYWRkcl90IGFkZHI7Cj4KPiAtICAgICAgICAgICAgICAgICAg
ICAgICBpZiAodnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIERNQV9GUk9NX0RFVklDRSwgJmFkZHIp
KQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byB1bm1hcF9yZWxlYXNlOwo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICh2cS0+cHJlbWFwcGVkKSB7Cj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gc2dfZG1hX2FkZHJlc3Moc2cpOwo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpZiAodnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIERNQV9GUk9NX0RFVklDRSwgJmFkZHIp
KQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3Jl
bGVhc2U7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAgICAgICAgICAg
ICAgICAgcHJldiA9IGk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgLyogTm90ZSB0aGF0IHdl
IHRydXN0IGluZGlyZWN0IGRlc2NyaXB0b3IKPiBAQCAtNjg5LDIxICs2OTcsMjMgQEAgc3RhdGlj
IGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4g
ICAgICAgICByZXR1cm4gMDsKPgo+ICB1bm1hcF9yZWxlYXNlOgo+IC0gICAgICAgZXJyX2lkeCA9
IGk7Cj4gKyAgICAgICBpZiAoIXZxLT5wcmVtYXBwZWQpIHsKCkNhbiB2cS0+cHJlbWFwcGVkIGJl
IHRydWUgaGVyZT8gVGhlIGxhYmVsIGlzIG5hbWVkIGFzICJ1bm1hcF9yZWxhc2UiCndoaWNoIGlt
cGxpZXMgIm1hcCIgYmVmb3JlaGFuZCB3aGljaCBzZWVtcyBub3QgdGhlIGNhc2UgZm9yCnByZW1h
cHBpbmcuCgpUaGFua3MKCgo+ICsgICAgICAgICAgICAgICBlcnJfaWR4ID0gaTsKPgo+IC0gICAg
ICAgaWYgKGluZGlyZWN0KQo+IC0gICAgICAgICAgICAgICBpID0gMDsKPiAtICAgICAgIGVsc2UK
PiAtICAgICAgICAgICAgICAgaSA9IGhlYWQ7Cj4gLQo+IC0gICAgICAgZm9yIChuID0gMDsgbiA8
IHRvdGFsX3NnOyBuKyspIHsKPiAtICAgICAgICAgICAgICAgaWYgKGkgPT0gZXJyX2lkeCkKPiAt
ICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAtICAgICAgICAgICAgICAgaWYgKGluZGly
ZWN0KSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgdnJpbmdfdW5tYXBfb25lX3NwbGl0X2lu
ZGlyZWN0KHZxLCAmZGVzY1tpXSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgaSA9IHZpcnRp
bzE2X3RvX2NwdShfdnEtPnZkZXYsIGRlc2NbaV0ubmV4dCk7Cj4gLSAgICAgICAgICAgICAgIH0g
ZWxzZQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGkgPSB2cmluZ191bm1hcF9vbmVfc3BsaXQo
dnEsIGkpOwo+ICsgICAgICAgICAgICAgICBpZiAoaW5kaXJlY3QpCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgaSA9IDA7Cj4gKyAgICAgICAgICAgICAgIGVsc2UKPiArICAgICAgICAgICAgICAg
ICAgICAgICBpID0gaGVhZDsKPiArCj4gKyAgICAgICAgICAgICAgIGZvciAobiA9IDA7IG4gPCB0
b3RhbF9zZzsgbisrKSB7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKGkgPT0gZXJyX2lk
eCkKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChpbmRpcmVjdCkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdnJpbmdfdW5tYXBfb25lX3NwbGl0X2luZGlyZWN0KHZxLCAmZGVzY1tpXSk7Cj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpID0gdmlydGlvMTZfdG9fY3B1KF92cS0+dmRl
diwgZGVzY1tpXS5uZXh0KTsKPiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2UKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkgPSB2cmluZ191bm1hcF9vbmVfc3BsaXQodnEs
IGkpOwo+ICsgICAgICAgICAgICAgICB9Cj4gICAgICAgICB9Cj4KPiAgICAgICAgIGlmIChpbmRp
cmVjdCkKPiAtLQo+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
