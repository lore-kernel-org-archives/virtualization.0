Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A0C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:20:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EF064E75
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EF064E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2584D86AF9;
	Tue,  9 Feb 2021 03:20:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r2wKrxa-pBzS; Tue,  9 Feb 2021 03:20:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1289F86A35;
	Tue,  9 Feb 2021 03:20:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDC64C0174;
	Tue,  9 Feb 2021 03:20:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DFB2C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 140D786027
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wH9pjYY0kx4c
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:20:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AE4B18564D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612840824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+FLqFu/CG5siHXerfbuw2HMV/wGJuJQj6kuCshmUH8w=;
 b=dq+/pT2USdgwejC1G5utbYfR0wdJlsO6rEGsMCUXpgcRKWnqV8TkE1I7U7hoqpNERa9sMy
 tQoHlLSGti/cr7qC5Dn9EHfsz7NXtrTnlHwRj+GDmEm2tXl0s9gDbtaQ1F4xu9/vvUo09H
 81iEJavQ3boKD45pkHS0dbOh+009gcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-RjmhC9FCOYe3ubpibR5FBg-1; Mon, 08 Feb 2021 22:20:22 -0500
X-MC-Unique: RjmhC9FCOYe3ubpibR5FBg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 800C8192D788;
 Tue,  9 Feb 2021 03:20:21 +0000 (UTC)
