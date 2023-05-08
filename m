Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCF0C77B7D
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 01:48:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A808605A0;
	Mon,  8 May 2023 01:48:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A808605A0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qfcUMKY58yZ0; Mon,  8 May 2023 01:48:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6CE10605A3;
	Mon,  8 May 2023 01:48:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CE10605A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 399AFC0036;
	Mon,  8 May 2023 01:48:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAB69C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 01:48:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84987416AF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 01:48:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 84987416AF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5mzBix30-wE9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 01:48:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40C8C4099D
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 40C8C4099D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 01:48:18 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=11; SR=0;
 TI=SMTPD_---0Vhymz9._1683510491; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vhymz9._1683510491) by smtp.aliyun-inc.com;
 Mon, 08 May 2023 09:48:12 +0800
Message-ID: <1683510351.569717-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v3] virtio_net: Fix error unwinding of XDP
 initialization
Date: Mon, 8 May 2023 09:45:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Feng Liu <feliu@nvidia.com>
References: <20230503003525.48590-1-feliu@nvidia.com>
 <1683340417.612963-3-xuanzhuo@linux.alibaba.com>
 <559ad341-2278-5fad-6805-c7f632e9894e@nvidia.com>
In-Reply-To: <559ad341-2278-5fad-6805-c7f632e9894e@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Simon Horman <simon.horman@corigine.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, William Tu <witu@nvidia.com>,
 netdev@vger.kernel.org, Bodong Wang <bodong@nvidia.com>, bpf@vger.kernel.org
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

