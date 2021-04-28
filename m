Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D0CC43460
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 13:11:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 205C161436
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 13:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205C161436
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8FCD6077C;
	Wed, 28 Apr 2021 13:11:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UY4S4cMGlZmu; Wed, 28 Apr 2021 13:11:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B42560C0E;
	Wed, 28 Apr 2021 13:11:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 077A0C0022;
	Wed, 28 Apr 2021 13:11:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 462A9C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 13:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3541960AE3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 13:11:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jEYVZIwT7rtO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 13:11:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 626C560BBC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619615467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F60S2PJ1+RaTbmbuAvPt9+LozPZrWdCqAvitq2IPjV8=;
 b=heivq0gwx93D1u/f8MuibQssQ9ly9Ml5UB4eab7FOxUhj6KFueZwAUuUEuP1Pou55y4Xtl
 eyNsoPjSkm3Tmj7Zl1Im6WsXAvOliP80C5vTUITlvodXmXmWRoaefnLrDYHZgwBvRHxz0v
 OZwc1tU0FdApTyfQhsp/N0slkTJrxOg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-QhXAdeguPwidVecbidxciA-1; Wed, 28 Apr 2021 09:10:58 -0400
X-MC-Unique: QhXAdeguPwidVecbidxciA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D621287300E;
 Wed, 28 Apr 2021 13:09:04 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-103.pek2.redhat.com
 [10.72.12.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D95276787D;
 Wed, 28 Apr 2021 13:08:36 +0000 (UTC)
Subject: Re: [PATCH 2/2] vDPA/ifcvf: implement doorbell mapping for ifcvf
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210428082133.6766-1-lingshan.zhu@intel.com>
 <20210428082133.6766-3-lingshan.zhu@intel.com>
 <f6d9a424-9025-3eb5-1cb4-0ff22f7bec63@redhat.com>
 <5052fced-cd9a-e453-5cb2-39cdde60a208@intel.com>
 <1984491f-cd5e-d4bc-b328-41e2f2e935fd@redhat.com>
 <ef510c97-1f1c-a121-99db-b659a5f9518c@intel.com>
 <4e0eda74-04ac-a889-471b-03fe65c65606@redhat.com>
 <f4cb4619-5634-e42d-0629-5c40f6b0dcd1@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bca66845-b16d-ee5e-807b-a3570e290813@redhat.com>
Date: Wed, 28 Apr 2021 21:08:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f4cb4619-5634-e42d-0629-5c40f6b0dcd1@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

CuWcqCAyMDIxLzQvMjgg5LiL5Y2INjoyMCwgWmh1LCBMaW5nc2hhbiDlhpnpgZM6Cj4KPgo+IE9u
IDQvMjgvMjAyMSA2OjAzIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80LzI4
IOS4i+WNiDU6NTYsIFpodSwgTGluZ3NoYW4g5YaZ6YGTOgo+Pj4KPj4+Cj4+PiBPbiA0LzI4LzIw
MjEgNToyMSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pgo+Pj4+IOWcqCAyMDIxLzQvMjgg5LiL
5Y2INDo1OSwgWmh1LCBMaW5nc2hhbiDlhpnpgZM6Cj4+Pj4+Cj4+Pj4+Cj4+Pj4+IE9uIDQvMjgv
MjAyMSA0OjQyIFBNLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4KPj4+Pj4+IOWcqCAyMDIxLzQv
Mjgg5LiL5Y2INDoyMSwgWmh1IExpbmdzaGFuIOWGmemBkzoKPj4+Pj4+PiBUaGlzIGNvbW1pdCBp
bXBsZW1lbnRzIGRvb3JiZWxsIG1hcHBpbmcgZmVhdHVyZSBmb3IgaWZjdmYuCj4+Pj4+Pj4gVGhp
cyBmZWF0dXJlIG1hcHMgdGhlIG5vdGlmeSBwYWdlIHRvIHVzZXJzcGFjZSwgdG8gZWxpbWluYXRl
Cj4+Pj4+Pj4gdm1leGl0IHdoZW4ga2ljayBhIHZxLgo+Pj4+Pj4+Cj4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogWmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+Pj4+Pj4+IC0tLQo+
Pj4+Pj4+IMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAxOCArKysrKysrKysr
KysrKysrKysKPj4+Pj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKQo+Pj4+
Pj4+Cj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMg
Cj4+Pj4+Pj4gYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+Pj4+Pj4gaW5kZXgg
ZTQ4ZTZiNzRmZTJlLi5hZmNiNzFiYzBmNTEgMTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMKPj4+Pj4+PiBAQCAtNDEzLDYgKzQxMywyMyBAQCBzdGF0aWMgaW50IGlmY3Zm
X3ZkcGFfZ2V0X3ZxX2lycShzdHJ1Y3QgCj4+Pj4+Pj4gdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+
Pj4+Pj4+IMKgwqDCoMKgwqAgcmV0dXJuIHZmLT52cmluZ1txaWRdLmlycTsKPj4+Pj4+PiDCoCB9
Cj4+Pj4+Pj4gwqAgK3N0YXRpYyBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYSAKPj4+Pj4+
PiBpZmN2Zl9nZXRfdnFfbm90aWZpY2F0aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYs
Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUxNiBpZHgpCj4+Pj4+Pj4gK3sKPj4+Pj4+PiArwqDCoMKg
IHN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPj4+Pj4+PiArwqDC
oMKgIHN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIGFyZWE7Cj4+Pj4+Pj4gKwo+Pj4+Pj4+
ICvCoMKgwqAgaWYgKHZmLT5ub3RpZnlfcGEgJSBQQUdFX1NJWkUpIHsKPj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgYXJlYS5hZGRyID0gMDsKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgYXJlYS5zaXpl
ID0gMDsKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gV2UgZG9uJ3QgbmVlZCB0aGlzIHNpbmNlOgo+Pj4+
Pj4KPj4+Pj4+IDEpIHRoZXJlJ3MgYSBjaGVjayBpbiB0aGUgdmhvc3QgdkRQQQo+Pj4+PiBJIHRo
aW5rIHlvdSBtZWFuIHRoaXMgY29kZSBibG9jayBpbiB2ZHBhLmMKPj4+Pj4gwqDCoMKgwqDCoMKg
wqAgbm90aWZ5ID0gb3BzLT5nZXRfdnFfbm90aWZpY2F0aW9uKHZkcGEsIGluZGV4KTsKPj4+Pj4g
wqDCoMKgwqDCoMKgwqAgaWYgKG5vdGlmeS5hZGRyICYgKFBBR0VfU0laRSAtIDEpKQo+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+Pj4+Cj4+Pj4+
IFRoaXMgc2hvdWxkIHdvcmssIGhvd2V2ZXIsIEkgdGhpbmsgdGhlIHBhcmVudCBkcml2ZXIgc2hv
dWxkIGVuc3VyZSAKPj4+Pj4gaXQgcGFzc2VzIGEgUEFHRV9TSVpFIGFsaWduZWQgYWRkcmVzcyB0
byB1c2Vyc3BhY2UsIHRvIGJlIHJvYnVzdCwgCj4+Pj4+IHRvIGJlIHJlbGlhYmxlLgo+Pj4+Cj4+
Pj4KPj4+PiBUaGUgcG9pbnQgaXMgcGFyZW50IGlzIHVuYXdhcmUgb2Ygd2hldGhlciBvciBub3Qg
dGhlcmUncyBhIHVzZXJzcGFjZS4KPj4+IHdoZW4gY2FsbGluZyB0aGlzLCBJIHRoaW5rIGl0IHRh
cmdldHMgYSB1c2Vyc2FwY2UgcHJvZ3JhbSwgd2h5IAo+Pj4ga2VybmVsIHNwYWNlIG5lZWQgaXQs
IHNvIElNSE8gbm8gaGFybSBpZiB3ZSBjaGVjayB0aGlzIHRvIGtlZXAgdGhlIAo+Pj4gcGFyZW50
IGRyaXZlciByb2J1c3QuCj4+Cj4+Cj4+IEFnYWluLCB2RFBBIGRldmljZSBpcyB1bmF3YXJlIG9m
IHdoYXQgZHJpdmVyIHRoYXQgaXMgYm91bmQuIEl0IGNvdWxkIAo+PiBiZSB2aXJ0aW8tdnBkYSwg
dmhvc3QtdmRwYSBvciBvdGhlciBpbiB0aGUgZnV0dXJlLiBJdCdzIG9ubHkgdGhlIHZEUEEgCj4+
IGJ1cyBkcml2ZXIga25vdyBob3cgaXQgaXMgYWN0dWFsbHkgdXNlZC4KPj4KPj4KPj4+Pgo+Pj4+
Cj4+Pj4+PiAyKSBkZXZpY2UgaXMgdW5hd2FyZSBvZiB0aGUgYm91bmQgZHJpdmVyLCBub24gcGFn
ZSBhbGlnbmVkIAo+Pj4+Pj4gZG9vcmJlbGwgZG9lc24ndCBuZWNlc3NhcmlseSBtZWFudCBpdCBj
YW4gYmUgdXNlZAo+Pj4+PiBZZXMsIG5vbiBwYWdlIGFsaWduZWQgZG9vcmJlbGwgY2FuIG5vdCBi
ZSB1c2VkLCBzbyB0aGVyZSBpcyBhIGNoZWNrLgo+Pj4+Cj4+Pj4KPj4+PiBUeXBvLCB3aGF0IEkg
bWVhbnQgaXMgIml0IGNhbid0IGJlIHVzZWQiLiBUaGF0IGlzIHRvIHNheSwgd2Ugc2hvdWxkIAo+
Pj4+IGxldCB0aGUgdkRQQSBidXMgZHJpdmVyIHRvIGRlY2lkZSB3aGV0aGVyIG9yIG5vdCBpdCBj
YW4gYmUgdXNlZC4KPj4+IElmIGl0IGlzIG5vdCBwYWdlIGFsaWduZWQsIHRoZXJlIHdvdWxkIGJl
IGV4dHJhIGNvbXBsZXhpdGllcyBmb3IgCj4+PiB2aG9zdC9xZW11LCBJIHNlZSBpdCBhcyBhIGhh
cmR3YXJlIGRlZmVjdCwgCj4+Cj4+Cj4+IEl0IGlzIGFsbG93ZWQgYnkgdGhlIHZpcnRpbyBzcGVj
LCBpc24ndCBpdD8KPiBUaGUgc3BlYyBkb2VzIG5vdCByZXF1aXJlIHRoZSBkb29yYmVsbCB0byBi
ZSBwYWdlIHNpemUgYWxpZ25lZCwgCj4gaG93ZXZlciBpdCBzdGlsbCBhIGhhcmR3YXJlIGRlZmVj
dCBpZiBub24gcGFnZSBzaXplIGFsaWduZWQgbm90aWZ5IAo+IGJhc2UgcHJlc2VudCwgSSB3aWxs
IGxlYXZlIGEgd2FybmluZyBtZXNzYWdlIGhlcmUgaW5zdGVhZCBvZiB0aGUgMCB2YWx1ZS4KPgoK
QW5vdGhlciBub3RlIGlzIHRoYXQsIHVzaW5nIFBBR0VfU0laRSBpcyB3cm9uZyBoZXJlIHNpbmNl
IGl0IHZhcmllcyAKYW1vbmcgYXJjaHMgKGF0IG1vc3QgNjRLIG9uIHNvbWUgb25lKS4KClRoYW5r
cwoKCj4gVGhhbmtzCj4gWmh1IExpbmdzaGFuCj4+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gd2h5IGFk
YXB0IHRvIHRoaXMga2luZCBvZiBkZWZlY3RzPwo+Pj4KPj4+IFRoYW5rcwo+Pj4gWmh1IExpbmdz
aGFuCj4+Pj4KPj4+PiBUaGFua3MKPj4+Pgo+Pj4+Cj4+Pj4+Cj4+Pj4+IFRoYW5rcwo+Pj4+PiBa
aHUgTGluZ3NoYW4KPj4+Pj4+Cj4+Pj4+PiBMZXQncyBsZWF2ZSB0aG9zZSBwb2xpY2VzIHRvIHRo
ZSBkcml2ZXIuCj4+Pj4+Pgo+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+PiArwqDC
oMKgIH0gZWxzZSB7Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGFyZWEuYWRkciA9IHZmLT5ub3Rp
ZnlfcGE7Cj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGFyZWEuc2l6ZSA9IFBBR0VfU0laRTsKPj4+
Pj4+PiArwqDCoMKgIH0KPj4+Pj4+PiArCj4+Pj4+Pj4gK8KgwqDCoCByZXR1cm4gYXJlYTsKPj4+
Pj4+PiArfQo+Pj4+Pj4+ICsKPj4+Pj4+PiDCoCAvKgo+Pj4+Pj4+IMKgwqAgKiBJRkNWRiBjdXJy
ZW50bHkgZG9lcyd0IGhhdmUgb24tY2hpcCBJT01NVSwgc28gbm90Cj4+Pj4+Pj4gwqDCoCAqIGlt
cGxlbWVudGVkIHNldF9tYXAoKS9kbWFfbWFwKCkvZG1hX3VubWFwKCkKPj4+Pj4+PiBAQCAtNDQw
LDYgKzQ1Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIAo+Pj4+Pj4+
IGlmY192ZHBhX29wcyA9ewo+Pj4+Pj4+IMKgwqDCoMKgwqAgLmdldF9jb25maWfCoMKgwqAgPSBp
ZmN2Zl92ZHBhX2dldF9jb25maWcsCj4+Pj4+Pj4gwqDCoMKgwqDCoCAuc2V0X2NvbmZpZ8KgwqDC
oCA9IGlmY3ZmX3ZkcGFfc2V0X2NvbmZpZywKPj4+Pj4+PiDCoMKgwqDCoMKgIC5zZXRfY29uZmln
X2NiwqAgPSBpZmN2Zl92ZHBhX3NldF9jb25maWdfY2IsCj4+Pj4+Pj4gK8KgwqDCoCAuZ2V0X3Zx
X25vdGlmaWNhdGlvbiA9IGlmY3ZmX2dldF92cV9ub3RpZmljYXRpb24sCj4+Pj4+Pj4gwqAgfTsK
Pj4+Pj4+PiDCoCDCoCBzdGF0aWMgaW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2
LCBjb25zdCBzdHJ1Y3QgCj4+Pj4+Pj4gcGNpX2RldmljZV9pZCAqaWQpCj4+Pj4+Pgo+Pj4+Pgo+
Pj4+Cj4+Pgo+Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
