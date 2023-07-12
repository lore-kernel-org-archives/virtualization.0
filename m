Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA42EB64D9
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 08:34:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C02F81F52;
	Wed, 12 Jul 2023 08:34:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C02F81F52
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iYF9EhStnFzs; Wed, 12 Jul 2023 08:34:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 105E181FC6;
	Wed, 12 Jul 2023 08:34:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 105E181FC6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDF48C0072;
	Wed, 12 Jul 2023 08:34:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6315C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A3AA7404FC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A3AA7404FC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jz1zqoyeNb6N
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:34:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B550403E9
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B550403E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 08:34:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VnCCAGS_1689150885; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VnCCAGS_1689150885) by smtp.aliyun-inc.com;
 Wed, 12 Jul 2023 16:34:46 +0800
Message-ID: <1689150822.0177438-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 04/10] virtio_ring: support add premapped buf
Date: Wed, 12 Jul 2023 16:33:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-5-xuanzhuo@linux.alibaba.com>
 <CACGkMEu16kUX02L+zb=hcX_sMW-s6wBFtiCRC_3H4ky4iDdy4Q@mail.gmail.com>
In-Reply-To: <CACGkMEu16kUX02L+zb=hcX_sMW-s6wBFtiCRC_3H4ky4iDdy4Q@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCAxMiBKdWwgMjAyMyAxNjozMTozNSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gTW9uLCBKdWwgMTAsIDIwMjMgYXQgMTE6NDLigK9BTSBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBJZiB0
aGUgdnEgaXMgdGhlIHByZW1hcHBlZCBtb2RlLCB1c2UgdGhlIHNnX2RtYV9hZGRyZXNzKCkgZGly
ZWN0bHkuCj4gPgo+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5h
bGliYWJhLmNvbT4KPiA+IC0tLQo+ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAx
OSArKysrKysrKysrKysrKysrKy0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBpbmRleCA1YWNl
NDUzOTM0NGMuLmQ0NzFkZWUzZjRmNyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3Zp
cnRpb19yaW5nLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiA+IEBA
IC0zNjEsNiArMzYxLDExIEBAIHN0YXRpYyBzdHJ1Y3QgZGV2aWNlICp2cmluZ19kbWFfZGV2KGNv
bnN0IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxKQo+ID4gIHN0YXRpYyBpbnQgdnJpbmdfbWFw
X29uZV9zZyhjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgc3RydWN0IHNjYXR0ZXJs
aXN0ICpzZywKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIGRtYV9kYXRhX2Rp
cmVjdGlvbiBkaXJlY3Rpb24sIGRtYV9hZGRyX3QgKmFkZHIpCj4gPiAgewo+ID4gKyAgICAgICBp
ZiAodnEtPnByZW1hcHBlZCkgewo+ID4gKyAgICAgICAgICAgICAgICphZGRyID0gc2dfZG1hX2Fk
ZHJlc3Moc2cpOwo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiAwOwo+ID4gKyAgICAgICB9Cj4g
PiArCj4gPiAgICAgICAgIGlmICghdnEtPnVzZV9kbWFfYXBpKSB7Cj4gPiAgICAgICAgICAgICAg
ICAgLyoKPiA+ICAgICAgICAgICAgICAgICAgKiBJZiBETUEgaXMgbm90IHVzZWQsIEtNU0FOIGRv
ZXNuJ3Qga25vdyB0aGF0IHRoZSBzY2F0dGVybGlzdAo+ID4gQEAgLTYzOSw4ICs2NDQsMTIgQEAg
c3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpf
dnEsCj4gPiAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBhZGRyID0gdnJpbmdfbWFwX3Npbmds
ZSgKPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHZxLCBkZXNjLCB0b3RhbF9zZyAqIHNpemVv
ZihzdHJ1Y3QgdnJpbmdfZGVzYyksCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBETUFfVE9f
REVWSUNFKTsKPiA+IC0gICAgICAgICAgICAgICBpZiAodnJpbmdfbWFwcGluZ19lcnJvcih2cSwg
YWRkcikpCj4gPiArICAgICAgICAgICAgICAgaWYgKHZyaW5nX21hcHBpbmdfZXJyb3IodnEsIGFk
ZHIpKSB7Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAodnEtPnByZW1hcHBlZCkKPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBmcmVlX2luZGlyZWN0Owo+Cj4g
VW5kZXIgd2hpY2ggY2FzZSBjb3VsZCB3ZSBoaXQgdGhpcz8gQSBidWcgb2YgdGhlIGRyaXZlcj8K
CkhlcmUgdGhlIG1hcCBvcGVyYXRlIGlzIGZvciB0aGUgaW5kaXJlY3QgZGVzY3MgYXJyYXkuCgpT
byB0aGlzIGlzIGRvbmUgaW5zaWRlIHRoZSB2aXJ0aW8gY29yZS4KClRoYW5rcy4KCgoKCj4KPiBU
aGFua3MKPgo+ID4gKwo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgZ290byB1bm1hcF9yZWxl
YXNlOwo+ID4gKyAgICAgICAgICAgICAgIH0KPiA+Cj4gPiAgICAgICAgICAgICAgICAgdmlydHF1
ZXVlX2FkZF9kZXNjX3NwbGl0KF92cSwgdnEtPnNwbGl0LnZyaW5nLmRlc2MsCj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGhlYWQsIGFkZHIsCj4gPiBAQCAtNzA2
LDYgKzcxNSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfc3BsaXQoc3RydWN0
IHZpcnRxdWV1ZSAqX3ZxLAo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaSA9IHZyaW5nX3Vu
bWFwX29uZV9zcGxpdCh2cSwgaSk7Cj4gPiAgICAgICAgIH0KPiA+Cj4gPiArZnJlZV9pbmRpcmVj
dDoKPiA+ICAgICAgICAgaWYgKGluZGlyZWN0KQo+ID4gICAgICAgICAgICAgICAgIGtmcmVlKGRl
c2MpOwo+ID4KPiA+IEBAIC0xMzA3LDggKzEzMTcsMTIgQEAgc3RhdGljIGludCB2aXJ0cXVldWVf
YWRkX2luZGlyZWN0X3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiA+ICAgICAg
ICAgYWRkciA9IHZyaW5nX21hcF9zaW5nbGUodnEsIGRlc2MsCj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICB0b3RhbF9zZyAqIHNpemVvZihzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MpLAo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgRE1BX1RPX0RFVklDRSk7Cj4gPiAtICAgICAgIGlmICh2
cmluZ19tYXBwaW5nX2Vycm9yKHZxLCBhZGRyKSkKPiA+ICsgICAgICAgaWYgKHZyaW5nX21hcHBp
bmdfZXJyb3IodnEsIGFkZHIpKSB7Cj4gPiArICAgICAgICAgICAgICAgaWYgKHZxLT5wcmVtYXBw
ZWQpCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGZyZWVfZGVzYzsKPiA+ICsKPiA+
ICAgICAgICAgICAgICAgICBnb3RvIHVubWFwX3JlbGVhc2U7Cj4gPiArICAgICAgIH0KPiA+Cj4g
PiAgICAgICAgIHZxLT5wYWNrZWQudnJpbmcuZGVzY1toZWFkXS5hZGRyID0gY3B1X3RvX2xlNjQo
YWRkcik7Cj4gPiAgICAgICAgIHZxLT5wYWNrZWQudnJpbmcuZGVzY1toZWFkXS5sZW4gPSBjcHVf
dG9fbGUzMih0b3RhbF9zZyAqCj4gPiBAQCAtMTM2Niw2ICsxMzgwLDcgQEAgc3RhdGljIGludCB2
aXJ0cXVldWVfYWRkX2luZGlyZWN0X3BhY2tlZChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwK
PiA+ICAgICAgICAgZm9yIChpID0gMDsgaSA8IGVycl9pZHg7IGkrKykKPiA+ICAgICAgICAgICAg
ICAgICB2cmluZ191bm1hcF9kZXNjX3BhY2tlZCh2cSwgJmRlc2NbaV0pOwo+ID4KPiA+ICtmcmVl
X2Rlc2M6Cj4gPiAgICAgICAgIGtmcmVlKGRlc2MpOwo+ID4KPiA+ICAgICAgICAgRU5EX1VTRSh2
cSk7Cj4gPiAtLQo+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4KPgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
