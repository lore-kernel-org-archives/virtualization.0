Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93911C433DB
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 02:56:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F15542245C
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 02:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F15542245C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9571785507;
	Mon, 18 Jan 2021 02:56:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zGcd3pLrCSgj; Mon, 18 Jan 2021 02:56:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1026A854C9;
	Mon, 18 Jan 2021 02:56:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D50ACC0FA7;
	Mon, 18 Jan 2021 02:55:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D88D0C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:55:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BF54D8702F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:55:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BLB7biQDri86
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:55:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BCB318702C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610938555;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=btsrrxo7mB11BqinBri0huz58VO1P3XSJaWNyk0vkAw=;
 b=ZsRyffWwmcGZmDXrvPJunymHPfn+OE3Rmk07hxR4dCwOZtZJl5s/X49PhUchiymFH/IFO/
 4h2fftg7P9fFxoPF6OyssTOt48cn5pOV9LsxhJMlZSgcvixfaByDtaJtm7K09iL6yRHRhq
 HORP+kRtPqg6ierNlF7hfSsy8+qokBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-40R2I4VhMpuBVHJQ-frJ2w-1; Sun, 17 Jan 2021 21:55:51 -0500
X-MC-Unique: 40R2I4VhMpuBVHJQ-frJ2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0898987950D;
 Mon, 18 Jan 2021 02:55:50 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D115100239A;
 Mon, 18 Jan 2021 02:55:45 +0000 (UTC)
Subject: Re: [PATCH] use pr_warn_ratelimited() for vq_err()
To: John Levon <john.levon@nutanix.com>, levon@movementarian.org,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
 mst@redhat.com
References: <20210115173741.2628737-1-john.levon@nutanix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fe831303-ebcd-9794-fc46-8ffc1701431e@redhat.com>
Date: Mon, 18 Jan 2021 10:55:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115173741.2628737-1-john.levon@nutanix.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

Ck9uIDIwMjEvMS8xNiDkuIrljYgxOjM3LCBKb2huIExldm9uIHdyb3RlOgo+IHZxX2VycigpIGlz
IHVzZWQgdG8gcmVwb3J0IHZhcmlvdXMgZmFpbHVyZSBzdGF0ZXMgaW4gdmhvc3QgY29kZSwgYnV0
IGJ5Cj4gZGVmYXVsdCB1c2VzIHByX2RlYnVnKCksIGFuZCBhcyBhIHJlc3VsdCBkb2Vzbid0IHJl
Y29yZCBhbnl0aGluZyB1bmxlc3MKPiBlbmFibGVkIHZpYSBkeW5hbWljIGRlYnVnLiBXZSdsbCBj
aGFuZ2UgdGhpcyBzbyB3ZSBnZXQgc29tZXRoaW5nIHJlY29yZGVkCj4gaW4gdGhlIGxvZyBpbiB0
aGVzZSBmYWlsdXJlIGNhc2VzLiBHdWVzdCBWTXMgKGFuZCB1c2Vyc3BhY2UpIGNhbiB0cmlnZ2Vy
Cj4gc29tZSBvZiB0aGVzZSBtZXNzYWdlcywgc28gd2Ugd2FudCB0byB1c2UgdGhlIHByX3dhcm5f
cmF0ZWxpbWl0ZWQoKQo+IHZhcmlhbnQuCgoKSXQgbG9va3MgdG8gbWUgS1ZNIGFsc28gdXNlIHBy
X3dhcm5fcmF0ZWxpbWl0ZWQoKS4KClNvCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KCgoKPgo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gTGV2b24gPGpvaG4ubGV2b25A
bnV0YW5peC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmggfCA4ICsrKystLS0t
Cj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaCBiL2RyaXZlcnMvdmhvc3Qvdmhvc3Qu
aAo+IGluZGV4IGIwNjMzMjRjNzY2OS4uY2I0ZWY3OGM4NGJhIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmhvc3Qvdmhvc3QuaAo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuaAo+IEBAIC0yMjgs
MTAgKzIyOCwxMCBAQCBpbnQgdmhvc3RfaW5pdF9kZXZpY2VfaW90bGIoc3RydWN0IHZob3N0X2Rl
diAqZCwgYm9vbCBlbmFibGVkKTsKPiAgIHZvaWQgdmhvc3RfaW90bGJfbWFwX2ZyZWUoc3RydWN0
IHZob3N0X2lvdGxiICppb3RsYiwKPiAgIAkJCSAgc3RydWN0IHZob3N0X2lvdGxiX21hcCAqbWFw
KTsKPiAgIAo+IC0jZGVmaW5lIHZxX2Vycih2cSwgZm10LCAuLi4pIGRvIHsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXAo+IC0JCXByX2RlYnVnKHByX2ZtdChmbXQpLCAjI19fVkFf
QVJHU19fKTsgICAgICAgXAo+IC0JCWlmICgodnEpLT5lcnJvcl9jdHgpICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKPiAtCQkJCWV2ZW50ZmRfc2lnbmFsKCh2cSktPmVycm9yX2N0eCwg
MSk7XAo+ICsjZGVmaW5lIHZxX2Vycih2cSwgZm10LCAuLi4pIGRvIHsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFwKPiArCQlwcl93YXJuX3JhdGVsaW1pdGVkKHByX2ZtdChmbXQpLCAj
I19fVkFfQVJHU19fKTsgXAo+ICsJCWlmICgodnEpLT5lcnJvcl9jdHgpICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBcCj4gKwkJCWV2ZW50ZmRfc2lnbmFsKCh2cSktPmVycm9yX2N0eCwgMSk7
ICAgICAgXAo+ICAgCX0gd2hpbGUgKDApCj4gICAKPiAgIGVudW0gewoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
