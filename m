Return-Path: <SRS0=J9So=JQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC1CC433ED
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 03:10:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C00A61104
	for <virtualization@archiver.kernel.org>; Mon, 19 Apr 2021 03:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C00A61104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E607A4012D;
	Mon, 19 Apr 2021 03:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jh61bBQxdE_A; Mon, 19 Apr 2021 03:10:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id C418C400C0;
	Mon, 19 Apr 2021 03:10:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BF64C000E;
	Mon, 19 Apr 2021 03:10:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C004C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:10:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 387184012D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3vB5T3MNsjkt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:10:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4736F400C0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Apr 2021 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618801814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xUe+MYJDbBFqVKD9wI/DGM7y7MGyU5lLHv4fHfJN3k=;
 b=hHOL3gk4oxaeuLIZZWa7w2HIHN2ckPNHWi3xqBiWhOQLopl8tiRIRFSKFXSuMP6Ng7tb09
 UqF4s9wJLXGH/l/DdXaxcHfySVtIFQOPgn3nMTBtsGDfWo6DBFIJkU3raZIzPokf2/5DzD
 I6wwx5ICdpbTTTa31/RNQXZKrD+X73w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-zD5P6VJKMXSXDPAUZv5Fdw-1; Sun, 18 Apr 2021 23:10:12 -0400
X-MC-Unique: zD5P6VJKMXSXDPAUZv5Fdw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC348180486D;
 Mon, 19 Apr 2021 03:10:10 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-157.pek2.redhat.com
 [10.72.12.157])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 573E619D9D;
 Mon, 19 Apr 2021 03:10:05 +0000 (UTC)
