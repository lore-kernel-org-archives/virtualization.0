Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2611BC433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 10:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C238C81D47;
	Mon, 10 Jan 2022 10:04:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id spJ3Gq1HCsJM; Mon, 10 Jan 2022 10:04:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3897181C11;
	Mon, 10 Jan 2022 10:04:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED9C3C0030;
	Mon, 10 Jan 2022 10:04:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DEA0C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 10:04:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E78604052B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 10:04:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ohzAD_Wj7n3S
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 10:04:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DE3AB400A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 10:04:30 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V1PG2qr_1641809067; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V1PG2qr_1641809067) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Jan 2022 18:04:27 +0800
MIME-Version: 1.0
message-id: <1641808716.6985362-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
date: Mon, 10 Jan 2022 17:58:36 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20220110044217-mutt-send-email-mst@kernel.org>
Cc: virtualization <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCAxMCBKYW4gMjAyMiAwNDo0OToyNSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2luIDxt
c3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMDU6MjM6MTNQ
TSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gT24gTW9uLCAxMCBKYW4gMjAyMiAxNjo1NDo1
OCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+IE9u
IE1vbiwgSmFuIDEwLCAyMDIyIGF0IDM6NTkgUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBNb24sIDEwIEphbiAyMDIyIDE1
OjQxOjI3ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gPiA+IE9uIE1vbiwgSmFuIDEwLCAyMDIyIGF0IDM6MjQgUE0gWHVhbiBaaHVvIDx4dWFuemh1
b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIE1v
biwgMTAgSmFuIDIwMjIgMTQ6NDM6MzkgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g5ZyoIDIwMjIvMS83IOS4
i+WNiDI6MzMsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+ID4gPiA+ID4gPiBJbiB0aGUgc2NlbmFy
aW8gd2hlcmUgaW5kaXJlY3QgaXMgbm90IHVzZWQsIGVhY2ggZGVzYyBjb3JyZXNwb25kcyB0byBh
bgo+ID4gPiA+ID4gPiA+ID4gZXh0cmEsIHdoaWNoIGlzIHVzZWQgdG8gcmVjb3JkIGluZm9ybWF0
aW9uIHN1Y2ggYXMgZG1hLCBmbGFncywgYW5kCj4gPiA+ID4gPiA+ID4gPiBuZXh0Lgo+ID4gPiA+
ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IEluIHRoZSBzY2VuYXJpbyBvZiB1c2luZyBpbmRpcmVj
dCwgdGhlIGFzc2lnbmVkIGRlc2MgZG9lcyBub3QgaGF2ZSB0aGUKPiA+ID4gPiA+ID4gPiA+IGNv
cnJlc3BvbmRpbmcgZXh0cmEgcmVjb3JkIGRtYSBpbmZvcm1hdGlvbiwgYW5kIHRoZSBkbWEgaW5m
b3JtYXRpb24gbXVzdAo+ID4gPiA+ID4gPiA+ID4gYmUgb2J0YWluZWQgZnJvbSB0aGUgZGVzYyB3
aGVuIHVubWFwLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggYWxs
b2NhdGVzIHRoZSBjb3JyZXNwb25kaW5nIGV4dHJhIGFycmF5IHdoZW4gaW5kaXJlY3QgZGVzYyBp
cwo+ID4gPiA+ID4gPiA+ID4gYWxsb2NhdGVkLiBUaGlzIGhhcyB0aGVzZSBhZHZhbnRhZ2VzOgo+
ID4gPiA+ID4gPiA+ID4gMS4gUmVjb3JkIHRoZSBkbWEgaW5mb3JtYXRpb24gb2YgZGVzYywgbm8g
bmVlZCB0byByZWFkIGRlc2Mgd2hlbiB1bm1hcAo+ID4gPiA+ID4gPiA+ID4gMi4gSXQgd2lsbCBi
ZSBtb3JlIGNvbnZlbmllbnQgYW5kIHVuaWZpZWQgaW4gcHJvY2Vzc2luZwo+ID4gPiA+ID4gPiA+
ID4gMy4gU29tZSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIGNhbiBiZSByZWNvcmRlZCBpbiBleHRy
YSwgd2hpY2ggd2lsbCBiZQo+ID4gPiA+ID4gPiA+ID4gICAgIHVzZWQgaW4gc3Vic2VxdWVudCBw
YXRjaGVzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUd28gcXVl
c3Rpb25zOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gMSkgSXMgdGhlcmUgYW55IHBlcmZv
cm1hbmNlIG51bWJlciBmb3IgdGhpcyBjaGFuZ2U/IEkgZ3Vlc3MgaXQgZ2l2ZXMKPiA+ID4gPiA+
ID4gPiBtb3JlIHN0cmVzcyBvbiB0aGUgY2FjaGUuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEkg
d2lsbCBhZGQgcGVyZm9ybWFuY2UgdGVzdCBkYXRhIGluIHRoZSBuZXh0IHZlcnNpb24uCj4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gMikgSXMgdGhlcmUgYSByZXF1aXJlbWVudCB0byBtaXggdGhl
IHByZSBtYXBwZWQgc2cgd2l0aCB1bm1hcHBlZCBzZz8gSWYKPiA+ID4gPiA+ID4gPiBub3QsIGEg
cGVyIHZpcnRxdWV1ZSBmbGFnIGxvb2tzIHN1ZmZpY2llbnQKPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gVGhlcmUgaXMgdGhpcyByZXF1aXJlbWVudC4gRm9yIGV4YW1wbGUsIGluIHRoZSBjYXNlIG9m
IEFGX1hEUCwgYSBwYXRja2V0Cj4gPiA+ID4gPiA+IGNvbnRhaW5zIHR3byBwYXJ0cywgb25lIGlz
IHZpcnRpb19uZXRfaGRyLCBhbmQgdGhlIG90aGVyIGlzIHRoZSBhY3R1YWwgZGF0YQo+ID4gPiA+
ID4gPiBwYWNrZXQgZnJvbSBBRl9YRFAuIFRoZSBmb3JtZXIgaXMgdW5tYXBwZWQgc2csIGFuZCB0
aGUgbGF0dGVyIGlzIHByZSBtYXBwZWQgc2cuCj4gPiA+ID4gPgo+ID4gPiA+ID4gQW55IGNoYW5j
ZSB0byBtYXAgdmlydGlvX25ldF9oZHIoKSBtYW51YWxseSBieSBBRl9YRFAgcm91dGluZSBpbiB0
aGlzIGNhc2U/Cj4gPiA+ID4KPiA+ID4gPiBXZWxsLCBpdCBpcyBpbmRlZWQgcG9zc2libGUgdG8g
ZG8gc28uIEluIHRoZSBpbmRpcmVjdCBzY2VuYXJpbywgd2UgY2FuIHJlY29yZCBpdAo+ID4gPiA+
IGluIHZyaW5nLT5zcGxpdC5kZXNjX2V4dHJhW2hlYWRdLmZsYWdzCj4gPiA+ID4KPiA+ID4gPiBU
aGVuIHdlIGhhdmUgdG8gYWdyZWUgdGhhdCB0aGVyZSBjYW4gYmUgbm8gbWl4ZWQgc2l0dWF0aW9u
Lgo+ID4gPgo+ID4gPiBJIHRoaW5rIGl0IHdvdWxkIGJlIGVhc2llciBhbmQgbGVzcyBwZXJmb3Jt
YW5jZSByZWdyZXNzaW9uIGlmIHdlIGRvbid0Cj4gPiA+IGRvIGh1Z2UgY2hhbmdlcyBpbiB0aGUg
Y29yZSB1bmxlc3MgaXQncyBhIG11c3QuCj4gPiA+Cj4gPgo+ID4gT2ssIEkgcGxhbiB0byBhZGQg
dHdvIG5ldyBpbnRlcmZhY2UgdmlydHF1ZXVlX2FkZF9vdXRidWZfZmxhZygpLAo+ID4gdmlydHF1
ZXVlX2FkZF9pbmJ1Zl9mbGFnKCkgcGFzcyBhIGZsYWcgcGFyYW1ldGVyIHRvIHZpcnRxdWV1ZV9h
ZGQoKSB0bwo+ID4gbWFyayBzZ3MgYWRkciBpcyBwcmVkbWEuCj4KPiBJIHdvdWxkIG1heWJlIGp1
c3QgZG8gYSB2YXJpYW50IHdvcmtpbmcgd2l0aCBtYXBwZWQgU0dzLgoKRG8geW91IG1lYW4gdmly
dHF1ZXVlX2FkZF9pbmJ1Zl9kbWEoKSwgdmlydHF1ZXVlX2FkZF9vdXRidWZfZG1hKCk/Cgo+Cj4g
PiBJIGRvbid0IHdhbnQgdG8gdXNlIHNnLT5kbWFfYWRkcmVzcywgc28gd2UgaGF2ZSB0byBjaGVj
ayB3aGV0aGVyIGVhY2ggc2cgdXNlcwo+ID4gZG1hX2FkZHJlc3MuIElmIGl0IGlzIG5vdCB1bmlm
aWVkLCB3ZSB3aWxsIGFsc28gaGFuZGxlIGV4Y2VwdGlvbi4KPiA+Cj4gPiA+IEJ0dywgSSBmb3Jn
b3QgdGhlIGNvbmNsdXNpb24gb2YgdGhlIGxhc3QgQUZfWERQIHNlcmllcy4gV2h5IGlzIGl0Cj4g
PiA+IGJldHRlciB0byBjaGFuZ2UgdmlydGlvX3JpbmcgaW5zdGVhZCBvZiBBRl9YRFAgKHdoaWNo
IHNlZW1zIGVhc2llcikuCj4gPgo+ID4gUmVnYXJkaW5nIHRoaXMgcXVlc3Rpb24sIEknbSBndWVz
c2luZyB5b3UgbWVhbiB0byBtYWtlIEFGX1hEUCBub3QgdXNlIERNQQo+ID4gYWRkcmVzc2VzPyBJ
bnN0ZWFkIHBhc3MgdmlydHVhbCBhZGRyZXNzZXMgdG8gdmlydGlvLgo+ID4KPiA+IEl0IHdvdWxk
IGNlcnRhaW5seSBiZSBzaW1wbGVyLCBidXQgSSB0aGluayB0aGVyZSBpcyBhIHBlcmZvcm1hbmNl
IGdhaW4gaW4gZG9pbmcKPiA+IHRoZSBETUEgbWFwcGluZyBhaGVhZCBvZiB0aW1lLgo+ID4KPiA+
IFRoYW5rcy4KPgo+IFRoYXQgd291bGQgYXQgbGVhc3QgaW4gcGFydCBkZXBlbmQgb24gd2hldGhl
ciBETUEgbWFwcGluZyBpcyBldmVudHVhbGx5IHVzZWQgOykKClllcywgc29tZSBvZiB0aGUgc2Nl
bmFyaW9zIEkgdGVzdGVkIHRoYXQgYWN0dWFsbHkgcmVxdWlyZSBkbWEgd2lsbCBnZXQKcGVyZm9y
bWFuY2UgaW1wcm92ZW1lbnRzLiBeX14KCgo+IFRlc3RpbmcgdGhlIGFjdHVhbCBnYWluIGJlZm9y
ZSB3ZSBpbnRyb2R1Y2UgY29tcGxleGl0eSBhbmQgaW5jbHVkaW5nCj4gdGhhdCBpbmZvIGluIHRo
ZSBjb21taXQgbG9nIGlzIG5vdCBhIGJhZCBpZGVhLgoKSSB3aWxsIGJyaW5nIHRoaXMgcGFydCBv
ZiB0aGUgZGF0YSBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKVGhhbmtzLgoKCj4KPiA+Cj4gPiA+Cj4g
PiA+IFRoYW5rcwo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+Cj4gPiA+ID4g
Pgo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFu
a3MuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+
Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
