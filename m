Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5338C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:16:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C30A64DE1
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:16:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C30A64DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A83B8567A;
	Mon,  8 Feb 2021 04:16:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JwzYWhsHNWlF; Mon,  8 Feb 2021 04:16:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 591688561E;
	Mon,  8 Feb 2021 04:16:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30E04C0174;
	Mon,  8 Feb 2021 04:16:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71330C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:16:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6BFC786816
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:16:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4+-AJtavN7ix
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:16:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0F8C286804
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612757778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=163dsehELjqfTy3yraaw2TTJlJnhey0aJXrU0Gs1cr4=;
 b=HhM6iV2GPMK7Z/SPJP5Iddu63untBbhYooSBsBlhhxvE9QDwzAd3oiORqF5M0H++rUVvwj
 8W7EJJd+atZQKlmevUth4x9SLOvd5w4kP3HDhgTJt0UEBIgLoBFneVl3TZ3EnxXq5P+H81
 KOs/uGyLUTKve8BTdE9oZRWJTk0Tmic=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-nt6rwihRPW6qP0WZNp1Rbg-1; Sun, 07 Feb 2021 23:16:16 -0500
X-MC-Unique: nt6rwihRPW6qP0WZNp1Rbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A896A80197A;
 Mon,  8 Feb 2021 04:16:15 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EED1761D31;
 Mon,  8 Feb 2021 04:16:06 +0000 (UTC)
Subject: Re: [PATCH V3 17/19] vdpa: set the virtqueue num during register
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
 <20210104065503.199631-18-jasowang@redhat.com>
 <20210205102552-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d2c32306-d8f5-698e-b1f7-c382d3f4a29c@redhat.com>
