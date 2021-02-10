Return-Path: <SRS0=QvMg=HM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2032AC433E6
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:12:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF4F64DED
	for <virtualization@archiver.kernel.org>; Wed, 10 Feb 2021 04:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF4F64DED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 612BF85643;
	Wed, 10 Feb 2021 04:12:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id imZaOF2f7dif; Wed, 10 Feb 2021 04:12:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C0F7C83509;
	Wed, 10 Feb 2021 04:12:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A71D4C0891;
	Wed, 10 Feb 2021 04:12:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 285FCC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:12:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1683583F11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:12:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gigoUXqcKskE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:12:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 20DAB83509
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Feb 2021 04:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612930345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P6Cl9KL8f7SY7V73YNj6aiJEGdKExA4CdRKAeLw3K88=;
 b=DX2zM/FZNKGHA1IuzNBLlVvEZNFRR0u89XXYr0attQBMiAysdjuTIe6RxqtvusT1m+RCtH
 ioYRx931qmofkiA78KiyTGgT51Z87ZelZ8VJ1n337fUZfLrM+PzTg6jtpiblCq7DU07wAT
 G4TcNPUxf698KluSW/O8B6SpqOuNtUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-OTILhi5nOeS-0KS4noiIZQ-1; Tue, 09 Feb 2021 23:12:23 -0500
X-MC-Unique: OTILhi5nOeS-0KS4noiIZQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 898F5107ACC7;
 Wed, 10 Feb 2021 04:12:22 +0000 (UTC)
