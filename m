Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1827C0015E
	for <virtualization@archiver.kernel.org>; Wed, 26 Jul 2023 05:38:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 48FA140BD7;
	Wed, 26 Jul 2023 05:38:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 48FA140BD7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bu/0wS/r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZyUCNc5qHIiv; Wed, 26 Jul 2023 05:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ECF5640BD1;
	Wed, 26 Jul 2023 05:38:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ECF5640BD1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94805C0071;
	Wed, 26 Jul 2023 05:38:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ACFCC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 05:38:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6240607F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 05:38:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C6240607F1
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bu/0wS/r
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fejml22slfya
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 05:38:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4827F607A4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jul 2023 05:38:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4827F607A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690349918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pfs3nnD/SOOUA7MFV9W94hwiVWoxJiHiqbutUMOkKZQ=;
 b=bu/0wS/rC944LMPG0hrxFwvanzuSGpleBFlAEtLuK7TA/fMUL2U2tA000CjQUSG1ca+PWB
 DNzeMReFKqtTikrKbuXhudEQIcD68FMHuf68hHfIStuOzvgUA+j93APdXIszlD9uzp2fwh
 /LOpXUsvizeN+HcU26DUrGYICtxI7rU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-tmLzuqVhNSu5Nkku1ulHZQ-1; Wed, 26 Jul 2023 01:38:36 -0400
X-MC-Unique: tmLzuqVhNSu5Nkku1ulHZQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b95d92116dso56918211fa.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Jul 2023 22:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690349914; x=1690954714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfs3nnD/SOOUA7MFV9W94hwiVWoxJiHiqbutUMOkKZQ=;
 b=fp6Gv01GCw9O6qclxFDNE2he2JxrKbxOQulCCkd/g7etsQ26vbxK9bxN6tSk7k7hEw
 fQANbRQDQJWZm8XXn8W2ctJOiqEoKUv1/5k1NkGMInRpHHESr3+iVzXi89RfqjsvR695
 JjsbVTiltlfbedv1RkhUH5W/rSH9qWy1TDfeOgXYRDntTj9c7BROAQm8fSuAvOOFCtKo
 g9DqyFRChka3J8M8oJys1VYYZlHMUlxmk4F7jRU8XLOsX+PGPglQvR8PYJ3Vqiq+d091
 CnAQCtD2ybN9Cs3Pxg+Ku5x9nmd8tKaG0XHUl94JOBWVUV/MVrPTrqrXcZ1ilt7G2deL
 4QAg==
X-Gm-Message-State: ABy/qLY3X1GhohPLllN0gHFIN0aAtHc+wRChOcWxgEWgBs6Fkz5TBzfT
 x7WXBdc0dw0GOeMYd+Jr4ry+WhI7P1C5a5ap1WtY0yd1vwTGVuvFnN1JtCA2AEHpaAEXnJLvuK1
 5zCwQfOksZ/Tw7ONC7XLN6tbY8en8mEGAbLpN0kimfdXimPB8losAWK/pnQ==
X-Received: by 2002:a2e:8042:0:b0:2b6:dd9a:e1d3 with SMTP id
 p2-20020a2e8042000000b002b6dd9ae1d3mr605686ljg.44.1690349914783; 
 Tue, 25 Jul 2023 22:38:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZ1ivRh44yxvv5AoW/k+bdQtpElC2pldw9fqqViy1tLZuooCCFV/0/FqgQ945tCdp+io30vgVHGutAPfdVtuA=
X-Received: by 2002:a2e:8042:0:b0:2b6:dd9a:e1d3 with SMTP id
 p2-20020a2e8042000000b002b6dd9ae1d3mr605673ljg.44.1690349914469; Tue, 25 Jul
 2023 22:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230705114505.63274-1-maxime.coquelin@redhat.com>
In-Reply-To: <20230705114505.63274-1-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Jul 2023 13:38:22 +0800
Message-ID: <CACGkMEtF9c0dL+bk0=JovcVs-ZVzEJJXdt9gx=_Lh+KtwFu9ig@mail.gmail.com>
Subject: Re: [PATCH] vduse: Use proper spinlock for IRQ injection
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 eperezma@redhat.com, david.marchand@redhat.com
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

