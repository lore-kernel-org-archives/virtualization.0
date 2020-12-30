Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A93C433E0
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 04:28:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A8F20700
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 04:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A8F20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3848F85EEF;
	Wed, 30 Dec 2020 04:28:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h9YSCQ81nINC; Wed, 30 Dec 2020 04:28:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2723485C4B;
	Wed, 30 Dec 2020 04:28:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EB848C0893;
	Wed, 30 Dec 2020 04:28:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA298C0174
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 04:28:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BAFBD87136
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 04:28:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bOyhR6dLuF26
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 04:28:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A0C5087135
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 04:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609302484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F7VOtk7yYlfXfkKIWDbIt/rwZpMlvsngOus3otwzlNY=;
 b=O8HPlHF1O1xluPbFt9fQIMO0Xd+Jz2hSzGGp6j0CeVjiMJEAnigWkqxZm6cvAcFbX8okBi
 Piy7/3djhVjzBDBWQV6Teu9hpcY7DQDk2DcmILV3sduva2Ao9TSfSc7RAFZBcl5d1bp97T
 LqpjKcw0tIxJl8iTbLXA7ULk60jknlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-rqaq5UO7OvObBieWgbT8Bg-1; Tue, 29 Dec 2020 23:28:00 -0500
X-MC-Unique: rqaq5UO7OvObBieWgbT8Bg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF011E75A;
 Wed, 30 Dec 2020 04:27:58 +0000 (UTC)
Received: from [10.72.13.30] (ovpn-13-30.pek2.redhat.com [10.72.13.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78F2271CBE;
 Wed, 30 Dec 2020 04:27:48 +0000 (UTC)
Subject: Re: [PATCH 10/21] vhost: support ASID in IOTLB API
To: Eli Cohen <elic@nvidia.com>
References: <20201216064818.48239-1-jasowang@redhat.com>
 <20201216064818.48239-11-jasowang@redhat.com>
 <20201229102059.GB195479@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0fc761c7-6053-c098-a251-ae2f7380f95e@redhat.com>
Date: Wed, 30 Dec 2020 12:27:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229102059.GB195479@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 stefanha@redhat.com, eli@mellanox.com, lingshan.zhu@intel.com,
 rob.miller@broadcom.com
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

Ck9uIDIwMjAvMTIvMjkg5LiL5Y2INjoyMCwgRWxpIENvaGVuIHdyb3RlOgo+PiAtc3RhdGljIGlu
dCB2aG9zdF9wcm9jZXNzX2lvdGxiX21zZyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+ICtzdGF0
aWMgaW50IHZob3N0X3Byb2Nlc3NfaW90bGJfbXNnKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdTE2
IGFzaWQsCj4+ICAgCQkJCSAgIHN0cnVjdCB2aG9zdF9pb3RsYl9tc2cgKm1zZykKPj4gICB7Cj4+
ICAgCWludCByZXQgPSAwOwo+PiAgIAo+PiArCWlmIChhc2lkICE9IDApCj4+ICsJCXJldHVybiAt
RUlOVkFMOwo+PiArCj4+ICAgCW11dGV4X2xvY2soJmRldi0+bXV0ZXgpOwo+PiAgIAl2aG9zdF9k
ZXZfbG9ja192cXMoZGV2KTsKPj4gICAJc3dpdGNoIChtc2ctPnR5cGUpIHsKPj4gQEAgLTExMzUs
NiArMTEzOCw3IEBAIHNzaXplX3Qgdmhvc3RfY2hyX3dyaXRlX2l0ZXIoc3RydWN0IHZob3N0X2Rl
diAqZGV2LAo+PiAgIAlzdHJ1Y3Qgdmhvc3RfaW90bGJfbXNnIG1zZzsKPj4gICAJc2l6ZV90IG9m
ZnNldDsKPj4gICAJaW50IHR5cGUsIHJldDsKPj4gKwl1MTYgYXNpZCA9IDA7Cj4gWW91IGFzc3Vt
ZSBhc2lkIG9jY3VwaWVzIGp1c3QgMTYgYml0cy4gU28gbWF5YmUgeW91IHNob3VsZCByZXNlcnZl
IHRoZQo+IG90aGVyIDE2IGJpdHMgZm9yIGZ1dHVyZSBleHRlbnNpb246Cj4KPiBzdHJ1Y3Qgdmhv
c3RfbXNnX3YyIHsKPiAgICAgICAgICBfX3UzMiB0eXBlOwo+IC0gICAgICAgX191MzIgcmVzZXJ2
ZWQ7Cj4gKyAgICAgICBfX3UxNiBhc2lkOwo+ICsgICAgICAgX191MTYgcmVzZXJ2ZWQ7Cj4gICAg
ICAgICAgdW5pb24gewo+Cj4gTW9yZW92ZXIsIG1heWJlIHRoaXMgc2hvdWxkIGJlIHJlZmxlY3Rl
ZCBpbiBwcmV2aW91cyBwYXRjaGVzIHRoYXQgdXNlCj4gdGhlIGFzaWQ6Cj4KPiAtc3RhdGljIGlu
dCBtbHg1X3ZkcGFfc2V0X21hcChzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHN0cnVjdCB2aG9z
dF9pb3RsYiAqaW90bGIpCj4gK3N0YXRpYyBpbnQgbWx4NV92ZHBhX3NldF9tYXAoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCB1MTYgYXNpZCwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCB2aG9zdF9pb3RsYiAqaW90bGIpCj4KPiAtc3RhdGljIGludCB2aG9zdF92ZHBhX3By
b2Nlc3NfaW90bGJfbXNnKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiArc3RhdGljIGludCB2aG9z
dF92ZHBhX3Byb2Nlc3NfaW90bGJfbXNnKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgdTE2IGFzaWQs
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3Rf
aW90bGJfbXNnICptc2cpCj4KPiBldGMuCgoKR29vZCBjYXRjaC4KClRoaXMgaXMgYSBidWcgb2Yg
dGhlIGNvZGUgYWN0dWFsbHkuIFNpbmNlIEkgd2FudCB0byBzdGljayB0byAzMmJpdCB0byBiZSAK
bGFyZ2UgZW5vdWdoIGZvciBlLmcgUEFTSUQuCgpXaWxsIGZpeC4KClRoYW5rcwoKCj4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
