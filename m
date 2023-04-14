Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB023C77B70
	for <virtualization@archiver.kernel.org>; Fri, 14 Apr 2023 05:59:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 421BE60F8D;
	Fri, 14 Apr 2023 05:59:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 421BE60F8D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wQ3FQ6kvEkb; Fri, 14 Apr 2023 05:59:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1DCE60F42;
	Fri, 14 Apr 2023 05:59:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1DCE60F42
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E510C0036;
	Fri, 14 Apr 2023 05:59:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC526C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83BC78401A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:59:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83BC78401A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tEeda5fJYvV6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:59:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FD9B83FB5
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8FD9B83FB5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Apr 2023 05:59:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vg2KYHN_1681451981; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vg2KYHN_1681451981) by smtp.aliyun-inc.com;
 Fri, 14 Apr 2023 13:59:41 +0800
Message-ID: <1681451962.2157283-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: bugfix overflow inside
 xdp_linearize_page()
Date: Fri, 14 Apr 2023 13:59:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230413121937.46135-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsE8TosCxyf4GwmsBzo1Ot9FiLtsWt16oz0f0J99DGYCg@mail.gmail.com>
In-Reply-To: <CACGkMEsE8TosCxyf4GwmsBzo1Ot9FiLtsWt16oz0f0J99DGYCg@mail.gmail.com>
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

T24gRnJpLCAxNCBBcHIgMjAyMyAxMzo0MDozMiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgODoxOeKAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IEhlcmUg
d2UgY29weSB0aGUgZGF0YSBmcm9tIHRoZSBvcmlnaW5hbCBidWYgdG8gdGhlIG5ldyBwYWdlLiBC
dXQgd2UKPiA+IG5vdCBjaGVjayB0aGF0IGl0IG1heSBiZSBvdmVyZmxvdy4KPiA+Cj4gPiBBcyBs
b25nIGFzIHRoZSBzaXplIHJlY2VpdmVkKGluY2x1ZGluZyB2bmV0aGRyKSBpcyBncmVhdGVyIHRo
YW4gMzg0MAo+ID4gKFBBR0VfU0laRSAtVklSVElPX1hEUF9IRUFEUk9PTSkuIFRoZW4gdGhlIG1l
bWNweSB3aWxsIG92ZXJmbG93Lgo+ID4KPiA+IEFuZCB0aGlzIGlzIGNvbXBsZXRlbHkgcG9zc2li
bGUsIGFzIGxvbmcgYXMgdGhlIE1UVSBpcyBsYXJnZSwgc3VjaAo+ID4gYXMgNDA5Ni4gSW4gb3Vy
IHRlc3QgZW52aXJvbm1lbnQsIHRoaXMgd2lsbCBjYXVzZSBjcmFzaC4gU2luY2UgY3Jhc2ggaXMK
PiA+IGNhdXNlZCBieSB0aGUgd3JpdHRlbiBtZW1vcnksIGl0IGlzIG1lYW5pbmdsZXNzLCBzbyBJ
IGRvIG5vdCBpbmNsdWRlIGl0Lgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4KPiBNaXNzaW5nIGZpeGVzIHRhZz8KPgo+IE90aGVy
IHRoYW4gdGhpcywKPgo+IEFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKU29ycnksIG1pc3MgdGhpcy4KClRoYW5rcy4KCgoKPgo+IFRoYW5rcwo+Cj4gPiAtLS0KPiA+
ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA4ICsrKysrKy0tCj4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDYgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBp
bmRleCAyMzk2YzI4YzAxMjIuLmVhMWJkNGJiMzI2ZCAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiBA
QCAtODE0LDggKzgxNCwxMyBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKnhkcF9saW5lYXJpemVfcGFn
ZShzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBpbnQgcGFnZV9vZmYsCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgKmxlbikKPiA+ICB7Cj4gPiAtICAgICAgIHN0cnVj
dCBwYWdlICpwYWdlID0gYWxsb2NfcGFnZShHRlBfQVRPTUlDKTsKPiA+ICsgICAgICAgaW50IHRh
aWxyb29tID0gU0tCX0RBVEFfQUxJR04oc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsK
PiA+ICsgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2U7Cj4gPiArCj4gPiArICAgICAgIGlmIChwYWdl
X29mZiArICpsZW4gKyB0YWlscm9vbSA+IFBBR0VfU0laRSkKPiA+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gTlVMTDsKPiA+Cj4gPiArICAgICAgIHBhZ2UgPSBhbGxvY19wYWdlKEdGUF9BVE9NSUMp
Owo+ID4gICAgICAgICBpZiAoIXBhZ2UpCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7
Cj4gPgo+ID4gQEAgLTgyMyw3ICs4MjgsNiBAQCBzdGF0aWMgc3RydWN0IHBhZ2UgKnhkcF9saW5l
YXJpemVfcGFnZShzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEsCj4gPiAgICAgICAgIHBhZ2Vfb2Zm
ICs9ICpsZW47Cj4gPgo+ID4gICAgICAgICB3aGlsZSAoLS0qbnVtX2J1Zikgewo+ID4gLSAgICAg
ICAgICAgICAgIGludCB0YWlscm9vbSA9IFNLQl9EQVRBX0FMSUdOKHNpemVvZihzdHJ1Y3Qgc2ti
X3NoYXJlZF9pbmZvKSk7Cj4gPiAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGJ1ZmxlbjsK
PiA+ICAgICAgICAgICAgICAgICB2b2lkICpidWY7Cj4gPiAgICAgICAgICAgICAgICAgaW50IG9m
ZjsKPiA+IC0tCj4gPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4gPgo+Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
