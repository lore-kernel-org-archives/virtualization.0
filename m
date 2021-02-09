Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B30C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 06:37:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23DF64D9F
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 06:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23DF64D9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 75C1B87248;
	Tue,  9 Feb 2021 06:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZ6oVvukKDVG; Tue,  9 Feb 2021 06:37:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 801B38708F;
	Tue,  9 Feb 2021 06:37:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E559C0174;
	Tue,  9 Feb 2021 06:37:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F036C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8554985FD0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qWnKNEXLuY8L
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:37:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 51F7985BDF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 06:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612852661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f45eMdlWCNGfjFr544mMESqKY7wvuw1YZDO4LRpxZ9g=;
 b=i1MG5K0wW8F40opk3OVMl7X89IsW4nrXs7SHOmfV3A3y7RAmiErJd7BHr6Sqtc955TvmCu
 xLuyDpYm45SIUhkbyP/F5yRcj8tNXlGXnKaZriiXHD6dIVAcuVAFkFOWiTBcF2NJfLqrsv
 LSBK7MgqXP9+ImsrCm/emMKXLTX3qJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-lnQfYz0bOou6AQPKSsWLow-1; Tue, 09 Feb 2021 01:37:37 -0500
X-MC-Unique: lnQfYz0bOou6AQPKSsWLow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81AD0192CC40;
 Tue,  9 Feb 2021 06:37:36 +0000 (UTC)
