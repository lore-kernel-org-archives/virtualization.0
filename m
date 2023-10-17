Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C73CDB465
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 03:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4524841877;
	Tue, 17 Oct 2023 03:11:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4524841877
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GbFNU811ikye; Tue, 17 Oct 2023 03:11:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6901E408A3;
	Tue, 17 Oct 2023 03:11:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6901E408A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 403FAC0071;
	Tue, 17 Oct 2023 03:11:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2328C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:11:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B081581926
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:11:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B081581926
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OBIcaHvTX-Up
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:11:28 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4E99818C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:11:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4E99818C4
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VuLNn2t_1697512280; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuLNn2t_1697512280) by smtp.aliyun-inc.com;
 Tue, 17 Oct 2023 11:11:21 +0800
Message-ID: <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
Date: Tue, 17 Oct 2023 11:02:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
In-Reply-To: <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCAxNyBPY3QgMjAyMyAxMDo1Mzo0NCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMOKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+ICMjIEFG
X1hEUAo+ID4KPiA+IFhEUCBzb2NrZXQoQUZfWERQKSBpcyBhbiBleGNlbGxlbnQgYnlwYXNzIGtl
cm5lbCBuZXR3b3JrIGZyYW1ld29yay4gVGhlIHplcm8KPiA+IGNvcHkgZmVhdHVyZSBvZiB4c2sg
KFhEUCBzb2NrZXQpIG5lZWRzIHRvIGJlIHN1cHBvcnRlZCBieSB0aGUgZHJpdmVyLiBUaGUKPiA+
IHBlcmZvcm1hbmNlIG9mIHplcm8gY29weSBpcyB2ZXJ5IGdvb2QuIG1seDUgYW5kIGludGVsIGl4
Z2JlIGFscmVhZHkgc3VwcG9ydAo+ID4gdGhpcyBmZWF0dXJlLCBUaGlzIHBhdGNoIHNldCBhbGxv
d3MgdmlydGlvLW5ldCB0byBzdXBwb3J0IHhzaydzIHplcm9jb3B5IHhtaXQKPiA+IGZlYXR1cmUu
Cj4gPgo+ID4gQXQgcHJlc2VudCwgd2UgaGF2ZSBjb21wbGV0ZWQgc29tZSBwcmVwYXJhdGlvbjoK
PiA+Cj4gPiAxLiB2cS1yZXNldCAodmlydGlvIHNwZWMgYW5kIGtlcm5lbCBjb2RlKQo+ID4gMi4g
dmlydGlvLWNvcmUgcHJlbWFwcGVkIGRtYQo+ID4gMy4gdmlydGlvLW5ldCB4ZHAgcmVmYWN0b3IK
PiA+Cj4gPiBTbyBpdCBpcyB0aW1lIGZvciBWaXJ0aW8tTmV0IHRvIGNvbXBsZXRlIHRoZSBzdXBw
b3J0IGZvciB0aGUgWERQIFNvY2tldAo+ID4gWmVyb2NvcHkuCj4gPgo+ID4gVmlydGlvLW5ldCBj
YW4gbm90IGluY3JlYXNlIHRoZSBxdWV1ZSBudW0gYXQgd2lsbCwgc28geHNrIHNoYXJlcyB0aGUg
cXVldWUgd2l0aAo+ID4ga2VybmVsLgo+ID4KPiA+IE9uIHRoZSBvdGhlciBoYW5kLCBWaXJ0aW8t
TmV0IGRvZXMgbm90IHN1cHBvcnQgZ2VuZXJhdGUgaW50ZXJydXB0IGZyb20gZHJpdmVyCj4gPiBt
YW51YWxseSwgc28gd2hlbiB3ZSB3YWtldXAgdHggeG1pdCwgd2UgdXNlZCBzb21lIHRpcHMuIElm
IHRoZSBDUFUgcnVuIGJ5IFRYCj4gPiBOQVBJIGxhc3QgdGltZSBpcyBvdGhlciBDUFVzLCB1c2Ug
SVBJIHRvIHdha2UgdXAgTkFQSSBvbiB0aGUgcmVtb3RlIENQVS4gSWYgaXQKPiA+IGlzIGFsc28g
dGhlIGxvY2FsIENQVSwgdGhlbiB3ZSB3YWtlIHVwIG5hcGkgZGlyZWN0bHkuCj4gPgo+ID4gVGhp
cyBwYXRjaCBzZXQgaW5jbHVkZXMgc29tZSByZWZhY3RvciB0byB0aGUgdmlydGlvLW5ldCB0byBs
ZXQgdGhhdCB0byBzdXBwb3J0Cj4gPiBBRl9YRFAuCj4gPgo+ID4gIyMgcGVyZm9ybWFuY2UKPiA+
Cj4gPiBFTlY6IFFlbXUgd2l0aCB2aG9zdC11c2VyKHBvbGxpbmcgbW9kZSkuCj4gPgo+ID4gU29j
a3BlcmY6IGh0dHBzOi8vZ2l0aHViLmNvbS9NZWxsYW5veC9zb2NrcGVyZgo+ID4gSSB1c2UgdGhp
cyB0b29sIHRvIHNlbmQgdWRwIHBhY2tldCBieSBrZXJuZWwgc3lzY2FsbC4KPiA+Cj4gPiB4bWl0
IGNvbW1hbmQ6IHNvY2twZXJmIHRwIC1pIDEwLjAuMy4xIC10IDEwMDAKPiA+Cj4gPiBJIHdyaXRl
IGEgdG9vbCB0aGF0IHNlbmRzIHVkcCBwYWNrZXRzIG9yIHJlY3ZzIHVkcCBwYWNrZXRzIGJ5IEFG
X1hEUC4KPiA+Cj4gPiAgICAgICAgICAgICAgICAgICB8IEd1ZXN0IEFQUCBDUFUgfEd1ZXN0IFNv
ZnRpcnEgQ1BVIHwgVURQIFBQUwo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0t
LXwtLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tCj4gPiB4bWl0IGJ5IHN5c2NhbGwgICB8
ICAgMTAwJSAgICAgICAgfCAgICAgICAgICAgICAgICAgIHwgICA2NzYsOTE1Cj4gPiB4bWl0IGJ5
IHhzayAgICAgICB8ICAgNTkuMSUgICAgICAgfCAgIDEwMCUgICAgICAgICAgIHwgNSw0NDcsMTY4
Cj4gPiByZWN2IGJ5IHN5c2NhbGwgICB8ICAgNjAlICAgICAgICAgfCAgIDEwMCUgICAgICAgICAg
IHwgICA5MzIsMjg4Cj4gPiByZWN2IGJ5IHhzayAgICAgICB8ICAgMzUuNyUgICAgICAgfCAgIDEw
MCUgICAgICAgICAgIHwgMywzNDMsMTY4Cj4KPiBBbnkgY2hhbmNlIHdlIGNhbiBnZXQgYSB0ZXN0
cG1kIHJlc3VsdCAod2hpY2ggSSBndWVzcyBzaG91bGQgYmUgYmV0dGVyCj4gdGhhbiBQUFMgYWJv
dmUpPwoKRG8geW91IG1lYW4gdGVzdHBtZCArIERQREsgKyBBRl9YRFA/CgpZZXMuIFRoaXMgaXMg
cHJvYmFibHkgYmV0dGVyIGJlY2F1c2UgbXkgdG9vbCBkb2VzIG1vcmUgd29yay4gVGhhdCBpcyBu
b3QgYQpjb21wbGV0ZSB0ZXN0aW5nIHRvb2wgdXNlZCBieSBvdXIgYnVzaW5lc3MuCgpXaGF0IEkg
bm90aWNlZCBpcyB0aGF0IHRoZSBob3RzcG90IGlzIHRoZSBkcml2ZXIgd3JpdGluZyB2aXJ0aW8g
ZGVzYy4gQmVjYXVzZQp0aGUgZGV2aWNlIGlzIGluIGJ1c3kgbW9kZS4gU28gdGhlcmUgaXMgcmFj
ZSBiZXR3ZWVuIGRyaXZlciBhbmQgZGV2aWNlLgpTbyBJIG1vZGlmaWVkIHRoZSB2aXJ0aW8gY29y
ZSBhbmQgbGF6aWx5IHVwZGF0ZWQgYXZhaWwgaWR4LiBUaGVuIHBwcyBjYW4gcmVhY2gKMTAsMDAw
LDAwMC4KClRoYW5rcy4KCj4KPiBUaGFua3MKPgo+ID4KPiA+ICMjIG1haW50YWluCj4gPgo+ID4g
SSBhbSBjdXJyZW50bHkgYSByZXZpZXdlciBmb3IgdmlydGlvLW5ldC4gSSBjb21taXQgdG8gbWFp
bnRhaW4gQUZfWERQIHN1cHBvcnQgaW4KPiA+IHZpcnRpby1uZXQuCj4gPgo+ID4gUGxlYXNlIHJl
dmlldy4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4gdjE6Cj4gPiAgICAgMS4gcmVtb3ZlIHR3byB2
aXJ0aW8gY29tbWl0cy4gUHVzaCB0aGlzIHBhdGNoc2V0IHRvIG5ldC1uZXh0Cj4gPiAgICAgMi4g
c3F1YXNoICJ2aXJ0aW9fbmV0OiB2aXJ0bmV0X3BvbGxfdHggc3VwcG9ydCByZXNjaGVkdWxlZCIg
dG8geHNrOiBzdXBwb3J0IHR4Cj4gPiAgICAgMy4gZml4IHNvbWUgd2FybmluZ3MKPiA+Cj4gPiBY
dWFuIFpodW8gKDE5KToKPiA+ICAgdmlydGlvX25ldDogcmVuYW1lIGZyZWVfb2xkX3htaXRfc2ti
cyB0byBmcmVlX29sZF94bWl0Cj4gPiAgIHZpcnRpb19uZXQ6IHVuaWZ5IHRoZSBjb2RlIGZvciBy
ZWN5Y2xpbmcgdGhlIHhtaXQgcHRyCj4gPiAgIHZpcnRpb19uZXQ6IGluZGVwZW5kZW50IGRpcmVj
dG9yeQo+ID4gICB2aXJ0aW9fbmV0OiBtb3ZlIHRvIHZpcnRpb19uZXQuaAo+ID4gICB2aXJ0aW9f
bmV0OiBhZGQgcHJlZml4IHZpcnRuZXQgdG8gYWxsIHN0cnVjdC9hcGkgaW5zaWRlIHZpcnRpb19u
ZXQuaAo+ID4gICB2aXJ0aW9fbmV0OiBzZXBhcmF0ZSB2aXJ0bmV0X3J4X3Jlc2l6ZSgpCj4gPiAg
IHZpcnRpb19uZXQ6IHNlcGFyYXRlIHZpcnRuZXRfdHhfcmVzaXplKCkKPiA+ICAgdmlydGlvX25l
dDogc3Egc3VwcG9ydCBwcmVtYXBwZWQgbW9kZQo+ID4gICB2aXJ0aW9fbmV0OiB4c2s6IGJpbmQv
dW5iaW5kIHhzawo+ID4gICB2aXJ0aW9fbmV0OiB4c2s6IHByZXZlbnQgZGlzYWJsZSB0eCBuYXBp
Cj4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6IHN1cHBvcnQgdHgKPiA+ICAgdmlydGlvX25ldDog
eHNrOiB0eDogc3VwcG9ydCB3YWtldXAKPiA+ICAgdmlydGlvX25ldDogeHNrOiB0eDogdmlydG5l
dF9mcmVlX29sZF94bWl0KCkgZGlzdGluZ3Vpc2hlcyB4c2sgYnVmZmVyCj4gPiAgIHZpcnRpb19u
ZXQ6IHhzazogdHg6IHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKCkgY2hlY2sgeHNrIGJ1ZmZl
cgo+ID4gICB2aXJ0aW9fbmV0OiB4c2s6IHJ4OiBpbnRyb2R1Y2UgYWRkX3JlY3ZidWZfeHNrKCkK
PiA+ICAgdmlydGlvX25ldDogeHNrOiByeDogaW50cm9kdWNlIHJlY2VpdmVfeHNrKCkgdG8gcmVj
diB4c2sgYnVmZmVyCj4gPiAgIHZpcnRpb19uZXQ6IHhzazogcng6IHZpcnRuZXRfcnFfZnJlZV91
bnVzZWRfYnVmKCkgY2hlY2sgeHNrIGJ1ZmZlcgo+ID4gICB2aXJ0aW9fbmV0OiB1cGRhdGUgdHgg
dGltZW91dCByZWNvcmQKPiA+ICAgdmlydGlvX25ldDogeGRwX2ZlYXR1cmVzIGFkZCBORVRERVZf
WERQX0FDVF9YU0tfWkVST0NPUFkKPiA+Cj4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgMiArLQo+ID4gIGRyaXZlcnMvbmV0L0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAgIDggKy0KPiA+ICBkcml2ZXJzL25ldC9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAyICstCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvL0tjb25m
aWcgICAgICAgICAgICAgICAgICB8ICAxMyArCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvL01ha2Vm
aWxlICAgICAgICAgICAgICAgICB8ICAgOCArCj4gPiAgZHJpdmVycy9uZXQve3ZpcnRpb19uZXQu
YyA9PiB2aXJ0aW8vbWFpbi5jfSB8IDY1MiArKysrKysrKystLS0tLS0tLS0tLQo+ID4gIGRyaXZl
cnMvbmV0L3ZpcnRpby92aXJ0aW9fbmV0LmggICAgICAgICAgICAgfCAzNTkgKysrKysrKysrKysK
PiA+ICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgICAgICAgICAgICAgICAgICAgIHwgNTQ1ICsr
KysrKysrKysrKysrKysKPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmggICAgICAgICAgICAg
ICAgICAgIHwgIDMyICsKPiA+ICA5IGZpbGVzIGNoYW5nZWQsIDEyNDcgaW5zZXJ0aW9ucygrKSwg
Mzc0IGRlbGV0aW9ucygtKQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0
aW8vS2NvbmZpZwo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vTWFr
ZWZpbGUKPiA+ICByZW5hbWUgZHJpdmVycy9uZXQve3ZpcnRpb19uZXQuYyA9PiB2aXJ0aW8vbWFp
bi5jfSAoOTElKQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vdmly
dGlvX25ldC5oCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby94c2su
Ywo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmgKPiA+Cj4g
PiAtLQo+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4KPgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
