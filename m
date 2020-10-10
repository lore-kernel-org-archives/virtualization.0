Return-Path: <SRS0=bpJj=DR=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99551C433DF
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 01:48:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA3E22210
	for <virtualization@archiver.kernel.org>; Sat, 10 Oct 2020 01:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH1cTj97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA3E22210
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B872E8788B;
	Sat, 10 Oct 2020 01:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id obiFILWNwIVe; Sat, 10 Oct 2020 01:48:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 19CA587812;
	Sat, 10 Oct 2020 01:48:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EF864C07FF;
	Sat, 10 Oct 2020 01:48:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3B7CBC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 01:48:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1B1D220420
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 01:48:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6aIHstg229BX
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 01:48:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 9C4EB203F2
 for <virtualization@lists.linux-foundation.org>;
 Sat, 10 Oct 2020 01:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602294534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AkDohCfK7nVkmvX90opUAZF6or9jerCZXTyJ6Vl8gSs=;
 b=QH1cTj97tlvKU5clj6PdKxK+fxq0E4VPxc1MsMKbnFGiWtX5P9oWi+BXXqssxkNoLHzVNS
 e61j/4gvnaHIE9hxP6XxU0n7Grn+bF66CfdL/GFF/xeJxMI4HIC77Ol4UaVHavRXQRf/Eh
 ChHkmHWEPeKrs+JS118sJCEj0LU07Jo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-mQYwk6YoMRq4w2A_ALxuOQ-1; Fri, 09 Oct 2020 21:48:52 -0400
X-MC-Unique: mQYwk6YoMRq4w2A_ALxuOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB5E0427C8;
 Sat, 10 Oct 2020 01:48:50 +0000 (UTC)
Received: from [10.72.13.27] (ovpn-13-27.pek2.redhat.com [10.72.13.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37486614F5;
 Sat, 10 Oct 2020 01:48:43 +0000 (UTC)
Subject: Re: [PATCH v3 1/2] vhost-vdpa: fix vhost_vdpa_map() on error condition
To: Si-Wei Liu <si-wei.liu@oracle.com>, mst@redhat.com, lingshan.zhu@intel.com
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-2-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a780b2e2-d8ce-4c27-df6b-47523c356d02@redhat.com>
Date: Sat, 10 Oct 2020 09:48:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1601701330-16837-2-git-send-email-si-wei.liu@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org
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

Ck9uIDIwMjAvMTAvMyDkuIvljYgxOjAyLCBTaS1XZWkgTGl1IHdyb3RlOgo+IHZob3N0X3ZkcGFf
bWFwKCkgc2hvdWxkIHJlbW92ZSB0aGUgaW90bGIgZW50cnkganVzdCBhZGRlZAo+IGlmIHRoZSBj
b3JyZXNwb25kaW5nIG1hcHBpbmcgZmFpbHMgdG8gc2V0IHVwIHByb3Blcmx5Lgo+Cj4gRml4ZXM6
IDRjOGNmMzE4ODVmNiAoInZob3N0OiBpbnRyb2R1Y2UgdkRQQS1iYXNlZCBiYWNrZW5kIikKPiBT
aWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4gLS0tCj4g
ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDMgKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNl
cnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+IGluZGV4IDc5NmZlOTcuLjBmMjc5MTkgMTAwNjQ0Cj4gLS0tIGEvZHJp
dmVycy92aG9zdC92ZHBhLmMKPiArKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IEBAIC01NjUs
NiArNTY1LDkgQEAgc3RhdGljIGludCB2aG9zdF92ZHBhX21hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAq
diwKPiAgIAkJCSAgICAgIHBlcm1fdG9faW9tbXVfZmxhZ3MocGVybSkpOwo+ICAgCX0KPiAgIAo+
ICsJaWYgKHIpCj4gKwkJdmhvc3RfaW90bGJfZGVsX3JhbmdlKGRldi0+aW90bGIsIGlvdmEsIGlv
dmEgKyBzaXplIC0gMSk7Cj4gKwo+ICAgCXJldHVybiByOwo+ICAgfQo+ICAgCgoKQWNrZWQtYnk6
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
