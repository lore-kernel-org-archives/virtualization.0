Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E419BCDB474
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 08:13:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 70BDD61133;
	Fri, 20 Oct 2023 08:13:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 70BDD61133
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QwfD2rVu0bh3; Fri, 20 Oct 2023 08:13:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD5CB60ED7;
	Fri, 20 Oct 2023 08:13:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD5CB60ED7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8175FC0071;
	Fri, 20 Oct 2023 08:13:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEA68C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 08:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAE6984826
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 08:13:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CAE6984826
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DkhuDyiDEs03
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 08:13:02 +0000 (UTC)
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 21EFC8481F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 08:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21EFC8481F
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VuWbcAx_1697789574; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuWbcAx_1697789574) by smtp.aliyun-inc.com;
 Fri, 20 Oct 2023 16:12:55 +0800
Message-ID: <1697789368.7039382-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 12/19] virtio_net: xsk: tx: support wakeup
Date: Fri, 20 Oct 2023 16:09:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <20231016120033.26933-13-xuanzhuo@linux.alibaba.com>
 <CACGkMEsoA_y6FV0PzoLfO-UFhJrYRe96cDpX_hHgSo7PAwshrQ@mail.gmail.com>
In-Reply-To: <CACGkMEsoA_y6FV0PzoLfO-UFhJrYRe96cDpX_hHgSo7PAwshrQ@mail.gmail.com>
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

