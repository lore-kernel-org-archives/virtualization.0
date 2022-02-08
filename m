Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49903C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:29:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CAE9B40235;
	Tue,  8 Feb 2022 03:29:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Q7j6xl4Ph4v; Tue,  8 Feb 2022 03:29:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6174F40226;
	Tue,  8 Feb 2022 03:29:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32FC6C001A;
	Tue,  8 Feb 2022 03:29:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D42DC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0110F812CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WJVeRKXyH28C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:29:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2A7CF80E3F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:29:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R731e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V3uaYPK_1644290949; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V3uaYPK_1644290949) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Feb 2022 11:29:09 +0800
Message-Id: <1644290712.5535257-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 01/17] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Date: Tue, 08 Feb 2022 11:25:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <20220126073533.44994-2-xuanzhuo@linux.alibaba.com>
 <28013a95-4ce4-7859-9ca1-d836265e8792@redhat.com>
 <1644213876.065673-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEuJ_v5g2ypLZ3eNhAcUM9Q3PpWuiaeWVfEC6KACGzWAZw@mail.gmail.com>
 <1644286649.5989025-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvVmKg0r4WudojL6dGt3vG4f=_4Pnsn-kBwQcge63jNqQ@mail.gmail.com>
 <1644290312.0241497-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEtOoSF293nDwLFpAcs9M1+sUZufO309kCO0tRy7w40vdQ@mail.gmail.com>
