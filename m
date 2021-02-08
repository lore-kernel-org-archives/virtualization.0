Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC537C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:27:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B89560238
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B89560238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E663486817;
	Mon,  8 Feb 2021 04:27:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id arlliZ-b+7XX; Mon,  8 Feb 2021 04:27:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 09E8686457;
	Mon,  8 Feb 2021 04:27:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DF65BC0174;
	Mon,  8 Feb 2021 04:27:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 591EBC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:27:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 482DC86816
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:27:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hy-fcPKIeByQ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:27:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B1DF686457
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612758456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UL8cH8XCzdkqrrckXfp0ppSR7tIhk9JzqfHaTniZt4I=;
 b=YjlOFLbTJpWhtb6YQ7vmXSQgivRIf1oL7hjX4hzUXrAsYJhFy4hQ+/eIyZkisZYeFfxoB5
 03el8wBmCHbxJ0N80wEnsCJEPwh3dkXGP2jCQOmyUdkcAnfuBgVjXS6R6G03BCwol8n0v1
 O2UIcKL3A0yUpsbumQeEVfmMQ8pRgYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-oAenPR9uPeWRpEXqIQWZWw-1; Sun, 07 Feb 2021 23:27:32 -0500
X-MC-Unique: oAenPR9uPeWRpEXqIQWZWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF4AA80197A;
 Mon,  8 Feb 2021 04:27:30 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2C96F5D722;
 Mon,  8 Feb 2021 04:27:19 +0000 (UTC)
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
To: Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>,
 mst@redhat.com, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210204073618.36336-1-elic@nvidia.com>
 <81f5ce4f-cdb0-26cd-0dce-7ada824b1b86@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f2206fa2-0ddc-1858-54e7-71614b142e46@redhat.com>
Date: Mon, 8 Feb 2021 12:27:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <81f5ce4f-cdb0-26cd-0dce-7ada824b1b86@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: lulu@redhat.com
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

