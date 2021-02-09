Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EC5C433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:22:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A9E64E45
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A9E64E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id F114187218;
	Tue,  9 Feb 2021 03:22:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xCBiUVHcsCv7; Tue,  9 Feb 2021 03:22:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 70746871DB;
	Tue,  9 Feb 2021 03:22:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6218AC0174;
	Tue,  9 Feb 2021 03:22:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12CAFC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9CF2A871E1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:22:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pAUFYzBJeP9a
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:22:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A1E0C871DB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612840922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gaGWvcCmb+uON3P2Wk6WUwlIKBagJIVHdTduyGgGi+g=;
 b=Qt1k/MkXPsDMOf45qP3RkVrT/syP9GSDaC+7pSiWYl/7Zfv7RYd9tZJ4IjnUrjhMvPixmh
 ClBUl3DqQPdmTyEBHp4LjfsqHyd+HMcXTWbbxMgu10Y5KeD2DtWNknR4/m7qk2Sw6+Aa1i
 iJxD+yYQvZpqq+u/RfF2L46Kzo1J1zc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-Uc19If0AOb-ST0d8kSf4Tg-1; Mon, 08 Feb 2021 22:22:00 -0500
X-MC-Unique: Uc19If0AOb-ST0d8kSf4Tg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E6B3192D788;
 Tue,  9 Feb 2021 03:21:59 +0000 (UTC)
Received: from [10.72.13.32] (ovpn-13-32.pek2.redhat.com [10.72.13.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFCAC5C260;
 Tue,  9 Feb 2021 03:21:53 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20210208161741.104939-1-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8081249b-47be-341a-f979-3bcc30ed41cb@redhat.com>
Date: Tue, 9 Feb 2021 11:21:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210208161741.104939-1-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjEvMi85IOS4iuWNiDEyOjE3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gSXQn
cyBsZWdhbCB0byBoYXZlICdvZmZzZXQgKyBsZW4nIGVxdWFsIHRvCj4gc2l6ZW9mKHN0cnVjdCB2
aXJ0aW9fbmV0X2NvbmZpZyksIHNpbmNlICduZGV2LT5jb25maWcnIGlzIGEKPiAnc3RydWN0IHZp
cnRpb19uZXRfY29uZmlnJywgc28gd2UgY2FuIHNhZmVseSBjb3B5IGl0cyBjb250ZW50IHVuZGVy
Cj4gdGhpcyBjb25kaXRpb24uCj4KPiBGaXhlczogMWE4NmIzNzdhYTIxICgidmRwYS9tbHg1OiBB
ZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmljZXMiKQo+IENjOiBzdGFibGVA
dmdlci5rZXJuZWwub3JnCj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2Fy
emFyZUByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgoKCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAyICst
Cj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3Zk
cGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBpbmRleCBkYzg4NTU5YThkNDkuLjEwZTliMDk5MzJl
YiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiArKysg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiBAQCAtMTgyMCw3ICsxODIwLDcg
QEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRl
diA9IHRvX212ZGV2KHZkZXYpOwo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9f
bWx4NV92ZHBhX25kZXYobXZkZXYpOwo+ICAgCj4gLQlpZiAob2Zmc2V0ICsgbGVuIDwgc2l6ZW9m
KHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZykpCj4gKwlpZiAob2Zmc2V0ICsgbGVuIDw9IHNpemVv
ZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpKQo+ICAgCQltZW1jcHkoYnVmLCAodTggKikmbmRl
di0+Y29uZmlnICsgb2Zmc2V0LCBsZW4pOwo+ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