Received: from [10.72.13.32] (ovpn-13-32.pek2.redhat.com [10.72.13.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E80885D9C0;
 Tue,  9 Feb 2021 03:20:15 +0000 (UTC)
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
To: Eli Cohen <elic@nvidia.com>
References: <20210204073618.36336-1-elic@nvidia.com>
 <81f5ce4f-cdb0-26cd-0dce-7ada824b1b86@oracle.com>
 <f2206fa2-0ddc-1858-54e7-71614b142e46@redhat.com>
 <20210208063736.GA166546@mtl-vdi-166.wap.labs.mlnx>
 <0d592ed0-3cea-cfb0-9b7b-9d2755da3f12@redhat.com>
 <20210208100445.GA173340@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <379d79ff-c8b4-9acb-1ee4-16573b601973@redhat.com>
Date: Tue, 9 Feb 2021 11:20:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210208100445.GA173340@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjEvMi84IOS4i+WNiDY6MDQsIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBNb24sIEZlYiAw
OCwgMjAyMSBhdCAwNTowNDoyN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiAyMDIx
LzIvOCDkuIvljYgyOjM3LCBFbGkgQ29oZW4gd3JvdGU6Cj4+PiBPbiBNb24sIEZlYiAwOCwgMjAy
MSBhdCAxMjoyNzoxOFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IE9uIDIwMjEvMi82
IOS4iuWNiDc6MDcsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+IE9uIDIvMy8yMDIxIDExOjM2IFBN
LCBFbGkgQ29oZW4gd3JvdGU6Cj4+Pj4+PiBXaGVuIGEgY2hhbmdlIG9mIG1lbW9yeSBtYXAgb2Nj
dXJzLCB0aGUgaGFyZHdhcmUgcmVzb3VyY2VzIGFyZSBkZXN0cm95ZWQKPj4+Pj4+IGFuZCB0aGVu
IHJlLWNyZWF0ZWQgYWdhaW4gd2l0aCB0aGUgbmV3IG1lbW9yeSBtYXAuIEluIHN1Y2ggY2FzZSwg
d2UgbmVlZAo+Pj4+Pj4gdG8gcmVzdG9yZSB0aGUgaGFyZHdhcmUgYXZhaWxhYmxlIGFuZCB1c2Vk
IGluZGljZXMuIFRoZSBkcml2ZXIgZmFpbGVkIHRvCj4+Pj4+PiByZXN0b3JlIHRoZSB1c2VkIGlu
ZGV4IHdoaWNoIGlzIGFkZGVkIGhlcmUuCj4+Pj4+Pgo+Pj4+Pj4gQWxzbywgc2luY2UgdGhlIGRy
aXZlciBhbHNvIGZhaWxzIHRvIHJlc2V0IHRoZSBhdmFpbGFibGUgYW5kIHVzZWQKPj4+Pj4+IGlu
ZGljZXMgdXBvbiBkZXZpY2UgcmVzZXQsIGZpeCB0aGlzIGhlcmUgdG8gYXZvaWQgcmVncmVzc2lv
biBjYXVzZWQgYnkKPj4+Pj4+IHRoZSBmYWN0IHRoYXQgdXNlZCBpbmRleCBtYXkgbm90IGJlIHpl
cm8gdXBvbiBkZXZpY2UgcmVzZXQuCj4+Pj4+Pgo+Pj4+Pj4gRml4ZXM6IDFhODZiMzc3YWEyMSAo
InZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NQo+Pj4+Pj4gZGV2
aWNlcyIpCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW48ZWxpY0BudmlkaWEuY29tPgo+
Pj4+Pj4gLS0tCj4+Pj4+PiB2MCAtPiB2MToKPj4+Pj4+IENsZWFyIGluZGljZXMgdXBvbiBkZXZp
Y2UgcmVzZXQKPj4+Pj4+Cj4+Pj4+PiAgIMKgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYyB8IDE4ICsrKysrKysrKysrKysrKysrKwo+Pj4+Pj4gICDCoCAxIGZpbGUgY2hhbmdlZCwg
MTggaW5zZXJ0aW9ucygrKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEv
bWx4NS9uZXQvbWx4NV92bmV0LmMKPj4+Pj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVf
dm5ldC5jCj4+Pj4+PiBpbmRleCA4OGRkZTM0NTViZmQuLmI1ZmU2ZDJhZDIyZiAxMDA2NDQKPj4+
Pj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4gKysrIGIv
ZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+PiBAQCAtODcsNiArODcsNyBA
QCBzdHJ1Y3QgbWx4NV92cV9yZXN0b3JlX2luZm8gewo+Pj4+Pj4gICDCoMKgwqDCoMKgIHU2NCBk
ZXZpY2VfYWRkcjsKPj4+Pj4+ICAgwqDCoMKgwqDCoCB1NjQgZHJpdmVyX2FkZHI7Cj4+Pj4+PiAg
IMKgwqDCoMKgwqAgdTE2IGF2YWlsX2luZGV4Owo+Pj4+Pj4gK8KgwqDCoCB1MTYgdXNlZF9pbmRl
eDsKPj4+Pj4+ICAgwqDCoMKgwqDCoCBib29sIHJlYWR5Owo+Pj4+Pj4gICDCoMKgwqDCoMKgIHN0
cnVjdCB2ZHBhX2NhbGxiYWNrIGNiOwo+Pj4+Pj4gICDCoMKgwqDCoMKgIGJvb2wgcmVzdG9yZTsK
Pj4+Pj4+IEBAIC0xMjEsNiArMTIyLDcgQEAgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgewo+
Pj4+Pj4gICDCoMKgwqDCoMKgIHUzMiB2aXJ0cV9pZDsKPj4+Pj4+ICAgwqDCoMKgwqDCoCBzdHJ1
Y3QgbWx4NV92ZHBhX25ldCAqbmRldjsKPj4+Pj4+ICAgwqDCoMKgwqDCoCB1MTYgYXZhaWxfaWR4
Owo+Pj4+Pj4gK8KgwqDCoCB1MTYgdXNlZF9pZHg7Cj4+Pj4+PiAgIMKgwqDCoMKgwqAgaW50IGZ3
X3N0YXRlOwo+Pj4+Pj4gICDCoCDCoMKgwqDCoMKgIC8qIGtlZXAgbGFzdCBpbiB0aGUgc3RydWN0
ICovCj4+Pj4+PiBAQCAtODA0LDYgKzgwNiw3IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3ZpcnRxdWV1
ZShzdHJ1Y3QgbWx4NV92ZHBhX25ldAo+Pj4+Pj4gKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmly
dHF1ZQo+Pj4+Pj4gICDCoCDCoMKgwqDCoMKgIG9ial9jb250ZXh0ID0gTUxYNV9BRERSX09GKGNy
ZWF0ZV92aXJ0aW9fbmV0X3FfaW4sIGluLAo+Pj4+Pj4gb2JqX2NvbnRleHQpOwo+Pj4+Pj4gICDC
oMKgwqDCoMKgIE1MWDVfU0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCBod19h
dmFpbGFibGVfaW5kZXgsCj4+Pj4+PiBtdnEtPmF2YWlsX2lkeCk7Cj4+Pj4+PiArwqDCoMKgIE1M
WDVfU0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCBod191c2VkX2luZGV4LAo+
Pj4+Pj4gbXZxLT51c2VkX2lkeCk7Cj4+Pj4+PiAgIMKgwqDCoMKgwqAgTUxYNV9TRVQodmlydGlv
X25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsCj4+Pj4+PiBxdWV1ZV9mZWF0dXJlX2JpdF9tYXNr
XzEyXzMsCj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdldF9mZWF0dXJlc18xMl8zKG5k
ZXYtPm12ZGV2LmFjdHVhbF9mZWF0dXJlcykpOwo+Pj4+Pj4gICDCoMKgwqDCoMKgIHZxX2N0eCA9
IE1MWDVfQUREUl9PRih2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwKPj4+Pj4+IHZp
cnRpb19xX2NvbnRleHQpOwo+Pj4+Pj4gQEAgLTEwMjIsNiArMTAyNSw3IEBAIHN0YXRpYyBpbnQg
Y29ubmVjdF9xcHMoc3RydWN0IG1seDVfdmRwYV9uZXQKPj4+Pj4+ICpuZGV2LCBzdHJ1Y3QgbWx4
NV92ZHBhX3ZpcnRxdWV1ZSAqbQo+Pj4+Pj4gICDCoCBzdHJ1Y3QgbWx4NV92aXJ0cV9hdHRyIHsK
Pj4+Pj4+ICAgwqDCoMKgwqDCoCB1OCBzdGF0ZTsKPj4+Pj4+ICAgwqDCoMKgwqDCoCB1MTYgYXZh
aWxhYmxlX2luZGV4Owo+Pj4+Pj4gK8KgwqDCoCB1MTYgdXNlZF9pbmRleDsKPj4+Pj4+ICAgwqAg
fTsKPj4+Pj4+ICAgwqAgwqAgc3RhdGljIGludCBxdWVyeV92aXJ0cXVldWUoc3RydWN0IG1seDVf
dmRwYV9uZXQgKm5kZXYsIHN0cnVjdAo+Pj4+Pj4gbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxLAo+
Pj4+Pj4gQEAgLTEwNTIsNiArMTA1Niw3IEBAIHN0YXRpYyBpbnQgcXVlcnlfdmlydHF1ZXVlKHN0
cnVjdAo+Pj4+Pj4gbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVl
dQo+Pj4+Pj4gICDCoMKgwqDCoMKgIG1lbXNldChhdHRyLCAwLCBzaXplb2YoKmF0dHIpKTsKPj4+
Pj4+ICAgwqDCoMKgwqDCoCBhdHRyLT5zdGF0ZSA9IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmpl
Y3QsIG9ial9jb250ZXh0LCBzdGF0ZSk7Cj4+Pj4+PiAgIMKgwqDCoMKgwqAgYXR0ci0+YXZhaWxh
YmxlX2luZGV4ID0gTUxYNV9HRVQodmlydGlvX25ldF9xX29iamVjdCwKPj4+Pj4+IG9ial9jb250
ZXh0LCBod19hdmFpbGFibGVfaW5kZXgpOwo+Pj4+Pj4gK8KgwqDCoCBhdHRyLT51c2VkX2luZGV4
ID0gTUxYNV9HRVQodmlydGlvX25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsCj4+Pj4+PiBod191
c2VkX2luZGV4KTsKPj4+Pj4+ICAgwqDCoMKgwqDCoCBrZnJlZShvdXQpOwo+Pj4+Pj4gICDCoMKg
wqDCoMKgIHJldHVybiAwOwo+Pj4+Pj4gICDCoCBAQCAtMTUzNSw2ICsxNTQwLDE2IEBAIHN0YXRp
YyB2b2lkIHRlYXJkb3duX3ZpcnRxdWV1ZXMoc3RydWN0Cj4+Pj4+PiBtbHg1X3ZkcGFfbmV0ICpu
ZGV2KQo+Pj4+Pj4gICDCoMKgwqDCoMKgIH0KPj4+Pj4+ICAgwqAgfQo+Pj4+Pj4gICDCoCArc3Rh
dGljIHZvaWQgY2xlYXJfdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKPj4+
Pj4+ICt7Cj4+Pj4+PiArwqDCoMKgIGludCBpOwo+Pj4+Pj4gKwo+Pj4+Pj4gK8KgwqDCoCBmb3Ig
KGkgPSBuZGV2LT5tdmRldi5tYXhfdnFzIC0gMTsgaSA+PSAwOyBpLS0pIHsKPj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBuZGV2LT52cXNbaV0uYXZhaWxfaWR4ID0gMDsKPj4+Pj4+ICvCoMKgwqDCoMKg
wqDCoCBuZGV2LT52cXNbaV0udXNlZF9pZHggPSAwOwo+Pj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+PiAr
fQo+Pj4+Pj4gKwo+Pj4+Pj4gICDCoCAvKiBUT0RPOiBjcm9zcy1lbmRpYW4gc3VwcG9ydCAqLwo+
Pj4+Pj4gICDCoCBzdGF0aWMgaW5saW5lIGJvb2wgbWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4o
c3RydWN0IG1seDVfdmRwYV9kZXYKPj4+Pj4+ICptdmRldikKPj4+Pj4+ICAgwqAgewo+Pj4+Pj4g
QEAgLTE2MTAsNiArMTYyNSw3IEBAIHN0YXRpYyBpbnQgc2F2ZV9jaGFubmVsX2luZm8oc3RydWN0
Cj4+Pj4+PiBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdQo+Pj4+
Pj4gICDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+Pj4+ICAgwqAgwqDCoMKgwqDC
oCByaS0+YXZhaWxfaW5kZXggPSBhdHRyLmF2YWlsYWJsZV9pbmRleDsKPj4+Pj4+ICvCoMKgwqAg
cmktPnVzZWRfaW5kZXggPSBhdHRyLnVzZWRfaW5kZXg7Cj4+Pj4+PiAgIMKgwqDCoMKgwqAgcmkt
PnJlYWR5ID0gbXZxLT5yZWFkeTsKPj4+Pj4+ICAgwqDCoMKgwqDCoCByaS0+bnVtX2VudCA9IG12
cS0+bnVtX2VudDsKPj4+Pj4+ICAgwqDCoMKgwqDCoCByaS0+ZGVzY19hZGRyID0gbXZxLT5kZXNj
X2FkZHI7Cj4+Pj4+PiBAQCAtMTY1NCw2ICsxNjcwLDcgQEAgc3RhdGljIHZvaWQgcmVzdG9yZV9j
aGFubmVsc19pbmZvKHN0cnVjdAo+Pj4+Pj4gbWx4NV92ZHBhX25ldCAqbmRldikKPj4+Pj4+ICAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+Pj4+PiAgIMKgIMKgwqDCoMKg
wqDCoMKgwqDCoCBtdnEtPmF2YWlsX2lkeCA9IHJpLT5hdmFpbF9pbmRleDsKPj4+Pj4+ICvCoMKg
wqDCoMKgwqDCoCBtdnEtPnVzZWRfaWR4ID0gcmktPnVzZWRfaW5kZXg7Cj4+Pj4+PiAgIMKgwqDC
oMKgwqDCoMKgwqDCoCBtdnEtPnJlYWR5ID0gcmktPnJlYWR5Owo+Pj4+Pj4gICDCoMKgwqDCoMKg
wqDCoMKgwqAgbXZxLT5udW1fZW50ID0gcmktPm51bV9lbnQ7Cj4+Pj4+PiAgIMKgwqDCoMKgwqDC
oMKgwqDCoCBtdnEtPmRlc2NfYWRkciA9IHJpLT5kZXNjX2FkZHI7Cj4+Pj4+PiBAQCAtMTc2OCw2
ICsxNzg1LDcgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3RydWN0Cj4+Pj4+
PiB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+Pj4+Pj4gICDCoMKgwqDCoMKgIGlmICgh
c3RhdHVzKSB7Cj4+Pj4+PiAgIMKgwqDCoMKgwqDCoMKgwqDCoCBtbHg1X3ZkcGFfaW5mbyhtdmRl
diwgInBlcmZvcm1pbmcgZGV2aWNlIHJlc2V0XG4iKTsKPj4+Pj4+ICAgwqDCoMKgwqDCoMKgwqDC
oMKgIHRlYXJkb3duX2RyaXZlcihuZGV2KTsKPj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBjbGVhcl92
aXJ0cXVldWVzKG5kZXYpOwo+Pj4+PiBUaGUgY2xlYXJpbmcgbG9va3MgZmluZSBhdCB0aGUgZmly
c3QgZ2xhbmNlLCBhcyBpdCBhbGlnbnMgd2l0aCB0aGUgb3RoZXIKPj4+Pj4gc3RhdGUgY2xlYW51
cHMgZmxvYXRpbmcgYXJvdW5kIGF0IHRoZSBzYW1lIHBsYWNlLiBIb3dldmVyLCB0aGUgdGhpbmcg
aXMKPj4+Pj4gZ2V0X3ZxX3N0YXRlKCkgaXMgc3VwcG9zZWQgdG8gYmUgY2FsbGVkIHJpZ2h0IGFm
dGVyIHRvIGdldCBzeW5jJ2VkIHdpdGgKPj4+Pj4gdGhlIGxhdGVzdCBpbnRlcm5hbCBhdmFpbF9p
bmRleCBmcm9tIGRldmljZSB3aGlsZSB2cSBpcyBzdG9wcGVkLiBUaGUKPj4+Pj4gaW5kZXggd2Fz
IHNhdmVkIGluIHRoZSBkcml2ZXIgc29mdHdhcmUgYXQgdnEgc3VzcGVuc2lvbiwgYnV0IGJlZm9y
ZSB0aGUKPj4+Pj4gdmlydHEgb2JqZWN0IGlzIGRlc3Ryb3llZC4gV2Ugc2hvdWxkbid0IGNsZWFy
IHRoZSBhdmFpbF9pbmRleCB0b28gZWFybHkuCj4+Pj4gR29vZCBwb2ludC4KPj4+Pgo+Pj4+IFRo
ZXJlJ3MgYSBsaW1pdGF0aW9uIG9uIHRoZSB2aXJ0aW8gc3BlYyBhbmQgdkRQQSBmcmFtZXdvcmsg
dGhhdCB3ZSBjYW4gbm90Cj4+Pj4gc2ltcGx5IGRpZmZlciBkZXZpY2Ugc3VzcGVuZGluZyBmcm9t
IGRldmljZSByZXNldC4KPj4+Pgo+Pj4gQXJlIHlvdSB0YWxraW5nIGFib3V0IGxpdmUgbWlncmF0
aW9uIHdoZXJlIHlvdSByZXNldCB0aGUgZGV2aWNlIGJ1dAo+Pj4gc3RpbGwgd2FudCB0byBrbm93
IGhvdyBmYXIgaXQgcHJvZ3Jlc3NlZCBpbiBvcmRlciB0byBjb250aW51ZSBmcm9tIHRoZQo+Pj4g
c2FtZSBwbGFjZSBpbiB0aGUgbmV3IFZNPwo+PiBZZXMuIFNvIGlmIHdlIHdhbnQgdG8gc3VwcG9y
dCBsaXZlIG1pZ3JhdGlvbiBhdCB3ZSBuZWVkOgo+Pgo+PiBpbiBzcmMgbm9kZToKPj4gMSkgc3Vz
cGVuZCB0aGUgZGV2aWNlCj4+IDIpIGdldCBsYXN0X2F2YWlsX2lkeCB2aWEgZ2V0X3ZxX3N0YXRl
KCkKPj4KPj4gaW4gdGhlIGRzdCBub2RlOgo+PiAzKSBzZXQgbGFzdF9hdmFpbF9pZHggdmlhIHNl
dF92cV9zdGF0ZSgpCj4+IDQpIHJlc3VtZSB0aGUgZGV2aWNlCj4+Cj4+IFNvIHlvdSBjYW4gc2Vl
LCBzdGVwIDIgcmVxdWlyZXMgdGhlIGRldmljZS9kcml2ZXIgbm90IHRvIGZvcmdldCB0aGUKPj4g
bGFzdF9hdmFpbF9pZHguCj4+Cj4gSnVzdCB0byBiZSBzdXJlLCB3aGF0IHJlYWxseSBtYXR0ZXJz
IGhlcmUgaXMgdGhlIHVzZWQgaW5kZXguIEJlY3Vhc2UgdGhlCj4gdnJpcXR1ZXVlIGl0c2VsZiBp
cyBjb3BpZWQgZnJvbSB0aGUgc3JjIFZNIHRvIHRoZSBkZXN0IFZNLiBUaGUgYXZhaWxhYmxlCj4g
aW5kZXggaXMgYWxyZWF5IHRoZXJlIGFuZCB3ZSBrbm93IHRoZSBoYXJkd2FyZSByZWFkcyBpdCBm
cm9tIHRoZXJlLgoKClNvIGZvciAibGFzdF9hdmFpbF9pZHgiIEkgbWVhbnQgdGhlIGhhcmR3YXJl
IGludGVybmFsIGF2YWlsIGluZGV4LiBJdCdzIApub3Qgc3RvcmVkIGluIHRoZSB2aXJ0cXVldWUg
c28gd2UgbXVzdCBtaWdyYXRlIGl0IGZyb20gc3JjIHRvIGRlc3QgYW5kIApzZXQgdGhlbSB0aHJv
dWdoIHNldF92cV9zdGF0ZSgpLiBUaGVuIGluIHRoZSBkZXN0aW5hdGlvbiwgdGhlIHZpcnRxdWV1
ZSAKY2FuIGJlIHJlc3RhcnRlZCBmcm9tIHRoYXQgaW5kZXguCgoKPgo+IFNvIGl0IHB1enpsZXMg
bWUgd2h5IGlzIHNldF92cV9zdGF0ZSgpIHdlIGRvIG5vdCBjb21tdW5pY2F0ZSB0aGUgc2F2ZWQK
PiB1c2VkIGluZGV4LgoKCldlIGRvbid0IGRvIHRoYXQgc2luY2U6CgoxKSBpZiB0aGUgaGFyZHdh
cmUgY2FuIHN5bmMgaXRzIGludGVybmFsIHVzZWQgaW5kZXggZnJvbSB0aGUgdmlydHF1ZXVlIApk
dXJpbmcgZGV2aWNlLCB0aGVuIHdlIGRvbid0IG5lZWQgaXQKMikgaWYgdGhlIGhhcmR3YXJlIGNh
biBub3Qgc3luYyBpdHMgaW50ZXJuYWwgdXNlZCBpbmRleCwgdGhlIGRyaXZlciAoZS5nIAphcyB5
b3UgZGlkIGhlcmUpIGNhbiBkbyB0aGF0LgoKQnV0IHRoZXJlJ3Mgbm8gd2F5IGZvciB0aGUgaGFy
ZHdhcmUgdG8gZGVkdWNlIHRoZSBpbnRlcm5hbCBhdmFpbCBpbmRleCAKZnJvbSB0aGUgdmlydHF1
ZXVlLCB0aGF0J3Mgd2h5IGF2YWlsIGluZGV4IGlzIHN5Y25lZC4KClRoYW5rcwoKCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
