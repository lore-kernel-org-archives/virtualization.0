Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD74C433E0
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 08:39:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E212523403
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 08:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E212523403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 842C586CF3;
	Fri,  8 Jan 2021 08:39:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fxHH6cjlLVoA; Fri,  8 Jan 2021 08:39:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A92B886CE0;
	Fri,  8 Jan 2021 08:39:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B9BAC0891;
	Fri,  8 Jan 2021 08:39:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ABE62C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 08:39:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9643586CE0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 08:39:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wCfF0vE2k96
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 08:39:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 943C986CF8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 08:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610095150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=naJFZbBBW8Z/PipZop5jp7RZQislmTLGZO8Bd0Lmm8M=;
 b=LpSwlU0iwlfYYjxgurDyusy82gyerl0dfnv4IV83Oymb8NRtCZRZNQS0y9YRgVf1N/Bx9p
 tdZS1dOAizXgIPeyS3uEhynlfWEQUBKbPrbwQAtcpDSi20tnTc3ECOVWQkQFmAViQNZsrH
 iZh/65SLBRACq8cTWM9n9w1E7XZHP8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-sWW27GvwNcesngDnpIJc_A-1; Fri, 08 Jan 2021 03:39:06 -0500
X-MC-Unique: sWW27GvwNcesngDnpIJc_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55F8D1005504;
 Fri,  8 Jan 2021 08:39:05 +0000 (UTC)
