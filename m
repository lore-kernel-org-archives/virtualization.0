Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3352C433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 02:41:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC9E64E3F
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 02:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC9E64E3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DEA982EDB;
	Tue, 23 Feb 2021 02:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TxL8JcDOqihP; Tue, 23 Feb 2021 02:41:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4903B82EBA;
	Tue, 23 Feb 2021 02:41:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2548DC000B;
	Tue, 23 Feb 2021 02:41:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2089C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:40:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A672B87016
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:40:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMFEO8tW6+EW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:40:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A3F098700C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 02:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614048056;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zPDpbJNZdQ9hi/5YT6ebJh2aTRbwiJFCyJYts7Zasc=;
 b=FVpeH/QwP1UuCH6TVrC9k+CBOJi4FcHebsRxTVQ5xpz1p8QRNbtzkNV7Qw6KKofxGMqw0h
 FpteocaN8fEobMCeQPI09uBU2ZGMlUbOds1OsYeWO+QlnhuDVU4T4zCkuIDGopK+dE2FFs
 ZbxnFSSKOXEm3qwRW93TW4Zsbg8QmC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-WEOsLhA2PXChyEjD8HQpQQ-1; Mon, 22 Feb 2021 21:40:54 -0500
X-MC-Unique: WEOsLhA2PXChyEjD8HQpQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD3991868405;
 Tue, 23 Feb 2021 02:40:52 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-175.pek2.redhat.com
 [10.72.13.175])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 283F75D74F;
 Tue, 23 Feb 2021 02:40:46 +0000 (UTC)
