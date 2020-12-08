Return-Path: <SRS0=k93m=FM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB400C4361B
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 02:49:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BD323609
	for <virtualization@archiver.kernel.org>; Tue,  8 Dec 2020 02:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BD323609
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BCCD620453;
	Tue,  8 Dec 2020 02:49:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TV1q5Coexnpx; Tue,  8 Dec 2020 02:49:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 876E120396;
	Tue,  8 Dec 2020 02:49:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 761F7C0FA7;
	Tue,  8 Dec 2020 02:49:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F131C013B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:49:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 44B0B8742D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:49:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7dwSTRSiWwRA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:49:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6F79A86B30
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 02:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607395761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HntMT6HlcO+PPg+xL5NcseaQ7qpjGnU814ibQC6Ox/I=;
 b=XEcJWlPz4DEl2Brt81ECAvqcUqsQuMgIpGRlRBk1TPUgQuiM020DKXu1xt3jBPwj4voFjV
 0NptdDWdVdPsUiWD8JCRTZTsjEhLrfr7MCyk4UuNTSZty7BwxYAgk71jQ5AeGJYpMEvWS3
 ik/Ly1IuHrW9L2P4H6s4RxFl1a0xlIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-EToiXG03Mv2XEkNJtBUdtg-1; Mon, 07 Dec 2020 21:49:14 -0500
X-MC-Unique: EToiXG03Mv2XEkNJtBUdtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0CC2800D62;
 Tue,  8 Dec 2020 02:49:12 +0000 (UTC)
