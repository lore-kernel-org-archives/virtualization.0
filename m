Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCF3C7EE20
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 07:46:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE71C60BC2;
	Tue, 25 Apr 2023 07:46:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DE71C60BC2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yyzFfu9yWLcG; Tue, 25 Apr 2023 07:46:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5B36F60B0F;
	Tue, 25 Apr 2023 07:46:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B36F60B0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31FCDC0037;
	Tue, 25 Apr 2023 07:46:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5006BC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 28620414C2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28620414C2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mxsPIa9V3rIx
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:46:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0F1A440982
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0F1A440982
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:46:31 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VgzJO0s_1682408786; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgzJO0s_1682408786) by smtp.aliyun-inc.com;
 Tue, 25 Apr 2023 15:46:27 +0800
Message-ID: <1682408766.7832832-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 07/15] virtio_net: auto release xdp shinfo
Date: Tue, 25 Apr 2023 15:46:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230423105736.56918-1-xuanzhuo@linux.alibaba.com>
 <20230423105736.56918-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEsNLa9ETksZBi-fkni3c0FzpdNFr-y87Gt48-QKuLDPtg@mail.gmail.com>
In-Reply-To: <CACGkMEsNLa9ETksZBi-fkni3c0FzpdNFr-y87Gt48-QKuLDPtg@mail.gmail.com>
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