Received: from [10.72.12.229] (ovpn-12-229.pek2.redhat.com [10.72.12.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 975E75B4BD;
 Fri,  8 Jan 2021 08:38:59 +0000 (UTC)
Subject: Re: [PATCH v1] vdpa/mlx5: Fix memory key MTT population
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20210107071845.GA224876@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <07d336a3-7fc2-5e4a-667a-495b5bb755da@redhat.com>
Date: Fri, 8 Jan 2021 16:38:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210107071845.GA224876@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: lulu@redhat.com
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

Ck9uIDIwMjEvMS83IOS4i+WNiDM6MTgsIEVsaSBDb2hlbiB3cm90ZToKPiBtYXBfZGlyZWN0X21y
KCkgYXNzdW1lZCB0aGF0IHRoZSBudW1iZXIgb2Ygc2NhdHRlci9nYXRoZXIgZW50cmllcwo+IHJl
dHVybmVkIGJ5IGRtYV9tYXBfc2dfYXR0cnMoKSB3YXMgZXF1YWwgdG8gdGhlIG51bWJlciBvZiBz
ZWdtZW50cyBpbgo+IHRoZSBzZ2wgbGlzdC4gVGhpcyBsZWQgdG8gd3JvbmcgcG9wdWxhdGlvbiBv
ZiB0aGUgbWtleSBvYmplY3QuIEZpeCB0aGlzCj4gYnkgcHJvcGVybHkgcmVmZXJyaW5nIHRvIHRo
ZSByZXR1cm5lZCB2YWx1ZS4KPgo+IFRoZSBoYXJkd2FyZSBleHBlY3RzIGVhY2ggTVRUIGVudHJ5
IHRvIGNvbnRhaW4gdGhlIERNQSBhZGRyZXNzIG9mIGEKPiBjb250aWd1b3VzIGJsb2NrIG9mIG1l
bW9yeSBvZiBzaXplICgxIDw8IG1yLT5sb2dfc2l6ZSkgYnl0ZXMuCj4gZG1hX21hcF9zZ19hdHRy
cygpIGNhbiBjb2FsZXNjZSBzZXZlcmFsIHNnIGVudHJpZXMgaW50byBhIHNpbmdsZQo+IHNjYXR0
ZXIvZ2F0aGVyIGVudHJ5IG9mIGNvbnRpZ3VvdXMgRE1BIHJhbmdlIHNvIHdlIG5lZWQgdG8gc2Nh
biB0aGUgbGlzdAo+IGFuZCByZWZlciB0byB0aGUgc2l6ZSBvZiBlYWNoIHMvZyBlbnRyeS4KPgo+
IEluIGFkZGl0aW9uLCBnZXQgcmlkIG9mIGZpbGxfc2coKSB3aGljaCBlZmZlY3QgaXMgb3Zlcndy
aXR0ZW4gYnkKPiBwb3B1bGF0ZV9tdHRzKCkuCj4KPiBGaXhlczogOTRhYmJjY2RmMjkxICgidmRw
YS9tbHg1OiBBZGQgc2hhcmVkIG1lbW9yeSByZWdpc3RyYXRpb24gY29kZSIpCj4gU2lnbmVkLW9m
Zi1ieTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4gLS0tCj4gVjAtPlYxOgo+IDEuIEZp
eCB0eXBvcwo+IDIuIEltcHJvdmUgY2hhbmdlbG9nCgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+CgoKPgo+ICAgZHJpdmVycy92ZHBhL21seDUvY29yZS9tbHg1X3Zk
cGEuaCB8ICAxICsKPiAgIGRyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYyAgICAgICAgfCAyOCAr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCj4gICAyIGZpbGVzIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9t
bHg1L2NvcmUvbWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5o
Cj4gaW5kZXggNWM5MmE1NzZlZGFlLi4wOGY3NDJmZDI0MDkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92ZHBhL21seDUvY29yZS9tbHg1X3ZkcGEuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbWx4NV92ZHBhLmgKPiBAQCAtMTUsNiArMTUsNyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVj
dF9tciB7Cj4gICAJc3RydWN0IHNnX3RhYmxlIHNnX2hlYWQ7Cj4gICAJaW50IGxvZ19zaXplOwo+
ICAgCWludCBuc2c7Cj4gKwlpbnQgbmVudDsKPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7Cj4g
ICAJdTY0IG9mZnNldDsKPiAgIH07Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbXIuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+IGluZGV4IDRiNjE5NTY2NmM1
OC4uZDMwMGY3OTllZmNkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIu
Ywo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbXIuYwo+IEBAIC0yNSwxNyArMjUsNiBA
QCBzdGF0aWMgaW50IGdldF9vY3RvX2xlbih1NjQgbGVuLCBpbnQgcGFnZV9zaGlmdCkKPiAgIAly
ZXR1cm4gKG5wYWdlcyArIDEpIC8gMjsKPiAgIH0KPiAgIAo+IC1zdGF0aWMgdm9pZCBmaWxsX3Nn
KHN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0X21yICptciwgdm9pZCAqaW4pCj4gLXsKPiAtCXN0cnVj
dCBzY2F0dGVybGlzdCAqc2c7Cj4gLQlfX2JlNjQgKnBhczsKPiAtCWludCBpOwo+IC0KPiAtCXBh
cyA9IE1MWDVfQUREUl9PRihjcmVhdGVfbWtleV9pbiwgaW4sIGtsbV9wYXNfbXR0KTsKPiAtCWZv
cl9lYWNoX3NnKG1yLT5zZ19oZWFkLnNnbCwgc2csIG1yLT5uc2csIGkpCj4gLQkJKCpwYXMpID0g
Y3B1X3RvX2JlNjQoc2dfZG1hX2FkZHJlc3Moc2cpKTsKPiAtfQo+IC0KPiAgIHN0YXRpYyB2b2lk
IG1seDVfc2V0X2FjY2Vzc19tb2RlKHZvaWQgKm1rYywgaW50IG1vZGUpCj4gICB7Cj4gICAJTUxY
NV9TRVQobWtjLCBta2MsIGFjY2Vzc19tb2RlXzFfMCwgbW9kZSAmIDB4Myk7Cj4gQEAgLTQ1LDEw
ICszNCwxOCBAQCBzdGF0aWMgdm9pZCBtbHg1X3NldF9hY2Nlc3NfbW9kZSh2b2lkICpta2MsIGlu
dCBtb2RlKQo+ICAgc3RhdGljIHZvaWQgcG9wdWxhdGVfbXR0cyhzdHJ1Y3QgbWx4NV92ZHBhX2Rp
cmVjdF9tciAqbXIsIF9fYmU2NCAqbXR0KQo+ICAgewo+ICAgCXN0cnVjdCBzY2F0dGVybGlzdCAq
c2c7Cj4gKwlpbnQgbnNnID0gbXItPm5zZzsKPiArCXU2NCBkbWFfYWRkcjsKPiArCXU2NCBkbWFf
bGVuOwo+ICsJaW50IGogPSAwOwo+ICAgCWludCBpOwo+ICAgCj4gLQlmb3JfZWFjaF9zZyhtci0+
c2dfaGVhZC5zZ2wsIHNnLCBtci0+bnNnLCBpKQo+IC0JCW10dFtpXSA9IGNwdV90b19iZTY0KHNn
X2RtYV9hZGRyZXNzKHNnKSk7Cj4gKwlmb3JfZWFjaF9zZyhtci0+c2dfaGVhZC5zZ2wsIHNnLCBt
ci0+bmVudCwgaSkgewo+ICsJCWZvciAoZG1hX2FkZHIgPSBzZ19kbWFfYWRkcmVzcyhzZyksIGRt
YV9sZW4gPSBzZ19kbWFfbGVuKHNnKTsKPiArCQkgICAgIG5zZyAmJiBkbWFfbGVuOwo+ICsJCSAg
ICAgbnNnLS0sIGRtYV9hZGRyICs9IEJJVChtci0+bG9nX3NpemUpLCBkbWFfbGVuIC09IEJJVCht
ci0+bG9nX3NpemUpKQo+ICsJCQltdHRbaisrXSA9IGNwdV90b19iZTY0KGRtYV9hZGRyKTsKPiAr
CX0KPiAgIH0KPiAgIAo+ICAgc3RhdGljIGludCBjcmVhdGVfZGlyZWN0X21yKHN0cnVjdCBtbHg1
X3ZkcGFfZGV2ICptdmRldiwgc3RydWN0IG1seDVfdmRwYV9kaXJlY3RfbXIgKm1yKQo+IEBAIC02
NCw3ICs2MSw2IEBAIHN0YXRpYyBpbnQgY3JlYXRlX2RpcmVjdF9tcihzdHJ1Y3QgbWx4NV92ZHBh
X2RldiAqbXZkZXYsIHN0cnVjdCBtbHg1X3ZkcGFfZGlyZWN0Cj4gICAJCXJldHVybiAtRU5PTUVN
Owo+ICAgCj4gICAJTUxYNV9TRVQoY3JlYXRlX21rZXlfaW4sIGluLCB1aWQsIG12ZGV2LT5yZXMu
dWlkKTsKPiAtCWZpbGxfc2cobXIsIGluKTsKPiAgIAlta2MgPSBNTFg1X0FERFJfT0YoY3JlYXRl
X21rZXlfaW4sIGluLCBtZW1vcnlfa2V5X21rZXlfZW50cnkpOwo+ICAgCU1MWDVfU0VUKG1rYywg
bWtjLCBsdywgISEobXItPnBlcm0gJiBWSE9TVF9NQVBfV08pKTsKPiAgIAlNTFg1X1NFVChta2Ms
IG1rYywgbHIsICEhKG1yLT5wZXJtICYgVkhPU1RfTUFQX1JPKSk7Cj4gQEAgLTI3Niw4ICsyNzIs
OCBAQCBzdGF0aWMgaW50IG1hcF9kaXJlY3RfbXIoc3RydWN0IG1seDVfdmRwYV9kZXYgKm12ZGV2
LCBzdHJ1Y3QgbWx4NV92ZHBhX2RpcmVjdF9tcgo+ICAgZG9uZToKPiAgIAltci0+bG9nX3NpemUg
PSBsb2dfZW50aXR5X3NpemU7Cj4gICAJbXItPm5zZyA9IG5zZzsKPiAtCWVyciA9IGRtYV9tYXBf
c2dfYXR0cnMoZG1hLCBtci0+c2dfaGVhZC5zZ2wsIG1yLT5uc2csIERNQV9CSURJUkVDVElPTkFM
LCAwKTsKPiAtCWlmICghZXJyKQo+ICsJbXItPm5lbnQgPSBkbWFfbWFwX3NnX2F0dHJzKGRtYSwg
bXItPnNnX2hlYWQuc2dsLCBtci0+bnNnLCBETUFfQklESVJFQ1RJT05BTCwgMCk7Cj4gKwlpZiAo
IW1yLT5uZW50KQo+ICAgCQlnb3RvIGVycl9tYXA7Cj4gICAKPiAgIAllcnIgPSBjcmVhdGVfZGly
ZWN0X21yKG12ZGV2LCBtcik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
