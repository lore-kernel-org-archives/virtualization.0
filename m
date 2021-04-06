Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E45C433B4
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 04:27:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 380BC613B7
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 04:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 380BC613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DED4540290;
	Tue,  6 Apr 2021 04:27:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dir_8JvVAIUK; Tue,  6 Apr 2021 04:27:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7CE7740249;
	Tue,  6 Apr 2021 04:27:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51D04C000C;
	Tue,  6 Apr 2021 04:27:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E497EC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 04:27:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D16EF40282
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 04:27:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bTTmJ4Fr6Bk6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 04:27:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C551840249
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 04:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617683254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/AFYn8wyf126xH7Xvsc600hQ8aGmO5+JH2/S4X8qpE=;
 b=ShCWr1jmdsucDsVh0edDk8IkfZrnpyk8d2B3mg7QQp9EVZNhJ8K9Bd4Wm/z0pJ7f2VYvZH
 Ik4/r19ybQvKFzvl6SG0xddW969VbipAuBZkah5fW7KunaPqvuH1RGtvpVcpj7gcrWsyWg
 2oOApunxhy5xXSKGI0VI9P3EzdDQUcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240--WbY4wkKMN2I-VutlISTYg-1; Tue, 06 Apr 2021 00:27:30 -0400
X-MC-Unique: -WbY4wkKMN2I-VutlISTYg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5B7B835BD1;
 Tue,  6 Apr 2021 04:27:26 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-96.pek2.redhat.com
 [10.72.13.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD5906267C;
 Tue,  6 Apr 2021 04:27:16 +0000 (UTC)
Subject: Re: [PATCH net-next v3 3/8] virtio-net: xsk zero copy xmit setup
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210331071139.15473-1-xuanzhuo@linux.alibaba.com>
 <20210331071139.15473-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <97a147bc-f9b8-ce95-889d-274893fd0444@redhat.com>
Date: Tue, 6 Apr 2021 12:27:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331071139.15473-4-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvMy8zMSDPws7nMzoxMSwgWHVhbiBaaHVvINC0tcA6Cj4geHNrIGlzIGEgaGlnaC1w
ZXJmb3JtYW5jZSBwYWNrZXQgcmVjZWl2aW5nIGFuZCBzZW5kaW5nIHRlY2hub2xvZ3kuCj4KPiBU
aGlzIHBhdGNoIGltcGxlbWVudHMgdGhlIGJpbmRpbmcgYW5kIHVuYmluZGluZyBvcGVyYXRpb25z
IG9mIHhzayBhbmQKPiB0aGUgdmlydGlvLW5ldCBxdWV1ZSBmb3IgeHNrIHplcm8gY29weSB4bWl0
Lgo+Cj4gVGhlIHhzayB6ZXJvIGNvcHkgeG1pdCBkZXBlbmRzIG9uIHR4IG5hcGkuIFNvIGlmIHR4
IG5hcGkgaXMgbm90IG9wZW5lZCwKPiBhbiBlcnJvciB3aWxsIGJlIHJlcG9ydGVkLiBBbmQgdGhl
IGVudGlyZSBvcGVyYXRpb24gaXMgdW5kZXIgdGhlCj4gcHJvdGVjdGlvbiBvZiBydG5sX2xvY2sK
Pgo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+
Cj4gUmV2aWV3ZWQtYnk6IER1c3QgTGkgPGR1c3QubGlAbGludXguYWxpYmFiYS5jb20+Cj4gLS0t
Cj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCA2NiArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygrKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+IGluZGV4IGJiNGVhOWRiYzE2Yi4uNGUyNTQwOGEyYjM3IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+IEBAIC0yMiw2ICsyMiw3IEBACj4gICAjaW5jbHVkZSA8bmV0L3JvdXRlLmg+Cj4gICAj
aW5jbHVkZSA8bmV0L3hkcC5oPgo+ICAgI2luY2x1ZGUgPG5ldC9uZXRfZmFpbG92ZXIuaD4KPiAr
I2luY2x1ZGUgPG5ldC94ZHBfc29ja19kcnYuaD4KPiAgIAo+ICAgc3RhdGljIGludCBuYXBpX3dl
aWdodCA9IE5BUElfUE9MTF9XRUlHSFQ7Cj4gICBtb2R1bGVfcGFyYW0obmFwaV93ZWlnaHQsIGlu
dCwgMDQ0NCk7Cj4gQEAgLTEzMyw2ICsxMzQsMTEgQEAgc3RydWN0IHNlbmRfcXVldWUgewo+ICAg
CXN0cnVjdCB2aXJ0bmV0X3NxX3N0YXRzIHN0YXRzOwo+ICAgCj4gICAJc3RydWN0IG5hcGlfc3Ry
dWN0IG5hcGk7Cj4gKwo+ICsJc3RydWN0IHsKPiArCQkvKiB4c2sgcG9vbCAqLwo+ICsJCXN0cnVj
dCB4c2tfYnVmZl9wb29sIF9fcmN1ICpwb29sOwo+ICsJfSB4c2s7Cj4gICB9Owo+ICAgCj4gICAv
KiBJbnRlcm5hbCByZXByZXNlbnRhdGlvbiBvZiBhIHJlY2VpdmUgdmlydHF1ZXVlICovCj4gQEAg
LTI1MjYsMTEgKzI1MzIsNzEgQEAgc3RhdGljIGludCB2aXJ0bmV0X3hkcF9zZXQoc3RydWN0IG5l
dF9kZXZpY2UgKmRldiwgc3RydWN0IGJwZl9wcm9nICpwcm9nLAo+ICAgCXJldHVybiBlcnI7Cj4g
ICB9Cj4gICAKPiArc3RhdGljIGludCB2aXJ0bmV0X3hza19wb29sX2VuYWJsZShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2LAo+ICsJCQkJICAgc3RydWN0IHhza19idWZmX3Bvb2wgKnBvb2wsCj4gKwkJ
CQkgICB1MTYgcWlkKQo+ICt7Cj4gKwlzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9w
cml2KGRldik7Cj4gKwlzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3E7Cj4gKwlpbnQgcmV0ID0gLUVCVVNZ
OwoKCkknZCByYXRoZXIgbW92ZSB0aGlzIHVuZGVyIHRoZSBjaGVjayBvZiB4c2sucG9vbC4KCgo+
ICsKPiArCWlmIChxaWQgPj0gdmktPmN1cnJfcXVldWVfcGFpcnMpCj4gKwkJcmV0dXJuIC1FSU5W
QUw7Cj4gKwo+ICsJc3EgPSAmdmktPnNxW3FpZF07Cj4gKwo+ICsJLyogeHNrIHplcm9jb3B5IGRl
cGVuZCBvbiB0aGUgdHggbmFwaSAqLwoKCk5lZWQgbW9yZSBjb21tZW50cyB0byBleHBsYWluIHdo
eSB0eCBOQVBJIGlzIHJlcXVpcmVkIGhlcmUuCgpBbmQgd2hhdCdzIG1vcmUgaW1wb3J0YW50LCB0
eCBOQVBJIGNvdWxkIGJlIGVuYWJsZWQvZGlzYWJsZSB2aWEgZXRodG9vbCwgCndoYXQgaWYgdGhl
IE5BUEkgaXMgZGlzYWJsZWQgYWZ0ZXIgeHNrIGlzIGVuYWJsZWQ/CgoKPiArCWlmICghc3EtPm5h
cGkud2VpZ2h0KQo+ICsJCXJldHVybiAtRVBFUk07Cj4gKwo+ICsJcmN1X3JlYWRfbG9jaygpOwo+
ICsJaWYgKHJjdV9kZXJlZmVyZW5jZShzcS0+eHNrLnBvb2wpKQo+ICsJCWdvdG8gZW5kOwoKClVu
ZGVyIHdoYXQgY29uZGl0aW9uIGNhbiB3ZSByZWFjaCBoZXJlPwoKCj4gKwo+ICsJLyogSGVyZSBp
cyBhbHJlYWR5IHByb3RlY3RlZCBieSBydG5sX2xvY2ssIHNvIHJjdV9hc3NpZ25fcG9pbnRlciBp
cwo+ICsJICogc2FmZS4KPiArCSAqLwo+ICsJcmN1X2Fzc2lnbl9wb2ludGVyKHNxLT54c2sucG9v
bCwgcG9vbCk7Cj4gKwlyZXQgPSAwOwo+ICtlbmQ6Cj4gKwlyY3VfcmVhZF91bmxvY2soKTsKPiAr
Cj4gKwlyZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICtzdGF0aWMgaW50IHZpcnRuZXRfeHNrX3Bvb2xf
ZGlzYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCB1MTYgcWlkKQo+ICt7Cj4gKwlzdHJ1Y3Qg
dmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gKwlzdHJ1Y3Qgc2VuZF9xdWV1
ZSAqc3E7Cj4gKwo+ICsJaWYgKHFpZCA+PSB2aS0+Y3Vycl9xdWV1ZV9wYWlycykKPiArCQlyZXR1
cm4gLUVJTlZBTDsKPiArCj4gKwlzcSA9ICZ2aS0+c3FbcWlkXTsKPiArCj4gKwkvKiBIZXJlIGlz
IGFscmVhZHkgcHJvdGVjdGVkIGJ5IHJ0bmxfbG9jaywgc28gcmN1X2Fzc2lnbl9wb2ludGVyIGlz
Cj4gKwkgKiBzYWZlLgo+ICsJICovCj4gKwlyY3VfYXNzaWduX3BvaW50ZXIoc3EtPnhzay5wb29s
LCBOVUxMKTsKPiArCj4gKwlzeW5jaHJvbml6ZV9yY3UoKTsgLyogU3luYyB3aXRoIHRoZSBYU0sg
d2FrZXVwIGFuZCB3aXRoIE5BUEkuICovCgoKU2luY2UgcnRubCBpcyBoZWxkIGhlcmUsIEkgZ3Vl
c3MgaXQncyBiZXR0ZXIgdG8gdXNlIHN5bmNob3JuaXplX25ldCgpLgoKCj4gKwo+ICsJcmV0dXJu
IDA7Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IHZpcnRuZXRfeGRwKHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYsIHN0cnVjdCBuZXRkZXZfYnBmICp4ZHApCj4gICB7Cj4gICAJc3dpdGNoICh4ZHAtPmNv
bW1hbmQpIHsKPiAgIAljYXNlIFhEUF9TRVRVUF9QUk9HOgo+ICAgCQlyZXR1cm4gdmlydG5ldF94
ZHBfc2V0KGRldiwgeGRwLT5wcm9nLCB4ZHAtPmV4dGFjayk7Cj4gKwljYXNlIFhEUF9TRVRVUF9Y
U0tfUE9PTDoKPiArCQkvKiB2aXJ0aW8gbmV0IG5vdCB1c2UgZG1hIGJlZm9yZSBjYWxsIHZyaW5n
IGFwaSAqLwo+ICsJCXhkcC0+eHNrLmNoZWNrX2RtYSA9IGZhbHNlOwoKCkkgdGhpbmsgaXQncyBi
ZXR0ZXIgbm90IG9wZW4gY29kZSB0aGluZ3MgbGlrZSB0aGlzLiBIb3cgYWJvdXQgaW50cm9kdWNl
IApuZXcgcGFyYW1ldGVycyBpbiB4cF9hc3NpZ25fZGV2KCk/CgoKPiArCQlpZiAoeGRwLT54c2su
cG9vbCkKPiArCQkJcmV0dXJuIHZpcnRuZXRfeHNrX3Bvb2xfZW5hYmxlKGRldiwgeGRwLT54c2su
cG9vbCwKPiArCQkJCQkJICAgICAgIHhkcC0+eHNrLnF1ZXVlX2lkKTsKPiArCQllbHNlCj4gKwkJ
CXJldHVybiB2aXJ0bmV0X3hza19wb29sX2Rpc2FibGUoZGV2LCB4ZHAtPnhzay5xdWV1ZV9pZCk7
Cj4gICAJZGVmYXVsdDoKPiAgIAkJcmV0dXJuIC1FSU5WQUw7Cj4gICAJfQoKClRoYW5rcwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