Received: from [10.72.12.91] (ovpn-12-91.pek2.redhat.com [10.72.12.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ABB0C10023AD;
 Tue,  8 Dec 2020 02:49:04 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 "Enrico Weigelt, metux IT consult" <info@metux.net>,
 linux-kernel@vger.kernel.org
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <8209ce55-a4aa-f256-b9b9-f7eb3cac877b@redhat.com>
 <43f1ee89-89f3-95a3-58f1-7a0a12c2b92f@metux.net>
 <37a9fbc6-d75f-f6cd-f052-0dd416594a84@redhat.com>
 <635faeb7-950e-e594-3217-69032ed9cbd1@metux.net>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2882f118-3555-614c-33a0-30865673deb3@redhat.com>
Date: Tue, 8 Dec 2020 10:49:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <635faeb7-950e-e594-3217-69032ed9cbd1@metux.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: corbet@lwn.net, mst@redhat.com, linus.walleij@linaro.org,
 linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org,
 bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
 linux-riscv@lists.infradead.org
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

Ck9uIDIwMjAvMTIvNyDkuIvljYg1OjMzLCBFbnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3Vs
dCB3cm90ZToKPiBPbiAwNy4xMi4yMCAwNDo0OCwgSmFzb24gV2FuZyB3cm90ZToKPgo+IEhpLAo+
Cj4+Pj4gTm90IGEgbmF0aXZlIHNwZWFrZXIgYnV0IGV2ZW50IHNvdW5kcyBsaWtlIHNvbWV0aGlu
ZyBkcml2ZXIgcmVhZCBmcm9tCj4+Pj4gZGV2aWNlLiBMb29raW5nIGF0IHRoZSBiZWxvdyBsaXN0
cywgbW9zdCBvZiB0aGVtIGV4Y2VwdCBmb3IKPj4+PiBWSVJUSU9fR1BJT19FVl9IT1NUX0xFVkVM
IGxvb2tzIG1vcmUgbGlrZSBhIGNvbW1hbmQuCj4+PiBva2F5LCBzaGFsbCBJIG5hbWUgaXQgIm1l
c3NhZ2UiID8KPj4KPj4gSXQgbWlnaHQgYmUgYmV0dGVyLgo+IE9rYXksIHJlbmFtZWQgdG8gbWVz
c2FnZXMgaW4gdjMuCj4KPj4+PiAjZGVmaW5lIFZJUlRJT19ORVRfT0vCoMKgwqDCoCAwCj4+Pj4g
I2RlZmluZSBWSVJUSU9fTkVUX0VSUsKgwqDCoCAxCj4+PiBobW0sIHNvIEknZCBuZWVkIHRvIGRl
ZmluZSBhbGwgdGhlIGVycm9yIGNvZGVzIHRoYXQgcG9zc2libHkgY291bGQKPj4+IGhhcHBlbiA/
Cj4+Cj4+IFllcywgSSB0aGluayB5b3UgbmVlZC4KPiBPa2F5LCBnb2luZyB0byBkbyBpdCBpbiB0
aGUgbmV4dCB2ZXJzaW9uLgo+Cj4+Pj4gSWYgSSByZWFkIHRoZSBjb2RlIGNvcnJlY3RseSwgdGhp
cyBleHBlY3RzIHRoZXJlIHdpbGwgYmUgYXQgbW9zdCBhCj4+Pj4gc2luZ2xlIHR5cGUgb2YgZXZl
bnQgdGhhdCBjYW4gYmUgcHJvY2Vzc2VkIGF0IHRoZSBzYW1lIHRpbWUuIEUuZyBjYW4KPj4+PiB1
cHBlciBsYXllciB3YW50IHRvIHJlYWQgZnJvbSBkaWZmZXJlbnQgbGluZXMgaW4gcGFyYWxsZWw/
IElmIHllcywgd2UKPj4+PiBuZWVkIHRvIGRlYWwgd2l0aCB0aGF0Lgo+Pj4gQExpbnVzIEBCYXJ0
b3N6OiBjYW4gdGhhdCBoYXBwZW4gb3IgZG9lcyBncGlvIHN1YnN5cyBhbHJlYWR5IHNlcmlhbGl6
ZQo+Pj4gcmVxdWVzdHMgPwo+Pj4KPj4+IEluaXRpYWxseSwgSSB0cmllZCB0byBwcm90ZWN0IGl0
IGJ5IHNwaW5sb2NrIChzbywgb25seSBvbmUgcmVxdWVzdCBtYXkKPj4+IHJ1biBhdCBhIHRpbWUs
IG90aGVyIGNhbGxzIGp1c3Qgd2FpdCB1bnRpbCB0aGUgZmlyc3QgaXMgZmluaXNoZWQpLCBidXQK
Pj4+IGl0IGNyYXNoZWQgd2hlbiBncGlvIGNkZXYgcmVnaXN0cmF0aW9uIGNhbGxzIGludG8gdGhl
IGRyaXZlciAoZmV0Y2hlcwo+Pj4gdGhlIHN0YXR1cykgd2hpbGUgc3RpbGwgaW4gYm9vdHVwLgo+
Pj4KPj4+IERvbid0IHJlY2FsbCB0aGUgZXhhY3QgZXJyb3IgYW55bW9yZSwgYnV0IHNvbWV0aGlu
ZyBsaWtlIGFuCj4+PiBpbmNvbnNpc3RlbmN5IGluIHRoZSBzcGlubG9jayBjYWxscy4KPj4+Cj4+
PiBEaWQgSSBqdXN0IHVzZSB0aGUgd3JvbmcgdHlwZSBvZiBsb2NrID8KPj4gSSdtIG5vdCBzdXJl
IHNpbmNlIEkgYW0gbm90IGZhbWlsaWFyIHdpdGggR1BJTy4gQnV0IGEgcXVlc3Rpb24gaXMsIGlm
IGF0Cj4+IG1vc3Qgb25lIHJlcXVlc3QgaXMgYWxsb3dlZCwgSSdtIG5vdCBzdXJlIHZpcnRpbyBp
cyB0aGUgYmVzdCBjaG9pY2UgaGVyZQo+PiBzaW5jZSB3ZSBkb24ndCBldmVuIG5lZWQgYSBxdWV1
ZSh2aXJ0cXVldWUpIGhlcmUuCj4gSSBndWVzcywgSSBzaG91bGQgYWRkIGxvY2tzIHRvIHRoZSBn
cGlvIGNhbGxiYWNrIGZ1bmN0aW9ucyAod2hlcmUgZ3Bpbwo+IHN1YnN5cyBjYWxscyBpbikuIFRo
YXQgd2F5LCByZXF1ZXN0cyBhcmUgcmVxdWVzdHMgYXJlIHN0cmljdGx5IG9yZGVyZWQuCj4gVGhl
IGxvY2tzIGRpZG4ndCB3b3JrIGluIG15IHByZXZpb3VzIGF0dGVtcHRzLCBidXQgcHJvYmFibHkg
YmVjYXVzZSBJJ3ZlCj4gbWlzc2VkIHRvIHNldCB0aGUgY2FuX3NsZWVwIGZsYWcgKG5vdyBmaXhl
ZCBpbiB2MykuCj4KPiBUaGUgZ3BpbyBvcHMgYXJlIGFscmVhZHkgd2FpdGluZyBmb3IgcmVwbHkg
b2YgdGhlIGNvcnJlc3BvbmRpbmcgdHlwZSwgc28KPiB0aGUgb25seSBiYWQgdGhpbmcgdGhhdCBj
b3VsZCBoYXBwZW4gaXMgdGhlIHNhbWUgb3BlcmF0aW9uIGJlaW5nIGNhbGxlZAo+IHR3aWNlICh3
aGVuIGNvbWluZyBmcm9tIGRpZmZlcmVudCB0aHJlYWRzKSBhbmQgcmVwbGllcyBtaXhlZCB1cCBi
ZXR3ZWVuCj4gZmlyc3QgYW5kIHNlY29uZCBvbmUuIE9UT0ggSSBkb24ndCBzZWUgbXVjaCBwcm9i
bGVtIHcvIHRoYXQuIFRoaXMgY2FuIGJlCj4gZml4ZWQgYnkgYWRkaW5nIGEgZ2xvYmFsIGxvY2su
Cj4KPj4gSSB0aGluayBpdCdzIHN0aWxsIGFib3V0IHdoZXRoZXIgb3Igbm90IHdlIG5lZWQgYWxs
b3cgYSBiYXRjaCBvZgo+PiByZXF1ZXN0cyB2aWEgYSBxdWV1ZS4gQ29uc2lkZXIgeW91J3ZlIHN1
Ym1pdHRlZCB0d28gcmVxdWVzdCBBIGFuZCBCLCBhbmQKPj4gaWYgQiBpcyBkb25lIGZpcnN0LCBj
dXJyZW50IGNvZGUgd29uJ3Qgd29yay4gVGhpcyBpcyBiZWNhdXNlLCB0aGUgcmVwbHkKPj4gaXMg
dHJhbnNwb3J0ZWQgdmlhIHJ4cSBidWZmZXJzIG5vdCBqdXN0IHJldXNlIHRoZSB0eHEgYnVmZmVy
IGlmIEkgcmVhZAo+PiB0aGUgY29kZSBjb3JyZWN0bHkuCj4gTWVhbndoaWxlIEkndmUgY2hhbmdl
ZCBpdCB0byBhbGxvY2F0ZSBhIG5ldyByeCBidWZmZXIgZm9yIHRoZSByZXBseQo+IChkb25lIHJp
Z2h0IGJlZm9yZSB0aGUgcmVxdWVzdCBpcyBzZW50KSwgc28gZXZlcnl0aGluZyBzaG91bGQgYmUK
PiBwcm9jZXNzZWQgaW4gdGhlIG9yZGVyIGl0IGhhZCBiZWVuIHNlbnQuIEFzc3VtaW5nIHZpcnRp
byBrZWVwcyB0aGUKPiBvcmRlciBvZiB0aGUgYnVmZmVycyBpbiB0aGUgcXVldWVzLgoKClVuZm9y
dHVuYXRlbHksIHRoZXJlJ3Mgbm8gZ3VhcmFudGVlIHRoYXQgdmlydGlvIHdpbGwga2VlcCB0aGUg
b3JkZXIgb3IgCml0IG5lZWRzIHRvIGFkdmVydGlzZSBWSVJUSU9fRl9JTl9PUkRFUi4gKHNlZSAy
LjYuOSBpbiB0aGUgdmlydGlvIHNwZWMpLgoKQnR3LCBpZiBwb3NzaWJsZSwgaXQncyBiZXR0ZXIg
dG8gYWRkIGEgbGluayB0byB0aGUgdXNlcnNwYWNlIGNvZGUgaGVyZS4KCgo+Cj4+PiBDb3VsZCB5
b3UgcGxlYXNlIGdpdmUgYW4gZXhhbXBsZSBob3cgYmktZGlyZWN0aW9uYWwgdHJhbnNtaXNzaW9u
IHdpdGhpbgo+Pj4gdGhlIHNhbWUgcXVldWUgY291bGQgbG9vayBsaWtlID8KPj4gWW91IGNhbiBj
aGVjayBob3cgdmlydGlvLWJsayBkaWQgdGhpcyBpbjoKPj4KPj4gaHR0cHM6Ly9kb2NzLm9hc2lz
LW9wZW4ub3JnL3ZpcnRpby92aXJ0aW8vdjEuMS9jc3ByZDAxL3ZpcnRpby12MS4xLWNzcHJkMDEu
aHRtbCN4MS0yNTAwMDA2Cj4gaG1tLCBzdGlsbCBkb24ndCBzZWUgaG93IHRoZSBjb2RlIHdvdWxk
IGFjdHVhbGx5IGxvb2sgbGlrZS4gKGluIHFlbXUgYXMKPiB3ZWxsIGFzIGtlcm5lbCkuIEp1c3Qg
YWRkIHRoZSBmZXRjaGVkIGluYnVmIGFzIGFuIG91dGJ1ZiAod2l0aGluIHRoZQo+IHNhbWUgcXVl
dWUpID8KCgpZZXMsIHZpcnRpbyBhbGxvd3MgYWRkaW5nIElOIGJ1ZmZlcnMgYWZ0ZXIgT1VUIGJ1
ZmZlciB0aHJvdWdoIGRlc2NyaXB0b3IgCmNoYWluaW5nLgoKVGhhbmtzCgoKPgo+Pj4gTWF5YmUg
YWRkIG9uZSBuZXcgYnVmZmVyIHBlciByZXF1ZXN0IGFuZCBvbmUgbmV3IHBlciByZWNlaXZlZCBh
c3luYwo+Pj4gc2lnbmFsID8KPj4gSXQgd291bGQgYmUgc2FmZSB0byBmaWxsIHRoZSB3aG9sZSBy
eHEgYW5kIGRvIHRoZSByZWZpbGwgZS5nIHdoZW4gaGFsZgo+PiBvZiB0aGUgcXVldWUgaXMgdXNl
ZC4KPiBPa2F5LCBkb2luZyB0aGF0IG5vdyBpbiB2MzogdGhlcmUncyBhbHdheXMgYXQgbGVhc3Qg
b25lIHJ4IGJ1ZmZlciwKPiBhbmQgcmVxdWVzdHMgYXMgd2VsbCBhcyB0aGUgaW50ciByZWNlaXZl
ciBhbHdheXMgYWRkIGEgbmV3IG9uZS4KPiAodGhleSBnZXQgcmVtb3ZlZCBvbiBmZXRjaGluZywg
SU1ITykuCj4KPgo+IC0tbXR4Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
