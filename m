Return-Path: <SRS0=bReq=JU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFD5C433ED
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 04:33:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D4C66120D
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 04:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4C66120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A9AC40F95;
	Fri, 23 Apr 2021 04:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xIQwsBhdfo3h; Fri, 23 Apr 2021 04:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 68D5740F93;
	Fri, 23 Apr 2021 04:33:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B281C000F;
	Fri, 23 Apr 2021 04:33:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3F85C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:33:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7DA2740281
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:33:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UduA72GDNksS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:33:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9687E4027A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 04:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619152402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S/rpXgbgmc50aCP+Bf5P8vd/NdVHXa2pUILMXzqjzjQ=;
 b=aiL4a84hj2j+oCKxcG9EUIh/1sfkPn/iqnrWL096iuaCcUNUkSMt1wHJEdopVGAa9H8CWe
 dDYS//2ylAAtZWuUxtlzm55CGWMsFzEue4UDydqp53EWaZ7EZgj7dixdN1NKHpUtH61ecL
 ZCdB2B+MhDSVkAl3Vu945n4oNZZrPSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-534-DaCL4IoKPQ2-RlU-wMUd2A-1; Fri, 23 Apr 2021 00:33:19 -0400
X-MC-Unique: DaCL4IoKPQ2-RlU-wMUd2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 479EC18B9F84;
 Fri, 23 Apr 2021 04:33:18 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-225.pek2.redhat.com
 [10.72.13.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C96DD19442;
 Fri, 23 Apr 2021 04:33:10 +0000 (UTC)
Subject: Re: [PATCH net-next] virtio-net: fix use-after-free in skb_gro_receive
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1619151585.3098595-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b2f5cab7-18dd-2817-7423-e84ea1907bf3@redhat.com>
Date: Fri, 23 Apr 2021 12:33:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1619151585.3098595-1-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ido Schimmel <idosch@nvidia.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIxLzQvMjMg5LiL5Y2IMTI6MTksIFh1YW4gWmh1byDlhpnpgZM6Cj4gT24gRnJpLCAy
MyBBcHIgMjAyMSAxMjowODozNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4+IOWcqCAyMDIxLzQvMjIg5LiL5Y2IMTE6MTYsIFh1YW4gWmh1byDlhpnpgZM6
Cj4+PiBXaGVuICJoZWFkcm9vbSIgPiAwLCB0aGUgYWN0dWFsIGFsbG9jYXRlZCBtZW1vcnkgc3Bh
Y2UgaXMgdGhlIGVudGlyZQo+Pj4gcGFnZSwgc28gdGhlIGFkZHJlc3Mgb2YgdGhlIHBhZ2Ugc2hv
dWxkIGJlIHVzZWQgd2hlbiBwYXNzaW5nIGl0IHRvCj4+PiBidWlsZF9za2IoKS4KPj4+Cj4+PiBC
VUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbiBza2JfZ3JvX3JlY2VpdmUgKG5ldC9jb3JlL3Nr
YnVmZi5jOjQyNjApCj4+PiBXcml0ZSBvZiBzaXplIDE2IGF0IGFkZHIgZmZmZjg4ODExNjE5ZmZm
YyBieSB0YXNrIGt3b3JrZXIvdTk6MC81MzQKPj4+IENQVTogMiBQSUQ6IDUzNCBDb21tOiBrd29y
a2VyL3U5OjAgTm90IHRhaW50ZWQgNS4xMi4wLXJjNy1jdXN0b20tMTYzNzItZ2IxNTBiZTA1Yjgw
NiAjMzM4Mgo+Pj4gSGFyZHdhcmUgbmFtZTogUUVNVSBNU04yNzAwLCBCSU9TIHJlbC0xLjEzLjAt
MC1nZjIxYjVhNGFlYjAyLXByZWJ1aWx0LnFlbXUub3JnIDA0LzAxLzIwMTQKPj4+IFdvcmtxdWV1
ZTogeHBydGlvZCB4c19zdHJlYW1fZGF0YV9yZWNlaXZlX3dvcmtmbiBbc3VucnBjXQo+Pj4gQ2Fs
bCBUcmFjZToKPj4+ICAgIDxJUlE+Cj4+PiBkdW1wX3N0YWNrIChsaWIvZHVtcF9zdGFjay5jOjEy
MikKPj4+IHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24uY29uc3Rwcm9wLjAgKG1tL2thc2FuL3Jl
cG9ydC5jOjIzMykKPj4+IGthc2FuX3JlcG9ydC5jb2xkIChtbS9rYXNhbi9yZXBvcnQuYzo0MDAg
bW0va2FzYW4vcmVwb3J0LmM6NDE2KQo+Pj4gc2tiX2dyb19yZWNlaXZlIChuZXQvY29yZS9za2J1
ZmYuYzo0MjYwKQo+Pj4gdGNwX2dyb19yZWNlaXZlIChuZXQvaXB2NC90Y3Bfb2ZmbG9hZC5jOjI2
NiAoZGlzY3JpbWluYXRvciAxKSkKPj4+IHRjcDRfZ3JvX3JlY2VpdmUgKG5ldC9pcHY0L3RjcF9v
ZmZsb2FkLmM6MzE2KQo+Pj4gaW5ldF9ncm9fcmVjZWl2ZSAobmV0L2lwdjQvYWZfaW5ldC5jOjE1
NDUgKGRpc2NyaW1pbmF0b3IgMikpCj4+PiBkZXZfZ3JvX3JlY2VpdmUgKG5ldC9jb3JlL2Rldi5j
OjYwNzUpCj4+PiBuYXBpX2dyb19yZWNlaXZlIChuZXQvY29yZS9kZXYuYzo2MTY4IG5ldC9jb3Jl
L2Rldi5jOjYxOTgpCj4+PiByZWNlaXZlX2J1ZiAoZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOjEx
NTEpIHZpcnRpb19uZXQKPj4+IHZpcnRuZXRfcG9sbCAoZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
OjE0MTUgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jOjE1MTkpIHZpcnRpb19uZXQKPj4+IF9fbmFw
aV9wb2xsIChuZXQvY29yZS9kZXYuYzo2OTY0KQo+Pj4gbmV0X3J4X2FjdGlvbiAobmV0L2NvcmUv
ZGV2LmM6NzAzMyBuZXQvY29yZS9kZXYuYzo3MTE4KQo+Pj4gX19kb19zb2Z0aXJxICguL2FyY2gv
eDg2L2luY2x1ZGUvYXNtL2p1bXBfbGFiZWwuaDoyNSAuL2luY2x1ZGUvbGludXgvanVtcF9sYWJl
bC5oOjIwMCAuL2luY2x1ZGUvdHJhY2UvZXZlbnRzL2lycS5oOjE0MiBrZXJuZWwvc29mdGlycS5j
OjM0NikKPj4+IGlycV9leGl0X3JjdSAoa2VybmVsL3NvZnRpcnEuYzoyMjEga2VybmVsL3NvZnRp
cnEuYzo0MjIga2VybmVsL3NvZnRpcnEuYzo0MzQpCj4+PiBjb21tb25faW50ZXJydXB0IChhcmNo
L3g4Ni9rZXJuZWwvaXJxLmM6MjQwIChkaXNjcmltaW5hdG9yIDE0KSkKPj4+IDwvSVJRPgo+Pj4K
Pj4+IEZpeGVzOiBmYjMyODU2YjE2YWQgKCJ2aXJ0aW8tbmV0OiBwYWdlX3RvX3NrYigpIHVzZSBi
dWlsZF9za2Igd2hlbiB0aGVyZSdzIHN1ZmZpY2llbnQgdGFpbHJvb20iKQo+Pj4gU2lnbmVkLW9m
Zi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPj4+IFJlcG9ydGVk
LWJ5OiBJZG8gU2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29tPgo+Pj4gVGVzdGVkLWJ5OiBJZG8g
U2NoaW1tZWwgPGlkb3NjaEBudmlkaWEuY29tPgo+Pj4gLS0tCj4+Cj4+IEFja2VkLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+Pgo+PiBUaGUgY29kZXMgYmVjYW1lIGhhcmQg
dG8gcmVhZCwgSSB0aGluayB3ZSBjYW4gdHJ5IHRvIGRvIHNvbWUgY2xlYW51cHMgb24KPj4gdG9w
IHRvIG1ha2UgaXQgZWFzaWVyIHRvIHJlYWQuCj4+Cj4+IFRoYW5rcwo+IFllcywgdGhpcyBwaWVj
ZSBvZiBjb2RlIG5lZWRzIHRvIGJlIHNvcnRlZCBvdXQuIEVzcGVjaWFsbHkgdGhlIGJpZyBhbmQg
bWVyZ2VhYmxlCj4gc2NlbmFyaW9zIHNob3VsZCBiZSBoYW5kbGVkIHNlcGFyYXRlbHkuIFJlbW92
ZSB0aGUgbWVyZ2VhYmxlIGNvZGUgZnJvbSB0aGlzCj4gZnVuY3Rpb24sIGFuZCBtZXJnZWFibGUg
dXNlcyBhIG5ldyBmdW5jdGlvbiBhbG9uZS4KCgpSaWdodCwgYW5vdGhlciB0aGluZyBpcyB0aGF0
IHdlIG1heSBjb25zaWRlciB0byByZWxheCB0aGUgY2hlY2tpbmcgb2YgCmxlbiA8IEdPT0RfQ09Q
WV9MRU4uCgpPdXIgUUUgc3RpbGwgc2VlIGxvdyBQUFMgY29tcGFyZWQgd2l0aCB0aGUgY29kZSBi
ZWZvcmUgMzIyNmIxNThlNjdjIAooIm5ldDogYXZvaWQgMzIgeCB0cnVlc2l6ZSB1bmRlci1lc3Rp
bWF0aW9uIGZvciB0aW55IHNrYnMiKS4KClRoYW5rcwoKCj4KPiBUaGFua3MuCj4KPj4KPj4+ICAg
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDEyICsrKysrKysrKy0tLQo+Pj4gICAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4+PiBpbmRleCA3NGQyZDQ5MjY0ZjMuLjdmZGEyYWU0YzQwZiAxMDA2NDQKPj4+IC0tLSBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4+PiBAQCAtMzg3LDcgKzM4Nyw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19z
a2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4+PiAgICAJdW5zaWduZWQgaW50IGNvcHksIGhk
cl9sZW4sIGhkcl9wYWRkZWRfbGVuOwo+Pj4gICAgCXN0cnVjdCBwYWdlICpwYWdlX3RvX2ZyZWUg
PSBOVUxMOwo+Pj4gICAgCWludCB0YWlscm9vbSwgc2hpbmZvX3NpemU7Cj4+PiAtCWNoYXIgKnAs
ICpoZHJfcDsKPj4+ICsJY2hhciAqcCwgKmhkcl9wLCAqYnVmOwo+Pj4KPj4+ICAgIAlwID0gcGFn
ZV9hZGRyZXNzKHBhZ2UpICsgb2Zmc2V0Owo+Pj4gICAgCWhkcl9wID0gcDsKPj4+IEBAIC00MDMs
MTEgKzQwMywxNSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpLAo+Pj4gICAgCSAqIHNwYWNlIGFyZSBhbGlnbmVkLgo+Pj4gICAgCSAq
Lwo+Pj4gICAgCWlmIChoZWFkcm9vbSkgewo+Pj4gLQkJLyogVGhlIGFjdHVhbCBhbGxvY2F0ZWQg
c3BhY2Ugc2l6ZSBpcyBQQUdFX1NJWkUuICovCj4+PiArCQkvKiBCdWZmZXJzIHdpdGggaGVhZHJv
b20gdXNlIFBBR0VfU0laRSBhcyBhbGxvYyBzaXplLAo+Pj4gKwkJICogc2VlIGFkZF9yZWN2YnVm
X21lcmdlYWJsZSgpICsgZ2V0X21lcmdlYWJsZV9idWZfbGVuKCkKPj4+ICsJCSAqLwo+Pj4gICAg
CQl0cnVlc2l6ZSA9IFBBR0VfU0laRTsKPj4+ICAgIAkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxl
biAtIG9mZnNldDsKPj4+ICsJCWJ1ZiA9IHBhZ2VfYWRkcmVzcyhwYWdlKTsKPj4+ICAgIAl9IGVs
c2Ugewo+Pj4gICAgCQl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuOwo+Pj4gKwkJYnVmID0gcDsK
Pj4+ICAgIAl9Cj4+Pgo+Pj4gICAgCWxlbiAtPSBoZHJfbGVuOwo+Pj4gQEAgLTQxNiwxMSArNDIw
LDEzIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRf
aW5mbyAqdmksCj4+Pgo+Pj4gICAgCXNoaW5mb19zaXplID0gU0tCX0RBVEFfQUxJR04oc2l6ZW9m
KHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsKPj4+Cj4+PiArCS8qIGNvcHkgc21hbGwgcGFja2V0
IHNvIHdlIGNhbiByZXVzZSB0aGVzZSBwYWdlcyAqLwo+Pj4gICAgCWlmICghTkVUX0lQX0FMSUdO
ICYmIGxlbiA+IEdPT0RfQ09QWV9MRU4gJiYgdGFpbHJvb20gPj0gc2hpbmZvX3NpemUpIHsKPj4+
IC0JCXNrYiA9IGJ1aWxkX3NrYihwLCB0cnVlc2l6ZSk7Cj4+PiArCQlza2IgPSBidWlsZF9za2Io
YnVmLCB0cnVlc2l6ZSk7Cj4+PiAgICAJCWlmICh1bmxpa2VseSghc2tiKSkKPj4+ICAgIAkJCXJl
dHVybiBOVUxMOwo+Pj4KPj4+ICsJCXNrYl9yZXNlcnZlKHNrYiwgcCAtIGJ1Zik7Cj4+PiAgICAJ
CXNrYl9wdXQoc2tiLCBsZW4pOwo+Pj4gICAgCQlnb3RvIG9rOwo+Pj4gICAgCX0KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
