Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8553C433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 09:04:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BBB864DDD
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 09:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BBB864DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C272987010;
	Mon,  8 Feb 2021 09:04:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hr+JJFPk8B4l; Mon,  8 Feb 2021 09:04:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B201886FAA;
	Mon,  8 Feb 2021 09:04:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E378C0891;
	Mon,  8 Feb 2021 09:04:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9216AC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:04:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 84B6A86FB1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:04:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rMHi8FW0CE+k
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:04:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1CF8A86FAA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612775083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WXD9znX1LdItJUy6y1iJLv4XS7dOC3t0iP2BAP+1AjE=;
 b=biRlE3qEuHzprYJU6YKfiPpBRXmwCrW5T9ra4NIGExsSgG+HLok4CLfQgl0pPhwTd1FCFM
 00wW77EIiA5LLIVBaoSjKcjq1hZqgo7tKczxu3JNgQOc//5RK/WcT4ZjN5uS/QAInYO6Hn
 HA7lfTYWmg6DnuieEUO2kyQhgRxut20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-_1iTII52N3e7GVm1wDeq2w-1; Mon, 08 Feb 2021 04:04:40 -0500
X-MC-Unique: _1iTII52N3e7GVm1wDeq2w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB11D804036;
 Mon,  8 Feb 2021 09:04:38 +0000 (UTC)
