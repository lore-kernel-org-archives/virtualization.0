Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE52CEE49A0
	for <virtualization@archiver.kernel.org>; Mon, 21 Aug 2023 03:59:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 412F681E9E;
	Mon, 21 Aug 2023 03:59:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 412F681E9E
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CXYLYmUZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3nSOqwKv_kEr; Mon, 21 Aug 2023 03:59:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C81E081B52;
	Mon, 21 Aug 2023 03:59:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C81E081B52
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99241C0071;
	Mon, 21 Aug 2023 03:59:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D3A5C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 03:59:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70D2F408D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 03:59:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70D2F408D4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CXYLYmUZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dP9nv0y5AWgT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 03:59:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9441D400C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Aug 2023 03:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9441D400C6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692590378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nreHUn0JxkoanDSj8+vpmXEimTfEctb6qeC7zgFBAZ8=;
 b=CXYLYmUZc+k9BUFpZLOkg5F1alPVrAHGpTkUIVoZnqlz/wY6tpuTjiXHi6AEoVviJga6OY
 7NB15ilRMU8n+P2tz+jCOpNUIK0ibsGH+Aoei6xqPEIhj5erFfFX7k4VvvMKsfFHgrp78K
 nI7OIcH6IBtF1A9P5YQ+sGrEGbJWu/g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-OdSKoXN5OzmkAR_EqHupLg-1; Sun, 20 Aug 2023 23:59:36 -0400
X-MC-Unique: OdSKoXN5OzmkAR_EqHupLg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b961c3af8fso29611271fa.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 20 Aug 2023 20:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692590374; x=1693195174;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nreHUn0JxkoanDSj8+vpmXEimTfEctb6qeC7zgFBAZ8=;
 b=g94huB4flMtV7TXACc7UNrdXCFYKCGsj73ygWYM/dpmJHyk0igRVbU134a9lXKIJwn
 Ad0uJGYp5shA34i4LB9JTNCRAhFJg255Hn8MFMeIRaKyZUDuV2oh7JNoSvmHcVMMMAcB
 GTot+9BdPGUKJoK5mqhCVxFndHy7l1RuAI4a8ZeyE46hLxcUBj4QdFddi9NhRmKyrbaP
 IEfSTzoEQ75qod6clZQKLzVE7rr7wUolzo/FJbBearAcLwQSxhkk4S7tHURCtkpbAkll
 UbaY8o2u1A/iHI0x9FQuFf2VX7lkig41JjYRuP7xMpISweCQ8YDLDVf9MNtekTeWYiy0
 s/0g==
X-Gm-Message-State: AOJu0YzUC+qkqRA6TeAaHJYM6FBSTeuGrTvDFWC56YnSrONR4TymhLW2
 gyG5lYsn3DO292UNCin0kqyTdep6TWBENzsh5ad8KPSSZeDdC/5LoqMBFj8kQXgVwU1ojk4bg29
 SOPLx35+SAzn6nwM02EiveAsLJR+A8MXsED8su7V3A1cdJbM/UKDb24cn1A==
X-Received: by 2002:a2e:3112:0:b0:2b9:f13b:6139 with SMTP id
 x18-20020a2e3112000000b002b9f13b6139mr3790127ljx.20.1692590374666; 
 Sun, 20 Aug 2023 20:59:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoBfF77nVJ4yrfjIeH14bn2Sai5TI3z+fImzUqsK4koFFUoPXY3bC1l2hD9WkdtuxTln8L++7hBwtc5Kq6axs=
X-Received: by 2002:a2e:3112:0:b0:2b9:f13b:6139 with SMTP id
 x18-20020a2e3112000000b002b9f13b6139mr3790120ljx.20.1692590374399; Sun, 20
 Aug 2023 20:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230821021835.1134-1-shawn.shao@jaguarmicro.com>
In-Reply-To: <20230821021835.1134-1-shawn.shao@jaguarmicro.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 21 Aug 2023 11:59:23 +0800
Message-ID: <CACGkMEs=B6yswCE0O_J+_X_XO9bPx-R+dM9SvSM77wyoCTroDg@mail.gmail.com>
Subject: Re: [PATCH] vdpa_sim_blk: Fix the potential leak of mgmt_dev
To: "Shawn.Shao" <shawn.shao@jaguarmicro.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, lege.wang@jaguarmicro.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
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

T24gTW9uLCBBdWcgMjEsIDIwMjMgYXQgMTA6MTjigK9BTSBTaGF3bi5TaGFvIDxzaGF3bi5zaGFv
QGphZ3Vhcm1pY3JvLmNvbT4gd3JvdGU6Cj4KPiBJZiB0aGUgc2hhcmVkX2J1ZmZlciBhbGxvY2F0
aW9uIGZhaWxzLCBuZWVkIHRvIHVucmVnaXN0ZXIgbWdtdF9kZXYgZmlyc3QuCj4KClBsZWFzZSBh
ZGQgYSBGaXhlcyB0YWcuCgpPdGhlciB0aGFuIHRoaXMKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgo+IFNpZ25lZC1vZmYtYnk6IFNoYXduLlNoYW8g
PHNoYXduLnNoYW9AamFndWFybWljcm8uY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEvdmRwYV9z
aW0vdmRwYV9zaW1fYmxrLmMgfCA1ICsrKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltX2Jsay5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5j
Cj4gaW5kZXggMDBkN2Q3MjcxM2JlLi5iM2EzY2IxNjU3OTUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltX2Jsay5jCj4gQEAgLTQ5OSwxMiArNDk5LDEzIEBAIHN0YXRpYyBpbnQgX19p
bml0IHZkcGFzaW1fYmxrX2luaXQodm9pZCkKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEdGUF9LRVJORUwpOwo+ICAgICAgICAgICAgICAgICBpZiAoIXNoYXJlZF9i
dWZmZXIpIHsKPiAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRU5PTUVNOwo+IC0gICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gcGFyZW50X2VycjsKPiArICAgICAgICAgICAgICAgICAg
ICAgICBnb3RvIG1nbXRfZGV2X2VycjsKPiAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgfQo+
Cj4gICAgICAgICByZXR1cm4gMDsKPiAtCj4gK21nbXRfZGV2X2VycjoKPiArICAgICAgIHZkcGFf
bWdtdGRldl91bnJlZ2lzdGVyKCZtZ210X2Rldik7Cj4gIHBhcmVudF9lcnI6Cj4gICAgICAgICBk
ZXZpY2VfdW5yZWdpc3RlcigmdmRwYXNpbV9ibGtfbWdtdGRldik7Cj4gICAgICAgICByZXR1cm4g
cmV0Owo+IC0tCj4gMi4zNC4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