T24gRnJpLCAyMCBPY3QgMjAyMyAxNDo1MjoxOCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBPY3QgMTYsIDIwMjMgYXQgODowMeKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IHhzayB3
YWtldXAgaXMgdXNlZCB0byB0cmlnZ2VyIHRoZSBsb2dpYyBmb3IgeHNrIHhtaXQgYnkgeHNrIGZy
YW1ld29yayBvcgo+ID4gdXNlci4KPiA+Cj4gPiBWaXJ0aW8tTmV0IGRvZXMgbm90IHN1cHBvcnQg
dG8gYWN0aXZlbHkgZ2VuZXJhdGUgYW4gaW50ZXJydXB0aW9uLCBzbyBpdAo+ID4gdHJpZXMgdG8g
dHJpZ2dlciB0eCBOQVBJIG9uIHRoZSB0eCBpbnRlcnJ1cHQgY3B1Lgo+ID4KPiA+IENvbnNpZGVy
IHRoZSBlZmZlY3Qgb2YgY2FjaGUuIFdoZW4gaW50ZXJydXB0IHRyaWdnZXJzLCBpdCBpcwo+ID4g
Z2VuZXJhbGx5IGZpeGVkIG9uIGEgQ1BVLiBJdCBpcyBiZXR0ZXIgdG8gc3RhcnQgVFggTmFwaSBv
biB0aGUgc2FtZQo+ID4gQ1BVLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8v
bWFpbi5jICAgICAgIHwgIDMgKysKPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5o
IHwgIDggKysrKysKPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmMgICAgICAgIHwgNTcgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gPiAgZHJpdmVycy9uZXQvdmlydGlvL3hz
ay5oICAgICAgICB8ICAxICsKPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKykK
PiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL21haW4uYyBiL2RyaXZlcnMv
bmV0L3ZpcnRpby9tYWluLmMKPiA+IGluZGV4IGEwODQyOWJlZjYxZi4uMWEyMjIyMjEzNTJlIDEw
MDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvL21haW4uYwo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvL21haW4uYwo+ID4gQEAgLTIwNjYsNiArMjA2Niw4IEBAIHN0YXRpYyBpbnQg
dmlydG5ldF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiA+
ICAgICAgICAgICAgICAgICByZXR1cm4gMDsKPiA+ICAgICAgICAgfQo+ID4KPiA+ICsgICAgICAg
c3EtPnhzay5sYXN0X2NwdSA9IHNtcF9wcm9jZXNzb3JfaWQoKTsKPiA+ICsKPiA+ICAgICAgICAg
dHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBpbmRleCk7Cj4gPiAgICAgICAgIF9f
bmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJvY2Vzc29yX2lkKCkpOwo+ID4gICAgICAgICB2
aXJ0cXVldWVfZGlzYWJsZV9jYihzcS0+dnEpOwo+ID4gQEAgLTM3NzAsNiArMzc3Miw3IEBAIHN0
YXRpYyBjb25zdCBzdHJ1Y3QgbmV0X2RldmljZV9vcHMgdmlydG5ldF9uZXRkZXYgPSB7Cj4gPiAg
ICAgICAgIC5uZG9fdmxhbl9yeF9raWxsX3ZpZCA9IHZpcnRuZXRfdmxhbl9yeF9raWxsX3ZpZCwK
PiA+ICAgICAgICAgLm5kb19icGYgICAgICAgICAgICAgICAgPSB2aXJ0bmV0X3hkcCwKPiA+ICAg
ICAgICAgLm5kb194ZHBfeG1pdCAgICAgICAgICAgPSB2aXJ0bmV0X3hkcF94bWl0LAo+ID4gKyAg
ICAgICAubmRvX3hza193YWtldXAgICAgICAgICA9IHZpcnRuZXRfeHNrX3dha2V1cCwKPiA+ICAg
ICAgICAgLm5kb19mZWF0dXJlc19jaGVjayAgICAgPSBwYXNzdGhydV9mZWF0dXJlc19jaGVjaywK
PiA+ICAgICAgICAgLm5kb19nZXRfcGh5c19wb3J0X25hbWUgPSB2aXJ0bmV0X2dldF9waHlzX3Bv
cnRfbmFtZSwKPiA+ICAgICAgICAgLm5kb19zZXRfZmVhdHVyZXMgICAgICAgPSB2aXJ0bmV0X3Nl
dF9mZWF0dXJlcywKPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25l
dC5oIGIvZHJpdmVycy9uZXQvdmlydGlvL3ZpcnRpb19uZXQuaAo+ID4gaW5kZXggM2JiYjFmNWJh
YWQ1Li43YzcyYThiYjE4MTMgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW8vdmly
dGlvX25ldC5oCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW8vdmlydGlvX25ldC5oCj4gPiBA
QCAtMTAxLDYgKzEwMSwxNCBAQCBzdHJ1Y3QgdmlydG5ldF9zcSB7Cj4gPiAgICAgICAgICAgICAg
ICAgc3RydWN0IHhza19idWZmX3Bvb2wgX19yY3UgKnBvb2w7Cj4gPgo+ID4gICAgICAgICAgICAg
ICAgIGRtYV9hZGRyX3QgaGRyX2RtYV9hZGRyZXNzOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICAg
IHUzMiBsYXN0X2NwdTsKPiA+ICsgICAgICAgICAgICAgICBzdHJ1Y3QgX19jYWxsX3NpbmdsZV9k
YXRhIGNzZDsKPiA+ICsKPiA+ICsgICAgICAgICAgICAgICAvKiBUaGUgbG9jayB0byBwcmV2ZW50
IHRoZSByZXBlYXQgb2YgY2FsbGluZwo+ID4gKyAgICAgICAgICAgICAgICAqIHNtcF9jYWxsX2Z1
bmN0aW9uX3NpbmdsZV9hc3luYygpLgo+ID4gKyAgICAgICAgICAgICAgICAqLwo+ID4gKyAgICAg
ICAgICAgICAgIHNwaW5sb2NrX3QgaXBpX2xvY2s7Cj4gPiAgICAgICAgIH0geHNrOwo+ID4gIH07
Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpby94c2suYyBiL2RyaXZlcnMv
bmV0L3ZpcnRpby94c2suYwo+ID4gaW5kZXggMGU3NzVhOWQyNzBmLi45NzNlNzgzMjYwYzMgMTAw
NjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW8veHNrLmMKPiA+ICsrKyBiL2RyaXZlcnMv
bmV0L3ZpcnRpby94c2suYwo+ID4gQEAgLTExNSw2ICsxMTUsNjAgQEAgYm9vbCB2aXJ0bmV0X3hz
a194bWl0KHN0cnVjdCB2aXJ0bmV0X3NxICpzcSwgc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2ws
Cj4gPiAgICAgICAgIHJldHVybiBzZW50ID09IGJ1ZGdldDsKPiA+ICB9Cj4gPgo+ID4gK3N0YXRp
YyB2b2lkIHZpcnRuZXRfcmVtb3RlX25hcGlfc2NoZWR1bGUodm9pZCAqaW5mbykKPiA+ICt7Cj4g
PiArICAgICAgIHN0cnVjdCB2aXJ0bmV0X3NxICpzcSA9IGluZm87Cj4gPiArCj4gPiArICAgICAg
IHZpcnRuZXRfdnFfbmFwaV9zY2hlZHVsZSgmc3EtPm5hcGksIHNxLT52cSk7Cj4gPiArfQo+ID4g
Kwo+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfcmVtb3RlX3JhaXNlX25hcGkoc3RydWN0IHZpcnRu
ZXRfc3EgKnNxKQo+ID4gK3sKPiA+ICsgICAgICAgdTMyIGxhc3RfY3B1LCBjdXJfY3B1Owo+ID4g
Kwo+ID4gKyAgICAgICBsYXN0X2NwdSA9IHNxLT54c2subGFzdF9jcHU7Cj4gPiArICAgICAgIGN1
cl9jcHUgPSBnZXRfY3B1KCk7Cj4gPiArCj4gPiArICAgICAgIC8qIE9uIHJlbW90ZSBjcHUsIHNv
ZnRpcnEgd2lsbCBydW4gYXV0b21hdGljYWxseSB3aGVuIGlwaSBpcnEgZXhpdC4gT24KPiA+ICsg
ICAgICAgICogbG9jYWwgY3B1LCBzbXBfY2FsbF94eHggd2lsbCBub3QgdHJpZ2dlciBpcGkgaW50
ZXJydXB0LCB0aGVuIHNvZnRpcnEKPiA+ICsgICAgICAgICogY2Fubm90IGJlIHRyaWdnZXJlZCBh
dXRvbWF0aWNhbGx5LiBTbyBDYWxsIGxvY2FsX2JoX2VuYWJsZSBhZnRlciB0bwo+ID4gKyAgICAg
ICAgKiB0cmlnZ2VyIHNvZnRJUlEgcHJvY2Vzc2luZy4KPiA+ICsgICAgICAgICovCj4gPiArICAg
ICAgIGlmIChsYXN0X2NwdSA9PSBjdXJfY3B1KSB7Cj4gPiArICAgICAgICAgICAgICAgbG9jYWxf
YmhfZGlzYWJsZSgpOwo+ID4gKyAgICAgICAgICAgICAgIHZpcnRuZXRfdnFfbmFwaV9zY2hlZHVs
ZSgmc3EtPm5hcGksIHNxLT52cSk7Cj4gPiArICAgICAgICAgICAgICAgbG9jYWxfYmhfZW5hYmxl
KCk7Cj4gPiArICAgICAgIH0gZWxzZSB7Cj4gPiArICAgICAgICAgICAgICAgaWYgKHNwaW5fdHJ5
bG9jaygmc3EtPnhzay5pcGlfbG9jaykpIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHNt
cF9jYWxsX2Z1bmN0aW9uX3NpbmdsZV9hc3luYyhsYXN0X2NwdSwgJnNxLT54c2suY3NkKTsKPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZzcS0+eHNrLmlwaV9sb2NrKTsK
PiA+ICsgICAgICAgICAgICAgICB9Cj4gPiArICAgICAgIH0KPgo+IElzIHRoZXJlIGFueSBudW1i
ZXIgdG8gc2hvdyB3aGV0aGVyIGl0J3Mgd29ydGggaXQgZm9yIGFuIElQSSBoZXJlPyBGb3IKPiBl
eGFtcGxlLCBHVkUgZG9lc24ndCBkbyB0aGlzLgoKSSBqdXN0IGRvIG5vdCBsaWtlIHRoZSB0eCBu
YXBpIHdpbGwgcnVuIG9uIGRpZmZlcmVuY2UgQ1BVcy4KCkxldCdzIHN0YXJ0IHdpdGggdGhlIHdh
eSBvZiBHVkUuCgpUaGFua3MKCgo+Cj4gVGhhbmtzCj4KPgo+ID4gKwo+ID4gKyAgICAgICBwdXRf
Y3B1KCk7Cj4gPiArfQo+ID4gKwo+ID4gK2ludCB2aXJ0bmV0X3hza193YWtldXAoc3RydWN0IG5l
dF9kZXZpY2UgKmRldiwgdTMyIHFpZCwgdTMyIGZsYWcpCj4gPiArewo+ID4gKyAgICAgICBzdHJ1
Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gPiArICAgICAgIHN0cnVj
dCB2aXJ0bmV0X3NxICpzcTsKPiA+ICsKPiA+ICsgICAgICAgaWYgKCFuZXRpZl9ydW5uaW5nKGRl
dikpCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuIC1FTkVURE9XTjsKPiA+ICsKPiA+ICsgICAg
ICAgaWYgKHFpZCA+PSB2aS0+Y3Vycl9xdWV1ZV9wYWlycykKPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsKPiA+ICsKPiA+ICsgICAgICAgc3EgPSAmdmktPnNxW3FpZF07Cj4gPiAr
Cj4gPiArICAgICAgIGlmIChuYXBpX2lmX3NjaGVkdWxlZF9tYXJrX21pc3NlZCgmc3EtPm5hcGkp
KQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gKwo+ID4gKyAgICAgICB2aXJ0bmV0
X3JlbW90ZV9yYWlzZV9uYXBpKHNxKTsKPiA+ICsKPiA+ICsgICAgICAgcmV0dXJuIDA7Cj4gPiAr
fQo+ID4gKwo+ID4gIHN0YXRpYyBpbnQgdmlydG5ldF9ycV9iaW5kX3hza19wb29sKHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3QgdmlydG5ldF9ycSAqcnEsCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqcG9vbCkKPiA+ICB7
Cj4gPiBAQCAtMjQwLDYgKzI5NCw5IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94c2tfcG9vbF9lbmFi
bGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+Cj4gPiAgICAgICAgIHNxLT54c2suaGRyX2Rt
YV9hZGRyZXNzID0gaGRyX2RtYTsKPiA+Cj4gPiArICAgICAgIElOSVRfQ1NEKCZzcS0+eHNrLmNz
ZCwgdmlydG5ldF9yZW1vdGVfbmFwaV9zY2hlZHVsZSwgc3EpOwo+ID4gKyAgICAgICBzcGluX2xv
Y2tfaW5pdCgmc3EtPnhzay5pcGlfbG9jayk7Cj4gPiArCj4gPiAgICAgICAgIHJldHVybiAwOwo+
ID4KPiA+ICBlcnJfc3E6Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvL3hzay5o
IGIvZHJpdmVycy9uZXQvdmlydGlvL3hzay5oCj4gPiBpbmRleCA3M2NhOGNkNTMwOGIuLjFiZDE5
ZGNkYTY0OSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpby94c2suaAo+ID4gKysr
IGIvZHJpdmVycy9uZXQvdmlydGlvL3hzay5oCj4gPiBAQCAtMTcsNCArMTcsNSBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgKnZpcnRuZXRfeHNrX3RvX3B0cih1MzIgbGVuKQo+ID4gIGludCB2aXJ0bmV0
X3hza19wb29sX3NldHVwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBuZXRkZXZfYnBm
ICp4ZHApOwo+ID4gIGJvb2wgdmlydG5ldF94c2tfeG1pdChzdHJ1Y3QgdmlydG5ldF9zcSAqc3Es
IHN0cnVjdCB4c2tfYnVmZl9wb29sICpwb29sLAo+ID4gICAgICAgICAgICAgICAgICAgICAgIGlu
dCBidWRnZXQpOwo+ID4gK2ludCB2aXJ0bmV0X3hza193YWtldXAoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwgdTMyIHFpZCwgdTMyIGZsYWcpOwo+ID4gICNlbmRpZgo+ID4gLS0KPiA+IDIuMzIuMC4z
LmcwMTE5NWNmOWYKPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
