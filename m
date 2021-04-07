Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92CAC433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 09:16:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C26561363
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 09:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C26561363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2E8664020E;
	Wed,  7 Apr 2021 09:16:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sjWWs_zB7pLh; Wed,  7 Apr 2021 09:16:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 877FD400BF;
	Wed,  7 Apr 2021 09:16:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 63E31C000C;
	Wed,  7 Apr 2021 09:16:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3652EC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24939849E8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:16:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5hxSeGlZkaHZ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:16:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6E479849E1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617786999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gyj7IJkIUvUgggyzLzduzdDumbbdYLArWF7fFDCSWyE=;
 b=fHA+rMROpuw4lhSU9Zj9AYTTqw/TFwCFUnARfCfj+NRFVJn9GcbjmaKeaxHTPOVkQVSomF
 chjEPZJcAfd4le9bUDYMg6C2UmmS9HkDknpJgsa0eOOsiPoSVz51BGk3UNDTc+u2C8J2U5
 eCBWqZ+kEwb3puPHoi/ow85bX5puc3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-qUhOMZ4FPBGKHH9acOmwuQ-1; Wed, 07 Apr 2021 05:16:37 -0400
X-MC-Unique: qUhOMZ4FPBGKHH9acOmwuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A607E1922967;
 Wed,  7 Apr 2021 09:16:35 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-236.pek2.redhat.com
 [10.72.13.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43F1E10023AF;
 Wed,  7 Apr 2021 09:16:27 +0000 (UTC)
Subject: Re: [PATCH net-next v3 7/8] virtio-net: poll tx call xsk zerocopy xmit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1617786614.454336-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6dc46d13-7bdc-33d8-3bab-9cabd16d69d0@redhat.com>
Date: Wed, 7 Apr 2021 17:16:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617786614.454336-5-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzQvNyDkuIvljYg1OjEwLCBYdWFuIFpodW8g5YaZ6YGTOgo+IE9uIFR1ZSwgNiBB
cHIgMjAyMSAxNTowMzoyOSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+IOWcqCAyMDIxLzMvMzEg5LiL5Y2IMzoxMSwgWHVhbiBaaHVvIOWGmemBkzoKPj4+
IHBvbGwgdHggY2FsbCB2aXJ0bmV0X3hza19ydW4sIHRoZW4gdGhlIGRhdGEgaW4gdGhlIHhzayB0
eCBxdWV1ZSB3aWxsIGJlCj4+PiBjb250aW51b3VzbHkgY29uc3VtZWQgYnkgbmFwaS4KPj4+Cj4+
PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+
Pj4gUmV2aWV3ZWQtYnk6IER1c3QgTGkgPGR1c3QubGlAbGludXguYWxpYmFiYS5jb20+Cj4+Cj4+
IEkgdGhpbmsgd2UgbmVlZCBzcXVhc2ggdGhpcyBpbnRvIHBhdGNoIDQsIGl0IGxvb2tzIG1vcmUg
bGlrZSBhIGJ1ZyBmaXgKPj4gdG8gbWUuCj4+Cj4+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyB8IDIwICsrKysrKysrKysrKysrKysrLS0tCj4+PiAgICAxIGZpbGUgY2hh
bmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+
PiBpbmRleCBkN2U5NWY1NTQ3OGQuLmZhYzdkMDAyMDAxMyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+
PiBAQCAtMjY0LDYgKzI2NCw5IEBAIHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIgewo+Pj4gICAgCWNo
YXIgcGFkZGluZ1s0XTsKPj4+ICAgIH07Cj4+Pgo+Pj4gK3N0YXRpYyBpbnQgdmlydG5ldF94c2tf
cnVuKHN0cnVjdCBzZW5kX3F1ZXVlICpzcSwgc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wsCj4+
PiArCQkJICAgaW50IGJ1ZGdldCwgYm9vbCBpbl9uYXBpKTsKPj4+ICsKPj4+ICAgIHN0YXRpYyBi
b29sIGlzX3hkcF9mcmFtZSh2b2lkICpwdHIpCj4+PiAgICB7Cj4+PiAgICAJcmV0dXJuICh1bnNp
Z25lZCBsb25nKXB0ciAmIFZJUlRJT19YRFBfRkxBRzsKPj4+IEBAIC0xNTUzLDcgKzE1NTYsOSBA
QCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGlu
dCBidWRnZXQpCj4+PiAgICAJc3RydWN0IHNlbmRfcXVldWUgKnNxID0gY29udGFpbmVyX29mKG5h
cGksIHN0cnVjdCBzZW5kX3F1ZXVlLCBuYXBpKTsKPj4+ICAgIAlzdHJ1Y3QgdmlydG5ldF9pbmZv
ICp2aSA9IHNxLT52cS0+dmRldi0+cHJpdjsKPj4+ICAgIAl1bnNpZ25lZCBpbnQgaW5kZXggPSB2
cTJ0eHEoc3EtPnZxKTsKPj4+ICsJc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2w7Cj4+PiAgICAJ
c3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+Pj4gKwlpbnQgd29yayA9IDA7Cj4+Pgo+Pj4gICAg
CWlmICh1bmxpa2VseShpc194ZHBfcmF3X2J1ZmZlcl9xdWV1ZSh2aSwgaW5kZXgpKSkgewo+Pj4g
ICAgCQkvKiBXZSBkb24ndCBuZWVkIHRvIGVuYWJsZSBjYiBmb3IgWERQICovCj4+PiBAQCAtMTU2
MywxNSArMTU2OCwyNCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcG9sbF90eChzdHJ1Y3QgbmFwaV9z
dHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4+Pgo+Pj4gICAgCXR4cSA9IG5ldGRldl9nZXRfdHhf
cXVldWUodmktPmRldiwgaW5kZXgpOwo+Pj4gICAgCV9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19z
bXBfcHJvY2Vzc29yX2lkKCkpOwo+Pj4gLQlmcmVlX29sZF94bWl0X3NrYnMoc3EsIHRydWUpOwo+
Pj4gKwlyY3VfcmVhZF9sb2NrKCk7Cj4+PiArCXBvb2wgPSByY3VfZGVyZWZlcmVuY2Uoc3EtPnhz
ay5wb29sKTsKPj4+ICsJaWYgKHBvb2wpIHsKPj4+ICsJCXdvcmsgPSB2aXJ0bmV0X3hza19ydW4o
c3EsIHBvb2wsIGJ1ZGdldCwgdHJ1ZSk7Cj4+PiArCQlyY3VfcmVhZF91bmxvY2soKTsKPj4+ICsJ
fSBlbHNlIHsKPj4+ICsJCXJjdV9yZWFkX3VubG9jaygpOwo+Pj4gKwkJZnJlZV9vbGRfeG1pdF9z
a2JzKHNxLCB0cnVlKTsKPj4+ICsJfQo+Pj4gICAgCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7Cj4+
Pgo+Pj4gLQl2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZShuYXBpLCBzcS0+dnEsIDApOwo+Pj4gKwlp
ZiAod29yayA8IGJ1ZGdldCkKPj4+ICsJCXZpcnRxdWV1ZV9uYXBpX2NvbXBsZXRlKG5hcGksIHNx
LT52cSwgMCk7Cj4+Pgo+Pj4gICAgCWlmIChzcS0+dnEtPm51bV9mcmVlID49IDIgKyBNQVhfU0tC
X0ZSQUdTKQo+Pj4gICAgCQluZXRpZl90eF93YWtlX3F1ZXVlKHR4cSk7Cj4+Pgo+Pj4gLQlyZXR1
cm4gMDsKPj4+ICsJcmV0dXJuIHdvcms7Cj4+Cj4+IE5lZWQgYSBzZXBhcmF0ZSBwYXRjaCB0byAi
Zml4IiB0aGUgYnVkZ2V0IHJldHVybmVkIGJ5IHBvbGxfdHggaGVyZS4KPiBJIHdpbGwgbWVyZ2Ug
IzUgIzcgIzggaW50byAjNCwgd2hpY2ggaXMgaW5kZWVkIG1vcmUgcmVhc29uYWJsZSwgYnV0IG1h
eWJlIHRoaXMKPiBwYXRjaCB3aWxsIGJlIHRvbyBiaWcuCj4KPiBCdXQgSSBkb24ndCB1bmRlcnN0
YW5kLCB3aGF0IHlvdSBhcmUgdGFsa2luZyBhYm91dCBoZXJlLCB3aGF0IGlzIHRoZSBzZXBhcmF0
ZQo+IHBhdGNoLCB3aGVuIHRoaXMgaXMgc3F1YXNoZWQgaW50byBwYXRjaCA0PwoKClNvIHlvdSBt
b2RpZnkgdGhlIGJlaGF2aW91ciBvZiBOQVBJIHBvbGwgdG8gcmV0dXJuIHRoZSBudW1iZXIgb2Yg
d29yayAKbm93ICgwIGlzIHJldHVybmVkIHByZXZpb3VzbHkpLiBEbyB3ZSBuZWVkIHRvIGRvIHRo
YXQgZm9yIG5vbiBYU0sgcGFydCAKYXMgd2VsbCAod2hpY2ggc2VlbXMgdG8gYmUgdGhlIGJlaGF2
aW91ciBvZiBvdGhlciBuaWMgZHJpdmVyKT8gSWYgeWVzLCAKdGhpcyBwYXJ0IHNob3VsZCBiZSBh
IHNlcGFyYXRlZCBwYXRjaCB0byBiZSBtb3JlIGJpc2VjdCBmcmllbmRseS4KClRoYW5rcwoKCj4K
Pj4gVGhhbmtzCj4+Cj4+Cj4+PiAgICB9Cj4+Pgo+Pj4gICAgc3RhdGljIGludCB4bWl0X3NrYihz
dHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsIHN0cnVjdCBza19idWZmICpza2IpCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
