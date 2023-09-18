Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DFEC46CA1
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 08:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C21178198A;
	Mon, 18 Sep 2023 08:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C21178198A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bDdp5CEZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BF_8jWQ3X_aH; Mon, 18 Sep 2023 08:49:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 56B4981FA8;
	Mon, 18 Sep 2023 08:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 56B4981FA8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2836EC0039;
	Mon, 18 Sep 2023 08:49:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F1A7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 61ABA4138D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:49:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 61ABA4138D
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=bDdp5CEZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gi7GKM2C_s21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:49:06 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 46159410DC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:49:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 46159410DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695026945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XjrLFNKkiROohp1YQUFUAWvCAJRc18i6LWfUqVeHSNg=;
 b=bDdp5CEZbVauUXjOX1O7JtjLZlU71hvHnnIGiPPqn0l4V/wmsNWY2AtSV9MACqZloGF3J0
 Pr0GxwphfyKLnL8wDpUYA/Bfib+9skyD+2QlmnEHaPPnnbpXUxytw8GYnzj09anw9FST1r
 x0aXAby2yrHzg5pDRXFCaDnK4ZxQMeQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-6KaQMA3aOGK3ArMax0LGDQ-1; Mon, 18 Sep 2023 04:49:01 -0400
X-MC-Unique: 6KaQMA3aOGK3ArMax0LGDQ-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-502d58d14beso3203958e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 01:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695026940; x=1695631740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjrLFNKkiROohp1YQUFUAWvCAJRc18i6LWfUqVeHSNg=;
 b=iVyPyHyWONLEJggmz34lJehQGX0BuR3pPQVrTYdIdV8RnxjaC4D0NkiTkpyDfDZlA8
 yo08g72I62LlCfDFlK7uot/WQ4EUWRw35XCi0kK8RTYslP4qUrEu1ufIGnVHgswI33Vl
 Ks0LW9zSfv4231+IthoTUm+ofZJANW9pwbQjBIaYcjKQ0LPf5u+nIupTOgIEUXS3ua0n
 cs2FeLNBkBH6hmBCUf1RBHZCc/2ZfMqDbCkmi+DN9VBM+zDQjiS/jBthL/iKprs49wxV
 xqeW/qrXrRmdo5FM5YwLj0axl5DPJoxvyDg5lnxUYi9HVLIfJalMd5r+/Fiz89CYFcgc
 s/Pg==
X-Gm-Message-State: AOJu0YyccT/q4HcgqjZioHBgTj43uVnF/OqdqvmODRjrtFh7CALynyDz
 nbO/+ncSJQtqnaPDkOgAqACEQZ7q0qrJKWD6aBAJXKm8nSyjMYEhcNXpoFdotLVAKkghj/yKxTK
 ESt0MHSZYU/q+8QPSRxiX1vvU49NtK0/O/zDHp2e2RlgE9GkmLiYqIWB12Q==
X-Received: by 2002:a05:6512:454:b0:500:9a45:63b with SMTP id
 y20-20020a056512045400b005009a45063bmr6257570lfk.13.1695026940423; 
 Mon, 18 Sep 2023 01:49:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcNhH5iIOphVoYXcP9ThVDZ+q8P4m1obQ5qx04ejzkKLACIx/Lt0O6PKx0zAhN2vKlafazLnuEdoCmJbrjonc=
X-Received: by 2002:a05:6512:454:b0:500:9a45:63b with SMTP id
 y20-20020a056512045400b005009a45063bmr6257546lfk.13.1695026940132; Mon, 18
 Sep 2023 01:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230912030008.3599514-1-lulu@redhat.com>
 <20230912030008.3599514-5-lulu@redhat.com>
