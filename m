Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE01C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:57:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3873F64F8C
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 03:57:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3873F64F8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C2F8F86E98;
	Fri,  5 Feb 2021 03:57:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cmDCl211PmUj; Fri,  5 Feb 2021 03:57:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E052A86E8F;
	Fri,  5 Feb 2021 03:57:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDC12C07FD;
	Fri,  5 Feb 2021 03:57:27 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B88FC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 724E986E90
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:57:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LDpmyV0qmyC5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:57:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4855886E8F
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 03:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612497444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XNDRjK2k4hYr251fYAwJiovjLPZ7/aDsH67J1vk1NvU=;
 b=gNs2cZ5trGgVzgqmxfSOBsyHiWoSDEIzuFPQ5dE+JEaAXkGLDvxtz+qBnwsqPL6h7V68Hl
 7EArTsAtnLvD5ZZFmdp3ExlsnXTOLbHCMmYg4aA2mJdthGtNL+Den7lh84IxLMVziviyYZ
 SNvE4HYIujgt5wuxm0EOf+f+RoNcYeQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-_eQcZEbrMcyx-IifS4jTFA-1; Thu, 04 Feb 2021 22:57:22 -0500
X-MC-Unique: _eQcZEbrMcyx-IifS4jTFA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E578AFA80;
 Fri,  5 Feb 2021 03:57:21 +0000 (UTC)
