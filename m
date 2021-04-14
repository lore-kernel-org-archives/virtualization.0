Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45200C433B4
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 03:32:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBF7160BBB
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 03:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBF7160BBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8DEB360C2D;
	Wed, 14 Apr 2021 03:32:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id khNq8oDsinq3; Wed, 14 Apr 2021 03:32:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0AFDA606F1;
	Wed, 14 Apr 2021 03:32:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5FD6C000B;
	Wed, 14 Apr 2021 03:32:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B0CBC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 03:32:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 727B7400FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 03:32:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CQw_lTEFZ8SQ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 03:32:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8479400F3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 03:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618371149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+A8H3Xsz8BfiDlAz5Esxp+7ouef9SRzHSQmz/cVmR8k=;
 b=D3Bzqlu97cy/nRNnhUiTYxf8eEA2mD8u9fvMPEe0gNhdYgBZ4xkJOeEA0Z7us6ttdVlyIE
 FiBfNkgFTAaBjusDq8sEGei04rulrRfntx4ZL37AUlOkW4vxfDDdUMW5iacwJFVDqqLiTY
 sygxOdOjIszMLwd0hqGvL5B4nOCs+T8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-jxjyci_WPZOdXCiqRwCDPg-1; Tue, 13 Apr 2021 23:32:25 -0400