In-Reply-To: <CACGkMEtOoSF293nDwLFpAcs9M1+sUZufO309kCO0tRy7w40vdQ@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCA4IEZlYiAyMDIyIDExOjI0OjEzICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIEZlYiA4LCAyMDIyIGF0IDExOjIwIEFNIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFR1ZSwg
OCBGZWIgMjAyMiAxMTowMzoxNyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgRmViIDgsIDIwMjIgYXQgMTA6MTcgQU0gWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4KPiA+ID4gPiBPbiBN
b24sIDcgRmViIDIwMjIgMTY6MDY6MTUgKzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gT24gTW9uLCBGZWIgNywgMjAyMiBhdCAyOjA3IFBNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiBPbiBNb24sIDcgRmViIDIwMjIgMTE6NDE6MDYgKzA4MDAsIEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
5ZyoIDIwMjIvMS8yNiDkuIvljYgzOjM1LCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gPiA+
ID4gQWRkIHF1ZXVlX25vdGlmeV9kYXRhIGluIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcs
IHdoaWNoIGNvbWVzIGZyb20KPiA+ID4gPiA+ID4gPiA+IGhlcmUgaHR0cHM6Ly9naXRodWIuY29t
L29hc2lzLXRjcy92aXJ0aW8tc3BlYy9pc3N1ZXMvODkKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiBTaW5jZSBJIHdhbnQgdG8gYWRkIHF1ZXVlX3Jlc2V0IGFmdGVyIGl0LCBJIHN1Ym1p
dHRlZCB0aGlzIHBhdGNoIGZpcnN0Lgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+
ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4gPiA+ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRp
b19wY2kuaCB8IDEgKwo+ID4gPiA+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykKPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNp
LmgKPiA+ID4gPiA+ID4gPiA+IGluZGV4IDNhODZmMzZkN2UzZC4uNDkyYzg5ZjU2YzZhIDEwMDY0
NAo+ID4gPiA+ID4gPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+
ID4gPiA+ID4gPiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+ID4g
PiA+ID4gPiA+ID4gQEAgLTE2NCw2ICsxNjQsNyBAQCBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25f
Y2ZnIHsKPiA+ID4gPiA+ID4gPiA+ICAgICBfX2xlMzIgcXVldWVfYXZhaWxfaGk7ICAgICAgICAg
IC8qIHJlYWQtd3JpdGUgKi8KPiA+ID4gPiA+ID4gPiA+ICAgICBfX2xlMzIgcXVldWVfdXNlZF9s
bzsgICAgICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+ID4gPiA+ID4gPiA+ICAgICBfX2xlMzIg
cXVldWVfdXNlZF9oaTsgICAgICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+ID4gPiA+ID4gPiA+
ICsgICBfX2xlMTYgcXVldWVfbm90aWZ5X2RhdGE7ICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+
ID4gPiA+ID4gPiA+ICAgfTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gU28gSSBoYWQgdGhlIHNhbWUgY29uY2VybiBhcyBwcmV2aW91cyB2ZXJzaW9uLgo+ID4gPiA+
ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhpcyBicmVha3MgdUFCSSB3aGVyZSBwcm9ncmFtIG1heSB0
cnkgdG8gdXNlIHNpemVvZihzdHJ1Y3QKPiA+ID4gPiA+ID4gPiB2aXJ0aW9fcGNpX2NvbW1vbl9j
ZmcpLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gV2UgcHJvYmFibHkgbmVlZCBhIGNvbnRh
aW5lciBzdHJ1Y3R1cmUgaGVyZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gSSBzZWUsIEkgcGxh
biB0byBhZGQgYSBzdHJ1Y3QgbGlrZSB0aGlzLCBkbyB5b3UgdGhpbmsgaXQncyBhcHByb3ByaWF0
ZT8KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZ192
MSB7Cj4gPiA+ID4gPiA+ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBjZmc7
Cj4gPiA+ID4gPiA+ICAgICAgICAgX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRhOyAgICAgICAvKiBy
ZWFkLXdyaXRlICovCj4gPiA+ID4gPiA+IH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiBTb21ldGhpbmcg
bGlrZSB0aGlzIGJ1dCB3ZSBwcm9iYWJseSBuZWVkIGEgYmV0dGVyIG5hbWUuCj4gPiA+ID4KPiA+
ID4gPgo+ID4gPiA+IGhvdyBhYm91dCB0aGlzPwo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICAvKiBF
eHQgRmllbGRzIGluIFZJUlRJT19QQ0lfQ0FQX0NPTU1PTl9DRkc6ICovCj4gPiA+ID4gICAgICAg
ICBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnX2V4dCB7Cj4gPiA+ID4gICAgICAgICAgICAg
ICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgY2ZnOwo+ID4gPiA+Cj4gPiA+ID4gICAg
ICAgICAgICAgICAgIF9fbGUxNiBxdWV1ZV9ub3RpZnlfZGF0YTsgICAgICAgLyogcmVhZC13cml0
ZSAqLwo+ID4gPiA+Cj4gPiA+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDA7Cj4g
PiA+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDE7Cj4gPiA+ID4gICAgICAgICAg
ICAgICAgIF9fbGUxNiByZXNlcnZlZDI7Cj4gPiA+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiBy
ZXNlcnZlZDM7Cj4gPiA+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDQ7Cj4gPiA+
ID4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDU7Cj4gPiA+ID4gICAgICAgICAgICAg
ICAgIF9fbGUxNiByZXNlcnZlZDY7Cj4gPiA+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNl
cnZlZDc7Cj4gPiA+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDg7Cj4gPiA+ID4g
ICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDk7Cj4gPiA+ID4gICAgICAgICAgICAgICAg
IF9fbGUxNiByZXNlcnZlZDEwOwo+ID4gPiA+ICAgICAgICAgICAgICAgICBfX2xlMTYgcmVzZXJ2
ZWQxMTsKPiA+ID4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMTI7Cj4gPiA+ID4g
ICAgICAgICAgICAgICAgIF9fbGUxNiByZXNlcnZlZDEzOwo+ID4gPiA+ICAgICAgICAgICAgICAg
ICBfX2xlMTYgcmVzZXJ2ZWQxNDsKPiA+ID4gPiAgICAgICAgIH07Cj4gPiA+Cj4gPiA+IEkgc3Rp
bGwgdGhpbmsgdGhlIGNvbnRhaW5lciB3aXRob3V0IHBhZGRpbmcgaXMgYmV0dGVyLiBPdGhlcndp
c2UKPiA+ID4gdXNlcnNwYWNlIG5lZWRzIHRvIHVzZSBvZmZzZXRfb2YoKSB0cmljayBpbnN0ZWFk
IG9mIHNpemVvZigpLgo+ID4KPiA+IEluIHRoaXMgY2FzZSwgYXMgdmlydGlvX3BjaV9jb21tb25f
Y2ZnX2V4dCBhZGRzIG5ldyBtZW1iZXJzIGluIHRoZSBmdXR1cmUsIHdlCj4gPiB3aWxsIGFkZCBt
b3JlIGNvbnRhaW5lciBzdHJ1Y3R1cmVzLgo+ID4KPiA+IEluIHRoYXQgY2FzZSwgSSB0aGluayB2
aXJ0aW9fcGNpX2NvbW1vbl9jZmdfdjEgaXMgYSBnb29kIG5hbWUgaW5zdGVhZC4KPgo+IFNvbWV0
aGluZyBsaWtlICJ2aXJ0aW9fcGNpX2NvbW1vbl9jZmdfbm90aWZ5IiBtaWdodCBiZSBhIGxpdHRs
ZSBiaXQgYmV0dGVyLgoKQWx0aG91Z2ggdGhlcmUgaXMgb25seSBvbmUgbm90aWZ5X2RhdGEgaW4g
dGhpcyBwYXRjaCwgSSBwbGFuIHRvIGxvb2sgbGlrZSB0aGlzCmFmdGVyIG15IHBhdGNoIHNldDoK
CglzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnX3YxIHsKCSAgICAgICAgc3RydWN0IHZpcnRp
b19wY2lfY29tbW9uX2NmZyBjZmc7CgoJICAgICAgICBfX2xlMTYgcXVldWVfbm90aWZ5X2RhdGE7
ICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KCSAgICAgICAgX19sZTE2IHF1ZXVlX3Jlc2V0OyAgICAg
ICAvKiByZWFkLXdyaXRlICovCgl9CgpJZiB3ZSB1c2UgdmlydGlvX3BjaV9jb21tb25fY2ZnX25v
dGlmeSwgdGhlbiB3ZSB3aWxsIGdldCB0d28gc3RydWN0dXJlcyBhZnRlcgp0aGlzIHBhdGNoIHNl
dDoKCglzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnX25vdGlmeSB7CgkgICAgICAgIHN0cnVj
dCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcgY2ZnOwoKCSAgICAgICAgX19sZTE2IHF1ZXVlX25vdGlm
eV9kYXRhOyAgICAgICAvKiByZWFkLXdyaXRlICovCgl9CgoJc3RydWN0IHZpcnRpb19wY2lfY29t
bW9uX2NmZ19yZXNldCB7CgkgICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmdfbm90
aWZ5IGNmZzsKCgkgICAgICAgIF9fbGUxNiBxdWV1ZV9yZXNldDsgICAgICAgLyogcmVhZC13cml0
ZSAqLwoJfQoKClRoYW5rcy4KCj4KPiBUaGFua3MKPgo+ID4KPiA+IFRoYW5rcy4KPiA+Cj4gPgo+
ID4gPgo+ID4gPiBUaGFua3MKPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4g
PiA+ID4gPgo+ID4gPiA+ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiBUaGFua3MuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBUSGFua3MK
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
ID4gICAvKiBGaWVsZHMgaW4gVklSVElPX1BDSV9DQVBfUENJX0NGRzogKi8KPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPgo+ID4KPgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
