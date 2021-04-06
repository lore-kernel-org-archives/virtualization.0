Return-Path: <SRS0=hGiF=JD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D73C433B4
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 06:59:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4177D613B7
	for <virtualization@archiver.kernel.org>; Tue,  6 Apr 2021 06:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4177D613B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 056E96075C;
	Tue,  6 Apr 2021 06:59:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kjgeaaVQK5pv; Tue,  6 Apr 2021 06:59:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D28E606F7;
	Tue,  6 Apr 2021 06:59:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F51FC000C;
	Tue,  6 Apr 2021 06:59:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFACAC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 06:59:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C5B5C4049C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 06:59:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BzyD_1qG1IrO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 06:59:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E791F40282
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 06:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617692363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MEh2o752ANYQ9L9YTCxFAQMwQEPClrn186DoZd/3tu4=;
 b=EK7EsUOVs+CN/FvgM59IiWJiUqM4C3cUjkxYtYHLq8BO1I2P/LmmRqvbwA0L9hrNB/FLT7
 vdA+tzNaPHE3Pop3rpQPqT4EXgwPPjfiqIFV25UjtnAi16ah9+/LNo/EFHfd87L7ytb3p5
 sscKrwTXV/gy0sJWzGnKHewaxb0WNkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-_QPCqdfDPSWjsL08fqIxGA-1; Tue, 06 Apr 2021 02:59:19 -0400
X-MC-Unique: _QPCqdfDPSWjsL08fqIxGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE1901018F70;
 Tue,  6 Apr 2021 06:59:16 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-95.pek2.redhat.com
 [10.72.13.95])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9BAA019D9F;
 Tue,  6 Apr 2021 06:59:01 +0000 (UTC)
Subject: Re: [PATCH net-next v3 6/8] virtio-net: xsk zero copy xmit kick by
 threshold
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
References: <20210331071139.15473-1-xuanzhuo@linux.alibaba.com>
 <20210331071139.15473-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b04d7110-95ec-0aec-a802-631baf260a62@redhat.com>
Date: Tue, 6 Apr 2021 14:59:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331071139.15473-7-xuanzhuo@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