Ck9uIDIwMjEvMi82IOS4iuWNiDc6MDcsIFNpLVdlaSBMaXUgd3JvdGU6Cj4KPgo+IE9uIDIvMy8y
MDIxIDExOjM2IFBNLCBFbGkgQ29oZW4gd3JvdGU6Cj4+IFdoZW4gYSBjaGFuZ2Ugb2YgbWVtb3J5
IG1hcCBvY2N1cnMsIHRoZSBoYXJkd2FyZSByZXNvdXJjZXMgYXJlIGRlc3Ryb3llZAo+PiBhbmQg
dGhlbiByZS1jcmVhdGVkIGFnYWluIHdpdGggdGhlIG5ldyBtZW1vcnkgbWFwLiBJbiBzdWNoIGNh
c2UsIHdlIG5lZWQKPj4gdG8gcmVzdG9yZSB0aGUgaGFyZHdhcmUgYXZhaWxhYmxlIGFuZCB1c2Vk
IGluZGljZXMuIFRoZSBkcml2ZXIgZmFpbGVkIHRvCj4+IHJlc3RvcmUgdGhlIHVzZWQgaW5kZXgg
d2hpY2ggaXMgYWRkZWQgaGVyZS4KPj4KPj4gQWxzbywgc2luY2UgdGhlIGRyaXZlciBhbHNvIGZh
aWxzIHRvIHJlc2V0IHRoZSBhdmFpbGFibGUgYW5kIHVzZWQKPj4gaW5kaWNlcyB1cG9uIGRldmlj
ZSByZXNldCwgZml4IHRoaXMgaGVyZSB0byBhdm9pZCByZWdyZXNzaW9uIGNhdXNlZCBieQo+PiB0
aGUgZmFjdCB0aGF0IHVzZWQgaW5kZXggbWF5IG5vdCBiZSB6ZXJvIHVwb24gZGV2aWNlIHJlc2V0
Lgo+Pgo+PiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIg
Zm9yIHN1cHBvcnRlZCBtbHg1IAo+PiBkZXZpY2VzIikKPj4gU2lnbmVkLW9mZi1ieTogRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+Cj4+IC0tLQo+PiB2MCAtPiB2MToKPj4gQ2xlYXIgaW5kaWNl
cyB1cG9uIGRldmljZSByZXNldAo+Pgo+PiDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMgfCAxOCArKysrKysrKysrKysrKysrKysKPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE4IGlu
c2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyAKPj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gaW5kZXgg
ODhkZGUzNDU1YmZkLi5iNWZlNmQyYWQyMmYgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92
bmV0LmMKPj4gQEAgLTg3LDYgKzg3LDcgQEAgc3RydWN0IG1seDVfdnFfcmVzdG9yZV9pbmZvIHsK
Pj4gwqDCoMKgwqDCoCB1NjQgZGV2aWNlX2FkZHI7Cj4+IMKgwqDCoMKgwqAgdTY0IGRyaXZlcl9h
ZGRyOwo+PiDCoMKgwqDCoMKgIHUxNiBhdmFpbF9pbmRleDsKPj4gK8KgwqDCoCB1MTYgdXNlZF9p
bmRleDsKPj4gwqDCoMKgwqDCoCBib29sIHJlYWR5Owo+PiDCoMKgwqDCoMKgIHN0cnVjdCB2ZHBh
X2NhbGxiYWNrIGNiOwo+PiDCoMKgwqDCoMKgIGJvb2wgcmVzdG9yZTsKPj4gQEAgLTEyMSw2ICsx
MjIsNyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSB7Cj4+IMKgwqDCoMKgwqAgdTMyIHZp
cnRxX2lkOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2Owo+PiDCoMKg
wqDCoMKgIHUxNiBhdmFpbF9pZHg7Cj4+ICvCoMKgwqAgdTE2IHVzZWRfaWR4Owo+PiDCoMKgwqDC
oMKgIGludCBmd19zdGF0ZTsKPj4gwqAgwqDCoMKgwqDCoCAvKiBrZWVwIGxhc3QgaW4gdGhlIHN0
cnVjdCAqLwo+PiBAQCAtODA0LDYgKzgwNiw3IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3ZpcnRxdWV1
ZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAKPj4gKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1
ZQo+PiDCoCDCoMKgwqDCoMKgIG9ial9jb250ZXh0ID0gTUxYNV9BRERSX09GKGNyZWF0ZV92aXJ0
aW9fbmV0X3FfaW4sIGluLCAKPj4gb2JqX2NvbnRleHQpOwo+PiDCoMKgwqDCoMKgIE1MWDVfU0VU
KHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCBod19hdmFpbGFibGVfaW5kZXgsIAo+
PiBtdnEtPmF2YWlsX2lkeCk7Cj4+ICvCoMKgwqAgTUxYNV9TRVQodmlydGlvX25ldF9xX29iamVj
dCwgb2JqX2NvbnRleHQsIGh3X3VzZWRfaW5kZXgsIAo+PiBtdnEtPnVzZWRfaWR4KTsKPj4gwqDC
oMKgwqDCoCBNTFg1X1NFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgCj4+IHF1
ZXVlX2ZlYXR1cmVfYml0X21hc2tfMTJfMywKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2V0X2Zl
YXR1cmVzXzEyXzMobmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzKSk7Cj4+IMKgwqDCoMKgwqAg
dnFfY3R4ID0gTUxYNV9BRERSX09GKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCAK
Pj4gdmlydGlvX3FfY29udGV4dCk7Cj4+IEBAIC0xMDIyLDYgKzEwMjUsNyBAQCBzdGF0aWMgaW50
IGNvbm5lY3RfcXBzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0IAo+PiAqbmRldiwgc3RydWN0IG1seDVf
dmRwYV92aXJ0cXVldWUgKm0KPj4gwqAgc3RydWN0IG1seDVfdmlydHFfYXR0ciB7Cj4+IMKgwqDC
oMKgwqAgdTggc3RhdGU7Cj4+IMKgwqDCoMKgwqAgdTE2IGF2YWlsYWJsZV9pbmRleDsKPj4gK8Kg
wqDCoCB1MTYgdXNlZF9pbmRleDsKPj4gwqAgfTsKPj4gwqAgwqAgc3RhdGljIGludCBxdWVyeV92
aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCAKPj4gbWx4NV92ZHBh
X3ZpcnRxdWV1ZSAqbXZxLAo+PiBAQCAtMTA1Miw2ICsxMDU2LDcgQEAgc3RhdGljIGludCBxdWVy
eV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQgCj4+ICpuZGV2LCBzdHJ1Y3QgbWx4NV92
ZHBhX3ZpcnRxdWV1Cj4+IMKgwqDCoMKgwqAgbWVtc2V0KGF0dHIsIDAsIHNpemVvZigqYXR0cikp
Owo+PiDCoMKgwqDCoMKgIGF0dHItPnN0YXRlID0gTUxYNV9HRVQodmlydGlvX25ldF9xX29iamVj
dCwgb2JqX2NvbnRleHQsIHN0YXRlKTsKPj4gwqDCoMKgwqDCoCBhdHRyLT5hdmFpbGFibGVfaW5k
ZXggPSBNTFg1X0dFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCAKPj4gb2JqX2NvbnRleHQsIGh3X2F2
YWlsYWJsZV9pbmRleCk7Cj4+ICvCoMKgwqAgYXR0ci0+dXNlZF9pbmRleCA9IE1MWDVfR0VUKHZp
cnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCAKPj4gaHdfdXNlZF9pbmRleCk7Cj4+IMKg
wqDCoMKgwqAga2ZyZWUob3V0KTsKPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gwqAgQEAgLTE1
MzUsNiArMTU0MCwxNiBAQCBzdGF0aWMgdm9pZCB0ZWFyZG93bl92aXJ0cXVldWVzKHN0cnVjdCAK
Pj4gbWx4NV92ZHBhX25ldCAqbmRldikKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIH0KPj4gwqAgK3N0
YXRpYyB2b2lkIGNsZWFyX3ZpcnRxdWV1ZXMoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4+
ICt7Cj4+ICvCoMKgwqAgaW50IGk7Cj4+ICsKPj4gK8KgwqDCoCBmb3IgKGkgPSBuZGV2LT5tdmRl
di5tYXhfdnFzIC0gMTsgaSA+PSAwOyBpLS0pIHsKPj4gK8KgwqDCoMKgwqDCoMKgIG5kZXYtPnZx
c1tpXS5hdmFpbF9pZHggPSAwOwo+PiArwqDCoMKgwqDCoMKgwqAgbmRldi0+dnFzW2ldLnVzZWRf
aWR4ID0gMDsKPj4gK8KgwqDCoCB9Cj4+ICt9Cj4+ICsKPj4gwqAgLyogVE9ETzogY3Jvc3MtZW5k
aWFuIHN1cHBvcnQgKi8KPj4gwqAgc3RhdGljIGlubGluZSBib29sIG1seDVfdmRwYV9pc19saXR0
bGVfZW5kaWFuKHN0cnVjdCBtbHg1X3ZkcGFfZGV2IAo+PiAqbXZkZXYpCj4+IMKgIHsKPj4gQEAg
LTE2MTAsNiArMTYyNSw3IEBAIHN0YXRpYyBpbnQgc2F2ZV9jaGFubmVsX2luZm8oc3RydWN0IAo+
PiBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdQo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4gwqAgwqDCoMKgwqDCoCByaS0+YXZhaWxfaW5kZXgg
PSBhdHRyLmF2YWlsYWJsZV9pbmRleDsKPj4gK8KgwqDCoCByaS0+dXNlZF9pbmRleCA9IGF0dHIu
dXNlZF9pbmRleDsKPj4gwqDCoMKgwqDCoCByaS0+cmVhZHkgPSBtdnEtPnJlYWR5Owo+PiDCoMKg
wqDCoMKgIHJpLT5udW1fZW50ID0gbXZxLT5udW1fZW50Owo+PiDCoMKgwqDCoMKgIHJpLT5kZXNj
X2FkZHIgPSBtdnEtPmRlc2NfYWRkcjsKPj4gQEAgLTE2NTQsNiArMTY3MCw3IEBAIHN0YXRpYyB2
b2lkIHJlc3RvcmVfY2hhbm5lbHNfaW5mbyhzdHJ1Y3QgCj4+IG1seDVfdmRwYV9uZXQgKm5kZXYp
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiDCoCDCoMKgwqDCoMKg
wqDCoMKgwqAgbXZxLT5hdmFpbF9pZHggPSByaS0+YXZhaWxfaW5kZXg7Cj4+ICvCoMKgwqDCoMKg
wqDCoCBtdnEtPnVzZWRfaWR4ID0gcmktPnVzZWRfaW5kZXg7Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBtdnEtPnJlYWR5ID0gcmktPnJlYWR5Owo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbXZxLT5udW1f
ZW50ID0gcmktPm51bV9lbnQ7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBtdnEtPmRlc2NfYWRkciA9
IHJpLT5kZXNjX2FkZHI7Cj4+IEBAIC0xNzY4LDYgKzE3ODUsNyBAQCBzdGF0aWMgdm9pZCBtbHg1
X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QgCj4+IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMp
Cj4+IMKgwqDCoMKgwqAgaWYgKCFzdGF0dXMpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1seDVf
dmRwYV9pbmZvKG12ZGV2LCAicGVyZm9ybWluZyBkZXZpY2UgcmVzZXRcbiIpOwo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgdGVhcmRvd25fZHJpdmVyKG5kZXYpOwo+PiArwqDCoMKgwqDCoMKgwqAgY2xl
YXJfdmlydHF1ZXVlcyhuZGV2KTsKPiBUaGUgY2xlYXJpbmcgbG9va3MgZmluZSBhdCB0aGUgZmly
c3QgZ2xhbmNlLCBhcyBpdCBhbGlnbnMgd2l0aCB0aGUgCj4gb3RoZXIgc3RhdGUgY2xlYW51cHMg
ZmxvYXRpbmcgYXJvdW5kIGF0IHRoZSBzYW1lIHBsYWNlLiBIb3dldmVyLCB0aGUgCj4gdGhpbmcg
aXMgZ2V0X3ZxX3N0YXRlKCkgaXMgc3VwcG9zZWQgdG8gYmUgY2FsbGVkIHJpZ2h0IGFmdGVyIHRv
IGdldCAKPiBzeW5jJ2VkIHdpdGggdGhlIGxhdGVzdCBpbnRlcm5hbCBhdmFpbF9pbmRleCBmcm9t
IGRldmljZSB3aGlsZSB2cSBpcyAKPiBzdG9wcGVkLiBUaGUgaW5kZXggd2FzIHNhdmVkIGluIHRo
ZSBkcml2ZXIgc29mdHdhcmUgYXQgdnEgc3VzcGVuc2lvbiwgCj4gYnV0IGJlZm9yZSB0aGUgdmly
dHEgb2JqZWN0IGlzIGRlc3Ryb3llZC4gV2Ugc2hvdWxkbid0IGNsZWFyIHRoZSAKPiBhdmFpbF9p
bmRleCB0b28gZWFybHkuCgoKR29vZCBwb2ludC4KClRoZXJlJ3MgYSBsaW1pdGF0aW9uIG9uIHRo
ZSB2aXJ0aW8gc3BlYyBhbmQgdkRQQSBmcmFtZXdvcmsgdGhhdCB3ZSBjYW4gCm5vdCBzaW1wbHkg
ZGlmZmVyIGRldmljZSBzdXNwZW5kaW5nIGZyb20gZGV2aWNlIHJlc2V0LgoKTmVlZCB0byB0aGlu
ayBhYm91dCB0aGF0LiBJIHN1Z2dlc3QgYSBuZXcgc3RhdGUgaW4gWzFdLCB0aGUgaXNzdWUgaXMg
CnRoYXQgcGVvcGxlIGRvZXNuJ3QgbGlrZSB0aGUgYXN5bmNocm9ub3VzIEFQSSB0aGF0IGl0IGlu
dHJvZHVjZXMuCgoKPgo+IFBvc3NpYmx5IGl0IGNhbiBiZSBwb3N0cG9uZWQgdG8gd2hlcmUgVklS
VElPX0NPTkZJR19TX0RSSVZFUl9PSyBnZXRzIAo+IHNldCBhZ2FpbiwgaS5lLiByaWdodCBiZWZv
cmUgdGhlIHNldHVwX2RyaXZlcigpIGluIAo+IG1seDVfdmRwYV9zZXRfc3RhdHVzKCk/CgoKTG9v
a3MgbGlrZSBhIGdvb2Qgd29ya2Fyb3VuZC4KClRoYW5rcwoKCj4KPiAtU2l3ZWkKCgpbMV0gCmh0
dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMDEy
L21zZzAwMDI5Lmh0bWwKCgo+Cj4+IG1seDVfdmRwYV9kZXN0cm95X21yKCZuZGV2LT5tdmRldik7
Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5zdGF0dXMgPSAwOwo+PiDCoMKgwqDC
oMKgwqDCoMKgwqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzID0gMDsKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
