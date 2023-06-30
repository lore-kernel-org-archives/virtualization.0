Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3A1EB64D7
	for <virtualization@archiver.kernel.org>; Fri, 30 Jun 2023 09:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10A94612E6;
	Fri, 30 Jun 2023 09:05:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10A94612E6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GLwY9Ap7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YCnoZ6F-lXSv; Fri, 30 Jun 2023 09:05:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 88CF161282;
	Fri, 30 Jun 2023 09:05:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88CF161282
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 647F8C0072;
	Fri, 30 Jun 2023 09:05:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D06AC0037
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 09:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 364F2612BC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 09:05:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 364F2612BC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cQCgbo7CusgT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 09:05:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1D4B361282
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1D4B361282
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688115952; x=1719651952;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=53bVGSy6uyVLmuLLOsl+45L/7XdZtKRaI/mMrsRyOYE=;
 b=GLwY9Ap7MZIUD43PvsWetG2jZuz1fHDl/z7OxQL7eK4HYt5iUzZ4zf6U
 Azm+a0adIzMLOvuZ/vySVyifaGeAgIe74Ypiup8jOJuon8KoSBatDE/IW
 L98eflMZf3q5bNj5Y9rLvYgBqUG/cjU6QW28Ds+ck2z8dpT6QG63ec3jh
 sO/WBsnhBGx6k/qgRyFRmyoMgmG80e3y2hR9rc6OEuoy3c9sGj/NevaXY
 v7LnN7a86U16tLMXTiObbUv3qwmBwBWfj4VEUs5dODnDjreziLTr2TWIg
 zWjhNyxojOlxhnuYqlG8eeSeshDM5VX3Jl7pFebbQS4Gk5xcRpHyTINd4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="341934855"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="341934855"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 02:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807691825"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; d="scan'208";a="807691825"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.169.9])
 ([10.249.169.9])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2023 02:05:49 -0700
Message-ID: <d86f2842-8149-9f74-46a3-f09fd66eb03a@intel.com>
Date: Fri, 30 Jun 2023 17:05:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] vp_vdpa: synchronize irq when free irq
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230630103656.345870-1-lingshan.zhu@intel.com>
 <CACGkMEteNC5vKe5QUyhPaiBAoEKHzyMKc2W5MpzbzeVWBe0qWQ@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEteNC5vKe5QUyhPaiBAoEKHzyMKc2W5MpzbzeVWBe0qWQ@mail.gmail.com>
Cc: virtualization@lists.linux-foundation.org, Cindy Lu <lulu@redhat.com>,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CgpPbiA2LzMwLzIwMjMgNDowMiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiBPbiBGcmksIEp1biAz
MCwgMjAyMyBhdCAxMDozN+KAr0FNIFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNv
bT4gd3JvdGU6Cj4+IFRoaXMgY29tbWl0cyBzeW5jaHJvbml6ZXMgaXJxcyB3aGVuIGZyZWUgdGhl
bQo+IE5lZWQgdG8gZXhwbGFpbiB3aHkgaXQgaXMgbmVlZGVkLgo+Cj4+IFNpZ25lZC1vZmYtYnk6
IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KPj4gVGVzdGVkLWJ5OiBDaW5k
eSBMdSA8bHVsdUByZWRoYXQuY29tPgo+PiAtLS0KPj4gICBkcml2ZXJzL3ZkcGEvdmlydGlvX3Bj
aS92cF92ZHBhLmMgfCAyICsrCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jIGIvZHJp
dmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4+IGluZGV4IDI4MTI4N2ZhZTg5Zi4uZDhl
ZTNlNjhjZDJkIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBh
LmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL3ZpcnRpb19wY2kvdnBfdmRwYS5jCj4+IEBAIC0xMTYs
NiArMTE2LDcgQEAgc3RhdGljIHZvaWQgdnBfdmRwYV9mcmVlX2lycShzdHJ1Y3QgdnBfdmRwYSAq
dnBfdmRwYSkKPj4gICAgICAgICAgZm9yIChpID0gMDsgaSA8IHZwX3ZkcGEtPnF1ZXVlczsgaSsr
KSB7Cj4+ICAgICAgICAgICAgICAgICAgaWYgKHZwX3ZkcGEtPnZyaW5nW2ldLmlycSAhPSBWSVJU
SU9fTVNJX05PX1ZFQ1RPUikgewo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgdnBfbW9kZXJu
X3F1ZXVlX3ZlY3RvcihtZGV2LCBpLCBWSVJUSU9fTVNJX05PX1ZFQ1RPUik7Cj4+ICsgICAgICAg
ICAgICAgICAgICAgICAgIHN5bmNocm9uaXplX2lycSh2cF92ZHBhLT52cmluZ1tpXS5pcnEpOwo+
IEludGVyZXN0aW5nbHksIHdlIGRvbid0IGRvIHRoaXMgaW4gdmlydGlvX3BjaV9jb21tb24uYyBh
bmQgd2Ugb25seQo+IHN5bmNocm9uaXplIGR1cmluZyByZXNldCB0aGVyZS4KPgo+IEFueSByZWFz
b24gbWFrZXMgdnBfdmRwYSBkaWZmZXJlbnQ/CkFzIE1pY2hhZWwgcG9pbnQgb3V0LCBmcmVlX2ly
cSBjYWxscyBzeW5jaHJvbml6ZV9pcnEgaW50ZXJuYWxseS4KQW5kIHRoaXMgdnBfdmRwYV9mcmVl
IGlycSBpcyBjYWxsZWQgaW4gdGhlIHJlc2V0IHJvdXRpbmUuClNvIEkgdGhpbmsgd2UgZG9uJ3Qg
bmVlZCB0byBzeW5jIGl0IGhlcmUuCj4KPiBUaGFua3MKPgo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgZGV2bV9mcmVlX2lycSgmcGRldi0+ZGV2LCB2cF92ZHBhLT52cmluZ1tpXS5pcnEsCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ2cF92ZHBhLT52cmluZ1tp
XSk7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICB2cF92ZHBhLT52cmluZ1tpXS5pcnEgPSBW
SVJUSU9fTVNJX05PX1ZFQ1RPUjsKPj4gQEAgLTEyNCw2ICsxMjUsNyBAQCBzdGF0aWMgdm9pZCB2
cF92ZHBhX2ZyZWVfaXJxKHN0cnVjdCB2cF92ZHBhICp2cF92ZHBhKQo+Pgo+PiAgICAgICAgICBp
ZiAodnBfdmRwYS0+Y29uZmlnX2lycSAhPSBWSVJUSU9fTVNJX05PX1ZFQ1RPUikgewo+PiAgICAg
ICAgICAgICAgICAgIHZwX21vZGVybl9jb25maWdfdmVjdG9yKG1kZXYsIFZJUlRJT19NU0lfTk9f
VkVDVE9SKTsKPj4gKyAgICAgICAgICAgICAgIHN5bmNocm9uaXplX2lycSh2cF92ZHBhLT5jb25m
aWdfaXJxKTsKPj4gICAgICAgICAgICAgICAgICBkZXZtX2ZyZWVfaXJxKCZwZGV2LT5kZXYsIHZw
X3ZkcGEtPmNvbmZpZ19pcnEsIHZwX3ZkcGEpOwo+PiAgICAgICAgICAgICAgICAgIHZwX3ZkcGEt
PmNvbmZpZ19pcnEgPSBWSVJUSU9fTVNJX05PX1ZFQ1RPUjsKPj4gICAgICAgICAgfQo+PiAtLQo+
PiAyLjM5LjMKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
