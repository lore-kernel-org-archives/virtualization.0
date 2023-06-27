Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0CEC0015E
	for <virtualization@archiver.kernel.org>; Tue, 27 Jun 2023 09:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 05B34820C8;
	Tue, 27 Jun 2023 09:05:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 05B34820C8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jhuY3rY1rJVE; Tue, 27 Jun 2023 09:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 52BD182090;
	Tue, 27 Jun 2023 09:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52BD182090
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 154BCC0072;
	Tue, 27 Jun 2023 09:05:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8A34C0037
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 09:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A6D640232
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 09:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A6D640232
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pgSuP3wN4d9E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 09:05:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 019104021C
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 019104021C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 09:05:26 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vm59os0_1687856719; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vm59os0_1687856719) by smtp.aliyun-inc.com;
 Tue, 27 Jun 2023 17:05:20 +0800
Message-ID: <1687856491.8062844-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v10 03/10] virtio_ring: split: support add premapped
 buf
Date: Tue, 27 Jun 2023 17:01:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
 <20230602092206.50108-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
In-Reply-To: <CACGkMEtFiutSpM--2agR1YhS0MxreH4vFFAEdCaC6E8qxyjZ4g@mail.gmail.com>
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

T24gVHVlLCAyNyBKdW4gMjAyMyAxNjowMzoyNiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gRnJpLCBKdW4gMiwgMjAyMyBhdCA1OjIy4oCvUE0gWHVh
biBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gSWYgdGhl
IHZxIGlzIHRoZSBwcmVtYXBwZWQgbW9kZSwgdXNlIHRoZSBzZ19kbWFfYWRkcmVzcygpIGRpcmVj
dGx5Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+Cj4gPiAtLS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNDYg
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDI4IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jpbmcu
Ywo+ID4gaW5kZXggMmFmZGZiOWUzZTMwLi4xODIxMmMzZTA1NmIgMTAwNjQ0Cj4gPiAtLS0gYS9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fcmluZy5jCj4gPiBAQCAtNTk4LDggKzU5OCwxMiBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0
cXVldWVfYWRkX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+ICAgICAgICAgICAgICAg
ICBmb3IgKHNnID0gc2dzW25dOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkgewo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBhZGRyOwo+ID4KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgIGlmICh2cmluZ19tYXBfb25lX3NnKHZxLCBzZywgRE1BX1RPX0RFVklDRSwgJmFkZHIp
KQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodnEtPnByZW1hcHBlZCkgewo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyID0gc2dfZG1hX2FkZHJlc3Moc2cpOwo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfSBlbHNlIHsKPiA+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgaWYgKHZyaW5nX21hcF9vbmVfc2codnEsIHNnLCBETUFfVE9fREVWSUNF
LCAmYWRkcikpCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290
byB1bm1hcF9yZWxlYXNlOwo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgfQo+Cj4gQnR3LCBJ
IHdvbmRlciB3aGV0aGVyIG9yIG5vdCBpdCB3b3VsZCBiZSBzaW1wbGUgdG8gaW1wbGVtZW50IHRo
ZQo+IHZxLT5wcmVtYXBwZWQgY2hlY2sgaW5zaWRlIHZyaW5nX21hcF9vbmVfc2coKSBhc3N1bWlu
ZyB0aGUKPiAhdXNlX2RtYV9hcGkgaXMgZG9uZSB0aGVyZSBhcyB3ZWxsLgoKCllFUywKClRoYXQg
d2lsbCBtb3JlIHNpbXBsZSBmb3IgdGhlIGNhbGxlci4KCkJ1dCB3ZSB3aWxsIGhhdmUgdGhpbmdz
IGxpa2U6CgppbnQgZnVuYyhib29sIGRvKQp7CmlmICghZG8pCiAgICByZXR1cm47Cn0KCkkgbGlr
ZSB0aGlzIHdheSwgYnV0IHlvdSBkb24ndCBsaWtlIGl0IGluIGxhc3QgdmVyc2lvbi4KCj4KPiA+
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBwcmV2ID0gaTsKPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIC8qIE5vdGUgdGhhdCB3ZSB0cnVzdCBpbmRpcmVjdCBkZXNjcmlwdG9yCj4gPiBA
QCAtNjE0LDggKzYxOCwxMiBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3NwbGl0
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiA+ICAgICAgICAgICAgICAgICBmb3IgKHNnID0gc2dz
W25dOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkgewo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ZG1hX2FkZHJfdCBhZGRyOwo+ID4KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmICh2cmlu
Z19tYXBfb25lX3NnKHZxLCBzZywgRE1BX0ZST01fREVWSUNFLCAmYWRkcikpCj4gPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW5tYXBfcmVsZWFzZTsKPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGlmICh2cS0+cHJlbWFwcGVkKSB7Cj4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFkZHIgPSBzZ19kbWFfYWRkcmVzcyhzZyk7Cj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICB9IGVsc2Ugewo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpZiAodnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIERNQV9GUk9NX0RFVklDRSwgJmFkZHIpKQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gdW5tYXBfcmVs
ZWFzZTsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBwcmV2ID0gaTsKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIE5vdGUg
dGhhdCB3ZSB0cnVzdCBpbmRpcmVjdCBkZXNjcmlwdG9yCj4gPiBAQCAtNjg5LDIxICs2OTcsMjMg
QEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVl
ICpfdnEsCj4gPiAgICAgICAgIHJldHVybiAwOwo+ID4KPiA+ICB1bm1hcF9yZWxlYXNlOgo+ID4g
LSAgICAgICBlcnJfaWR4ID0gaTsKPiA+ICsgICAgICAgaWYgKCF2cS0+cHJlbWFwcGVkKSB7Cj4K
PiBDYW4gdnEtPnByZW1hcHBlZCBiZSB0cnVlIGhlcmU/IFRoZSBsYWJlbCBpcyBuYW1lZCBhcyAi
dW5tYXBfcmVsYXNlIgo+IHdoaWNoIGltcGxpZXMgIm1hcCIgYmVmb3JlaGFuZCB3aGljaCBzZWVt
cyBub3QgdGhlIGNhc2UgZm9yCj4gcHJlbWFwcGluZy4KCkkgc2VlLgoKUmV0aGluayBhYm91dCB0
aGlzLCB0aGVyZSBpcyBhIGJldHRlciB3YXkuCkkgd2lsbCBmaXggaW4gbmV4dCB2ZXJzaW9uLgoK
ClRoYW5rcy4KCgo+Cj4gVGhhbmtzCj4KPgo+ID4gKyAgICAgICAgICAgICAgIGVycl9pZHggPSBp
Owo+ID4KPiA+IC0gICAgICAgaWYgKGluZGlyZWN0KQo+ID4gLSAgICAgICAgICAgICAgIGkgPSAw
Owo+ID4gLSAgICAgICBlbHNlCj4gPiAtICAgICAgICAgICAgICAgaSA9IGhlYWQ7Cj4gPiAtCj4g
PiAtICAgICAgIGZvciAobiA9IDA7IG4gPCB0b3RhbF9zZzsgbisrKSB7Cj4gPiAtICAgICAgICAg
ICAgICAgaWYgKGkgPT0gZXJyX2lkeCkKPiA+IC0gICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Owo+ID4gLSAgICAgICAgICAgICAgIGlmIChpbmRpcmVjdCkgewo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgdnJpbmdfdW5tYXBfb25lX3NwbGl0X2luZGlyZWN0KHZxLCAmZGVzY1tpXSk7Cj4g
PiAtICAgICAgICAgICAgICAgICAgICAgICBpID0gdmlydGlvMTZfdG9fY3B1KF92cS0+dmRldiwg
ZGVzY1tpXS5uZXh0KTsKPiA+IC0gICAgICAgICAgICAgICB9IGVsc2UKPiA+IC0gICAgICAgICAg
ICAgICAgICAgICAgIGkgPSB2cmluZ191bm1hcF9vbmVfc3BsaXQodnEsIGkpOwo+ID4gKyAgICAg
ICAgICAgICAgIGlmIChpbmRpcmVjdCkKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGkgPSAw
Owo+ID4gKyAgICAgICAgICAgICAgIGVsc2UKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGkg
PSBoZWFkOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICAgIGZvciAobiA9IDA7IG4gPCB0b3RhbF9z
ZzsgbisrKSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoaSA9PSBlcnJfaWR4KQo+
ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGlmIChpbmRpcmVjdCkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2cmluZ191bm1hcF9vbmVfc3BsaXRfaW5kaXJlY3QodnEsICZkZXNjW2ldKTsKPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSA9IHZpcnRpbzE2X3RvX2NwdShfdnEt
PnZkZXYsIGRlc2NbaV0ubmV4dCk7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2UK
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaSA9IHZyaW5nX3VubWFwX29uZV9z
cGxpdCh2cSwgaSk7Cj4gPiArICAgICAgICAgICAgICAgfQo+ID4gICAgICAgICB9Cj4gPgo+ID4g
ICAgICAgICBpZiAoaW5kaXJlY3QpCj4gPiAtLQo+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4K
PgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
