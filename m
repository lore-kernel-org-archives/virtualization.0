Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90370C433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 06:45:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14BFD229C6
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 06:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14BFD229C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B3FEA8579E;
	Mon, 18 Jan 2021 06:45:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6DG-oE_wFq1x; Mon, 18 Jan 2021 06:45:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D8C07856E8;
	Mon, 18 Jan 2021 06:45:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C009DC088B;
	Mon, 18 Jan 2021 06:45:39 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ED5CC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:45:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1363087048
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:45:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WP+511dCqD8j
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:45:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8193087042
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 06:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610952335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdEi9XS6yauqVH4y/Yh5K8jYx6nqo491sww+XMX6WiY=;
 b=NoEJYzp4mnfnCNeLFHnmQCezuq4ZkCoo4WQHDmPfdNfl96RMjBm97jgh7G4+o+VHnJlzJ5
 apr8AHaBaO+WoLiitC/Mja8atvJjuAOBcrmZmYN8PFjgZZpbpXTldf8dX5PB6kgJWK55tn
 cItEwDb37NKV8Y97j2pOv/8dS18K+dE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-9BOc-bKPPVWZK5MGcghH1A-1; Mon, 18 Jan 2021 01:45:31 -0500
X-MC-Unique: 9BOc-bKPPVWZK5MGcghH1A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33DDDE743;
 Mon, 18 Jan 2021 06:45:29 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5D1671002382;
 Mon, 18 Jan 2021 06:45:18 +0000 (UTC)
Subject: Re: [PATCH net-next v2 2/7] virtio-net, xsk: distinguish XDP_TX and
 XSK XMIT ctx
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <cover.1609837120.git.xuanzhuo@linux.alibaba.com>
 <cover.1610765285.git.xuanzhuo@linux.alibaba.com>
 <27006309ce40fe3f5375b44d4afaae39ed550855.1610765285.git.xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7203b2a0-0f56-dee8-4ba0-cbbaf6456913@redhat.com>
Date: Mon, 18 Jan 2021 14:45:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <27006309ce40fe3f5375b44d4afaae39ed550855.1610765285.git.xuanzhuo@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
 virtualization@lists.linux-foundation.org,
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

