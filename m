Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C85C433B4
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:44:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 243E86113B
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 02:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243E86113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CB43C40EE5;
	Fri, 16 Apr 2021 02:44:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9je7JXry31wg; Fri, 16 Apr 2021 02:44:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4B06840EDF;
	Fri, 16 Apr 2021 02:44:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2C751C000C;
	Fri, 16 Apr 2021 02:44:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E7827C000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:44:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9162402F6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:44:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kDxfjCt6lgLB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:44:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2381540245
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 02:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618541070;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KV83RWPE04QR8KnKtIQmiAuSTrc/SlgfLG9br6c33pM=;
 b=J6r6dvmQFHwEUDUD/UaIzgQGQ5sDGIFPf5A4JFt8bfNWvvUmB0XZE0uzwAJC1X5q2Ii6Tn
 T8h28CYDxUpk+RFQIVgdXF4j5dq+MbNPmM7zs0u33tCVuqKeGL7lQIwPTY0CQYHstt6JBf
 lSRISueC+CCoKH+8NT0e4THf+wSNiy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-I5drtALzO8Kzse26L5dDuQ-1; Thu, 15 Apr 2021 22:44:28 -0400
X-MC-Unique: I5drtALzO8Kzse26L5dDuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF66F80D6A8;
 Fri, 16 Apr 2021 02:44:27 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-140.pek2.redhat.com
 [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B97505D71F;
 Fri, 16 Apr 2021 02:44:18 +0000 (UTC)
Subject: Re: [PATCH 4/4] vhost poll: fix coding style
To: Mike Christie <michael.christie@oracle.com>, stefanha@redhat.com,
 pbonzini@redhat.com, mst@redhat.com,
 virtualization@lists.linux-foundation.org, chaitanya.kulkarni@wdc.com
References: <20210415172752.5734-1-michael.christie@oracle.com>
 <20210415172752.5734-5-michael.christie@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <88b9df33-a3ec-95e6-b2ef-2ae92f317925@redhat.com>
Date: Fri, 16 Apr 2021 10:44:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210415172752.5734-5-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

CtTaIDIwMjEvNC8xNiDJz87nMToyNywgTWlrZSBDaHJpc3RpZSDQtLXAOgo+IFdlIHVzZSBsaWtl
IDMgY29kaW5nIHN0eWxlcyBpbiB0aGlzIHN0cnVjdC4gU3dpdGNoIHRvIGp1c3QgdGFicy4KPgo+
IFNpZ25lZC1vZmYtYnk6IE1pa2UgQ2hyaXN0aWUgPG1pY2hhZWwuY2hyaXN0aWVAb3JhY2xlLmNv
bT4KPiBSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxjaGFpdGFueWEua3Vsa2FybmlA
d2RjLmNvbT4KPiBSZXZpZXdlZC1ieTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQu
Y29tPgo+IC0tLQoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoK
Cj4gICBkcml2ZXJzL3Zob3N0L3Zob3N0LmggfCAxMiArKysrKystLS0tLS0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aG9zdC92aG9zdC5oIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gaW5kZXggMWJh
OGU4MTQ5ODlkLi41NzVjODE4MGNhYWQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9z
dC5oCj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gQEAgLTI4LDEyICsyOCwxMiBAQCBz
dHJ1Y3Qgdmhvc3Rfd29yayB7Cj4gICAvKiBQb2xsIGEgZmlsZSAoZXZlbnRmZCBvciBzb2NrZXQp
ICovCj4gICAvKiBOb3RlOiB0aGVyZSdzIG5vdGhpbmcgdmhvc3Qgc3BlY2lmaWMgYWJvdXQgdGhp
cyBzdHJ1Y3R1cmUuICovCj4gICBzdHJ1Y3Qgdmhvc3RfcG9sbCB7Cj4gLQlwb2xsX3RhYmxlICAg
ICAgICAgICAgICAgIHRhYmxlOwo+IC0Jd2FpdF9xdWV1ZV9oZWFkX3QgICAgICAgICp3cWg7Cj4g
LQl3YWl0X3F1ZXVlX2VudHJ5X3QgICAgICAgICAgICAgIHdhaXQ7Cj4gLQlzdHJ1Y3Qgdmhvc3Rf
d29yawkgIHdvcms7Cj4gLQlfX3BvbGxfdAkJICBtYXNrOwo+IC0Jc3RydWN0IHZob3N0X2Rldgkg
KmRldjsKPiArCXBvbGxfdGFibGUJCXRhYmxlOwo+ICsJd2FpdF9xdWV1ZV9oZWFkX3QJKndxaDsK
PiArCXdhaXRfcXVldWVfZW50cnlfdAl3YWl0Owo+ICsJc3RydWN0IHZob3N0X3dvcmsJd29yazsK
PiArCV9fcG9sbF90CQltYXNrOwo+ICsJc3RydWN0IHZob3N0X2RldgkqZGV2Owo+ICAgfTsKPiAg
IAo+ICAgdm9pZCB2aG9zdF93b3JrX2luaXQoc3RydWN0IHZob3N0X3dvcmsgKndvcmssIHZob3N0
X3dvcmtfZm5fdCBmbik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
