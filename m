Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFA0C433F5
	for <virtualization@archiver.kernel.org>; Tue, 11 Jan 2022 06:07:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 61168402D7;
	Tue, 11 Jan 2022 06:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UfIhXUVfT1kx; Tue, 11 Jan 2022 06:07:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CD1044023D;
	Tue, 11 Jan 2022 06:07:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A1917C002F;
	Tue, 11 Jan 2022 06:07:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03E25C001E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:07:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC4A740634
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:07:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Te4wOuLsY96j
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:07:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61EE840577
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 06:07:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V1YXIG8_1641881242; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V1YXIG8_1641881242) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 11 Jan 2022 14:07:23 +0800
MIME-Version: 1.0
message-id: <1641880660.922636-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
date: Tue, 11 Jan 2022 13:57:40 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Jason Wang <jasowang@redhat.com>
in-reply-to: <CACGkMEs70FRvHoApEG29L+C47zTS++JOFgM-G7jjbAq5oU9wPw@mail.gmail.com>
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

T24gVHVlLCAxMSBKYW4gMjAyMiAxMDo0NDo1MiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgNToyOSBQTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24s
IDEwIEphbiAyMDIyIDE2OjU0OjU4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPiA+ID4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMzo1OSBQTSBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9u
IE1vbiwgMTAgSmFuIDIwMjIgMTU6NDE6MjcgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCBKYW4gMTAsIDIwMjIgYXQgMzoyNCBQ
TSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gT24gTW9uLCAxMCBKYW4gMjAyMiAxNDo0MzozOSArMDgwMCwgSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiDlnKggMjAyMi8xLzcg5LiL5Y2IMjozMywgWHVhbiBaaHVvIOWGmemBkzoKPiA+ID4gPiA+
ID4gPiA+IEluIHRoZSBzY2VuYXJpbyB3aGVyZSBpbmRpcmVjdCBpcyBub3QgdXNlZCwgZWFjaCBk
ZXNjIGNvcnJlc3BvbmRzIHRvIGFuCj4gPiA+ID4gPiA+ID4gPiBleHRyYSwgd2hpY2ggaXMgdXNl
ZCB0byByZWNvcmQgaW5mb3JtYXRpb24gc3VjaCBhcyBkbWEsIGZsYWdzLCBhbmQKPiA+ID4gPiA+
ID4gPiA+IG5leHQuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gSW4gdGhlIHNjZW5h
cmlvIG9mIHVzaW5nIGluZGlyZWN0LCB0aGUgYXNzaWduZWQgZGVzYyBkb2VzIG5vdCBoYXZlIHRo
ZQo+ID4gPiA+ID4gPiA+ID4gY29ycmVzcG9uZGluZyBleHRyYSByZWNvcmQgZG1hIGluZm9ybWF0
aW9uLCBhbmQgdGhlIGRtYSBpbmZvcm1hdGlvbiBtdXN0Cj4gPiA+ID4gPiA+ID4gPiBiZSBvYnRh
aW5lZCBmcm9tIHRoZSBkZXNjIHdoZW4gdW5tYXAuCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gVGhpcyBwYXRjaCBhbGxvY2F0ZXMgdGhlIGNvcnJlc3BvbmRpbmcgZXh0cmEgYXJyYXkg
d2hlbiBpbmRpcmVjdCBkZXNjIGlzCj4gPiA+ID4gPiA+ID4gPiBhbGxvY2F0ZWQuIFRoaXMgaGFz
IHRoZXNlIGFkdmFudGFnZXM6Cj4gPiA+ID4gPiA+ID4gPiAxLiBSZWNvcmQgdGhlIGRtYSBpbmZv
cm1hdGlvbiBvZiBkZXNjLCBubyBuZWVkIHRvIHJlYWQgZGVzYyB3aGVuIHVubWFwCj4gPiA+ID4g
PiA+ID4gPiAyLiBJdCB3aWxsIGJlIG1vcmUgY29udmVuaWVudCBhbmQgdW5pZmllZCBpbiBwcm9j
ZXNzaW5nCj4gPiA+ID4gPiA+ID4gPiAzLiBTb21lIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gY2Fu
IGJlIHJlY29yZGVkIGluIGV4dHJhLCB3aGljaCB3aWxsIGJlCj4gPiA+ID4gPiA+ID4gPiAgICAg
dXNlZCBpbiBzdWJzZXF1ZW50IHBhdGNoZXMuCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+IFR3byBxdWVzdGlvbnM6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAx
KSBJcyB0aGVyZSBhbnkgcGVyZm9ybWFuY2UgbnVtYmVyIGZvciB0aGlzIGNoYW5nZT8gSSBndWVz
cyBpdCBnaXZlcwo+ID4gPiA+ID4gPiA+IG1vcmUgc3RyZXNzIG9uIHRoZSBjYWNoZS4KPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gSSB3aWxsIGFkZCBwZXJmb3JtYW5jZSB0ZXN0IGRhdGEgaW4gdGhl
IG5leHQgdmVyc2lvbi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAyKSBJcyB0aGVyZSBhIHJl
cXVpcmVtZW50IHRvIG1peCB0aGUgcHJlIG1hcHBlZCBzZyB3aXRoIHVubWFwcGVkIHNnPyBJZgo+
ID4gPiA+ID4gPiA+IG5vdCwgYSBwZXIgdmlydHF1ZXVlIGZsYWcgbG9va3Mgc3VmZmljaWVudAo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGVyZSBpcyB0aGlzIHJlcXVpcmVtZW50LiBGb3IgZXhh
bXBsZSwgaW4gdGhlIGNhc2Ugb2YgQUZfWERQLCBhIHBhdGNrZXQKPiA+ID4gPiA+ID4gY29udGFp
bnMgdHdvIHBhcnRzLCBvbmUgaXMgdmlydGlvX25ldF9oZHIsIGFuZCB0aGUgb3RoZXIgaXMgdGhl
IGFjdHVhbCBkYXRhCj4gPiA+ID4gPiA+IHBhY2tldCBmcm9tIEFGX1hEUC4gVGhlIGZvcm1lciBp
cyB1bm1hcHBlZCBzZywgYW5kIHRoZSBsYXR0ZXIgaXMgcHJlIG1hcHBlZCBzZy4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBBbnkgY2hhbmNlIHRvIG1hcCB2aXJ0aW9fbmV0X2hkcigpIG1hbnVhbGx5IGJ5
IEFGX1hEUCByb3V0aW5lIGluIHRoaXMgY2FzZT8KPiA+ID4gPgo+ID4gPiA+IFdlbGwsIGl0IGlz
IGluZGVlZCBwb3NzaWJsZSB0byBkbyBzby4gSW4gdGhlIGluZGlyZWN0IHNjZW5hcmlvLCB3ZSBj
YW4gcmVjb3JkIGl0Cj4gPiA+ID4gaW4gdnJpbmctPnNwbGl0LmRlc2NfZXh0cmFbaGVhZF0uZmxh
Z3MKPiA+ID4gPgo+ID4gPiA+IFRoZW4gd2UgaGF2ZSB0byBhZ3JlZSB0aGF0IHRoZXJlIGNhbiBi
ZSBubyBtaXhlZCBzaXR1YXRpb24uCj4gPiA+Cj4gPiA+IEkgdGhpbmsgaXQgd291bGQgYmUgZWFz
aWVyIGFuZCBsZXNzIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gaWYgd2UgZG9uJ3QKPiA+ID4gZG8g
aHVnZSBjaGFuZ2VzIGluIHRoZSBjb3JlIHVubGVzcyBpdCdzIGEgbXVzdC4KPiA+ID4KPiA+Cj4g
PiBPaywgSSBwbGFuIHRvIGFkZCB0d28gbmV3IGludGVyZmFjZSB2aXJ0cXVldWVfYWRkX291dGJ1
Zl9mbGFnKCksCj4gPiB2aXJ0cXVldWVfYWRkX2luYnVmX2ZsYWcoKSBwYXNzIGEgZmxhZyBwYXJh
bWV0ZXIgdG8gdmlydHF1ZXVlX2FkZCgpIHRvCj4gPiBtYXJrIHNncyBhZGRyIGlzIHByZWRtYS4K
PiA+Cj4gPiBJIGRvbid0IHdhbnQgdG8gdXNlIHNnLT5kbWFfYWRkcmVzcywgc28gd2UgaGF2ZSB0
byBjaGVjayB3aGV0aGVyIGVhY2ggc2cgdXNlcwo+ID4gZG1hX2FkZHJlc3MuIElmIGl0IGlzIG5v
dCB1bmlmaWVkLCB3ZSB3aWxsIGFsc28gaGFuZGxlIGV4Y2VwdGlvbi4KPiA+Cj4gPiA+IEJ0dywg
SSBmb3Jnb3QgdGhlIGNvbmNsdXNpb24gb2YgdGhlIGxhc3QgQUZfWERQIHNlcmllcy4gV2h5IGlz
IGl0Cj4gPiA+IGJldHRlciB0byBjaGFuZ2UgdmlydGlvX3JpbmcgaW5zdGVhZCBvZiBBRl9YRFAg
KHdoaWNoIHNlZW1zIGVhc2llcikuCj4gPgo+ID4gUmVnYXJkaW5nIHRoaXMgcXVlc3Rpb24sIEkn
bSBndWVzc2luZyB5b3UgbWVhbiB0byBtYWtlIEFGX1hEUCBub3QgdXNlIERNQQo+ID4gYWRkcmVz
c2VzPyBJbnN0ZWFkIHBhc3MgdmlydHVhbCBhZGRyZXNzZXMgdG8gdmlydGlvLgo+ID4KPiA+IEl0
IHdvdWxkIGNlcnRhaW5seSBiZSBzaW1wbGVyLCBidXQgSSB0aGluayB0aGVyZSBpcyBhIHBlcmZv
cm1hbmNlIGdhaW4gaW4gZG9pbmcKPiA+IHRoZSBETUEgbWFwcGluZyBhaGVhZCBvZiB0aW1lLgo+
Cj4gQW55IHJlYXNvbiBmb3IgdGhpcz8gSXMgaXQganVzdCBiZWNhdXNlIEFGX1hEUCBkaWQgYmF0
Y2ggbWFwcGluZz8KPgoKQUZfWERQIGNvbXBsZXRlcyBhbGwgRE1BIG1hcHMgZHVyaW5nIGluaXRp
YWxpemF0aW9uLCBhbmQgdmlydGlvIGN1cnJlbnRseQpleGVjdXRlcyBhIERNQSBtYXAgZXZlcnkg
dGltZSB2aXJ0cXVldWVfYWRkKCkgaXMgZXhlY3V0ZWQuCgpJZiB3ZSBzdXBwb3J0IGFkdmFuY2Ug
RE1BLCB0aGVyZSB3aWxsIGJlIG5vIERNQSBvdmVyaGVhZCBldmVyeSB0aW1lCnZpcnRxdWV1ZV9h
ZGQoKSBpcyBleGVjdXRlZC4KCj4gQWN0dWFsbHkgdGhlcmUncyBhbm90aGVyIHN1YnRsZSBkaWZm
ZXJlbmNlLCBBRl9YRFAgdGVuZHMgdG8gdXNlCj4gRE1BX0JJRElSRUNUSU9OQUwgYnV0IHRoZSB2
aXJ0aW9fcmluZyBtYXAgZGVwZW5kcyBvbiB0aGUgaW4vb3V0LgoKWWVzLgoKVGhhbmtzLgoKPgo+
IFRoYW5rcwo+Cj4gPgo+ID4gVGhhbmtzLgo+ID4KPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4g
Pgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVGhh
bmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBUaGFua3MuCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUaGFua3MKPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+Cj4gPiA+Cj4gPgo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