Subject: Re: [PATCH net-next v3] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210416091615.25198-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <023dcd7f-5896-8175-545f-44af935e9e45@redhat.com>
Date: Mon, 19 Apr 2021 11:10:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210416091615.25198-1-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CuWcqCAyMDIxLzQvMTYg5LiL5Y2INToxNiwgWHVhbiBaaHVvIOWGmemBkzoKPiBJbiBwYWdlX3Rv
X3NrYigpLCBpZiB3ZSBoYXZlIGVub3VnaCB0YWlscm9vbSB0byBzYXZlIHNrYl9zaGFyZWRfaW5m
bywgd2UKPiBjYW4gdXNlIGJ1aWxkX3NrYiB0byBjcmVhdGUgc2tiIGRpcmVjdGx5LiBObyBuZWVk
IHRvIGFsbG9jIGZvcgo+IGFkZGl0aW9uYWwgc3BhY2UuIEFuZCBpdCBjYW4gc2F2ZSBhICdmcmFn
cyBzbG90Jywgd2hpY2ggaXMgdmVyeSBmcmllbmRseQo+IHRvIEdSTy4KPgo+IEhlcmUsIGlmIHRo
ZSBwYXlsb2FkIG9mIHRoZSByZWNlaXZlZCBwYWNrYWdlIGlzIHRvbyBzbWFsbCAobGVzcyB0aGFu
Cj4gR09PRF9DT1BZX0xFTiksIHdlIHN0aWxsIGNob29zZSB0byBjb3B5IGl0IGRpcmVjdGx5IHRv
IHRoZSBzcGFjZSBnb3QgYnkKPiBuYXBpX2FsbG9jX3NrYi4gU28gd2UgY2FuIHJldXNlIHRoZXNl
IHBhZ2VzLgo+Cj4gVGVzdGluZyBNYWNoaW5lOgo+ICAgICAgVGhlIGZvdXIgcXVldWVzIG9mIHRo
ZSBuZXR3b3JrIGNhcmQgYXJlIGJvdW5kIHRvIHRoZSBjcHUxLgo+Cj4gVGVzdCBjb21tYW5kOgo+
ICAgICAgZm9yICgoaT0wO2k8NTsrK2kpKTsgZG8gc29ja3BlcmYgdHAgLS1pcCAxOTIuMTY4LjEy
Mi42NCAtbSAxMDAwIC10IDE1MCYgZG9uZQo+Cj4gVGhlIHNpemUgb2YgdGhlIHVkcCBwYWNrYWdl
IGlzIDEwMDAsIHNvIGluIHRoZSBjYXNlIG9mIHRoaXMgcGF0Y2gsIHRoZXJlCj4gd2lsbCBhbHdh
eXMgYmUgZW5vdWdoIHRhaWxyb29tIHRvIHVzZSBidWlsZF9za2IuIFRoZSBzZW50IHVkcCBwYWNr
ZXQKPiB3aWxsIGJlIGRpc2NhcmRlZCBiZWNhdXNlIHRoZXJlIGlzIG5vIHBvcnQgdG8gcmVjZWl2
ZSBpdC4gVGhlIGlycXNvZnRkCj4gb2YgdGhlIG1hY2hpbmUgaXMgMTAwJSwgd2Ugb2JzZXJ2ZSB0
aGUgcmVjZWl2ZWQgcXVhbnRpdHkgZGlzcGxheWVkIGJ5Cj4gc2FyIC1uIERFViAxOgo+Cj4gbm8g
YnVpbGRfc2tiOiAgOTU2ODY0LjAwIHJ4cGNrL3MKPiBidWlsZF9za2I6ICAgIDExNTg0NjUuMDAg
cnhwY2svcwoKCkkgc3VnZ2VzcyB0byB0ZXN0IHRoZSBjYXNlIG9mIFhEUF9QQVNTIGluIHRoaXMg
Y2FzZSBhcyB3ZWxsLgoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPgo+IFN1Z2dlc3RlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KPiAtLS0KPgo+IHYzOiBmaXggdGhlIHRydWVzaXplIHdoZW4gaGVhZHJvb20gPiAw
Cj4KPiB2MjogY29uZmxpY3QgcmVzb2x1dGlvbgo+Cj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMgfCA2OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4gICAxIGZp
bGUgY2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gaW5kZXggMTAxNjU5Y2Q0Yjg3Li44Y2Q3NjAzN2M3MjQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gQEAg
LTM3OSwyMSArMzc5LDE3IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19za2Ioc3Ry
dWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJCQkJICAgc3RydWN0IHJlY2VpdmVfcXVldWUgKnJx
LAo+ICAgCQkJCSAgIHN0cnVjdCBwYWdlICpwYWdlLCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ICAg
CQkJCSAgIHVuc2lnbmVkIGludCBsZW4sIHVuc2lnbmVkIGludCB0cnVlc2l6ZSwKPiAtCQkJCSAg
IGJvb2wgaGRyX3ZhbGlkLCB1bnNpZ25lZCBpbnQgbWV0YXNpemUpCj4gKwkJCQkgICBib29sIGhk
cl92YWxpZCwgdW5zaWduZWQgaW50IG1ldGFzaXplLAo+ICsJCQkJICAgdW5zaWduZWQgaW50IGhl
YWRyb29tKQo+ICAgewo+ICAgCXN0cnVjdCBza19idWZmICpza2I7Cj4gICAJc3RydWN0IHZpcnRp
b19uZXRfaGRyX21yZ19yeGJ1ZiAqaGRyOwo+ICAgCXVuc2lnbmVkIGludCBjb3B5LCBoZHJfbGVu
LCBoZHJfcGFkZGVkX2xlbjsKPiAtCWNoYXIgKnA7Cj4gKwlpbnQgdGFpbHJvb20sIHNoaW5mb19z
aXplOwo+ICsJY2hhciAqcCwgKmhkcl9wOwo+Cj4gICAJcCA9IHBhZ2VfYWRkcmVzcyhwYWdlKSAr
IG9mZnNldDsKPiAtCj4gLQkvKiBjb3B5IHNtYWxsIHBhY2tldCBzbyB3ZSBjYW4gcmV1c2UgdGhl
c2UgcGFnZXMgZm9yIHNtYWxsIGRhdGEgKi8KPiAtCXNrYiA9IG5hcGlfYWxsb2Nfc2tiKCZycS0+
bmFwaSwgR09PRF9DT1BZX0xFTik7Cj4gLQlpZiAodW5saWtlbHkoIXNrYikpCj4gLQkJcmV0dXJu
IE5VTEw7Cj4gLQo+IC0JaGRyID0gc2tiX3ZuZXRfaGRyKHNrYik7Cj4gKwloZHJfcCA9IHA7Cj4K
PiAgIAloZHJfbGVuID0gdmktPmhkcl9sZW47Cj4gICAJaWYgKHZpLT5tZXJnZWFibGVfcnhfYnVm
cykKPiBAQCAtNDAxLDE0ICszOTcsMzggQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpwYWdlX3Rv
X3NrYihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgIAllbHNlCj4gICAJCWhkcl9wYWRkZWRf
bGVuID0gc2l6ZW9mKHN0cnVjdCBwYWRkZWRfdm5ldF9oZHIpOwo+Cj4gLQkvKiBoZHJfdmFsaWQg
bWVhbnMgbm8gWERQLCBzbyB3ZSBjYW4gY29weSB0aGUgdm5ldCBoZWFkZXIgKi8KPiAtCWlmICho
ZHJfdmFsaWQpCj4gLQkJbWVtY3B5KGhkciwgcCwgaGRyX2xlbik7Cj4gKwkvKiBJZiBoZWFkcm9v
bSBpcyBub3QgMCwgdGhlcmUgaXMgYW4gb2Zmc2V0IGJldHdlZW4gdGhlIGJlZ2lubmluZyBvZiB0
aGUKPiArCSAqIGRhdGEgYW5kIHRoZSBhbGxvY2F0ZWQgc3BhY2UsIG90aGVyd2lzZSB0aGUgZGF0
YSBhbmQgdGhlIGFsbG9jYXRlZAo+ICsJICogc3BhY2UgYXJlIGFsaWduZWQuCj4gKwkgKi8KPiAr
CWlmIChoZWFkcm9vbSkgewo+ICsJCS8qIFRoZSBhY3R1YWwgYWxsb2NhdGVkIHNwYWNlIHNpemUg
aXMgUEFHRV9TSVpFLiAqLwoKCkkgdGhpbmsgdGhlIGNvbW1lbnQgaW4gcmVjZWl2ZV9tZXJnZWFi
bGUoKSBpcyBiZXR0ZXI6CgogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIEJ1ZmZl
cnMgd2l0aCBoZWFkcm9vbSB1c2UgUEFHRV9TSVpFIGFzIGFsbG9jIHNpemUsCiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHNlZSBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUoKSArIGdl
dF9tZXJnZWFibGVfYnVmX2xlbigpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAq
LwoKCj4gKwkJdHJ1ZXNpemUgPSBQQUdFX1NJWkU7Cj4gKwkJdGFpbHJvb20gPSB0cnVlc2l6ZSAt
IGxlbiAtIG9mZnNldDsKPiArCX0gZWxzZSB7Cj4gKwkJdGFpbHJvb20gPSB0cnVlc2l6ZSAtIGxl
bjsKPiArCX0KPgo+ICAgCWxlbiAtPSBoZHJfbGVuOwo+ICAgCW9mZnNldCArPSBoZHJfcGFkZGVk
X2xlbjsKPiAgIAlwICs9IGhkcl9wYWRkZWRfbGVuOwo+Cj4gKwlzaGluZm9fc2l6ZSA9IFNLQl9E
QVRBX0FMSUdOKHNpemVvZihzdHJ1Y3Qgc2tiX3NoYXJlZF9pbmZvKSk7Cj4gKwo+ICsJaWYgKGxl
biA+IEdPT0RfQ09QWV9MRU4gJiYgdGFpbHJvb20gPj0gc2hpbmZvX3NpemUpIHsKCgpBbnkgcmVh
c29uIHRoYXQgeW91IGRvbid0IHVzZSBidWlsZF9za2IoKSBmb3IgbGVuIDwgR09PRF9DT1BZX0xF
Tj8KCk90aGVyIGxvb2tzIGdvb2QuCgpUaGFua3MKCgo+ICsJCXNrYiA9IGJ1aWxkX3NrYihwLCB0
cnVlc2l6ZSk7Cj4gKwkJaWYgKHVubGlrZWx5KCFza2IpKQo+ICsJCQlyZXR1cm4gTlVMTDsKPiAr
Cj4gKwkJc2tiX3B1dChza2IsIGxlbik7Cj4gKwkJZ290byBvazsKPiArCX0KPiArCj4gKwkvKiBj
b3B5IHNtYWxsIHBhY2tldCBzbyB3ZSBjYW4gcmV1c2UgdGhlc2UgcGFnZXMgZm9yIHNtYWxsIGRh
dGEgKi8KPiArCXNrYiA9IG5hcGlfYWxsb2Nfc2tiKCZycS0+bmFwaSwgR09PRF9DT1BZX0xFTik7
Cj4gKwlpZiAodW5saWtlbHkoIXNrYikpCj4gKwkJcmV0dXJuIE5VTEw7Cj4gKwo+ICAgCS8qIENv
cHkgYWxsIGZyYW1lIGlmIGl0IGZpdHMgc2tiLT5oZWFkLCBvdGhlcndpc2UKPiAgIAkgKiB3ZSBs
ZXQgdmlydGlvX25ldF9oZHJfdG9fc2tiKCkgYW5kIEdSTyBwdWxsIGhlYWRlcnMgYXMgbmVlZGVk
Lgo+ICAgCSAqLwo+IEBAIC00MTgsMTEgKzQzOCw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAq
cGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJCWNvcHkgPSBFVEhfSExF
TiArIG1ldGFzaXplOwo+ICAgCXNrYl9wdXRfZGF0YShza2IsIHAsIGNvcHkpOwo+Cj4gLQlpZiAo
bWV0YXNpemUpIHsKPiAtCQlfX3NrYl9wdWxsKHNrYiwgbWV0YXNpemUpOwo+IC0JCXNrYl9tZXRh
ZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7Cj4gLQl9Cj4gLQo+ICAgCWxlbiAtPSBjb3B5Owo+ICAg
CW9mZnNldCArPSBjb3B5Owo+Cj4gQEAgLTQzMSw3ICs0NDYsNyBAQCBzdGF0aWMgc3RydWN0IHNr
X2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgCQkJc2tiX2Fk
ZF9yeF9mcmFnKHNrYiwgMCwgcGFnZSwgb2Zmc2V0LCBsZW4sIHRydWVzaXplKTsKPiAgIAkJZWxz
ZQo+ICAgCQkJcHV0X3BhZ2UocGFnZSk7Cj4gLQkJcmV0dXJuIHNrYjsKPiArCQlnb3RvIG9rOwo+
ICAgCX0KPgo+ICAgCS8qCj4gQEAgLTQ1OCw2ICs0NzMsMTggQEAgc3RhdGljIHN0cnVjdCBza19i
dWZmICpwYWdlX3RvX3NrYihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgIAlpZiAocGFnZSkK
PiAgIAkJZ2l2ZV9wYWdlcyhycSwgcGFnZSk7Cj4KPiArb2s6Cj4gKwkvKiBoZHJfdmFsaWQgbWVh
bnMgbm8gWERQLCBzbyB3ZSBjYW4gY29weSB0aGUgdm5ldCBoZWFkZXIgKi8KPiArCWlmIChoZHJf
dmFsaWQpIHsKPiArCQloZHIgPSBza2Jfdm5ldF9oZHIoc2tiKTsKPiArCQltZW1jcHkoaGRyLCBo
ZHJfcCwgaGRyX2xlbik7Cj4gKwl9Cj4gKwo+ICsJaWYgKG1ldGFzaXplKSB7Cj4gKwkJX19za2Jf
cHVsbChza2IsIG1ldGFzaXplKTsKPiArCQlza2JfbWV0YWRhdGFfc2V0KHNrYiwgbWV0YXNpemUp
Owo+ICsJfQo+ICsKPiAgIAlyZXR1cm4gc2tiOwo+ICAgfQo+Cj4gQEAgLTgwOCw3ICs4MzUsNyBA
QCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfYmlnKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYsCj4gICB7Cj4gICAJc3RydWN0IHBhZ2UgKnBhZ2UgPSBidWY7Cj4gICAJc3RydWN0IHNrX2J1
ZmYgKnNrYiA9Cj4gLQkJcGFnZV90b19za2IodmksIHJxLCBwYWdlLCAwLCBsZW4sIFBBR0VfU0la
RSwgdHJ1ZSwgMCk7Cj4gKwkJcGFnZV90b19za2IodmksIHJxLCBwYWdlLCAwLCBsZW4sIFBBR0Vf
U0laRSwgdHJ1ZSwgMCwgMCk7Cj4KPiAgIAlzdGF0cy0+Ynl0ZXMgKz0gbGVuIC0gdmktPmhkcl9s
ZW47Cj4gICAJaWYgKHVubGlrZWx5KCFza2IpKQo+IEBAIC05MjIsNyArOTQ5LDcgQEAgc3RhdGlj
IHN0cnVjdCBza19idWZmICpyZWNlaXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LAo+ICAgCQkJCXB1dF9wYWdlKHBhZ2UpOwo+ICAgCQkJCWhlYWRfc2tiID0gcGFnZV90b19za2Io
dmksIHJxLCB4ZHBfcGFnZSwgb2Zmc2V0LAo+ICAgCQkJCQkJICAgICAgIGxlbiwgUEFHRV9TSVpF
LCBmYWxzZSwKPiAtCQkJCQkJICAgICAgIG1ldGFzaXplKTsKPiArCQkJCQkJICAgICAgIG1ldGFz
aXplLCBoZWFkcm9vbSk7Cj4gICAJCQkJcmV0dXJuIGhlYWRfc2tiOwo+ICAgCQkJfQo+ICAgCQkJ
YnJlYWs7Cj4gQEAgLTk4MCw3ICsxMDA3LDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNl
aXZlX21lcmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ICAgCX0KPgo+ICAgCWhlYWRf
c2tiID0gcGFnZV90b19za2IodmksIHJxLCBwYWdlLCBvZmZzZXQsIGxlbiwgdHJ1ZXNpemUsICF4
ZHBfcHJvZywKPiAtCQkJICAgICAgIG1ldGFzaXplKTsKPiArCQkJICAgICAgIG1ldGFzaXplLCBo
ZWFkcm9vbSk7Cj4gICAJY3Vycl9za2IgPSBoZWFkX3NrYjsKPgo+ICAgCWlmICh1bmxpa2VseSgh
Y3Vycl9za2IpKQo+IC0tCj4gMi4zMS4wCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
