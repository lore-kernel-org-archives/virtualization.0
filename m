Return-Path: <SRS0=bReq=JU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F150DC433ED
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 04:08:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9318D6145C
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 04:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9318D6145C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 480F2605DC;
	Fri, 23 Apr 2021 04:08:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wvyhjUr_fN_g; Fri, 23 Apr 2021 04:08:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6297605EA;
	Fri, 23 Apr 2021 04:08:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C3A3C000E;
	Fri, 23 Apr 2021 04:08:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E03EC000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:08:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61B4A40281
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:08:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 18dhUIdAlcyd
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:08:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 541D6400BD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619150928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+GSyHIdh8Go4j1sZl0+B3qpF1lIUKXILWqJcAbazOA=;
 b=gDZLs80UHN2hhdlPKzMko5CDQHeYHHa4RzQ+3qYb8GlJiSGarXH263M3m7p+RrhxV43wDa
 g4wIEG2LBjNX/HlADbE6AbPLgPwtVSfHJq3D7Zr7pTnUbxww0WcRWQKY6aAtoDXF5/aNI7
 Mh+IDNVMx3QUsGEMf00jLmZlkBXba6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-8mnq1jCyP2a45amhpXgiSA-1; Fri, 23 Apr 2021 00:08:42 -0400
X-MC-Unique: 8mnq1jCyP2a45amhpXgiSA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E27210054F6;
 Fri, 23 Apr 2021 04:08:41 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-225.pek2.redhat.com
 [10.72.13.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3044F60BE5;
 Fri, 23 Apr 2021 04:08:35 +0000 (UTC)
Subject: Re: [PATCH net-next] virtio-net: fix use-after-free in skb_gro_receive
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210422151620.58204-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ea0bc0bc-1ac0-bf21-94dd-e11bf527a0c1@redhat.com>
Date: Fri, 23 Apr 2021 12:08:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210422151620.58204-1-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, "Michael S. Tsirkin" <mst@redhat.com>
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8yMiDPws7nMTE6MTYsIFh1YW4gWmh1byDQtLXAOgo+IFdoZW4gImhlYWRyb29t
IiA+IDAsIHRoZSBhY3R1YWwgYWxsb2NhdGVkIG1lbW9yeSBzcGFjZSBpcyB0aGUgZW50aXJlCj4g
cGFnZSwgc28gdGhlIGFkZHJlc3Mgb2YgdGhlIHBhZ2Ugc2hvdWxkIGJlIHVzZWQgd2hlbiBwYXNz
aW5nIGl0IHRvCj4gYnVpbGRfc2tiKCkuCj4KPiBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBp
biBza2JfZ3JvX3JlY2VpdmUgKG5ldC9jb3JlL3NrYnVmZi5jOjQyNjApCj4gV3JpdGUgb2Ygc2l6
ZSAxNiBhdCBhZGRyIGZmZmY4ODgxMTYxOWZmZmMgYnkgdGFzayBrd29ya2VyL3U5OjAvNTM0Cj4g
Q1BVOiAyIFBJRDogNTM0IENvbW06IGt3b3JrZXIvdTk6MCBOb3QgdGFpbnRlZCA1LjEyLjAtcmM3
LWN1c3RvbS0xNjM3Mi1nYjE1MGJlMDViODA2ICMzMzgyCj4gSGFyZHdhcmUgbmFtZTogUUVNVSBN
U04yNzAwLCBCSU9TIHJlbC0xLjEzLjAtMC1nZjIxYjVhNGFlYjAyLXByZWJ1aWx0LnFlbXUub3Jn
IDA0LzAxLzIwMTQKPiBXb3JrcXVldWU6IHhwcnRpb2QgeHNfc3RyZWFtX2RhdGFfcmVjZWl2ZV93
b3JrZm4gW3N1bnJwY10KPiBDYWxsIFRyYWNlOgo+ICAgPElSUT4KPiBkdW1wX3N0YWNrIChsaWIv
ZHVtcF9zdGFjay5jOjEyMikKPiBwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uLmNvbnN0cHJvcC4w
IChtbS9rYXNhbi9yZXBvcnQuYzoyMzMpCj4ga2FzYW5fcmVwb3J0LmNvbGQgKG1tL2thc2FuL3Jl
cG9ydC5jOjQwMCBtbS9rYXNhbi9yZXBvcnQuYzo0MTYpCj4gc2tiX2dyb19yZWNlaXZlIChuZXQv
Y29yZS9za2J1ZmYuYzo0MjYwKQo+IHRjcF9ncm9fcmVjZWl2ZSAobmV0L2lwdjQvdGNwX29mZmxv
YWQuYzoyNjYgKGRpc2NyaW1pbmF0b3IgMSkpCj4gdGNwNF9ncm9fcmVjZWl2ZSAobmV0L2lwdjQv
dGNwX29mZmxvYWQuYzozMTYpCj4gaW5ldF9ncm9fcmVjZWl2ZSAobmV0L2lwdjQvYWZfaW5ldC5j
OjE1NDUgKGRpc2NyaW1pbmF0b3IgMikpCj4gZGV2X2dyb19yZWNlaXZlIChuZXQvY29yZS9kZXYu
Yzo2MDc1KQo+IG5hcGlfZ3JvX3JlY2VpdmUgKG5ldC9jb3JlL2Rldi5jOjYxNjggbmV0L2NvcmUv
ZGV2LmM6NjE5OCkKPiByZWNlaXZlX2J1ZiAoZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOjExNTEp
IHZpcnRpb19uZXQKPiB2aXJ0bmV0X3BvbGwgKGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzoxNDE1
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYzoxNTE5KSB2aXJ0aW9fbmV0Cj4gX19uYXBpX3BvbGwg
KG5ldC9jb3JlL2Rldi5jOjY5NjQpCj4gbmV0X3J4X2FjdGlvbiAobmV0L2NvcmUvZGV2LmM6NzAz
MyBuZXQvY29yZS9kZXYuYzo3MTE4KQo+IF9fZG9fc29mdGlycSAoLi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9qdW1wX2xhYmVsLmg6MjUgLi9pbmNsdWRlL2xpbnV4L2p1bXBfbGFiZWwuaDoyMDAgLi9p
bmNsdWRlL3RyYWNlL2V2ZW50cy9pcnEuaDoxNDIga2VybmVsL3NvZnRpcnEuYzozNDYpCj4gaXJx
X2V4aXRfcmN1IChrZXJuZWwvc29mdGlycS5jOjIyMSBrZXJuZWwvc29mdGlycS5jOjQyMiBrZXJu
ZWwvc29mdGlycS5jOjQzNCkKPiBjb21tb25faW50ZXJydXB0IChhcmNoL3g4Ni9rZXJuZWwvaXJx
LmM6MjQwIChkaXNjcmltaW5hdG9yIDE0KSkKPiA8L0lSUT4KPgo+IEZpeGVzOiBmYjMyODU2YjE2
YWQgKCJ2aXJ0aW8tbmV0OiBwYWdlX3RvX3NrYigpIHVzZSBidWlsZF9za2Igd2hlbiB0aGVyZSdz
IHN1ZmZpY2llbnQgdGFpbHJvb20iKQo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+Cj4gUmVwb3J0ZWQtYnk6IElkbyBTY2hpbW1lbCA8aWRvc2No
QG52aWRpYS5jb20+Cj4gVGVzdGVkLWJ5OiBJZG8gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29t
Pgo+IC0tLQoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhl
IGNvZGVzIGJlY2FtZSBoYXJkIHRvIHJlYWQsIEkgdGhpbmsgd2UgY2FuIHRyeSB0byBkbyBzb21l
IGNsZWFudXBzIG9uIAp0b3AgdG8gbWFrZSBpdCBlYXNpZXIgdG8gcmVhZC4KClRoYW5rcwoKCj4g
ICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAxMiArKysrKysrKystLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5k
ZXggNzRkMmQ0OTI2NGYzLi43ZmRhMmFlNGM0MGYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAgLTM4Nyw3
ICszODcsNyBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0
bmV0X2luZm8gKnZpLAo+ICAgCXVuc2lnbmVkIGludCBjb3B5LCBoZHJfbGVuLCBoZHJfcGFkZGVk
X2xlbjsKPiAgIAlzdHJ1Y3QgcGFnZSAqcGFnZV90b19mcmVlID0gTlVMTDsKPiAgIAlpbnQgdGFp
bHJvb20sIHNoaW5mb19zaXplOwo+IC0JY2hhciAqcCwgKmhkcl9wOwo+ICsJY2hhciAqcCwgKmhk
cl9wLCAqYnVmOwo+ICAgCj4gICAJcCA9IHBhZ2VfYWRkcmVzcyhwYWdlKSArIG9mZnNldDsKPiAg
IAloZHJfcCA9IHA7Cj4gQEAgLTQwMywxMSArNDAzLDE1IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVm
ZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJICogc3BhY2UgYXJl
IGFsaWduZWQuCj4gICAJICovCj4gICAJaWYgKGhlYWRyb29tKSB7Cj4gLQkJLyogVGhlIGFjdHVh
bCBhbGxvY2F0ZWQgc3BhY2Ugc2l6ZSBpcyBQQUdFX1NJWkUuICovCj4gKwkJLyogQnVmZmVycyB3
aXRoIGhlYWRyb29tIHVzZSBQQUdFX1NJWkUgYXMgYWxsb2Mgc2l6ZSwKPiArCQkgKiBzZWUgYWRk
X3JlY3ZidWZfbWVyZ2VhYmxlKCkgKyBnZXRfbWVyZ2VhYmxlX2J1Zl9sZW4oKQo+ICsJCSAqLwo+
ICAgCQl0cnVlc2l6ZSA9IFBBR0VfU0laRTsKPiAgIAkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxl
biAtIG9mZnNldDsKPiArCQlidWYgPSBwYWdlX2FkZHJlc3MocGFnZSk7Cj4gICAJfSBlbHNlIHsK
PiAgIAkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxlbjsKPiArCQlidWYgPSBwOwo+ICAgCX0KPiAg
IAo+ICAgCWxlbiAtPSBoZHJfbGVuOwo+IEBAIC00MTYsMTEgKzQyMCwxMyBAQCBzdGF0aWMgc3Ry
dWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgCj4g
ICAJc2hpbmZvX3NpemUgPSBTS0JfREFUQV9BTElHTihzaXplb2Yoc3RydWN0IHNrYl9zaGFyZWRf
aW5mbykpOwo+ICAgCj4gKwkvKiBjb3B5IHNtYWxsIHBhY2tldCBzbyB3ZSBjYW4gcmV1c2UgdGhl
c2UgcGFnZXMgKi8KPiAgIAlpZiAoIU5FVF9JUF9BTElHTiAmJiBsZW4gPiBHT09EX0NPUFlfTEVO
ICYmIHRhaWxyb29tID49IHNoaW5mb19zaXplKSB7Cj4gLQkJc2tiID0gYnVpbGRfc2tiKHAsIHRy
dWVzaXplKTsKPiArCQlza2IgPSBidWlsZF9za2IoYnVmLCB0cnVlc2l6ZSk7Cj4gICAJCWlmICh1
bmxpa2VseSghc2tiKSkKPiAgIAkJCXJldHVybiBOVUxMOwo+ICAgCj4gKwkJc2tiX3Jlc2VydmUo
c2tiLCBwIC0gYnVmKTsKPiAgIAkJc2tiX3B1dChza2IsIGxlbik7Cj4gICAJCWdvdG8gb2s7Cj4g
ICAJfQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