CtTaIDIwMjEvMy8zMSDPws7nMzoxMSwgWHVhbiBaaHVvINC0tcA6Cj4gQWZ0ZXIgdGVzdGluZywg
dGhlIHBlcmZvcm1hbmNlIG9mIGNhbGxpbmcga2ljayBldmVyeSB0aW1lIGlzIG5vdCBzdGFibGUu
Cj4gQW5kIGlmIGFsbCB0aGUgcGFja2V0cyBhcmUgc2VudCBhbmQga2lja2VkIGFnYWluLCB0aGUg
cGVyZm9ybWFuY2UgaXMgbm90Cj4gZ29vZC4gU28gYWRkIGEgbW9kdWxlIHBhcmFtZXRlciB0byBz
cGVjaWZ5IGhvdyBtYW55IHBhY2tldHMgYXJlIHNlbnQgdG8KPiBjYWxsIGEga2ljay4KPgo+IDgg
aXMgYSByZWxhdGl2ZWx5IHN0YWJsZSB2YWx1ZSB3aXRoIHRoZSBiZXN0IHBlcmZvcm1hbmNlLgoK
ClBsZWFzZSBhZGQgc29tZSBwZXJmIG51bWJlcnMgaGVyZS4KClRoYW5rcwoKCj4KPiBTaWduZWQt
b2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+IFJldmlld2Vk
LWJ5OiBEdXN0IExpIDxkdXN0LmxpQGxpbnV4LmFsaWJhYmEuY29tPgo+IC0tLQo+ICAgZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jIHwgMjMgKysrKysrKysrKysrKysrKysrKystLS0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+
IGluZGV4IDI1OWZhZmNmNjAyOC4uZDdlOTVmNTU0NzhkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
bmV0L3ZpcnRpb19uZXQuYwo+ICsrKyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+IEBAIC0y
OSwxMCArMjksMTIgQEAgbW9kdWxlX3BhcmFtKG5hcGlfd2VpZ2h0LCBpbnQsIDA0NDQpOwo+ICAg
Cj4gICBzdGF0aWMgYm9vbCBjc3VtID0gdHJ1ZSwgZ3NvID0gdHJ1ZSwgbmFwaV90eCA9IHRydWU7
Cj4gICBzdGF0aWMgaW50IHhza19idWRnZXQgPSAzMjsKPiArc3RhdGljIGludCB4c2tfa2lja190
aHIgPSA4Owo+ICAgbW9kdWxlX3BhcmFtKGNzdW0sIGJvb2wsIDA0NDQpOwo+ICAgbW9kdWxlX3Bh
cmFtKGdzbywgYm9vbCwgMDQ0NCk7Cj4gICBtb2R1bGVfcGFyYW0obmFwaV90eCwgYm9vbCwgMDY0
NCk7Cj4gICBtb2R1bGVfcGFyYW0oeHNrX2J1ZGdldCwgaW50LCAwNjQ0KTsKPiArbW9kdWxlX3Bh
cmFtKHhza19raWNrX3RociwgaW50LCAwNjQ0KTsKPiAgIAo+ICAgLyogRklYTUU6IE1UVSBpbiBj
b25maWcuICovCj4gICAjZGVmaW5lIEdPT0RfUEFDS0VUX0xFTiAoRVRIX0hMRU4gKyBWTEFOX0hM
RU4gKyBFVEhfREFUQV9MRU4pCj4gQEAgLTI2MTIsNiArMjYxNCw4IEBAIHN0YXRpYyBpbnQgdmly
dG5ldF94c2tfeG1pdF9iYXRjaChzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsCj4gICAJc3RydWN0IHhk
cF9kZXNjIGRlc2M7Cj4gICAJaW50IGVyciwgcGFja2V0ID0gMDsKPiAgIAlpbnQgcmV0ID0gLUVB
R0FJTjsKPiArCWludCBuZWVkX2tpY2sgPSAwOwo+ICsJaW50IGtpY2tzID0gMDsKPiAgIAo+ICAg
CWlmIChzcS0+eHNrLmxhc3RfZGVzYy5hZGRyKSB7Cj4gICAJCWVyciA9IHZpcnRuZXRfeHNrX3ht
aXQoc3EsIHBvb2wsICZzcS0+eHNrLmxhc3RfZGVzYyk7Cj4gQEAgLTI2MTksNiArMjYyMyw3IEBA
IHN0YXRpYyBpbnQgdmlydG5ldF94c2tfeG1pdF9iYXRjaChzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3Es
Cj4gICAJCQlyZXR1cm4gLUVCVVNZOwo+ICAgCj4gICAJCSsrcGFja2V0Owo+ICsJCSsrbmVlZF9r
aWNrOwo+ICAgCQktLWJ1ZGdldDsKPiAgIAkJc3EtPnhzay5sYXN0X2Rlc2MuYWRkciA9IDA7Cj4g
ICAJfQo+IEBAIC0yNjQyLDEzICsyNjQ3LDI1IEBAIHN0YXRpYyBpbnQgdmlydG5ldF94c2tfeG1p
dF9iYXRjaChzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsCj4gICAJCX0KPiAgIAo+ICAgCQkrK3BhY2tl
dDsKPiArCQkrK25lZWRfa2ljazsKPiArCQlpZiAobmVlZF9raWNrID4geHNrX2tpY2tfdGhyKSB7
Cj4gKwkJCWlmICh2aXJ0cXVldWVfa2lja19wcmVwYXJlKHNxLT52cSkgJiYKPiArCQkJICAgIHZp
cnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkKPiArCQkJCSsra2lja3M7Cj4gKwo+ICsJCQluZWVkX2tp
Y2sgPSAwOwo+ICsJCX0KPiAgIAl9Cj4gICAKPiAgIAlpZiAocGFja2V0KSB7Cj4gLQkJaWYgKHZp
cnRxdWV1ZV9raWNrX3ByZXBhcmUoc3EtPnZxKSAmJgo+IC0JCSAgICB2aXJ0cXVldWVfbm90aWZ5
KHNxLT52cSkpIHsKPiArCQlpZiAobmVlZF9raWNrKSB7Cj4gKwkJCWlmICh2aXJ0cXVldWVfa2lj
a19wcmVwYXJlKHNxLT52cSkgJiYKPiArCQkJICAgIHZpcnRxdWV1ZV9ub3RpZnkoc3EtPnZxKSkK
PiArCQkJCSsra2lja3M7Cj4gKwkJfQo+ICsJCWlmIChraWNrcykgewo+ICAgCQkJdTY0X3N0YXRz
X3VwZGF0ZV9iZWdpbigmc3EtPnN0YXRzLnN5bmNwKTsKPiAtCQkJc3EtPnN0YXRzLmtpY2tzICs9
IDE7Cj4gKwkJCXNxLT5zdGF0cy5raWNrcyArPSBraWNrczsKPiAgIAkJCXU2NF9zdGF0c191cGRh
dGVfZW5kKCZzcS0+c3RhdHMuc3luY3ApOwo+ICAgCQl9Cj4gICAKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
