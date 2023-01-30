Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81FF9C54EAA
	for <virtualization@archiver.kernel.org>; Mon, 30 Jan 2023 07:40:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EC0D2405BA;
	Mon, 30 Jan 2023 07:40:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EC0D2405BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q3DwSogIQlcb; Mon, 30 Jan 2023 07:40:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 67C7140475;
	Mon, 30 Jan 2023 07:40:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67C7140475
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25314C0032;
	Mon, 30 Jan 2023 07:40:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F1BDC002B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 07:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1CF360C29
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 07:40:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F1CF360C29
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NCpJYpfkq5l8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 07:40:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E43EB60ABD
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E43EB60ABD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Jan 2023 07:40:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VaPc4LJ_1675064403; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VaPc4LJ_1675064403) by smtp.aliyun-inc.com;
 Mon, 30 Jan 2023 15:40:04 +0800
Message-ID: <1675064346.4139252-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] vhost-net: support VIRTIO_F_RING_RESET
Date: Mon, 30 Jan 2023 15:39:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220825085610.80315-1-kangjie.xu@linux.alibaba.com>
 <10630d99-e0bd-c067-8766-19266b38d2fe@redhat.com>
In-Reply-To: <10630d99-e0bd-c067-8766-19266b38d2fe@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 Kangjie Xu <kangjie.xu@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hengqi@linux.alibaba.com,
 bpf@vger.kernel.org
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

