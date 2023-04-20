Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44B5C77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 09:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4AC7E4064D;
	Thu, 20 Apr 2023 09:09:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AC7E4064D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5akIPtk1xDDE; Thu, 20 Apr 2023 09:09:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C5E8640515;
	Thu, 20 Apr 2023 09:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C5E8640515
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 96854C0036;
	Thu, 20 Apr 2023 09:09:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CCE2C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B31083C3A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:09:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B31083C3A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GXhpt9g5gvPZ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:09:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B1488130C
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8B1488130C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 09:09:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VgYMQcc_1681981746; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgYMQcc_1681981746) by smtp.aliyun-inc.com;
 Thu, 20 Apr 2023 17:09:07 +0800
Message-ID: <1681980971.1167793-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 13/14] virtio_net: small: optimize code
Date: Thu, 20 Apr 2023 16:56:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230418065327.72281-1-xuanzhuo@linux.alibaba.com>
 <20230418065327.72281-14-xuanzhuo@linux.alibaba.com>
 <CACGkMEtubJ8ND01J+Arpa4TB5kfdap7t6f9D5qc7-XkeFZYRKQ@mail.gmail.com>
In-Reply-To: <CACGkMEtubJ8ND01J+Arpa4TB5kfdap7t6f9D5qc7-XkeFZYRKQ@mail.gmail.com>
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

