Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C66EB64DC
	for <virtualization@archiver.kernel.org>; Mon, 10 Jul 2023 03:05:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0917F4098A;
	Mon, 10 Jul 2023 03:05:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0917F4098A
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=abgrwgOd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 55OiFw1eTHzg; Mon, 10 Jul 2023 03:04:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D8A8840911;
	Mon, 10 Jul 2023 03:04:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D8A8840911
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9D234C0071;
	Mon, 10 Jul 2023 03:04:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF59C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5407C40111
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:04:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5407C40111
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=abgrwgOd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Htd-zsk19uiR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:04:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C6D0400EA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4C6D0400EA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688958292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxjOs7/F2ykf+m07k9EWu1+E7xvxWLp6lvjndYFVYtE=;
 b=abgrwgOd6Xs8xyihNDH5yiHBUACAjV2+4R0H+ts7LW0MoKpD2i9CG/h4Z78ouiLp1vKrmW
 z3GO2OKdpuYz49mcEiy4XagCxCKokvZpO9dsKYAhrvgJYMTebEn5WBgpDEjLl8hEJZTUFm
 7DRevXXghVxpG99zYbVeqMg4bs0ghF8=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-s8WecjjqOhmM7ObfyciTVg-1; Sun, 09 Jul 2023 23:04:48 -0400
X-MC-Unique: s8WecjjqOhmM7ObfyciTVg-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b6f0527454so33476191fa.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jul 2023 20:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688958287; x=1691550287;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxjOs7/F2ykf+m07k9EWu1+E7xvxWLp6lvjndYFVYtE=;
 b=X7GthgBugFkeJNGOgW/eJAr94Opr1Xo6frux1dvMTEuhbATeCn84H26Ux8NtQoaMHV
 mDK9qHQZtPROPU/PJlZB0445XwOoPEr8yjsegdOvCXGGGQxOCAnDg8J5K4IUo5bzgQgM
 UxgW4i/q7l982mM/rKTmd3jhC/givn6Yuf7YihiARSC5eJBEto2oLABX2BQCS63CMjS9
 +7uO7xrCX1jHrhkoF+9fGOiCOX2B0jW7ZsEZSfZUxy3Yk7cwgDwirP4zjU8Ti6zvH7eU
 d7x939kjHwpkMLg22WrzJI3Hh5YtQTJ7eomzYNEIvYyrwUoO+Y3HP27JygAhHOsU0JyB
 xqxQ==
X-Gm-Message-State: ABy/qLa8B55+egKk0Y0taB8eM4JE6+gMWhfMRamBr5X/M2I/86jnagfT
 NEC7/ihtU41Ts70C7E0LpsFBsDpmlbW0cyMbsZqyiM1TgeROkwqtxuKlb0h0v0nJ99s4SOiwGp6
 RV9LQtfY0qylhG9WwvrVMDps0VRcjEpiC87jmHsJ3gjoSHlSZhikf1UsHCw==
X-Received: by 2002:a2e:8611:0:b0:2b6:daa3:f0af with SMTP id
 a17-20020a2e8611000000b002b6daa3f0afmr8680398lji.25.1688958287191; 
 Sun, 09 Jul 2023 20:04:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHEGVvoR8gVnhH73Hli5jfY/rNYMh3k0RWDca6Em62XjPIJAIwze5KX/2gY2cCAHHk0KtIToNvZe+bhl4Ac3v8=
X-Received: by 2002:a2e:8611:0:b0:2b6:daa3:f0af with SMTP id
 a17-20020a2e8611000000b002b6daa3f0afmr8680390lji.25.1688958286904; Sun, 09
 Jul 2023 20:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230630003609.28527-1-shannon.nelson@amd.com>
 <20230630003609.28527-2-shannon.nelson@amd.com>
 <CACGkMEthwPRtawkpJMZ5o+H=pOxGszaxOsmKuRH4LkPXrfzRoA@mail.gmail.com>
 <92b6697b-4d33-457d-b9b5-ec16926cd9fa@amd.com>