T24gTW9uLCA1IFNlcCAyMDIyIDE2OjMyOjE5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzgvMjUgMTY6NTYsIEthbmdqaWUgWHUg5YaZ
6YGTOgo+ID4gQWRkIFZJUlRJT19GX1JJTkdfUkVTRVQsIHdoaWNoIGluZGljYXRlcyB0aGF0IHRo
ZSBkcml2ZXIgY2FuIHJlc2V0IGEKPiA+IHF1ZXVlIGluZGl2aWR1YWxseS4KPiA+Cj4gPiBWSVJU
SU9fRl9SSU5HX1JFU0VUIGZlYXR1cmUgaXMgYWRkZWQgdG8gdmlydGlvLXNwZWMgMS4yLiBUaGUg
cmVsZXZhbnQKPiA+IGluZm9ybWF0aW9uIGlzIGluCj4gPiAgICAgIG9hc2lzLXRjcy92aXJ0aW8t
c3BlYyMxMjQKPiA+ICAgICAgb2FzaXMtdGNzL3ZpcnRpby1zcGVjIzEzOQo+ID4KPiA+IFRoZSBp
bXBsZW1lbnRhdGlvbiBvbmx5IGFkZHMgdGhlIGZlYXR1cmUgYml0IGluIHN1cHBvcnRlZCBmZWF0
dXJlcy4gSXQKPiA+IGRvZXMgbm90IHJlcXVpcmUgYW55IG90aGVyIGNoYW5nZXMgYmVjYXVzZSB3
ZSByZXVzZSB0aGUgZXhpc3Rpbmcgdmhvc3QKPiA+IHByb3RvY29sLgo+ID4KPiA+IFRoZSB2aXJ0
cXVldWUgcmVzZXQgcHJvY2VzcyBjYW4gYmUgY29uY2x1ZGVkIGFzIHR3byBwYXJ0czoKPiA+IDEu
IFRoZSBkcml2ZXIgY2FuIHJlc2V0IGEgdmlydHF1ZXVlLiBXaGVuIGl0IGlzIHRyaWdnZXJlZCwg
d2UgdXNlIHRoZQo+ID4gc2V0X2JhY2tlbmQgdG8gZGlzYWJsZSB0aGUgdmlydHF1ZXVlLgo+ID4g
Mi4gQWZ0ZXIgdGhlIHZpcnRxdWV1ZSBpcyBkaXNhYmxlZCwgdGhlIGRyaXZlciBtYXkgb3B0aW9u
YWxseSByZS1lbmFibGUKPiA+IGl0LiBUaGUgcHJvY2VzcyBpcyBiYXNpY2FsbHkgc2ltaWxhciB0
byB3aGVuIHRoZSBkZXZpY2UgaXMgc3RhcnRlZCwKPiA+IGV4Y2VwdCB0aGF0IHRoZSByZXN0YXJ0
IHByb2Nlc3MgZG9lcyBub3QgbmVlZCB0byBzZXQgZmVhdHVyZXMgYW5kIHNldAo+ID4gbWVtIHRh
YmxlIHNpbmNlIHRoZXkgZG8gbm90IGNoYW5nZS4gUUVNVSB3aWxsIHNlbmQgbWVzc2FnZXMgY29u
dGFpbmluZwo+ID4gc2l6ZSwgYmFzZSwgYWRkciwga2lja2ZkIGFuZCBjYWxsZmQgb2YgdGhlIHZp
cnRxdWV1ZSBpbiBvcmRlci4KPiA+IFNwZWNpZmljYWxseSwgdGhlIGhvc3Qga2VybmVsIHdpbGwg
cmVjZWl2ZSB0aGVzZSBtZXNzYWdlcyBpbiBvcmRlcjoKPiA+ICAgICAgYS4gVkhPU1RfU0VUX1ZS
SU5HX05VTQo+ID4gICAgICBiLiBWSE9TVF9TRVRfVlJJTkdfQkFTRQo+ID4gICAgICBjLiBWSE9T
VF9TRVRfVlJJTkdfQUREUgo+ID4gICAgICBkLiBWSE9TVF9TRVRfVlJJTkdfS0lDSwo+ID4gICAg
ICBlLiBWSE9TVF9TRVRfVlJJTkdfQ0FMTAo+ID4gICAgICBmLiBWSE9TVF9ORVRfU0VUX0JBQ0tF
TkQKPiA+IEZpbmFsbHksIGFmdGVyIHdlIHVzZSBzZXRfYmFja2VuZCB0byBhdHRhY2ggdGhlIHZp
cnRxdWV1ZSwgdGhlIHZpcnRxdWV1ZQo+ID4gd2lsbCBiZSBlbmFibGVkIGFuZCBzdGFydCB0byB3
b3JrLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IEthbmdqaWUgWHUgPGthbmdqaWUueHVAbGludXgu
YWxpYmFiYS5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPgo+Cj4KPiBBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KCkBtc3QKCkRvIHdlIG1pc3MgdGhpcz8KClRoYW5rcy4KCj4KPgo+ID4gLS0tCj4gPgo+
ID4gVGVzdCBlbnZpcm9ubWVudCBhbmQgbWV0aG9kOgo+ID4gICAgICBIb3N0OiA1LjE5LjAtcmMz
Cj4gPiAgICAgIFFlbXU6IFFFTVUgZW11bGF0b3IgdmVyc2lvbiA3LjAuNTAgKFdpdGggdnEgcnNl
dCBzdXBwb3J0KQo+ID4gICAgICBHdWVzdDogNS4xOS4wLXJjMyAoV2l0aCB2cSByZXNldCBzdXBw
b3J0KQo+ID4gICAgICBUZXN0IENtZDogZXRodG9vbCAtZyBldGgxOyBldGh0b29sIC1HIGV0aDEg
cnggJDEgdHggJDI7IGV0aHRvb2wgLWcgZXRoMTsKPiA+Cj4gPiAgICAgIFRoZSBkcnZpZXIgY2Fu
IHJlc2l6ZSB0aGUgdmlydGlvIHF1ZXVlLCB0aGVuIHZpcnRpbyBxdWV1ZSByZXNldCBmdW5jdGlv
biBzaG91bGQKPiA+ICAgICAgYmUgdHJpZ2dlcmVkLgo+ID4KPiA+ICAgICAgVGhlIGRlZmF1bHQg
aXMgc3BsaXQgbW9kZSwgbW9kaWZ5IFFlbXUgdmlydGlvLW5ldCB0byBhZGQgUEFDS0VEIGZlYXR1
cmUgdG8KPiA+ICAgICAgdGVzdCBwYWNrZWQgbW9kZS4KPiA+Cj4gPiBHdWVzdCBLZXJuZWwgUGF0
Y2g6Cj4gPiAgICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi8yMDIyMDgwMTA2MzkwMi4x
MjkzMjktMS14dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbS8KPiA+Cj4gPiBRRU1VIFBhdGNoOgo+
ID4gICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL2NvdmVyLjE2NjE0MTQz
NDUuZ2l0LmthbmdqaWUueHVAbGludXguYWxpYmFiYS5jb20vCj4gPgo+ID4gTG9va2luZyBmb3J3
YXJkIHRvIHlvdXIgcmV2aWV3IGFuZCBjb21tZW50cy4gVGhhbmtzLgo+ID4KPiA+ICAgZHJpdmVy
cy92aG9zdC9uZXQuYyB8IDMgKystCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC9uZXQu
YyBiL2RyaXZlcnMvdmhvc3QvbmV0LmMKPiA+IGluZGV4IDY4ZTRlY2QxY2MwZS4uOGEzNDkyOGQ0
ZmVmIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy92aG9zdC9uZXQuYwo+ID4gKysrIGIvZHJpdmVy
cy92aG9zdC9uZXQuYwo+ID4gQEAgLTczLDcgKzczLDggQEAgZW51bSB7Cj4gPiAgIAlWSE9TVF9O
RVRfRkVBVFVSRVMgPSBWSE9TVF9GRUFUVVJFUyB8Cj4gPiAgIAkJCSAoMVVMTCA8PCBWSE9TVF9O
RVRfRl9WSVJUSU9fTkVUX0hEUikgfAo+ID4gICAJCQkgKDFVTEwgPDwgVklSVElPX05FVF9GX01S
R19SWEJVRikgfAo+ID4gLQkJCSAoMVVMTCA8PCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pCj4g
PiArCQkJICgxVUxMIDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkgfAo+ID4gKwkJCSAoMVVM
TCA8PCBWSVJUSU9fRl9SSU5HX1JFU0VUKQo+ID4gICB9Owo+ID4KPiA+ICAgZW51bSB7Cj4KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
