Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27079C47080
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 03:11:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD7766136E
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 03:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7766136E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AD4B605B3;
	Tue,  1 Jun 2021 03:11:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IUDiQg-f6xFs; Tue,  1 Jun 2021 03:11:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BAA16059E;
	Tue,  1 Jun 2021 03:11:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6C9AC000D;
	Tue,  1 Jun 2021 03:11:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE16CC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:11:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0B036059E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:11:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7tYbVM6A6Im0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:11:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 577BB605B3
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 03:11:21 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R261e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0UapPeeG_1622517077; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UapPeeG_1622517077) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 01 Jun 2021 11:11:17 +0800
MIME-Version: 1.0
Message-Id: <1622516885.7439268-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio-net: get build_skb() buf by data ptr
Date: Tue, 01 Jun 2021 11:08:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <b7dde035-b770-35c2-5e08-d81df4023a90@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCAxIEp1biAyMDIxIDExOjAzOjM3ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIxLzUvMzEg5LiL5Y2INjo1OCwgWHVhbiBaaHVv
IOWGmemBkzoKPiA+IE9uIE1vbiwgMzEgTWF5IDIwMjEgMTQ6MTA6NTUgKzA4MDAsIEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+IOWcqCAyMDIxLzUvMTQg5LiL5Y2I
MTE6MTYsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPj4+IEluIHRoZSBjYXNlIG9mIG1lcmdlLCB0aGUg
cGFnZSBwYXNzZWQgaW50byBwYWdlX3RvX3NrYigpIG1heSBiZSBhIGhlYWQKPiA+Pj4gcGFnZSwg
bm90IHRoZSBwYWdlIHdoZXJlIHRoZSBjdXJyZW50IGRhdGEgaXMgbG9jYXRlZC4KPiA+Pgo+ID4+
IEkgZG9uJ3QgZ2V0IGhvdyB0aGlzIGNhbiBoYXBwZW4/Cj4gPj4KPiA+PiBNYXliZSB5b3UgY2Fu
IGV4cGxhaW4gYSBsaXR0bGUgYml0IG1vcmU/Cj4gPj4KPiA+PiByZWNlaXZlX21lcmdlYWJsZSgp
IGNhbGwgcGFnZV90b19za2IoKSBpbiB0d28gcGxhY2VzOgo+ID4+Cj4gPj4gMSkgWERQX1BBU1Mg
Zm9yIGxpbmVhcml6ZWQgcGFnZSAsIGluIHRoaXMgY2FzZSB3ZSB1c2UgeGRwX3BhZ2UKPiA+PiAy
KSBwYWdlX3RvX3NrYigpIGZvciAibm9ybWFsIiBwYWdlLCBpbiB0aGlzIGNhc2UgdGhlIHBhZ2Ug
Y29udGFpbnMgdGhlIGRhdGEKPiA+IFRoZSBvZmZzZXQgbWF5IGJlIGdyZWF0ZXIgdGhhbiBQQUdF
X1NJWkUsIGJlY2F1c2UgcGFnZSBpcyBvYnRhaW5lZCBieQo+ID4gdmlydF90b19oZWFkX3BhZ2Uo
KSwgbm90IHRoZSBwYWdlIHdoZXJlIGJ1ZiBpcyBsb2NhdGVkLiBBbmQgIm9mZnNldCIgaXMgdGhl
IG9mZnNldAo+ID4gb2YgYnVmIHJlbGF0aXZlIHRvIHBhZ2UuCj4gPgo+ID4gCXRhaWxyb29tID0g
dHJ1ZXNpemUgLSBsZW4gLSBvZmZzZXQ7Cj4gPgo+ID4gSW4gdGhpcyBjYXNlLCB0aGUgdGFpbHJv
b20gbXVzdCBiZSBsZXNzIHRoYW4gMC4gQWx0aG91Z2ggdGhlcmUgbWF5IGJlIGVub3VnaAo+ID4g
Y29udGVudCBvbiB0aGlzIHBhZ2UgdG8gc2F2ZSBza2Jfc2hhcmVkX2luZm8uCj4KPgo+IEludGVy
ZXN0aW5nLCBJIHRoaW5rIHdlIGRvbid0IHVzZSBjb21wb3VuZCBwYWdlcyBmb3IgdmlydGlvLW5l
dC4gKFdlCj4gZG9uJ3QgZGVmaW5lIFNLQl9GUkFHX1BBR0VfT1JERVIpLgo+Cj4gQW0gSSB3cm9u
Zz8KCgpJdCBzZWVtcyB0byBtZSB0aGF0IGl0IHNlZW1zIHRvIGJlIGEgZml4ZWQgc2V0dGluZywg
bm90IGZvciB1cyB0byBjb25maWd1cmUKaW5kZXBlbmRlbnRseQoKVGhhbmtzLgoKPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CgpuZXQvc29jay5jCgojZGVmaW5lIFNL
Ql9GUkFHX1BBR0VfT1JERVIJZ2V0X29yZGVyKDMyNzY4KQpERUZJTkVfU1RBVElDX0tFWV9GQUxT
RShuZXRfaGlnaF9vcmRlcl9hbGxvY19kaXNhYmxlX2tleSk7CgovKioKICogc2tiX3BhZ2VfZnJh
Z19yZWZpbGwgLSBjaGVjayB0aGF0IGEgcGFnZV9mcmFnIGNvbnRhaW5zIGVub3VnaCByb29tCiAq
IEBzejogbWluaW11bSBzaXplIG9mIHRoZSBmcmFnbWVudCB3ZSB3YW50IHRvIGdldAogKiBAcGZy
YWc6IHBvaW50ZXIgdG8gcGFnZV9mcmFnCiAqIEBnZnA6IHByaW9yaXR5IGZvciBtZW1vcnkgYWxs
b2NhdGlvbgogKgogKiBOb3RlOiBXaGlsZSB0aGlzIGFsbG9jYXRvciB0cmllcyB0byB1c2UgaGln
aCBvcmRlciBwYWdlcywgdGhlcmUgaXMKICogbm8gZ3VhcmFudGVlIHRoYXQgYWxsb2NhdGlvbnMg
c3VjY2VlZC4gVGhlcmVmb3JlLCBAc3ogTVVTVCBiZQogKiBsZXNzIG9yIGVxdWFsIHRoYW4gUEFH
RV9TSVpFLgogKi8KYm9vbCBza2JfcGFnZV9mcmFnX3JlZmlsbCh1bnNpZ25lZCBpbnQgc3osIHN0
cnVjdCBwYWdlX2ZyYWcgKnBmcmFnLCBnZnBfdCBnZnApCnsKCWlmIChwZnJhZy0+cGFnZSkgewoJ
CWlmIChwYWdlX3JlZl9jb3VudChwZnJhZy0+cGFnZSkgPT0gMSkgewoJCQlwZnJhZy0+b2Zmc2V0
ID0gMDsKCQkJcmV0dXJuIHRydWU7CgkJfQoJCWlmIChwZnJhZy0+b2Zmc2V0ICsgc3ogPD0gcGZy
YWctPnNpemUpCgkJCXJldHVybiB0cnVlOwoJCXB1dF9wYWdlKHBmcmFnLT5wYWdlKTsKCX0KCglw
ZnJhZy0+b2Zmc2V0ID0gMDsKCWlmIChTS0JfRlJBR19QQUdFX09SREVSICYmCgkgICAgIXN0YXRp
Y19icmFuY2hfdW5saWtlbHkoJm5ldF9oaWdoX29yZGVyX2FsbG9jX2Rpc2FibGVfa2V5KSkgewoJ
CS8qIEF2b2lkIGRpcmVjdCByZWNsYWltIGJ1dCBhbGxvdyBrc3dhcGQgdG8gd2FrZSAqLwoJCXBm
cmFnLT5wYWdlID0gYWxsb2NfcGFnZXMoKGdmcCAmIH5fX0dGUF9ESVJFQ1RfUkVDTEFJTSkgfAoJ
CQkJCSAgX19HRlBfQ09NUCB8IF9fR0ZQX05PV0FSTiB8CgkJCQkJICBfX0dGUF9OT1JFVFJZLAoJ
CQkJCSAgU0tCX0ZSQUdfUEFHRV9PUkRFUik7CgkJaWYgKGxpa2VseShwZnJhZy0+cGFnZSkpIHsK
CQkJcGZyYWctPnNpemUgPSBQQUdFX1NJWkUgPDwgU0tCX0ZSQUdfUEFHRV9PUkRFUjsKCQkJcmV0
dXJuIHRydWU7CgkJfQoJfQoJcGZyYWctPnBhZ2UgPSBhbGxvY19wYWdlKGdmcCk7CglpZiAobGlr
ZWx5KHBmcmFnLT5wYWdlKSkgewoJCXBmcmFnLT5zaXplID0gUEFHRV9TSVpFOwoJCXJldHVybiB0
cnVlOwoJfQoJcmV0dXJuIGZhbHNlOwp9CkVYUE9SVF9TWU1CT0woc2tiX3BhZ2VfZnJhZ19yZWZp
bGwpOwoKCj4KPiBUaGFua3MKPgo+Cj4gPgo+ID4gVGhhbmtzLgo+ID4KPiA+PiBUaGFua3MKPiA+
Pgo+ID4+Cj4gPj4+IFNvIHdoZW4gdHJ5aW5nIHRvCj4gPj4+IGdldCB0aGUgYnVmIHdoZXJlIHRo
ZSBkYXRhIGlzIGxvY2F0ZWQsIHlvdSBzaG91bGQgZGlyZWN0bHkgdXNlIHRoZQo+ID4+PiBwb2lu
dGVyKHApIHRvIGdldCB0aGUgYWRkcmVzcyBjb3JyZXNwb25kaW5nIHRvIHRoZSBwYWdlLgo+ID4+
Pgo+ID4+PiBBdCB0aGUgc2FtZSB0aW1lLCB0aGUgb2Zmc2V0IG9mIHRoZSBkYXRhIGluIHRoZSBw
YWdlIHNob3VsZCBhbHNvIGJlCj4gPj4+IG9idGFpbmVkIHVzaW5nIG9mZnNldF9pbl9wYWdlKCku
Cj4gPj4+Cj4gPj4+IFRoaXMgcGF0Y2ggc29sdmVzIHRoaXMgcHJvYmxlbS4gQnV0IGlmIHlvdSBk
b27igJl0IHVzZSB0aGlzIHBhdGNoLCB0aGUKPiA+Pj4gb3JpZ2luYWwgY29kZSBjYW4gYWxzbyBy
dW4sIGJlY2F1c2UgaWYgdGhlIHBhZ2UgaXMgbm90IHRoZSBwYWdlIG9mIHRoZQo+ID4+PiBjdXJy
ZW50IGRhdGEsIHRoZSBjYWxjdWxhdGVkIHRhaWxyb29tIHdpbGwgYmUgbGVzcyB0aGFuIDAsIGFu
ZCB3aWxsIG5vdAo+ID4+PiBlbnRlciB0aGUgbG9naWMgb2YgYnVpbGRfc2tiKCkgLiBUaGUgc2ln
bmlmaWNhbmNlIG9mIHRoaXMgcGF0Y2ggaXMgdG8KPiA+Pj4gbW9kaWZ5IHRoaXMgbG9naWNhbCBw
cm9ibGVtLCBhbGxvd2luZyBtb3JlIHNpdHVhdGlvbnMgdG8gdXNlCj4gPj4+IGJ1aWxkX3NrYigp
Lgo+ID4+Pgo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgo+ID4+PiBBY2tlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4KPiA+Pj4gLS0tCj4gPj4+ICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDggKysr
KysrLS0KPiA+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBi
L2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+PiBpbmRleCAzZTQ2YzEyZGRlMDguLjA3M2Zl
YzRjMGRmMSAxMDA2NDQKPiA+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPj4+
ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+PiBAQCAtNDA3LDggKzQwNywxMiBA
QCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8g
KnZpLAo+ID4+PiAgICAJCSAqIHNlZSBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUoKSArIGdldF9tZXJn
ZWFibGVfYnVmX2xlbigpCj4gPj4+ICAgIAkJICovCj4gPj4+ICAgIAkJdHJ1ZXNpemUgPSBQQUdF
X1NJWkU7Cj4gPj4+IC0JCXRhaWxyb29tID0gdHJ1ZXNpemUgLSBsZW4gLSBvZmZzZXQ7Cj4gPj4+
IC0JCWJ1ZiA9IHBhZ2VfYWRkcmVzcyhwYWdlKTsKPiA+Pj4gKwo+ID4+PiArCQkvKiBwYWdlIG1h
eWJlIGhlYWQgcGFnZSwgc28gd2Ugc2hvdWxkIGdldCB0aGUgYnVmIGJ5IHAsIG5vdCB0aGUKPiA+
Pj4gKwkJICogcGFnZQo+ID4+PiArCQkgKi8KPiA+Pj4gKwkJdGFpbHJvb20gPSB0cnVlc2l6ZSAt
IGxlbiAtIG9mZnNldF9pbl9wYWdlKHApOwo+ID4+PiArCQlidWYgPSAoY2hhciAqKSgodW5zaWdu
ZWQgbG9uZylwICYgUEFHRV9NQVNLKTsKPiA+Pj4gICAgCX0gZWxzZSB7Cj4gPj4+ICAgIAkJdGFp
bHJvb20gPSB0cnVlc2l6ZSAtIGxlbjsKPiA+Pj4gICAgCQlidWYgPSBwOwo+Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
