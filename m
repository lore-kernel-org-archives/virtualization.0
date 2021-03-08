Return-Path: <SRS0=agY8=IG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48065C433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:41:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B68D65163
	for <virtualization@archiver.kernel.org>; Mon,  8 Mar 2021 03:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B68D65163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 584044E578;
	Mon,  8 Mar 2021 03:41:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fAeLvjj-t-QS; Mon,  8 Mar 2021 03:41:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F0634E456;
	Mon,  8 Mar 2021 03:41:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40BFFC000B;
	Mon,  8 Mar 2021 03:41:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 561C4C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:41:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 36C584E456
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:41:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vZKd7jYiaesj
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:41:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EAE774E4BC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Mar 2021 03:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615174880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjCP294mtRHCqRtSfc55b0b9ungG9VqmZ6pLnI2D/fY=;
 b=Vc8f9CtO7FqUZUIGxSzKTatrmYaLUpV6nAT/0dHt6Xg0vRbSE9w16BHjVy4BwwAkMCnaku
 6HBSU8eJUh7YtOvc0VdU7ugNDt5ej1D06dJvWQxkXamHr2Xe6mdkp6CT1Eh1VQp1F49+I/
 3/cW2M8XcUyowf7dFHNChVa6lv3GBBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-3_yvO8sgODe-FYRZ3MLQ4w-1; Sun, 07 Mar 2021 22:41:16 -0500
