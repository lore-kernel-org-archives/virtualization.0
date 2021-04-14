Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFF8C433ED
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 07:52:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A80861220
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 07:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A80861220
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1468540F1B;
	Wed, 14 Apr 2021 07:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gB_Omec-IV09; Wed, 14 Apr 2021 07:52:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A29B40EE7;
	Wed, 14 Apr 2021 07:52:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C451C000C;
	Wed, 14 Apr 2021 07:52:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44BD9C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 07:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3102140EEF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 07:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MtnVYvpd-pou
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 07:52:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 093C340EE7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 07:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618386719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QpV4QlutdUC0YACURiFDKFycuEucWOSaUyWywoS1lus=;
 b=YkorPT9Y0wAOybVxjOSh73u9yYk6TtG6Vf4q1D1d3WCXLlc04Cu903wHC6kRHVCsrzj1p7
 i+jMK/M0xVO7LdgT09hALEobPs7TvBgsnz+ivNsw/swjoUgizxUHUgXqlaCKAlhhDrRlnv
 Y5ewFsVZ1C1tnZoI1rnSUyW+Xr1B+ak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-GE-fulZ2NMGWijIvPHz59A-1; Wed, 14 Apr 2021 03:51:55 -0400
X-MC-Unique: GE-fulZ2NMGWijIvPHz59A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C50BBA40C1;
 Wed, 14 Apr 2021 07:51:52 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-33.pek2.redhat.com
 [10.72.13.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 41D1F5D6AC;
 Wed, 14 Apr 2021 07:51:42 +0000 (UTC)
Subject: Re: [PATCH net-next v4 08/10] virtio-net: xsk zero copy xmit setup
To: Magnus Karlsson <magnus.karlsson@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20210413031523.73507-1-xuanzhuo@linux.alibaba.com>
 <20210413031523.73507-9-xuanzhuo@linux.alibaba.com>
 <CAJ8uoz2LzrvZUsDfFuKiFkyRwdWtEk8AF9y7Nb6RKzB7pO3YDw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <93394cbc-ed6a-d07f-7f52-e584b48ca2cd@redhat.com>
Date: Wed, 14 Apr 2021 15:51:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAJ8uoz2LzrvZUsDfFuKiFkyRwdWtEk8AF9y7Nb6RKzB7pO3YDw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust . li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf <bpf@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
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

CuWcqCAyMDIxLzQvMTQg5LiL5Y2IMzozNiwgTWFnbnVzIEthcmxzc29uIOWGmemBkzoKPiBPbiBU
dWUsIEFwciAxMywgMjAyMSBhdCA5OjU4IEFNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+IHdyb3RlOgo+PiB4c2sgaXMgYSBoaWdoLXBlcmZvcm1hbmNlIHBhY2tldCByZWNl
aXZpbmcgYW5kIHNlbmRpbmcgdGVjaG5vbG9neS4KPj4KPj4gVGhpcyBwYXRjaCBpbXBsZW1lbnRz
IHRoZSBiaW5kaW5nIGFuZCB1bmJpbmRpbmcgb3BlcmF0aW9ucyBvZiB4c2sgYW5kCj4+IHRoZSB2
aXJ0aW8tbmV0IHF1ZXVlIGZvciB4c2sgemVybyBjb3B5IHhtaXQuCj4+Cj4+IFRoZSB4c2sgemVy
byBjb3B5IHhtaXQgZGVwZW5kcyBvbiB0eCBuYXBpLiBTbyBpZiB0eCBuYXBpIGlzIG5vdCB0cnVl
LAo+PiBhbiBlcnJvciB3aWxsIGJlIHJlcG9ydGVkLiBBbmQgdGhlIGVudGlyZSBvcGVyYXRpb24g
aXMgdW5kZXIgdGhlCj4+IHByb3RlY3Rpb24gb2YgcnRubF9sb2NrLgo+Pgo+PiBJZiB4c2sgaXMg
YWN0aXZlLCBpdCB3aWxsIHByZXZlbnQgZXRodG9vbCBmcm9tIG1vZGlmeWluZyB0eCBuYXBpLgo+
Pgo+PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29t
Pgo+PiBSZXZpZXdlZC1ieTogRHVzdCBMaSA8ZHVzdC5saUBsaW51eC5hbGliYWJhLmNvbT4KPj4g
LS0tCj4+ICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNzggKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA3NyBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4gaW5kZXggZjUyYTI1MDkxMzIyLi44
MjQyYTllOWYxN2QgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+PiAr
KysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4gQEAgLTIyLDYgKzIyLDcgQEAKPj4gICAj
aW5jbHVkZSA8bmV0L3JvdXRlLmg+Cj4+ICAgI2luY2x1ZGUgPG5ldC94ZHAuaD4KPj4gICAjaW5j
bHVkZSA8bmV0L25ldF9mYWlsb3Zlci5oPgo+PiArI2luY2x1ZGUgPG5ldC94ZHBfc29ja19kcnYu
aD4KPj4KPj4gICBzdGF0aWMgaW50IG5hcGlfd2VpZ2h0ID0gTkFQSV9QT0xMX1dFSUdIVDsKPj4g
ICBtb2R1bGVfcGFyYW0obmFwaV93ZWlnaHQsIGludCwgMDQ0NCk7Cj4+IEBAIC0xMzMsNiArMTM0
LDExIEBAIHN0cnVjdCBzZW5kX3F1ZXVlIHsKPj4gICAgICAgICAgc3RydWN0IHZpcnRuZXRfc3Ff
c3RhdHMgc3RhdHM7Cj4+Cj4+ICAgICAgICAgIHN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOwo+PiAr
Cj4+ICsgICAgICAgc3RydWN0IHsKPj4gKyAgICAgICAgICAgICAgIC8qIHhzayBwb29sICovCj4+
ICsgICAgICAgICAgICAgICBzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCBfX3JjdSAqcG9vbDsKPj4gKyAg
ICAgICB9IHhzazsKPj4gICB9Owo+Pgo+PiAgIC8qIEludGVybmFsIHJlcHJlc2VudGF0aW9uIG9m
IGEgcmVjZWl2ZSB2aXJ0cXVldWUgKi8KPj4gQEAgLTIyNDksOCArMjI1NSwxOSBAQCBzdGF0aWMg
aW50IHZpcnRuZXRfc2V0X2NvYWxlc2NlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4+ICAgICAg
ICAgIGlmIChuYXBpX3dlaWdodCBeIHZpLT5zcVswXS5uYXBpLndlaWdodCkgewo+PiAgICAgICAg
ICAgICAgICAgIGlmIChkZXYtPmZsYWdzICYgSUZGX1VQKQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIC1FQlVTWTsKPj4gLSAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCB2
aS0+bWF4X3F1ZXVlX3BhaXJzOyBpKyspCj4+ICsgICAgICAgICAgICAgICBmb3IgKGkgPSAwOyBp
IDwgdmktPm1heF9xdWV1ZV9wYWlyczsgaSsrKSB7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAg
IC8qIHhzayB4bWl0IGRlcGVuZCBvbiB0aGUgdHggbmFwaS4gU28gaWYgeHNrIGlzIGFjdGl2ZSwK
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICogcHJldmVudCBtb2RpZmljYXRpb25zIHRvIHR4
IG5hcGkuCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAqLwo+PiArICAgICAgICAgICAgICAg
ICAgICAgICByY3VfcmVhZF9sb2NrKCk7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmIChy
Y3VfZGVyZWZlcmVuY2UodmktPnNxW2ldLnhzay5wb29sKSkgewo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9jaygpOwo+PiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnRpbnVlOwo+PiArICAgICAgICAgICAgICAgICAgICAgICB9Cj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJjdV9yZWFkX3VubG9jaygpOwo+PiArCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICB2aS0+c3FbaV0ubmFwaS53ZWlnaHQgPSBuYXBpX3dlaWdodDsKPj4g
KyAgICAgICAgICAgICAgIH0KPj4gICAgICAgICAgfQo+Pgo+PiAgICAgICAgICByZXR1cm4gMDsK
Pj4gQEAgLTI1MTgsMTEgKzI1MzUsNzAgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9zZXQoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IGJwZl9wcm9nICpwcm9nLAo+PiAgICAgICAgICBy
ZXR1cm4gZXJyOwo+PiAgIH0KPj4KPj4gK3N0YXRpYyBpbnQgdmlydG5ldF94c2tfcG9vbF9lbmFi
bGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBzdHJ1Y3QgeHNrX2J1ZmZfcG9vbCAqcG9vbCwKPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB1MTYgcWlkKQo+PiArewo+PiArICAgICAgIHN0cnVjdCB2aXJ0bmV0
X2luZm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsKPj4gKyAgICAgICBzdHJ1Y3Qgc2VuZF9xdWV1
ZSAqc3E7Cj4+ICsKPj4gKyAgICAgICBpZiAocWlkID49IHZpLT5jdXJyX3F1ZXVlX3BhaXJzKQo+
PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gWW91ciBpbXBsZW1lbnRhdGlvbiBp
cyB0aGUgZmlyc3QgaW1wbGVtZW50YXRpb24gdGhhdCBvbmx5IHN1cHBvcnRzCj4gemVyb2NvcHkg
Zm9yIG9uZSBvdXQgb2YgUnggYW5kIFR4LCBhbmQgdGhpcyB3aWxsIGN1cnJlbnRseSBjb25mdXNl
IHRoZQo+IGNvbnRyb2wgcGxhbmUgaW4gc29tZSBzaXR1YXRpb25zIHNpbmNlIGl0IGFzc3VtZXMg
dGhhdCBib3RoIFJ4IGFuZCBUeAo+IGFyZSBlbmFibGVkIGJ5IGEgY2FsbCB0byB0aGlzIE5ETy4g
Rm9yIGV4YW1wbGU6IHVzZXIgc3BhY2UgY3JlYXRlcyBhbgo+IHhzayBzb2NrZXQgd2l0aCBib3Ro
IGFuIFJ4IGFuZCBhIFR4IHJpbmcsIHRoZW4gY2FsbHMgYmluZCB3aXRoIHRoZQo+IFhEUF9aRVJP
Q09QWSBmbGFnLiBJbiB0aGlzIGNhc2UsIHRoZSBjYWxsIHNob3VsZCBmYWlsIGlmIHRoZSBkZXZp
Y2UgaXMKPiB2aXJ0aW8tbmV0IHNpbmNlIGl0IG9ubHkgc3VwcG9ydHMgemVyb2NvcHkgZm9yIFR4
LiBCdXQgaXQgc2hvdWxkCj4gc3VjY2VlZCBpZiB0aGUgdXNlciBvbmx5IGNyZWF0ZWQgYSBUeCBy
aW5nIHNpbmNlIHRoYXQgbWFrZXMgaXQgYQo+IFR4LW9ubHkgc29ja2V0IHdoaWNoIGNhbiBiZSBz
dXBwb3J0ZWQuCj4KPiBTbyB5b3UgbmVlZCB0byBpbnRyb2R1Y2UgYSBuZXcgaW50ZXJmYWNlIGlu
IHhkcF9zb2NrX2Rydi5oIHRoYXQgY2FuIGJlCj4gdXNlZCB0byBhc2sgaWYgdGhpcyBzb2NrZXQg
aGFzIFJ4IGVuYWJsZWQgYW5kIGlmIHNvIGZhaWwgdGhlIGNhbGwgKGF0Cj4gbGVhc3Qgb25lIG9m
IHRoZW0gaGFzIHRvIGJlIGVuYWJsZWQsIG90aGVyd2lzZSB0aGUgYmluZCBjYWxsIHdvdWxkCj4g
ZmFpbCBiZWZvcmUgdGhpcyBuZG8gaXMgY2FsbGVkKS4gVGhlbiB0aGUgbG9naWMgYWJvdmUgd2ls
bCBhY3Qgb24gdGhhdAo+IGFuZCB0cnkgdG8gZmFsbCBiYWNrIHRvIGNvcHkgbW9kZSAoaWYgYWxs
b3dlZCkuIFN1Y2ggYW4gaW50ZXJmYWNlCj4gKHdpdGggYW4gYWRkZWQgImlzX3R4X2VuYWJsZWQi
KSBtaWdodCBpbiB0aGUgZnV0dXJlIGJlIHVzZWZ1bCBmb3IKPiBwaHlzaWNhbCBOSUMgZHJpdmVy
cyB0b28gaWYgdGhleSB3b3VsZCBsaWtlIHRvIHNhdmUgb24gcmVzb3VyY2VzIGZvcgo+IFR4LW9u
bHkgYW5kIFJ4LW9ubHkgc29ja2V0cy4gQ3VycmVudGx5LCB0aGV5IGFsbCBqdXN0IGFzc3VtZSBl
dmVyeQo+IHNvY2tldCBpcyBSeCBhbmQgVHguCgoKU28gaWYgdGhlcmUncyBubyBibG9ja2VyIGZv
ciBpbXBsZW1lbnRpbmcgdGhlIHplcm9jb3B5IFJYLCBJIHRoaW5rIHdlJ2QgCmJldHRlciB0byBp
bXBsZW1lbnQgaXQgaW4gdGhpcyBzZXJpZXMgd2l0aG91dCBpbnRyb2R1Y2luZyBuZXcgQVBJcyBm
b3IgCnRoZSB1cHBlciBsYXllci4KClRoYW5rcwoKCj4KPiBUaGFua3M6IE1hZ251cwo+Cj4+ICsK
Pj4gKyAgICAgICBzcSA9ICZ2aS0+c3FbcWlkXTsKPj4gKwo+PiArICAgICAgIC8qIHhzayB6ZXJv
Y29weSBkZXBlbmQgb24gdGhlIHR4IG5hcGkuCj4+ICsgICAgICAgICoKPj4gKyAgICAgICAgKiB4
c2sgemVyb2NvcHkgeG1pdCBpcyBkcml2ZW4gYnkgdGhlIHR4IGludGVycnVwdC4gV2hlbiB0aGUg
ZGV2aWNlIGlzCj4+ICsgICAgICAgICogbm90IGJ1c3ksIG5hcGkgd2lsbCBiZSBjYWxsZWQgY29u
dGludW91c2x5IHRvIHNlbmQgZGF0YS4gV2hlbiB0aGUKPj4gKyAgICAgICAgKiBkZXZpY2UgaXMg
YnVzeSwgd2FpdCBmb3IgdGhlIG5vdGlmaWNhdGlvbiBpbnRlcnJ1cHQgYWZ0ZXIgdGhlCj4+ICsg
ICAgICAgICogaGFyZHdhcmUgaGFzIGZpbmlzaGVkIHByb2Nlc3NpbmcgdGhlIGRhdGEsIGFuZCBj
b250aW51ZSB0byBzZW5kIGRhdGEKPj4gKyAgICAgICAgKiBpbiBuYXBpLgo+PiArICAgICAgICAq
Lwo+PiArICAgICAgIGlmICghc3EtPm5hcGkud2VpZ2h0KQo+PiArICAgICAgICAgICAgICAgcmV0
dXJuIC1FUEVSTTsKPj4gKwo+PiArICAgICAgIHJjdV9yZWFkX2xvY2soKTsKPj4gKyAgICAgICAv
KiBIZXJlIGlzIGFscmVhZHkgcHJvdGVjdGVkIGJ5IHJ0bmxfbG9jaywgc28gcmN1X2Fzc2lnbl9w
b2ludGVyIGlzCj4+ICsgICAgICAgICogc2FmZS4KPj4gKyAgICAgICAgKi8KPj4gKyAgICAgICBy
Y3VfYXNzaWduX3BvaW50ZXIoc3EtPnhzay5wb29sLCBwb29sKTsKPj4gKyAgICAgICByY3VfcmVh
ZF91bmxvY2soKTsKPj4gKwo+PiArICAgICAgIHJldHVybiAwOwo+PiArfQo+PiArCj4+ICtzdGF0
aWMgaW50IHZpcnRuZXRfeHNrX3Bvb2xfZGlzYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB1
MTYgcWlkKQo+PiArewo+PiArICAgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2
X3ByaXYoZGV2KTsKPj4gKyAgICAgICBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3E7Cj4+ICsKPj4gKyAg
ICAgICBpZiAocWlkID49IHZpLT5jdXJyX3F1ZXVlX3BhaXJzKQo+PiArICAgICAgICAgICAgICAg
cmV0dXJuIC1FSU5WQUw7Cj4+ICsKPj4gKyAgICAgICBzcSA9ICZ2aS0+c3FbcWlkXTsKPj4gKwo+
PiArICAgICAgIC8qIEhlcmUgaXMgYWxyZWFkeSBwcm90ZWN0ZWQgYnkgcnRubF9sb2NrLCBzbyBy
Y3VfYXNzaWduX3BvaW50ZXIgaXMKPj4gKyAgICAgICAgKiBzYWZlLgo+PiArICAgICAgICAqLwo+
PiArICAgICAgIHJjdV9hc3NpZ25fcG9pbnRlcihzcS0+eHNrLnBvb2wsIE5VTEwpOwo+PiArCj4+
ICsgICAgICAgc3luY2hyb25pemVfbmV0KCk7IC8qIFN5bmMgd2l0aCB0aGUgWFNLIHdha2V1cCBh
bmQgd2l0aCBOQVBJLiAqLwo+PiArCj4+ICsgICAgICAgcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4g
ICBzdGF0aWMgaW50IHZpcnRuZXRfeGRwKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsIHN0cnVjdCBu
ZXRkZXZfYnBmICp4ZHApCj4+ICAgewo+PiAgICAgICAgICBzd2l0Y2ggKHhkcC0+Y29tbWFuZCkg
ewo+PiAgICAgICAgICBjYXNlIFhEUF9TRVRVUF9QUk9HOgo+PiAgICAgICAgICAgICAgICAgIHJl
dHVybiB2aXJ0bmV0X3hkcF9zZXQoZGV2LCB4ZHAtPnByb2csIHhkcC0+ZXh0YWNrKTsKPj4gKyAg
ICAgICBjYXNlIFhEUF9TRVRVUF9YU0tfUE9PTDoKPj4gKyAgICAgICAgICAgICAgIGlmICh4ZHAt
Pnhzay5wb29sKQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gdmlydG5ldF94c2tf
cG9vbF9lbmFibGUoZGV2LCB4ZHAtPnhzay5wb29sLAo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgeGRwLT54c2sucXVldWVfaWQpOwo+PiAr
ICAgICAgICAgICAgICAgZWxzZQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gdmly
dG5ldF94c2tfcG9vbF9kaXNhYmxlKGRldiwgeGRwLT54c2sucXVldWVfaWQpOwo+PiAgICAgICAg
ICBkZWZhdWx0Ogo+PiAgICAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOwo+PiAgICAgICAg
ICB9Cj4+IC0tCj4+IDIuMzEuMAo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
