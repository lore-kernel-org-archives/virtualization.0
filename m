Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6179AC433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 02:19:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B792A64D74
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 02:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B792A64D74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7759A83FF4;
	Thu, 18 Feb 2021 02:19:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IkWZaEcdq2ak; Thu, 18 Feb 2021 02:19:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BFDB483336;
	Thu, 18 Feb 2021 02:19:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9073AC000F;
	Thu, 18 Feb 2021 02:19:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFBF2C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 02:19:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BAECA86234
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 02:19:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2-fjj8nX597x
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 02:19:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 57D1B862D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 02:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613614751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oEPKtTgrc4YzD3mfk0Ov5baKrhMLojrx5gD3FzHnF7c=;
 b=BfjdoBdNL7GXj55Ip9cZJCajdzF0ZQGhfvvn8G8pIILZPGWEbVSzUZRpsaMeHwuWPcvgmm
 MQ85ZySpzsUPhfoUOJ6fffhCk7Oo0cPnA01WVsfX0OSnpfA+0e2Wa4bRxkaaGhv1bPaUmX
 6AIKaKx+lRJJeaoyhi/XxlsoiF8P8iE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-w1bAZqm7MIifojaTZnr1uQ-1; Wed, 17 Feb 2021 21:19:07 -0500
X-MC-Unique: w1bAZqm7MIifojaTZnr1uQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48C4318A08C0;
 Thu, 18 Feb 2021 02:19:05 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-162.pek2.redhat.com
 [10.72.13.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC80F19C46;
 Thu, 18 Feb 2021 02:18:57 +0000 (UTC)
Subject: Re: [PATCH netdev] virtio-net: support XDP_TX when not more queues
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <81abae33fc8dbec37ef0061ff6f6fd696b484a3e.1610523188.git.xuanzhuo@linux.alibaba.com>
 <20210210163945-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <bbd43240-c677-da41-8e6f-6a1550c220a8@redhat.com>
Date: Thu, 18 Feb 2021 10:18:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210210163945-mutt-send-email-mst@kernel.org>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, dust.li@linux.alibaba.com,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

Ck9uIDIwMjEvMi8xMSA1OjQwIOS4iuWNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+IE9u
IFdlZCwgSmFuIDEzLCAyMDIxIGF0IDA0OjA4OjU3UE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToK
Pj4gVGhlIG51bWJlciBvZiBxdWV1ZXMgaW1wbGVtZW50ZWQgYnkgbWFueSB2aXJ0aW8gYmFja2Vu
ZHMgaXMgbGltaXRlZCwKPj4gZXNwZWNpYWxseSBzb21lIG1hY2hpbmVzIGhhdmUgYSBsYXJnZSBu
dW1iZXIgb2YgQ1BVcy4gSW4gdGhpcyBjYXNlLCBpdAo+PiBpcyBvZnRlbiBpbXBvc3NpYmxlIHRv
IGFsbG9jYXRlIGEgc2VwYXJhdGUgcXVldWUgZm9yIFhEUF9UWC4KPj4KPj4gVGhpcyBwYXRjaCBh
bGxvd3MgWERQX1RYIHRvIHJ1biBieSByZXVzZSB0aGUgZXhpc3RpbmcgU1Egd2l0aAo+PiBfX25l
dGlmX3R4X2xvY2soKSBob2xkIHdoZW4gdGhlcmUgYXJlIG5vdCBlbm91Z2ggcXVldWVzLgo+Pgo+
PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+
PiBSZXZpZXdlZC1ieTogRHVzdCBMaSA8ZHVzdC5saUBsaW51eC5hbGliYWJhLmNvbT4KPiBJJ2Qg
bGlrZSB0byBnZXQgc29tZSBhZHZpY2Ugb24gd2hldGhlciB0aGlzIGlzIG9rIGZyb20gc29tZQo+
IFhEUCBleHBlcnRzIC0gcHJldmlvdXNseSBteSB1bmRlcnN0YW5kaW5nIHdhcyB0aGF0IGl0IGlz
Cj4gcHJlZmVyYWJsZSB0byBkaXNhYmxlIFhEUCBmb3Igc3VjaCBkZXZpY2VzIHRoYW4KPiB1c2Ug
bG9ja3Mgb24gWERQIGZhc3QgcGF0aC4KCgpJIHRoaW5rIHRoaXMgaXMgYWNjZXB0YWJsZSBvbiB0
aGUgZGV2aWNlIHRoYXQgY2hhbmdpbmcgdGhlIG51bWJlciBvZiAKcXVldWVzIGlzIG5vdCBlYXN5
LiBGb3IgdmlydGlvLW5ldCwgaXQgcHJvYmFibHkgcmVxdWlyZXMgYSBsb3Qgb2YgCmNoYW5nZXMg
aW4gdGhlIG1hbmFnZW1lbnQuCgpBbm90aGVyIGV4YW1wbGUgaXMgVFVOIHdoaWNoIHVzZSBUWCBs
b2NrIGZvciBYRFAuCgpUaGFua3MKCgo+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+
Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4+IGluZGV4IGJhOGU2MzcuLjdhM2IyYTcgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
Pj4gQEAgLTE5NSw2ICsxOTUsOSBAQCBzdHJ1Y3QgdmlydG5ldF9pbmZvIHsKPj4gICAJLyogIyBv
ZiBYRFAgcXVldWUgcGFpcnMgY3VycmVudGx5IHVzZWQgYnkgdGhlIGRyaXZlciAqLwo+PiAgIAl1
MTYgeGRwX3F1ZXVlX3BhaXJzOwo+PiAgIAo+PiArCS8qIHhkcF9xdWV1ZV9wYWlycyBtYXkgYmUg
MCwgd2hlbiB4ZHAgaXMgYWxyZWFkeSBsb2FkZWQuIFNvIGFkZCB0aGlzLiAqLwo+PiArCWJvb2wg
eGRwX2VuYWJsZWQ7Cj4+ICsKPj4gICAJLyogSSBsaWtlLi4uIGJpZyBwYWNrZXRzIGFuZCBJIGNh
bm5vdCBsaWUhICovCj4+ICAgCWJvb2wgYmlnX3BhY2tldHM7Cj4+ICAgCj4+IEBAIC00ODEsMTQg
KzQ4NCwzNCBAQCBzdGF0aWMgaW50IF9fdmlydG5ldF94ZHBfeG1pdF9vbmUoc3RydWN0IHZpcnRu
ZXRfaW5mbyAqdmksCj4+ICAgCXJldHVybiAwOwo+PiAgIH0KPj4gICAKPj4gLXN0YXRpYyBzdHJ1
Y3Qgc2VuZF9xdWV1ZSAqdmlydG5ldF94ZHBfc3Eoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4+
ICtzdGF0aWMgc3RydWN0IHNlbmRfcXVldWUgKnZpcnRuZXRfZ2V0X3hkcF9zcShzdHJ1Y3Qgdmly
dG5ldF9pbmZvICp2aSkKPj4gICB7Cj4+ICAgCXVuc2lnbmVkIGludCBxcDsKPj4gKwlzdHJ1Y3Qg
bmV0ZGV2X3F1ZXVlICp0eHE7Cj4+ICsKPj4gKwlpZiAodmktPmN1cnJfcXVldWVfcGFpcnMgPiBu
cl9jcHVfaWRzKSB7Cj4+ICsJCXFwID0gdmktPmN1cnJfcXVldWVfcGFpcnMgLSB2aS0+eGRwX3F1
ZXVlX3BhaXJzICsgc21wX3Byb2Nlc3Nvcl9pZCgpOwo+PiArCX0gZWxzZSB7Cj4+ICsJCXFwID0g
c21wX3Byb2Nlc3Nvcl9pZCgpICUgdmktPmN1cnJfcXVldWVfcGFpcnM7Cj4+ICsJCXR4cSA9IG5l
dGRldl9nZXRfdHhfcXVldWUodmktPmRldiwgcXApOwo+PiArCQlfX25ldGlmX3R4X2xvY2sodHhx
LCByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpKTsKPj4gKwl9Cj4+ICAgCj4+IC0JcXAgPSB2aS0+Y3Vy
cl9xdWV1ZV9wYWlycyAtIHZpLT54ZHBfcXVldWVfcGFpcnMgKyBzbXBfcHJvY2Vzc29yX2lkKCk7
Cj4+ICAgCXJldHVybiAmdmktPnNxW3FwXTsKPj4gICB9Cj4+ICAgCj4+ICtzdGF0aWMgdm9pZCB2
aXJ0bmV0X3B1dF94ZHBfc3Eoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4+ICt7Cj4+ICsJdW5z
aWduZWQgaW50IHFwOwo+PiArCXN0cnVjdCBuZXRkZXZfcXVldWUgKnR4cTsKPj4gKwo+PiArCWlm
ICh2aS0+Y3Vycl9xdWV1ZV9wYWlycyA8PSBucl9jcHVfaWRzKSB7Cj4+ICsJCXFwID0gc21wX3By
b2Nlc3Nvcl9pZCgpICUgdmktPmN1cnJfcXVldWVfcGFpcnM7Cj4+ICsJCXR4cSA9IG5ldGRldl9n
ZXRfdHhfcXVldWUodmktPmRldiwgcXApOwo+PiArCQlfX25ldGlmX3R4X3VubG9jayh0eHEpOwo+
PiArCX0KPj4gK30KPj4gKwo+PiAgIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfeG1pdChzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2LAo+PiAgIAkJCSAgICBpbnQgbiwgc3RydWN0IHhkcF9mcmFtZSAqKmZy
YW1lcywgdTMyIGZsYWdzKQo+PiAgIHsKPj4gQEAgLTUxMiw3ICs1MzUsNyBAQCBzdGF0aWMgaW50
IHZpcnRuZXRfeGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPj4gICAJaWYgKCF4ZHBf
cHJvZykKPj4gICAJCXJldHVybiAtRU5YSU87Cj4+ICAgCj4+IC0Jc3EgPSB2aXJ0bmV0X3hkcF9z
cSh2aSk7Cj4+ICsJc3EgPSB2aXJ0bmV0X2dldF94ZHBfc3EodmkpOwo+PiAgIAo+PiAgIAlpZiAo
dW5saWtlbHkoZmxhZ3MgJiB+WERQX1hNSVRfRkxBR1NfTUFTSykpIHsKPj4gICAJCXJldCA9IC1F
SU5WQUw7Cj4+IEBAIC01NjAsMTIgKzU4MywxMyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3ht
aXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPj4gICAJc3EtPnN0YXRzLmtpY2tzICs9IGtpY2tz
Owo+PiAgIAl1NjRfc3RhdHNfdXBkYXRlX2VuZCgmc3EtPnN0YXRzLnN5bmNwKTsKPj4gICAKPj4g
Kwl2aXJ0bmV0X3B1dF94ZHBfc3EodmkpOwo+PiAgIAlyZXR1cm4gcmV0Owo+PiAgIH0KPj4gICAK
Pj4gICBzdGF0aWMgdW5zaWduZWQgaW50IHZpcnRuZXRfZ2V0X2hlYWRyb29tKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpKQo+PiAgIHsKPj4gLQlyZXR1cm4gdmktPnhkcF9xdWV1ZV9wYWlycyA/IFZJ
UlRJT19YRFBfSEVBRFJPT00gOiAwOwo+PiArCXJldHVybiB2aS0+eGRwX2VuYWJsZWQgPyBWSVJU
SU9fWERQX0hFQURST09NIDogMDsKPj4gICB9Cj4+ICAgCj4+ICAgLyogV2UgY29weSB0aGUgcGFj
a2V0IGZvciBYRFAgaW4gdGhlIGZvbGxvd2luZyBjYXNlczoKPj4gQEAgLTE0NTcsMTIgKzE0ODEs
MTMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3BvbGwoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLCBp
bnQgYnVkZ2V0KQo+PiAgIAkJeGRwX2RvX2ZsdXNoKCk7Cj4+ICAgCj4+ICAgCWlmICh4ZHBfeG1p
dCAmIFZJUlRJT19YRFBfVFgpIHsKPj4gLQkJc3EgPSB2aXJ0bmV0X3hkcF9zcSh2aSk7Cj4+ICsJ
CXNxID0gdmlydG5ldF9nZXRfeGRwX3NxKHZpKTsKPj4gICAJCWlmICh2aXJ0cXVldWVfa2lja19w
cmVwYXJlKHNxLT52cSkgJiYgdmlydHF1ZXVlX25vdGlmeShzcS0+dnEpKSB7Cj4+ICAgCQkJdTY0
X3N0YXRzX3VwZGF0ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNwKTsKPj4gICAJCQlzcS0+c3RhdHMu
a2lja3MrKzsKPj4gICAJCQl1NjRfc3RhdHNfdXBkYXRlX2VuZCgmc3EtPnN0YXRzLnN5bmNwKTsK
Pj4gICAJCX0KPj4gKwkJdmlydG5ldF9wdXRfeGRwX3NxKHZpKTsKPj4gICAJfQo+PiAgIAo+PiAg
IAlyZXR1cm4gcmVjZWl2ZWQ7Cj4+IEBAIC0yNDE2LDEyICsyNDQxLDggQEAgc3RhdGljIGludCB2
aXJ0bmV0X3hkcF9zZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGJwZl9wcm9nICpw
cm9nLAo+PiAgIAkJeGRwX3FwID0gbnJfY3B1X2lkczsKPj4gICAKPj4gICAJLyogWERQIHJlcXVp
cmVzIGV4dHJhIHF1ZXVlcyBmb3IgWERQX1RYICovCj4+IC0JaWYgKGN1cnJfcXAgKyB4ZHBfcXAg
PiB2aS0+bWF4X3F1ZXVlX3BhaXJzKSB7Cj4+IC0JCU5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ss
ICJUb28gZmV3IGZyZWUgVFggcmluZ3MgYXZhaWxhYmxlIik7Cj4+IC0JCW5ldGRldl93YXJuKGRl
diwgInJlcXVlc3QgJWkgcXVldWVzIGJ1dCBtYXggaXMgJWlcbiIsCj4+IC0JCQkgICAgY3Vycl9x
cCArIHhkcF9xcCwgdmktPm1heF9xdWV1ZV9wYWlycyk7Cj4+IC0JCXJldHVybiAtRU5PTUVNOwo+
PiAtCX0KPj4gKwlpZiAoY3Vycl9xcCArIHhkcF9xcCA+IHZpLT5tYXhfcXVldWVfcGFpcnMpCj4+
ICsJCXhkcF9xcCA9IDA7Cj4+ICAgCj4+ICAgCW9sZF9wcm9nID0gcnRubF9kZXJlZmVyZW5jZSh2
aS0+cnFbMF0ueGRwX3Byb2cpOwo+PiAgIAlpZiAoIXByb2cgJiYgIW9sZF9wcm9nKQo+PiBAQCAt
MjQ1MywxMiArMjQ3NCwxNCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3NldChzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LCBzdHJ1Y3QgYnBmX3Byb2cgKnByb2csCj4+ICAgCW5ldGlmX3NldF9yZWFs
X251bV9yeF9xdWV1ZXMoZGV2LCBjdXJyX3FwICsgeGRwX3FwKTsKPj4gICAJdmktPnhkcF9xdWV1
ZV9wYWlycyA9IHhkcF9xcDsKPj4gICAKPj4gKwl2aS0+eGRwX2VuYWJsZWQgPSBmYWxzZTsKPj4g
ICAJaWYgKHByb2cpIHsKPj4gICAJCWZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3BhaXJz
OyBpKyspIHsKPj4gICAJCQlyY3VfYXNzaWduX3BvaW50ZXIodmktPnJxW2ldLnhkcF9wcm9nLCBw
cm9nKTsKPj4gICAJCQlpZiAoaSA9PSAwICYmICFvbGRfcHJvZykKPj4gICAJCQkJdmlydG5ldF9j
bGVhcl9ndWVzdF9vZmZsb2Fkcyh2aSk7Cj4+ICAgCQl9Cj4+ICsJCXZpLT54ZHBfZW5hYmxlZCA9
IHRydWU7Cj4+ICAgCX0KPj4gICAKPj4gICAJZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVf
cGFpcnM7IGkrKykgewo+PiBAQCAtMjUyNiw3ICsyNTQ5LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0
X3NldF9mZWF0dXJlcyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+PiAgIAlpbnQgZXJyOwo+PiAg
IAo+PiAgIAlpZiAoKGRldi0+ZmVhdHVyZXMgXiBmZWF0dXJlcykgJiBORVRJRl9GX0xSTykgewo+
PiAtCQlpZiAodmktPnhkcF9xdWV1ZV9wYWlycykKPj4gKwkJaWYgKHZpLT54ZHBfZW5hYmxlZCkK
Pj4gICAJCQlyZXR1cm4gLUVCVVNZOwo+PiAgIAo+PiAgIAkJaWYgKGZlYXR1cmVzICYgTkVUSUZf
Rl9MUk8pCj4+IC0tIAo+PiAxLjguMy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