T24gU2F0LCA2IE1heSAyMDIzIDA4OjA4OjAyIC0wNDAwLCBGZW5nIExpdSA8ZmVsaXVAbnZpZGlh
LmNvbT4gd3JvdGU6Cj4KPgo+IE9uIDIwMjMtMDUtMDUgcC5tLjEwOjMzLCBYdWFuIFpodW8gd3Jv
dGU6Cj4gPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRh
Y2htZW50cwo+ID4KPiA+Cj4gPiBPbiBUdWUsIDIgTWF5IDIwMjMgMjA6MzU6MjUgLTA0MDAsIEZl
bmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPiB3cm90ZToKPiA+PiBXaGVuIGluaXRpYWxpemluZyBY
RFAgaW4gdmlydG5ldF9vcGVuKCksIHNvbWUgcnEgeGRwIGluaXRpYWxpemF0aW9uCj4gPj4gbWF5
IGhpdCBhbiBlcnJvciBjYXVzaW5nIG5ldCBkZXZpY2Ugb3BlbiBmYWlsZWQuIEhvd2V2ZXIsIHBy
ZXZpb3VzCj4gPj4gcnFzIGhhdmUgYWxyZWFkeSBpbml0aWFsaXplZCBYRFAgYW5kIGVuYWJsZWQg
TkFQSSwgd2hpY2ggaXMgbm90IHRoZQo+ID4+IGV4cGVjdGVkIGJlaGF2aW9yLiBOZWVkIHRvIHJv
bGwgYmFjayB0aGUgcHJldmlvdXMgcnEgaW5pdGlhbGl6YXRpb24KPiA+PiB0byBhdm9pZCBsZWFr
cyBpbiBlcnJvciB1bndpbmRpbmcgb2YgaW5pdCBjb2RlLgo+ID4+Cj4gPj4gQWxzbyBleHRyYWN0
IGEgaGVscGVyIGZ1bmN0aW9uIG9mIGRpc2FibGUgcXVldWUgcGFpcnMsIGFuZCB1c2UgbmV3bHkK
PiA+PiBpbnRyb2R1Y2VkIGhlbHBlciBmdW5jdGlvbiBpbiBlcnJvciB1bndpbmRpbmcgYW5kIHZp
cnRuZXRfY2xvc2U7Cj4gPj4KPiA+PiBJc3N1ZTogMzM4MzAzOAo+ID4+IEZpeGVzOiA3NTRiOGEy
MWE5NmQgKCJ2aXJ0aW9fbmV0OiBzZXR1cCB4ZHBfcnhxX2luZm8iKQo+ID4+IFNpZ25lZC1vZmYt
Ynk6IEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPgo+ID4+IFJldmlld2VkLWJ5OiBXaWxsaWFt
IFR1IDx3aXR1QG52aWRpYS5jb20+Cj4gPj4gUmV2aWV3ZWQtYnk6IFBhcmF2IFBhbmRpdCA8cGFy
YXZAbnZpZGlhLmNvbT4KPiA+PiBSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuIDxzaW1vbi5ob3Jt
YW5AY29yaWdpbmUuY29tPgo+ID4+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPgo+ID4+IENoYW5nZS1JZDogSWI0YzZhOTdjYjdiODM3Y2ZhNDg0YzU5M2RkNDNh
NDM1YzQ3ZWE2OGYKPiA+PiAtLS0KPiA+PiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDMw
ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDIw
IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+ID4+Cj4gPj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+IGlu
ZGV4IDhkODAzODUzOGZjNC4uMzczN2NmMTIwY2I3IDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+
IEBAIC0xODY4LDYgKzE4NjgsMTMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3BvbGwoc3RydWN0IG5h
cGlfc3RydWN0ICpuYXBpLCBpbnQgYnVkZ2V0KQo+ID4+ICAgICAgICByZXR1cm4gcmVjZWl2ZWQ7
Cj4gPj4gICB9Cj4gPj4KPiA+PiArc3RhdGljIHZvaWQgdmlydG5ldF9kaXNhYmxlX3FwKHN0cnVj
dCB2aXJ0bmV0X2luZm8gKnZpLCBpbnQgcXBfaW5kZXgpCj4gPj4gK3sKPiA+PiArICAgICB2aXJ0
bmV0X25hcGlfdHhfZGlzYWJsZSgmdmktPnNxW3FwX2luZGV4XS5uYXBpKTsKPiA+PiArICAgICBu
YXBpX2Rpc2FibGUoJnZpLT5ycVtxcF9pbmRleF0ubmFwaSk7Cj4gPj4gKyAgICAgeGRwX3J4cV9p
bmZvX3VucmVnKCZ2aS0+cnFbcXBfaW5kZXhdLnhkcF9yeHEpOwo+ID4+ICt9Cj4gPj4gKwo+ID4+
ICAgc3RhdGljIGludCB2aXJ0bmV0X29wZW4oc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+PiAg
IHsKPiA+PiAgICAgICAgc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYp
Owo+ID4+IEBAIC0xODgzLDIwICsxODkwLDI2IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9vcGVuKHN0
cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPj4KPiA+PiAgICAgICAgICAgICAgICBlcnIgPSB4ZHBf
cnhxX2luZm9fcmVnKCZ2aS0+cnFbaV0ueGRwX3J4cSwgZGV2LCBpLCB2aS0+cnFbaV0ubmFwaS5u
YXBpX2lkKTsKPiA+PiAgICAgICAgICAgICAgICBpZiAoZXJyIDwgMCkKPiA+PiAtICAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIGVycjsKPiA+PiArICAgICAgICAgICAgICAgICAgICAgZ290byBl
cnJfeGRwX2luZm9fcmVnOwo+ID4+Cj4gPj4gICAgICAgICAgICAgICAgZXJyID0geGRwX3J4cV9p
bmZvX3JlZ19tZW1fbW9kZWwoJnZpLT5ycVtpXS54ZHBfcnhxLAo+ID4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1FTV9UWVBFX1BBR0VfU0hBUkVELCBO
VUxMKTsKPiA+PiAtICAgICAgICAgICAgIGlmIChlcnIgPCAwKSB7Cj4gPj4gLSAgICAgICAgICAg
ICAgICAgICAgIHhkcF9yeHFfaW5mb191bnJlZygmdmktPnJxW2ldLnhkcF9yeHEpOwo+ID4+IC0g
ICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+ID4+IC0gICAgICAgICAgICAgfQo+ID4+
ICsgICAgICAgICAgICAgaWYgKGVyciA8IDApCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgIGdv
dG8gZXJyX3hkcF9yZWdfbWVtX21vZGVsOwo+ID4+Cj4gPj4gICAgICAgICAgICAgICAgdmlydG5l
dF9uYXBpX2VuYWJsZSh2aS0+cnFbaV0udnEsICZ2aS0+cnFbaV0ubmFwaSk7Cj4gPj4gICAgICAg
ICAgICAgICAgdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgdmktPnNxW2ldLnZxLCAmdmktPnNx
W2ldLm5hcGkpOwo+ID4+ICAgICAgICB9Cj4gPj4KPiA+PiAgICAgICAgcmV0dXJuIDA7Cj4gPj4g
Kwo+ID4+ICtlcnJfeGRwX3JlZ19tZW1fbW9kZWw6Cj4gPj4gKyAgICAgeGRwX3J4cV9pbmZvX3Vu
cmVnKCZ2aS0+cnFbaV0ueGRwX3J4cSk7Cj4gPj4gK2Vycl94ZHBfaW5mb19yZWc6Cj4gPj4gKyAg
ICAgZm9yIChpID0gaSAtIDE7IGkgPj0gMDsgaS0tKQo+ID4+ICsgICAgICAgICAgICAgdmlydG5l
dF9kaXNhYmxlX3FwKHZpLCBpKTsKPiA+Cj4gPgo+ID4gSSB3b3VsZCB0byBrbm93IHNob3VsZCB3
ZSBoYW5kbGUgZm9yIHRoZXNlOgo+ID4KPiA+ICAgICAgICAgIGRpc2FibGVfZGVsYXllZF9yZWZp
bGwodmkpOwo+ID4gICAgICAgICAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZ2aS0+cmVmaWxs
KTsKPiA+Cj4gPgo+ID4gTWF5YmUgd2Ugc2hvdWxkIGNhbGwgdmlydG5ldF9jbG9zZSgpIHdpdGgg
ImkiIGRpcmVjdGx5Lgo+ID4KPiA+IFRoYW5rcy4KPiA+Cj4gPgo+IENhbuKAmXQgdXNlIGkgZGly
ZWN0bHkgaGVyZSwgYmVjYXVzZSBpZiB4ZHBfcnhxX2luZm9fcmVnIGZhaWxzLCBuYXBpIGhhcwo+
IG5vdCBiZWVuIGVuYWJsZWQgZm9yIGN1cnJlbnQgcXAgeWV0LCBJIHNob3VsZCByb2xsIGJhY2sg
ZnJvbSB0aGUgcXVldWUKPiBwYWlycyB3aGVyZSBuYXBpIHdhcyBlbmFibGVkIGJlZm9yZShpLS0p
LCBvdGhlcndpc2UgaXQgd2lsbCBoYW5nIGF0IG5hcGkKPiBkaXNhYmxlIGFwaQoKVGhpcyBpcyBu
b3QgdGhlIHBvaW50LCB0aGUga2V5IGlzIHdoZXRoZXIgd2Ugc2hvdWxkIGhhbmRsZSB3aXRoOgoK
ICAgICAgICAgIGRpc2FibGVfZGVsYXllZF9yZWZpbGwodmkpOwogICAgICAgICAgY2FuY2VsX2Rl
bGF5ZWRfd29ya19zeW5jKCZ2aS0+cmVmaWxsKTsKClRoYW5rcy4KCgo+Cj4gPj4gKwo+ID4+ICsg
ICAgIHJldHVybiBlcnI7Cj4gPj4gICB9Cj4gPj4KPiA+PiAgIHN0YXRpYyBpbnQgdmlydG5ldF9w
b2xsX3R4KHN0cnVjdCBuYXBpX3N0cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiA+PiBAQCAtMjMw
NSwxMSArMjMxOCw4IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9jbG9zZShzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2KQo+ID4+ICAgICAgICAvKiBNYWtlIHN1cmUgcmVmaWxsX3dvcmsgZG9lc24ndCByZS1l
bmFibGUgbmFwaSEgKi8KPiA+PiAgICAgICAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZ2aS0+
cmVmaWxsKTsKPiA+Pgo+ID4+IC0gICAgIGZvciAoaSA9IDA7IGkgPCB2aS0+bWF4X3F1ZXVlX3Bh
aXJzOyBpKyspIHsKPiA+PiAtICAgICAgICAgICAgIHZpcnRuZXRfbmFwaV90eF9kaXNhYmxlKCZ2
aS0+c3FbaV0ubmFwaSk7Cj4gPj4gLSAgICAgICAgICAgICBuYXBpX2Rpc2FibGUoJnZpLT5ycVtp
XS5uYXBpKTsKPiA+PiAtICAgICAgICAgICAgIHhkcF9yeHFfaW5mb191bnJlZygmdmktPnJxW2ld
LnhkcF9yeHEpOwo+ID4+IC0gICAgIH0KPiA+PiArICAgICBmb3IgKGkgPSAwOyBpIDwgdmktPm1h
eF9xdWV1ZV9wYWlyczsgaSsrKQo+ID4+ICsgICAgICAgICAgICAgdmlydG5ldF9kaXNhYmxlX3Fw
KHZpLCBpKTsKPiA+Pgo+ID4+ICAgICAgICByZXR1cm4gMDsKPiA+PiAgIH0KPiA+PiAtLQo+ID4+
IDIuMzcuMSAoQXBwbGUgR2l0LTEzNy4xKQo+ID4+Cl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
