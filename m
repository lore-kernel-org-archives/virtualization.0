Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64348C433B4
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 09:38:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF66961249
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 09:38:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF66961249
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 70AE040168;
	Wed, 14 Apr 2021 09:38:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oU4uNQ5IwEUk; Wed, 14 Apr 2021 09:37:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 04A6D4013E;
	Wed, 14 Apr 2021 09:37:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3FF0C000C;
	Wed, 14 Apr 2021 09:37:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 064F0C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 09:37:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D2F2E40F2E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 09:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BznTmUOUHonR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 09:37:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A53AB40F02
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 09:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618393075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31nI9rEM3AksD9/z0IQbYLKi4TSPs5CKGKrvk7XFaw0=;
 b=GSPvfo/304ohDsp43X4A5AOALt2QUwGN4oMaQMb3smpKmbYSApXrCZFY9NjgtHVpluLkmy
 pDiTtjVvy+TB7XlkYlMbZGqdIbVKtRCpWewrbTKoTR/P4U0Xn129TbVqyS84gGrjZ3/utD
 qyxXPNsDa/NR8ARvnySOeJ5UTZf/ozw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-vXNknX-HOLSmBsd9ZJVxZA-1; Wed, 14 Apr 2021 05:37:53 -0400
X-MC-Unique: vXNknX-HOLSmBsd9ZJVxZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35F0F83DD20;
 Wed, 14 Apr 2021 09:37:52 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-33.pek2.redhat.com
 [10.72.13.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AD1C5D9D0;
 Wed, 14 Apr 2021 09:37:46 +0000 (UTC)
Subject: Re: [PATCH net-next v2] virtio-net: page_to_skb() use build_skb when
 there's sufficient tailroom
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210414015221.87554-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4c049eea-e00e-0c5f-9b52-95925a178dd1@redhat.com>
Date: Wed, 14 Apr 2021 17:37:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414015221.87554-1-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

CuWcqCAyMDIxLzQvMTQg5LiK5Y2IOTo1MiwgWHVhbiBaaHVvIOWGmemBkzoKPiBJbiBwYWdlX3Rv
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
cnhwY2svcwo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGli
YWJhLmNvbT4KPiBTdWdnZXN0ZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
Cj4gLS0tCj4KPiB2MjogY29uZmxpY3QgcmVzb2x1dGlvbgo+Cj4gICBkcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMgfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gaW5kZXggMTAxNjU5Y2Q0Yjg3Li5kNzE0MmI1MDhiZDAgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gQEAgLTM4MywxNyArMzgzLDExIEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19z
a2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICB7Cj4gICAJc3RydWN0IHNrX2J1ZmYgKnNr
YjsKPiAgIAlzdHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVmICpoZHI7Cj4gLQl1bnNpZ25l
ZCBpbnQgY29weSwgaGRyX2xlbiwgaGRyX3BhZGRlZF9sZW47Cj4gLQljaGFyICpwOwo+ICsJdW5z
aWduZWQgaW50IGNvcHksIGhkcl9sZW4sIGhkcl9wYWRkZWRfbGVuLCB0YWlscm9vbSwgc2hpbmZv
X3NpemU7Cj4gKwljaGFyICpwLCAqaGRyX3A7Cj4KPiAgIAlwID0gcGFnZV9hZGRyZXNzKHBhZ2Up
ICsgb2Zmc2V0Owo+IC0KPiAtCS8qIGNvcHkgc21hbGwgcGFja2V0IHNvIHdlIGNhbiByZXVzZSB0
aGVzZSBwYWdlcyBmb3Igc21hbGwgZGF0YSAqLwo+IC0Jc2tiID0gbmFwaV9hbGxvY19za2IoJnJx
LT5uYXBpLCBHT09EX0NPUFlfTEVOKTsKPiAtCWlmICh1bmxpa2VseSghc2tiKSkKPiAtCQlyZXR1
cm4gTlVMTDsKPiAtCj4gLQloZHIgPSBza2Jfdm5ldF9oZHIoc2tiKTsKPiArCWhkcl9wID0gcDsK
Pgo+ICAgCWhkcl9sZW4gPSB2aS0+aGRyX2xlbjsKPiAgIAlpZiAodmktPm1lcmdlYWJsZV9yeF9i
dWZzKQo+IEBAIC00MDEsMTQgKzM5NSwyOCBAQCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnBhZ2Vf
dG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgCWVsc2UKPiAgIAkJaGRyX3BhZGRl
ZF9sZW4gPSBzaXplb2Yoc3RydWN0IHBhZGRlZF92bmV0X2hkcik7Cj4KPiAtCS8qIGhkcl92YWxp
ZCBtZWFucyBubyBYRFAsIHNvIHdlIGNhbiBjb3B5IHRoZSB2bmV0IGhlYWRlciAqLwo+IC0JaWYg
KGhkcl92YWxpZCkKPiAtCQltZW1jcHkoaGRyLCBwLCBoZHJfbGVuKTsKPiArCXRhaWxyb29tID0g
dHJ1ZXNpemUgLSBsZW47CgoKVGhlIG1hdGggbG9va3Mgbm90IGNvcnJlY3QgaW4gdGhlIGNhc2Ug
b2YgWERQLiBTaW5jZSB0aGUgZUJQRiBwZ29yYW0gY2FuIApjaG9vc2UgdG8gYWRqdXN0IHRoZSBo
ZWFkZXIgYW5kIGluc2VydCBtZXRhIHdoaWNoIHdpbGwgY2F1c2UgdGhlIAp0cnVlc2l6ZSBpcyBs
ZXNzIHRoYW4gbGVuLgoKTm90ZSB0aGF0IGluIHRoZSBjYXNlIG9mIFhEUCwgd2UgYWx3YXlzIHJl
c2VydmUgc3VmZmljaWVudCB0YWlscm9vbSBmb3IgCnNoaW5mbywgc2VlIGFkZF9yZWN2YnVmX21l
cmdlYWJsZSgpOgoKIMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCB0YWlscm9vbSA9IGhlYWRy
b29tID8gc2l6ZW9mKHN0cnVjdCAKc2tiX3NoYXJlZF9pbmZvKSA6IDA7CgpUaGFua3MKCgo+Cj4g
ICAJbGVuIC09IGhkcl9sZW47Cj4gICAJb2Zmc2V0ICs9IGhkcl9wYWRkZWRfbGVuOwo+ICAgCXAg
Kz0gaGRyX3BhZGRlZF9sZW47Cj4KPiArCXNoaW5mb19zaXplID0gU0tCX0RBVEFfQUxJR04oc2l6
ZW9mKHN0cnVjdCBza2Jfc2hhcmVkX2luZm8pKTsKPiArCj4gKwlpZiAobGVuID4gR09PRF9DT1BZ
X0xFTiAmJiB0YWlscm9vbSA+PSBzaGluZm9fc2l6ZSkgewo+ICsJCXNrYiA9IGJ1aWxkX3NrYihw
LCB0cnVlc2l6ZSk7Cj4gKwkJaWYgKHVubGlrZWx5KCFza2IpKQo+ICsJCQlyZXR1cm4gTlVMTDsK
PiArCj4gKwkJc2tiX3B1dChza2IsIGxlbik7Cj4gKwkJZ290byBvazsKPiArCX0KPiArCj4gKwkv
KiBjb3B5IHNtYWxsIHBhY2tldCBzbyB3ZSBjYW4gcmV1c2UgdGhlc2UgcGFnZXMgZm9yIHNtYWxs
IGRhdGEgKi8KPiArCXNrYiA9IG5hcGlfYWxsb2Nfc2tiKCZycS0+bmFwaSwgR09PRF9DT1BZX0xF
Tik7Cj4gKwlpZiAodW5saWtlbHkoIXNrYikpCj4gKwkJcmV0dXJuIE5VTEw7Cj4gKwo+ICAgCS8q
IENvcHkgYWxsIGZyYW1lIGlmIGl0IGZpdHMgc2tiLT5oZWFkLCBvdGhlcndpc2UKPiAgIAkgKiB3
ZSBsZXQgdmlydGlvX25ldF9oZHJfdG9fc2tiKCkgYW5kIEdSTyBwdWxsIGhlYWRlcnMgYXMgbmVl
ZGVkLgo+ICAgCSAqLwo+IEBAIC00MTgsMTEgKzQyNiw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVm
ZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJCWNvcHkgPSBFVEhf
SExFTiArIG1ldGFzaXplOwo+ICAgCXNrYl9wdXRfZGF0YShza2IsIHAsIGNvcHkpOwo+Cj4gLQlp
ZiAobWV0YXNpemUpIHsKPiAtCQlfX3NrYl9wdWxsKHNrYiwgbWV0YXNpemUpOwo+IC0JCXNrYl9t
ZXRhZGF0YV9zZXQoc2tiLCBtZXRhc2l6ZSk7Cj4gLQl9Cj4gLQo+ICAgCWxlbiAtPSBjb3B5Owo+
ICAgCW9mZnNldCArPSBjb3B5Owo+Cj4gQEAgLTQzMSw3ICs0MzQsNyBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ICAgCQkJc2ti
X2FkZF9yeF9mcmFnKHNrYiwgMCwgcGFnZSwgb2Zmc2V0LCBsZW4sIHRydWVzaXplKTsKPiAgIAkJ
ZWxzZQo+ICAgCQkJcHV0X3BhZ2UocGFnZSk7Cj4gLQkJcmV0dXJuIHNrYjsKPiArCQlnb3RvIG9r
Owo+ICAgCX0KPgo+ICAgCS8qCj4gQEAgLTQ1OCw2ICs0NjEsMTggQEAgc3RhdGljIHN0cnVjdCBz
a19idWZmICpwYWdlX3RvX3NrYihzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiAgIAlpZiAocGFn
ZSkKPiAgIAkJZ2l2ZV9wYWdlcyhycSwgcGFnZSk7Cj4KPiArb2s6Cj4gKwkvKiBoZHJfdmFsaWQg
bWVhbnMgbm8gWERQLCBzbyB3ZSBjYW4gY29weSB0aGUgdm5ldCBoZWFkZXIgKi8KPiArCWlmICho
ZHJfdmFsaWQpIHsKPiArCQloZHIgPSBza2Jfdm5ldF9oZHIoc2tiKTsKPiArCQltZW1jcHkoaGRy
LCBoZHJfcCwgaGRyX2xlbik7Cj4gKwl9Cj4gKwo+ICsJaWYgKG1ldGFzaXplKSB7Cj4gKwkJX19z
a2JfcHVsbChza2IsIG1ldGFzaXplKTsKPiArCQlza2JfbWV0YWRhdGFfc2V0KHNrYiwgbWV0YXNp
emUpOwo+ICsJfQo+ICsKPiAgIAlyZXR1cm4gc2tiOwo+ICAgfQo+Cj4gLS0KPiAyLjMxLjAKPgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
