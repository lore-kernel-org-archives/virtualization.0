Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BB3C64E7B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:05:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B7B620757
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N0NB20+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7B620757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4C7E2012D;
	Mon, 30 Nov 2020 03:05:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKGADYDN9Ms4; Mon, 30 Nov 2020 03:05:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5E448203EB;
	Mon, 30 Nov 2020 03:05:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30280C0859;
	Mon, 30 Nov 2020 03:05:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 723CEC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6D3CB86356
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DyJ4gWqAicyd
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:05:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9F7C48629C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606705506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=na0VqByCBLwL2XYwDNtC+dq1b+zzL7qMGmJPR1qmUks=;
 b=N0NB20+2+OaxAkC1bCFozDOssgyXP5eezCaFmkn3HR7tgKxna8AVDl2Euxo/dqfzKA4AKq
 OfIyDoBFCu75CZ2f+Y1AEBBU6ecIWl+zD+Ujm/Jj0YIDtYDNF+zL6ixnDAY4xW1F5uP4gK
 KtST5Qv2i0FpkyOCA057W/89TZ3IdhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-y7BAwqydM9uuLIM8QSFasA-1; Sun, 29 Nov 2020 22:05:02 -0500
X-MC-Unique: y7BAwqydM9uuLIM8QSFasA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEE771842142;
 Mon, 30 Nov 2020 03:05:00 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2DC1A88F;
 Mon, 30 Nov 2020 03:04:50 +0000 (UTC)
Subject: Re: [PATCH v2 02/17] vdpa_sim: remove unnecessary headers inclusion
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-3-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f900316d-a642-714e-65b6-5b6cc4b79b48@redhat.com>
Date: Mon, 30 Nov 2020 11:04:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-3-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBT
b21lIGhlYWRlcnMgYXJlIG5vdCBuZWNlc3NhcnksIHNvIGxldCdzIHJlbW92ZSB0aGVtIHRvIGRv
Cj4gc29tZSBjbGVhbmluZy4KPgo+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5jIHwgMTMgLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEzIGRlbGV0aW9u
cygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIv
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBpbmRleCA2YTkwZmRiOWNiZmMuLmM2
ZWFmNjJkZjhlYyAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
Ywo+ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gQEAgLTcsMjQgKzcs
MTEgQEAKPiAgICAqCj4gICAgKi8KPiAgIAo+IC0jaW5jbHVkZSA8bGludXgvaW5pdC5oPgo+ICAg
I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgo+IC0jaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CgoK
SSB0aGluayB0aGUgcnVsZSBpcyB0byBtYWtlIHN1cmUgZS5nIHRoZSBzdHJ1Y3R1cmUgZGVmaW5p
dGlvbiBjYW4gYmUgdmlhIApkaXJlY3QgaW5jbHVzaW9uLiBFLmcgc3RydWN0IGRldmljZSB7fSBp
cyBkZWZpbmVkIGluIHRoaXMgZmlsZS4KCgo+IC0jaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4g
LSNpbmNsdWRlIDxsaW51eC9mcy5oPgo+IC0jaW5jbHVkZSA8bGludXgvcG9sbC5oPgo+IC0jaW5j
bHVkZSA8bGludXgvc2xhYi5oPgo+IC0jaW5jbHVkZSA8bGludXgvc2NoZWQuaD4KPiAtI2luY2x1
ZGUgPGxpbnV4L3dhaXQuaD4KPiAtI2luY2x1ZGUgPGxpbnV4L3V1aWQuaD4KPiAtI2luY2x1ZGUg
PGxpbnV4L2lvbW11Lmg+Cj4gICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcC1vcHMuaD4KPiAtI2lu
Y2x1ZGUgPGxpbnV4L3N5c2ZzLmg+Cj4gLSNpbmNsdWRlIDxsaW51eC9maWxlLmg+Cj4gICAjaW5j
bHVkZSA8bGludXgvZXRoZXJkZXZpY2UuaD4KPiAgICNpbmNsdWRlIDxsaW51eC92cmluZ2guaD4K
PiAgICNpbmNsdWRlIDxsaW51eC92ZHBhLmg+Cj4gLSNpbmNsdWRlIDxsaW51eC92aXJ0aW9fYnl0
ZW9yZGVyLmg+CgoKQW5kIHRoZcKgIF9fY3B1X3RvX3ZpcnRpbzE2IGlzIGRlZmluZWQgaW4gdGhp
cyBmaWxlLgoKVGhhbmtzCgoKPiAgICNpbmNsdWRlIDxsaW51eC92aG9zdF9pb3RsYi5oPgo+ICAg
I2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oPgo+ICAgI2luY2x1ZGUgPHVhcGkv
bGludXgvdmlydGlvX25ldC5oPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
