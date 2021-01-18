Return-Path: <SRS0=OmMZ=GV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F04EC433E0
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 02:57:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1BB224BD
	for <virtualization@archiver.kernel.org>; Mon, 18 Jan 2021 02:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1BB224BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B2F4C2048D;
	Mon, 18 Jan 2021 02:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2VjCV5zn+j3C; Mon, 18 Jan 2021 02:57:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 54A432014B;
	Mon, 18 Jan 2021 02:57:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47712C0FA7;
	Mon, 18 Jan 2021 02:57:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E0DCC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:57:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6C92A85604
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:57:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H96nVnJbeUg9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:57:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D5EAB855D1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Jan 2021 02:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610938629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LedkJCf2woputitHVAf5yD7dLglL44/GLUzYpe6i5Ac=;
 b=CCl5CT5HkbbI0WYFEu4qyBj/xh2YI/pk8tRlCAHUz9T8YeRvhNtID18pSVIEmzURtu+xc7
 sOX0IDCe2gsH5p02mx4zlhOrACSOymfHQUCyvGRasRcxG+is7VQQhzW+DOisIzaGJko8QI
 tjewS2Hm0MK4JJ6sByeFPVTZpquj6NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453--H6RMxbAPcaOGMYXHLPdGA-1; Sun, 17 Jan 2021 21:57:07 -0500
X-MC-Unique: -H6RMxbAPcaOGMYXHLPdGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5600F8145F7;
 Mon, 18 Jan 2021 02:57:06 +0000 (UTC)
Received: from [10.72.13.12] (ovpn-13-12.pek2.redhat.com [10.72.13.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7072D71C97;
 Mon, 18 Jan 2021 02:57:04 +0000 (UTC)
Subject: Re: [PATCH] virtio_ring: boolean values to a bool variable
To: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>, mst@redhat.com
References: <1610704825-17724-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <1d311c25-9051-ddcd-e7e1-5adbb8a913f9@redhat.com>
Date: Mon, 18 Jan 2021 10:57:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1610704825-17724-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMS8xNSDkuIvljYg2OjAwLCBKaWFwZW5nIFpob25nIHdyb3RlOgo+IEZpeCB0aGUg
Zm9sbG93aW5nIGNvY2NpY2hlY2sgd2FybmluZ3M6Cj4KPiAuL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmM6MTYzNzoxLTI5OiBXQVJOSU5HOiBBc3NpZ25tZW50IG9mCj4gMC8xIHRvIGJvb2wg
dmFyaWFibGUuCj4KPiAuL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6MTYzNjoxLTMwOiBX
QVJOSU5HOiBBc3NpZ25tZW50IG9mCj4gMC8xIHRvIGJvb2wgdmFyaWFibGUuCj4KPiBSZXBvcnRl
ZC1ieTogQWJhY2kgUm9ib3QgPGFiYWNpQGxpbnV4LmFsaWJhYmEuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IEppYXBlbmcgWmhvbmcgPGFiYWNpLWJ1Z2ZpeEBsaW51eC5hbGliYWJhLmNvbT4KCgpJdCBs
b29rcyB0byBtZSBpdCdzIG5vdCB0aGUgb25seSBwbGFjZXM6CgpnaXQgZ3JlcCBhdmFpbF93cmFw
X2NvdW50ZXIKZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYzrCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYm9vbCBhdmFpbF93cmFwX2NvdW50ZXI7CmRyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmM6IHZxLT5wYWNrZWQuYXZhaWxfd3JhcF9jb3VudGVyIF49IDE7CmRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6IHZxLT5wYWNrZWQuYXZhaWxfd3JhcF9jb3VudGVyIF49
IDE7CmRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmM6wqDCoCBpZiAod3JhcF9jb3VudGVyICE9
IAp2cS0+cGFja2VkLmF2YWlsX3dyYXBfY291bnRlcikKZHJpdmVycy92aXJ0aW8vdmlydGlvX3Jp
bmcuYzrCoMKgIHZxLT5wYWNrZWQuYXZhaWxfd3JhcF9jb3VudGVyID0gMTsKClRoYW5rcwoKCj4g
LS0tCj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNCArKy0tCj4gICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmlu
Zy5jCj4gaW5kZXggNzFlMTZiNS4uNWFkYjM2MSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRp
by92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IEBA
IC0xNjMzLDggKzE2MzMsOCBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRl
X3ZpcnRxdWV1ZV9wYWNrZWQoCj4gICAJdnEtPnBhY2tlZC52cmluZy5kZXZpY2UgPSBkZXZpY2U7
Cj4gICAKPiAgIAl2cS0+cGFja2VkLm5leHRfYXZhaWxfaWR4ID0gMDsKPiAtCXZxLT5wYWNrZWQu
YXZhaWxfd3JhcF9jb3VudGVyID0gMTsKPiAtCXZxLT5wYWNrZWQudXNlZF93cmFwX2NvdW50ZXIg
PSAxOwo+ICsJdnEtPnBhY2tlZC5hdmFpbF93cmFwX2NvdW50ZXIgPSB0cnVlOwo+ICsJdnEtPnBh
Y2tlZC51c2VkX3dyYXBfY291bnRlciA9IHRydWU7Cj4gICAJdnEtPnBhY2tlZC5ldmVudF9mbGFn
c19zaGFkb3cgPSAwOwo+ICAgCXZxLT5wYWNrZWQuYXZhaWxfdXNlZF9mbGFncyA9IDEgPDwgVlJJ
TkdfUEFDS0VEX0RFU0NfRl9BVkFJTDsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
