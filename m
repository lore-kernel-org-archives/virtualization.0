Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F8FC433E0
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 12:16:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA0164E7C
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 12:16:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA0164E7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4C8E086F5E;
	Tue,  9 Feb 2021 12:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nRZmzk+RwYsX; Tue,  9 Feb 2021 12:16:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B1B7886DD3;
	Tue,  9 Feb 2021 12:16:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88E5DC0174;
	Tue,  9 Feb 2021 12:16:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C96FEC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BD4C0872E9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ovcLDthyOb4P
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:16:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 29967872E0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 12:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612872995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByUjskTTLoPD2OajNMiA8UoGsbWTnUgXFSxuqEGtMYU=;
 b=LjQ21l8+g965qkfYqorGpywS9dBVqbpVtqapWWClGPuTy0Ywk/5AYZmzIw0skfi9eQmuja
 ngZgM3fuTSl40Bw07o8wfemeu1KOerpeoMUe9PV0vwR4iZaY9hlszlYMbgm1FkNmktBjYz
 vF3r7q9aRVCReNGn0QHN34DkQ5qkM8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-MIC4sTsyMaC8ql-oRLNTXg-1; Tue, 09 Feb 2021 07:16:33 -0500
X-MC-Unique: MIC4sTsyMaC8ql-oRLNTXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7FB01005501;
 Tue,  9 Feb 2021 12:16:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-170.ams2.redhat.com
 [10.36.112.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A965171F4;
 Tue,  9 Feb 2021 12:16:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 737F41800395; Tue,  9 Feb 2021 13:16:29 +0100 (CET)
Date: Tue, 9 Feb 2021 13:16:29 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] drm/qxl: properly handle device init failures
Message-ID: <20210209121629.vb3yu6zkr4npnskz@sirius.home.kraxel.org>
References: <20210208104149.423758-1-kraxel@redhat.com>
 <E07153A4-9B42-4050-903E-8BBB99D8ED8E@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E07153A4-9B42-4050-903E-8BBB99D8ED8E@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, "open list:DRM DRIVER FOR QXL VIRTUAL GPU"
 <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@redhat.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMTI6MDc6MDFQTSAtMDUwMCwgVG9uZyBaaGFuZyB3cm90
ZToKPiBEb2VzIHRoaXMgcGF0Y2ggZml4IGFuIGlzc3VlIHJhaXNlZCBwcmV2aW91c2x5PyBPciBz
aG91bGQgdGhleSBiZSB1c2VkIHRvZ2V0aGVyPwo+IGh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5j
b20vbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZy9tc2cyNDY2NTQxLmh0bWwgCj4gCj4gSU1I
TyB1c2luZyB0aGlzIHBhdGNoIGFsb25lIHdvbuKAmXQgZml4IHRoZSBpc3N1ZQoKVGhpcyBwYXRj
aCBvbiB0b3Agb2YgZHJtLW1pc2MtbmV4dCBmaXhlcyB0aGUgaW5pdGlhbGl6YXRpb24gZXJyb3Ig
aXNzdWUKcmVwb3J0ZWQgYnkgeW91IGluIG15IHRlc3RpbmcuCgp0YWtlIGNhcmUsCiAgR2VyZAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
