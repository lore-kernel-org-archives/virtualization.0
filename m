Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE968CDB465
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 03:25:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 503544018F;
	Tue, 17 Oct 2023 03:25:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 503544018F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 36fXWqYaCaha; Tue, 17 Oct 2023 03:25:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3C16E400EC;
	Tue, 17 Oct 2023 03:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C16E400EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15435C0071;
	Tue, 17 Oct 2023 03:25:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4110FC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:25:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0FFA8813DB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:25:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0FFA8813DB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i4zXOMlF6uWw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:25:23 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C6014813D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:25:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6014813D5
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VuLNrE7_1697513115; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuLNrE7_1697513115) by smtp.aliyun-inc.com;
 Tue, 17 Oct 2023 11:25:16 +0800
Message-ID: <1697512950.0813534-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
Date: Tue, 17 Oct 2023 11:22:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
In-Reply-To: <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
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

T24gVHVlLCAxNyBPY3QgMjAyMyAxMToyMDo0MSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMTE6MTHigK9BTSBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBU
dWUsIDE3IE9jdCAyMDIzIDEwOjUzOjQ0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gT24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMOKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+Cj4gPiA+
ID4gIyMgQUZfWERQCj4gPiA+ID4KPiA+ID4gPiBYRFAgc29ja2V0KEFGX1hEUCkgaXMgYW4gZXhj
ZWxsZW50IGJ5cGFzcyBrZXJuZWwgbmV0d29yayBmcmFtZXdvcmsuIFRoZSB6ZXJvCj4gPiA+ID4g
Y29weSBmZWF0dXJlIG9mIHhzayAoWERQIHNvY2tldCkgbmVlZHMgdG8gYmUgc3VwcG9ydGVkIGJ5
IHRoZSBkcml2ZXIuIFRoZQo+ID4gPiA+IHBlcmZvcm1hbmNlIG9mIHplcm8gY29weSBpcyB2ZXJ5
IGdvb2QuIG1seDUgYW5kIGludGVsIGl4Z2JlIGFscmVhZHkgc3VwcG9ydAo+ID4gPiA+IHRoaXMg
ZmVhdHVyZSwgVGhpcyBwYXRjaCBzZXQgYWxsb3dzIHZpcnRpby1uZXQgdG8gc3VwcG9ydCB4c2sn
cyB6ZXJvY29weSB4bWl0Cj4gPiA+ID4gZmVhdHVyZS4KPiA+ID4gPgo+ID4gPiA+IEF0IHByZXNl
bnQsIHdlIGhhdmUgY29tcGxldGVkIHNvbWUgcHJlcGFyYXRpb246Cj4gPiA+ID4KPiA+ID4gPiAx
LiB2cS1yZXNldCAodmlydGlvIHNwZWMgYW5kIGtlcm5lbCBjb2RlKQo+ID4gPiA+IDIuIHZpcnRp
by1jb3JlIHByZW1hcHBlZCBkbWEKPiA+ID4gPiAzLiB2aXJ0aW8tbmV0IHhkcCByZWZhY3Rvcgo+
ID4gPiA+Cj4gPiA+ID4gU28gaXQgaXMgdGltZSBmb3IgVmlydGlvLU5ldCB0byBjb21wbGV0ZSB0
aGUgc3VwcG9ydCBmb3IgdGhlIFhEUCBTb2NrZXQKPiA+ID4gPiBaZXJvY29weS4KPiA+ID4gPgo+
ID4gPiA+IFZpcnRpby1uZXQgY2FuIG5vdCBpbmNyZWFzZSB0aGUgcXVldWUgbnVtIGF0IHdpbGws
IHNvIHhzayBzaGFyZXMgdGhlIHF1ZXVlIHdpdGgKPiA+ID4gPiBrZXJuZWwuCj4gPiA+ID4KPiA+
ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCwgVmlydGlvLU5ldCBkb2VzIG5vdCBzdXBwb3J0IGdlbmVy
YXRlIGludGVycnVwdCBmcm9tIGRyaXZlcgo+ID4gPiA+IG1hbnVhbGx5LCBzbyB3aGVuIHdlIHdh
a2V1cCB0eCB4bWl0LCB3ZSB1c2VkIHNvbWUgdGlwcy4gSWYgdGhlIENQVSBydW4gYnkgVFgKPiA+
ID4gPiBOQVBJIGxhc3QgdGltZSBpcyBvdGhlciBDUFVzLCB1c2UgSVBJIHRvIHdha2UgdXAgTkFQ
SSBvbiB0aGUgcmVtb3RlIENQVS4gSWYgaXQKPiA+ID4gPiBpcyBhbHNvIHRoZSBsb2NhbCBDUFUs
IHRoZW4gd2Ugd2FrZSB1cCBuYXBpIGRpcmVjdGx5Lgo+ID4gPiA+Cj4gPiA+ID4gVGhpcyBwYXRj
aCBzZXQgaW5jbHVkZXMgc29tZSByZWZhY3RvciB0byB0aGUgdmlydGlvLW5ldCB0byBsZXQgdGhh
dCB0byBzdXBwb3J0Cj4gPiA+ID4gQUZfWERQLgo+ID4gPiA+Cj4gPiA+ID4gIyMgcGVyZm9ybWFu
Y2UKPiA+ID4gPgo+ID4gPiA+IEVOVjogUWVtdSB3aXRoIHZob3N0LXVzZXIocG9sbGluZyBtb2Rl
KS4KPiA+ID4gPgo+ID4gPiA+IFNvY2twZXJmOiBodHRwczovL2dpdGh1Yi5jb20vTWVsbGFub3gv
c29ja3BlcmYKPiA+ID4gPiBJIHVzZSB0aGlzIHRvb2wgdG8gc2VuZCB1ZHAgcGFja2V0IGJ5IGtl
cm5lbCBzeXNjYWxsLgo+ID4gPiA+Cj4gPiA+ID4geG1pdCBjb21tYW5kOiBzb2NrcGVyZiB0cCAt
aSAxMC4wLjMuMSAtdCAxMDAwCj4gPiA+ID4KPiA+ID4gPiBJIHdyaXRlIGEgdG9vbCB0aGF0IHNl
bmRzIHVkcCBwYWNrZXRzIG9yIHJlY3ZzIHVkcCBwYWNrZXRzIGJ5IEFGX1hEUC4KPiA+ID4gPgo+
ID4gPiA+ICAgICAgICAgICAgICAgICAgIHwgR3Vlc3QgQVBQIENQVSB8R3Vlc3QgU29mdGlycSBD
UFUgfCBVRFAgUFBTCj4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0tLXwt
LS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tCj4gPiA+ID4geG1pdCBieSBzeXNjYWxsICAg
fCAgIDEwMCUgICAgICAgIHwgICAgICAgICAgICAgICAgICB8ICAgNjc2LDkxNQo+ID4gPiA+IHht
aXQgYnkgeHNrICAgICAgIHwgICA1OS4xJSAgICAgICB8ICAgMTAwJSAgICAgICAgICAgfCA1LDQ0
NywxNjgKPiA+ID4gPiByZWN2IGJ5IHN5c2NhbGwgICB8ICAgNjAlICAgICAgICAgfCAgIDEwMCUg
ICAgICAgICAgIHwgICA5MzIsMjg4Cj4gPiA+ID4gcmVjdiBieSB4c2sgICAgICAgfCAgIDM1Ljcl
ICAgICAgIHwgICAxMDAlICAgICAgICAgICB8IDMsMzQzLDE2OAo+ID4gPgo+ID4gPiBBbnkgY2hh
bmNlIHdlIGNhbiBnZXQgYSB0ZXN0cG1kIHJlc3VsdCAod2hpY2ggSSBndWVzcyBzaG91bGQgYmUg
YmV0dGVyCj4gPiA+IHRoYW4gUFBTIGFib3ZlKT8KPiA+Cj4gPiBEbyB5b3UgbWVhbiB0ZXN0cG1k
ICsgRFBESyArIEFGX1hEUD8KPgo+IFllcy4KPgo+ID4KPiA+IFllcy4gVGhpcyBpcyBwcm9iYWJs
eSBiZXR0ZXIgYmVjYXVzZSBteSB0b29sIGRvZXMgbW9yZSB3b3JrLiBUaGF0IGlzIG5vdCBhCj4g
PiBjb21wbGV0ZSB0ZXN0aW5nIHRvb2wgdXNlZCBieSBvdXIgYnVzaW5lc3MuCj4KPiBQcm9iYWJs
eSwgYnV0IGl0IHdvdWxkIGJlIGFwcGVhbGluZyBmb3Igb3RoZXJzLiBFc3BlY2lhbGx5IGNvbnNp
ZGVyaW5nCj4gRFBESyBzdXBwb3J0cyBBRl9YRFAgUE1EIG5vdy4KCk9LLgoKTGV0IG1lIHRyeS4K
CkJ1dCBjb3VsZCB5b3Ugc3RhcnQgdG8gcmV2aWV3IGZpcnN0bHk/CgoKPgo+ID4KPiA+IFdoYXQg
SSBub3RpY2VkIGlzIHRoYXQgdGhlIGhvdHNwb3QgaXMgdGhlIGRyaXZlciB3cml0aW5nIHZpcnRp
byBkZXNjLiBCZWNhdXNlCj4gPiB0aGUgZGV2aWNlIGlzIGluIGJ1c3kgbW9kZS4gU28gdGhlcmUg
aXMgcmFjZSBiZXR3ZWVuIGRyaXZlciBhbmQgZGV2aWNlLgo+ID4gU28gSSBtb2RpZmllZCB0aGUg
dmlydGlvIGNvcmUgYW5kIGxhemlseSB1cGRhdGVkIGF2YWlsIGlkeC4gVGhlbiBwcHMgY2FuIHJl
YWNoCj4gPiAxMCwwMDAsMDAwLgo+Cj4gQ2FyZSB0byBwb3N0IGEgZHJhZnQgZm9yIHRoaXM/CgpZ
RVMsIEkgaXMgdGhpbmtpbmcgZm9yIHRoaXMuCkJ1dCBtYXliZSB0aGF0IGlzIGp1c3Qgd29yayBm
b3Igc3BsaXQuIFRoZSBwYWNrZWQgbW9kZSBoYXMgc29tZSB0cm91Ymxlcy4KClRoYW5rcy4KCj4K
PiBUaGFua3MKPgo+ID4KPiA+IFRoYW5rcy4KPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gIyMgbWFpbnRhaW4KPiA+ID4gPgo+ID4gPiA+IEkgYW0gY3VycmVudGx5
IGEgcmV2aWV3ZXIgZm9yIHZpcnRpby1uZXQuIEkgY29tbWl0IHRvIG1haW50YWluIEFGX1hEUCBz
dXBwb3J0IGluCj4gPiA+ID4gdmlydGlvLW5ldC4KPiA+ID4gPgo+ID4gPiA+IFBsZWFzZSByZXZp
ZXcuCj4gPiA+ID4KPiA+ID4gPiBUaGFua3MuCj4gPiA+ID4KPiA+ID4gPiB2MToKPiA+ID4gPiAg
ICAgMS4gcmVtb3ZlIHR3byB2aXJ0aW8gY29tbWl0cy4gUHVzaCB0aGlzIHBhdGNoc2V0IHRvIG5l
dC1uZXh0Cj4gPiA+ID4gICAgIDIuIHNxdWFzaCAidmlydGlvX25ldDogdmlydG5ldF9wb2xsX3R4
IHN1cHBvcnQgcmVzY2hlZHVsZWQiIHRvIHhzazogc3VwcG9ydCB0eAo+ID4gPiA+ICAgICAzLiBm
aXggc29tZSB3YXJuaW5ncwo+ID4gPiA+Cj4gPiA+ID4gWHVhbiBaaHVvICgxOSk6Cj4gPiA+ID4g
ICB2aXJ0aW9fbmV0OiByZW5hbWUgZnJlZV9vbGRfeG1pdF9za2JzIHRvIGZyZWVfb2xkX3htaXQK
PiA+ID4gPiAgIHZpcnRpb19uZXQ6IHVuaWZ5IHRoZSBjb2RlIGZvciByZWN5Y2xpbmcgdGhlIHht
aXQgcHRyCj4gPiA+ID4gICB2aXJ0aW9fbmV0OiBpbmRlcGVuZGVudCBkaXJlY3RvcnkKPiA+ID4g
PiAgIHZpcnRpb19uZXQ6IG1vdmUgdG8gdmlydGlvX25ldC5oCj4gPiA+ID4gICB2aXJ0aW9fbmV0
OiBhZGQgcHJlZml4IHZpcnRuZXQgdG8gYWxsIHN0cnVjdC9hcGkgaW5zaWRlIHZpcnRpb19uZXQu
aAo+ID4gPiA+ICAgdmlydGlvX25ldDogc2VwYXJhdGUgdmlydG5ldF9yeF9yZXNpemUoKQo+ID4g
PiA+ICAgdmlydGlvX25ldDogc2VwYXJhdGUgdmlydG5ldF90eF9yZXNpemUoKQo+ID4gPiA+ICAg
dmlydGlvX25ldDogc3Egc3VwcG9ydCBwcmVtYXBwZWQgbW9kZQo+ID4gPiA+ICAgdmlydGlvX25l
dDogeHNrOiBiaW5kL3VuYmluZCB4c2sKPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogcHJldmVu
dCBkaXNhYmxlIHR4IG5hcGkKPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6IHN1cHBvcnQg
dHgKPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6IHN1cHBvcnQgd2FrZXVwCj4gPiA+ID4g
ICB2aXJ0aW9fbmV0OiB4c2s6IHR4OiB2aXJ0bmV0X2ZyZWVfb2xkX3htaXQoKSBkaXN0aW5ndWlz
aGVzIHhzayBidWZmZXIKPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6IHZpcnRuZXRfc3Ff
ZnJlZV91bnVzZWRfYnVmKCkgY2hlY2sgeHNrIGJ1ZmZlcgo+ID4gPiA+ICAgdmlydGlvX25ldDog
eHNrOiByeDogaW50cm9kdWNlIGFkZF9yZWN2YnVmX3hzaygpCj4gPiA+ID4gICB2aXJ0aW9fbmV0
OiB4c2s6IHJ4OiBpbnRyb2R1Y2UgcmVjZWl2ZV94c2soKSB0byByZWN2IHhzayBidWZmZXIKPiA+
ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogcng6IHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKCkg
Y2hlY2sgeHNrIGJ1ZmZlcgo+ID4gPiA+ICAgdmlydGlvX25ldDogdXBkYXRlIHR4IHRpbWVvdXQg
cmVjb3JkCj4gPiA+ID4gICB2aXJ0aW9fbmV0OiB4ZHBfZmVhdHVyZXMgYWRkIE5FVERFVl9YRFBf
QUNUX1hTS19aRVJPQ09QWQo+ID4gPiA+Cj4gPiA+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0KPiA+ID4gPiAgZHJpdmVycy9uZXQvS2NvbmZp
ZyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgOCArLQo+ID4gPiA+ICBkcml2ZXJzL25ldC9N
YWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstCj4gPiA+ID4gIGRyaXZlcnMv
bmV0L3ZpcnRpby9LY29uZmlnICAgICAgICAgICAgICAgICAgfCAgMTMgKwo+ID4gPiA+ICBkcml2
ZXJzL25ldC92aXJ0aW8vTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICA4ICsKPiA+ID4gPiAg
ZHJpdmVycy9uZXQve3ZpcnRpb19uZXQuYyA9PiB2aXJ0aW8vbWFpbi5jfSB8IDY1MiArKysrKysr
KystLS0tLS0tLS0tLQo+ID4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5oICAg
ICAgICAgICAgIHwgMzU5ICsrKysrKysrKysrCj4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby94
c2suYyAgICAgICAgICAgICAgICAgICAgfCA1NDUgKysrKysrKysrKysrKysrKwo+ID4gPiA+ICBk
cml2ZXJzL25ldC92aXJ0aW8veHNrLmggICAgICAgICAgICAgICAgICAgIHwgIDMyICsKPiA+ID4g
PiAgOSBmaWxlcyBjaGFuZ2VkLCAxMjQ3IGluc2VydGlvbnMoKyksIDM3NCBkZWxldGlvbnMoLSkK
PiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby9LY29uZmlnCj4g
PiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vTWFrZWZpbGUKPiA+
ID4gPiAgcmVuYW1lIGRyaXZlcnMvbmV0L3t2aXJ0aW9fbmV0LmMgPT4gdmlydGlvL21haW4uY30g
KDkxJSkKPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0
aW9fbmV0LmgKPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby94
c2suYwo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL3hzay5o
Cj4gPiA+ID4KPiA+ID4gPiAtLQo+ID4gPiA+IDIuMzIuMC4zLmcwMTE5NWNmOWYKPiA+ID4gPgo+
ID4gPgo+ID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