Subject: Re: [PATCH 2/2 v1] vdpa/mlx5: Enable user to add/delete vdpa device
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, si-wei.liu@oracle.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
References: <20210217113136.10215-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ffee8558-e34f-310d-39a1-36b6615f9a92@redhat.com>
Date: Tue, 23 Feb 2021 10:40:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210217113136.10215-1-elic@nvidia.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjEvMi8xNyA3OjMxIOS4i+WNiCwgRWxpIENvaGVuIHdyb3RlOgo+IEFsbG93IHRvIGNv
bnRyb2wgdmRwYSBkZXZpY2UgY3JlYXRpb24gYW5kIGRlc3RydWN0aW9uIHVzaW5nIHRoZSB2ZHBh
Cj4gbWFuYWdlbWVudCB0b29sLgo+Cj4gRXhhbXBsZXM6Cj4gMS4gTGlzdCB0aGUgbWFuYWdlbWVu
dCBkZXZpY2VzCj4gJCB2ZHBhIG1nbXRkZXYgc2hvdwo+IHBjaS8wMDAwOjNiOjAwLjE6Cj4gICAg
c3VwcG9ydGVkX2NsYXNzZXMgbmV0Cj4KPiAyLiBDcmVhdGUgdmRwYSBpbnN0YW5jZQo+ICQgdmRw
YSBkZXYgYWRkIG1nbXRkZXYgcGNpLzAwMDA6M2I6MDAuMSBuYW1lIHZkcGEwCj4KPiAzLiBTaG93
IHZkcGEgZGV2aWNlcwo+ICQgdmRwYSBkZXYgc2hvdwo+IHZkcGEwOiB0eXBlIG5ldHdvcmsgbWdt
dGRldiBwY2kvMDAwMDozYjowMC4xIHZlbmRvcl9pZCA1NTU1IG1heF92cXMgMTYgXAo+IG1heF92
cV9zaXplIDI1Ngo+Cj4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+
Cj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4KCgpBY2tlZC1i
eTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+IHYwLT52MToKPiBz
ZXQgbWd0ZGV2LT5uZGV2IE5VTEwgb24gZGV2IGRlbGV0ZQo+Cj4gICBkcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMgfCA3OSArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4g
ICAxIGZpbGUgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCBhNTFiMGY4NmFmZTIuLjA4ZmI0ODFkZGM0
ZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtMTk3NCwyMyArMTk3NCwz
MiBAQCBzdGF0aWMgdm9pZCBpbml0X212cXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4g
ICAJfQo+ICAgfQo+ICAgCj4gLXN0YXRpYyBpbnQgbWx4NXZfcHJvYmUoc3RydWN0IGF1eGlsaWFy
eV9kZXZpY2UgKmFkZXYsCj4gLQkJICAgICAgIGNvbnN0IHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNl
X2lkICppZCkKPiArc3RydWN0IG1seDVfdmRwYV9tZ210ZGV2IHsKPiArCXN0cnVjdCB2ZHBhX21n
bXRfZGV2IG1ndGRldjsKPiArCXN0cnVjdCBtbHg1X2FkZXYgKm1hZGV2Owo+ICsJc3RydWN0IG1s
eDVfdmRwYV9uZXQgKm5kZXY7Cj4gK307Cj4gKwo+ICtzdGF0aWMgaW50IG1seDVfdmRwYV9kZXZf
YWRkKHN0cnVjdCB2ZHBhX21nbXRfZGV2ICp2X21kZXYsIGNvbnN0IGNoYXIgKm5hbWUpCj4gICB7
Cj4gLQlzdHJ1Y3QgbWx4NV9hZGV2ICptYWRldiA9IGNvbnRhaW5lcl9vZihhZGV2LCBzdHJ1Y3Qg
bWx4NV9hZGV2LCBhZGV2KTsKPiAtCXN0cnVjdCBtbHg1X2NvcmVfZGV2ICptZGV2ID0gbWFkZXYt
Pm1kZXY7Cj4gKwlzdHJ1Y3QgbWx4NV92ZHBhX21nbXRkZXYgKm1ndGRldiA9IGNvbnRhaW5lcl9v
Zih2X21kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfbWdtdGRldiwgbWd0ZGV2KTsKPiAgIAlzdHJ1Y3Qg
dmlydGlvX25ldF9jb25maWcgKmNvbmZpZzsKPiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXY7Cj4gICAJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXY7Cj4gKwlzdHJ1Y3QgbWx4NV9jb3Jl
X2RldiAqbWRldjsKPiAgIAl1MzIgbWF4X3ZxczsKPiAgIAlpbnQgZXJyOwo+ICAgCj4gKwlpZiAo
bWd0ZGV2LT5uZGV2KQo+ICsJCXJldHVybiAtRU5PU1BDOwo+ICsKPiArCW1kZXYgPSBtZ3RkZXYt
Pm1hZGV2LT5tZGV2Owo+ICAgCS8qIHdlIHNhdmUgb25lIHZpcnRxdWV1ZSBmb3IgY29udHJvbCB2
aXJ0cXVldWUgc2hvdWxkIHdlIHJlcXVpcmUgaXQgKi8KPiAgIAltYXhfdnFzID0gTUxYNV9DQVBf
REVWX1ZEUEFfRU1VTEFUSU9OKG1kZXYsIG1heF9udW1fdmlydGlvX3F1ZXVlcyk7Cj4gICAJbWF4
X3ZxcyA9IG1pbl90KHUzMiwgbWF4X3ZxcywgTUxYNV9NQVhfU1VQUE9SVEVEX1ZRUyk7Cj4gICAK
PiAgIAluZGV2ID0gdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IG1seDVfdmRwYV9uZXQsIG12ZGV2
LnZkZXYsIG1kZXYtPmRldmljZSwgJm1seDVfdmRwYV9vcHMsCj4gLQkJCQkgMiAqIG1seDVfdmRw
YV9tYXhfcXBzKG1heF92cXMpLCBOVUxMKTsKPiArCQkJCSAyICogbWx4NV92ZHBhX21heF9xcHMo
bWF4X3ZxcyksIG5hbWUpOwo+ICAgCWlmIChJU19FUlIobmRldikpCj4gICAJCXJldHVybiBQVFJf
RVJSKG5kZXYpOwo+ICAgCj4gQEAgLTIwMTgsMTEgKzIwMjcsMTIgQEAgc3RhdGljIGludCBtbHg1
dl9wcm9iZShzdHJ1Y3QgYXV4aWxpYXJ5X2RldmljZSAqYWRldiwKPiAgIAlpZiAoZXJyKQo+ICAg
CQlnb3RvIGVycl9yZXM7Cj4gICAKPiAtCWVyciA9IHZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZtdmRl
di0+dmRldik7Cj4gKwltdmRldi0+dmRldi5tZGV2ID0gJm1ndGRldi0+bWd0ZGV2Owo+ICsJZXJy
ID0gX3ZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZtdmRldi0+dmRldik7Cj4gICAJaWYgKGVycikKPiAg
IAkJZ290byBlcnJfcmVnOwo+ICAgCj4gLQlkZXZfc2V0X2RydmRhdGEoJmFkZXYtPmRldiwgbmRl
dik7Cj4gKwltZ3RkZXYtPm5kZXYgPSBuZGV2Owo+ICAgCXJldHVybiAwOwo+ICAgCj4gICBlcnJf
cmVnOgo+IEBAIC0yMDM1LDExICsyMDQ1LDYyIEBAIHN0YXRpYyBpbnQgbWx4NXZfcHJvYmUoc3Ry
dWN0IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXYsCj4gICAJcmV0dXJuIGVycjsKPiAgIH0KPiAgIAo+
ICtzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZGV2X2RlbChzdHJ1Y3QgdmRwYV9tZ210X2RldiAqdl9t
ZGV2LCBzdHJ1Y3QgdmRwYV9kZXZpY2UgKmRldikKPiArewo+ICsJc3RydWN0IG1seDVfdmRwYV9t
Z210ZGV2ICptZ3RkZXYgPSBjb250YWluZXJfb2Yodl9tZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX21n
bXRkZXYsIG1ndGRldik7Cj4gKwo+ICsJX3ZkcGFfdW5yZWdpc3Rlcl9kZXZpY2UoZGV2KTsKPiAr
CW1ndGRldi0+bmRldiA9IE5VTEw7Cj4gK30KPiArCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgdmRw
YV9tZ210ZGV2X29wcyBtZGV2X29wcyA9IHsKPiArCS5kZXZfYWRkID0gbWx4NV92ZHBhX2Rldl9h
ZGQsCj4gKwkuZGV2X2RlbCA9IG1seDVfdmRwYV9kZXZfZGVsLAo+ICt9Owo+ICsKPiArc3RhdGlj
IHN0cnVjdCB2aXJ0aW9fZGV2aWNlX2lkIGlkX3RhYmxlW10gPSB7Cj4gKwl7IFZJUlRJT19JRF9O
RVQsIFZJUlRJT19ERVZfQU5ZX0lEIH0sCj4gKwl7IDAgfSwKPiArfTsKPiArCj4gK3N0YXRpYyBp
bnQgbWx4NXZfcHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2UgKmFkZXYsCj4gKwkJICAgICAg
IGNvbnN0IHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlX2lkICppZCkKPiArCj4gK3sKPiArCXN0cnVj
dCBtbHg1X2FkZXYgKm1hZGV2ID0gY29udGFpbmVyX29mKGFkZXYsIHN0cnVjdCBtbHg1X2FkZXYs
IGFkZXYpOwo+ICsJc3RydWN0IG1seDVfY29yZV9kZXYgKm1kZXYgPSBtYWRldi0+bWRldjsKPiAr
CXN0cnVjdCBtbHg1X3ZkcGFfbWdtdGRldiAqbWd0ZGV2Owo+ICsJaW50IGVycjsKPiArCj4gKwlt
Z3RkZXYgPSBremFsbG9jKHNpemVvZigqbWd0ZGV2KSwgR0ZQX0tFUk5FTCk7Cj4gKwlpZiAoIW1n
dGRldikKPiArCQlyZXR1cm4gLUVOT01FTTsKPiArCj4gKwltZ3RkZXYtPm1ndGRldi5vcHMgPSAm
bWRldl9vcHM7Cj4gKwltZ3RkZXYtPm1ndGRldi5kZXZpY2UgPSBtZGV2LT5kZXZpY2U7Cj4gKwlt
Z3RkZXYtPm1ndGRldi5pZF90YWJsZSA9IGlkX3RhYmxlOwo+ICsJbWd0ZGV2LT5tYWRldiA9IG1h
ZGV2Owo+ICsKPiArCWVyciA9IHZkcGFfbWdtdGRldl9yZWdpc3RlcigmbWd0ZGV2LT5tZ3RkZXYp
Owo+ICsJaWYgKGVycikKPiArCQlnb3RvIHJlZ19lcnI7Cj4gKwo+ICsJZGV2X3NldF9kcnZkYXRh
KCZhZGV2LT5kZXYsIG1ndGRldik7Cj4gKwo+ICsJcmV0dXJuIDA7Cj4gKwo+ICtyZWdfZXJyOgo+
ICsJa2ZyZWUobWRldik7Cj4gKwlyZXR1cm4gZXJyOwo+ICt9Cj4gKwo+ICAgc3RhdGljIHZvaWQg
bWx4NXZfcmVtb3ZlKHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlICphZGV2KQo+ICAgewo+IC0Jc3Ry
dWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2ID0gZGV2X2dldF9kcnZkYXRhKCZhZGV2LT5kZXYpOwo+
ICsJc3RydWN0IG1seDVfdmRwYV9tZ210ZGV2ICptZ3RkZXY7Cj4gICAKPiAtCXZkcGFfdW5yZWdp
c3Rlcl9kZXZpY2UoJm12ZGV2LT52ZGV2KTsKPiArCW1ndGRldiA9IGRldl9nZXRfZHJ2ZGF0YSgm
YWRldi0+ZGV2KTsKPiArCXZkcGFfbWdtdGRldl91bnJlZ2lzdGVyKCZtZ3RkZXYtPm1ndGRldik7
Cj4gKwlrZnJlZShtZ3RkZXYpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGF1
eGlsaWFyeV9kZXZpY2VfaWQgbWx4NXZfaWRfdGFibGVbXSA9IHsKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
