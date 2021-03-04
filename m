Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1650C433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 07:31:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24FD764EFD
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 07:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24FD764EFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC2824D6C5;
	Thu,  4 Mar 2021 07:31:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Cb5E0R7QvE0e; Thu,  4 Mar 2021 07:30:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A8334D15B;
	Thu,  4 Mar 2021 07:30:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF96DC000B;
	Thu,  4 Mar 2021 07:30:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37715C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 07:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1997E431CD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 07:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4MsJl-pmqlqj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 07:30:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B8FC743193
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 07:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614843055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c7/0tXgFX+Nemc6SQyJg+VG+4lWEi4mRvofkLtSVT7s=;
 b=XrgyONze8zouAXxl7MAT7UxGk0jaPATjks2ixrG+Er//NxOyY6QC91VdxXlX/mfWf1ckeP
 w0Muzjg2mOvqPkZRPioGBxf/bb/AQBKOhdyvGsGXMqdZMB0ulc/h/qyazdVzxodyjN8RsH
 6FYPLzeRHmYfIR9pA/87tPTsnuIuRLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-5Fli40RVOiqTeqVxlv819A-1; Thu, 04 Mar 2021 02:30:51 -0500
X-MC-Unique: 5Fli40RVOiqTeqVxlv819A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15EB7107ACE6;
 Thu,  4 Mar 2021 07:30:49 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-64.pek2.redhat.com
 [10.72.12.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AB85960CCD;
 Thu,  4 Mar 2021 07:30:35 +0000 (UTC)
Subject: Re: [RFC v4 11/11] vduse: Support binding irq to the specified cpu
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-12-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d104a518-799d-c13f-311c-f7a673f9241b@redhat.com>
Date: Thu, 4 Mar 2021 15:30:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223115048.435-12-xieyongji@bytedance.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8yMyA3OjUwIOS4i+WNiCwgWGllIFlvbmdqaSB3cm90ZToKPiBBZGQgYSBwYXJh
bWV0ZXIgZm9yIHRoZSBpb2N0bCBWRFVTRV9JTkpFQ1RfVlFfSVJRIHRvIHN1cHBvcnQKPiBpbmpl
Y3RpbmcgdmlydHF1ZXVlJ3MgaW50ZXJydXB0IHRvIHRoZSBzcGVjaWZpZWQgY3B1LgoKCkhvdyB1
c2Vyc3BhY2Uga25vdyB3aGljaCBDUFUgaXMgdGhpcyBpcnEgZm9yPyBJdCBsb29rcyB0byBtZSB3
ZSBuZWVkIHRvIApkbyBpdCBhdCBkaWZmZXJlbnQgbGV2ZWwuCgpFLmcgaW50cm9kdWNlIHNvbWUg
QVBJIGluIHN5cyB0byBhbGxvdyBhZG1pbiB0byB0dW5lIGZvciB0aGF0LgoKQnV0IEkgdGhpbmsg
d2UgY2FuIGRvIHRoYXQgaW4gYW50b2hlciBwYXRjaCBvbiB0b3Agb2YgdGhpcyBzZXJpZXMuCgpU
aGFua3MKCgo+Cj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5j
ZS5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIHwgMjIg
KysrKysrKysrKysrKysrKystLS0tLQo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmggICAg
ICAgICB8ICA3ICsrKysrKy0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3Zk
dXNlX2Rldi5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+IGluZGV4IGY1
YWRlYjllZTAyNy4uZGYzZDQ2N2ZmZjQwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBh
X3VzZXIvdmR1c2VfZGV2LmMKPiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jCj4gQEAgLTkyMywxNCArOTIzLDI3IEBAIHN0YXRpYyBsb25nIHZkdXNlX2Rldl9pb2N0bChz
dHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50IGNtZCwKPiAgIAkJYnJlYWs7Cj4gICAJfQo+
ICAgCWNhc2UgVkRVU0VfSU5KRUNUX1ZRX0lSUTogewo+ICsJCXN0cnVjdCB2ZHVzZV92cV9pcnEg
aXJxOwo+ICAgCQlzdHJ1Y3QgdmR1c2VfdmlydHF1ZXVlICp2cTsKPiAgIAo+ICsJCXJldCA9IC1F
RkFVTFQ7Cj4gKwkJaWYgKGNvcHlfZnJvbV91c2VyKCZpcnEsIGFyZ3AsIHNpemVvZihpcnEpKSkK
PiArCQkJYnJlYWs7Cj4gKwo+ICAgCQlyZXQgPSAtRUlOVkFMOwo+IC0JCWlmIChhcmcgPj0gZGV2
LT52cV9udW0pCj4gKwkJaWYgKGlycS5pbmRleCA+PSBkZXYtPnZxX251bSkKPiArCQkJYnJlYWs7
Cj4gKwo+ICsJCWlmIChpcnEuY3B1ICE9IC0xICYmIChpcnEuY3B1ID49IG5yX2NwdV9pZHMgfHwK
PiArCQkgICAgIWNwdV9vbmxpbmUoaXJxLmNwdSkpKQo+ICAgCQkJYnJlYWs7Cj4gICAKPiAtCQl2
cSA9ICZkZXYtPnZxc1thcmddOwo+IC0JCXF1ZXVlX3dvcmsodmR1c2VfaXJxX3dxLCAmdnEtPmlu
amVjdCk7Cj4gKwkJcmV0ID0gMDsKPiArCQl2cSA9ICZkZXYtPnZxc1tpcnEuaW5kZXhdOwo+ICsJ
CWlmIChpcnEuY3B1ID09IC0xKQo+ICsJCQlxdWV1ZV93b3JrKHZkdXNlX2lycV93cSwgJnZxLT5p
bmplY3QpOwo+ICsJCWVsc2UKPiArCQkJcXVldWVfd29ya19vbihpcnEuY3B1LCB2ZHVzZV9pcnFf
d3EsICZ2cS0+aW5qZWN0KTsKPiAgIAkJYnJlYWs7Cj4gICAJfQo+ICAgCWNhc2UgVkRVU0VfSU5K
RUNUX0NPTkZJR19JUlE6Cj4gQEAgLTEzNDIsOCArMTM1NSw3IEBAIHN0YXRpYyBpbnQgdmR1c2Vf
aW5pdCh2b2lkKQo+ICAgCWlmIChyZXQpCj4gICAJCWdvdG8gZXJyX2NoYXJkZXY7Cj4gICAKPiAt
CXZkdXNlX2lycV93cSA9IGFsbG9jX3dvcmtxdWV1ZSgidmR1c2UtaXJxIiwKPiAtCQkJCVdRX0hJ
R0hQUkkgfCBXUV9TWVNGUyB8IFdRX1VOQk9VTkQsIDApOwo+ICsJdmR1c2VfaXJxX3dxID0gYWxs
b2Nfd29ya3F1ZXVlKCJ2ZHVzZS1pcnEiLCBXUV9ISUdIUFJJLCAwKTsKPiAgIAlpZiAoIXZkdXNl
X2lycV93cSkKPiAgIAkJZ290byBlcnJfd3E7Cj4gICAKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91
YXBpL2xpbnV4L3ZkdXNlLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmR1c2UuaAo+IGluZGV4IDkw
NzBjZDUxMmNiNC4uOWM3MGZkODQyY2U1IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51
eC92ZHVzZS5oCj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZkdXNlLmgKPiBAQCAtMTE2LDYg
KzExNiwxMSBAQCBzdHJ1Y3QgdmR1c2VfdnFfZXZlbnRmZCB7Cj4gICAJaW50IGZkOyAvKiBldmVu
dGZkLCAtMSBtZWFucyBkZS1hc3NpZ25pbmcgdGhlIGV2ZW50ZmQgKi8KPiAgIH07Cj4gICAKPiAr
c3RydWN0IHZkdXNlX3ZxX2lycSB7Cj4gKwlfX3UzMiBpbmRleDsgLyogdmlydHF1ZXVlIGluZGV4
ICovCj4gKwlpbnQgY3B1OyAvKiBiaW5kIGlycSB0byB0aGUgc3BlY2lmaWVkIGNwdSwgLTEgbWVh
bnMgcnVubmluZyBvbiB0aGUgY3VycmVudCBjcHUgKi8KPiArfTsKPiArCj4gICAjZGVmaW5lIFZE
VVNFX0JBU0UJMHg4MQo+ICAgCj4gICAvKiBDcmVhdGUgYSB2ZHVzZSBkZXZpY2Ugd2hpY2ggaXMg
cmVwcmVzZW50ZWQgYnkgYSBjaGFyIGRldmljZSAoL2Rldi92ZHVzZS88bmFtZT4pICovCj4gQEAg
LTEzMSw3ICsxMzYsNyBAQCBzdHJ1Y3QgdmR1c2VfdnFfZXZlbnRmZCB7Cj4gICAjZGVmaW5lIFZE
VVNFX1ZRX1NFVFVQX0tJQ0tGRAlfSU9XKFZEVVNFX0JBU0UsIDB4MDQsIHN0cnVjdCB2ZHVzZV92
cV9ldmVudGZkKQo+ICAgCj4gICAvKiBJbmplY3QgYW4gaW50ZXJydXB0IGZvciBzcGVjaWZpYyB2
aXJ0cXVldWUgKi8KPiAtI2RlZmluZSBWRFVTRV9JTkpFQ1RfVlFfSVJRCV9JTyhWRFVTRV9CQVNF
LCAweDA1KQo+ICsjZGVmaW5lIFZEVVNFX0lOSkVDVF9WUV9JUlEJX0lPVyhWRFVTRV9CQVNFLCAw
eDA1LCBzdHJ1Y3QgdmR1c2VfdnFfaXJxKQo+ICAgCj4gICAvKiBJbmplY3QgYSBjb25maWcgaW50
ZXJydXB0ICovCj4gICAjZGVmaW5lIFZEVVNFX0lOSkVDVF9DT05GSUdfSVJRCV9JTyhWRFVTRV9C
QVNFLCAweDA2KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
