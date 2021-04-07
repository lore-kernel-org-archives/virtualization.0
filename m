Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBABC433ED
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 09:01:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3ADB61262
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 09:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3ADB61262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 883A9849E0;
	Wed,  7 Apr 2021 09:01:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CiN-9dUWfMSZ; Wed,  7 Apr 2021 09:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F0B9849DF;
	Wed,  7 Apr 2021 09:01:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C21C3C000B;
	Wed,  7 Apr 2021 09:01:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CDE70C000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AEB0B40209
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:01:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5p0emgMW33Iu
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:01:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71992400BF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 09:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617786074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rkz4nKqmSi3Q6k0oz/hhB2XArXf+uraFndElilQ7l4Y=;
 b=KD+onLjAZxS/nW+aNR3SURgw4eoRN2hBYdHpCPzn/WaSsLPb3K/IiSjjhTJme6pFgMlpAp
 LyOqz185UEdINtCRpbdsr1c2tr/EXlwIExpjHC8K2h9sjxhC5s33ZQf8Tic31ewjyJw0WN
 9QgZQlVDyazMLxBwufht2OqO9Y6M5iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-qJLkybGIMl2vhBM809sq0g-1; Wed, 07 Apr 2021 05:01:10 -0400
X-MC-Unique: qJLkybGIMl2vhBM809sq0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D41B5B38D;
 Wed,  7 Apr 2021 09:01:08 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-236.pek2.redhat.com
 [10.72.13.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B86135D762;
 Wed,  7 Apr 2021 09:00:57 +0000 (UTC)
Subject: Re: [PATCH net-next v3 3/8] virtio-net: xsk zero copy xmit setup
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1617780476.5300975-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <67f0091a-e065-9183-04a0-4722e1fff84f@redhat.com>
Date: Wed, 7 Apr 2021 17:00:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1617780476.5300975-1-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Dust Li <dust.li@linux.alibaba.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, virtualization@lists.linux-foundation.org,
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

CuWcqCAyMDIxLzQvNyDkuIvljYgzOjI3LCBYdWFuIFpodW8g5YaZ6YGTOgo+IE9uIFR1ZSwgNiBB
cHIgMjAyMSAxMjoyNzoxNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4g
d3JvdGU6Cj4+IOWcqCAyMDIxLzMvMzEg5LiL5Y2IMzoxMSwgWHVhbiBaaHVvIOWGmemBkzoKPj4+
IHhzayBpcyBhIGhpZ2gtcGVyZm9ybWFuY2UgcGFja2V0IHJlY2VpdmluZyBhbmQgc2VuZGluZyB0
ZWNobm9sb2d5Lgo+Pj4KPj4+IFRoaXMgcGF0Y2ggaW1wbGVtZW50cyB0aGUgYmluZGluZyBhbmQg
dW5iaW5kaW5nIG9wZXJhdGlvbnMgb2YgeHNrIGFuZAo+Pj4gdGhlIHZpcnRpby1uZXQgcXVldWUg
Zm9yIHhzayB6ZXJvIGNvcHkgeG1pdC4KPj4+Cj4+PiBUaGUgeHNrIHplcm8gY29weSB4bWl0IGRl
cGVuZHMgb24gdHggbmFwaS4gU28gaWYgdHggbmFwaSBpcyBub3Qgb3BlbmVkLAo+Pj4gYW4gZXJy
b3Igd2lsbCBiZSByZXBvcnRlZC4gQW5kIHRoZSBlbnRpcmUgb3BlcmF0aW9uIGlzIHVuZGVyIHRo
ZQo+Pj4gcHJvdGVjdGlvbiBvZiBydG5sX2xvY2sKPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+Pj4gUmV2aWV3ZWQtYnk6IER1c3Qg
TGkgPGR1c3QubGlAbGludXguYWxpYmFiYS5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvbmV0
L3ZpcnRpb19uZXQuYyB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspCj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+Pj4gaW5kZXggYmI0ZWE5ZGJjMTZiLi40ZTI1NDA4YTJiMzcgMTAwNjQ0Cj4+PiAtLS0gYS9k
cml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
Ywo+Pj4gQEAgLTIyLDYgKzIyLDcgQEAKPj4+ICAgICNpbmNsdWRlIDxuZXQvcm91dGUuaD4KPj4+
ICAgICNpbmNsdWRlIDxuZXQveGRwLmg+Cj4+PiAgICAjaW5jbHVkZSA8bmV0L25ldF9mYWlsb3Zl
ci5oPgo+Pj4gKyNpbmNsdWRlIDxuZXQveGRwX3NvY2tfZHJ2Lmg+Cj4+Pgo+Pj4gICAgc3RhdGlj
IGludCBuYXBpX3dlaWdodCA9IE5BUElfUE9MTF9XRUlHSFQ7Cj4+PiAgICBtb2R1bGVfcGFyYW0o
bmFwaV93ZWlnaHQsIGludCwgMDQ0NCk7Cj4+PiBAQCAtMTMzLDYgKzEzNCwxMSBAQCBzdHJ1Y3Qg
c2VuZF9xdWV1ZSB7Cj4+PiAgICAJc3RydWN0IHZpcnRuZXRfc3Ffc3RhdHMgc3RhdHM7Cj4+Pgo+
Pj4gICAgCXN0cnVjdCBuYXBpX3N0cnVjdCBuYXBpOwo+Pj4gKwo+Pj4gKwlzdHJ1Y3Qgewo+Pj4g
KwkJLyogeHNrIHBvb2wgKi8KPj4+ICsJCXN0cnVjdCB4c2tfYnVmZl9wb29sIF9fcmN1ICpwb29s
Owo+Pj4gKwl9IHhzazsKPj4+ICAgIH07Cj4+Pgo+Pj4gICAgLyogSW50ZXJuYWwgcmVwcmVzZW50
YXRpb24gb2YgYSByZWNlaXZlIHZpcnRxdWV1ZSAqLwo+Pj4gQEAgLTI1MjYsMTEgKzI1MzIsNzEg
QEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9zZXQoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3Ry
dWN0IGJwZl9wcm9nICpwcm9nLAo+Pj4gICAgCXJldHVybiBlcnI7Cj4+PiAgICB9Cj4+Pgo+Pj4g
K3N0YXRpYyBpbnQgdmlydG5ldF94c2tfcG9vbF9lbmFibGUoc3RydWN0IG5ldF9kZXZpY2UgKmRl
diwKPj4+ICsJCQkJICAgc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wsCj4+PiArCQkJCSAgIHUx
NiBxaWQpCj4+PiArewo+Pj4gKwlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2
KGRldik7Cj4+PiArCXN0cnVjdCBzZW5kX3F1ZXVlICpzcTsKPj4+ICsJaW50IHJldCA9IC1FQlVT
WTsKPj4KPj4gSSdkIHJhdGhlciBtb3ZlIHRoaXMgdW5kZXIgdGhlIGNoZWNrIG9mIHhzay5wb29s
Lgo+Pgo+Pgo+Pj4gKwo+Pj4gKwlpZiAocWlkID49IHZpLT5jdXJyX3F1ZXVlX3BhaXJzKQo+Pj4g
KwkJcmV0dXJuIC1FSU5WQUw7Cj4+PiArCj4+PiArCXNxID0gJnZpLT5zcVtxaWRdOwo+Pj4gKwo+
Pj4gKwkvKiB4c2sgemVyb2NvcHkgZGVwZW5kIG9uIHRoZSB0eCBuYXBpICovCj4+Cj4+IE5lZWQg
bW9yZSBjb21tZW50cyB0byBleHBsYWluIHdoeSB0eCBOQVBJIGlzIHJlcXVpcmVkIGhlcmUuCj4+
Cj4+IEFuZCB3aGF0J3MgbW9yZSBpbXBvcnRhbnQsIHR4IE5BUEkgY291bGQgYmUgZW5hYmxlZC9k
aXNhYmxlIHZpYSBldGh0b29sLAo+PiB3aGF0IGlmIHRoZSBOQVBJIGlzIGRpc2FibGVkIGFmdGVy
IHhzayBpcyBlbmFibGVkPwo+Pgo+IElmIG5hcGlfdHggaXMgdHVybmVkIG9mZiwgdGhlbiB0aGUg
eG1pdCB3aWxsIGJlIGFmZmVjdGVkLgoKClBsZWFzZSBkb2N1bWVudCB3aGF0IGtpbmQgb2YgZWZm
ZWN0IHRoYXQgcHJldmVudHMgeHNrIGZyb20gd29ya2luZy4KCgo+IE1heWJlIEkKPiBzaG91bGQg
cmVzdHJpY3QgdGhhdCB0eCBOQVBJIGJlIGRpc2FibGUgdmlhIGV0aHRvb2wgYWZ0ZXIgeHNrIGlz
IGVuYWJsZWQuCgoKSXQgY2FuIHdvcmsuCgoKPgo+Pj4gKwlpZiAoIXNxLT5uYXBpLndlaWdodCkK
Pj4+ICsJCXJldHVybiAtRVBFUk07Cj4+PiArCj4+PiArCXJjdV9yZWFkX2xvY2soKTsKPj4+ICsJ
aWYgKHJjdV9kZXJlZmVyZW5jZShzcS0+eHNrLnBvb2wpKQo+Pj4gKwkJZ290byBlbmQ7Cj4+Cj4+
IFVuZGVyIHdoYXQgY29uZGl0aW9uIGNhbiB3ZSByZWFjaCBoZXJlPwo+IFdoZW4gdGhlIHVzZXIg
dHJpZXMgdG8gYmluZCByZXBlYXRlZGx5LgoKCk9rLCBJIGFtIGEgbGl0dGxlIHN1cHJpc2VkIHRo
YXQgaXQgd2FzIG5vdCBjaGVja2VkIGJ5IHhza19iaW5kKCkuCgoKCj4KPj4KPj4+ICsKPj4+ICsJ
LyogSGVyZSBpcyBhbHJlYWR5IHByb3RlY3RlZCBieSBydG5sX2xvY2ssIHNvIHJjdV9hc3NpZ25f
cG9pbnRlciBpcwo+Pj4gKwkgKiBzYWZlLgo+Pj4gKwkgKi8KPj4+ICsJcmN1X2Fzc2lnbl9wb2lu
dGVyKHNxLT54c2sucG9vbCwgcG9vbCk7Cj4+PiArCXJldCA9IDA7Cj4+PiArZW5kOgo+Pj4gKwly
Y3VfcmVhZF91bmxvY2soKTsKPj4+ICsKPj4+ICsJcmV0dXJuIHJldDsKPj4+ICt9Cj4+PiArCj4+
PiArc3RhdGljIGludCB2aXJ0bmV0X3hza19wb29sX2Rpc2FibGUoc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiwgdTE2IHFpZCkKPj4+ICt7Cj4+PiArCXN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0
ZGV2X3ByaXYoZGV2KTsKPj4+ICsJc3RydWN0IHNlbmRfcXVldWUgKnNxOwo+Pj4gKwo+Pj4gKwlp
ZiAocWlkID49IHZpLT5jdXJyX3F1ZXVlX3BhaXJzKQo+Pj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4+
PiArCj4+PiArCXNxID0gJnZpLT5zcVtxaWRdOwo+Pj4gKwo+Pj4gKwkvKiBIZXJlIGlzIGFscmVh
ZHkgcHJvdGVjdGVkIGJ5IHJ0bmxfbG9jaywgc28gcmN1X2Fzc2lnbl9wb2ludGVyIGlzCj4+PiAr
CSAqIHNhZmUuCj4+PiArCSAqLwo+Pj4gKwlyY3VfYXNzaWduX3BvaW50ZXIoc3EtPnhzay5wb29s
LCBOVUxMKTsKPj4+ICsKPj4+ICsJc3luY2hyb25pemVfcmN1KCk7IC8qIFN5bmMgd2l0aCB0aGUg
WFNLIHdha2V1cCBhbmQgd2l0aCBOQVBJLiAqLwo+Pgo+PiBTaW5jZSBydG5sIGlzIGhlbGQgaGVy
ZSwgSSBndWVzcyBpdCdzIGJldHRlciB0byB1c2Ugc3luY2hvcm5pemVfbmV0KCkuCj4+Cj4+Cj4+
PiArCj4+PiArCXJldHVybiAwOwo+Pj4gK30KPj4+ICsKPj4+ICAgIHN0YXRpYyBpbnQgdmlydG5l
dF94ZHAoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwgc3RydWN0IG5ldGRldl9icGYgKnhkcCkKPj4+
ICAgIHsKPj4+ICAgIAlzd2l0Y2ggKHhkcC0+Y29tbWFuZCkgewo+Pj4gICAgCWNhc2UgWERQX1NF
VFVQX1BST0c6Cj4+PiAgICAJCXJldHVybiB2aXJ0bmV0X3hkcF9zZXQoZGV2LCB4ZHAtPnByb2cs
IHhkcC0+ZXh0YWNrKTsKPj4+ICsJY2FzZSBYRFBfU0VUVVBfWFNLX1BPT0w6Cj4+PiArCQkvKiB2
aXJ0aW8gbmV0IG5vdCB1c2UgZG1hIGJlZm9yZSBjYWxsIHZyaW5nIGFwaSAqLwo+Pj4gKwkJeGRw
LT54c2suY2hlY2tfZG1hID0gZmFsc2U7Cj4+Cj4+IEkgdGhpbmsgaXQncyBiZXR0ZXIgbm90IG9w
ZW4gY29kZSB0aGluZ3MgbGlrZSB0aGlzLiBIb3cgYWJvdXQgaW50cm9kdWNlCj4+IG5ldyBwYXJh
bWV0ZXJzIGluIHhwX2Fzc2lnbl9kZXYoKT8KPiB4cF9hc3NpZ25fZGV2IGlzIGNhbGxlZCBieSB0
aGUgdXNlciwgd2Ugc2hvdWxkIGxldCB4c2sgcGVyY2VpdmUgdGhhdCB0aGUgY3VycmVudAo+IGRl
diBkb2VzIG5vdCBkaXJlY3RseSB1c2UgZG1hLiBJcyBpdCBwb3NzaWJsZSB0byB1c2UgZGV2LT5w
cml2X2ZsYWdzPyBJIG9ubHkKPiBrbm93IHRoYXQgdGhpcyBpcyB0aGUgY2FzZSB3aXRoIHZpcnRp
by1uZXQhIQoKCk9rLCB0aGVuIGl0IHNob3VsZCBiZSBmaW5lLCBidXQgd2UgbmVlZCBhIGJldHRl
ciBuYW1lIG90aGVyIHRoYW4gCiJjaGVja19kbWEiLiBNYXliZSAidXNlX2RtYV9hZGRyIiBpbnN0
ZWFkLgoKVGhhbmtzCgoKPgo+IFRoYW5rcyB2ZXJ5IG11Y2guCj4KPj4KPj4+ICsJCWlmICh4ZHAt
Pnhzay5wb29sKQo+Pj4gKwkJCXJldHVybiB2aXJ0bmV0X3hza19wb29sX2VuYWJsZShkZXYsIHhk
cC0+eHNrLnBvb2wsCj4+PiArCQkJCQkJICAgICAgIHhkcC0+eHNrLnF1ZXVlX2lkKTsKPj4+ICsJ
CWVsc2UKPj4+ICsJCQlyZXR1cm4gdmlydG5ldF94c2tfcG9vbF9kaXNhYmxlKGRldiwgeGRwLT54
c2sucXVldWVfaWQpOwo+Pj4gICAgCWRlZmF1bHQ6Cj4+PiAgICAJCXJldHVybiAtRUlOVkFMOwo+
Pj4gICAgCX0KPj4KPj4gVGhhbmtzCj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