T24gVHVlLCAyNSBBcHIgMjAyMyAxNTo0MToyOCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gU3VuLCBBcHIgMjMsIDIwMjMgYXQgNjo1N+KAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IHZpcnRu
ZXRfYnVpbGRfeGRwX2J1ZmZfbXJnKCkgYW5kIHZpcnRuZXRfeGRwX2hhbmRsZXIoKSBhdXRvCj4g
PiByZWxlYXNlIHhkcCBzaGluZm8gdGhlbiB0aGUgY2FsbGVyIG5vIG5lZWQgdG8gY2FyZWZ1bCB0
aGUgeGRwIHNoaW5mby4KPgo+IFRoaW5raW5nIG9mIHRoaXMsIEkgdGhpbmsgcmVsZWFzaW5nIGZy
YWdzIGluCj4gdmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoKSBpcyBmaW5lLiBCdXQgZm9yIHZp
cnRuZXRfeGRwX2hhbmRsZXIoKSwKPiBpdCdzIGJldHRlciB0byBiZSBkb25lIGJ5IHRoZSBjYWxs
ZXIsIHNpbmNlIHRoZSBmcmFncyB3ZXJlIHByZXBhcmVkIGJ5Cj4gdGhlIGNhbGxlciBhbnlob3cu
CgoKSSBhZ3JlZSB0aGlzLgoKVGhhbmtzLgoKCj4KPiBUaGFua3MKPgo+ID4KPiA+IFNpZ25lZC1v
ZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+
ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAyOSArKysrKysrKysrKysrKysrKy0tLS0tLS0t
LS0tLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMo
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBpbmRleCA1ZjM3YTFjZWY2MWUuLmM2YmY0MjVlODg0NCAx
MDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiBAQCAtODI1LDcgKzgyNSw3IEBAIHN0YXRpYyBpbnQgdmly
dG5ldF94ZHBfaGFuZGxlcihzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1Y3QgeGRwX2J1
ZmYgKnhkcCwKPiA+ICAgICAgICAgICAgICAgICB4ZHBmID0geGRwX2NvbnZlcnRfYnVmZl90b19m
cmFtZSh4ZHApOwo+ID4gICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSgheGRwZikpIHsKPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgIG5ldGRldl9kYmcoZGV2LCAiY29udmVydCBidWZmIHRv
IGZyYW1lIGZhaWxlZCBmb3IgeGRwXG4iKTsKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiBYRFBfRFJPUDsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZHJvcDsKPiA+
ICAgICAgICAgICAgICAgICB9Cj4gPgo+ID4gICAgICAgICAgICAgICAgIGVyciA9IHZpcnRuZXRf
eGRwX3htaXQoZGV2LCAxLCAmeGRwZiwgMCk7Cj4gPiBAQCAtODMzLDcgKzgzMyw3IEBAIHN0YXRp
YyBpbnQgdmlydG5ldF94ZHBfaGFuZGxlcihzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nLCBzdHJ1
Y3QgeGRwX2J1ZmYgKnhkcCwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHhkcF9yZXR1cm5f
ZnJhbWVfcnhfbmFwaSh4ZHBmKTsKPiA+ICAgICAgICAgICAgICAgICB9IGVsc2UgaWYgKHVubGlr
ZWx5KGVyciA8IDApKSB7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB0cmFjZV94ZHBfZXhj
ZXB0aW9uKGRldiwgeGRwX3Byb2csIGFjdCk7Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm4gWERQX0RST1A7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGRyb3A7Cj4g
PiAgICAgICAgICAgICAgICAgfQo+ID4gICAgICAgICAgICAgICAgICp4ZHBfeG1pdCB8PSBWSVJU
SU9fWERQX1RYOwo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBhY3Q7Cj4gPiBAQCAtODQyLDcg
Kzg0Miw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfaGFuZGxlcihzdHJ1Y3QgYnBmX3Byb2cg
KnhkcF9wcm9nLCBzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCwKPiA+ICAgICAgICAgICAgICAgICBzdGF0
cy0+eGRwX3JlZGlyZWN0cysrOwo+ID4gICAgICAgICAgICAgICAgIGVyciA9IHhkcF9kb19yZWRp
cmVjdChkZXYsIHhkcCwgeGRwX3Byb2cpOwo+ID4gICAgICAgICAgICAgICAgIGlmIChlcnIpCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gWERQX0RST1A7Cj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGRyb3A7Cj4gPgo+ID4gICAgICAgICAgICAgICAgICp4ZHBfeG1p
dCB8PSBWSVJUSU9fWERQX1JFRElSOwo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBhY3Q7Cj4g
PiBAQCAtODU0LDggKzg1NCwxMiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX2hhbmRsZXIoc3Ry
dWN0IGJwZl9wcm9nICp4ZHBfcHJvZywgc3RydWN0IHhkcF9idWZmICp4ZHAsCj4gPiAgICAgICAg
ICAgICAgICAgdHJhY2VfeGRwX2V4Y2VwdGlvbihkZXYsIHhkcF9wcm9nLCBhY3QpOwo+ID4gICAg
ICAgICAgICAgICAgIGZhbGx0aHJvdWdoOwo+ID4gICAgICAgICBjYXNlIFhEUF9EUk9QOgo+ID4g
LSAgICAgICAgICAgICAgIHJldHVybiBYRFBfRFJPUDsKPiA+ICsgICAgICAgICAgICAgICBicmVh
azsKPiA+ICAgICAgICAgfQo+ID4gKwo+ID4gK2Ryb3A6Cj4gPiArICAgICAgIHB1dF94ZHBfZnJh
Z3MoeGRwKTsKPiA+ICsgICAgICAgcmV0dXJuIFhEUF9EUk9QOwo+ID4gIH0KPiA+Cj4gPiAgc3Rh
dGljIHVuc2lnbmVkIGludCB2aXJ0bmV0X2dldF9oZWFkcm9vbShzdHJ1Y3QgdmlydG5ldF9pbmZv
ICp2aSkKPiA+IEBAIC0xMTkwLDcgKzExOTQsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfYnVpbGRf
eGRwX2J1ZmZfbXJnKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkZXYtPm5hbWUsICpudW1fYnVmLAo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdmlydGlvMTZfdG9fY3B1KHZpLT52ZGV2LCBoZHItPm51bV9idWZm
ZXJzKSk7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnN0YXRzLnJ4X2xlbmd0aF9l
cnJvcnMrKzsKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnI7Cj4gPiAgICAgICAgICAgICAgICAgfQo+
ID4KPiA+ICAgICAgICAgICAgICAgICBzdGF0cy0+Ynl0ZXMgKz0gbGVuOwo+ID4gQEAgLTEyMDks
NyArMTIxMyw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9idWlsZF94ZHBfYnVmZl9tcmcoc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHByX2RlYnVnKCIl
czogcnggZXJyb3I6IGxlbiAldSBleGNlZWRzIHRydWVzaXplICVsdVxuIiwKPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGRldi0+bmFtZSwgbGVuLCAodW5zaWduZWQgbG9uZyko
dHJ1ZXNpemUgLSByb29tKSk7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBkZXYtPnN0YXRz
LnJ4X2xlbmd0aF9lcnJvcnMrKzsKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
RUlOVkFMOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnI7Cj4gPiAgICAgICAg
ICAgICAgICAgfQo+ID4KPiA+ICAgICAgICAgICAgICAgICBmcmFnID0gJnNoaW5mby0+ZnJhZ3Nb
c2hpbmZvLT5ucl9mcmFncysrXTsKPiA+IEBAIC0xMjI0LDYgKzEyMjgsMTAgQEAgc3RhdGljIGlu
dCB2aXJ0bmV0X2J1aWxkX3hkcF9idWZmX21yZyhzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4K
PiA+ICAgICAgICAgKnhkcF9mcmFnc190cnVlc2l6ZSA9IHhkcF9mcmFnc190cnVlc3o7Cj4gPiAg
ICAgICAgIHJldHVybiAwOwo+ID4gKwo+ID4gK2VycjoKPiA+ICsgICAgICAgcHV0X3hkcF9mcmFn
cyh4ZHApOwo+ID4gKyAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+ICB9Cj4gPgo+ID4gIHN0YXRp
YyB2b2lkICptZXJnZWFibGVfeGRwX2dldF9idWYoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4g
PiBAQCAtMTM1Myw3ICsxMzYxLDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21l
cmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gICAgICAgICAgICAgICAgIGVyciA9
IHZpcnRuZXRfYnVpbGRfeGRwX2J1ZmZfbXJnKGRldiwgdmksIHJxLCAmeGRwLCBkYXRhLCBsZW4s
IGZyYW1lX3N6LAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICZudW1fYnVmLCAmeGRwX2ZyYWdzX3RydWVzeiwgc3RhdHMpOwo+ID4gICAgICAgICAg
ICAgICAgIGlmICh1bmxpa2VseShlcnIpKQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZ290
byBlcnJfeGRwX2ZyYWdzOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRw
Owo+ID4KPiA+ICAgICAgICAgICAgICAgICBhY3QgPSB2aXJ0bmV0X3hkcF9oYW5kbGVyKHhkcF9w
cm9nLCAmeGRwLCBkZXYsIHhkcF94bWl0LCBzdGF0cyk7Cj4gPgo+ID4gQEAgLTEzNjEsNyArMTM2
OSw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5l
dF9kZXZpY2UgKmRldiwKPiA+ICAgICAgICAgICAgICAgICBjYXNlIFhEUF9QQVNTOgo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgaGVhZF9za2IgPSBidWlsZF9za2JfZnJvbV94ZHBfYnVmZihk
ZXYsIHZpLCAmeGRwLCB4ZHBfZnJhZ3NfdHJ1ZXN6KTsKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmICh1bmxpa2VseSghaGVhZF9za2IpKQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIGVycl94ZHBfZnJhZ3M7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGdvdG8gZXJyX3hkcDsKPiA+Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICByY3Vf
cmVhZF91bmxvY2soKTsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBoZWFkX3Nr
YjsKPiA+IEBAIC0xMzcwLDExICsxMzc4LDggQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNl
aXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIHhkcF94bWl0Owo+ID4gICAgICAgICAgICAgICAgIGRlZmF1bHQ6Cj4gPiAtICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJy
X3hkcDsKPiA+ICAgICAgICAgICAgICAgICB9Cj4gPiAtZXJyX3hkcF9mcmFnczoKPiA+IC0gICAg
ICAgICAgICAgICBwdXRfeGRwX2ZyYWdzKCZ4ZHApOwo+ID4gLSAgICAgICAgICAgICAgIGdvdG8g
ZXJyX3hkcDsKPiA+ICAgICAgICAgfQo+ID4gICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiA+
Cj4gPiAtLQo+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4KPgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
