Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F23C433F5
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:07:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3845604DC
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 07:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E3845604DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4519403A9;
	Mon, 25 Oct 2021 07:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fC3MvNS78f56; Mon, 25 Oct 2021 07:07:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 52DC7403A8;
	Mon, 25 Oct 2021 07:07:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C3BBC0012;
	Mon, 25 Oct 2021 07:07:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 336D1C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13EC1403A9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BJzVEIrF32ee
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:07:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4FB8F403A8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635145628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEjO2FjxQ8ExiPhsFTKwMLa3sw18WtMh2h53u71UA0I=;
 b=ETBVOXAa7DBsgJdwo4d5EGPYgyT20k+iwINQT4dH6RdvyO3Wo6YRTVlS/IxGvciFFAw/PT
 PFqxyJxTzbWdEv6TeaqWhmvtJawt/RHw3sDCprmbldo3tG7rmoTnHOceNkw4PY3Y24YvTZ
 YldPHIi1jWk9X2Rvm7i8wiDVB6W/9ms=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-RIRimYpLMLOuqibuWHf7Rg-1; Mon, 25 Oct 2021 03:07:07 -0400
X-MC-Unique: RIRimYpLMLOuqibuWHf7Rg-1
Received: by mail-pg1-f200.google.com with SMTP id
 t75-20020a63784e000000b002993a9284b0so5795108pgc.11
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 00:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=VEjO2FjxQ8ExiPhsFTKwMLa3sw18WtMh2h53u71UA0I=;
 b=xS/KFEOWYWvdsepgobSz1CxyF5Mc3UveZb3etGC9lPngcCIxuxJS7zCgu1rIx8kPP8
 MRN2P8CAW9D4hpBVDjXEEEMhqZhJuhPJVqDZ2xyEExIrzPL2oHTYELFo2XCeX3hXkm9r
 5Q7ZzILf9hcXym3tYWM5/MHl4DRRreEpIyhNb2Z4bn6MH1LkZpxjDV3AopFyxJ6fnGMt
 EdSeIH3eHKJqt9z4llXHdCFbuCKvJDSpXE0exiCTRqy0OjbsLsEC71Z0tlEFbOjGtpqU
 m8l6lAS0AVCpdJoPbAaGsfA9bl1RHvCrgIx4y1+m9dEjoaIaaUrYCvFie3MQStDGW6o6
 SD9Q==
X-Gm-Message-State: AOAM531CvQlDT4nNZQbN8gWdk5gKlxdwbX30YJccQRFB0Jx1xXFe1zVS
 jRnReG/AyOJgfU0+Ve9Qup1Z29drZ4ZpaNAToERezukX8xHi72hCiCmZzVRi+6NimDRClAXQQHq
 W87Rx4gNt3w6CPeRbE754Z4dLbqZkXq+sALrdJnLJ+A==
X-Received: by 2002:a17:90a:fe8a:: with SMTP id
 co10mr14443971pjb.183.1635145625904; 
 Mon, 25 Oct 2021 00:07:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI1Nkm4+3HJoRs7Is/zDalLpA0jmPxsRhnV4oVo49b0hme2m1LDHt0eJvUPVWueGtarSsqoA==
X-Received: by 2002:a17:90a:fe8a:: with SMTP id
 co10mr14443943pjb.183.1635145625665; 
 Mon, 25 Oct 2021 00:07:05 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id om5sm17490042pjb.36.2021.10.25.00.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Oct 2021 00:07:05 -0700 (PDT)
