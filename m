Return-Path: <SRS0=XmMV=HA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC36C433DB
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 03:48:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924A964E01
	for <virtualization@archiver.kernel.org>; Fri, 29 Jan 2021 03:48:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924A964E01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 10C92868E4;
	Fri, 29 Jan 2021 03:48:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4oMKTo6Z4FW; Fri, 29 Jan 2021 03:48:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6995C868CF;
	Fri, 29 Jan 2021 03:48:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5082AC08A1;
	Fri, 29 Jan 2021 03:48:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1ADDC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 03:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E95D4873FB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 03:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cHQ9fKF6ISmh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 03:48:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D6F71873F5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 03:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611892108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzFvyTbz2UvsYBfZzFs744TP0/6WmLw0eTkB57Sb6vo=;
 b=NXBNcHcMKicBnjUOBdQcRrxOWfBU20F7EGpgZ9QjyvEGCp9qeVukEVvrRkyx3YvttF95c+
 FXgwE/S4MXJR8AOWujujNJPKMrm+z70f60s0UsNx5UkkvPSqqJRRqck4+3AxqFC9FukRdM
 KassqO0RsWu9x2vBHgXSZlitGIIj/+Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-sGcZvseiNOaFYvzAPvTNQg-1; Thu, 28 Jan 2021 22:48:26 -0500
X-MC-Unique: sGcZvseiNOaFYvzAPvTNQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAACA10054FF;
 Fri, 29 Jan 2021 03:48:25 +0000 (UTC)
Received: from [10.72.14.10] (ovpn-14-10.pek2.redhat.com [10.72.14.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D91DA2B394;
 Fri, 29 Jan 2021 03:48:20 +0000 (UTC)
Subject: Re: [PATCH 1/2] vdpa/mlx5: Avoid unnecessary query virtqueue
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com
References: <20210128134130.3051-1-elic@nvidia.com>
 <20210128134130.3051-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <024560f4-51bd-af11-a9aa-48682d4e7f5f@redhat.com>
Date: Fri, 29 Jan 2021 11:48:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210128134130.3051-2-elic@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, lulu@redhat.com,
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
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjEvMS8yOCDkuIvljYg5OjQxLCBFbGkgQ29oZW4gd3JvdGU6Cj4gc3VzcGVuZF92cSBz
aG91bGQgb25seSBzdXNwZW5kIHRoZSBWUSBvbiBub3Qgc2F2ZSB0aGUgY3VycmVudCBhdmFpbGFi
bGUKPiBpbmRleC4gVGhpcyBpcyBkb25lIHdoZW4gYSBjaGFuZ2Ugb2YgbWFwIG9jY3VycyB3aGVu
IHRoZSBkcml2ZXIgY2FsbHMKPiBzYXZlX2NoYW5uZWxfaW5mbygpLgo+Cj4gU2lnbmVkLW9mZi1i
eTogRWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGph
c293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyB8IDggLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGRlbGV0aW9ucygtKQo+
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZl
cnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDg4ZGRlMzQ1NWJmZC4uNTQ5ZGVk
MDc0ZmYzIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+
ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBAIC0xMTQ4LDggKzEx
NDgsNiBAQCBzdGF0aWMgaW50IHNldHVwX3ZxKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBz
dHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxKQo+ICAgCj4gICBzdGF0aWMgdm9pZCBzdXNw
ZW5kX3ZxKHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRx
dWV1ZSAqbXZxKQo+ICAgewo+IC0Jc3RydWN0IG1seDVfdmlydHFfYXR0ciBhdHRyOwo+IC0KPiAg
IAlpZiAoIW12cS0+aW5pdGlhbGl6ZWQpCj4gICAJCXJldHVybjsKPiAgIAo+IEBAIC0xMTU4LDEy
ICsxMTU2LDYgQEAgc3RhdGljIHZvaWQgc3VzcGVuZF92cShzdHJ1Y3QgbWx4NV92ZHBhX25ldCAq
bmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUgKm0KPiAgIAo+ICAgCWlmIChtb2RpZnlf
dmlydHF1ZXVlKG5kZXYsIG12cSwgTUxYNV9WSVJUSU9fTkVUX1FfT0JKRUNUX1NUQVRFX1NVU1BF
TkQpKQo+ICAgCQltbHg1X3ZkcGFfd2FybigmbmRldi0+bXZkZXYsICJtb2RpZnkgdG8gc3VzcGVu
ZCBmYWlsZWRcbiIpOwo+IC0KPiAtCWlmIChxdWVyeV92aXJ0cXVldWUobmRldiwgbXZxLCAmYXR0
cikpIHsKPiAtCQltbHg1X3ZkcGFfd2FybigmbmRldi0+bXZkZXYsICJmYWlsZWQgdG8gcXVlcnkg
dmlydHF1ZXVlXG4iKTsKPiAtCQlyZXR1cm47Cj4gLQl9Cj4gLQltdnEtPmF2YWlsX2lkeCA9IGF0
dHIuYXZhaWxhYmxlX2luZGV4Owo+ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCBzdXNwZW5kX3Zx
cyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldikKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
