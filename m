Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2A5C76196
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 07:50:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 99F19421D7;
	Fri, 31 Mar 2023 07:50:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 99F19421D7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id APhLFQy_Z7gt; Fri, 31 Mar 2023 07:50:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9A3514214B;
	Fri, 31 Mar 2023 07:50:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9A3514214B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 707A3C0036;
	Fri, 31 Mar 2023 07:50:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42DCDC002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:50:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 181174211C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:50:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 181174211C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xchgq5hkb1_s
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:50:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B7164408C2
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B7164408C2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:50:01 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R691e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vf1TRG3_1680248994; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vf1TRG3_1680248994) by smtp.aliyun-inc.com;
 Fri, 31 Mar 2023 15:49:55 +0800
Message-ID: <1680248880.8897254-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/16] virtio-net: split virtio-net.c
Date: Fri, 31 Mar 2023 15:48:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
 <20230330015412-mutt-send-email-mst@kernel.org>
 <1680247317.9193828-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEt2M3zaytjOmhTuSx6wnerZBrVoQxgbUuAv0WmUu50Hiw@mail.gmail.com>
In-Reply-To: <CACGkMEt2M3zaytjOmhTuSx6wnerZBrVoQxgbUuAv0WmUu50Hiw@mail.gmail.com>
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

T24gRnJpLCAzMSBNYXIgMjAyMyAxNTozNToxNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBNYXIgMzEsIDIwMjMgYXQgMzozMeKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFRo
dSwgMzAgTWFyIDIwMjMgMDI6MTc6NDMgLTA0MDAsICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+IE9uIFR1ZSwgTWFyIDI4LCAyMDIzIGF0IDA1OjI4OjMx
UE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gPiBDb25zaWRlcmluZyB0aGUgY29tcGxl
eGl0eSBvZiB2aXJ0aW8tbmV0LmMgYW5kIHRoZSBuZXcgZmVhdHVyZXMgd2Ugd2FudAo+ID4gPiA+
IHRvIGFkZCwgaXQgaXMgdGltZSB0byBzcGxpdCB2aXJ0aW8tbmV0LmMgaW50byBtdWx0aXBsZSBp
bmRlcGVuZGVudAo+ID4gPiA+IG1vZHVsZSBmaWxlcy4KPiA+ID4gPgo+ID4gPiA+IFRoaXMgaXMg
YmVuZWZpY2lhbCB0byB0aGUgbWFpbnRlbmFuY2UgYW5kIGFkZGluZyBuZXcgZnVuY3Rpb25zLgo+
ID4gPiA+Cj4gPiA+ID4gQW5kIEFGX1hEUCBzdXBwb3J0IHdpbGwgYmUgYWRkZWQgbGF0ZXIsIHRo
ZW4gYSBzZXBhcmF0ZSB4c2suYyBmaWxlIHdpbGwKPiA+ID4gPiBiZSBhZGRlZC4KPiA+ID4gPgo+
ID4gPiA+IFRoaXMgcGF0Y2hzZXQgc3BsaXQgdmlydGlvLW5ldC5jIGludG8gdGhlc2UgcGFydHM6
Cj4gPiA+ID4KPiA+ID4gPiAqIHZpcnRuZXQuYzogICAgICAgICB2aXJ0aW8gbmV0IGRldmljZSBv
cHMgKG5hcGksIHR4LCByeCwgZGV2aWNlIG9wcywgLi4uKQo+ID4gPiA+ICogdmlydG5ldF9jb21t
b24uYzogIHZpcnRpbyBuZXQgY29tbW9uIGNvZGUKPiA+ID4gPiAqIHZpcnRuZXRfZXRodG9vbC5j
OiB2aXJ0aW8gbmV0IGV0aHRvb2wgY2FsbGJhY2tzCj4gPiA+ID4gKiB2aXJ0bmV0X2N0cmwuYzog
ICAgdmlydGlvIG5ldCBjdHJsIHF1ZXVlIGNvbW1hbmQgQVBJcwo+ID4gPiA+ICogdmlydG5ldF92
aXJ0aW8uYzogIHZpcnRpbyBuZXQgdmlydGlvIGNhbGxiYWNrcy9vcHMgKGRyaXZlciByZWdpc3Rl
ciwgdmlydGlvIHByb2JlLCB2aXJ0aW8gZnJlZSwgLi4uKQo+ID4gPiA+Cj4gPiA+ID4gUGxlYXNl
IHJldmlldy4KPiA+ID4gPgo+ID4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4KPiA+ID4gSSBkb24n
dCBmZWVsIHRoaXMgaXMgYW4gaW1wcm92ZW1lbnQgYXMgcHJlc2VudGVkLCB3aWxsIG5lZWQgbW9y
ZSB3b3JrCj4gPiA+IHRvIG1ha2UgY29kZSBwbGFjZW1lbnQgbW9yZSBsb2dpY2FsLgo+ID4KPiA+
IFllcywgdGhpcyBkb2VzIG5lZWQgc29tZSB0aW1lIGFuZCBlbmVyZ3kuIEJ1dCBJIHRoaW5rIHRo
aXMgYWx3YXlzIG5lZWQgdG8gZG8sCj4gPiBqdXN0IHdoZW4gdG8gZG8gaXQuIEkgdGhpbmsgaXQg
aXMgY3VycmVudGx5IGFuIG9wcG9ydHVuaXR5Lgo+ID4KPiA+Cj4gPiA+Cj4gPiA+IEZvciBleGFt
cGxlIHdoZXJlIGRvIEkgZmluZCBjb2RlIHRvIHVwZGF0ZSBycSBzdGF0cz8KPiA+ID4gUnggZGF0
YSBwYXRoIHNob3VsZCBiZSB2aXJ0bmV0LmM/Cj4gPiA+IE5vIGl0J3MgaW4gdmlydG5ldF9ldGh0
b29sLmMgYmVjYXVzZSBycSBzdGF0cyBjYW4gYmUKPiA+ID4gYWNjZXNzZWQgYnkgZXRodG9vbC4K
PiA+Cj4gPiBUaGF0J3Mgd2hhdCBJIGRvLgo+ID4KPiA+ID4gQSBidW5jaCBvZiBzdHVmZiBzZWVt
cyB0byBiZSBpbiBoZWFkZXJzIGp1c3QgYmVjYXVzZSBvZiB0ZWNobmljYWxpdGllcy4KPiA+ID4g
dmlydGlvIGNvbW1vbiBzZWVtcyB0byBiZSBhIGR1bXBpbmcgZ3JvdW5kIHdpdGggbm8gZ3VpZGlu
ZyBwcmluY2lwbGUgYXQKPiA+ID4gYWxsLgo+ID4KPiA+IFllcywgSSBhZ3JlZSwgd2l0aCB0aGUg
ZGV2ZWxvcG1lbnQgb2YgdGltZSwgY29tbW9uIHdpbGwgaW5kZWVkIGJlY29tZSBhIGR1bXBpbmcK
PiA+IGdyb3VwLiBUaGlzIGlzIHNvbWV0aGluZyB3ZSBzaG91bGQgcGF5IGF0dGVudGlvbiB0byBh
ZnRlciB0aGlzLgo+ID4KPiA+Cj4gPiA+IGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X3ZpcnRp
by5jIGlzIHdlaXJkIHdpdGgKPiA+ID4gdmlydCByZXBlYXRlZCB0aHJlZSB0aW1lcyBpbiB0aGUg
cGF0aC4KPiA+Cj4gPiBBbnkgZ29vZCBpZGVhLgo+ID4KPiA+ID4KPiA+ID4gVGhlc2UgdGhpbmdz
IG9ubHkgZ2V0IG11cmtpZXIgd2l0aCB0aW1lLCBhdCB0aGUgcG9pbnQgb2YgcmVvcmcKPiA+ID4g
SSB3b3VsZCBleHBlY3QgdmVyeSBsb2dpY2FsIHBsYWNlbWVudCwgc2luY2UKPiA+ID4gd2l0aG91
dCBjbGVhciBndWlkaW5nIHJ1bGUgZmluZGluZyB3aGVyZSBzb21ldGhpbmcgaXMgYmVjb21lcyBo
YXJkZXIgYnV0Cj4gPiA+IG1vcmUgaW1wb3J0YW50bHkgd2UnbGwgbm93IGdldCBlbmRsZXNzIGhl
YXJ0YnVybiBhYm91dCB3aGVyZSBkb2VzIGVhY2ggbmV3Cj4gPiA+IGZ1bmN0aW9uIGdvLgo+ID4g
Pgo+ID4gPgo+ID4gPiBUaGUgcmVvcmcgaXMgdW5mb3J0dW5hdGVseSBub3QgZnJlZSAtIGZvciBl
eGFtcGxlIGdpdCBsb2cgLS1mb2xsb3cgd2lsbAo+ID4gPiBubyBsb25nZXIgZWFzaWx5IG1hdGNo
IHZpcnRpbyBiZWNhdXNlIC0tZm9sbG93IHdvcmtzIHdpdGggZXhhY3RseSBvbmUKPiA+ID4gcGF0
aC4KPiA+Cj4gPiBPbmUgZGF5IHdlIHdpbGwgZmFjZSB0aGlzIHByb2JsZW0uCj4gPgo+ID4gPiBJ
dCdzIG5vdyBhbHNvIGV4dHJhIHdvcmsgdG8ga2VlcCBoZWFkZXJzIHNlbGYtY29uc2lzdGVudC4K
PiA+Cj4gPiBDYW4gd2UgbWFrZSBpdCBzaW1wbGVyLCBmaXJzdCBjb21wbGV0ZSB0aGUgc3BsaXQu
Cj4gPgo+ID4KPiA+ID4gU28gaXQgYmV0dGVyIGJlIGEgYmlnIGltcHJvdmVtZW50IHRvIGJlIHdv
cnRoIGl0Lgo+ID4KPiA+Cj4gPiBPciBhYm91dCBzcGxpdCwgZG8geW91IGhhdmUgYW55IGJldHRl
ciB0aG91Z2h0cz8gT3IgZG8geW91IHRoaW5rIHdlIGhhdmUgYWx3YXlzCj4gPiBiZWVuIGxpa2Ug
dGhpcyBhbmQgbWFrZSBWaXJ0aW8tTmV0IG1vcmUgYW5kIG1vcmUgY29tcGxpY2F0ZWQ/Cj4KPiBN
eSBmZWVsaW5nIGlzIHRoYXQgbWF5YmUgaXQncyB3b3J0aCBpdCB0byBzdGFydCB1c2luZyBhIHNl
cGFyYXRlIGZpbGUKPiBmb3IgeHNrIHN1cHBvcnQuCgpJIGFncmVlLgoKQE1pY2hhZWwgYXQgdGhp
cyBwb2ludCwgd2hhdCBpcyB5b3VyIHRob3VnaHQ/CgoKVGhhbmtzLgoKCj4KPiBUaGFua3MKPgo+
ID4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4gPgo+ID4gPgo+ID4gPgo+ID4gPgo+ID4gPiA+IFh1
YW4gWmh1byAoMTYpOgo+ID4gPiA+ICAgdmlydGlvX25ldDogYWRkIGEgc2VwYXJhdGUgZGlyZWN0
b3J5IGZvciB2aXJ0aW8tbmV0Cj4gPiA+ID4gICB2aXJ0aW9fbmV0OiBtb3ZlIHN0cnVjdCB0byBo
ZWFkZXIgZmlsZQo+ID4gPiA+ICAgdmlydGlvX25ldDogYWRkIHByZWZpeCB0byB0aGUgc3RydWN0
IGluc2lkZSBoZWFkZXIgZmlsZQo+ID4gPiA+ICAgdmlydGlvX25ldDogc2VwYXJhdGluZyBjcHUt
cmVsYXRlZCBmdW5zCj4gPiA+ID4gICB2aXJ0aW9fbmV0OiBzZXBhcmF0ZSB2aXJ0bmV0X2N0cmxf
c2V0X3F1ZXVlcygpCj4gPiA+ID4gICB2aXJ0aW9fbmV0OiBzZXBhcmF0ZSB2aXJ0bmV0X2N0cmxf
c2V0X21hY19hZGRyZXNzKCkKPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHJlbW92ZSBsb2NrIGZyb20g
dmlydG5ldF9hY2tfbGlua19hbm5vdW5jZSgpCj4gPiA+ID4gICB2aXJ0aW9fbmV0OiBzZXBhcmF0
aW5nIHRoZSBBUElzIG9mIGNxCj4gPiA+ID4gICB2aXJ0aW9fbmV0OiBpbnRyb2R1Y2UgdmlydG5l
dF9ycV91cGRhdGVfc3RhdHMoKQo+ID4gPiA+ICAgdmlydGlvX25ldDogc2VwYXJhdGluZyB0aGUg
ZnVuY3Mgb2YgZXRodG9vbAo+ID4gPiA+ICAgdmlydGlvX25ldDogaW50cm9kdWNlIHZpcnRuZXRf
ZGV2X3J4X3F1ZXVlX2dyb3VwKCkKPiA+ID4gPiAgIHZpcnRpb19uZXQ6IGludHJvZHVjZSB2aXJ0
bmV0X2dldF9uZXRkZXYoKQo+ID4gPiA+ICAgdmlydGlvX25ldDogcHJlcGFyZSBmb3IgdmlydGlv
Cj4gPiA+ID4gICB2aXJ0aW9fbmV0OiBtb3ZlIHZpcnRuZXRfW2VuL2Rpc11hYmxlX2RlbGF5ZWRf
cmVmaWxsIHRvIGhlYWRlciBmaWxlCj4gPiA+ID4gICB2aXJ0aW9fbmV0OiBhZGQgQVBJcyB0byBy
ZWdpc3Rlci91bnJlZ2lzdGVyIHZpcnRpbyBkcml2ZXIKPiA+ID4gPiAgIHZpcnRpb19uZXQ6IHNl
cGFyYXRpbmcgdGhlIHZpcnRpbyBjb2RlCj4gPiA+ID4KPiA+ID4gPiAgTUFJTlRBSU5FUlMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArLQo+ID4gPiA+ICBkcml2ZXJz
L25ldC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICA4ICstCj4gPiA+ID4g
IGRyaXZlcnMvbmV0L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKy0K
PiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvL0tjb25maWcgICAgICAgICAgICAgICAgICAgIHwg
ICAxMSArCj4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby9NYWtlZmlsZSAgICAgICAgICAgICAg
ICAgICB8ICAgMTAgKwo+ID4gPiA+ICAuLi4vbmV0L3t2aXJ0aW9fbmV0LmMgPT4gdmlydGlvL3Zp
cnRuZXQuY30gICAgfCAyMzY4ICsrLS0tLS0tLS0tLS0tLS0tCj4gPiA+ID4gIGRyaXZlcnMvbmV0
L3ZpcnRpby92aXJ0bmV0LmggICAgICAgICAgICAgICAgICB8ICAyMTMgKysKPiA+ID4gPiAgZHJp
dmVycy9uZXQvdmlydGlvL3ZpcnRuZXRfY29tbW9uLmMgICAgICAgICAgIHwgIDEzOCArCj4gPiA+
ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X2NvbW1vbi5oICAgICAgICAgICB8ICAgMTQg
Kwo+ID4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8vdmlydG5ldF9jdHJsLmMgICAgICAgICAgICAg
fCAgMjcyICsrCj4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X2N0cmwuaCAgICAg
ICAgICAgICB8ICAgNDUgKwo+ID4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8vdmlydG5ldF9ldGh0
b29sLmMgICAgICAgICAgfCAgNTc4ICsrKysKPiA+ID4gPiAgZHJpdmVycy9uZXQvdmlydGlvL3Zp
cnRuZXRfZXRodG9vbC5oICAgICAgICAgIHwgICAgOCArCj4gPiA+ID4gIGRyaXZlcnMvbmV0L3Zp
cnRpby92aXJ0bmV0X3ZpcnRpby5jICAgICAgICAgICB8ICA4ODAgKysrKysrCj4gPiA+ID4gIGRy
aXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X3ZpcnRpby5oICAgICAgICAgICB8ICAgIDggKwo+ID4g
PiA+ICAxNSBmaWxlcyBjaGFuZ2VkLCAyMzY2IGluc2VydGlvbnMoKyksIDIxOTEgZGVsZXRpb25z
KC0pCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vS2NvbmZp
Zwo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL01ha2VmaWxl
Cj4gPiA+ID4gIHJlbmFtZSBkcml2ZXJzL25ldC97dmlydGlvX25ldC5jID0+IHZpcnRpby92aXJ0
bmV0LmN9ICg1MCUpCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0
aW8vdmlydG5ldC5oCj4gPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0
aW8vdmlydG5ldF9jb21tb24uYwo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9u
ZXQvdmlydGlvL3ZpcnRuZXRfY29tbW9uLmgKPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X2N0cmwuYwo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRuZXRfY3RybC5oCj4gPiA+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8vdmlydG5ldF9ldGh0b29sLmMKPiA+ID4gPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0X2V0aHRvb2wuaAo+ID4g
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRuZXRfdmlydGlv
LmMKPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby92aXJ0bmV0
X3ZpcnRpby5oCj4gPiA+ID4KPiA+ID4gPiAtLQo+ID4gPiA+IDIuMzIuMC4zLmcwMTE5NWNmOWYK
PiA+ID4KPiA+Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwo+IFZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdAo+IFZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCj4gaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
