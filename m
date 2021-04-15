Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC00EC433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 03:30:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863EE6103E
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 03:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863EE6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4389340F89;
	Thu, 15 Apr 2021 03:30:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Ur83F7QD16B; Thu, 15 Apr 2021 03:30:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id B274940F6C;
	Thu, 15 Apr 2021 03:30:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78231C000C;
	Thu, 15 Apr 2021 03:30:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4DBFC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8011940F81
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdHGMEeqZwWT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:30:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 390AA40F6C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618457450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlNNiI/3x3aTaVCgbYG1oVjUjq53goSd1bVD/8PXIMk=;
 b=WvNnwpeQUr2ma2+yuayizJe3fcS6gp1sW1kJ4eHpNHjfRktk5kbB2l6uxaoQT5APar1/DX
 rVmCKPLE2nqu2jreeCawr6ip5MTfv8zUWZZ7yZKochgwQoSTcEBdlCg95ilcP6XzYeJ/1K
 8r6+l8+VukP/g9CvdBPU5VJN4iThVCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-wQ4K-NJSPnOVQhvEvIBkPQ-1; Wed, 14 Apr 2021 23:30:49 -0400
X-MC-Unique: wQ4K-NJSPnOVQhvEvIBkPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08E81107ACE4;
 Thu, 15 Apr 2021 03:30:48 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-220.pek2.redhat.com
 [10.72.13.220])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9D418610A8;
 Thu, 15 Apr 2021 03:30:43 +0000 (UTC)
Subject: Re: [PATCH 1/3] vDPA/ifcvf: deduce VIRTIO device ID when probe
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, lulu@redhat.com,
 leonro@nvidia.com
References: <20210414091832.5132-1-lingshan.zhu@intel.com>
 <20210414091832.5132-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <85483ff1-cf98-ad05-0c53-74caa2464459@redhat.com>
Date: Thu, 15 Apr 2021 11:30:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210414091832.5132-2-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

