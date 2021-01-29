Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A849DC433E0
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 03:49:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D3FB64DBD
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 03:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D3FB64DBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CB8338693C;
	Fri, 29 Jan 2021 03:49:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NfoYWlJYWqs5; Fri, 29 Jan 2021 03:49:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E7A148691A;
	Fri, 29 Jan 2021 03:49:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CCE2EC08A1;
	Fri, 29 Jan 2021 03:49:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 153B4C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 03:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 03DE187422
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 03:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eq0kd6g0upYx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 03:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 53BBD873FB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 03:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611892195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1wOMLsnl3srevdmRDL22qVzg7hZeq9Vx6iIhsGCDt5g=;
 b=RvRsDBAitIKccBq9TyYEweAYh4dDdyJOfNVMLE+71IE50StzOkbYIrho8fCOF/z6VAaQlC
 nH9iA+3vECwDjTuFti6AtWbeR1X0Cd0fCnT23TSL6VCMY4DD3ubtN0OzobKWdneP+T1iT4
 QvsgmpiuT0VB0mT0QLixSSX2/7LsBOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-bVMfGUOKOKOQJgtd-AiNww-1; Thu, 28 Jan 2021 22:49:53 -0500
X-MC-Unique: bVMfGUOKOKOQJgtd-AiNww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0FEA107ACE3;
 Fri, 29 Jan 2021 03:49:51 +0000 (UTC)