T24gV2VkLCBKdWwgNSwgMjAyMyBhdCA3OjQ14oCvUE0gTWF4aW1lIENvcXVlbGluCjxtYXhpbWUu
Y29xdWVsaW5AcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBUaGUgSVJRIGluamVjdGlvbiB3b3JrIHVz
ZWQgc3Bpbl9sb2NrX2lycSgpIHRvIHByb3RlY3QgdGhlCj4gc2NoZWR1bGluZyBvZiB0aGUgc29m
dGlycSwgYnV0IHNwaW5fbG9ja19iaCgpIHNob3VsZCBiZQo+IHVzZWQuCj4KPiBXaXRoIHNwaW5f
bG9ja19pcnEoKSwgd2Ugbm90aWNlZCBkZWxheSBvZiBtb3JlIHRoYW4gNgo+IHNlY29uZHMgYmV0
d2VlbiB0aGUgdGltZSBhIE5BUEkgcG9sbGluZyB3b3JrIGlzIHNjaGVkdWxlZAo+IGFuZCB0aGUg
dGltZSBpdCBpcyBleGVjdXRlZC4KPgo+IEZpeGVzOiBjOGE2MTUzYjZjNTkgKCJ2ZHVzZTogSW50
cm9kdWNlIFZEVVNFIC0gdkRQQSBEZXZpY2UgaW4gVXNlcnNwYWNlIikKPiBDYzogeGlleW9uZ2pp
QGJ5dGVkYW5jZS5jb20KPgo+IFN1Z2dlc3RlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBNYXhpbWUgQ29xdWVsaW4gPG1heGltZS5jb3F1ZWxp
bkByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgpUaGFua3MKCgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwg
OCArKysrLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMg
Yi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gaW5kZXggZGMzOGVkMjEzMTlk
Li5kZjc4Njk1MzdlZjEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVz
ZV9kZXYuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBAQCAt
OTM1LDEwICs5MzUsMTAgQEAgc3RhdGljIHZvaWQgdmR1c2VfZGV2X2lycV9pbmplY3Qoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgdmR1c2VfZGV2ICpkZXYg
PSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHZkdXNlX2RldiwgaW5qZWN0KTsKPgo+IC0gICAg
ICAgc3Bpbl9sb2NrX2lycSgmZGV2LT5pcnFfbG9jayk7Cj4gKyAgICAgICBzcGluX2xvY2tfYmgo
JmRldi0+aXJxX2xvY2spOwo+ICAgICAgICAgaWYgKGRldi0+Y29uZmlnX2NiLmNhbGxiYWNrKQo+
ICAgICAgICAgICAgICAgICBkZXYtPmNvbmZpZ19jYi5jYWxsYmFjayhkZXYtPmNvbmZpZ19jYi5w
cml2YXRlKTsKPiAtICAgICAgIHNwaW5fdW5sb2NrX2lycSgmZGV2LT5pcnFfbG9jayk7Cj4gKyAg
ICAgICBzcGluX3VubG9ja19iaCgmZGV2LT5pcnFfbG9jayk7Cj4gIH0KPgo+ICBzdGF0aWMgdm9p
ZCB2ZHVzZV92cV9pcnFfaW5qZWN0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiBAQCAtOTQ2
LDEwICs5NDYsMTAgQEAgc3RhdGljIHZvaWQgdmR1c2VfdnFfaXJxX2luamVjdChzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspCj4gICAgICAgICBzdHJ1Y3QgdmR1c2VfdmlydHF1ZXVlICp2cSA9IGNv
bnRhaW5lcl9vZih3b3JrLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgdmR1c2VfdmlydHF1ZXVlLCBpbmplY3QpOwo+Cj4gLSAgICAgICBzcGluX2xvY2tf
aXJxKCZ2cS0+aXJxX2xvY2spOwo+ICsgICAgICAgc3Bpbl9sb2NrX2JoKCZ2cS0+aXJxX2xvY2sp
Owo+ICAgICAgICAgaWYgKHZxLT5yZWFkeSAmJiB2cS0+Y2IuY2FsbGJhY2spCj4gICAgICAgICAg
ICAgICAgIHZxLT5jYi5jYWxsYmFjayh2cS0+Y2IucHJpdmF0ZSk7Cj4gLSAgICAgICBzcGluX3Vu
bG9ja19pcnEoJnZxLT5pcnFfbG9jayk7Cj4gKyAgICAgICBzcGluX3VubG9ja19iaCgmdnEtPmly
cV9sb2NrKTsKPiAgfQo+Cj4gIHN0YXRpYyBib29sIHZkdXNlX3ZxX3NpZ25hbF9pcnFmZChzdHJ1
Y3QgdmR1c2VfdmlydHF1ZXVlICp2cSkKPiAtLQo+IDIuNDEuMAo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