Received: from [10.72.12.112] (ovpn-12-112.pek2.redhat.com [10.72.12.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 616AA2B0A5;
 Fri,  5 Feb 2021 03:57:15 +0000 (UTC)
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com, si-wei.liu@oracle.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20210204073618.36336-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a23e0ea0-8471-4c97-73c5-e6e8fcf634ea@redhat.com>
Date: Fri, 5 Feb 2021 11:57:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204073618.36336-1-elic@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Ck9uIDIwMjEvMi80IOS4i+WNiDM6MzYsIEVsaSBDb2hlbiB3cm90ZToKPiBXaGVuIGEgY2hhbmdl
IG9mIG1lbW9yeSBtYXAgb2NjdXJzLCB0aGUgaGFyZHdhcmUgcmVzb3VyY2VzIGFyZSBkZXN0cm95
ZWQKPiBhbmQgdGhlbiByZS1jcmVhdGVkIGFnYWluIHdpdGggdGhlIG5ldyBtZW1vcnkgbWFwLiBJ
biBzdWNoIGNhc2UsIHdlIG5lZWQKPiB0byByZXN0b3JlIHRoZSBoYXJkd2FyZSBhdmFpbGFibGUg
YW5kIHVzZWQgaW5kaWNlcy4gVGhlIGRyaXZlciBmYWlsZWQgdG8KPiByZXN0b3JlIHRoZSB1c2Vk
IGluZGV4IHdoaWNoIGlzIGFkZGVkIGhlcmUuCj4KPiBBbHNvLCBzaW5jZSB0aGUgZHJpdmVyIGFs
c28gZmFpbHMgdG8gcmVzZXQgdGhlIGF2YWlsYWJsZSBhbmQgdXNlZAo+IGluZGljZXMgdXBvbiBk
ZXZpY2UgcmVzZXQsIGZpeCB0aGlzIGhlcmUgdG8gYXZvaWQgcmVncmVzc2lvbiBjYXVzZWQgYnkK
PiB0aGUgZmFjdCB0aGF0IHVzZWQgaW5kZXggbWF5IG5vdCBiZSB6ZXJvIHVwb24gZGV2aWNlIHJl
c2V0Lgo+Cj4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVy
IGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4g
PGVsaWNAbnZpZGlhLmNvbT4KPiAtLS0KPiB2MCAtPiB2MToKPiBDbGVhciBpbmRpY2VzIHVwb24g
ZGV2aWNlIHJlc2V0CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
CgoKPgo+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTggKysrKysrKysr
KysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDg4ZGRlMzQ1NWJmZC4uYjVmZTZkMmFkMjJmIDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ICsrKyBiL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC04Nyw2ICs4Nyw3IEBAIHN0cnVj
dCBtbHg1X3ZxX3Jlc3RvcmVfaW5mbyB7Cj4gICAJdTY0IGRldmljZV9hZGRyOwo+ICAgCXU2NCBk
cml2ZXJfYWRkcjsKPiAgIAl1MTYgYXZhaWxfaW5kZXg7Cj4gKwl1MTYgdXNlZF9pbmRleDsKPiAg
IAlib29sIHJlYWR5Owo+ICAgCXN0cnVjdCB2ZHBhX2NhbGxiYWNrIGNiOwo+ICAgCWJvb2wgcmVz
dG9yZTsKPiBAQCAtMTIxLDYgKzEyMiw3IEBAIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlIHsK
PiAgIAl1MzIgdmlydHFfaWQ7Cj4gICAJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXY7Cj4gICAJ
dTE2IGF2YWlsX2lkeDsKPiArCXUxNiB1c2VkX2lkeDsKPiAgIAlpbnQgZndfc3RhdGU7Cj4gICAK
PiAgIAkvKiBrZWVwIGxhc3QgaW4gdGhlIHN0cnVjdCAqLwo+IEBAIC04MDQsNiArODA2LDcgQEAg
c3RhdGljIGludCBjcmVhdGVfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBz
dHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWUKPiAgIAo+ICAgCW9ial9jb250ZXh0ID0gTUxYNV9BRERS
X09GKGNyZWF0ZV92aXJ0aW9fbmV0X3FfaW4sIGluLCBvYmpfY29udGV4dCk7Cj4gICAJTUxYNV9T
RVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsIGh3X2F2YWlsYWJsZV9pbmRleCwg
bXZxLT5hdmFpbF9pZHgpOwo+ICsJTUxYNV9TRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2Nv
bnRleHQsIGh3X3VzZWRfaW5kZXgsIG12cS0+dXNlZF9pZHgpOwo+ICAgCU1MWDVfU0VUKHZpcnRp
b19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCBxdWV1ZV9mZWF0dXJlX2JpdF9tYXNrXzEyXzMs
Cj4gICAJCSBnZXRfZmVhdHVyZXNfMTJfMyhuZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMpKTsK
PiAgIAl2cV9jdHggPSBNTFg1X0FERFJfT0YodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRl
eHQsIHZpcnRpb19xX2NvbnRleHQpOwo+IEBAIC0xMDIyLDYgKzEwMjUsNyBAQCBzdGF0aWMgaW50
IGNvbm5lY3RfcXBzKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBh
X3ZpcnRxdWV1ZSAqbQo+ICAgc3RydWN0IG1seDVfdmlydHFfYXR0ciB7Cj4gICAJdTggc3RhdGU7
Cj4gICAJdTE2IGF2YWlsYWJsZV9pbmRleDsKPiArCXUxNiB1c2VkX2luZGV4Owo+ICAgfTsKPiAg
IAo+ICAgc3RhdGljIGludCBxdWVyeV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5k
ZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEsCj4gQEAgLTEwNTIsNiArMTA1Niw3
IEBAIHN0YXRpYyBpbnQgcXVlcnlfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2
LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1Cj4gICAJbWVtc2V0KGF0dHIsIDAsIHNpemVvZigq
YXR0cikpOwo+ICAgCWF0dHItPnN0YXRlID0gTUxYNV9HRVQodmlydGlvX25ldF9xX29iamVjdCwg
b2JqX2NvbnRleHQsIHN0YXRlKTsKPiAgIAlhdHRyLT5hdmFpbGFibGVfaW5kZXggPSBNTFg1X0dF
VCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgaHdfYXZhaWxhYmxlX2luZGV4KTsK
PiArCWF0dHItPnVzZWRfaW5kZXggPSBNTFg1X0dFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpf
Y29udGV4dCwgaHdfdXNlZF9pbmRleCk7Cj4gICAJa2ZyZWUob3V0KTsKPiAgIAlyZXR1cm4gMDsK
PiAgIAo+IEBAIC0xNTM1LDYgKzE1NDAsMTYgQEAgc3RhdGljIHZvaWQgdGVhcmRvd25fdmlydHF1
ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAgIAl9Cj4gICB9Cj4gICAKPiArc3Rh
dGljIHZvaWQgY2xlYXJfdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPiAr
ewo+ICsJaW50IGk7Cj4gKwo+ICsJZm9yIChpID0gbmRldi0+bXZkZXYubWF4X3ZxcyAtIDE7IGkg
Pj0gMDsgaS0tKSB7Cj4gKwkJbmRldi0+dnFzW2ldLmF2YWlsX2lkeCA9IDA7Cj4gKwkJbmRldi0+
dnFzW2ldLnVzZWRfaWR4ID0gMDsKPiArCX0KPiArfQo+ICsKPiAgIC8qIFRPRE86IGNyb3NzLWVu
ZGlhbiBzdXBwb3J0ICovCj4gICBzdGF0aWMgaW5saW5lIGJvb2wgbWx4NV92ZHBhX2lzX2xpdHRs
ZV9lbmRpYW4oc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2KQo+ICAgewo+IEBAIC0xNjEwLDYg
KzE2MjUsNyBAQCBzdGF0aWMgaW50IHNhdmVfY2hhbm5lbF9pbmZvKHN0cnVjdCBtbHg1X3ZkcGFf
bmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdQo+ICAgCQlyZXR1cm4gZXJyOwo+ICAg
Cj4gICAJcmktPmF2YWlsX2luZGV4ID0gYXR0ci5hdmFpbGFibGVfaW5kZXg7Cj4gKwlyaS0+dXNl
ZF9pbmRleCA9IGF0dHIudXNlZF9pbmRleDsKPiAgIAlyaS0+cmVhZHkgPSBtdnEtPnJlYWR5Owo+
ICAgCXJpLT5udW1fZW50ID0gbXZxLT5udW1fZW50Owo+ICAgCXJpLT5kZXNjX2FkZHIgPSBtdnEt
PmRlc2NfYWRkcjsKPiBAQCAtMTY1NCw2ICsxNjcwLDcgQEAgc3RhdGljIHZvaWQgcmVzdG9yZV9j
aGFubmVsc19pbmZvKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+ICAgCQkJY29udGludWU7
Cj4gICAKPiAgIAkJbXZxLT5hdmFpbF9pZHggPSByaS0+YXZhaWxfaW5kZXg7Cj4gKwkJbXZxLT51
c2VkX2lkeCA9IHJpLT51c2VkX2luZGV4Owo+ICAgCQltdnEtPnJlYWR5ID0gcmktPnJlYWR5Owo+
ICAgCQltdnEtPm51bV9lbnQgPSByaS0+bnVtX2VudDsKPiAgIAkJbXZxLT5kZXNjX2FkZHIgPSBy
aS0+ZGVzY19hZGRyOwo+IEBAIC0xNzY4LDYgKzE3ODUsNyBAQCBzdGF0aWMgdm9pZCBtbHg1X3Zk
cGFfc2V0X3N0YXR1cyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU4IHN0YXR1cykKPiAgIAlp
ZiAoIXN0YXR1cykgewo+ICAgCQltbHg1X3ZkcGFfaW5mbyhtdmRldiwgInBlcmZvcm1pbmcgZGV2
aWNlIHJlc2V0XG4iKTsKPiAgIAkJdGVhcmRvd25fZHJpdmVyKG5kZXYpOwo+ICsJCWNsZWFyX3Zp
cnRxdWV1ZXMobmRldik7Cj4gICAJCW1seDVfdmRwYV9kZXN0cm95X21yKCZuZGV2LT5tdmRldik7
Cj4gICAJCW5kZXYtPm12ZGV2LnN0YXR1cyA9IDA7Cj4gICAJCW5kZXYtPm12ZGV2Lm1seF9mZWF0
dXJlcyA9IDA7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