In-Reply-To: <20230912030008.3599514-5-lulu@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 18 Sep 2023 16:48:49 +0800
Message-ID: <CACGkMEtCYG8-Pt+V-OOwUV7fYFp_cnxU68Moisfxju9veJ-=qw@mail.gmail.com>
Subject: Re: [RFC v2 4/4] vduse: Add new ioctl VDUSE_GET_RECONNECT_INFO
To: Cindy Lu <lulu@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 maxime.coquelin@redhat.com
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

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTE6MDHigK9BTSBDaW5keSBMdSA8bHVsdUByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IEluIFZEVVNFX0dFVF9SRUNPTk5FQ1RfSU5GTywgdGhlIFVzZXJzcGFj
ZSBBcHAgY2FuIGdldCB0aGUgbWFwIHNpemUKPiBhbmQgVGhlIG51bWJlciBvZiBtYXBwaW5nIG1l
bW9yeSBwYWdlcyBmcm9tIHRoZSBrZXJuZWwuIFRoZSB1c2Vyc3BhY2UKPiBBcHAgY2FuIHVzZSB0
aGlzIGluZm9ybWF0aW9uIHRvIG1hcCB0aGUgcGFnZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDaW5k
eSBMdSA8bHVsdUByZWRoYXQuY29tPgo+IC0tLQo+ICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3Zk
dXNlX2Rldi5jIHwgMTUgKysrKysrKysrKysrKysrCj4gIGluY2x1ZGUvdWFwaS9saW51eC92ZHVz
ZS5oICAgICAgICAgfCAxNSArKysrKysrKysrKysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMCBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVz
ZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBpbmRleCA2ODBi
MjNkYmRkZTIuLmM5OWY5OTg5MmI1YyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91
c2VyL3ZkdXNlX2Rldi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYu
Ywo+IEBAIC0xMzY4LDYgKzEzNjgsMjEgQEAgc3RhdGljIGxvbmcgdmR1c2VfZGV2X2lvY3RsKHN0
cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgICAgICAgICAgICAgICByZXQg
PSAwOwo+ICAgICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgIH0KPiArICAgICAgIGNhc2Ug
VkRVU0VfR0VUX1JFQ09OTkVDVF9JTkZPOiB7Cj4gKyAgICAgICAgICAgICAgIHN0cnVjdCB2ZHVz
ZV9yZWNvbm5lY3RfbW1hcF9pbmZvIGluZm87Cj4gKwo+ICsgICAgICAgICAgICAgICByZXQgPSAt
RUZBVUxUOwo+ICsgICAgICAgICAgICAgICBpZiAoY29weV9mcm9tX3VzZXIoJmluZm8sIGFyZ3As
IHNpemVvZihpbmZvKSkpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7Cj4gKwo+ICsg
ICAgICAgICAgICAgICBpbmZvLnNpemUgPSBQQUdFX1NJWkU7Cj4gKyAgICAgICAgICAgICAgIGlu
Zm8ubWF4X2luZGV4ID0gZGV2LT52cV9udW0gKyAxOwo+ICsKPiArICAgICAgICAgICAgICAgaWYg
KGNvcHlfdG9fdXNlcihhcmdwLCAmaW5mbywgc2l6ZW9mKGluZm8pKSkKPiArICAgICAgICAgICAg
ICAgICAgICAgICBicmVhazsKPiArICAgICAgICAgICAgICAgcmV0ID0gMDsKPiArICAgICAgICAg
ICAgICAgYnJlYWs7Cj4gKyAgICAgICB9Cj4gICAgICAgICBkZWZhdWx0Ogo+ICAgICAgICAgICAg
ICAgICByZXQgPSAtRU5PSU9DVExDTUQ7Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL3VhcGkvbGludXgvdmR1c2UuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92
ZHVzZS5oCj4gaW5kZXggZDU4NTQyNTgwM2ZkLi5jZTU1ZTM0ZjYzZDcgMTAwNjQ0Cj4gLS0tIGEv
aW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgKPiArKysgYi9pbmNsdWRlL3VhcGkvbGludXgvdmR1
c2UuaAo+IEBAIC0zNTYsNCArMzU2LDE5IEBAIHN0cnVjdCB2aG9zdF9yZWNvbm5lY3RfdnJpbmcg
ewo+ICAgICAgICAgX0Jvb2wgYXZhaWxfd3JhcF9jb3VudGVyOwo+ICB9Owo+Cj4gKy8qKgo+ICsg
KiBzdHJ1Y3QgdmR1c2VfcmVjb25uZWN0X21tYXBfaW5mbwo+ICsgKiBAc2l6ZTogbWFwcGluZyBt
ZW1vcnkgc2l6ZSwgYWx3YXlzIHBhZ2Vfc2l6ZSBoZXJlCj4gKyAqIEBtYXhfaW5kZXg6IHRoZSBu
dW1iZXIgb2YgcGFnZXMgYWxsb2NhdGVkIGluIGtlcm5lbCxqdXN0Cj4gKyAqIHVzZSBmb3IgY2hl
Y2sKPiArICovCj4gKwo+ICtzdHJ1Y3QgdmR1c2VfcmVjb25uZWN0X21tYXBfaW5mbyB7Cj4gKyAg
ICAgICBfX3UzMiBzaXplOwo+ICsgICAgICAgX191MzIgbWF4X2luZGV4Owo+ICt9OwoKT25lIHRo
aW5nIEkgZGlkbid0IHVuZGVyc3RhbmQgaXMgdGhhdCwgYXJlbid0IHRoZSB0aGluZ3Mgd2UgdXNl
ZCB0bwpzdG9yZSBjb25uZWN0aW9uIGluZm8gYmVsb25nIHRvIHVBUEk/IElmIG5vdCwgaG93IGNh
biB3ZSBtYWtlIHN1cmUgdGhlCmNvbm5lY3Rpb25zIHdvcmsgYWNyb3NzIGRpZmZlcmVudCB2ZW5k
b3JzL2ltcGxlbWVudGF0aW9ucy4gSWYgeWVzLAp3aGVyZT8KClRoYW5rcwoKPiArCj4gKyNkZWZp
bmUgVkRVU0VfR0VUX1JFQ09OTkVDVF9JTkZPIFwKPiArICAgICAgIF9JT1dSKFZEVVNFX0JBU0Us
IDB4MWIsIHN0cnVjdCB2ZHVzZV9yZWNvbm5lY3RfbW1hcF9pbmZvKQo+ICsKPiAgI2VuZGlmIC8q
IF9VQVBJX1ZEVVNFX0hfICovCj4gLS0KPiAyLjM0LjMKPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
