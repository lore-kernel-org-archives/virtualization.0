Return-Path: <SRS0=YToA=IC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A471C433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 07:00:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7EC864EE4
	for <virtualization@archiver.kernel.org>; Thu,  4 Mar 2021 07:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7EC864EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 72EB649DEA;
	Thu,  4 Mar 2021 07:00:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kA25dTbbpey2; Thu,  4 Mar 2021 07:00:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08C4F4981D;
	Thu,  4 Mar 2021 07:00:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3D83C000A;
	Thu,  4 Mar 2021 07:00:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F7C4C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 07:00:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA629834BA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 07:00:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mTk35Gxu9s8K
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 07:00:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BA468349A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Mar 2021 06:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614841198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GWD3fPcp3FG/R9bDKdREFBmnHOESW2KvfRo/SFt+d/o=;
 b=NdbPJvtFgM3yoN0xnmefMgUmS89Xi+8w62X+1XP7OpqX2whYMq0hTLpNp7BcB0q55w81AN
 JUng0yCtZs++Th+uF1PL/TI3ftLEd4OyV+BZ7d0iovwQFcS9tcAg0wx0m4Ych5fMlDmQeQ
 vx2oD9egIRoud2si+/KQBtZMAO3JbGA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-OYQPMdC5Niqx3OoRkA14Ew-1; Thu, 04 Mar 2021 01:59:55 -0500
