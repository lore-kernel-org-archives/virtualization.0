Return-Path: <SRS0=S6pE=IH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB743C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:47:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DDB76527C
	for <virtualization@archiver.kernel.org>; Tue,  9 Mar 2021 02:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DDB76527C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B4BE4B398;
	Tue,  9 Mar 2021 02:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Bo_bDaZcqLo; Tue,  9 Mar 2021 02:47:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 26F3749ED5;
	Tue,  9 Mar 2021 02:47:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EC534C000B;
	Tue,  9 Mar 2021 02:47:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E449C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:47:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 302D36F59B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:47:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Mgz8XudiKVtN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:47:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CB7C4605CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Mar 2021 02:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615258061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yXxMXtBDnNA6kd3wQmWLnEiKXRyWhKVg+orPmmFoSwQ=;
 b=WmZS99o+645/Jy8AZ7r6ETGgXrS42AEfL16kxZ5OC01Vidhy9FiX6QdEexg1wmhyIA044v
 iasIKJKGoKUnx3/VhiYn7JoEOeecJUFnvhvIB17ku8M+Nt+eSkbvGD8QHogbhLNMa1JQd2
 YKqdFD9sIBP3TiZngURS/PCnYLbNb34=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-JKFitLOKOOuULmc2xzrRwA-1; Mon, 08 Mar 2021 21:47:37 -0500
X-MC-Unique: JKFitLOKOOuULmc2xzrRwA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A888326862;
 Tue,  9 Mar 2021 02:47:35 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-202.pek2.redhat.com
 [10.72.13.202])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD9F85D9CD;
 Tue,  9 Mar 2021 02:47:27 +0000 (UTC)
