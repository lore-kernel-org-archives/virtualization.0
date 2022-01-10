Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4973FC433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 07:59:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D9B55405BF;
	Mon, 10 Jan 2022 07:59:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mmUOIRA8nUgH; Mon, 10 Jan 2022 07:59:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 43FA6405C1;
	Mon, 10 Jan 2022 07:59:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C1FBC0030;
	Mon, 10 Jan 2022 07:59:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D87D7C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A6DFE405BD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Ew315M6tSGm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:59:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B32EB405C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 07:59:43 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V1Ofggv_1641801579; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V1Ofggv_1641801579) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Jan 2022 15:59:40 +0800
MIME-Version: 1.0
message-id: <1641801140.4307308-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
date: Mon, 10 Jan 2022 15:52:20 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEsV-GLLUmTnBHBUou_2+urkpaV4A54cD8wwoH-6eoer=w@mail.gmail.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gTW9uLCAxMCBKYW4gMjAyMiAxNTo0MToyNyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMzoyNCBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24s
IDEwIEphbiAyMDIyIDE0OjQzOjM5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4KPiA+ID4g5ZyoIDIwMjIvMS83IOS4i+WNiDI6MzMsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiA+ID4gSW4gdGhlIHNjZW5hcmlvIHdoZXJlIGluZGlyZWN0IGlzIG5vdCB1
c2VkLCBlYWNoIGRlc2MgY29ycmVzcG9uZHMgdG8gYW4KPiA+ID4gPiBleHRyYSwgd2hpY2ggaXMg
dXNlZCB0byByZWNvcmQgaW5mb3JtYXRpb24gc3VjaCBhcyBkbWEsIGZsYWdzLCBhbmQKPiA+ID4g
PiBuZXh0Lgo+ID4gPiA+Cj4gPiA+ID4gSW4gdGhlIHNjZW5hcmlvIG9mIHVzaW5nIGluZGlyZWN0
LCB0aGUgYXNzaWduZWQgZGVzYyBkb2VzIG5vdCBoYXZlIHRoZQo+ID4gPiA+IGNvcnJlc3BvbmRp
bmcgZXh0cmEgcmVjb3JkIGRtYSBpbmZvcm1hdGlvbiwgYW5kIHRoZSBkbWEgaW5mb3JtYXRpb24g
bXVzdAo+ID4gPiA+IGJlIG9idGFpbmVkIGZyb20gdGhlIGRlc2Mgd2hlbiB1bm1hcC4KPiA+ID4g
Pgo+ID4gPiA+IFRoaXMgcGF0Y2ggYWxsb2NhdGVzIHRoZSBjb3JyZXNwb25kaW5nIGV4dHJhIGFy
cmF5IHdoZW4gaW5kaXJlY3QgZGVzYyBpcwo+ID4gPiA+IGFsbG9jYXRlZC4gVGhpcyBoYXMgdGhl
c2UgYWR2YW50YWdlczoKPiA+ID4gPiAxLiBSZWNvcmQgdGhlIGRtYSBpbmZvcm1hdGlvbiBvZiBk
ZXNjLCBubyBuZWVkIHRvIHJlYWQgZGVzYyB3aGVuIHVubWFwCj4gPiA+ID4gMi4gSXQgd2lsbCBi
ZSBtb3JlIGNvbnZlbmllbnQgYW5kIHVuaWZpZWQgaW4gcHJvY2Vzc2luZwo+ID4gPiA+IDMuIFNv
bWUgYWRkaXRpb25hbCBpbmZvcm1hdGlvbiBjYW4gYmUgcmVjb3JkZWQgaW4gZXh0cmEsIHdoaWNo
IHdpbGwgYmUKPiA+ID4gPiAgICAgdXNlZCBpbiBzdWJzZXF1ZW50IHBhdGNoZXMuCj4gPiA+Cj4g
PiA+Cj4gPiA+IFR3byBxdWVzdGlvbnM6Cj4gPiA+Cj4gPiA+IDEpIElzIHRoZXJlIGFueSBwZXJm
b3JtYW5jZSBudW1iZXIgZm9yIHRoaXMgY2hhbmdlPyBJIGd1ZXNzIGl0IGdpdmVzCj4gPiA+IG1v
cmUgc3RyZXNzIG9uIHRoZSBjYWNoZS4KPiA+Cj4gPiBJIHdpbGwgYWRkIHBlcmZvcm1hbmNlIHRl
c3QgZGF0YSBpbiB0aGUgbmV4dCB2ZXJzaW9uLgo+ID4KPiA+ID4gMikgSXMgdGhlcmUgYSByZXF1
aXJlbWVudCB0byBtaXggdGhlIHByZSBtYXBwZWQgc2cgd2l0aCB1bm1hcHBlZCBzZz8gSWYKPiA+
ID4gbm90LCBhIHBlciB2aXJ0cXVldWUgZmxhZyBsb29rcyBzdWZmaWNpZW50Cj4gPgo+ID4gVGhl
cmUgaXMgdGhpcyByZXF1aXJlbWVudC4gRm9yIGV4YW1wbGUsIGluIHRoZSBjYXNlIG9mIEFGX1hE
UCwgYSBwYXRja2V0Cj4gPiBjb250YWlucyB0d28gcGFydHMsIG9uZSBpcyB2aXJ0aW9fbmV0X2hk
ciwgYW5kIHRoZSBvdGhlciBpcyB0aGUgYWN0dWFsIGRhdGEKPiA+IHBhY2tldCBmcm9tIEFGX1hE
UC4gVGhlIGZvcm1lciBpcyB1bm1hcHBlZCBzZywgYW5kIHRoZSBsYXR0ZXIgaXMgcHJlIG1hcHBl
ZCBzZy4KPgo+IEFueSBjaGFuY2UgdG8gbWFwIHZpcnRpb19uZXRfaGRyKCkgbWFudWFsbHkgYnkg
QUZfWERQIHJvdXRpbmUgaW4gdGhpcyBjYXNlPwoKV2VsbCwgaXQgaXMgaW5kZWVkIHBvc3NpYmxl
IHRvIGRvIHNvLiBJbiB0aGUgaW5kaXJlY3Qgc2NlbmFyaW8sIHdlIGNhbiByZWNvcmQgaXQKaW4g
dnJpbmctPnNwbGl0LmRlc2NfZXh0cmFbaGVhZF0uZmxhZ3MKClRoZW4gd2UgaGF2ZSB0byBhZ3Jl
ZSB0aGF0IHRoZXJlIGNhbiBiZSBubyBtaXhlZCBzaXR1YXRpb24uCgpUaGFua3MuCgo+Cj4gVGhh
bmtzCj4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4K
PiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