Received: from [10.72.12.29] (ovpn-12-29.pek2.redhat.com [10.72.12.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F29BE60C8F;
 Mon,  8 Feb 2021 09:04:29 +0000 (UTC)
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
To: Eli Cohen <elic@nvidia.com>
References: <20210204073618.36336-1-elic@nvidia.com>
 <81f5ce4f-cdb0-26cd-0dce-7ada824b1b86@oracle.com>
 <f2206fa2-0ddc-1858-54e7-71614b142e46@redhat.com>
 <20210208063736.GA166546@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0d592ed0-3cea-cfb0-9b7b-9d2755da3f12@redhat.com>
Date: Mon, 8 Feb 2021 17:04:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210208063736.GA166546@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: lulu@redhat.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Si-Wei Liu <si-wei.liu@oracle.com>
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

Ck9uIDIwMjEvMi84IOS4i+WNiDI6MzcsIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBNb24sIEZlYiAw
OCwgMjAyMSBhdCAxMjoyNzoxOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiAyMDIx
LzIvNiDkuIrljYg3OjA3LCBTaS1XZWkgTGl1IHdyb3RlOgo+Pj4KPj4+IE9uIDIvMy8yMDIxIDEx
OjM2IFBNLCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4gV2hlbiBhIGNoYW5nZSBvZiBtZW1vcnkgbWFw
IG9jY3VycywgdGhlIGhhcmR3YXJlIHJlc291cmNlcyBhcmUgZGVzdHJveWVkCj4+Pj4gYW5kIHRo
ZW4gcmUtY3JlYXRlZCBhZ2FpbiB3aXRoIHRoZSBuZXcgbWVtb3J5IG1hcC4gSW4gc3VjaCBjYXNl
LCB3ZSBuZWVkCj4+Pj4gdG8gcmVzdG9yZSB0aGUgaGFyZHdhcmUgYXZhaWxhYmxlIGFuZCB1c2Vk
IGluZGljZXMuIFRoZSBkcml2ZXIgZmFpbGVkIHRvCj4+Pj4gcmVzdG9yZSB0aGUgdXNlZCBpbmRl
eCB3aGljaCBpcyBhZGRlZCBoZXJlLgo+Pj4+Cj4+Pj4gQWxzbywgc2luY2UgdGhlIGRyaXZlciBh
bHNvIGZhaWxzIHRvIHJlc2V0IHRoZSBhdmFpbGFibGUgYW5kIHVzZWQKPj4+PiBpbmRpY2VzIHVw
b24gZGV2aWNlIHJlc2V0LCBmaXggdGhpcyBoZXJlIHRvIGF2b2lkIHJlZ3Jlc3Npb24gY2F1c2Vk
IGJ5Cj4+Pj4gdGhlIGZhY3QgdGhhdCB1c2VkIGluZGV4IG1heSBub3QgYmUgemVybyB1cG9uIGRl
dmljZSByZXNldC4KPj4+Pgo+Pj4+IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFk
ZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUKPj4+PiBkZXZpY2VzIikKPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPj4+PiAtLS0KPj4+PiB2MCAt
PiB2MToKPj4+PiBDbGVhciBpbmRpY2VzIHVwb24gZGV2aWNlIHJlc2V0Cj4+Pj4KPj4+PiAgwqAg
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIHwgMTggKysrKysrKysrKysrKysrKysr
Cj4+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspCj4+Pj4KPj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4gYi9kcml2ZXJz
L3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+PiBpbmRleCA4OGRkZTM0NTViZmQuLmI1ZmU2
ZDJhZDIyZiAxMDA2NDQKPj4+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0
LmMKPj4+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+PiBAQCAt
ODcsNiArODcsNyBAQCBzdHJ1Y3QgbWx4NV92cV9yZXN0b3JlX2luZm8gewo+Pj4+ICDCoMKgwqDC
oMKgIHU2NCBkZXZpY2VfYWRkcjsKPj4+PiAgwqDCoMKgwqDCoCB1NjQgZHJpdmVyX2FkZHI7Cj4+
Pj4gIMKgwqDCoMKgwqAgdTE2IGF2YWlsX2luZGV4Owo+Pj4+ICvCoMKgwqAgdTE2IHVzZWRfaW5k
ZXg7Cj4+Pj4gIMKgwqDCoMKgwqAgYm9vbCByZWFkeTsKPj4+PiAgwqDCoMKgwqDCoCBzdHJ1Y3Qg
dmRwYV9jYWxsYmFjayBjYjsKPj4+PiAgwqDCoMKgwqDCoCBib29sIHJlc3RvcmU7Cj4+Pj4gQEAg
LTEyMSw2ICsxMjIsNyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSB7Cj4+Pj4gIMKgwqDC
oMKgwqAgdTMyIHZpcnRxX2lkOwo+Pj4+ICDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3ZkcGFfbmV0
ICpuZGV2Owo+Pj4+ICDCoMKgwqDCoMKgIHUxNiBhdmFpbF9pZHg7Cj4+Pj4gK8KgwqDCoCB1MTYg
dXNlZF9pZHg7Cj4+Pj4gIMKgwqDCoMKgwqAgaW50IGZ3X3N0YXRlOwo+Pj4+ICDCoCDCoMKgwqDC
oMKgIC8qIGtlZXAgbGFzdCBpbiB0aGUgc3RydWN0ICovCj4+Pj4gQEAgLTgwNCw2ICs4MDYsNyBA
QCBzdGF0aWMgaW50IGNyZWF0ZV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQKPj4+PiAq
bmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVlCj4+Pj4gIMKgIMKgwqDCoMKgwqAgb2JqX2Nv
bnRleHQgPSBNTFg1X0FERFJfT0YoY3JlYXRlX3ZpcnRpb19uZXRfcV9pbiwgaW4sCj4+Pj4gb2Jq
X2NvbnRleHQpOwo+Pj4+ICDCoMKgwqDCoMKgIE1MWDVfU0VUKHZpcnRpb19uZXRfcV9vYmplY3Qs
IG9ial9jb250ZXh0LCBod19hdmFpbGFibGVfaW5kZXgsCj4+Pj4gbXZxLT5hdmFpbF9pZHgpOwo+
Pj4+ICvCoMKgwqAgTUxYNV9TRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsIGh3
X3VzZWRfaW5kZXgsCj4+Pj4gbXZxLT51c2VkX2lkeCk7Cj4+Pj4gIMKgwqDCoMKgwqAgTUxYNV9T
RVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsCj4+Pj4gcXVldWVfZmVhdHVyZV9i
aXRfbWFza18xMl8zLAo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfZmVhdHVyZXNfMTJf
MyhuZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMpKTsKPj4+PiAgwqDCoMKgwqDCoCB2cV9jdHgg
PSBNTFg1X0FERFJfT0YodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsCj4+Pj4gdmly
dGlvX3FfY29udGV4dCk7Cj4+Pj4gQEAgLTEwMjIsNiArMTAyNSw3IEBAIHN0YXRpYyBpbnQgY29u
bmVjdF9xcHMoc3RydWN0IG1seDVfdmRwYV9uZXQKPj4+PiAqbmRldiwgc3RydWN0IG1seDVfdmRw
YV92aXJ0cXVldWUgKm0KPj4+PiAgwqAgc3RydWN0IG1seDVfdmlydHFfYXR0ciB7Cj4+Pj4gIMKg
wqDCoMKgwqAgdTggc3RhdGU7Cj4+Pj4gIMKgwqDCoMKgwqAgdTE2IGF2YWlsYWJsZV9pbmRleDsK
Pj4+PiArwqDCoMKgIHUxNiB1c2VkX2luZGV4Owo+Pj4+ICDCoCB9Owo+Pj4+ICDCoCDCoCBzdGF0
aWMgaW50IHF1ZXJ5X3ZpcnRxdWV1ZShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0
Cj4+Pj4gbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxLAo+Pj4+IEBAIC0xMDUyLDYgKzEwNTYsNyBA
QCBzdGF0aWMgaW50IHF1ZXJ5X3ZpcnRxdWV1ZShzdHJ1Y3QKPj4+PiBtbHg1X3ZkcGFfbmV0ICpu
ZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1Cj4+Pj4gIMKgwqDCoMKgwqAgbWVtc2V0KGF0
dHIsIDAsIHNpemVvZigqYXR0cikpOwo+Pj4+ICDCoMKgwqDCoMKgIGF0dHItPnN0YXRlID0gTUxY
NV9HRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsIHN0YXRlKTsKPj4+PiAgwqDC
oMKgwqDCoCBhdHRyLT5hdmFpbGFibGVfaW5kZXggPSBNTFg1X0dFVCh2aXJ0aW9fbmV0X3Ffb2Jq
ZWN0LAo+Pj4+IG9ial9jb250ZXh0LCBod19hdmFpbGFibGVfaW5kZXgpOwo+Pj4+ICvCoMKgwqAg
YXR0ci0+dXNlZF9pbmRleCA9IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250
ZXh0LAo+Pj4+IGh3X3VzZWRfaW5kZXgpOwo+Pj4+ICDCoMKgwqDCoMKgIGtmcmVlKG91dCk7Cj4+
Pj4gIMKgwqDCoMKgwqAgcmV0dXJuIDA7Cj4+Pj4gIMKgIEBAIC0xNTM1LDYgKzE1NDAsMTYgQEAg
c3RhdGljIHZvaWQgdGVhcmRvd25fdmlydHF1ZXVlcyhzdHJ1Y3QKPj4+PiBtbHg1X3ZkcGFfbmV0
ICpuZGV2KQo+Pj4+ICDCoMKgwqDCoMKgIH0KPj4+PiAgwqAgfQo+Pj4+ICDCoCArc3RhdGljIHZv
aWQgY2xlYXJfdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPj4+PiArewo+
Pj4+ICvCoMKgwqAgaW50IGk7Cj4+Pj4gKwo+Pj4+ICvCoMKgwqAgZm9yIChpID0gbmRldi0+bXZk
ZXYubWF4X3ZxcyAtIDE7IGkgPj0gMDsgaS0tKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG5kZXYt
PnZxc1tpXS5hdmFpbF9pZHggPSAwOwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBuZGV2LT52cXNbaV0u
dXNlZF9pZHggPSAwOwo+Pj4+ICvCoMKgwqAgfQo+Pj4+ICt9Cj4+Pj4gKwo+Pj4+ICDCoCAvKiBU
T0RPOiBjcm9zcy1lbmRpYW4gc3VwcG9ydCAqLwo+Pj4+ICDCoCBzdGF0aWMgaW5saW5lIGJvb2wg
bWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0IG1seDVfdmRwYV9kZXYKPj4+PiAqbXZk
ZXYpCj4+Pj4gIMKgIHsKPj4+PiBAQCAtMTYxMCw2ICsxNjI1LDcgQEAgc3RhdGljIGludCBzYXZl
X2NoYW5uZWxfaW5mbyhzdHJ1Y3QKPj4+PiBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4
NV92ZHBhX3ZpcnRxdQo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+PiAg
wqAgwqDCoMKgwqDCoCByaS0+YXZhaWxfaW5kZXggPSBhdHRyLmF2YWlsYWJsZV9pbmRleDsKPj4+
PiArwqDCoMKgIHJpLT51c2VkX2luZGV4ID0gYXR0ci51c2VkX2luZGV4Owo+Pj4+ICDCoMKgwqDC
oMKgIHJpLT5yZWFkeSA9IG12cS0+cmVhZHk7Cj4+Pj4gIMKgwqDCoMKgwqAgcmktPm51bV9lbnQg
PSBtdnEtPm51bV9lbnQ7Cj4+Pj4gIMKgwqDCoMKgwqAgcmktPmRlc2NfYWRkciA9IG12cS0+ZGVz
Y19hZGRyOwo+Pj4+IEBAIC0xNjU0LDYgKzE2NzAsNyBAQCBzdGF0aWMgdm9pZCByZXN0b3JlX2No
YW5uZWxzX2luZm8oc3RydWN0Cj4+Pj4gbWx4NV92ZHBhX25ldCAqbmRldikKPj4+PiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+Pj4gIMKgIMKgwqDCoMKgwqDCoMKgwqDC
oCBtdnEtPmF2YWlsX2lkeCA9IHJpLT5hdmFpbF9pbmRleDsKPj4+PiArwqDCoMKgwqDCoMKgwqAg
bXZxLT51c2VkX2lkeCA9IHJpLT51c2VkX2luZGV4Owo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAg
bXZxLT5yZWFkeSA9IHJpLT5yZWFkeTsKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIG12cS0+bnVt
X2VudCA9IHJpLT5udW1fZW50Owo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgbXZxLT5kZXNjX2Fk
ZHIgPSByaS0+ZGVzY19hZGRyOwo+Pj4+IEBAIC0xNzY4LDYgKzE3ODUsNyBAQCBzdGF0aWMgdm9p
ZCBtbHg1X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1Y3QKPj4+PiB2ZHBhX2RldmljZSAqdmRldiwgdTgg
c3RhdHVzKQo+Pj4+ICDCoMKgwqDCoMKgIGlmICghc3RhdHVzKSB7Cj4+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoCBtbHg1X3ZkcGFfaW5mbyhtdmRldiwgInBlcmZvcm1pbmcgZGV2aWNlIHJlc2V0XG4i
KTsKPj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHRlYXJkb3duX2RyaXZlcihuZGV2KTsKPj4+PiAr
wqDCoMKgwqDCoMKgwqAgY2xlYXJfdmlydHF1ZXVlcyhuZGV2KTsKPj4+IFRoZSBjbGVhcmluZyBs
b29rcyBmaW5lIGF0IHRoZSBmaXJzdCBnbGFuY2UsIGFzIGl0IGFsaWducyB3aXRoIHRoZSBvdGhl
cgo+Pj4gc3RhdGUgY2xlYW51cHMgZmxvYXRpbmcgYXJvdW5kIGF0IHRoZSBzYW1lIHBsYWNlLiBI
b3dldmVyLCB0aGUgdGhpbmcgaXMKPj4+IGdldF92cV9zdGF0ZSgpIGlzIHN1cHBvc2VkIHRvIGJl
IGNhbGxlZCByaWdodCBhZnRlciB0byBnZXQgc3luYydlZCB3aXRoCj4+PiB0aGUgbGF0ZXN0IGlu
dGVybmFsIGF2YWlsX2luZGV4IGZyb20gZGV2aWNlIHdoaWxlIHZxIGlzIHN0b3BwZWQuIFRoZQo+
Pj4gaW5kZXggd2FzIHNhdmVkIGluIHRoZSBkcml2ZXIgc29mdHdhcmUgYXQgdnEgc3VzcGVuc2lv
biwgYnV0IGJlZm9yZSB0aGUKPj4+IHZpcnRxIG9iamVjdCBpcyBkZXN0cm95ZWQuIFdlIHNob3Vs
ZG4ndCBjbGVhciB0aGUgYXZhaWxfaW5kZXggdG9vIGVhcmx5Lgo+Pgo+PiBHb29kIHBvaW50Lgo+
Pgo+PiBUaGVyZSdzIGEgbGltaXRhdGlvbiBvbiB0aGUgdmlydGlvIHNwZWMgYW5kIHZEUEEgZnJh
bWV3b3JrIHRoYXQgd2UgY2FuIG5vdAo+PiBzaW1wbHkgZGlmZmVyIGRldmljZSBzdXNwZW5kaW5n
IGZyb20gZGV2aWNlIHJlc2V0Lgo+Pgo+IEFyZSB5b3UgdGFsa2luZyBhYm91dCBsaXZlIG1pZ3Jh
dGlvbiB3aGVyZSB5b3UgcmVzZXQgdGhlIGRldmljZSBidXQKPiBzdGlsbCB3YW50IHRvIGtub3cg
aG93IGZhciBpdCBwcm9ncmVzc2VkIGluIG9yZGVyIHRvIGNvbnRpbnVlIGZyb20gdGhlCj4gc2Ft
ZSBwbGFjZSBpbiB0aGUgbmV3IFZNPwoKClllcy4gU28gaWYgd2Ugd2FudCB0byBzdXBwb3J0IGxp
dmUgbWlncmF0aW9uIGF0IHdlIG5lZWQ6CgppbiBzcmMgbm9kZToKMSkgc3VzcGVuZCB0aGUgZGV2
aWNlCjIpIGdldCBsYXN0X2F2YWlsX2lkeCB2aWEgZ2V0X3ZxX3N0YXRlKCkKCmluIHRoZSBkc3Qg
bm9kZToKMykgc2V0IGxhc3RfYXZhaWxfaWR4IHZpYSBzZXRfdnFfc3RhdGUoKQo0KSByZXN1bWUg
dGhlIGRldmljZQoKU28geW91IGNhbiBzZWUsIHN0ZXAgMiByZXF1aXJlcyB0aGUgZGV2aWNlL2Ry
aXZlciBub3QgdG8gZm9yZ2V0IHRoZSAKbGFzdF9hdmFpbF9pZHguCgpUaGUgYW5ub3lpbmcgdGhp
bmcgaXMgdGhhdCwgaW4gdGhlIHZpcnRpbyBzcGVjIHRoZXJlJ3Mgbm8gZGVmaW5pdGlvbiBvZiAK
ZGV2aWNlIHN1c3BlbmRpbmcuIFNvIHdlIHJldXNlIHNldF9zdGF0dXMoMCkgcmlnaHQgbm93IGZv
ciB2cSAKc3VzcGVuZGluZy4gVGhlbiBpZiB3ZSBmb3JnZXQgbGFzdF9hdmFpbF9pZHggaW4gc2V0
X3N0YXR1cygwKSwgaXQgd2lsbCAKYnJlYWsgdGhlIGFzc3VtcHRpb24gb2Ygc3RlcCAyKS4KCgo+
Cj4+IE5lZWQgdG8gdGhpbmsgYWJvdXQgdGhhdC4gSSBzdWdnZXN0IGEgbmV3IHN0YXRlIGluIFsx
XSwgdGhlIGlzc3VlIGlzIHRoYXQKPj4gcGVvcGxlIGRvZXNuJ3QgbGlrZSB0aGUgYXN5bmNocm9u
b3VzIEFQSSB0aGF0IGl0IGludHJvZHVjZXMuCj4+Cj4+Cj4+PiBQb3NzaWJseSBpdCBjYW4gYmUg
cG9zdHBvbmVkIHRvIHdoZXJlIFZJUlRJT19DT05GSUdfU19EUklWRVJfT0sgZ2V0cyBzZXQKPj4+
IGFnYWluLCBpLmUuIHJpZ2h0IGJlZm9yZSB0aGUgc2V0dXBfZHJpdmVyKCkgaW4gbWx4NV92ZHBh
X3NldF9zdGF0dXMoKT8KPj4KPj4gTG9va3MgbGlrZSBhIGdvb2Qgd29ya2Fyb3VuZC4KCgpSZXRo
aW5rIG9mIHRoaXMsIHRoaXMgd29uJ3Qgd29yayBmb3IgdGhlIHN0ZXAgNCksIGlmIHdlIHJldXNl
IHRoZSAKU19EUklOR19PSyBmb3IgcmVzdW1pbmcuCgpUaGUgbW9zdCBjbGVhbiB3YXkgaXMgdG8g
aW52ZW50IHRoZSBmZWF0dXJlIGluIHZpcnRpbyBzcGVjIGFuZCBpbXBsZW1lbnQgCnRoYXQgaW4g
dGhlIGRyaXZlci4KClRoYW5rcwoKCgo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+IC1TaXdlaQo+Pgo+
PiBbMV0KPj4gaHR0cHM6Ly9saXN0cy5vYXNpcy1vcGVuLm9yZy9hcmNoaXZlcy92aXJ0aW8tY29t
bWVudC8yMDIwMTIvbXNnMDAwMjkuaHRtbAo+Pgo+Pgo+Pj4+IG1seDVfdmRwYV9kZXN0cm95X21y
KCZuZGV2LT5tdmRldik7Cj4+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBuZGV2LT5tdmRldi5zdGF0
dXMgPSAwOwo+Pj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVz
ID0gMDsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