Subject: Re: [PATCH v7 net-next] virtio-net: support XDP when not more queues
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1615257107.0376601-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cff8d1b7-8267-75a0-cfef-5330a1442742@redhat.com>
Date: Tue, 9 Mar 2021 10:47:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615257107.0376601-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMy85IDEwOjMxIOS4iuWNiCwgWHVhbiBaaHVvIHdyb3RlOgo+IE9uIFR1ZSwgOSBN
YXIgMjAyMSAxMDoxNzoxNiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+IE9uIDIwMjEvMy84IDQ6NTIg5LiL5Y2ILCBYdWFuIFpodW8gd3JvdGU6Cj4+PiBU
aGUgbnVtYmVyIG9mIHF1ZXVlcyBpbXBsZW1lbnRlZCBieSBtYW55IHZpcnRpbyBiYWNrZW5kcyBp
cyBsaW1pdGVkLAo+Pj4gZXNwZWNpYWxseSBzb21lIG1hY2hpbmVzIGhhdmUgYSBsYXJnZSBudW1i
ZXIgb2YgQ1BVcy4gSW4gdGhpcyBjYXNlLCBpdAo+Pj4gaXMgb2Z0ZW4gaW1wb3NzaWJsZSB0byBh
bGxvY2F0ZSBhIHNlcGFyYXRlIHF1ZXVlIGZvcgo+Pj4gWERQX1RYL1hEUF9SRURJUkVDVCwgdGhl
biB4ZHAgY2Fubm90IGJlIGxvYWRlZCB0byB3b3JrLCBldmVuIHhkcCBkb2VzCj4+PiBub3QgdXNl
IHRoZSBYRFBfVFgvWERQX1JFRElSRUNULgo+Pj4KPj4+IFRoaXMgcGF0Y2ggYWxsb3dzIFhEUF9U
WC9YRFBfUkVESVJFQ1QgdG8gcnVuIGJ5IHJldXNlIHRoZSBleGlzdGluZyBTUQo+Pj4gd2l0aCBf
X25ldGlmX3R4X2xvY2soKSBob2xkIHdoZW4gdGhlcmUgYXJlIG5vdCBlbm91Z2ggcXVldWVzLgo+
Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+Cj4+PiBSZXZpZXdlZC1ieTogRHVzdCBMaSA8ZHVzdC5saUBsaW51eC5hbGliYWJhLmNvbT4K
Pj4+IC0tLQo+Pj4gdjc6IDEuIHVzZSBtYWNyb3MgdG8gaW1wbGVtZW50IGdldC9wdXQKPj4+ICAg
ICAgIDIuIHJlbW92ZSAnZmxhZycuIChzdWdnZXN0ZWQgYnkgSmFzb24gV2FuZykKPj4+Cj4+PiB2
NjogMS4gdXNlIF9fbmV0aWZfdHhfYWNxdWlyZSgpL19fbmV0aWZfdHhfcmVsZWFzZSgpLiAoc3Vn
Z2VzdGVkIGJ5IEphc29uIFdhbmcpCj4+PiAgICAgICAyLiBhZGQgbm90ZSBmb3Igd2h5IG5vdCBs
b2NrLiAoc3VnZ2VzdGVkIGJ5IEphc29uIFdhbmcpCj4+PiAgICAgICAzLiBVc2UgdmFyaWFibGUg
J2ZsYWcnIHRvIHJlY29yZCB3aXRoIG9yIHdpdGhvdXQgbG9ja2VkLiAgSXQgaXMgbm90IHNhZmUg
dG8KPj4+ICAgICAgICAgIHVzZSBjdXJyX3F1ZXVlX3BhaXJzIGluICJ2aXJ0bmV0X3B1dF94ZHBf
c3EiLCBiZWNhdXNlIGl0IG1heSBjaGFuZ2VkIGFmdGVyCj4+PiAgICAgICAgICAidmlydG5ldF9n
ZXRfeGRwX3NxIi4KPj4+Cj4+PiB2NTogY2hhbmdlIHN1YmplY3QgZnJvbSAnc3VwcG9ydCBYRFBf
VFggd2hlbiBub3QgbW9yZSBxdWV1ZXMnCj4+Pgo+Pj4gdjQ6IG1ha2Ugc3BhcnNlIGhhcHB5Cj4+
PiAgICAgICBzdWdnZXN0ZWQgYnkgSmFrdWIgS2ljaW5za2kKPj4+Cj4+PiB2MzogYWRkIHdhcm5p
bmcgd2hlbiBubyBtb3JlIHF1ZXVlcwo+Pj4gICAgICAgc3VnZ2VzdGVkIGJ5IEplc3BlciBEYW5n
YWFyZCBCcm91ZXIKPj4+Cj4+PiAgICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA1NSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0KPj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAxMyBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25l
dC5jCj4+PiBpbmRleCBiYThlNjM3Li41Y2U0MGVjIDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy9u
ZXQvdmlydGlvX25ldC5jCj4+PiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+IEBA
IC0xOTUsNiArMTk1LDkgQEAgc3RydWN0IHZpcnRuZXRfaW5mbyB7Cj4+PiAgICAJLyogIyBvZiBY
RFAgcXVldWUgcGFpcnMgY3VycmVudGx5IHVzZWQgYnkgdGhlIGRyaXZlciAqLwo+Pj4gICAgCXUx
NiB4ZHBfcXVldWVfcGFpcnM7Cj4+Pgo+Pj4gKwkvKiB4ZHBfcXVldWVfcGFpcnMgbWF5IGJlIDAs
IHdoZW4geGRwIGlzIGFscmVhZHkgbG9hZGVkLiBTbyBhZGQgdGhpcy4gKi8KPj4+ICsJYm9vbCB4
ZHBfZW5hYmxlZDsKPj4+ICsKPj4+ICAgIAkvKiBJIGxpa2UuLi4gYmlnIHBhY2tldHMgYW5kIEkg
Y2Fubm90IGxpZSEgKi8KPj4+ICAgIAlib29sIGJpZ19wYWNrZXRzOwo+Pj4KPj4+IEBAIC00ODEs
MTIgKzQ4NCwzNCBAQCBzdGF0aWMgaW50IF9fdmlydG5ldF94ZHBfeG1pdF9vbmUoc3RydWN0IHZp
cnRuZXRfaW5mbyAqdmksCj4+PiAgICAJcmV0dXJuIDA7Cj4+PiAgICB9Cj4+Pgo+Pj4gLXN0YXRp
YyBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqdmlydG5ldF94ZHBfc3Eoc3RydWN0IHZpcnRuZXRfaW5mbyAq
dmkpCj4+PiAtewo+Pj4gLQl1bnNpZ25lZCBpbnQgcXA7Cj4+PiAtCj4+PiAtCXFwID0gdmktPmN1
cnJfcXVldWVfcGFpcnMgLSB2aS0+eGRwX3F1ZXVlX3BhaXJzICsgc21wX3Byb2Nlc3Nvcl9pZCgp
Owo+Pj4gLQlyZXR1cm4gJnZpLT5zcVtxcF07Cj4+PiArLyogd2hlbiB2aS0+Y3Vycl9xdWV1ZV9w
YWlycyA+IG5yX2NwdV9pZHMsIHRoZSB0eHEvc3EgaXMgb25seSB1c2VkIGZvciB4ZHAgdHggb24K
Pj4+ICsgKiB0aGUgY3VycmVudCBjcHUsIHNvIGl0IGRvZXMgbm90IG5lZWQgdG8gYmUgbG9ja2Vk
Lgo+Pj4gKyAqLwo+Pj4gKyNkZWZpbmUgdmlydG5ldF94ZHBfZ2V0X3NxKHZpKSAoeyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+Pj4gKwlzdHJ1Y3QgbmV0ZGV2X3F1
ZXVlICp0eHE7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4+PiAr
CXR5cGVvZih2aSkgdiA9ICh2aSk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFwKPj4KPj4gQW55IHJlYXNvbiBmb3Igbm90IHVzaW5nIHZpIGRpcmVjdGx5Pwo+
Pgo+PiBPdGhlciBsb29rcyBnb29kLgo+Pgo+PiBUaGFua3MKPiBVc2luZyB2aSBkaXJlY3RseSwg
SSBnb3QgYW4gZXJyb3IgYnkgY2hlY2twYXRjaC5wbDoKPgo+IAlNYWNybyBhcmd1bWVudCByZXVz
ZSAndmknIC0gcG9zc2libGUgc2lkZS1lZmZlY3RzCj4KPiBtb3JlIGluZm86IGh0dHBzOi8vZ2Nj
LmdudS5vcmcvb25saW5lZG9jcy9jcHAvRHVwbGljYXRpb24tb2YtU2lkZS1FZmZlY3RzLmh0bWwK
Pgo+IFRoYW5rcy4KCgpPay4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKVGhhbmtzCgoKPgo+Pgo+Pj4gKwl1bnNpZ25lZCBpbnQgcXA7ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4+PiArCWlmICh2LT5jdXJyX3F1
ZXVlX3BhaXJzID4gbnJfY3B1X2lkcykgeyAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPj4+
ICsJCXFwID0gdi0+Y3Vycl9xdWV1ZV9wYWlycyAtIHYtPnhkcF9xdWV1ZV9wYWlyczsgICAgICAg
ICAgICBcCj4+PiArCQlxcCArPSBzbXBfcHJvY2Vzc29yX2lkKCk7ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgXAo+Pj4gKwkJdHhxID0gbmV0ZGV2X2dldF90eF9xdWV1ZSh2LT5kZXYs
IHFwKTsgICAgICAgICAgICAgICAgICAgIFwKPj4+ICsJCV9fbmV0aWZfdHhfYWNxdWlyZSh0eHEp
OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcCj4+PiArCX0gZWxzZSB7ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPj4+
ICsJCXFwID0gc21wX3Byb2Nlc3Nvcl9pZCgpICUgdi0+Y3Vycl9xdWV1ZV9wYWlyczsgICAgICAg
ICAgICBcCj4+PiArCQl0eHEgPSBuZXRkZXZfZ2V0X3R4X3F1ZXVlKHYtPmRldiwgcXApOyAgICAg
ICAgICAgICAgICAgICAgXAo+Pj4gKwkJX19uZXRpZl90eF9sb2NrKHR4cSwgcmF3X3NtcF9wcm9j
ZXNzb3JfaWQoKSk7ICAgICAgICAgICAgIFwKPj4+ICsJfSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+Pj4gKwl2LT5zcSAr
IHFwOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcCj4+PiArfSkKPj4+ICsKPj4+ICsjZGVmaW5lIHZpcnRuZXRfeGRwX3B1dF9zcSh2aSwgcSkg
eyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPj4+ICsJc3RydWN0IG5l
dGRldl9xdWV1ZSAqdHhxOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
XAo+Pj4gKwl0eXBlb2YodmkpIHYgPSAodmkpOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBcCj4+PiArCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVldWUodi0+ZGV2
LCAocSkgLSB2LT5zcSk7ICAgICAgICAgICAgICAgICAgIFwKPj4+ICsJaWYgKHYtPmN1cnJfcXVl
dWVfcGFpcnMgPiBucl9jcHVfaWRzKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXAo+Pj4g
KwkJX19uZXRpZl90eF9yZWxlYXNlKHR4cSk7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwKPj4+ICsJZWxzZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXAo+Pj4gKwkJX19uZXRpZl90eF91bmxvY2sodHhxKTsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwKPj4+ICAgIH0KPj4+Cj4+PiAgICBzdGF0
aWMgaW50IHZpcnRuZXRfeGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPj4+IEBAIC01
MTIsNyArNTM3LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYsCj4+PiAgICAJaWYgKCF4ZHBfcHJvZykKPj4+ICAgIAkJcmV0dXJuIC1FTlhJTzsK
Pj4+Cj4+PiAtCXNxID0gdmlydG5ldF94ZHBfc3EodmkpOwo+Pj4gKwlzcSA9IHZpcnRuZXRfeGRw
X2dldF9zcSh2aSk7Cj4+Pgo+Pj4gICAgCWlmICh1bmxpa2VseShmbGFncyAmIH5YRFBfWE1JVF9G
TEFHU19NQVNLKSkgewo+Pj4gICAgCQlyZXQgPSAtRUlOVkFMOwo+Pj4gQEAgLTU2MCwxMiArNTg1
LDEzIEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfeG1pdChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2
LAo+Pj4gICAgCXNxLT5zdGF0cy5raWNrcyArPSBraWNrczsKPj4+ICAgIAl1NjRfc3RhdHNfdXBk
YXRlX2VuZCgmc3EtPnN0YXRzLnN5bmNwKTsKPj4+Cj4+PiArCXZpcnRuZXRfeGRwX3B1dF9zcSh2
aSwgc3EpOwo+Pj4gICAgCXJldHVybiByZXQ7Cj4+PiAgICB9Cj4+Pgo+Pj4gICAgc3RhdGljIHVu
c2lnbmVkIGludCB2aXJ0bmV0X2dldF9oZWFkcm9vbShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkK
Pj4+ICAgIHsKPj4+IC0JcmV0dXJuIHZpLT54ZHBfcXVldWVfcGFpcnMgPyBWSVJUSU9fWERQX0hF
QURST09NIDogMDsKPj4+ICsJcmV0dXJuIHZpLT54ZHBfZW5hYmxlZCA/IFZJUlRJT19YRFBfSEVB
RFJPT00gOiAwOwo+Pj4gICAgfQo+Pj4KPj4+ICAgIC8qIFdlIGNvcHkgdGhlIHBhY2tldCBmb3Ig
WERQIGluIHRoZSBmb2xsb3dpbmcgY2FzZXM6Cj4+PiBAQCAtMTQ1NywxMiArMTQ4MywxMyBAQCBz
dGF0aWMgaW50IHZpcnRuZXRfcG9sbChzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksIGludCBidWRn
ZXQpCj4+PiAgICAJCXhkcF9kb19mbHVzaCgpOwo+Pj4KPj4+ICAgIAlpZiAoeGRwX3htaXQgJiBW
SVJUSU9fWERQX1RYKSB7Cj4+PiAtCQlzcSA9IHZpcnRuZXRfeGRwX3NxKHZpKTsKPj4+ICsJCXNx
ID0gdmlydG5ldF94ZHBfZ2V0X3NxKHZpKTsKPj4+ICAgIAkJaWYgKHZpcnRxdWV1ZV9raWNrX3By
ZXBhcmUoc3EtPnZxKSAmJiB2aXJ0cXVldWVfbm90aWZ5KHNxLT52cSkpIHsKPj4+ICAgIAkJCXU2
NF9zdGF0c191cGRhdGVfYmVnaW4oJnNxLT5zdGF0cy5zeW5jcCk7Cj4+PiAgICAJCQlzcS0+c3Rh
dHMua2lja3MrKzsKPj4+ICAgIAkJCXU2NF9zdGF0c191cGRhdGVfZW5kKCZzcS0+c3RhdHMuc3lu
Y3ApOwo+Pj4gICAgCQl9Cj4+PiArCQl2aXJ0bmV0X3hkcF9wdXRfc3EodmksIHNxKTsKPj4+ICAg
IAl9Cj4+Pgo+Pj4gICAgCXJldHVybiByZWNlaXZlZDsKPj4+IEBAIC0yNDE3LDEwICsyNDQ0LDkg
QEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9zZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3Ry
dWN0IGJwZl9wcm9nICpwcm9nLAo+Pj4KPj4+ICAgIAkvKiBYRFAgcmVxdWlyZXMgZXh0cmEgcXVl
dWVzIGZvciBYRFBfVFggKi8KPj4+ICAgIAlpZiAoY3Vycl9xcCArIHhkcF9xcCA+IHZpLT5tYXhf
cXVldWVfcGFpcnMpIHsKPj4+IC0JCU5MX1NFVF9FUlJfTVNHX01PRChleHRhY2ssICJUb28gZmV3
IGZyZWUgVFggcmluZ3MgYXZhaWxhYmxlIik7Cj4+PiAtCQluZXRkZXZfd2FybihkZXYsICJyZXF1
ZXN0ICVpIHF1ZXVlcyBidXQgbWF4IGlzICVpXG4iLAo+Pj4gKwkJbmV0ZGV2X3dhcm4oZGV2LCAi
WERQIHJlcXVlc3QgJWkgcXVldWVzIGJ1dCBtYXggaXMgJWkuIFhEUF9UWCBhbmQgWERQX1JFRElS
RUNUIHdpbGwgb3BlcmF0ZSBpbiBhIHNsb3dlciBsb2NrZWQgdHggbW9kZS5cbiIsCj4+PiAgICAJ
CQkgICAgY3Vycl9xcCArIHhkcF9xcCwgdmktPm1heF9xdWV1ZV9wYWlycyk7Cj4+PiAtCQlyZXR1
cm4gLUVOT01FTTsKPj4+ICsJCXhkcF9xcCA9IDA7Cj4+PiAgICAJfQo+Pj4KPj4+ICAgIAlvbGRf
cHJvZyA9IHJ0bmxfZGVyZWZlcmVuY2UodmktPnJxWzBdLnhkcF9wcm9nKTsKPj4+IEBAIC0yNDU0
LDExICsyNDgwLDE0IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94ZHBfc2V0KHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYsIHN0cnVjdCBicGZfcHJvZyAqcHJvZywKPj4+ICAgIAl2aS0+eGRwX3F1ZXVlX3Bh
aXJzID0geGRwX3FwOwo+Pj4KPj4+ICAgIAlpZiAocHJvZykgewo+Pj4gKwkJdmktPnhkcF9lbmFi
bGVkID0gdHJ1ZTsKPj4+ICAgIAkJZm9yIChpID0gMDsgaSA8IHZpLT5tYXhfcXVldWVfcGFpcnM7
IGkrKykgewo+Pj4gICAgCQkJcmN1X2Fzc2lnbl9wb2ludGVyKHZpLT5ycVtpXS54ZHBfcHJvZywg
cHJvZyk7Cj4+PiAgICAJCQlpZiAoaSA9PSAwICYmICFvbGRfcHJvZykKPj4+ICAgIAkJCQl2aXJ0
bmV0X2NsZWFyX2d1ZXN0X29mZmxvYWRzKHZpKTsKPj4+ICAgIAkJfQo+Pj4gKwl9IGVsc2Ugewo+
Pj4gKwkJdmktPnhkcF9lbmFibGVkID0gZmFsc2U7Cj4+PiAgICAJfQo+Pj4KPj4+ICAgIAlmb3Ig
KGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4+PiBAQCAtMjUyNiw3ICsy
NTU1LDcgQEAgc3RhdGljIGludCB2aXJ0bmV0X3NldF9mZWF0dXJlcyhzdHJ1Y3QgbmV0X2Rldmlj
ZSAqZGV2LAo+Pj4gICAgCWludCBlcnI7Cj4+Pgo+Pj4gICAgCWlmICgoZGV2LT5mZWF0dXJlcyBe
IGZlYXR1cmVzKSAmIE5FVElGX0ZfTFJPKSB7Cj4+PiAtCQlpZiAodmktPnhkcF9xdWV1ZV9wYWly
cykKPj4+ICsJCWlmICh2aS0+eGRwX2VuYWJsZWQpCj4+PiAgICAJCQlyZXR1cm4gLUVCVVNZOwo+
Pj4KPj4+ICAgIAkJaWYgKGZlYXR1cmVzICYgTkVUSUZfRl9MUk8pCj4+PiAtLQo+Pj4gMS44LjMu
MQo+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