Received: from [10.72.13.32] (ovpn-13-32.pek2.redhat.com [10.72.13.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 16AE85D6D7;
 Tue,  9 Feb 2021 06:37:30 +0000 (UTC)
Subject: Re: [PATCH v1] vdpa/mlx5: Restore the hardware used index after
 change map
To: Eli Cohen <elic@nvidia.com>
References: <20210204073618.36336-1-elic@nvidia.com>
 <81f5ce4f-cdb0-26cd-0dce-7ada824b1b86@oracle.com>
 <f2206fa2-0ddc-1858-54e7-71614b142e46@redhat.com>
 <20210208063736.GA166546@mtl-vdi-166.wap.labs.mlnx>
 <0d592ed0-3cea-cfb0-9b7b-9d2755da3f12@redhat.com>
 <20210208100445.GA173340@mtl-vdi-166.wap.labs.mlnx>
 <379d79ff-c8b4-9acb-1ee4-16573b601973@redhat.com>
 <20210209061232.GC210455@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <411ff244-a698-a312-333a-4fdbeb3271d1@redhat.com>
Date: Tue, 9 Feb 2021 14:37:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209061232.GC210455@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Ck9uIDIwMjEvMi85IOS4i+WNiDI6MTIsIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBUdWUsIEZlYiAw
OSwgMjAyMSBhdCAxMToyMDoxNEFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiAyMDIx
LzIvOCDkuIvljYg2OjA0LCBFbGkgQ29oZW4gd3JvdGU6Cj4+PiBPbiBNb24sIEZlYiAwOCwgMjAy
MSBhdCAwNTowNDoyN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IE9uIDIwMjEvMi84
IOS4i+WNiDI6MzcsIEVsaSBDb2hlbiB3cm90ZToKPj4+Pj4gT24gTW9uLCBGZWIgMDgsIDIwMjEg
YXQgMTI6Mjc6MThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+IE9uIDIwMjEvMi82
IOS4iuWNiDc6MDcsIFNpLVdlaSBMaXUgd3JvdGU6Cj4+Pj4+Pj4gT24gMi8zLzIwMjEgMTE6MzYg
UE0sIEVsaSBDb2hlbiB3cm90ZToKPj4+Pj4+Pj4gV2hlbiBhIGNoYW5nZSBvZiBtZW1vcnkgbWFw
IG9jY3VycywgdGhlIGhhcmR3YXJlIHJlc291cmNlcyBhcmUgZGVzdHJveWVkCj4+Pj4+Pj4+IGFu
ZCB0aGVuIHJlLWNyZWF0ZWQgYWdhaW4gd2l0aCB0aGUgbmV3IG1lbW9yeSBtYXAuIEluIHN1Y2gg
Y2FzZSwgd2UgbmVlZAo+Pj4+Pj4+PiB0byByZXN0b3JlIHRoZSBoYXJkd2FyZSBhdmFpbGFibGUg
YW5kIHVzZWQgaW5kaWNlcy4gVGhlIGRyaXZlciBmYWlsZWQgdG8KPj4+Pj4+Pj4gcmVzdG9yZSB0
aGUgdXNlZCBpbmRleCB3aGljaCBpcyBhZGRlZCBoZXJlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBBbHNv
LCBzaW5jZSB0aGUgZHJpdmVyIGFsc28gZmFpbHMgdG8gcmVzZXQgdGhlIGF2YWlsYWJsZSBhbmQg
dXNlZAo+Pj4+Pj4+PiBpbmRpY2VzIHVwb24gZGV2aWNlIHJlc2V0LCBmaXggdGhpcyBoZXJlIHRv
IGF2b2lkIHJlZ3Jlc3Npb24gY2F1c2VkIGJ5Cj4+Pj4+Pj4+IHRoZSBmYWN0IHRoYXQgdXNlZCBp
bmRleCBtYXkgbm90IGJlIHplcm8gdXBvbiBkZXZpY2UgcmVzZXQuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
IEZpeGVzOiAxYTg2YjM3N2FhMjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3Vw
cG9ydGVkIG1seDUKPj4+Pj4+Pj4gZGV2aWNlcyIpCj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEVs
aSBDb2hlbjxlbGljQG52aWRpYS5jb20+Cj4+Pj4+Pj4+IC0tLQo+Pj4+Pj4+PiB2MCAtPiB2MToK
Pj4+Pj4+Pj4gQ2xlYXIgaW5kaWNlcyB1cG9uIGRldmljZSByZXNldAo+Pj4+Pj4+Pgo+Pj4+Pj4+
PiAgICDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxOCArKysrKysrKysr
KysrKysrKysKPj4+Pj4+Pj4gICAgwqAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykK
Pj4+Pj4+Pj4KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYwo+Pj4+Pj4+PiBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+
Pj4+PiBpbmRleCA4OGRkZTM0NTViZmQuLmI1ZmU2ZDJhZDIyZiAxMDA2NDQKPj4+Pj4+Pj4gLS0t
IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+Pj4+Pj4+ICsrKyBiL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4+Pj4+PiBAQCAtODcsNiArODcsNyBAQCBz
dHJ1Y3QgbWx4NV92cV9yZXN0b3JlX2luZm8gewo+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgIHU2NCBk
ZXZpY2VfYWRkcjsKPj4+Pj4+Pj4gICAgwqDCoMKgwqDCoCB1NjQgZHJpdmVyX2FkZHI7Cj4+Pj4+
Pj4+ICAgIMKgwqDCoMKgwqAgdTE2IGF2YWlsX2luZGV4Owo+Pj4+Pj4+PiArwqDCoMKgIHUxNiB1
c2VkX2luZGV4Owo+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgIGJvb2wgcmVhZHk7Cj4+Pj4+Pj4+ICAg
IMKgwqDCoMKgwqAgc3RydWN0IHZkcGFfY2FsbGJhY2sgY2I7Cj4+Pj4+Pj4+ICAgIMKgwqDCoMKg
wqAgYm9vbCByZXN0b3JlOwo+Pj4+Pj4+PiBAQCAtMTIxLDYgKzEyMiw3IEBAIHN0cnVjdCBtbHg1
X3ZkcGFfdmlydHF1ZXVlIHsKPj4+Pj4+Pj4gICAgwqDCoMKgwqDCoCB1MzIgdmlydHFfaWQ7Cj4+
Pj4+Pj4+ICAgIMKgwqDCoMKgwqAgc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXY7Cj4+Pj4+Pj4+
ICAgIMKgwqDCoMKgwqAgdTE2IGF2YWlsX2lkeDsKPj4+Pj4+Pj4gK8KgwqDCoCB1MTYgdXNlZF9p
ZHg7Cj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqAgaW50IGZ3X3N0YXRlOwo+Pj4+Pj4+PiAgICDCoCDC
oMKgwqDCoMKgIC8qIGtlZXAgbGFzdCBpbiB0aGUgc3RydWN0ICovCj4+Pj4+Pj4+IEBAIC04MDQs
NiArODA2LDcgQEAgc3RhdGljIGludCBjcmVhdGVfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFf
bmV0Cj4+Pj4+Pj4+ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWUKPj4+Pj4+Pj4gICAg
wqAgwqDCoMKgwqDCoCBvYmpfY29udGV4dCA9IE1MWDVfQUREUl9PRihjcmVhdGVfdmlydGlvX25l
dF9xX2luLCBpbiwKPj4+Pj4+Pj4gb2JqX2NvbnRleHQpOwo+Pj4+Pj4+PiAgICDCoMKgwqDCoMKg
IE1MWDVfU0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCBod19hdmFpbGFibGVf
aW5kZXgsCj4+Pj4+Pj4+IG12cS0+YXZhaWxfaWR4KTsKPj4+Pj4+Pj4gK8KgwqDCoCBNTFg1X1NF
VCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwgaHdfdXNlZF9pbmRleCwKPj4+Pj4+
Pj4gbXZxLT51c2VkX2lkeCk7Cj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqAgTUxYNV9TRVQodmlydGlv
X25ldF9xX29iamVjdCwgb2JqX2NvbnRleHQsCj4+Pj4+Pj4+IHF1ZXVlX2ZlYXR1cmVfYml0X21h
c2tfMTJfMywKPj4+Pj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2V0X2ZlYXR1cmVzXzEy
XzMobmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzKSk7Cj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqAg
dnFfY3R4ID0gTUxYNV9BRERSX09GKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LAo+
Pj4+Pj4+PiB2aXJ0aW9fcV9jb250ZXh0KTsKPj4+Pj4+Pj4gQEAgLTEwMjIsNiArMTAyNSw3IEBA
IHN0YXRpYyBpbnQgY29ubmVjdF9xcHMoc3RydWN0IG1seDVfdmRwYV9uZXQKPj4+Pj4+Pj4gKm5k
ZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptCj4+Pj4+Pj4+ICAgIMKgIHN0cnVjdCBt
bHg1X3ZpcnRxX2F0dHIgewo+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgIHU4IHN0YXRlOwo+Pj4+Pj4+
PiAgICDCoMKgwqDCoMKgIHUxNiBhdmFpbGFibGVfaW5kZXg7Cj4+Pj4+Pj4+ICvCoMKgwqAgdTE2
IHVzZWRfaW5kZXg7Cj4+Pj4+Pj4+ICAgIMKgIH07Cj4+Pj4+Pj4+ICAgIMKgIMKgIHN0YXRpYyBp
bnQgcXVlcnlfdmlydHF1ZXVlKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QKPj4+
Pj4+Pj4gbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxLAo+Pj4+Pj4+PiBAQCAtMTA1Miw2ICsxMDU2
LDcgQEAgc3RhdGljIGludCBxdWVyeV92aXJ0cXVldWUoc3RydWN0Cj4+Pj4+Pj4+IG1seDVfdmRw
YV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXUKPj4+Pj4+Pj4gICAgwqDCoMKg
wqDCoCBtZW1zZXQoYXR0ciwgMCwgc2l6ZW9mKCphdHRyKSk7Cj4+Pj4+Pj4+ICAgIMKgwqDCoMKg
wqAgYXR0ci0+c3RhdGUgPSBNTFg1X0dFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4
dCwgc3RhdGUpOwo+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgIGF0dHItPmF2YWlsYWJsZV9pbmRleCA9
IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsCj4+Pj4+Pj4+IG9ial9jb250ZXh0LCBod19h
dmFpbGFibGVfaW5kZXgpOwo+Pj4+Pj4+PiArwqDCoMKgIGF0dHItPnVzZWRfaW5kZXggPSBNTFg1
X0dFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29udGV4dCwKPj4+Pj4+Pj4gaHdfdXNlZF9p
bmRleCk7Cj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqAga2ZyZWUob3V0KTsKPj4+Pj4+Pj4gICAgwqDC
oMKgwqDCoCByZXR1cm4gMDsKPj4+Pj4+Pj4gICAgwqAgQEAgLTE1MzUsNiArMTU0MCwxNiBAQCBz
dGF0aWMgdm9pZCB0ZWFyZG93bl92aXJ0cXVldWVzKHN0cnVjdAo+Pj4+Pj4+PiBtbHg1X3ZkcGFf
bmV0ICpuZGV2KQo+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgIH0KPj4+Pj4+Pj4gICAgwqAgfQo+Pj4+
Pj4+PiAgICDCoCArc3RhdGljIHZvaWQgY2xlYXJfdmlydHF1ZXVlcyhzdHJ1Y3QgbWx4NV92ZHBh
X25ldCAqbmRldikKPj4+Pj4+Pj4gK3sKPj4+Pj4+Pj4gK8KgwqDCoCBpbnQgaTsKPj4+Pj4+Pj4g
Kwo+Pj4+Pj4+PiArwqDCoMKgIGZvciAoaSA9IG5kZXYtPm12ZGV2Lm1heF92cXMgLSAxOyBpID49
IDA7IGktLSkgewo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgbmRldi0+dnFzW2ldLmF2YWlsX2lk
eCA9IDA7Cj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCBuZGV2LT52cXNbaV0udXNlZF9pZHggPSAw
Owo+Pj4+Pj4+PiArwqDCoMKgIH0KPj4+Pj4+Pj4gK30KPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiAgICDC
oCAvKiBUT0RPOiBjcm9zcy1lbmRpYW4gc3VwcG9ydCAqLwo+Pj4+Pj4+PiAgICDCoCBzdGF0aWMg
aW5saW5lIGJvb2wgbWx4NV92ZHBhX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0IG1seDVfdmRwYV9k
ZXYKPj4+Pj4+Pj4gKm12ZGV2KQo+Pj4+Pj4+PiAgICDCoCB7Cj4+Pj4+Pj4+IEBAIC0xNjEwLDYg
KzE2MjUsNyBAQCBzdGF0aWMgaW50IHNhdmVfY2hhbm5lbF9pbmZvKHN0cnVjdAo+Pj4+Pj4+PiBt
bHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdQo+Pj4+Pj4+PiAgICDC
oMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPj4+Pj4+Pj4gICAgwqAgwqDCoMKgwqDCoCBy
aS0+YXZhaWxfaW5kZXggPSBhdHRyLmF2YWlsYWJsZV9pbmRleDsKPj4+Pj4+Pj4gK8KgwqDCoCBy
aS0+dXNlZF9pbmRleCA9IGF0dHIudXNlZF9pbmRleDsKPj4+Pj4+Pj4gICAgwqDCoMKgwqDCoCBy
aS0+cmVhZHkgPSBtdnEtPnJlYWR5Owo+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgIHJpLT5udW1fZW50
ID0gbXZxLT5udW1fZW50Owo+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgIHJpLT5kZXNjX2FkZHIgPSBt
dnEtPmRlc2NfYWRkcjsKPj4+Pj4+Pj4gQEAgLTE2NTQsNiArMTY3MCw3IEBAIHN0YXRpYyB2b2lk
IHJlc3RvcmVfY2hhbm5lbHNfaW5mbyhzdHJ1Y3QKPj4+Pj4+Pj4gbWx4NV92ZHBhX25ldCAqbmRl
dikKPj4+Pj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7Cj4+Pj4+
Pj4+ICAgIMKgIMKgwqDCoMKgwqDCoMKgwqDCoCBtdnEtPmF2YWlsX2lkeCA9IHJpLT5hdmFpbF9p
bmRleDsKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIG12cS0+dXNlZF9pZHggPSByaS0+dXNlZF9p
bmRleDsKPj4+Pj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgIG12cS0+cmVhZHkgPSByaS0+cmVh
ZHk7Cj4+Pj4+Pj4+ICAgIMKgwqDCoMKgwqDCoMKgwqDCoCBtdnEtPm51bV9lbnQgPSByaS0+bnVt
X2VudDsKPj4+Pj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgIG12cS0+ZGVzY19hZGRyID0gcmkt
PmRlc2NfYWRkcjsKPj4+Pj4+Pj4gQEAgLTE3NjgsNiArMTc4NSw3IEBAIHN0YXRpYyB2b2lkIG1s
eDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdAo+Pj4+Pj4+PiB2ZHBhX2RldmljZSAqdmRldiwgdTgg
c3RhdHVzKQo+Pj4+Pj4+PiAgICDCoMKgwqDCoMKgIGlmICghc3RhdHVzKSB7Cj4+Pj4+Pj4+ICAg
IMKgwqDCoMKgwqDCoMKgwqDCoCBtbHg1X3ZkcGFfaW5mbyhtdmRldiwgInBlcmZvcm1pbmcgZGV2
aWNlIHJlc2V0XG4iKTsKPj4+Pj4+Pj4gICAgwqDCoMKgwqDCoMKgwqDCoMKgIHRlYXJkb3duX2Ry
aXZlcihuZGV2KTsKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGNsZWFyX3ZpcnRxdWV1ZXMobmRl
dik7Cj4+Pj4+Pj4gVGhlIGNsZWFyaW5nIGxvb2tzIGZpbmUgYXQgdGhlIGZpcnN0IGdsYW5jZSwg
YXMgaXQgYWxpZ25zIHdpdGggdGhlIG90aGVyCj4+Pj4+Pj4gc3RhdGUgY2xlYW51cHMgZmxvYXRp
bmcgYXJvdW5kIGF0IHRoZSBzYW1lIHBsYWNlLiBIb3dldmVyLCB0aGUgdGhpbmcgaXMKPj4+Pj4+
PiBnZXRfdnFfc3RhdGUoKSBpcyBzdXBwb3NlZCB0byBiZSBjYWxsZWQgcmlnaHQgYWZ0ZXIgdG8g
Z2V0IHN5bmMnZWQgd2l0aAo+Pj4+Pj4+IHRoZSBsYXRlc3QgaW50ZXJuYWwgYXZhaWxfaW5kZXgg
ZnJvbSBkZXZpY2Ugd2hpbGUgdnEgaXMgc3RvcHBlZC4gVGhlCj4+Pj4+Pj4gaW5kZXggd2FzIHNh
dmVkIGluIHRoZSBkcml2ZXIgc29mdHdhcmUgYXQgdnEgc3VzcGVuc2lvbiwgYnV0IGJlZm9yZSB0
aGUKPj4+Pj4+PiB2aXJ0cSBvYmplY3QgaXMgZGVzdHJveWVkLiBXZSBzaG91bGRuJ3QgY2xlYXIg
dGhlIGF2YWlsX2luZGV4IHRvbyBlYXJseS4KPj4+Pj4+IEdvb2QgcG9pbnQuCj4+Pj4+Pgo+Pj4+
Pj4gVGhlcmUncyBhIGxpbWl0YXRpb24gb24gdGhlIHZpcnRpbyBzcGVjIGFuZCB2RFBBIGZyYW1l
d29yayB0aGF0IHdlIGNhbiBub3QKPj4+Pj4+IHNpbXBseSBkaWZmZXIgZGV2aWNlIHN1c3BlbmRp
bmcgZnJvbSBkZXZpY2UgcmVzZXQuCj4+Pj4+Pgo+Pj4+PiBBcmUgeW91IHRhbGtpbmcgYWJvdXQg
bGl2ZSBtaWdyYXRpb24gd2hlcmUgeW91IHJlc2V0IHRoZSBkZXZpY2UgYnV0Cj4+Pj4+IHN0aWxs
IHdhbnQgdG8ga25vdyBob3cgZmFyIGl0IHByb2dyZXNzZWQgaW4gb3JkZXIgdG8gY29udGludWUg
ZnJvbSB0aGUKPj4+Pj4gc2FtZSBwbGFjZSBpbiB0aGUgbmV3IFZNPwo+Pj4+IFllcy4gU28gaWYg
d2Ugd2FudCB0byBzdXBwb3J0IGxpdmUgbWlncmF0aW9uIGF0IHdlIG5lZWQ6Cj4+Pj4KPj4+PiBp
biBzcmMgbm9kZToKPj4+PiAxKSBzdXNwZW5kIHRoZSBkZXZpY2UKPj4+PiAyKSBnZXQgbGFzdF9h
dmFpbF9pZHggdmlhIGdldF92cV9zdGF0ZSgpCj4+Pj4KPj4+PiBpbiB0aGUgZHN0IG5vZGU6Cj4+
Pj4gMykgc2V0IGxhc3RfYXZhaWxfaWR4IHZpYSBzZXRfdnFfc3RhdGUoKQo+Pj4+IDQpIHJlc3Vt
ZSB0aGUgZGV2aWNlCj4+Pj4KPj4+PiBTbyB5b3UgY2FuIHNlZSwgc3RlcCAyIHJlcXVpcmVzIHRo
ZSBkZXZpY2UvZHJpdmVyIG5vdCB0byBmb3JnZXQgdGhlCj4+Pj4gbGFzdF9hdmFpbF9pZHguCj4+
Pj4KPj4+IEp1c3QgdG8gYmUgc3VyZSwgd2hhdCByZWFsbHkgbWF0dGVycyBoZXJlIGlzIHRoZSB1
c2VkIGluZGV4LiBCZWN1YXNlIHRoZQo+Pj4gdnJpcXR1ZXVlIGl0c2VsZiBpcyBjb3BpZWQgZnJv
bSB0aGUgc3JjIFZNIHRvIHRoZSBkZXN0IFZNLiBUaGUgYXZhaWxhYmxlCj4+PiBpbmRleCBpcyBh
bHJlYXkgdGhlcmUgYW5kIHdlIGtub3cgdGhlIGhhcmR3YXJlIHJlYWRzIGl0IGZyb20gdGhlcmUu
Cj4+Cj4+IFNvIGZvciAibGFzdF9hdmFpbF9pZHgiIEkgbWVhbnQgdGhlIGhhcmR3YXJlIGludGVy
bmFsIGF2YWlsIGluZGV4LiBJdCdzIG5vdAo+PiBzdG9yZWQgaW4gdGhlIHZpcnRxdWV1ZSBzbyB3
ZSBtdXN0IG1pZ3JhdGUgaXQgZnJvbSBzcmMgdG8gZGVzdCBhbmQgc2V0IHRoZW0KPj4gdGhyb3Vn
aCBzZXRfdnFfc3RhdGUoKS4gVGhlbiBpbiB0aGUgZGVzdGluYXRpb24sIHRoZSB2aXJ0cXVldWUg
Y2FuIGJlCj4+IHJlc3RhcnRlZCBmcm9tIHRoYXQgaW5kZXguCj4+Cj4gQ29uc2lkZXIgdGhpcyBj
YXNlOiBkcml2ZXIgcG9zdGVkIGJ1ZmZlcnMgdGlsbCBhdmFpbCBpbmRleCBiZWNvbWVzIHRoZQo+
IHZhbHVlIDUwLiBIYXJkd2FyZSBpcyBleGVjdXRpbmcgYnV0IG1hZGUgaXQgdGlsbCAyMCB3aGVu
IHZpcnRxdWV1ZSB3YXMKPiBzdXNwZW5kZWQgZHVlIHRvIGxpdmUgbWlncmF0aW9uIC0gdGhpcyBp
cyBpbmRpY2F0ZWQgYnkgaGFyZHdhcmUgdXNlZAo+IGluZGV4IGVxdWFsIDIwLgoKClNvIGluIHRo
aXMgY2FzZSB0aGUgdXNlZCBpbmRleCBpbiB0aGUgdmlydHF1ZXVlIHNob3VsZCBiZSAyMD8gT3Ro
ZXJ3aXNlIAp3ZSBuZWVkIG5vdCBzeW5jIHVzZWQgaW5kZXggaXRzZWxmIGJ1dCBhbGwgdGhlIHVz
ZWQgZW50cmllcyB0aGF0IGlzIG5vdCAKY29tbWl0dGVkIHRvIHRoZSB1c2VkIHJpbmcuCgoKPiBO
b3cgdGhlIHZyaXRxdWV1ZSBpcyBjb3BpZWQgdG8gdGhlIG5ldyBWTSBhbmQgdGhlCj4gaGFyZHdh
cmUgbm93IGhhcyB0byBjb250aW51ZSBleGVjdXRpb24gZnJvbSBpbmRleCAyMC4gV2UgbmVlZCB0
byB0ZWxsCj4gdGhlIGhhcmR3YXJlIHZpYSBjb25maWd1cmluZyB0aGUgbGFzdCB1c2VkX2luZGV4
LgoKCklmIHRoZSBoYXJkd2FyZSBjYW4gbm90IHN5bmMgdGhlIGluZGV4IGZyb20gdGhlIHZpcnRx
dWV1ZSwgdGhlIGRyaXZlciAKY2FuIGRvIHRoZSBzeW5jaHJvbml6YXRpb24gYnkgbWFrZSB0aGUg
bGFzdF91c2VkX2lkeCBlcXVhbHMgdG8gdXNlZCAKaW5kZXggaW4gdGhlIHZpcnRxdWV1ZS4KClRo
YW5rcwoKCj4gICBTbyB3aHkgZG9uJ3Qgd2UKPiByZXN0b3JlIHRoZSB1c2VkIGluZGV4Pwo+Cj4+
PiBTbyBpdCBwdXp6bGVzIG1lIHdoeSBpcyBzZXRfdnFfc3RhdGUoKSB3ZSBkbyBub3QgY29tbXVu
aWNhdGUgdGhlIHNhdmVkCj4+PiB1c2VkIGluZGV4Lgo+Pgo+PiBXZSBkb24ndCBkbyB0aGF0IHNp
bmNlOgo+Pgo+PiAxKSBpZiB0aGUgaGFyZHdhcmUgY2FuIHN5bmMgaXRzIGludGVybmFsIHVzZWQg
aW5kZXggZnJvbSB0aGUgdmlydHF1ZXVlCj4+IGR1cmluZyBkZXZpY2UsIHRoZW4gd2UgZG9uJ3Qg
bmVlZCBpdAo+PiAyKSBpZiB0aGUgaGFyZHdhcmUgY2FuIG5vdCBzeW5jIGl0cyBpbnRlcm5hbCB1
c2VkIGluZGV4LCB0aGUgZHJpdmVyIChlLmcgYXMKPj4geW91IGRpZCBoZXJlKSBjYW4gZG8gdGhh
dC4KPj4KPj4gQnV0IHRoZXJlJ3Mgbm8gd2F5IGZvciB0aGUgaGFyZHdhcmUgdG8gZGVkdWNlIHRo
ZSBpbnRlcm5hbCBhdmFpbCBpbmRleCBmcm9tCj4+IHRoZSB2aXJ0cXVldWUsIHRoYXQncyB3aHkg
YXZhaWwgaW5kZXggaXMgc3ljbmVkLgo+Pgo+PiBUaGFua3MKPj4KPj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