T24gVGh1LCAyMCBBcHIgMjAyMyAxNDozMjozNyArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVHVlLCBBcHIgMTgsIDIwMjMgYXQgMjo1M+KAr1BNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IEF2b2lk
IHRoZSBwcm9ibGVtIHRoYXQgc29tZSB2YXJpYWJsZXMoaGVhZHJvb20gYW5kIHNvIG9uKSB3aWxs
IHJlcGVhdAo+ID4gdGhlIGNhbGN1bGF0aW9uIHdoZW4gcHJvY2VzcyB4ZHAuCj4KPiBXaGlsZSBh
dCBpdCwgaWYgd2UgYWdyZWUgdG8gdXNlIHNlcGFyYXRlIGNvZGUgcGF0aHMgZm9yIGJ1aWxkaW5n
IHNrYnMuCj4KPiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gaGF2ZSBhIGhlbHBlciBmb3IgYnVpbGRp
bmcgc2tiIGZvciBub24gWERQCj4gY2FzZXMsIHRoZW4gd2UgY2FuIGhpZGUgdGhvc2UgY2FsY3Vs
YXRpb24gdGhlcmUuCgoKWWVzLCB3ZSBjYW4gaW50cm9kdWNlIG9uZSBoZWxwZXIsIHRoZW4gcmVj
ZWl2ZV9zbWFsbCB3aWxsIGJlIG1vcmUgc2ltcGxlLgpCdXQgdGhlc2UgY2FsY3VsYXRpb24gY2Fu
IG5vdCBzaGFyZWQgd2l0aCB4ZHAgY2FzZSwgYmVjYXVzZSB4ZHAgY2FzZSBuZWVkcyB0bwpnZXQg
dGhlc2UgdmFycyBiZWZvcmUgcnVubmluZyB4ZHAuCgpUaGVuIHRoZSBjb2RlICJjb3B5IHZuZXQg
aGRyIiBhbmQgInNldCBtZXRhZGF0YSIgc2hvdWxkIHN0YXkgaW4gdGhlaXIgb3duCmZ1bmN0aW9u
LgoKT25seSB0aGUgdmlydG5ldF9idWlsZF9za2IoKVtidWlsZF9za2IsIHNrYl9yZXNlcnZlLCBz
a2JfcHV0XSBjYW4gYmUgc2hhcmVkLgoKc3RhdGljIHN0cnVjdCBza19idWZmICp2aXJ0bmV0X2J1
aWxkX3NrYih2b2lkICpidWYsIHVuc2lnbmVkIGludCBidWZsZW4sCgkJCQkJIHVuc2lnbmVkIGlu
dCBoZWFkcm9vbSwKCQkJCQkgdW5zaWduZWQgaW50IGxlbikKewoJc3RydWN0IHNrX2J1ZmYgKnNr
YjsKCglza2IgPSBidWlsZF9za2IoYnVmLCBidWZsZW4pOwoJaWYgKCFza2IpCgkJcmV0dXJuIE5V
TEw7CgoJc2tiX3Jlc2VydmUoc2tiLCBoZWFkcm9vbSk7Cglza2JfcHV0KHNrYiwgbGVuKTsKCgly
ZXR1cm4gc2tiOwp9CgpzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfc21hbGxfYnVpbGRf
c2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAoJCQkJCSAgICAgICB1bnNpZ25lZCBpbnQgeGRw
X2hlYWRyb29tLAoJCQkJCSAgICAgICB2b2lkICpidWYsCgkJCQkJICAgICAgIHVuc2lnbmVkIGlu
dCBsZW4pCnsKCXVuc2lnbmVkIGludCBoZWFkZXJfb2Zmc2V0OwoJdW5zaWduZWQgaW50IGhlYWRy
b29tOwoJdW5zaWduZWQgaW50IGJ1ZmxlbjsKCXN0cnVjdCBza19idWZmICpza2I7CgoJaGVhZGVy
X29mZnNldCA9IFZJUlRORVRfUlhfUEFEICsgeGRwX2hlYWRyb29tOwoJaGVhZHJvb20gPSB2aS0+
aGRyX2xlbiArIGhlYWRlcl9vZmZzZXQ7CglidWZsZW4gPSBTS0JfREFUQV9BTElHTihHT09EX1BB
Q0tFVF9MRU4gKyBoZWFkcm9vbSkgKwoJCVNLQl9EQVRBX0FMSUdOKHNpemVvZihzdHJ1Y3Qgc2ti
X3NoYXJlZF9pbmZvKSk7CgoJc2tiID0gdmlydG5ldF9idWlsZF9za2IoYnVmLCBidWZsZW4sIGhl
YWRyb29tLCBsZW4pOwoJaWYgKHVubGlrZWx5KCFza2IpKQoJCXJldHVybiBOVUxMOwoKCWJ1ZiAr
PSBoZWFkZXJfb2Zmc2V0OwoJbWVtY3B5KHNrYl92bmV0X2hkcihza2IpLCBidWYsIHZpLT5oZHJf
bGVuKTsKCglyZXR1cm4gc2tiOwp9CgpUaGFua3MKCj4KPiBUaGFua3MKPgo+ID4KPiA+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0K
PiA+ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAxMiArKysrKysrKy0tLS0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiA+IGluZGV4IGY2ZjU5MDNmYWNlMi4uNWE1NjM2MTc4YmQzIDEwMDY0NAo+ID4gLS0tIGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiA+IEBAIC0xMDQwLDExICsxMDQwLDEwIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcmVj
ZWl2ZV9zbWFsbChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gICAgICAgICBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiOwo+ID4gICAgICAgICBzdHJ1Y3QgYnBmX3Byb2cgKnhkcF9wcm9nOwo+ID4gICAg
ICAgICB1bnNpZ25lZCBpbnQgeGRwX2hlYWRyb29tID0gKHVuc2lnbmVkIGxvbmcpY3R4Owo+ID4g
LSAgICAgICB1bnNpZ25lZCBpbnQgaGVhZGVyX29mZnNldCA9IFZJUlRORVRfUlhfUEFEICsgeGRw
X2hlYWRyb29tOwo+ID4gLSAgICAgICB1bnNpZ25lZCBpbnQgaGVhZHJvb20gPSB2aS0+aGRyX2xl
biArIGhlYWRlcl9vZmZzZXQ7Cj4gPiAtICAgICAgIHVuc2lnbmVkIGludCBidWZsZW4gPSBTS0Jf
REFUQV9BTElHTihHT09EX1BBQ0tFVF9MRU4gKyBoZWFkcm9vbSkgKwo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgU0tCX0RBVEFfQUxJR04oc2l6ZW9mKHN0cnVjdCBza2Jfc2hhcmVk
X2luZm8pKTsKPiA+ICAgICAgICAgc3RydWN0IHBhZ2UgKnBhZ2UgPSB2aXJ0X3RvX2hlYWRfcGFn
ZShidWYpOwo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgaGVhZGVyX29mZnNldDsKPiA+ICsgICAg
ICAgdW5zaWduZWQgaW50IGhlYWRyb29tOwo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgYnVmbGVu
Owo+ID4KPiA+ICAgICAgICAgbGVuIC09IHZpLT5oZHJfbGVuOwo+ID4gICAgICAgICBzdGF0cy0+
Ynl0ZXMgKz0gbGVuOwo+ID4gQEAgLTEwNzIsNiArMTA3MSwxMSBAQCBzdGF0aWMgc3RydWN0IHNr
X2J1ZmYgKnJlY2VpdmVfc21hbGwoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+ICAgICAgICAg
cmN1X3JlYWRfdW5sb2NrKCk7Cj4gPgo+ID4gIHNraXBfeGRwOgo+ID4gKyAgICAgICBoZWFkZXJf
b2Zmc2V0ID0gVklSVE5FVF9SWF9QQUQgKyB4ZHBfaGVhZHJvb207Cj4gPiArICAgICAgIGhlYWRy
b29tID0gdmktPmhkcl9sZW4gKyBoZWFkZXJfb2Zmc2V0Owo+ID4gKyAgICAgICBidWZsZW4gPSBT
S0JfREFUQV9BTElHTihHT09EX1BBQ0tFVF9MRU4gKyBoZWFkcm9vbSkgKwo+ID4gKyAgICAgICAg
ICAgICAgIFNLQl9EQVRBX0FMSUdOKHNpemVvZihzdHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvKSk7Cj4g
PiArCj4gPiAgICAgICAgIHNrYiA9IGJ1aWxkX3NrYihidWYsIGJ1Zmxlbik7Cj4gPiAgICAgICAg
IGlmICghc2tiKQo+ID4gICAgICAgICAgICAgICAgIGdvdG8gZXJyOwo+ID4gLS0KPiA+IDIuMzIu
MC4zLmcwMTE5NWNmOWYKPiA+Cj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
