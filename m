Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F31AC64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 14:16:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4633F2076E
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 14:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KddqXzuC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4633F2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 780B1228AC;
	Mon, 30 Nov 2020 14:16:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9iQThbjw57pj; Mon, 30 Nov 2020 14:16:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 27D0A22882;
	Mon, 30 Nov 2020 14:16:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16174C163C;
	Mon, 30 Nov 2020 14:16:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D21DC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:16:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 988B38709E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:16:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bg28DeG5vfJF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:16:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 720B08729E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606745794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nk3PwbgnWPBsA8dJTlZWHGE9bPoVI0JdWk0TDjCsPaU=;
 b=KddqXzuC4cRSatZLJRKlksxSgqfLymCtQbuUh+5l0rml4g36id+WUo/UaR6tDLYSR+dpLX
 ZNDCxDkAzB5iLgL+MeEaL55Jdt915jctYvUWyjSny/k+EtfOsc1Tyv7adW5o5RY33UQNbN
 PcXQSbWfP8V9BS6MGred5RlRdbh8vXo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-gxcjuAF0NIOCb-8nraz0iA-1; Mon, 30 Nov 2020 09:16:32 -0500
X-MC-Unique: gxcjuAF0NIOCb-8nraz0iA-1
Received: by mail-wr1-f70.google.com with SMTP id e6so8381768wrx.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 06:16:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nk3PwbgnWPBsA8dJTlZWHGE9bPoVI0JdWk0TDjCsPaU=;
 b=eyAfj0x5ojVm82bbXzW3oULT43T7H2Vee0vlrFOkpgVHW3fzQhvQJX9d79kZWT9IxY
 TMD+m19t2fBRNEaeMTNXMFJqjCzEBxEIz1D/sTUnKB4bmNXMsqP4MfhJhc0QdNqLJwf8
 YFEgSHX5oDw80pMuczfROmrD027N/jNbFAyYhQfCZSV9vhjd1o8tuC0LkmuNjq699l4Q
 vZ9aFvX1QkL6Zo1yfcNMBFDh1lKWaPsgKHiv6JN9NoHNxPZ336nabQOtoS9rh3Kmx1RG
 nXM8t8yCtHPfhoz8Ak78Y2HpL2RiyHyIXZOx7W49hLpFQymoSjziNAaq+hvoyMYog8M+
 3fYw==
X-Gm-Message-State: AOAM5330+P+mdfuOw4G3t1aSnsuKAlmX/iXwl9jJ1aCDfLAWzXp7T/Su
 Huf4GoUSfGRK7OcDy1JpmwBFP1wgd5P62LouEZzSMG5qBx1Zt5JKevUeRoOvsYuRd9CHaygeGDR
 BouGu3AROJvTy4/RItJzpqKivz04zfHD1Dd3vtNoqWw==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr23625751wmh.110.1606745790854; 
 Mon, 30 Nov 2020 06:16:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjRy9tynfMnBGRMaIbuZ6bUgN4vno7cZV4YkNrWOD0VSIz+J6N442hYHa81mtCWHg4WmBcew==
X-Received: by 2002:a7b:cc12:: with SMTP id f18mr23625712wmh.110.1606745790353; 
 Mon, 30 Nov 2020 06:16:30 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id t136sm25228625wmt.18.2020.11.30.06.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 06:16:29 -0800 (PST)
Date: Mon, 30 Nov 2020 15:16:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 13/17] vdpa_sim: set vringh notify callback
Message-ID: <20201130141627.4gjsoiwg5byt3ujx@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-14-sgarzare@redhat.com>
 <5569e198-22be-514a-744a-1bef9a3b95ce@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5569e198-22be-514a-744a-1bef9a3b95ce@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
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

T24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6Mjc6NTFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8yNiDkuIvljYgxMDo0OSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+Pkluc3RlYWQgb2YgY2FsbGluZyB0aGUgdnEgY2FsbGJhY2sgZGlyZWN0bHksIHdlIGNhbiBs
ZXZlcmFnZSB0aGUKPj52cmluZ2hfbm90aWZ5KCkgZnVuY3Rpb24sIGFkZGluZyB2ZHBhc2ltX3Zx
X25vdGlmeSgpIGFuZCBzZXR0aW5nIGl0Cj4+aW4gdGhlIHZyaW5naCBub3RpZnkgY2FsbGJhY2su
Cj4+Cj4+U3VnZ2VzdGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+PlNp
Z25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4t
LS0KPj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMjEgKysrKysrKysrKysr
KysrKystLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkKPj4KPj5kaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMg
Yi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+PmluZGV4IDhiODdjZTA0ODViNi4u
NDMyN2VmZDZkNDFlIDEwMDY0NAo+Pi0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bS5jCj4+KysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPj5AQCAtMTIwLDYg
KzEyMCwxNyBAQCBzdGF0aWMgc3RydWN0IHZkcGFzaW0gKmRldl90b19zaW0oc3RydWN0IGRldmlj
ZSAqZGV2KQo+PiAgCXJldHVybiB2ZHBhX3RvX3NpbSh2ZHBhKTsKPj4gIH0KPj4rc3RhdGljIHZv
aWQgdmRwYXNpbV92cV9ub3RpZnkoc3RydWN0IHZyaW5naCAqdnJpbmcpCj4+K3sKPj4rCXN0cnVj
dCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEgPQo+PisJCWNvbnRhaW5lcl9vZih2cmluZywgc3RydWN0
IHZkcGFzaW1fdmlydHF1ZXVlLCB2cmluZyk7Cj4+Kwo+PisJaWYgKCF2cS0+Y2IpCj4+KwkJcmV0
dXJuOwo+PisKPj4rCXZxLT5jYih2cS0+cHJpdmF0ZSk7Cj4+K30KPj4rCj4+ICBzdGF0aWMgdm9p
ZCB2ZHBhc2ltX3F1ZXVlX3JlYWR5KHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCB1bnNpZ25lZCBp
bnQgaWR4KQo+PiAgewo+PiAgCXN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnEgPSAmdmRwYXNp
bS0+dnFzW2lkeF07Cj4+QEAgLTEzMSw2ICsxNDIsOCBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX3F1
ZXVlX3JlYWR5KHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCB1bnNpZ25lZCBpbnQgaWR4KQo+PiAg
CQkJICAodWludHB0cl90KXZxLT5kcml2ZXJfYWRkciwKPj4gIAkJCSAgKHN0cnVjdCB2cmluZ191
c2VkICopCj4+ICAJCQkgICh1aW50cHRyX3QpdnEtPmRldmljZV9hZGRyKTsKPj4rCj4+Kwl2cS0+
dnJpbmcubm90aWZ5ID0gdmRwYXNpbV92cV9ub3RpZnk7Cj4KPgo+RG8gd2UgbmVlZCB0byBjbGVh
ciBub3RpZnkgZHVyaW5nIHJlc2V0PwoKUmlnaHQsIEknbGwgY2xlYXIgaXQuCgo+Cj5PdGhlciBs
b29rcyBnb29kLgo+CgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