Ck9uIDIwMjEvMS8xNiDkuIrljYgxMDo1OSwgWHVhbiBaaHVvIHdyb3RlOgo+IElmIHN1cHBvcnQg
eHNrLCBhIG5ldyBwdHIgd2lsbCBiZSByZWNvdmVyZWQgZHVyaW5nIHRoZQo+IHByb2Nlc3Mgb2Yg
ZnJlZWluZyB0aGUgb2xkIHB0ci4gSW4gb3JkZXIgdG8gZGlzdGluZ3Vpc2ggYmV0d2VlbiBjdHgg
c2VudAo+IGJ5IFhEUF9UWCBhbmQgY3R4IHNlbnQgYnkgeHNrLCBhIHN0cnVjdCBpcyBhZGRlZCBo
ZXJlIHRvIGRpc3Rpbmd1aXNoCj4gYmV0d2VlbiB0aGVzZSB0d28gc2l0dWF0aW9ucy4gdmlydG5l
dF94ZHBfdHlwZS50eXBlIEl0IGlzIHVzZWQgdG8KPiBkaXN0aW5ndWlzaCBkaWZmZXJlbnQgY3R4
LCBhbmQgdmlydG5ldF94ZHBfdHlwZS5vZmZzZXQgaXMgdXNlZCB0byByZWNvcmQKPiB0aGUgb2Zm
c2V0IGJldHdlZW4gInRydWUgY3R4IiBhbmQgdmlydG5ldF94ZHBfdHlwZS4KPgo+IFRoZSBuZXds
eSBhZGRlZCB2aXJ0bmV0X3hza19oZHIgd2lsbCBiZSB1c2VkIGZvciB4c2suCj4KPiBTaWduZWQt
b2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoKCkFueSByZWFz
b24gdGhhdCB5b3UgY2FuJ3Qgc2ltcGx5IGVuY29kZSB0aGUgdHlwZSBpbiB0aGUgcG9pbnRlciBp
dHNlbGYgCmFzIHdlIHVzZWQgdG8gZG8/CgojZGVmaW5lIFZJUlRJT19YU0tfRkxBR8KgwqDCoCBC
SVQoMSkKCj8KCgo+IC0tLQo+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNzUgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hh
bmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gaW5k
ZXggYmE4ZTYzNy4uZTcwN2MzMSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0
LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtOTQsNiArOTQsMjIgQEAg
c3RydWN0IHZpcnRuZXRfcnFfc3RhdHMgewo+ICAgCXU2NCBraWNrczsKPiAgIH07Cj4gICAKPiAr
ZW51bSB7Cj4gKwlYRFBfVFlQRV9YU0ssCj4gKwlYRFBfVFlQRV9UWCwKPiArfTsKPiArCj4gK3N0
cnVjdCB2aXJ0bmV0X3hkcF90eXBlIHsKPiArCWludCBvZmZzZXQ6MjQ7Cj4gKwl1bnNpZ25lZCB0
eXBlOjg7Cj4gK307Cj4gKwo+ICtzdHJ1Y3QgdmlydG5ldF94c2tfaGRyIHsKPiArCXN0cnVjdCB2
aXJ0bmV0X3hkcF90eXBlIHR5cGU7Cj4gKwlzdHJ1Y3QgdmlydGlvX25ldF9oZHJfbXJnX3J4YnVm
IGhkcjsKPiArCXUzMiBsZW47Cj4gK307Cj4gKwo+ICAgI2RlZmluZSBWSVJUTkVUX1NRX1NUQVQo
bSkJb2Zmc2V0b2Yoc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMsIG0pCj4gICAjZGVmaW5lIFZJUlRO
RVRfUlFfU1RBVChtKQlvZmZzZXRvZihzdHJ1Y3QgdmlydG5ldF9ycV9zdGF0cywgbSkKPiAgIAo+
IEBAIC0yNTEsMTQgKzI2NywxOSBAQCBzdGF0aWMgYm9vbCBpc194ZHBfZnJhbWUodm9pZCAqcHRy
KQo+ICAgCXJldHVybiAodW5zaWduZWQgbG9uZylwdHIgJiBWSVJUSU9fWERQX0ZMQUc7Cj4gICB9
Cj4gICAKPiAtc3RhdGljIHZvaWQgKnhkcF90b19wdHIoc3RydWN0IHhkcF9mcmFtZSAqcHRyKQo+
ICtzdGF0aWMgdm9pZCAqeGRwX3RvX3B0cihzdHJ1Y3QgdmlydG5ldF94ZHBfdHlwZSAqcHRyKQo+
ICAgewo+ICAgCXJldHVybiAodm9pZCAqKSgodW5zaWduZWQgbG9uZylwdHIgfCBWSVJUSU9fWERQ
X0ZMQUcpOwo+ICAgfQo+ICAgCj4gLXN0YXRpYyBzdHJ1Y3QgeGRwX2ZyYW1lICpwdHJfdG9feGRw
KHZvaWQgKnB0cikKPiArc3RhdGljIHN0cnVjdCB2aXJ0bmV0X3hkcF90eXBlICpwdHJfdG9feHR5
cGUodm9pZCAqcHRyKQo+ICt7Cj4gKwlyZXR1cm4gKHN0cnVjdCB2aXJ0bmV0X3hkcF90eXBlICop
KCh1bnNpZ25lZCBsb25nKXB0ciAmIH5WSVJUSU9fWERQX0ZMQUcpOwo+ICt9Cj4gKwo+ICtzdGF0
aWMgdm9pZCAqeHR5cGVfZ2V0X3B0cihzdHJ1Y3QgdmlydG5ldF94ZHBfdHlwZSAqeGRwdHlwZSkK
PiAgIHsKPiAtCXJldHVybiAoc3RydWN0IHhkcF9mcmFtZSAqKSgodW5zaWduZWQgbG9uZylwdHIg
JiB+VklSVElPX1hEUF9GTEFHKTsKPiArCXJldHVybiAoY2hhciAqKXhkcHR5cGUgKyB4ZHB0eXBl
LT5vZmZzZXQ7Cj4gICB9Cj4gICAKPiAgIC8qIENvbnZlcnRpbmcgYmV0d2VlbiB2aXJ0cXVldWUg
bm8uIGFuZCBrZXJuZWwgdHgvcnggcXVldWUgbm8uCj4gQEAgLTQ1OSwxMSArNDgwLDE2IEBAIHN0
YXRpYyBpbnQgX192aXJ0bmV0X3hkcF94bWl0X29uZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwK
PiAgIAkJCQkgICBzdHJ1Y3QgeGRwX2ZyYW1lICp4ZHBmKQo+ICAgewo+ICAgCXN0cnVjdCB2aXJ0
aW9fbmV0X2hkcl9tcmdfcnhidWYgKmhkcjsKPiArCXN0cnVjdCB2aXJ0bmV0X3hkcF90eXBlICp4
ZHB0eXBlOwo+ICAgCWludCBlcnI7Cj4gICAKPiAtCWlmICh1bmxpa2VseSh4ZHBmLT5oZWFkcm9v
bSA8IHZpLT5oZHJfbGVuKSkKPiArCWlmICh1bmxpa2VseSh4ZHBmLT5oZWFkcm9vbSA8IHZpLT5o
ZHJfbGVuICsgc2l6ZW9mKCp4ZHB0eXBlKSkpCj4gICAJCXJldHVybiAtRU9WRVJGTE9XOwo+ICAg
Cj4gKwl4ZHB0eXBlID0gKHN0cnVjdCB2aXJ0bmV0X3hkcF90eXBlICopKHhkcGYgKyAxKTsKPiAr
CXhkcHR5cGUtPm9mZnNldCA9IChjaGFyICopeGRwZiAtIChjaGFyICopeGRwdHlwZTsKPiArCXhk
cHR5cGUtPnR5cGUgPSBYRFBfVFlQRV9UWDsKPiArCj4gICAJLyogTWFrZSByb29tIGZvciB2aXJ0
cXVldWUgaGRyIChhbHNvIGNoYW5nZSB4ZHBmLT5oZWFkcm9vbT8pICovCj4gICAJeGRwZi0+ZGF0
YSAtPSB2aS0+aGRyX2xlbjsKPiAgIAkvKiBaZXJvIGhlYWRlciBhbmQgbGVhdmUgY3N1bSB1cCB0
byBYRFAgbGF5ZXJzICovCj4gQEAgLTQ3Myw3ICs0OTksNyBAQCBzdGF0aWMgaW50IF9fdmlydG5l
dF94ZHBfeG1pdF9vbmUoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmksCj4gICAKPiAgIAlzZ19pbml0
X29uZShzcS0+c2csIHhkcGYtPmRhdGEsIHhkcGYtPmxlbik7Cj4gICAKPiAtCWVyciA9IHZpcnRx
dWV1ZV9hZGRfb3V0YnVmKHNxLT52cSwgc3EtPnNnLCAxLCB4ZHBfdG9fcHRyKHhkcGYpLAo+ICsJ
ZXJyID0gdmlydHF1ZXVlX2FkZF9vdXRidWYoc3EtPnZxLCBzcS0+c2csIDEsIHhkcF90b19wdHIo
eGRwdHlwZSksCj4gICAJCQkJICAgR0ZQX0FUT01JQyk7Cj4gICAJaWYgKHVubGlrZWx5KGVycikp
Cj4gICAJCXJldHVybiAtRU5PU1BDOyAvKiBDYWxsZXIgaGFuZGxlIGZyZWUvcmVmY250ICovCj4g
QEAgLTUyMyw4ICs1NDksMTEgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF94bWl0KHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYsCj4gICAJLyogRnJlZSB1cCBhbnkgcGVuZGluZyBvbGQgYnVmZmVycyBi
ZWZvcmUgcXVldWVpbmcgbmV3IG9uZXMuICovCj4gICAJd2hpbGUgKChwdHIgPSB2aXJ0cXVldWVf
Z2V0X2J1ZihzcS0+dnEsICZsZW4pKSAhPSBOVUxMKSB7Cj4gICAJCWlmIChsaWtlbHkoaXNfeGRw
X2ZyYW1lKHB0cikpKSB7Cj4gLQkJCXN0cnVjdCB4ZHBfZnJhbWUgKmZyYW1lID0gcHRyX3RvX3hk
cChwdHIpOwo+ICsJCQlzdHJ1Y3QgdmlydG5ldF94ZHBfdHlwZSAqeHR5cGU7Cj4gKwkJCXN0cnVj
dCB4ZHBfZnJhbWUgKmZyYW1lOwo+ICAgCj4gKwkJCXh0eXBlID0gcHRyX3RvX3h0eXBlKHB0cik7
Cj4gKwkJCWZyYW1lID0geHR5cGVfZ2V0X3B0cih4dHlwZSk7Cj4gICAJCQlieXRlcyArPSBmcmFt
ZS0+bGVuOwo+ICAgCQkJeGRwX3JldHVybl9mcmFtZShmcmFtZSk7Cj4gICAJCX0gZWxzZSB7Cj4g
QEAgLTEzNzMsMjQgKzE0MDIsMzQgQEAgc3RhdGljIGludCB2aXJ0bmV0X3JlY2VpdmUoc3RydWN0
IHJlY2VpdmVfcXVldWUgKnJxLCBpbnQgYnVkZ2V0LAo+ICAgCj4gICBzdGF0aWMgdm9pZCBmcmVl
X29sZF94bWl0X3NrYnMoc3RydWN0IHNlbmRfcXVldWUgKnNxLCBib29sIGluX25hcGkpCj4gICB7
Cj4gLQl1bnNpZ25lZCBpbnQgbGVuOwo+ICAgCXVuc2lnbmVkIGludCBwYWNrZXRzID0gMDsKPiAg
IAl1bnNpZ25lZCBpbnQgYnl0ZXMgPSAwOwo+IC0Jdm9pZCAqcHRyOwo+ICsJdW5zaWduZWQgaW50
IGxlbjsKPiArCXN0cnVjdCB2aXJ0bmV0X3hkcF90eXBlICp4dHlwZTsKPiArCXN0cnVjdCB4ZHBf
ZnJhbWUgICAgICAgICpmcmFtZTsKPiArCXN0cnVjdCB2aXJ0bmV0X3hza19oZHIgICp4c2toZHI7
Cj4gKwlzdHJ1Y3Qgc2tfYnVmZiAgICAgICAgICAqc2tiOwo+ICsJdm9pZCAgICAgICAgICAgICAg
ICAgICAgKnB0cjsKPiAgIAo+ICAgCXdoaWxlICgocHRyID0gdmlydHF1ZXVlX2dldF9idWYoc3Et
PnZxLCAmbGVuKSkgIT0gTlVMTCkgewo+ICAgCQlpZiAobGlrZWx5KCFpc194ZHBfZnJhbWUocHRy
KSkpIHsKPiAtCQkJc3RydWN0IHNrX2J1ZmYgKnNrYiA9IHB0cjsKPiArCQkJc2tiID0gcHRyOwo+
ICAgCj4gICAJCQlwcl9kZWJ1ZygiU2VudCBza2IgJXBcbiIsIHNrYik7Cj4gICAKPiAgIAkJCWJ5
dGVzICs9IHNrYi0+bGVuOwo+ICAgCQkJbmFwaV9jb25zdW1lX3NrYihza2IsIGluX25hcGkpOwo+
ICAgCQl9IGVsc2Ugewo+IC0JCQlzdHJ1Y3QgeGRwX2ZyYW1lICpmcmFtZSA9IHB0cl90b194ZHAo
cHRyKTsKPiArCQkJeHR5cGUgPSBwdHJfdG9feHR5cGUocHRyKTsKPiAgIAo+IC0JCQlieXRlcyAr
PSBmcmFtZS0+bGVuOwo+IC0JCQl4ZHBfcmV0dXJuX2ZyYW1lKGZyYW1lKTsKPiArCQkJaWYgKHh0
eXBlLT50eXBlID09IFhEUF9UWVBFX1hTSykgewo+ICsJCQkJeHNraGRyID0gKHN0cnVjdCB2aXJ0
bmV0X3hza19oZHIgKil4dHlwZTsKPiArCQkJCWJ5dGVzICs9IHhza2hkci0+bGVuOwo+ICsJCQl9
IGVsc2Ugewo+ICsJCQkJZnJhbWUgPSB4dHlwZV9nZXRfcHRyKHh0eXBlKTsKPiArCQkJCXhkcF9y
ZXR1cm5fZnJhbWUoZnJhbWUpOwo+ICsJCQkJYnl0ZXMgKz0gZnJhbWUtPmxlbjsKPiArCQkJfQo+
ICAgCQl9Cj4gICAJCXBhY2tldHMrKzsKPiAgIAl9Cj4gQEAgLTI2NTksMTAgKzI2OTgsMTYgQEAg
c3RhdGljIHZvaWQgZnJlZV91bnVzZWRfYnVmcyhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiAg
IAlmb3IgKGkgPSAwOyBpIDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4gICAJCXN0cnVj
dCB2aXJ0cXVldWUgKnZxID0gdmktPnNxW2ldLnZxOwo+ICAgCQl3aGlsZSAoKGJ1ZiA9IHZpcnRx
dWV1ZV9kZXRhY2hfdW51c2VkX2J1Zih2cSkpICE9IE5VTEwpIHsKPiAtCQkJaWYgKCFpc194ZHBf
ZnJhbWUoYnVmKSkKPiArCQkJaWYgKCFpc194ZHBfZnJhbWUoYnVmKSkgewo+ICAgCQkJCWRldl9r
ZnJlZV9za2IoYnVmKTsKPiAtCQkJZWxzZQo+IC0JCQkJeGRwX3JldHVybl9mcmFtZShwdHJfdG9f
eGRwKGJ1ZikpOwo+ICsJCQl9IGVsc2Ugewo+ICsJCQkJc3RydWN0IHZpcnRuZXRfeGRwX3R5cGUg
Knh0eXBlOwo+ICsKPiArCQkJCXh0eXBlID0gcHRyX3RvX3h0eXBlKGJ1Zik7Cj4gKwo+ICsJCQkJ
aWYgKHh0eXBlLT50eXBlICE9IFhEUF9UWVBFX1hTSykKPiArCQkJCQl4ZHBfcmV0dXJuX2ZyYW1l
KHh0eXBlX2dldF9wdHIoeHR5cGUpKTsKPiArCQkJfQo+ICAgCQl9Cj4gICAJfQo+ICAgCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