X-MC-Unique: jxjyci_WPZOdXCiqRwCDPg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F379192AB6D;
 Wed, 14 Apr 2021 03:32:22 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-196.pek2.redhat.com
 [10.72.13.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C41785D9CA;
 Wed, 14 Apr 2021 03:32:14 +0000 (UTC)
Subject: Re: [PATCH net-next v4 06/10] virtio-net: unify the code for
 recycling the xmit ptr
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210413031523.73507-1-xuanzhuo@linux.alibaba.com>
 <20210413031523.73507-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6a853b6a-be20-cce6-f1c9-9c19f891aac3@redhat.com>
Date: Wed, 14 Apr 2021 11:32:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210413031523.73507-7-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8xMyDJz87nMTE6MTUsIFh1YW4gWmh1byDQtLXAOgo+IE5vdyB0aGVyZSBhcmUg
dHdvIHR5cGVzIG9mICJza2IiIGFuZCAieGRwIGZyYW1lIiBkdXJpbmcgcmVjeWNsaW5nIG9sZAo+
IHhtaXQuCj4KPiBUaGVyZSBhcmUgdHdvIGNvbXBsZXRlbHkgc2ltaWxhciBhbmQgaW5kZXBlbmRl
bnQgaW1wbGVtZW50YXRpb25zLiBUaGlzCj4gaXMgaW5jb252ZW5pZW50IGZvciB0aGUgc3Vic2Vx
dWVudCBhZGRpdGlvbiBvZiBuZXcgdHlwZXMuIFNvIGV4dHJhY3QgYQo+IGZ1bmN0aW9uIGZyb20g
dGhpcyBwaWVjZSBvZiBjb2RlIGFuZCBjYWxsIHRoaXMgZnVuY3Rpb24gdW5pZm9ybWx5IHRvCj4g
cmVjb3ZlciBvbGQgeG1pdCBwdHIuCj4KPiBSZW5hbWUgZnJlZV9vbGRfeG1pdF9za2JzKCkgdG8g
ZnJlZV9vbGRfeG1pdCgpLgo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0Bs
aW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDg2
ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAzOCBpbnNlcnRpb25zKCspLCA0OCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRl
eCA1MjY1M2UyMzRhMjAuLmYzNzUyYjI1NDk2NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtMjY0LDYg
KzI2NCwzMCBAQCBzdGF0aWMgc3RydWN0IHhkcF9mcmFtZSAqcHRyX3RvX3hkcCh2b2lkICpwdHIp
Cj4gICAJcmV0dXJuIChzdHJ1Y3QgeGRwX2ZyYW1lICopKCh1bnNpZ25lZCBsb25nKXB0ciAmIH5W
SVJUSU9fWERQX0ZMQUcpOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyB2b2lkIF9fZnJlZV9vbGRfeG1p
dChzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsIGJvb2wgaW5fbmFwaSwKPiArCQkJICAgIHN0cnVjdCB2
aXJ0bmV0X3NxX3N0YXRzICpzdGF0cykKPiArewo+ICsJdW5zaWduZWQgaW50IGxlbjsKPiArCXZv
aWQgKnB0cjsKPiArCj4gKwl3aGlsZSAoKHB0ciA9IHZpcnRxdWV1ZV9nZXRfYnVmKHNxLT52cSwg
JmxlbikpICE9IE5VTEwpIHsKPiArCQlpZiAobGlrZWx5KCFpc194ZHBfZnJhbWUocHRyKSkpIHsK
CgpTbyBJIHRoaW5rIHdlIG5lZWQgdG8gZHJvcCBsaWtlbHkgaGVyZSBiZWNhdXNlIGl0IGNvdWxk
IGJlIGNhbGxlZCBieSBza2IgCnBhdGguCgpPdGhlciBsb29rcyBnb29kLgoKVGhhbmtzCgoKPiAr
CQkJc3RydWN0IHNrX2J1ZmYgKnNrYiA9IHB0cjsKPiArCj4gKwkJCXByX2RlYnVnKCJTZW50IHNr
YiAlcFxuIiwgc2tiKTsKPiArCj4gKwkJCXN0YXRzLT5ieXRlcyArPSBza2ItPmxlbjsKPiArCQkJ
bmFwaV9jb25zdW1lX3NrYihza2IsIGluX25hcGkpOwo+ICsJCX0gZWxzZSB7Cj4gKwkJCXN0cnVj
dCB4ZHBfZnJhbWUgKmZyYW1lID0gcHRyX3RvX3hkcChwdHIpOwo+ICsKPiArCQkJc3RhdHMtPmJ5
dGVzICs9IGZyYW1lLT5sZW47Cj4gKwkJCXhkcF9yZXR1cm5fZnJhbWUoZnJhbWUpOwo+ICsJCX0K
PiArCQlzdGF0cy0+cGFja2V0cysrOwo+ICsJfQo+ICt9Cj4gKwo+ICAgLyogQ29udmVydGluZyBi
ZXR3ZWVuIHZpcnRxdWV1ZSBuby4gYW5kIGtlcm5lbCB0eC9yeCBxdWV1ZSBuby4KPiAgICAqIDA6
cngwIDE6dHgwIDI6cngxIDM6dHgxIC4uLiAyTjpyeE4gMk4rMTp0eE4gMk4rMjpjdnEKPiAgICAq
Lwo+IEBAIC01MjUsMTUgKzU0OSwxMiBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3htaXQoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAkJCSAgICBpbnQgbiwgc3RydWN0IHhkcF9mcmFtZSAq
KmZyYW1lcywgdTMyIGZsYWdzKQo+ICAgewo+ICAgCXN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0g
bmV0ZGV2X3ByaXYoZGV2KTsKPiArCXN0cnVjdCB2aXJ0bmV0X3NxX3N0YXRzIHN0YXRzID0ge307
Cj4gICAJc3RydWN0IHJlY2VpdmVfcXVldWUgKnJxID0gdmktPnJxOwo+ICAgCXN0cnVjdCBicGZf
cHJvZyAqeGRwX3Byb2c7Cj4gICAJc3RydWN0IHNlbmRfcXVldWUgKnNxOwo+IC0JdW5zaWduZWQg
aW50IGxlbjsKPiAtCWludCBwYWNrZXRzID0gMDsKPiAtCWludCBieXRlcyA9IDA7Cj4gICAJaW50
IG54bWl0ID0gMDsKPiAgIAlpbnQga2lja3MgPSAwOwo+IC0Jdm9pZCAqcHRyOwo+ICAgCWludCBy
ZXQ7Cj4gICAJaW50IGk7Cj4gICAKPiBAQCAtNTUyLDIwICs1NzMsNyBAQCBzdGF0aWMgaW50IHZp
cnRuZXRfeGRwX3htaXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgIAl9Cj4gICAKPiAgIAkv
KiBGcmVlIHVwIGFueSBwZW5kaW5nIG9sZCBidWZmZXJzIGJlZm9yZSBxdWV1ZWluZyBuZXcgb25l
cy4gKi8KPiAtCXdoaWxlICgocHRyID0gdmlydHF1ZXVlX2dldF9idWYoc3EtPnZxLCAmbGVuKSkg
IT0gTlVMTCkgewo+IC0JCWlmIChsaWtlbHkoaXNfeGRwX2ZyYW1lKHB0cikpKSB7Cj4gLQkJCXN0
cnVjdCB4ZHBfZnJhbWUgKmZyYW1lID0gcHRyX3RvX3hkcChwdHIpOwo+IC0KPiAtCQkJYnl0ZXMg
Kz0gZnJhbWUtPmxlbjsKPiAtCQkJeGRwX3JldHVybl9mcmFtZShmcmFtZSk7Cj4gLQkJfSBlbHNl
IHsKPiAtCQkJc3RydWN0IHNrX2J1ZmYgKnNrYiA9IHB0cjsKPiAtCj4gLQkJCWJ5dGVzICs9IHNr
Yi0+bGVuOwo+IC0JCQluYXBpX2NvbnN1bWVfc2tiKHNrYiwgZmFsc2UpOwo+IC0JCX0KPiAtCQlw
YWNrZXRzKys7Cj4gLQl9Cj4gKwlfX2ZyZWVfb2xkX3htaXQoc3EsIGZhbHNlLCAmc3RhdHMpOwo+
ICAgCj4gICAJZm9yIChpID0gMDsgaSA8IG47IGkrKykgewo+ICAgCQlzdHJ1Y3QgeGRwX2ZyYW1l
ICp4ZHBmID0gZnJhbWVzW2ldOwo+IEBAIC01ODIsOCArNTkwLDggQEAgc3RhdGljIGludCB2aXJ0
bmV0X3hkcF94bWl0KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gICAJfQo+ICAgb3V0Ogo+ICAg
CXU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnNxLT5zdGF0cy5zeW5jcCk7Cj4gLQlzcS0+c3RhdHMu
Ynl0ZXMgKz0gYnl0ZXM7Cj4gLQlzcS0+c3RhdHMucGFja2V0cyArPSBwYWNrZXRzOwo+ICsJc3Et
PnN0YXRzLmJ5dGVzICs9IHN0YXRzLmJ5dGVzOwo+ICsJc3EtPnN0YXRzLnBhY2tldHMgKz0gc3Rh
dHMucGFja2V0czsKPiAgIAlzcS0+c3RhdHMueGRwX3R4ICs9IG47Cj4gICAJc3EtPnN0YXRzLnhk
cF90eF9kcm9wcyArPSBuIC0gbnhtaXQ7Cj4gICAJc3EtPnN0YXRzLmtpY2tzICs9IGtpY2tzOwo+
IEBAIC0xNDA2LDM5ICsxNDE0LDIxIEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yZWNlaXZlKHN0cnVj
dCByZWNlaXZlX3F1ZXVlICpycSwgaW50IGJ1ZGdldCwKPiAgIAlyZXR1cm4gc3RhdHMucGFja2V0
czsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgdm9pZCBmcmVlX29sZF94bWl0X3NrYnMoc3RydWN0IHNl
bmRfcXVldWUgKnNxLCBib29sIGluX25hcGkpCj4gK3N0YXRpYyB2b2lkIGZyZWVfb2xkX3htaXQo
c3RydWN0IHNlbmRfcXVldWUgKnNxLCBib29sIGluX25hcGkpCj4gICB7Cj4gLQl1bnNpZ25lZCBp
bnQgbGVuOwo+IC0JdW5zaWduZWQgaW50IHBhY2tldHMgPSAwOwo+IC0JdW5zaWduZWQgaW50IGJ5
dGVzID0gMDsKPiAtCXZvaWQgKnB0cjsKPiAtCj4gLQl3aGlsZSAoKHB0ciA9IHZpcnRxdWV1ZV9n
ZXRfYnVmKHNxLT52cSwgJmxlbikpICE9IE5VTEwpIHsKPiAtCQlpZiAobGlrZWx5KCFpc194ZHBf
ZnJhbWUocHRyKSkpIHsKPiAtCQkJc3RydWN0IHNrX2J1ZmYgKnNrYiA9IHB0cjsKPiAtCj4gLQkJ
CXByX2RlYnVnKCJTZW50IHNrYiAlcFxuIiwgc2tiKTsKPiArCXN0cnVjdCB2aXJ0bmV0X3NxX3N0
YXRzIHN0YXRzID0ge307Cj4gICAKPiAtCQkJYnl0ZXMgKz0gc2tiLT5sZW47Cj4gLQkJCW5hcGlf
Y29uc3VtZV9za2Ioc2tiLCBpbl9uYXBpKTsKPiAtCQl9IGVsc2Ugewo+IC0JCQlzdHJ1Y3QgeGRw
X2ZyYW1lICpmcmFtZSA9IHB0cl90b194ZHAocHRyKTsKPiAtCj4gLQkJCWJ5dGVzICs9IGZyYW1l
LT5sZW47Cj4gLQkJCXhkcF9yZXR1cm5fZnJhbWUoZnJhbWUpOwo+IC0JCX0KPiAtCQlwYWNrZXRz
Kys7Cj4gLQl9Cj4gKwlfX2ZyZWVfb2xkX3htaXQoc3EsIGluX25hcGksICZzdGF0cyk7Cj4gICAK
PiAgIAkvKiBBdm9pZCBvdmVyaGVhZCB3aGVuIG5vIHBhY2tldHMgaGF2ZSBiZWVuIHByb2Nlc3Nl
ZAo+ICAgCSAqIGhhcHBlbnMgd2hlbiBjYWxsZWQgc3BlY3VsYXRpdmVseSBmcm9tIHN0YXJ0X3ht
aXQuCj4gICAJICovCj4gLQlpZiAoIXBhY2tldHMpCj4gKwlpZiAoIXN0YXRzLnBhY2tldHMpCj4g
ICAJCXJldHVybjsKPiAgIAo+ICAgCXU2NF9zdGF0c191cGRhdGVfYmVnaW4oJnNxLT5zdGF0cy5z
eW5jcCk7Cj4gLQlzcS0+c3RhdHMuYnl0ZXMgKz0gYnl0ZXM7Cj4gLQlzcS0+c3RhdHMucGFja2V0
cyArPSBwYWNrZXRzOwo+ICsJc3EtPnN0YXRzLmJ5dGVzICs9IHN0YXRzLmJ5dGVzOwo+ICsJc3Et
PnN0YXRzLnBhY2tldHMgKz0gc3RhdHMucGFja2V0czsKPiAgIAl1NjRfc3RhdHNfdXBkYXRlX2Vu
ZCgmc3EtPnN0YXRzLnN5bmNwKTsKPiAgIH0KPiAgIAo+IEBAIC0xNDYzLDcgKzE0NTMsNyBAQCBz
dGF0aWMgdm9pZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAqcnEp
Cj4gICAJCXJldHVybjsKPiAgIAo+ICAgCWlmIChfX25ldGlmX3R4X3RyeWxvY2sodHhxKSkgewo+
IC0JCWZyZWVfb2xkX3htaXRfc2ticyhzcSwgdHJ1ZSk7Cj4gKwkJZnJlZV9vbGRfeG1pdChzcSwg
dHJ1ZSk7Cj4gICAJCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7Cj4gICAJfQo+ICAgCj4gQEAgLTE1
NDgsNyArMTUzOCw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9wb2xsX3R4KHN0cnVjdCBuYXBpX3N0
cnVjdCAqbmFwaSwgaW50IGJ1ZGdldCkKPiAgIAo+ICAgCXR4cSA9IG5ldGRldl9nZXRfdHhfcXVl
dWUodmktPmRldiwgaW5kZXgpOwo+ICAgCV9fbmV0aWZfdHhfbG9jayh0eHEsIHJhd19zbXBfcHJv
Y2Vzc29yX2lkKCkpOwo+IC0JZnJlZV9vbGRfeG1pdF9za2JzKHNxLCB0cnVlKTsKPiArCWZyZWVf
b2xkX3htaXQoc3EsIHRydWUpOwo+ICAgCV9fbmV0aWZfdHhfdW5sb2NrKHR4cSk7Cj4gICAKPiAg
IAl2aXJ0cXVldWVfbmFwaV9jb21wbGV0ZShuYXBpLCBzcS0+dnEsIDApOwo+IEBAIC0xNjE3LDcg
KzE2MDcsNyBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAgCWJvb2wgdXNlX25hcGkgPSBzcS0+bmFw
aS53ZWlnaHQ7Cj4gICAKPiAgIAkvKiBGcmVlIHVwIGFueSBwZW5kaW5nIG9sZCBidWZmZXJzIGJl
Zm9yZSBxdWV1ZWluZyBuZXcgb25lcy4gKi8KPiAtCWZyZWVfb2xkX3htaXRfc2ticyhzcSwgZmFs
c2UpOwo+ICsJZnJlZV9vbGRfeG1pdChzcSwgZmFsc2UpOwo+ICAgCj4gICAJaWYgKHVzZV9uYXBp
ICYmIGtpY2spCj4gICAJCXZpcnRxdWV1ZV9lbmFibGVfY2JfZGVsYXllZChzcS0+dnEpOwo+IEBA
IC0xNjYxLDcgKzE2NTEsNyBAQCBzdGF0aWMgbmV0ZGV2X3R4X3Qgc3RhcnRfeG1pdChzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ICAgCQlpZiAoIXVzZV9uYXBp
ICYmCj4gICAJCSAgICB1bmxpa2VseSghdmlydHF1ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHNxLT52
cSkpKSB7Cj4gICAJCQkvKiBNb3JlIGp1c3QgZ290IHVzZWQsIGZyZWUgdGhlbSB0aGVuIHJlY2hl
Y2suICovCj4gLQkJCWZyZWVfb2xkX3htaXRfc2ticyhzcSwgZmFsc2UpOwo+ICsJCQlmcmVlX29s
ZF94bWl0KHNxLCBmYWxzZSk7Cj4gICAJCQlpZiAoc3EtPnZxLT5udW1fZnJlZSA+PSAyK01BWF9T
S0JfRlJBR1MpIHsKPiAgIAkJCQluZXRpZl9zdGFydF9zdWJxdWV1ZShkZXYsIHFudW0pOwo+ICAg
CQkJCXZpcnRxdWV1ZV9kaXNhYmxlX2NiKHNxLT52cSk7CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
