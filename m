Return-Path: <SRS0=6MyX=JZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1020FC433ED
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 08:43:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 878A16141F
	for <virtualization@archiver.kernel.org>; Wed, 28 Apr 2021 08:43:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878A16141F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1F7E940561;
	Wed, 28 Apr 2021 08:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ktcsLgi9lGOO; Wed, 28 Apr 2021 08:43:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id B043440551;
	Wed, 28 Apr 2021 08:43:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A27DC001C;
	Wed, 28 Apr 2021 08:43:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51B1EC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 08:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4022A60A52
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 08:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jXECuy8YD1QW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 08:43:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91A99605DA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Apr 2021 08:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619599384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1W52g62U8eu7kNC+tsNnm2qSHOwqXQwpPJN3IreWZiE=;
 b=cwi67XmjvwxkEk4XMIok8DS5StW6CphISuv2vS3m+0VaXGIXg9H0wEgSjeOPLY3NyGurnB
 xV58E4rzVSbVELwHghBLP6qUSpa+nTmzRyoSIJDKIpwKnsEL8IXswV3/ni8cJqeoAhYGIN
 PYPjhETr8Pn6g373Z3kd4fT8oHF7Mpo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-hAMRtaRlN_isfdaq7ctq8w-1; Wed, 28 Apr 2021 04:43:02 -0400
X-MC-Unique: hAMRtaRlN_isfdaq7ctq8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09BF710054F6;
 Wed, 28 Apr 2021 08:43:01 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-52.pek2.redhat.com
 [10.72.13.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 87E205F9C5;
 Wed, 28 Apr 2021 08:42:55 +0000 (UTC)
Subject: Re: [PATCH 2/2] vDPA/ifcvf: implement doorbell mapping for ifcvf
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210428082133.6766-1-lingshan.zhu@intel.com>
 <20210428082133.6766-3-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f6d9a424-9025-3eb5-1cb4-0ff22f7bec63@redhat.com>
Date: Wed, 28 Apr 2021 16:42:53 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428082133.6766-3-lingshan.zhu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CtTaIDIwMjEvNC8yOCDPws7nNDoyMSwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
aW1wbGVtZW50cyBkb29yYmVsbCBtYXBwaW5nIGZlYXR1cmUgZm9yIGlmY3ZmLgo+IFRoaXMgZmVh
dHVyZSBtYXBzIHRoZSBub3RpZnkgcGFnZSB0byB1c2Vyc3BhY2UsIHRvIGVsaW1pbmF0ZQo+IHZt
ZXhpdCB3aGVuIGtpY2sgYSB2cS4KPgo+IFNpZ25lZC1vZmYtYnk6IFpodSBMaW5nc2hhbiA8bGlu
Z3NoYW4uemh1QGludGVsLmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9t
YWluLmMgfCAxOCArKysrKysrKysrKysrKysrKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4u
YyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiBpbmRleCBlNDhlNmI3NGZlMmUu
LmFmY2I3MWJjMGY1MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IEBAIC00MTMsNiAr
NDEzLDIzIEBAIHN0YXRpYyBpbnQgaWZjdmZfdmRwYV9nZXRfdnFfaXJxKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRwYV9kZXYsCj4gICAJcmV0dXJuIHZmLT52cmluZ1txaWRdLmlycTsKPiAgIH0KPiAg
IAo+ICtzdGF0aWMgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgaWZjdmZfZ2V0X3ZxX25v
dGlmaWNhdGlvbihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+ICsJCQkJCQkJICAgICAg
IHUxNiBpZHgpCj4gK3sKPiArCXN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFf
ZGV2KTsKPiArCXN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIGFyZWE7Cj4gKwo+ICsJaWYg
KHZmLT5ub3RpZnlfcGEgJSBQQUdFX1NJWkUpIHsKPiArCQlhcmVhLmFkZHIgPSAwOwo+ICsJCWFy
ZWEuc2l6ZSA9IDA7CgoKV2UgZG9uJ3QgbmVlZCB0aGlzIHNpbmNlOgoKMSkgdGhlcmUncyBhIGNo
ZWNrIGluIHRoZSB2aG9zdCB2RFBBCjIpIGRldmljZSBpcyB1bmF3YXJlIG9mIHRoZSBib3VuZCBk
cml2ZXIsIG5vbiBwYWdlIGFsaWduZWQgZG9vcmJlbGwgCmRvZXNuJ3QgbmVjZXNzYXJpbHkgbWVh
bnQgaXQgY2FuIGJlIHVzZWQKCkxldCdzIGxlYXZlIHRob3NlIHBvbGljZXMgdG8gdGhlIGRyaXZl
ci4KClRoYW5rcwoKCj4gKwl9IGVsc2Ugewo+ICsJCWFyZWEuYWRkciA9IHZmLT5ub3RpZnlfcGE7
Cj4gKwkJYXJlYS5zaXplID0gUEFHRV9TSVpFOwo+ICsJfQo+ICsKPiArCXJldHVybiBhcmVhOwo+
ICt9Cj4gKwo+ICAgLyoKPiAgICAqIElGQ1ZGIGN1cnJlbnRseSBkb2VzJ3QgaGF2ZSBvbi1jaGlw
IElPTU1VLCBzbyBub3QKPiAgICAqIGltcGxlbWVudGVkIHNldF9tYXAoKS9kbWFfbWFwKCkvZG1h
X3VubWFwKCkKPiBAQCAtNDQwLDYgKzQ1Nyw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzIGlmY192ZHBhX29wcyA9IHsKPiAgIAkuZ2V0X2NvbmZpZwk9IGlmY3ZmX3ZkcGFf
Z2V0X2NvbmZpZywKPiAgIAkuc2V0X2NvbmZpZwk9IGlmY3ZmX3ZkcGFfc2V0X2NvbmZpZywKPiAg
IAkuc2V0X2NvbmZpZ19jYiAgPSBpZmN2Zl92ZHBhX3NldF9jb25maWdfY2IsCj4gKwkuZ2V0X3Zx
X25vdGlmaWNhdGlvbiA9IGlmY3ZmX2dldF92cV9ub3RpZmljYXRpb24sCj4gICB9Owo+ICAgCj4g
ICBzdGF0aWMgaW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1
Y3QgcGNpX2RldmljZV9pZCAqaWQpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