Date: Mon, 8 Feb 2021 12:16:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205102552-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: shahafs@mellanox.com, lulu@redhat.com, rdunlap@infradead.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi81IOS4i+WNiDExOjI3LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gT24g
TW9uLCBKYW4gMDQsIDIwMjEgYXQgMDI6NTU6MDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gVGhpcyBwYXRjaCBkZWxheSB0aGUgcXVldWUgbnVtYmVyIHNldHRpbmcgdG8gdkRQQSBkZXZp
Y2UKPj4gcmVnaXN0ZXJpbmcuIFRoaXMgYWxsb3dzIHVzIHRvIHByb2JlIHRoZSB2aXJ0cXVldWUg
bnVtYmVycyBiZXR3ZWVuCj4+IGRldmljZSBhbGxvY2F0aW9uIGFuZCByZWdpc3RlcmluZy4KPj4K
Pj4gUmV2aWV3ZWQtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4K
Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiBDb25m
bGljdHMgd2l0aCBvdGhlciBwYXRjaGVzIGluIHRoZSB2aG9zdCB0cmVlLgo+IENhbiB5b3UgcmVi
YXNlIHBsZWFzZT8KCgpXaWxsIGRvLgoKVGhhbmtzCgoKPgo+PiAtLS0KPj4gICBkcml2ZXJzL3Zk
cGEvaWZjdmYvaWZjdmZfbWFpbi5jICAgfCA1ICsrLS0tCj4+ICAgZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jIHwgNSArKy0tLQo+PiAgIGRyaXZlcnMvdmRwYS92ZHBhLmMgICAgICAg
ICAgICAgICB8IDggKysrKy0tLS0KPj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
YyAgfCA0ICsrLS0KPj4gICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCAgICAgICAgICAgICAgfCA3ICsr
Ky0tLS0KPj4gICA1IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9u
cygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBi
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4gaW5kZXggOGI0MDI4NTU2Y2I2Li5k
NjVmMzIyMWQ4ZWQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWlu
LmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiBAQCAtNDM4LDgg
KzQzOCw3IEBAIHN0YXRpYyBpbnQgaWZjdmZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsIGNv
bnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPj4gICAJfQo+PiAgIAo+PiAgIAlhZGFwdGVy
ID0gdmRwYV9hbGxvY19kZXZpY2Uoc3RydWN0IGlmY3ZmX2FkYXB0ZXIsIHZkcGEsCj4+IC0JCQkJ
ICAgIGRldiwgJmlmY192ZHBhX29wcywKPj4gLQkJCQkgICAgSUZDVkZfTUFYX1FVRVVFX1BBSVJT
ICogMik7Cj4+ICsJCQkJICAgIGRldiwgJmlmY192ZHBhX29wcyk7Cj4+ICAgCWlmIChhZGFwdGVy
ID09IE5VTEwpIHsKPj4gICAJCUlGQ1ZGX0VSUihwZGV2LCAiRmFpbGVkIHRvIGFsbG9jYXRlIHZE
UEEgc3RydWN0dXJlIik7Cj4+ICAgCQlyZXR1cm4gLUVOT01FTTsKPj4gQEAgLTQ2Myw3ICs0NjIs
NyBAQCBzdGF0aWMgaW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBz
dHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4+ICAgCWZvciAoaSA9IDA7IGkgPCBJRkNWRl9NQVhf
UVVFVUVfUEFJUlMgKiAyOyBpKyspCj4+ICAgCQl2Zi0+dnJpbmdbaV0uaXJxID0gLUVJTlZBTDsK
Pj4gICAKPj4gLQlyZXQgPSB2ZHBhX3JlZ2lzdGVyX2RldmljZSgmYWRhcHRlci0+dmRwYSk7Cj4+
ICsJcmV0ID0gdmRwYV9yZWdpc3Rlcl9kZXZpY2UoJmFkYXB0ZXItPnZkcGEsIElGQ1ZGX01BWF9R
VUVVRV9QQUlSUyAqIDIpOwo+PiAgIAlpZiAocmV0KSB7Cj4+ICAgCQlJRkNWRl9FUlIocGRldiwg
IkZhaWxlZCB0byByZWdpc3RlciBpZmN2ZiB0byB2ZHBhIGJ1cyIpOwo+PiAgIAkJZ290byBlcnI7
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gaW5kZXggZjFkNTQ4MTRkYjk3Li5hMWI5
MjYwYmYwNGQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gQEAgLTE5NTgs
OCArMTk1OCw3IEBAIHN0YXRpYyBpbnQgbWx4NXZfcHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZp
Y2UgKmFkZXYsCj4+ICAgCW1heF92cXMgPSBNTFg1X0NBUF9ERVZfVkRQQV9FTVVMQVRJT04obWRl
diwgbWF4X251bV92aXJ0aW9fcXVldWVzKTsKPj4gICAJbWF4X3ZxcyA9IG1pbl90KHUzMiwgbWF4
X3ZxcywgTUxYNV9NQVhfU1VQUE9SVEVEX1ZRUyk7Cj4+ICAgCj4+IC0JbmRldiA9IHZkcGFfYWxs
b2NfZGV2aWNlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0LCBtdmRldi52ZGV2LCBtZGV2LT5kZXZpY2Us
ICZtbHg1X3ZkcGFfb3BzLAo+PiAtCQkJCSAyICogbWx4NV92ZHBhX21heF9xcHMobWF4X3Zxcykp
Owo+PiArCW5kZXYgPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCwgbXZk
ZXYudmRldiwgbWRldi0+ZGV2aWNlLCAmbWx4NV92ZHBhX29wcyk7Cj4+ICAgCWlmIChJU19FUlIo
bmRldikpCj4+ICAgCQlyZXR1cm4gUFRSX0VSUihuZGV2KTsKPj4gICAKPj4gQEAgLTE5ODYsNyAr
MTk4NSw3IEBAIHN0YXRpYyBpbnQgbWx4NXZfcHJvYmUoc3RydWN0IGF1eGlsaWFyeV9kZXZpY2Ug
KmFkZXYsCj4+ICAgCWlmIChlcnIpCj4+ICAgCQlnb3RvIGVycl9yZXM7Cj4+ICAgCj4+IC0JZXJy
ID0gdmRwYV9yZWdpc3Rlcl9kZXZpY2UoJm12ZGV2LT52ZGV2KTsKPj4gKwllcnIgPSB2ZHBhX3Jl
Z2lzdGVyX2RldmljZSgmbXZkZXYtPnZkZXYsIDIgKiBtbHg1X3ZkcGFfbWF4X3FwcyhtYXhfdnFz
KSk7Cj4+ICAgCWlmIChlcnIpCj4+ICAgCQlnb3RvIGVycl9yZWc7Cj4+ICAgCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+PiBpbmRleCBh
NjlmZmM5OTFlMTMuLmJhODkyMzhmOTg5OCAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL3Zk
cGEuYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+IEBAIC02MSw3ICs2MSw2IEBAIHN0
YXRpYyB2b2lkIHZkcGFfcmVsZWFzZV9kZXYoc3RydWN0IGRldmljZSAqZCkKPj4gICAgKiBpbml0
aWFsaXplZCBidXQgYmVmb3JlIHJlZ2lzdGVyZWQuCj4+ICAgICogQHBhcmVudDogdGhlIHBhcmVu
dCBkZXZpY2UKPj4gICAgKiBAY29uZmlnOiB0aGUgYnVzIG9wZXJhdGlvbnMgdGhhdCBpcyBzdXBw
b3J0ZWQgYnkgdGhpcyBkZXZpY2UKPj4gLSAqIEBudnFzOiBudW1iZXIgb2YgdmlydHF1ZXVlcyBz
dXBwb3J0ZWQgYnkgdGhpcyBkZXZpY2UKPj4gICAgKiBAc2l6ZTogc2l6ZSBvZiB0aGUgcGFyZW50
IHN0cnVjdHVyZSB0aGF0IGNvbnRhaW5zIHByaXZhdGUgZGF0YQo+PiAgICAqCj4+ICAgICogRHJp
dmVyIHNob3VsZCB1c2UgdmRwYV9hbGxvY19kZXZpY2UoKSB3cmFwcGVyIG1hY3JvIGluc3RlYWQg
b2YKPj4gQEAgLTcyLDcgKzcxLDYgQEAgc3RhdGljIHZvaWQgdmRwYV9yZWxlYXNlX2RldihzdHJ1
Y3QgZGV2aWNlICpkKQo+PiAgICAqLwo+PiAgIHN0cnVjdCB2ZHBhX2RldmljZSAqX192ZHBhX2Fs
bG9jX2RldmljZShzdHJ1Y3QgZGV2aWNlICpwYXJlbnQsCj4+ICAgCQkJCQljb25zdCBzdHJ1Y3Qg
dmRwYV9jb25maWdfb3BzICpjb25maWcsCj4+IC0JCQkJCWludCBudnFzLAo+PiAgIAkJCQkJc2l6
ZV90IHNpemUpCj4+ICAgewo+PiAgIAlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXY7Cj4+IEBAIC05
OSw3ICs5Nyw2IEBAIHN0cnVjdCB2ZHBhX2RldmljZSAqX192ZHBhX2FsbG9jX2RldmljZShzdHJ1
Y3QgZGV2aWNlICpwYXJlbnQsCj4+ICAgCXZkZXYtPmluZGV4ID0gZXJyOwo+PiAgIAl2ZGV2LT5j
b25maWcgPSBjb25maWc7Cj4+ICAgCXZkZXYtPmZlYXR1cmVzX3ZhbGlkID0gZmFsc2U7Cj4+IC0J
dmRldi0+bnZxcyA9IG52cXM7Cj4+ICAgCj4+ICAgCWVyciA9IGRldl9zZXRfbmFtZSgmdmRldi0+
ZGV2LCAidmRwYSV1IiwgdmRldi0+aW5kZXgpOwo+PiAgIAlpZiAoZXJyKQo+PiBAQCAtMTIyLDEx
ICsxMTksMTQgQEAgRVhQT1JUX1NZTUJPTF9HUEwoX192ZHBhX2FsbG9jX2RldmljZSk7Cj4+ICAg
ICogdmRwYV9yZWdpc3Rlcl9kZXZpY2UgLSByZWdpc3RlciBhIHZEUEEgZGV2aWNlCj4+ICAgICog
Q2FsbGVycyBtdXN0IGhhdmUgYSBzdWNjZWVkIGNhbGwgb2YgdmRwYV9hbGxvY19kZXZpY2UoKSBi
ZWZvcmUuCj4+ICAgICogQHZkZXY6IHRoZSB2ZHBhIGRldmljZSB0byBiZSByZWdpc3RlcmVkIHRv
IHZEUEEgYnVzCj4+ICsgKiBAbnZxczogbnVtYmVyIG9mIHZpcnRxdWV1ZXMgc3VwcG9ydGVkIGJ5
IHRoaXMgZGV2aWNlCj4+ICAgICoKPj4gICAgKiBSZXR1cm5zIGFuIGVycm9yIHdoZW4gZmFpbCB0
byBhZGQgdG8gdkRQQSBidXMKPj4gICAgKi8KPj4gLWludCB2ZHBhX3JlZ2lzdGVyX2RldmljZShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpCj4+ICtpbnQgdmRwYV9yZWdpc3Rlcl9kZXZpY2Uoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2LCBpbnQgbnZxcykKPj4gICB7Cj4+ICsJdmRldi0+bnZxcyA9
IG52cXM7Cj4+ICsKPj4gICAJcmV0dXJuIGRldmljZV9hZGQoJnZkZXYtPmRldik7Cj4+ICAgfQo+
PiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZkcGFfcmVnaXN0ZXJfZGV2aWNlKTsKPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVycy92ZHBhL3ZkcGFf
c2ltL3ZkcGFfc2ltLmMKPj4gaW5kZXggNmE5MGZkYjljYmZjLi5iMTI5Y2I0ZGQwMTMgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+ICsrKyBiL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+IEBAIC0zNTcsNyArMzU3LDcgQEAgc3RhdGlj
IHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZSh2b2lkKQo+PiAgIAllbHNlCj4+ICAgCQlv
cHMgPSAmdmRwYXNpbV9uZXRfY29uZmlnX29wczsKPj4gICAKPj4gLQl2ZHBhc2ltID0gdmRwYV9h
bGxvY19kZXZpY2Uoc3RydWN0IHZkcGFzaW0sIHZkcGEsIE5VTEwsIG9wcywgVkRQQVNJTV9WUV9O
VU0pOwo+PiArCXZkcGFzaW0gPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1Y3QgdmRwYXNpbSwgdmRw
YSwgTlVMTCwgb3BzKTsKPj4gICAJaWYgKCF2ZHBhc2ltKQo+PiAgIAkJZ290byBlcnJfYWxsb2M7
Cj4+ICAgCj4+IEBAIC0zOTMsNyArMzkzLDcgQEAgc3RhdGljIHN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltX2NyZWF0ZSh2b2lkKQo+PiAgIAl2cmluZ2hfc2V0X2lvdGxiKCZ2ZHBhc2ltLT52cXNbMV0u
dnJpbmcsIHZkcGFzaW0tPmlvbW11KTsKPj4gICAKPj4gICAJdmRwYXNpbS0+dmRwYS5kbWFfZGV2
ID0gZGV2Owo+PiAtCXJldCA9IHZkcGFfcmVnaXN0ZXJfZGV2aWNlKCZ2ZHBhc2ltLT52ZHBhKTsK
Pj4gKwlyZXQgPSB2ZHBhX3JlZ2lzdGVyX2RldmljZSgmdmRwYXNpbS0+dmRwYSwgVkRQQVNJTV9W
UV9OVU0pOwo+PiAgIAlpZiAocmV0KQo+PiAgIAkJZ290byBlcnJfaW9tbXU7Cj4+ICAgCj4+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+
IGluZGV4IDMwYmM3YTcyMjNiYi4uZDllOWQxN2I5MDgzIDEwMDY0NAo+PiAtLS0gYS9pbmNsdWRl
L2xpbnV4L3ZkcGEuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+PiBAQCAtMjQ0LDE4
ICsyNDQsMTcgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4+ICAgCj4+ICAgc3RydWN0IHZk
cGFfZGV2aWNlICpfX3ZkcGFfYWxsb2NfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKnBhcmVudCwKPj4g
ICAJCQkJCWNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKmNvbmZpZywKPj4gLQkJCQkJaW50
IG52cXMsCj4+ICAgCQkJCQlzaXplX3Qgc2l6ZSk7Cj4+ICAgCj4+IC0jZGVmaW5lIHZkcGFfYWxs
b2NfZGV2aWNlKGRldl9zdHJ1Y3QsIG1lbWJlciwgcGFyZW50LCBjb25maWcsIG52cXMpICAgXAo+
PiArI2RlZmluZSB2ZHBhX2FsbG9jX2RldmljZShkZXZfc3RydWN0LCBtZW1iZXIsIHBhcmVudCwg
Y29uZmlnKSAgIFwKPj4gICAJCQkgIGNvbnRhaW5lcl9vZihfX3ZkcGFfYWxsb2NfZGV2aWNlKCBc
Cj4+IC0JCQkJICAgICAgIHBhcmVudCwgY29uZmlnLCBudnFzLCBcCj4+ICsJCQkJICAgICAgIHBh
cmVudCwgY29uZmlnLCBcCj4+ICAgCQkJCSAgICAgICBzaXplb2YoZGV2X3N0cnVjdCkgKyBcCj4+
ICAgCQkJCSAgICAgICBCVUlMRF9CVUdfT05fWkVSTyhvZmZzZXRvZiggXAo+PiAgIAkJCQkgICAg
ICAgZGV2X3N0cnVjdCwgbWVtYmVyKSkpLCBcCj4+ICAgCQkJCSAgICAgICBkZXZfc3RydWN0LCBt
ZW1iZXIpCj4+ICAgCj4+IC1pbnQgdmRwYV9yZWdpc3Rlcl9kZXZpY2Uoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2KTsKPj4gK2ludCB2ZHBhX3JlZ2lzdGVyX2RldmljZShzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkZXYsIGludCBudnFzKTsKPj4gICB2b2lkIHZkcGFfdW5yZWdpc3Rlcl9kZXZpY2Uoc3Ry
dWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPj4gICAKPj4gICAvKioKPj4gLS0gCj4+IDIuMjUuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
