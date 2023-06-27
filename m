Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3998EB64DD
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 09:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B620D40888;
	Tue, 27 Jun 2023 09:08:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B620D40888
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jBnWfF0Sbqsc; Tue, 27 Jun 2023 09:08:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F347940546;
	Tue, 27 Jun 2023 09:08:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F347940546
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE70AC0072;
	Tue, 27 Jun 2023 09:08:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1076C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 09:08:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AB1BF416F6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 09:08:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AB1BF416F6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nY0FpgCl-eyH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 09:08:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 587164021C
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 587164021C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 09:08:26 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vm5G301_1687856900; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vm5G301_1687856900) by smtp.aliyun-inc.com;
 Tue, 27 Jun 2023 17:08:21 +0800
Message-ID: <1687856738.178093-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 04/10] virtio_ring: packed: support add
 premapped buf
Date: Tue, 27 Jun 2023 17:05:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEuoBtQ+=kJJk84Vs2sk7WAdh8O3d2wJLM-yBFAtkgLEUA@mail.gmail.com>
In-Reply-To: <CACGkMEuoBtQ+=kJJk84Vs2sk7WAdh8O3d2wJLM-yBFAtkgLEUA@mail.gmail.com>
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

T24gVHVlLCAyNyBKdW4gMjAyMyAxNjowMzoyOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjIy4oCvUE0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gSWYgdGhl
IHZxIGlzIHRoZSBwcmVtYXBwZWQgbW9kZSwgdXNlIHRoZSBzZ19kbWFfYWRkcmVzcygpIGRpcmVj
dGx5Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMzYg
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDI2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gaW5kZXggMTgyMTJjM2UwNTZiLi5kYzEwOWZiYzA1YTUgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4gPiBAQCAtMTI5OSw5ICsxMjk5LDEzIEBAIHN0YXRpYyBpbnQgdmlydHF1ZXVl
X2FkZF9pbmRpcmVjdF9wYWNrZWQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gPgo+ID4g
ICAgICAgICBmb3IgKG4gPSAwOyBuIDwgb3V0X3NncyArIGluX3NnczsgbisrKSB7Cj4gPiAgICAg
ICAgICAgICAgICAgZm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0gc2dfbmV4dChzZykpIHsKPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgbiA8
IG91dF9zZ3MgPwo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgRE1BX1RPX0RFVklDRSA6IERNQV9GUk9NX0RFVklDRSwgJmFkZHIpKQo+ID4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICBpZiAodnEtPnByZW1hcHBlZCkgewo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBhZGRyID0gc2dfZG1hX2FkZHJlc3Moc2cpOwo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgfSBlbHNlIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aWYgKHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBuIDwgb3V0X3NncyA/Cj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERNQV9UT19ERVZJQ0Ug
OiBETUFfRlJPTV9ERVZJQ0UsICZhZGRyKSkKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICB9Cj4gPgo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZGVzY1tpXS5mbGFncyA9IGNw
dV90b19sZTE2KG4gPCBvdXRfc2dzID8KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDAgOiBWUklOR19ERVNDX0ZfV1JJVEUpOwo+ID4gQEAgLTEzNjks
MTAgKzEzNzMsMTIgQEAgc3RhdGljIGludCB2aXJ0cXVldWVfYWRkX2luZGlyZWN0X3BhY2tlZChz
dHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+ICAgICAgICAgcmV0dXJuIDA7Cj4gPgo+ID4g
IHVubWFwX3JlbGVhc2U6Cj4gPiAtICAgICAgIGVycl9pZHggPSBpOwo+ID4gKyAgICAgICBpZiAo
IXZxLT5wcmVtYXBwZWQpIHsKPiA+ICsgICAgICAgICAgICAgICBlcnJfaWR4ID0gaTsKPiA+Cj4g
PiAtICAgICAgIGZvciAoaSA9IDA7IGkgPCBlcnJfaWR4OyBpKyspCj4gPiAtICAgICAgICAgICAg
ICAgdnJpbmdfdW5tYXBfZGVzY19wYWNrZWQodnEsICZkZXNjW2ldKTsKPiA+ICsgICAgICAgICAg
ICAgICBmb3IgKGkgPSAwOyBpIDwgZXJyX2lkeDsgaSsrKQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgdnJpbmdfdW5tYXBfZGVzY19wYWNrZWQodnEsICZkZXNjW2ldKTsKPiA+ICsgICAgICAg
fQo+ID4KPiA+ICAgICAgICAga2ZyZWUoZGVzYyk7Cj4gPgo+ID4gQEAgLTE0NDcsOSArMTQ1Mywx
MyBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3QgdmlydHF1
ZXVlICpfdnEsCj4gPiAgICAgICAgICAgICAgICAgZm9yIChzZyA9IHNnc1tuXTsgc2c7IHNnID0g
c2dfbmV4dChzZykpIHsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGRtYV9hZGRyX3QgYWRk
cjsKPiA+Cj4gPiAtICAgICAgICAgICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwX29uZV9zZyh2
cSwgc2csIG4gPCBvdXRfc2dzID8KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIERNQV9UT19ERVZJQ0UgOiBETUFfRlJPTV9ERVZJQ0UsICZhZGRyKSkKPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byB1bm1hcF9yZWxlYXNlOwo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZxLT5wcmVtYXBwZWQpIHsKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgYWRkciA9IHNnX2RtYV9hZGRyZXNzKHNnKTsKPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgbiA8IG91dF9zZ3MgPwo+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBETUFf
VE9fREVWSUNFIDogRE1BX0ZST01fREVWSUNFLCAmYWRkcikpCj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZ290byB1bm1hcF9yZWxlYXNlOwo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgfQo+ID4KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGZsYWdzID0g
Y3B1X3RvX2xlMTYodnEtPnBhY2tlZC5hdmFpbF91c2VkX2ZsYWdzIHwKPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICgrK2MgPT0gdG90YWxfc2cgPyAwIDogVlJJTkdfREVT
Q19GX05FWFQpIHwKPiA+IEBAIC0xNTEyLDExICsxNTIyLDE3IEBAIHN0YXRpYyBpbmxpbmUgaW50
IHZpcnRxdWV1ZV9hZGRfcGFja2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+ICAgICAgICAg
cmV0dXJuIDA7Cj4gPgo+ID4gIHVubWFwX3JlbGVhc2U6Cj4gPiArICAgICAgIHZxLT5wYWNrZWQu
YXZhaWxfdXNlZF9mbGFncyA9IGF2YWlsX3VzZWRfZmxhZ3M7Cj4gPiArCj4gPiArICAgICAgIGlm
ICh2cS0+cHJlbWFwcGVkKSB7Cj4KPiBTaW1pbGFyIHRvIHRoZSBzcGxpdCBwYXRoLCBJIHRoaW5r
IHdlIGNhbid0IGhpdCB2cS0+cHJlbWFwcGVkIGhlcmUuCgoKWUVTLCBzaW1pbGFyIHRvIHRoZSBh
Ym92ZSByZXBseSwgd2UgY2FuIGhhdmUgYSBiZXR0ZXIgd2F5LgoKQnV0LCB3ZSBjYW4gaGl0IHZx
LT5wcmVtYXBwZWQsIHdoZW4gd2UgZmFpbCBkb2luZyBkbWEgZm9yIHRoZSBpbmRpcmVjdCBkZXNj
CmFycmF5LgoKVGhhbmtzLgoKCgoKPgo+IFRoYW5rcwo+Cj4KPiA+ICsgICAgICAgICAgICAgICBF
TkRfVVNFKHZxKTsKPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTzsKPiA+ICsgICAgICAg
fQo+ID4gKwo+ID4gICAgICAgICBlcnJfaWR4ID0gaTsKPiA+ICAgICAgICAgaSA9IGhlYWQ7Cj4g
PiAgICAgICAgIGN1cnIgPSB2cS0+ZnJlZV9oZWFkOwo+ID4KPiA+IC0gICAgICAgdnEtPnBhY2tl
ZC5hdmFpbF91c2VkX2ZsYWdzID0gYXZhaWxfdXNlZF9mbGFnczsKPiA+Cj4gPiAgICAgICAgIGZv
ciAobiA9IDA7IG4gPCB0b3RhbF9zZzsgbisrKSB7Cj4gPiAgICAgICAgICAgICAgICAgaWYgKGkg
PT0gZXJyX2lkeCkKPiA+IC0tCj4gPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4gPgo+Cl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
