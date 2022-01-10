Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0399C433F5
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 09:29:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AA0A60B87;
	Mon, 10 Jan 2022 09:29:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id flAFyb4ToWyS; Mon, 10 Jan 2022 09:29:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 598BE605A6;
	Mon, 10 Jan 2022 09:29:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E542C002F;
	Mon, 10 Jan 2022 09:29:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1585C001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id ABE9B605EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kga16osgbqOm
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:29:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C7549605A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 09:29:40 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V1PFzQ7_1641806975; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V1PFzQ7_1641806975) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 10 Jan 2022 17:29:35 +0800
MIME-Version: 1.0
message-id: <1641806593.3066823-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
date: Mon, 10 Jan 2022 17:23:13 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEu4MPe9DQbaphMrd3T16V9FF+Pu9uhpBue8-Pz9Q6Jk1A@mail.gmail.com>
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

T24gTW9uLCAxMCBKYW4gMjAyMiAxNjo1NDo1OCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMzo1OSBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24s
IDEwIEphbiAyMDIyIDE1OjQxOjI3ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMzoyNCBQTSBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9u
IE1vbiwgMTAgSmFuIDIwMjIgMTQ6NDM6MzkgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4KPiA+ID4gPiA+IOWcqCAyMDIyLzEvNyDkuIvljYgy
OjMzLCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gPiBJbiB0aGUgc2NlbmFyaW8gd2hlcmUg
aW5kaXJlY3QgaXMgbm90IHVzZWQsIGVhY2ggZGVzYyBjb3JyZXNwb25kcyB0byBhbgo+ID4gPiA+
ID4gPiBleHRyYSwgd2hpY2ggaXMgdXNlZCB0byByZWNvcmQgaW5mb3JtYXRpb24gc3VjaCBhcyBk
bWEsIGZsYWdzLCBhbmQKPiA+ID4gPiA+ID4gbmV4dC4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
SW4gdGhlIHNjZW5hcmlvIG9mIHVzaW5nIGluZGlyZWN0LCB0aGUgYXNzaWduZWQgZGVzYyBkb2Vz
IG5vdCBoYXZlIHRoZQo+ID4gPiA+ID4gPiBjb3JyZXNwb25kaW5nIGV4dHJhIHJlY29yZCBkbWEg
aW5mb3JtYXRpb24sIGFuZCB0aGUgZG1hIGluZm9ybWF0aW9uIG11c3QKPiA+ID4gPiA+ID4gYmUg
b2J0YWluZWQgZnJvbSB0aGUgZGVzYyB3aGVuIHVubWFwLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBUaGlzIHBhdGNoIGFsbG9jYXRlcyB0aGUgY29ycmVzcG9uZGluZyBleHRyYSBhcnJheSB3aGVu
IGluZGlyZWN0IGRlc2MgaXMKPiA+ID4gPiA+ID4gYWxsb2NhdGVkLiBUaGlzIGhhcyB0aGVzZSBh
ZHZhbnRhZ2VzOgo+ID4gPiA+ID4gPiAxLiBSZWNvcmQgdGhlIGRtYSBpbmZvcm1hdGlvbiBvZiBk
ZXNjLCBubyBuZWVkIHRvIHJlYWQgZGVzYyB3aGVuIHVubWFwCj4gPiA+ID4gPiA+IDIuIEl0IHdp
bGwgYmUgbW9yZSBjb252ZW5pZW50IGFuZCB1bmlmaWVkIGluIHByb2Nlc3NpbmcKPiA+ID4gPiA+
ID4gMy4gU29tZSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIGNhbiBiZSByZWNvcmRlZCBpbiBleHRy
YSwgd2hpY2ggd2lsbCBiZQo+ID4gPiA+ID4gPiAgICAgdXNlZCBpbiBzdWJzZXF1ZW50IHBhdGNo
ZXMuCj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IFR3byBxdWVzdGlvbnM6Cj4gPiA+ID4g
Pgo+ID4gPiA+ID4gMSkgSXMgdGhlcmUgYW55IHBlcmZvcm1hbmNlIG51bWJlciBmb3IgdGhpcyBj
aGFuZ2U/IEkgZ3Vlc3MgaXQgZ2l2ZXMKPiA+ID4gPiA+IG1vcmUgc3RyZXNzIG9uIHRoZSBjYWNo
ZS4KPiA+ID4gPgo+ID4gPiA+IEkgd2lsbCBhZGQgcGVyZm9ybWFuY2UgdGVzdCBkYXRhIGluIHRo
ZSBuZXh0IHZlcnNpb24uCj4gPiA+ID4KPiA+ID4gPiA+IDIpIElzIHRoZXJlIGEgcmVxdWlyZW1l
bnQgdG8gbWl4IHRoZSBwcmUgbWFwcGVkIHNnIHdpdGggdW5tYXBwZWQgc2c/IElmCj4gPiA+ID4g
PiBub3QsIGEgcGVyIHZpcnRxdWV1ZSBmbGFnIGxvb2tzIHN1ZmZpY2llbnQKPiA+ID4gPgo+ID4g
PiA+IFRoZXJlIGlzIHRoaXMgcmVxdWlyZW1lbnQuIEZvciBleGFtcGxlLCBpbiB0aGUgY2FzZSBv
ZiBBRl9YRFAsIGEgcGF0Y2tldAo+ID4gPiA+IGNvbnRhaW5zIHR3byBwYXJ0cywgb25lIGlzIHZp
cnRpb19uZXRfaGRyLCBhbmQgdGhlIG90aGVyIGlzIHRoZSBhY3R1YWwgZGF0YQo+ID4gPiA+IHBh
Y2tldCBmcm9tIEFGX1hEUC4gVGhlIGZvcm1lciBpcyB1bm1hcHBlZCBzZywgYW5kIHRoZSBsYXR0
ZXIgaXMgcHJlIG1hcHBlZCBzZy4KPiA+ID4KPiA+ID4gQW55IGNoYW5jZSB0byBtYXAgdmlydGlv
X25ldF9oZHIoKSBtYW51YWxseSBieSBBRl9YRFAgcm91dGluZSBpbiB0aGlzIGNhc2U/Cj4gPgo+
ID4gV2VsbCwgaXQgaXMgaW5kZWVkIHBvc3NpYmxlIHRvIGRvIHNvLiBJbiB0aGUgaW5kaXJlY3Qg
c2NlbmFyaW8sIHdlIGNhbiByZWNvcmQgaXQKPiA+IGluIHZyaW5nLT5zcGxpdC5kZXNjX2V4dHJh
W2hlYWRdLmZsYWdzCj4gPgo+ID4gVGhlbiB3ZSBoYXZlIHRvIGFncmVlIHRoYXQgdGhlcmUgY2Fu
IGJlIG5vIG1peGVkIHNpdHVhdGlvbi4KPgo+IEkgdGhpbmsgaXQgd291bGQgYmUgZWFzaWVyIGFu
ZCBsZXNzIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gaWYgd2UgZG9uJ3QKPiBkbyBodWdlIGNoYW5n
ZXMgaW4gdGhlIGNvcmUgdW5sZXNzIGl0J3MgYSBtdXN0Lgo+CgpPaywgSSBwbGFuIHRvIGFkZCB0
d28gbmV3IGludGVyZmFjZSB2aXJ0cXVldWVfYWRkX291dGJ1Zl9mbGFnKCksCnZpcnRxdWV1ZV9h
ZGRfaW5idWZfZmxhZygpIHBhc3MgYSBmbGFnIHBhcmFtZXRlciB0byB2aXJ0cXVldWVfYWRkKCkg
dG8KbWFyayBzZ3MgYWRkciBpcyBwcmVkbWEuCgpJIGRvbid0IHdhbnQgdG8gdXNlIHNnLT5kbWFf
YWRkcmVzcywgc28gd2UgaGF2ZSB0byBjaGVjayB3aGV0aGVyIGVhY2ggc2cgdXNlcwpkbWFfYWRk
cmVzcy4gSWYgaXQgaXMgbm90IHVuaWZpZWQsIHdlIHdpbGwgYWxzbyBoYW5kbGUgZXhjZXB0aW9u
LgoKPiBCdHcsIEkgZm9yZ290IHRoZSBjb25jbHVzaW9uIG9mIHRoZSBsYXN0IEFGX1hEUCBzZXJp
ZXMuIFdoeSBpcyBpdAo+IGJldHRlciB0byBjaGFuZ2UgdmlydGlvX3JpbmcgaW5zdGVhZCBvZiBB
Rl9YRFAgKHdoaWNoIHNlZW1zIGVhc2llcikuCgpSZWdhcmRpbmcgdGhpcyBxdWVzdGlvbiwgSSdt
IGd1ZXNzaW5nIHlvdSBtZWFuIHRvIG1ha2UgQUZfWERQIG5vdCB1c2UgRE1BCmFkZHJlc3Nlcz8g
SW5zdGVhZCBwYXNzIHZpcnR1YWwgYWRkcmVzc2VzIHRvIHZpcnRpby4KCkl0IHdvdWxkIGNlcnRh
aW5seSBiZSBzaW1wbGVyLCBidXQgSSB0aGluayB0aGVyZSBpcyBhIHBlcmZvcm1hbmNlIGdhaW4g
aW4gZG9pbmcKdGhlIERNQSBtYXBwaW5nIGFoZWFkIG9mIHRpbWUuCgpUaGFua3MuCgoKPgo+IFRo
YW5rcwo+Cj4gPgo+ID4gVGhhbmtzLgo+ID4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+
ID4KPiA+ID4gPiBUaGFua3MuCj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGFua3MKPiA+
ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+Cj4gPgo+Cl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