X-MC-Unique: OYQPMdC5Niqx3OoRkA14Ew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A090657;
 Thu,  4 Mar 2021 06:59:52 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-12-113.pek2.redhat.com
 [10.72.12.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F28B16268E;
 Thu,  4 Mar 2021 06:59:40 +0000 (UTC)
Subject: Re: [RFC v4 10/11] vduse: Introduce a workqueue for irq injection
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 stefanha@redhat.com, sgarzare@redhat.com, parav@nvidia.com,
 bob.liu@oracle.com, hch@infradead.org, rdunlap@infradead.org,
 willy@infradead.org, viro@zeniv.linux.org.uk, axboe@kernel.dk,
 bcrl@kvack.org, corbet@lwn.net
References: <20210223115048.435-1-xieyongji@bytedance.com>
 <20210223115048.435-11-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d63e4cfd-4992-8493-32b0-18e0478f6e1a@redhat.com>
Date: Thu, 4 Mar 2021 14:59:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210223115048.435-11-xieyongji@bytedance.com>
Content-Language: en-GB
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: linux-aio@kvack.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMi8yMyA3OjUwIOS4i+WNiCwgWGllIFlvbmdqaSB3cm90ZToKPiBUaGlzIHBhdGNo
IGludHJvZHVjZXMgYSB3b3JrcXVldWUgdG8gc3VwcG9ydCBpbmplY3RpbmcKPiB2aXJ0cXVldWUn
cyBpbnRlcnJ1cHQgYXN5bmNocm9ub3VzbHkuIFRoaXMgaXMgbWFpbmx5Cj4gZm9yIHBlcmZvcm1h
bmNlIGNvbnNpZGVyYXRpb25zIHdoaWNoIG1ha2VzIHN1cmUgdGhlIHB1c2goKQo+IGFuZCBwb3Ao
KSBmb3IgdXNlZCB2cmluZyBjYW4gYmUgYXN5bmNocm9ub3VzLgoKCkRvIHlvdSBoYXZlIHByZWYg
bnVtYmVycyBmb3IgdGhpcyBwYXRjaD8KClRoYW5rcwoKCj4KPiBTaWduZWQtb2ZmLWJ5OiBYaWUg
WW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92
ZHBhX3VzZXIvdmR1c2VfZGV2LmMgfCAyOSArKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQo+
ICAgMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMv
dmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMKPiBpbmRleCA4MDQyZDNmYTU3ZjEuLmY1YWRlYjll
ZTAyNyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4g
KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+IEBAIC00Miw2ICs0Miw3
IEBAIHN0cnVjdCB2ZHVzZV92aXJ0cXVldWUgewo+ICAgCXNwaW5sb2NrX3QgaXJxX2xvY2s7Cj4g
ICAJc3RydWN0IGV2ZW50ZmRfY3R4ICpraWNrZmQ7Cj4gICAJc3RydWN0IHZkcGFfY2FsbGJhY2sg
Y2I7Cj4gKwlzdHJ1Y3Qgd29ya19zdHJ1Y3QgaW5qZWN0Owo+ICAgfTsKPiAgIAo+ICAgc3RydWN0
IHZkdXNlX2RldjsKPiBAQCAtOTksNiArMTAwLDcgQEAgc3RhdGljIERFRklORV9JREEodmR1c2Vf
aWRhKTsKPiAgIAo+ICAgc3RhdGljIGRldl90IHZkdXNlX21ham9yOwo+ICAgc3RhdGljIHN0cnVj
dCBjbGFzcyAqdmR1c2VfY2xhc3M7Cj4gK3N0YXRpYyBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAq
dmR1c2VfaXJxX3dxOwo+ICAgCj4gICBzdGF0aWMgaW5saW5lIHN0cnVjdCB2ZHVzZV9kZXYgKnZk
cGFfdG9fdmR1c2Uoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICAgewo+IEBAIC04NTIsNiAr
ODU0LDE3IEBAIHN0YXRpYyBpbnQgdmR1c2Vfa2lja2ZkX3NldHVwKHN0cnVjdCB2ZHVzZV9kZXYg
KmRldiwKPiAgIAlyZXR1cm4gMDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgdm9pZCB2ZHVzZV92cV9p
cnFfaW5qZWN0KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiArewo+ICsJc3RydWN0IHZkdXNl
X3ZpcnRxdWV1ZSAqdnEgPSBjb250YWluZXJfb2Yod29yaywKPiArCQkJCQlzdHJ1Y3QgdmR1c2Vf
dmlydHF1ZXVlLCBpbmplY3QpOwo+ICsKPiArCXNwaW5fbG9ja19pcnEoJnZxLT5pcnFfbG9jayk7
Cj4gKwlpZiAodnEtPnJlYWR5ICYmIHZxLT5jYi5jYWxsYmFjaykKPiArCQl2cS0+Y2IuY2FsbGJh
Y2sodnEtPmNiLnByaXZhdGUpOwo+ICsJc3Bpbl91bmxvY2tfaXJxKCZ2cS0+aXJxX2xvY2spOwo+
ICt9Cj4gKwo+ICAgc3RhdGljIGxvbmcgdmR1c2VfZGV2X2lvY3RsKHN0cnVjdCBmaWxlICpmaWxl
LCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgCQkJdW5zaWduZWQgbG9uZyBhcmcpCj4gICB7Cj4gQEAg
LTkxNywxMiArOTMwLDcgQEAgc3RhdGljIGxvbmcgdmR1c2VfZGV2X2lvY3RsKHN0cnVjdCBmaWxl
ICpmaWxlLCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgCQkJYnJlYWs7Cj4gICAKPiAgIAkJdnEgPSAm
ZGV2LT52cXNbYXJnXTsKPiAtCQlzcGluX2xvY2tfaXJxKCZ2cS0+aXJxX2xvY2spOwo+IC0JCWlm
ICh2cS0+cmVhZHkgJiYgdnEtPmNiLmNhbGxiYWNrKSB7Cj4gLQkJCXZxLT5jYi5jYWxsYmFjayh2
cS0+Y2IucHJpdmF0ZSk7Cj4gLQkJCXJldCA9IDA7Cj4gLQkJfQo+IC0JCXNwaW5fdW5sb2NrX2ly
cSgmdnEtPmlycV9sb2NrKTsKPiArCQlxdWV1ZV93b3JrKHZkdXNlX2lycV93cSwgJnZxLT5pbmpl
Y3QpOwo+ICAgCQlicmVhazsKPiAgIAl9Cj4gICAJY2FzZSBWRFVTRV9JTkpFQ1RfQ09ORklHX0lS
UToKPiBAQCAtMTEwOSw2ICsxMTE3LDcgQEAgc3RhdGljIGludCB2ZHVzZV9jcmVhdGVfZGV2KHN0
cnVjdCB2ZHVzZV9kZXZfY29uZmlnICpjb25maWcpCj4gICAKPiAgIAlmb3IgKGkgPSAwOyBpIDwg
ZGV2LT52cV9udW07IGkrKykgewo+ICAgCQlkZXYtPnZxc1tpXS5pbmRleCA9IGk7Cj4gKwkJSU5J
VF9XT1JLKCZkZXYtPnZxc1tpXS5pbmplY3QsIHZkdXNlX3ZxX2lycV9pbmplY3QpOwo+ICAgCQlz
cGluX2xvY2tfaW5pdCgmZGV2LT52cXNbaV0ua2lja19sb2NrKTsKPiAgIAkJc3Bpbl9sb2NrX2lu
aXQoJmRldi0+dnFzW2ldLmlycV9sb2NrKTsKPiAgIAl9Cj4gQEAgLTEzMzMsNiArMTM0MiwxMSBA
QCBzdGF0aWMgaW50IHZkdXNlX2luaXQodm9pZCkKPiAgIAlpZiAocmV0KQo+ICAgCQlnb3RvIGVy
cl9jaGFyZGV2Owo+ICAgCj4gKwl2ZHVzZV9pcnFfd3EgPSBhbGxvY193b3JrcXVldWUoInZkdXNl
LWlycSIsCj4gKwkJCQlXUV9ISUdIUFJJIHwgV1FfU1lTRlMgfCBXUV9VTkJPVU5ELCAwKTsKPiAr
CWlmICghdmR1c2VfaXJxX3dxKQo+ICsJCWdvdG8gZXJyX3dxOwo+ICsKPiAgIAlyZXQgPSB2ZHVz
ZV9kb21haW5faW5pdCgpOwo+ICAgCWlmIChyZXQpCj4gICAJCWdvdG8gZXJyX2RvbWFpbjsKPiBA
QCAtMTM0NCw2ICsxMzU4LDggQEAgc3RhdGljIGludCB2ZHVzZV9pbml0KHZvaWQpCj4gICAJcmV0
dXJuIDA7Cj4gICBlcnJfbWdtdGRldjoKPiAgIAl2ZHVzZV9kb21haW5fZXhpdCgpOwo+ICtlcnJf
d3E6Cj4gKwlkZXN0cm95X3dvcmtxdWV1ZSh2ZHVzZV9pcnFfd3EpOwo+ICAgZXJyX2RvbWFpbjoK
PiAgIAl1bnJlZ2lzdGVyX2NocmRldl9yZWdpb24odmR1c2VfbWFqb3IsIFZEVVNFX0RFVl9NQVgp
Owo+ICAgZXJyX2NoYXJkZXY6Cj4gQEAgLTEzNTksNiArMTM3NSw3IEBAIHN0YXRpYyB2b2lkIHZk
dXNlX2V4aXQodm9pZCkKPiAgIAltaXNjX2RlcmVnaXN0ZXIoJnZkdXNlX21pc2MpOwo+ICAgCWNs
YXNzX2Rlc3Ryb3kodmR1c2VfY2xhc3MpOwo+ICAgCXVucmVnaXN0ZXJfY2hyZGV2X3JlZ2lvbih2
ZHVzZV9tYWpvciwgVkRVU0VfREVWX01BWCk7Cj4gKwlkZXN0cm95X3dvcmtxdWV1ZSh2ZHVzZV9p
cnFfd3EpOwo+ICAgCXZkdXNlX2RvbWFpbl9leGl0KCk7Cj4gICAJdmR1c2VfbWdtdGRldl9leGl0
KCk7Cj4gICB9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