Received: from [10.72.14.10] (ovpn-14-10.pek2.redhat.com [10.72.14.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E0221894E;
 Fri, 29 Jan 2021 03:49:46 +0000 (UTC)
Subject: Re: [PATCH 2/2] vdpa/mlx5: Restore the hardware used index after
 change map
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com
References: <20210128134130.3051-1-elic@nvidia.com>
 <20210128134130.3051-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <54239b51-918c-3475-dc88-4da1a4548da8@redhat.com>
Date: Fri, 29 Jan 2021 11:49:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128134130.3051-3-elic@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lulu@redhat.com,
 virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMS8yOCDkuIvljYg5OjQxLCBFbGkgQ29oZW4gd3JvdGU6Cj4gV2hlbiBhIGNoYW5n
ZSBvZiBtZW1vcnkgbWFwIG9jY3VycywgdGhlIGhhcmR3YXJlIHJlc291cmNlcyBhcmUgZGVzdHJv
eWVkCj4gYW5kIHRoZW4gcmUtY3JlYXRlZCBhZ2FpbiB3aXRoIHRoZSBuZXcgbWVtb3J5IG1hcC4g
SW4gc3VjaCBjYXNlLCB3ZSBuZWVkCj4gdG8gcmVzdG9yZSB0aGUgaGFyZHdhcmUgYXZhaWxhYmxl
IGFuZCB1c2VkIGluZGljZXMuIFRoZSBkcml2ZXIgZmFpbGVkIHRvCj4gcmVzdG9yZSB0aGUgdXNl
ZCBpbmRleCB3aGljaCBpcyBhZGRlZCBoZXJlLgo+Cj4gRml4ZXMgMWE4NmIzNzdhYTIxICgidmRw
YS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+IFNp
Z25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgoKCkEgcXVlc3Rpb24uIERv
ZXMgdGhpcyBtZWFuIGFmdGVyIGEgdnEgaXMgc3VzcGVuZGVkLCB0aGUgaHcgdXNlZCBpbmRleCBp
cyAKbm90IGVxdWFsIHRvIHZxIHVzZWQgaW5kZXg/CgpUaGFua3MKCgo+IC0tLQo+ICAgZHJpdmVy
cy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgNyArKysrKysrCj4gICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0
L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gaW5kZXgg
NTQ5ZGVkMDc0ZmYzLi4zZmM4NTg4Y2VjYWUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jCj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4gQEAgLTg3LDYgKzg3LDcgQEAgc3RydWN0IG1seDVfdnFfcmVzdG9yZV9pbmZvIHsKPiAg
IAl1NjQgZGV2aWNlX2FkZHI7Cj4gICAJdTY0IGRyaXZlcl9hZGRyOwo+ICAgCXUxNiBhdmFpbF9p
bmRleDsKPiArCXUxNiB1c2VkX2luZGV4Owo+ICAgCWJvb2wgcmVhZHk7Cj4gICAJc3RydWN0IHZk
cGFfY2FsbGJhY2sgY2I7Cj4gICAJYm9vbCByZXN0b3JlOwo+IEBAIC0xMjEsNiArMTIyLDcgQEAg
c3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgewo+ICAgCXUzMiB2aXJ0cV9pZDsKPiAgIAlzdHJ1
Y3QgbWx4NV92ZHBhX25ldCAqbmRldjsKPiAgIAl1MTYgYXZhaWxfaWR4Owo+ICsJdTE2IHVzZWRf
aWR4Owo+ICAgCWludCBmd19zdGF0ZTsKPiAgIAo+ICAgCS8qIGtlZXAgbGFzdCBpbiB0aGUgc3Ry
dWN0ICovCj4gQEAgLTgwNCw2ICs4MDYsNyBAQCBzdGF0aWMgaW50IGNyZWF0ZV92aXJ0cXVldWUo
c3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZQo+ICAg
Cj4gICAJb2JqX2NvbnRleHQgPSBNTFg1X0FERFJfT0YoY3JlYXRlX3ZpcnRpb19uZXRfcV9pbiwg
aW4sIG9ial9jb250ZXh0KTsKPiAgIAlNTFg1X1NFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpf
Y29udGV4dCwgaHdfYXZhaWxhYmxlX2luZGV4LCBtdnEtPmF2YWlsX2lkeCk7Cj4gKwlNTFg1X1NF
VCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgaHdfdXNlZF9pbmRleCwgbXZxLT51
c2VkX2lkeCk7Cj4gICAJTUxYNV9TRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQs
IHF1ZXVlX2ZlYXR1cmVfYml0X21hc2tfMTJfMywKPiAgIAkJIGdldF9mZWF0dXJlc18xMl8zKG5k
ZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcykpOwo+ICAgCXZxX2N0eCA9IE1MWDVfQUREUl9PRih2
aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgdmlydGlvX3FfY29udGV4dCk7Cj4gQEAg
LTEwMjIsNiArMTAyNSw3IEBAIHN0YXRpYyBpbnQgY29ubmVjdF9xcHMoc3RydWN0IG1seDVfdmRw
YV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptCj4gICBzdHJ1Y3QgbWx4
NV92aXJ0cV9hdHRyIHsKPiAgIAl1OCBzdGF0ZTsKPiAgIAl1MTYgYXZhaWxhYmxlX2luZGV4Owo+
ICsJdTE2IHVzZWRfaW5kZXg7Cj4gICB9Owo+ICAgCj4gICBzdGF0aWMgaW50IHF1ZXJ5X3ZpcnRx
dWV1ZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVl
dWUgKm12cSwKPiBAQCAtMTA1Miw2ICsxMDU2LDcgQEAgc3RhdGljIGludCBxdWVyeV92aXJ0cXVl
dWUoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXUK
PiAgIAltZW1zZXQoYXR0ciwgMCwgc2l6ZW9mKCphdHRyKSk7Cj4gICAJYXR0ci0+c3RhdGUgPSBN
TFg1X0dFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgc3RhdGUpOwo+ICAgCWF0
dHItPmF2YWlsYWJsZV9pbmRleCA9IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9j
b250ZXh0LCBod19hdmFpbGFibGVfaW5kZXgpOwo+ICsJYXR0ci0+dXNlZF9pbmRleCA9IE1MWDVf
R0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCBod191c2VkX2luZGV4KTsKPiAg
IAlrZnJlZShvdXQpOwo+ICAgCXJldHVybiAwOwo+ICAgCj4gQEAgLTE2MDIsNiArMTYwNyw3IEBA
IHN0YXRpYyBpbnQgc2F2ZV9jaGFubmVsX2luZm8oc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYs
IHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1Cj4gICAJCXJldHVybiBlcnI7Cj4gICAKPiAgIAlyaS0+
YXZhaWxfaW5kZXggPSBhdHRyLmF2YWlsYWJsZV9pbmRleDsKPiArCXJpLT51c2VkX2luZGV4ID0g
YXR0ci51c2VkX2luZGV4Owo+ICAgCXJpLT5yZWFkeSA9IG12cS0+cmVhZHk7Cj4gICAJcmktPm51
bV9lbnQgPSBtdnEtPm51bV9lbnQ7Cj4gICAJcmktPmRlc2NfYWRkciA9IG12cS0+ZGVzY19hZGRy
Owo+IEBAIC0xNjQ2LDYgKzE2NTIsNyBAQCBzdGF0aWMgdm9pZCByZXN0b3JlX2NoYW5uZWxzX2lu
Zm8oc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYpCj4gICAJCQljb250aW51ZTsKPiAgIAo+ICAg
CQltdnEtPmF2YWlsX2lkeCA9IHJpLT5hdmFpbF9pbmRleDsKPiArCQltdnEtPnVzZWRfaWR4ID0g
cmktPnVzZWRfaW5kZXg7Cj4gICAJCW12cS0+cmVhZHkgPSByaS0+cmVhZHk7Cj4gICAJCW12cS0+
bnVtX2VudCA9IHJpLT5udW1fZW50Owo+ICAgCQltdnEtPmRlc2NfYWRkciA9IHJpLT5kZXNjX2Fk
ZHI7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