CtTaIDIwMjEvNC8xNCDPws7nNToxOCwgWmh1IExpbmdzaGFuINC0tcA6Cj4gVGhpcyBjb21taXQg
ZGVkdWNlcyBWSVJUSU8gZGV2aWNlIElEIGFzIGRldmljZSB0eXBlIHdoZW4gcHJvYmUsCj4gdGhl
biBpZmN2Zl92ZHBhX2dldF9kZXZpY2VfaWQoKSBjYW4gc2ltcGx5IHJldHVybiB0aGUgSUQuCj4g
aWZjdmZfdmRwYV9nZXRfZmVhdHVyZXMoKSBhbmQgaWZjdmZfdmRwYV9nZXRfY29uZmlnX3NpemUo
KQo+IGNhbiB3b3JrIHByb3Blcmx5IGJhc2VkIG9uIHRoZSBkZXZpY2UgSUQuCj4KPiBTaWduZWQt
b2ZmLWJ5OiBaaHUgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+Cj4gLS0tCj4gICBk
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgIDEgKwo+ICAgZHJpdmVycy92ZHBhL2lm
Y3ZmL2lmY3ZmX21haW4uYyB8IDIyICsrKysrKysrKystLS0tLS0tLS0tLS0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuaCBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9iYXNlLmgKPiBpbmRleCBiMmVlYjE2YjljMmMuLjFjMDRjZDI1NmZhNyAxMDA2NDQKPiAt
LS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gKysrIGIvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX2Jhc2UuaAo+IEBAIC04NCw2ICs4NCw3IEBAIHN0cnVjdCBpZmN2Zl9odyB7
Cj4gICAJdTMyIG5vdGlmeV9vZmZfbXVsdGlwbGllcjsKPiAgIAl1NjQgcmVxX2ZlYXR1cmVzOwo+
ICAgCXU2NCBod19mZWF0dXJlczsKPiArCXUzMiBkZXZfdHlwZTsKPiAgIAlzdHJ1Y3QgdmlydGlv
X3BjaV9jb21tb25fY2ZnIF9faW9tZW0gKmNvbW1vbl9jZmc7Cj4gICAJdm9pZCBfX2lvbWVtICpu
ZXRfY2ZnOwo+ICAgCXN0cnVjdCB2cmluZ19pbmZvIHZyaW5nW0lGQ1ZGX01BWF9RVUVVRV9QQUlS
UyAqIDJdOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIGIv
ZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+IGluZGV4IDQ0ZDc1ODYwMTlkYS4uOTli
MGE2YjRjMjI3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMK
PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4gQEAgLTMyMywxOSArMzIz
LDkgQEAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dldF9nZW5lcmF0aW9uKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRwYV9kZXYpCj4gICAKPiAgIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfZGV2aWNl
X2lkKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gICB7Cj4gLQlzdHJ1Y3QgaWZjdmZf
YWRhcHRlciAqYWRhcHRlciA9IHZkcGFfdG9fYWRhcHRlcih2ZHBhX2Rldik7Cj4gLQlzdHJ1Y3Qg
cGNpX2RldiAqcGRldiA9IGFkYXB0ZXItPnBkZXY7Cj4gLQl1MzIgcmV0ID0gLUVOT0RFVjsKPiAt
Cj4gLQlpZiAocGRldi0+ZGV2aWNlIDwgMHgxMDAwIHx8IHBkZXYtPmRldmljZSA+IDB4MTA3ZikK
PiAtCQlyZXR1cm4gcmV0Owo+IC0KPiAtCWlmIChwZGV2LT5kZXZpY2UgPCAweDEwNDApCj4gLQkJ
cmV0ID0gIHBkZXYtPnN1YnN5c3RlbV9kZXZpY2U7Cj4gLQllbHNlCj4gLQkJcmV0ID0gIHBkZXYt
PmRldmljZSAtIDB4MTA0MDsKPiArCXN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZk
cGFfZGV2KTsKPiAgIAo+IC0JcmV0dXJuIHJldDsKPiArCXJldHVybiB2Zi0+ZGV2X3R5cGU7Cj4g
ICB9Cj4gICAKPiAgIHN0YXRpYyB1MzIgaWZjdmZfdmRwYV9nZXRfdmVuZG9yX2lkKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gQEAgLTQ2Niw2ICs0NTYsMTQgQEAgc3RhdGljIGludCBp
ZmN2Zl9wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2Vf
aWQgKmlkKQo+ICAgCXBjaV9zZXRfZHJ2ZGF0YShwZGV2LCBhZGFwdGVyKTsKPiAgIAo+ICAgCXZm
ID0gJmFkYXB0ZXItPnZmOwo+ICsJaWYgKHBkZXYtPmRldmljZSA8IDB4MTAwMCB8fCBwZGV2LT5k
ZXZpY2UgPiAweDEwN2YpCj4gKwkJcmV0dXJuIC1FT1BOT1RTVVBQOwo+ICsKPiArCWlmIChwZGV2
LT5kZXZpY2UgPCAweDEwNDApCj4gKwkJdmYtPmRldl90eXBlID0gIHBkZXYtPnN1YnN5c3RlbV9k
ZXZpY2U7Cj4gKwllbHNlCj4gKwkJdmYtPmRldl90eXBlID0gIHBkZXYtPmRldmljZSAtIDB4MTA0
MDsKCgpTbyBhIHF1ZXN0aW9uIGhlcmUsIGlzIHRoZSBkZXZpY2UgYSB0cmFuc3Rpb25hbCBkZXZp
Y2Ugb3IgbW9kZXJuIG9uZT8KCklmIGl0J3MgYSB0cmFuc2l0b25hbCBvbmUsIGNhbiBpdCBzd3Rp
Y2ggZW5kaWFuZXNzIGF1dG9tYXRpY2FsbHkgb3Igbm90PwoKVGhhbmtzCgoKPiArCj4gICAJdmYt
PmJhc2UgPSBwY2ltX2lvbWFwX3RhYmxlKHBkZXYpOwo+ICAgCj4gICAJYWRhcHRlci0+cGRldiA9
IHBkZXY7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
