Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4127CEB64DC
	for <virtualization@archiver.kernel.org>; Mon, 10 Jul 2023 03:16:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AE690817AB;
	Mon, 10 Jul 2023 03:16:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE690817AB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EtDC9taN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A1Tg7ZUsudQP; Mon, 10 Jul 2023 03:16:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3EFEA815AB;
	Mon, 10 Jul 2023 03:16:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EFEA815AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12A26C0072;
	Mon, 10 Jul 2023 03:16:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A5F1C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 30BAA81604
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:16:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 30BAA81604
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HAyKj2JAEGos
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:16:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 548C0815AB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 548C0815AB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688959006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a62DSLSpXeASP7dYpa5HsA33PutQ3KjJO6C/G/Q8iAk=;
 b=EtDC9taNDHxe3UhqS0Y14C9GRRrvbHW+ueIqProwcxJlRByuZtx+cnvnRc7Z+G7cq9wh87
 wU5+SGTKeEdB3+kJ+G22FYsTIEf30g1tID9cqbrtAlJhwKGWro5WCVQVlKI7XiccCJngZH
 P42ZiJogMaJfuwV5F7AvW0EP+f4sVCc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-sSkd99KXPdyy1HwS5lHJ1Q-1; Sun, 09 Jul 2023 23:16:45 -0400
X-MC-Unique: sSkd99KXPdyy1HwS5lHJ1Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b701e0bb10so33311781fa.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jul 2023 20:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688959004; x=1691551004;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a62DSLSpXeASP7dYpa5HsA33PutQ3KjJO6C/G/Q8iAk=;
 b=Evqx5SNHeeJSbXRRQTI8tnrktznEa27BHBeQkeKl7rwzYYRdDCO8/TcnzT0GPcAHKF
 CEspNTW4t/y6+cX1tvn++81XTRqH6lEmYfDl2K+apvdQwcZfSe2RgHuew4DaqQv6LTf5
 j+NkDNUm+olvZQPOPGkDIwPEoQ/bMZ2m72hWikSTak0EQ7mrBD2zD5y0mfqv5xTrgkVt
 LG8Hk4l7sL3Sy/2M/xKT6esI5qhXRnlRVwpmPQUjDv2YN31IfXIzzXUNmGzKb98z2N1g
 v6ij2WNhjLFlo7Jp3MZOh0QdLvYfUjYo2iu+8qVgelCf/b4GxjBa0tHzzdCfFvG+R1JE
 BktA==
X-Gm-Message-State: ABy/qLb4LXoxAli/twTyRXnYC9S/SPTBdQIsnsq4G40PTXl/HB29Cf8E
 Ie2X28PqdW6Eiw5r2NSKyZB1ERISBs9ZjpvGKr2spPjzt87Em2m3SrpnNGP7C4IaeEo9zSd7lcB
 mh1O30LtcH1APYp1zrI1KCGS1PO4B9tt8W8UNMV4ACH4EhN7Zsjuc36tGjg==
X-Received: by 2002:a05:651c:1025:b0:2b6:a22f:9fb9 with SMTP id
 w5-20020a05651c102500b002b6a22f9fb9mr8375724ljm.27.1688959004007; 
 Sun, 09 Jul 2023 20:16:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEnVegvrkpNt0TR6XRnujYIiNrsRYYJzxc37gJtNWKUE7a5YX0jPBMxs0gFC9cJdQNoUf+kMZdSTNMkLAa3IKo=
X-Received: by 2002:a05:651c:1025:b0:2b6:a22f:9fb9 with SMTP id
 w5-20020a05651c102500b002b6a22f9fb9mr8375700ljm.27.1688959002988; Sun, 09 Jul
 2023 20:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230706231718.54198-1-shannon.nelson@amd.com>
In-Reply-To: <20230706231718.54198-1-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jul 2023 11:16:32 +0800
Message-ID: <CACGkMEuD9DgK7CEp0cW-he3FAbzDVsvnhvouLWAMv9bUrq+ATA@mail.gmail.com>
Subject: Re: [PATCH virtio] pds_vdpa: protect Makefile from unconfigured
 debugfs
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: sfr@canb.auug.org.au, brett.creeley@amd.com, mst@redhat.com,
 netdev@vger.kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-next@vger.kernel.org,
 drivers@pensando.io
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

T24gRnJpLCBKdWwgNywgMjAyMyBhdCA3OjE34oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24u
bmVsc29uQGFtZC5jb20+IHdyb3RlOgo+Cj4gZGVidWdmcy5oIHByb3RlY3RzIGl0c2VsZiBmcm9t
IGFuIHVuZGVmaW5lZCBERUJVR19GUywgc28gaXQgaXMKPiBub3QgbmVjZXNzYXJ5IHRvIGNoZWNr
IGl0IGluIHRoZSBkcml2ZXIgY29kZSBvciB0aGUgTWFrZWZpbGUuCj4gVGhlIGRyaXZlciBjb2Rl
IGhhZCBiZWVuIHVwZGF0ZWQgZm9yIHRoaXMsIGJ1dCB0aGUgTWFrZWZpbGUgaGFkCj4gbWlzc2Vk
IHRoZSB1cGRhdGUuCj4KPiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1uZXh0
L2ZlYzY4YzNjLTgyNDktN2FmNC01MzkwLTA0OTUzODZhNzZmOUBpbmZyYWRlYWQub3JnLwo+IEZp
eGVzOiBhMTYyOTFiNWJjYmIgKCJwZHNfdmRwYTogQWRkIG5ldyB2RFBBIGRyaXZlciBmb3IgQU1E
L1BlbnNhbmRvIERTQyIpCj4gU2lnbmVkLW9mZi1ieTogU2hhbm5vbiBOZWxzb24gPHNoYW5ub24u
bmVsc29uQGFtZC5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy92ZHBhL3Bkcy9NYWtlZmlsZSB8IDMgKy0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL01ha2VmaWxlIGIvZHJpdmVycy92ZHBhL3Bkcy9NYWtl
ZmlsZQo+IGluZGV4IDJlMjI0MThlM2FiMy4uYzJkMzE0ZDQ2MTRkIDEwMDY0NAo+IC0tLSBhL2Ry
aXZlcnMvdmRwYS9wZHMvTWFrZWZpbGUKPiArKysgYi9kcml2ZXJzL3ZkcGEvcGRzL01ha2VmaWxl
Cj4gQEAgLTUsNiArNSw1IEBAIG9iai0kKENPTkZJR19QRFNfVkRQQSkgOj0gcGRzX3ZkcGEubwo+
Cj4gIHBkc192ZHBhLXkgOj0gYXV4X2Rydi5vIFwKPiAgICAgICAgICAgICAgIGNtZHMubyBcCj4g
KyAgICAgICAgICAgICBkZWJ1Z2ZzLm8gXAo+ICAgICAgICAgICAgICAgdmRwYV9kZXYubwo+IC0K
PiAtcGRzX3ZkcGEtJChDT05GSUdfREVCVUdfRlMpICs9IGRlYnVnZnMubwo+IC0tCj4gMi4xNy4x
Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