Subject: Re: [PATCH linux-next v4 7/8] vdpa/mlx5: Support configuration of MAC
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-8-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <559946af-0990-a6da-00ec-3e1872f19e63@redhat.com>
Date: Mon, 25 Oct 2021 15:07:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021163509.6978-8-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: elic@nvidia.com, mst@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMTAvMjIgyc/O5zEyOjM1LCBQYXJhdiBQYW5kaXQg0LS1wDoKPiBGcm9tOiBFbGkg
Q29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPgo+IEFkZCBjb2RlIHRvIGFjY2VwdCBNQUMgY29uZmln
dXJhdGlvbiB0aHJvdWdoIHZkcGEgdG9vbC4gVGhlIE1BQyBpcwo+IHdyaXR0ZW4gaW50byB0aGUg
Y29uZmlnIHN0cnVjdCBhbmQgbGF0ZXIgY2FuIGJlIHJldHJpZXZlZCB0aHJvdWdoCj4gZ2V0X2Nv
bmZpZygpLgo+Cj4gRXhhbXBsZXM6Cj4gMS4gQ29uZmlndXJlIE1BQyB3aGlsZSBhZGRpbmcgYSBk
ZXZpY2U6Cj4gJCB2ZHBhIGRldiBhZGQgbWdtdGRldiBwY2kvMDAwMDowNjowMC4yIG5hbWUgdmRw
YTAgbWFjIDAwOjExOjIyOjMzOjQ0OjU1Cj4KPiAyLiBTaG93IGNvbmZpZ3VyZWQgcGFyYW1zOgo+
ICQgdmRwYSBkZXYgY29uZmlnIHNob3cKPiB2ZHBhMDogbWFjIDAwOjExOjIyOjMzOjQ0OjU1IGxp
bmsgZG93biBsaW5rX2Fubm91bmNlIGZhbHNlIG1heF92cV9wYWlycyA4IG10dSAxNTAwCj4KPiBT
aWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTog
UGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxq
YXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMgfCAxMiArKysrKysrKystLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gaW5k
ZXggMGEyYjc5ODg3MDg1Li42MWYxN2NlMDg5MmUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCj4gQEAgLTYsNiArNiw3IEBACj4gICAjaW5jbHVkZSA8bGludXgvdnJpbmdoLmg+Cj4g
ICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0aW9fbmV0Lmg+Cj4gICAjaW5jbHVkZSA8dWFwaS9s
aW51eC92aXJ0aW9faWRzLmg+Cj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZkcGEuaD4KPiAgICNp
bmNsdWRlIDxsaW51eC92aXJ0aW9fY29uZmlnLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvYXV4aWxp
YXJ5X2J1cy5oPgo+ICAgI2luY2x1ZGUgPGxpbnV4L21seDUvY3EuaD4KPiBAQCAtMjQ0NCw5ICsy
NDQ1LDEzIEBAIHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9k
ZXYgKnZfbWRldiwgY29uc3QgY2hhciAqbmFtZSwKPiAgIAlpZiAoZXJyKQo+ICAgCQlnb3RvIGVy
cl9tdHU7Cj4gICAKPiAtCWVyciA9IG1seDVfcXVlcnlfbmljX3Zwb3J0X21hY19hZGRyZXNzKG1k
ZXYsIDAsIDAsIGNvbmZpZy0+bWFjKTsKPiAtCWlmIChlcnIpCj4gLQkJZ290byBlcnJfbXR1Owo+
ICsJaWYgKGFkZF9jb25maWctPm1hc2sgJiAoMSA8PCBWRFBBX0FUVFJfREVWX05FVF9DRkdfTUFD
QUREUikpIHsKPiArCQltZW1jcHkobmRldi0+Y29uZmlnLm1hYywgYWRkX2NvbmZpZy0+bmV0Lm1h
YywgRVRIX0FMRU4pOwo+ICsJfSBlbHNlIHsKPiArCQllcnIgPSBtbHg1X3F1ZXJ5X25pY192cG9y
dF9tYWNfYWRkcmVzcyhtZGV2LCAwLCAwLCBjb25maWctPm1hYyk7Cj4gKwkJaWYgKGVycikKPiAr
CQkJZ290byBlcnJfbXR1Owo+ICsJfQo+ICAgCj4gICAJaWYgKCFpc196ZXJvX2V0aGVyX2FkZHIo
Y29uZmlnLT5tYWMpKSB7Cj4gICAJCXBmbWRldiA9IHBjaV9nZXRfZHJ2ZGF0YShwY2lfcGh5c2Zu
KG1kZXYtPnBkZXYpKTsKPiBAQCAtMjU0MSw2ICsyNTQ2LDcgQEAgc3RhdGljIGludCBtbHg1dl9w
cm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldiwKPiAgIAltZ3RkZXYtPm1ndGRldi5v
cHMgPSAmbWRldl9vcHM7Cj4gICAJbWd0ZGV2LT5tZ3RkZXYuZGV2aWNlID0gbWRldi0+ZGV2aWNl
Owo+ICAgCW1ndGRldi0+bWd0ZGV2LmlkX3RhYmxlID0gaWRfdGFibGU7Cj4gKwltZ3RkZXYtPm1n
dGRldi5jb25maWdfYXR0cl9tYXNrID0gKDEgPDwgVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FE
RFIpOwo+ICAgCW1ndGRldi0+bWFkZXYgPSBtYWRldjsKPiAgIAo+ICAgCWVyciA9IHZkcGFfbWdt
dGRldl9yZWdpc3RlcigmbWd0ZGV2LT5tZ3RkZXYpOwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