X-MC-Unique: 3_yvO8sgODe-FYRZ3MLQ4w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13BDA18D6A2E;
 Mon,  8 Mar 2021 03:41:14 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-193.pek2.redhat.com
 [10.72.13.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE7FC5D9D3;
 Mon,  8 Mar 2021 03:41:04 +0000 (UTC)
Subject: Re: [PATCH v6 net-next] virtio-net: support XDP when not more queues
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <1614940150-38458-1-git-send-email-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2e7bd8ac-9ac2-6668-2061-c94e57173223@redhat.com>
Date: Mon, 8 Mar 2021 11:41:03 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1614940150-38458-1-git-send-email-xuanzhuo@linux.alibaba.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Ck9uIDIwMjEvMy81IDY6Mjkg5LiL5Y2ILCBYdWFuIFpodW8gd3JvdGU6Cj4gVGhlIG51bWJlciBv
ZiBxdWV1ZXMgaW1wbGVtZW50ZWQgYnkgbWFueSB2aXJ0aW8gYmFja2VuZHMgaXMgbGltaXRlZCwK
PiBlc3BlY2lhbGx5IHNvbWUgbWFjaGluZXMgaGF2ZSBhIGxhcmdlIG51bWJlciBvZiBDUFVzLiBJ
biB0aGlzIGNhc2UsIGl0Cj4gaXMgb2Z0ZW4gaW1wb3NzaWJsZSB0byBhbGxvY2F0ZSBhIHNlcGFy
YXRlIHF1ZXVlIGZvcgo+IFhEUF9UWC9YRFBfUkVESVJFQ1QsIHRoZW4geGRwIGNhbm5vdCBiZSBs
b2FkZWQgdG8gd29yaywgZXZlbiB4ZHAgZG9lcwo+IG5vdCB1c2UgdGhlIFhEUF9UWC9YRFBfUkVE
SVJFQ1QuCj4KPiBUaGlzIHBhdGNoIGFsbG93cyBYRFBfVFgvWERQX1JFRElSRUNUIHRvIHJ1biBi
eSByZXVzZSB0aGUgZXhpc3RpbmcgU1EKPiB3aXRoIF9fbmV0aWZfdHhfbG9jaygpIGhvbGQgd2hl
biB0aGVyZSBhcmUgbm90IGVub3VnaCBxdWV1ZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpo
dW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IFJldmlld2VkLWJ5OiBEdXN0IExpIDxk
dXN0LmxpQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+IHY2OiAxLiB1c2UgX19uZXRpZl90eF9h
Y3F1aXJlKCkvX19uZXRpZl90eF9yZWxlYXNlKCkuIChzdWdnZXN0ZWQgYnkgSmFzb24gV2FuZykK
PiAgICAgIDIuIGFkZCBub3RlIGZvciB3aHkgbm90IGxvY2suIChzdWdnZXN0ZWQgYnkgSmFzb24g
V2FuZykKPiAgICAgIDMuIFVzZSB2YXJpYWJsZSAnZmxhZycgdG8gcmVjb3JkIHdpdGggb3Igd2l0
aG91dCBsb2NrZWQuICBJdCBpcyBub3Qgc2FmZSB0bwo+ICAgICAgICAgdXNlIGN1cnJfcXVldWVf
cGFpcnMgaW4gInZpcnRuZXRfcHV0X3hkcF9zcSIsIGJlY2F1c2UgaXQgbWF5IGNoYW5nZWQgYWZ0
ZXIKPiAgICAgICAgICJ2aXJ0bmV0X2dldF94ZHBfc3EiLgo+Cj4gdjU6IGNoYW5nZSBzdWJqZWN0
IGZyb20gJ3N1cHBvcnQgWERQX1RYIHdoZW4gbm90IG1vcmUgcXVldWVzJwo+Cj4gdjQ6IG1ha2Ug
c3BhcnNlIGhhcHB5Cj4gICAgICBzdWdnZXN0ZWQgYnkgSmFrdWIgS2ljaW5za2kKPgo+IHYzOiBh
ZGQgd2FybmluZyB3aGVuIG5vIG1vcmUgcXVldWVzCj4gICAgICBzdWdnZXN0ZWQgYnkgSmVzcGVy
IERhbmdhYXJkIEJyb3Vlcgo+Cj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA2MyArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA1MyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBp
bmRleCBiYThlNjM3Li5mOWUwMjRkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0xOTUsNiArMTk1LDkg
QEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4gICAJLyogIyBvZiBYRFAgcXVldWUgcGFpcnMgY3Vy
cmVudGx5IHVzZWQgYnkgdGhlIGRyaXZlciAqLwo+ICAgCXUxNiB4ZHBfcXVldWVfcGFpcnM7Cj4K
PiArCS8qIHhkcF9xdWV1ZV9wYWlycyBtYXkgYmUgMCwgd2hlbiB4ZHAgaXMgYWxyZWFkeSBsb2Fk
ZWQuIFNvIGFkZCB0aGlzLiAqLwo+ICsJYm9vbCB4ZHBfZW5hYmxlZDsKPiArCj4gICAJLyogSSBs
aWtlLi4uIGJpZyBwYWNrZXRzIGFuZCBJIGNhbm5vdCBsaWUhICovCj4gICAJYm9vbCBiaWdfcGFj
a2V0czsKPgo+IEBAIC00ODEsMTQgKzQ4NCw0OCBAQCBzdGF0aWMgaW50IF9fdmlydG5ldF94ZHBf
eG1pdF9vbmUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAJcmV0dXJuIDA7Cj4gICB9Cj4K
PiAtc3RhdGljIHN0cnVjdCBzZW5kX3F1ZXVlICp2aXJ0bmV0X3hkcF9zcShzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aSkKPiArc3RhdGljIHN0cnVjdCBzZW5kX3F1ZXVlICp2aXJ0bmV0X2dldF94ZHBf
c3Eoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksIGludCAqZmxhZykKPiArCV9fYWNxdWlyZXModHhx
LT5feG1pdF9sb2NrKQo+ICAgewo+ICsJc3RydWN0IG5ldGRldl9xdWV1ZSAqdHhxOwo+ICAgCXVu
c2lnbmVkIGludCBxcDsKPgo+IC0JcXAgPSB2aS0+Y3Vycl9xdWV1ZV9wYWlycyAtIHZpLT54ZHBf
cXVldWVfcGFpcnMgKyBzbXBfcHJvY2Vzc29yX2lkKCk7Cj4gKwlpZiAodmktPmN1cnJfcXVldWVf
cGFpcnMgPiBucl9jcHVfaWRzKSB7Cj4gKwkJcXAgPSB2aS0+Y3Vycl9xdWV1ZV9wYWlycyAtIHZp
LT54ZHBfcXVldWVfcGFpcnMgKyBzbXBfcHJvY2Vzc29yX2lkKCk7Cj4gKwkJdHhxID0gbmV0ZGV2
X2dldF90eF9xdWV1ZSh2aS0+ZGV2LCBxcCk7Cj4gKwo+ICsJCS8qIEluIHRoaXMgY2FzZSwgdGhp
cyB0eHEgaXMgb25seSB1c2VkIGZvciB4ZHAgdHggb24gdGhlIGN1cnJlbnQKPiArCQkgKiBjcHUs
IHNvIGl0IGRvZXMgbm90IG5lZWQgdG8gYmUgbG9ja2VkLgo+ICsJCSAqIF9fbmV0aWZfdHhfYWNx
dWlyZSBpcyBmb3Igc3BhcnNlLgo+ICsJCSAqLwo+ICsJCV9fbmV0aWZfdHhfYWNxdWlyZSh0eHEp
Owo+ICsJCSpmbGFnID0gZmFsc2U7Cj4gKwl9IGVsc2Ugewo+ICsJCXFwID0gc21wX3Byb2Nlc3Nv
cl9pZCgpICUgdmktPmN1cnJfcXVldWVfcGFpcnM7Cj4gKwkJdHhxID0gbmV0ZGV2X2dldF90eF9x
dWV1ZSh2aS0+ZGV2LCBxcCk7Cj4gKwkJX19uZXRpZl90eF9sb2NrKHR4cSwgcmF3X3NtcF/GknBy
b2Nlc3Nvcl9pZCgpKTsKPiArCQkqZmxhZyA9IHRydWU7Cj4gKwl9Cj4gKwo+ICAgCXJldHVybiAm
dmktPnNxW3FwXTsKCgpUd28gcXVlc3Rpb25zOgoKMSkgQ2FuIHdlIHNpbXBseSBjaGVjayB4ZHBf
cXVldWVfcGFyaXMgYWdhaW5zdCAwIHRoZW4gd2UgZG9uJ3QgbmVlZCBmbGFnPwoyKSBDYW4gd2Ug
cGFzcyB0eHEgdG8gdmlydG5ldF9nZXRfeGRwX3NxKCkgdGhlbiB0aGUgYW5ub3RhdGlvbiBsb29r
cyAKZXZlbiBtb3JlIGJldHRlcj8KClRoYW5rcwoKCj4gICB9Cj4KPiArc3RhdGljIHZvaWQgdmly
dG5ldF9wdXRfeGRwX3NxKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLCBzdHJ1Y3Qgc2VuZF9xdWV1
ZSAqc3EsCj4gKwkJCSAgICAgICBpbnQgZmxhZykKPiArCV9fcmVsZWFzZXModHhxLT5feG1pdF9s
b2NrKQo+ICt7Cj4gKwlzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7Cj4gKwl1bnNpZ25lZCBpbnQg
cXA7Cj4gKwo+ICsJcXAgPSBzcSAtIHZpLT5zcTsKPiArCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVl
dWUodmktPmRldiwgcXApOwo+ICsKPiArCWlmIChmbGFnKQo+ICsJCV9fbmV0aWZfdHhfdW5sb2Nr
KHR4cSk7Cj4gKwllbHNlCj4gKwkJX19uZXRpZl90eF9yZWxlYXNlKHR4cSk7Cj4gK30KPiArCj4g
ICBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAg
IAkJCSAgICBpbnQgbiwgc3RydWN0IHhkcF9mcmFtZSAqKmZyYW1lcywgdTMyIGZsYWdzKQo+ICAg
ewo+IEBAIC00OTYsMTIgKzUzMywxMiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3htaXQoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAlzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEgPSB2aS0+
cnE7Cj4gICAJc3RydWN0IGJwZl9wcm9nICp4ZHBfcHJvZzsKPiAgIAlzdHJ1Y3Qgc2VuZF9xdWV1
ZSAqc3E7Cj4gKwlpbnQgcmV0LCBlcnIsIHNxX2ZsYWc7Cj4gICAJdW5zaWduZWQgaW50IGxlbjsK
PiAgIAlpbnQgcGFja2V0cyA9IDA7Cj4gICAJaW50IGJ5dGVzID0gMDsKPiAgIAlpbnQgZHJvcHMg
PSAwOwo+ICAgCWludCBraWNrcyA9IDA7Cj4gLQlpbnQgcmV0LCBlcnI7Cj4gICAJdm9pZCAqcHRy
Owo+ICAgCWludCBpOwo+Cj4gQEAgLTUxMiw3ICs1NDksNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRf
eGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAlpZiAoIXhkcF9wcm9nKQo+ICAg
CQlyZXR1cm4gLUVOWElPOwo+Cj4gLQlzcSA9IHZpcnRuZXRfeGRwX3NxKHZpKTsKPiArCXNxID0g
dmlydG5ldF9nZXRfeGRwX3NxKHZpLCAmc3FfZmxhZyk7Cj4KPiAgIAlpZiAodW5saWtlbHkoZmxh
Z3MgJiB+WERQX1hNSVRfRkxBR1NfTUFTSykpIHsKPiAgIAkJcmV0ID0gLUVJTlZBTDsKPiBAQCAt
NTYwLDEyICs1OTcsMTMgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRf
ZGV2aWNlICpkZXYsCj4gICAJc3EtPnN0YXRzLmtpY2tzICs9IGtpY2tzOwo+ICAgCXU2NF9zdGF0
c191cGRhdGVfZW5kKCZzcS0+c3RhdHMuc3luY3ApOwo+Cj4gKwl2aXJ0bmV0X3B1dF94ZHBfc3Eo
dmksIHNxLCBzcV9mbGFnKTsKPiAgIAlyZXR1cm4gcmV0Owo+ICAgfQo+Cj4gICBzdGF0aWMgdW5z
aWduZWQgaW50IHZpcnRuZXRfZ2V0X2hlYWRyb29tKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpKQo+
ICAgewo+IC0JcmV0dXJuIHZpLT54ZHBfcXVldWVfcGFpcnMgPyBWSVJUSU9fWERQX0hFQURST09N
IDogMDsKPiArCXJldHVybiB2aS0+eGRwX2VuYWJsZWQgPyBWSVJUSU9fWERQX0hFQURST09NIDog
MDsKPiAgIH0KPgo+ICAgLyogV2UgY29weSB0aGUgcGFja2V0IGZvciBYRFAgaW4gdGhlIGZvbGxv
d2luZyBjYXNlczoKPiBAQCAtMTQ1NywxMiArMTQ5NSwxNSBAQCBzdGF0aWMgaW50IHZpcnRuZXRf
cG9sbChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRnZXQpCj4gICAJCXhkcF9kb19m
bHVzaCgpOwo+Cj4gICAJaWYgKHhkcF94bWl0ICYgVklSVElPX1hEUF9UWCkgewo+IC0JCXNxID0g
dmlydG5ldF94ZHBfc3EodmkpOwo+ICsJCWludCBzcV9mbGFnOwo+ICsKPiArCQlzcSA9IHZpcnRu
ZXRfZ2V0X3hkcF9zcSh2aSwgJnNxX2ZsYWcpOwo+ICAgCQlpZiAodmlydHF1ZXVlX2tpY2tfcHJl
cGFyZShzcS0+dnEpICYmIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkgewo+ICAgCQkJdTY0X3N0
YXRzX3VwZGF0ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNwKTsKPiAgIAkJCXNxLT5zdGF0cy5raWNr
cysrOwo+ICAgCQkJdTY0X3N0YXRzX3VwZGF0ZV9lbmQoJnNxLT5zdGF0cy5zeW5jcCk7Cj4gICAJ
CX0KPiArCQl2aXJ0bmV0X3B1dF94ZHBfc3EodmksIHNxLCBzcV9mbGFnKTsKPiAgIAl9Cj4KPiAg
IAlyZXR1cm4gcmVjZWl2ZWQ7Cj4gQEAgLTI0MTcsMTAgKzI0NTgsOSBAQCBzdGF0aWMgaW50IHZp
cnRuZXRfeGRwX3NldChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBzdHJ1Y3QgYnBmX3Byb2cgKnBy
b2csCj4KPiAgIAkvKiBYRFAgcmVxdWlyZXMgZXh0cmEgcXVldWVzIGZvciBYRFBfVFggKi8KPiAg
IAlpZiAoY3Vycl9xcCArIHhkcF9xcCA+IHZpLT5tYXhfcXVldWVfcGFpcnMpIHsKPiAtCQlOTF9T
RVRfRVJSX01TR19NT0QoZXh0YWNrLCAiVG9vIGZldyBmcmVlIFRYIHJpbmdzIGF2YWlsYWJsZSIp
Owo+IC0JCW5ldGRldl93YXJuKGRldiwgInJlcXVlc3QgJWkgcXVldWVzIGJ1dCBtYXggaXMgJWlc
biIsCj4gKwkJbmV0ZGV2X3dhcm4oZGV2LCAiWERQIHJlcXVlc3QgJWkgcXVldWVzIGJ1dCBtYXgg
aXMgJWkuIFhEUF9UWCBhbmQgWERQX1JFRElSRUNUIHdpbGwgb3BlcmF0ZSBpbiBhIHNsb3dlciBs
b2NrZWQgdHggbW9kZS5cbiIsCj4gICAJCQkgICAgY3Vycl9xcCArIHhkcF9xcCwgdmktPm1heF9x
dWV1ZV9wYWlycyk7Cj4gLQkJcmV0dXJuIC1FTk9NRU07Cj4gKwkJeGRwX3FwID0gMDsKPiAgIAl9
Cj4KPiAgIAlvbGRfcHJvZyA9IHJ0bmxfZGVyZWZlcmVuY2UodmktPnJxWzBdLnhkcF9wcm9nKTsK
PiBAQCAtMjQ1NCwxMSArMjQ5NCwxNCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3NldChzdHJ1
Y3QgbmV0X2RldmljZSAqZGV2LCBzdHJ1Y3QgYnBmX3Byb2cgKnByb2csCj4gICAJdmktPnhkcF9x
dWV1ZV9wYWlycyA9IHhkcF9xcDsKPgo+ICAgCWlmIChwcm9nKSB7Cj4gKwkJdmktPnhkcF9lbmFi
bGVkID0gdHJ1ZTsKPiAgIAkJZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7IGkr
Kykgewo+ICAgCQkJcmN1X2Fzc2lnbl9wb2ludGVyKHZpLT5ycVtpXS54ZHBfcHJvZywgcHJvZyk7
Cj4gICAJCQlpZiAoaSA9PSAwICYmICFvbGRfcHJvZykKPiAgIAkJCQl2aXJ0bmV0X2NsZWFyX2d1
ZXN0X29mZmxvYWRzKHZpKTsKPiAgIAkJfQo+ICsJfSBlbHNlIHsKPiArCQl2aS0+eGRwX2VuYWJs
ZWQgPSBmYWxzZTsKPiAgIAl9Cj4KPiAgIAlmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9w
YWlyczsgaSsrKSB7Cj4gQEAgLTI1MjYsNyArMjU2OSw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9z
ZXRfZmVhdHVyZXMoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAlpbnQgZXJyOwo+Cj4gICAJ
aWYgKChkZXYtPmZlYXR1cmVzIF4gZmVhdHVyZXMpICYgTkVUSUZfRl9MUk8pIHsKPiAtCQlpZiAo
dmktPnhkcF9xdWV1ZV9wYWlycykKPiArCQlpZiAodmktPnhkcF9lbmFibGVkKQo+ICAgCQkJcmV0
dXJuIC1FQlVTWTsKPgo+ICAgCQlpZiAoZmVhdHVyZXMgJiBORVRJRl9GX0xSTykKPiAtLQo+IDEu
OC4zLjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