In-Reply-To: <92b6697b-4d33-457d-b9b5-ec16926cd9fa@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 10 Jul 2023 11:04:36 +0800
Message-ID: <CACGkMEtyJajf=xTmna66CbxxaYVXmeo5+dyw__wqrB=EwfdeqQ@mail.gmail.com>
Subject: Re: [PATCH virtio 1/4] pds_vdpa: reset to vdpa specified mac
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, Allen Hubbe <allen.hubbe@amd.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

T24gU2F0LCBKdWwgOCwgMjAyMyBhdCA0OjEy4oCvQU0gU2hhbm5vbiBOZWxzb24gPHNoYW5ub24u
bmVsc29uQGFtZC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDcvNy8yMyAxMjozMyBBTSwgSmFzb24g
V2FuZyB3cm90ZToKPiA+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4g
RXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1l
bnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4KPiA+Cj4gPgo+ID4gT24gRnJpLCBK
dW4gMzAsIDIwMjMgYXQgODozNuKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBh
bWQuY29tPiB3cm90ZToKPiA+Pgo+ID4+IEZyb206IEFsbGVuIEh1YmJlIDxhbGxlbi5odWJiZUBh
bWQuY29tPgo+ID4+Cj4gPj4gV2hlbiB0aGUgdmRwYSBkZXZpY2UgaXMgcmVzZXQsIGFsc28gcmVp
bml0aWFsaXplIGl0IHdpdGggdGhlIG1hYyBhZGRyZXNzCj4gPj4gdGhhdCB3YXMgYXNzaWduZWQg
d2hlbiB0aGUgZGV2aWNlIHdhcyBhZGRlZC4KPiA+Pgo+ID4+IEZpeGVzOiAxNTFjYzgzNGYzZGQg
KCJwZHNfdmRwYTogYWRkIHN1cHBvcnQgZm9yIHZkcGEgYW5kIHZkcGFtZ210IGludGVyZmFjZXMi
KQo+ID4+IFNpZ25lZC1vZmYtYnk6IEFsbGVuIEh1YmJlIDxhbGxlbi5odWJiZUBhbWQuY29tPgo+
ID4+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQuY29t
Pgo+ID4+IFJldmlld2VkLWJ5OiBCcmV0dCBDcmVlbGV5IDxicmV0dC5jcmVlbGV5QGFtZC5jb20+
Cj4gPj4gLS0tCj4gPj4gICBkcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgfCAxNiArKysrKysr
Ky0tLS0tLS0tCj4gPj4gICBkcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmggfCAgMSArCj4gPj4g
ICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiA+Pgo+
ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMgYi9kcml2ZXJzL3Zk
cGEvcGRzL3ZkcGFfZGV2LmMKPiA+PiBpbmRleCA1MDcxYTRkNThmOGQuLmUyZTk5YmIwYmUyYiAx
MDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPiA+PiArKysgYi9k
cml2ZXJzL3ZkcGEvcGRzL3ZkcGFfZGV2LmMKPiA+PiBAQCAtNDA5LDYgKzQwOSw4IEBAIHN0YXRp
YyB2b2lkIHBkc192ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2Rldiwg
dTggc3RhdHVzKQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICBwZHN2LT52cXNbaV0uYXZh
aWxfaWR4ID0gMDsKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgcGRzdi0+dnFzW2ldLnVz
ZWRfaWR4ID0gMDsKPiA+PiAgICAgICAgICAgICAgICAgIH0KPiA+PiArCj4gPj4gKyAgICAgICAg
ICAgICAgIHBkc192ZHBhX2NtZF9zZXRfbWFjKHBkc3YsIHBkc3YtPm1hYyk7Cj4gPgo+ID4gU28g
dGhpcyBpcyBub3QgbmVjZXNzYXJpbHkgY2FsbGVkIGR1cmluZyByZXNldC4gU28gSSB0aGluayB3
ZSBuZWVkIHRvCj4gPiBtb3ZlIGl0IHRvIHBkc192ZHBhX3Jlc2V0KCk/Cj4KPiBwZHNfdmRwYV9y
ZXNldCgpIGNhbGxzIHBkc192ZHBhX3NldF9zdGF0dXMoKSB3aXRoIGEgc3RhdHVzPTAsIHNvIHRo
aXMgaXMKPiBhbHJlYWR5IGNvdmVyZWQuCgpZZXMsIGJ1dCBwZHNfdmRwYV9zZXRfc3RhdHVzKCkg
d2lsbCBiZSBjYWxsZWQgd2hlbiBzdGF0dXMgaXMgbm90IHplcm8/CgpUaGFua3MKCj4KPiBzbG4K
Pgo+ID4KPiA+IFRoZSByZXN0IGxvb2tzIGdvb2QuCj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4+ICAg
ICAgICAgIH0KPiA+Pgo+ID4+ICAgICAgICAgIGlmIChzdGF0dXMgJiB+b2xkX3N0YXR1cyAmIFZJ
UlRJT19DT05GSUdfU19GRUFUVVJFU19PSykgewo+ID4+IEBAIC01MzIsNyArNTM0LDYgQEAgc3Rh
dGljIGludCBwZHNfdmRwYV9kZXZfYWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICptZGV2LCBjb25z
dCBjaGFyICpuYW1lLAo+ID4+ICAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRtYV9kZXY7Cj4gPj4g
ICAgICAgICAgc3RydWN0IHBjaV9kZXYgKnBkZXY7Cj4gPj4gICAgICAgICAgc3RydWN0IGRldmlj
ZSAqZGV2Owo+ID4+IC0gICAgICAgdTggbWFjW0VUSF9BTEVOXTsKPiA+PiAgICAgICAgICBpbnQg
ZXJyOwo+ID4+ICAgICAgICAgIGludCBpOwo+ID4+Cj4gPj4gQEAgLTYxNywxOSArNjE4LDE4IEBA
IHN0YXRpYyBpbnQgcGRzX3ZkcGFfZGV2X2FkZChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqbWRldiwg
Y29uc3QgY2hhciAqbmFtZSwKPiA+PiAgICAgICAgICAgKiBvciBzZXQgYSByYW5kb20gbWFjIGlm
IGRlZmF1bHQgaXMgMDA6Li46MDAKPiA+PiAgICAgICAgICAgKi8KPiA+PiAgICAgICAgICBpZiAo
YWRkX2NvbmZpZy0+bWFzayAmIEJJVF9VTEwoVkRQQV9BVFRSX0RFVl9ORVRfQ0ZHX01BQ0FERFIp
KSB7Cj4gPj4gLSAgICAgICAgICAgICAgIGV0aGVyX2FkZHJfY29weShtYWMsIGFkZF9jb25maWct
Pm5ldC5tYWMpOwo+ID4+IC0gICAgICAgICAgICAgICBwZHNfdmRwYV9jbWRfc2V0X21hYyhwZHN2
LCBtYWMpOwo+ID4+ICsgICAgICAgICAgICAgICBldGhlcl9hZGRyX2NvcHkocGRzdi0+bWFjLCBh
ZGRfY29uZmlnLT5uZXQubWFjKTsKPiA+PiAgICAgICAgICB9IGVsc2Ugewo+ID4+ICAgICAgICAg
ICAgICAgICAgc3RydWN0IHZpcnRpb19uZXRfY29uZmlnIF9faW9tZW0gKnZjOwo+ID4+Cj4gPj4g
ICAgICAgICAgICAgICAgICB2YyA9IHBkc3YtPnZkcGFfYXV4LT52ZF9tZGV2LmRldmljZTsKPiA+
PiAtICAgICAgICAgICAgICAgbWVtY3B5X2Zyb21pbyhtYWMsIHZjLT5tYWMsIHNpemVvZihtYWMp
KTsKPiA+PiAtICAgICAgICAgICAgICAgaWYgKGlzX3plcm9fZXRoZXJfYWRkcihtYWMpKSB7Cj4g
Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgZXRoX3JhbmRvbV9hZGRyKG1hYyk7Cj4gPj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgZGV2X2luZm8oZGV2LCAic2V0dGluZyByYW5kb20gbWFjICVw
TVxuIiwgbWFjKTsKPiA+PiAtICAgICAgICAgICAgICAgICAgICAgICBwZHNfdmRwYV9jbWRfc2V0
X21hYyhwZHN2LCBtYWMpOwo+ID4+ICsgICAgICAgICAgICAgICBtZW1jcHlfZnJvbWlvKHBkc3Yt
Pm1hYywgdmMtPm1hYywgc2l6ZW9mKHBkc3YtPm1hYykpOwo+ID4+ICsgICAgICAgICAgICAgICBp
ZiAoaXNfemVyb19ldGhlcl9hZGRyKHBkc3YtPm1hYykpIHsKPiA+PiArICAgICAgICAgICAgICAg
ICAgICAgICBldGhfcmFuZG9tX2FkZHIocGRzdi0+bWFjKTsKPiA+PiArICAgICAgICAgICAgICAg
ICAgICAgICBkZXZfaW5mbyhkZXYsICJzZXR0aW5nIHJhbmRvbSBtYWMgJXBNXG4iLCBwZHN2LT5t
YWMpOwo+ID4+ICAgICAgICAgICAgICAgICAgfQo+ID4+ICAgICAgICAgIH0KPiA+PiArICAgICAg
IHBkc192ZHBhX2NtZF9zZXRfbWFjKHBkc3YsIHBkc3YtPm1hYyk7Cj4gPj4KPiA+PiAgICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgcGRzdi0+bnVtX3ZxczsgaSsrKSB7Cj4gPj4gICAgICAgICAgICAg
ICAgICBwZHN2LT52cXNbaV0ucWlkID0gaTsKPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L3Bkcy92ZHBhX2Rldi5oIGIvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5oCj4gPj4gaW5kZXgg
YTFiYzM3ZGU5NTM3Li5jZjAyZGYyODdmYzQgMTAwNjQ0Cj4gPj4gLS0tIGEvZHJpdmVycy92ZHBh
L3Bkcy92ZHBhX2Rldi5oCj4gPj4gKysrIGIvZHJpdmVycy92ZHBhL3Bkcy92ZHBhX2Rldi5oCj4g
Pj4gQEAgLTM5LDYgKzM5LDcgQEAgc3RydWN0IHBkc192ZHBhX2RldmljZSB7Cj4gPj4gICAgICAg
ICAgdTY0IHJlcV9mZWF0dXJlczsgICAgICAgICAgICAgICAvKiBmZWF0dXJlcyByZXF1ZXN0ZWQg
YnkgdmRwYSAqLwo+ID4+ICAgICAgICAgIHU4IHZkcGFfaW5kZXg7ICAgICAgICAgICAgICAgICAg
LyogcnN2ZCBmb3IgZnV0dXJlIHN1YmRldmljZSB1c2UgKi8KPiA+PiAgICAgICAgICB1OCBudW1f
dnFzOyAgICAgICAgICAgICAgICAgICAgIC8qIG51bSB2cXMgaW4gdXNlICovCj4gPj4gKyAgICAg
ICB1OCBtYWNbRVRIX0FMRU5dOyAgICAgICAgICAgICAgIC8qIG1hYyBzZWxlY3RlZCB3aGVuIHRo
ZSBkZXZpY2Ugd2FzIGFkZGVkICovCj4gPj4gICAgICAgICAgc3RydWN0IHZkcGFfY2FsbGJhY2sg
Y29uZmlnX2NiOwo+ID4+ICAgICAgICAgIHN0cnVjdCBub3RpZmllcl9ibG9jayBuYjsKPiA+PiAg
IH07Cj4gPj4gLS0KPiA+PiAyLjE3LjEKPiA+Pgo+ID4KPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