Received: from [10.72.12.223] (ovpn-12-223.pek2.redhat.com [10.72.12.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21E735D74B;
 Wed, 10 Feb 2021 04:12:16 +0000 (UTC)
Subject: Re: [PATCH RFC v2 3/4] virtio-net: support transmit timestamp
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210208185558.995292-1-willemdebruijn.kernel@gmail.com>
 <20210208185558.995292-4-willemdebruijn.kernel@gmail.com>
 <6bfdf48d-c780-bc65-b0b9-24a33f18827b@redhat.com>
 <20210209113643-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d25bce7b-ac29-e189-c399-2c03f57202cc@redhat.com>
Date: Wed, 10 Feb 2021 12:12:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210209113643-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, richardcochran@gmail.com,
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

Ck9uIDIwMjEvMi8xMCDkuIrljYgxMjozOCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFR1ZSwgRmViIDA5LCAyMDIxIGF0IDAxOjQ1OjExUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6
Cj4+IE9uIDIwMjEvMi85IOS4iuWNiDI6NTUsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4+PiBG
cm9tOiBXaWxsZW0gZGUgQnJ1aWpuPHdpbGxlbWJAZ29vZ2xlLmNvbT4KPj4+Cj4+PiBBZGQgb3B0
aW9uYWwgUFRQIGhhcmR3YXJlIHR4IHRpbWVzdGFtcCBvZmZsb2FkIGZvciB2aXJ0aW8tbmV0Lgo+
Pj4KPj4+IEFjY3VyYXRlIFJUVCBtZWFzdXJlbWVudCByZXF1aXJlcyB0aW1lc3RhbXBzIGNsb3Nl
IHRvIHRoZSB3aXJlLgo+Pj4gSW50cm9kdWNlIHZpcnRpbyBmZWF0dXJlIFZJUlRJT19ORVRfRl9U
WF9UU1RBTVAsIHRoZSB0cmFuc21pdAo+Pj4gZXF1aXZhbGVudCB0byBWSVJUSU9fTkVUX0ZfUlhf
VFNUQU1QLgo+Pj4KPj4+IFRoZSBkcml2ZXIgc2V0cyBWSVJUSU9fTkVUX0hEUl9GX1RTVEFNUCB0
byByZXF1ZXN0IGEgdGltZXN0YW1wCj4+PiByZXR1cm5lZCBvbiBjb21wbGV0aW9uLiBJZiB0aGUg
ZmVhdHVyZSBpcyBuZWdvdGlhdGVkLCB0aGUgZGV2aWNlCj4+PiBlaXRoZXIgcGxhY2VzIHRoZSB0
aW1lc3RhbXAgb3IgY2xlYXJzIHRoZSBmZWF0dXJlIGJpdC4KPj4+Cj4+PiBUaGUgdGltZXN0YW1w
IHN0cmFkZGxlcyAodmlydHVhbCkgaGFyZHdhcmUgZG9tYWlucy4gTGlrZSBQVFAsIHVzZQo+Pj4g
aW50ZXJuYXRpb25hbCBhdG9taWMgdGltZSAoQ0xPQ0tfVEFJKSBhcyBnbG9iYWwgY2xvY2sgYmFz
ZS4gVGhlIGRyaXZlcgo+Pj4gbXVzdCBzeW5jIHdpdGggdGhlIGRldmljZSwgZS5nLiwgdGhyb3Vn
aCBrdm0tY2xvY2suCj4+Pgo+Pj4gTW9kaWZ5IGNhbl9wdXNoIHRvIGVuc3VyZSB0aGF0IG9uIHR4
IGNvbXBsZXRpb24gdGhlIGhlYWRlciwgYW5kIHRodXMKPj4+IHRpbWVzdGFtcCwgaXMgaW4gYSBw
cmVkaWNhdGFibGUgbG9jYXRpb24gYXQgc2tiX3ZuZXRfaGRyLgo+Pj4KPj4+IFJGQzogdGhpcyBp
bXBsZW1lbnRhdGlvbiByZWxpZXMgb24gdGhlIGRldmljZSB3cml0aW5nIHRvIHRoZSBidWZmZXIu
Cj4+PiBUaGF0IGJyZWFrcyBETUFfVE9fREVWSUNFIHNlbWFudGljcy4gRm9yIG5vdywgZGlzYWJs
ZSB3aGVuIERNQSBpcyBvbi4KPj4+IFRoZSB2aXJ0aW8gY2hhbmdlcyBzaG91bGQgYmUgYSBzZXBh
cmF0ZSBwYXRjaCBhdCB0aGUgbGVhc3QuCj4+Pgo+Pj4gVGVzdGVkOiBtb2RpZmllZCB0eHRpbWVz
dGFtcC5jIHRvIHdpdGggaC93IHRpbWVzdGFtcGluZzoKPj4+ICAgICAtICAgICAgIHNvY2tfb3B0
ID0gU09GX1RJTUVTVEFNUElOR19TT0ZUV0FSRSB8Cj4+PiAgICAgKyAgICAgICBzb2NrX29wdCA9
IFNPRl9USU1FU1RBTVBJTkdfUkFXX0hBUkRXQVJFIHwKPj4+ICAgICArIGRvX3Rlc3QoZmFtaWx5
LCBTT0ZfVElNRVNUQU1QSU5HX1RYX0hBUkRXQVJFKTsKPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBX
aWxsZW0gZGUgQnJ1aWpuPHdpbGxlbWJAZ29vZ2xlLmNvbT4KPj4+IC0tLQo+Pj4gICAgZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jICAgICAgICB8IDYxICsrKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0tLQo+Pj4gICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICB8ICAzICstCj4+
PiAgICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgICAgIHwgIDEgKwo+Pj4gICAgaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19uZXQuaCB8ICAxICsKPj4+ICAgIDQgZmlsZXMgY2hhbmdlZCwg
NTYgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4gaW5k
ZXggYWM0NGM1ZWZhMGJjLi5mYzhlY2QzYTMzM2EgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMKPj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4gQEAg
LTIxMCw2ICsyMTAsMTIgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4+PiAgICAJLyogRGV2aWNl
IHdpbGwgcGFzcyByeCB0aW1lc3RhbXAuIFJlcXVpcmVzIGhhc19yeF90c3RhbXAgKi8KPj4+ICAg
IAlib29sIGVuYWJsZV9yeF90c3RhbXA7Cj4+PiArCS8qIERldmljZSBjYW4gcGFzcyBDTE9DS19U
QUkgdHJhbnNtaXQgdGltZSB0byB0aGUgZHJpdmVyICovCj4+PiArCWJvb2wgaGFzX3R4X3RzdGFt
cDsKPj4+ICsKPj4+ICsJLyogRGV2aWNlIHdpbGwgcGFzcyB0eCB0aW1lc3RhbXAuIFJlcXVpcmVz
IGhhc190eF90c3RhbXAgKi8KPj4+ICsJYm9vbCBlbmFibGVfdHhfdHN0YW1wOwo+Pj4gKwo+Pj4g
ICAgCS8qIEhhcyBjb250cm9sIHZpcnRxdWV1ZSAqLwo+Pj4gICAgCWJvb2wgaGFzX2N2cTsKPj4+
IEBAIC0xNDAxLDYgKzE0MDcsMjAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3JlY2VpdmUoc3RydWN0
IHJlY2VpdmVfcXVldWUgKnJxLCBpbnQgYnVkZ2V0LAo+Pj4gICAgCXJldHVybiBzdGF0cy5wYWNr
ZXRzOwo+Pj4gICAgfQo+Pj4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfcmVjb3JkX3R4X3RzdGFtcChj
b25zdCBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsCj4+PiArCQkJCSAgICAgc3RydWN0IHNrX2J1ZmYg
KnNrYikKPj4+ICt7Cj4+PiArCWNvbnN0IHN0cnVjdCB2aXJ0aW9fbmV0X2hkcl9oYXNoX3RzICpo
ID0gc2tiX3ZuZXRfaGRyX2h0KHNrYik7Cj4+PiArCWNvbnN0IHN0cnVjdCB2aXJ0bmV0X2luZm8g
KnZpID0gc3EtPnZxLT52ZGV2LT5wcml2Owo+Pj4gKwlzdHJ1Y3Qgc2tiX3NoYXJlZF9od3RzdGFt
cHMgdHM7Cj4+PiArCj4+PiArCWlmIChoLT5oZHIuZmxhZ3MgJiBWSVJUSU9fTkVUX0hEUl9GX1RT
VEFNUCAmJgo+Pj4gKwkgICAgdmktPmVuYWJsZV90eF90c3RhbXApIHsKPj4+ICsJCXRzLmh3dHN0
YW1wID0gbnNfdG9fa3RpbWUobGU2NF90b19jcHUoaC0+dHN0YW1wKSk7Cj4+PiArCQlza2JfdHN0
YW1wX3R4KHNrYiwgJnRzKTsKPj4gVGhpcyBwcm9iYWJseSB3b24ndCB3b3JrIHNpbmNlIHRoZSBi
dWZmZXIgaXMgcmVhZC1vbmx5IGZyb20gdGhlIGRldmljZS4gKFNlZQo+PiB2aXJ0cXVldWVfYWRk
X291dGJ1ZigpKS4KPj4KPj4gQW5vdGhlciBpc3N1ZSB0aGF0IEkgdmFndWVseSByZW1lbWJlciB0
aGF0IHRoZSB2aXJ0aW8gc3BlYyBmb3JiaWRzIG91dAo+PiBidWZmZXIgYWZ0ZXIgaW4gYnVmZmVy
Lgo+IEJvdGggRHJpdmVyIFJlcXVpcmVtZW50czogTWVzc2FnZSBGcmFtaW5nIGFuZCBEcml2ZXIg
UmVxdWlyZW1lbnRzOiBTY2F0dGVyLUdhdGhlciBTdXBwb3J0Cj4gaGF2ZSB0aGlzIHN0YXRlbWVu
dDoKPgo+IAlUaGUgZHJpdmVyIE1VU1QgcGxhY2UgYW55IGRldmljZS13cml0YWJsZSBkZXNjcmlw
dG9yIGVsZW1lbnRzIGFmdGVyIGFueSBkZXZpY2UtcmVhZGFibGUgZGVzY3JpcHRvciBlbGUtCj4g
CW1lbnRzLgo+Cj4KPiBzaW1pbGFybHkKPgo+IERldmljZSBSZXF1aXJlbWVudHM6IFRoZSBWaXJ0
cXVldWUgRGVzY3JpcHRvciBUYWJsZQo+IAlBIGRldmljZSBNVVNUIE5PVCB3cml0ZSB0byBhIGRl
dmljZS1yZWFkYWJsZSBidWZmZXIsIGFuZCBhIGRldmljZSBTSE9VTEQgTk9UIHJlYWQgYSBkZXZp
Y2Utd3JpdGFibGUKPiAJYnVmZmVyLgo+Cj4KCkV4YWN0bHkuIEJ1dCBJIHdvbmRlciB3aGF0J3Mg
dGhlIHJhdGlvbmFsZSBiZWhpbmRzIHRob3NlIHJlcXVpcmVtZW50cz8KClRoYW5rcwoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
