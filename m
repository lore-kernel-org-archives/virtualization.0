Return-Path: <SRS0=HWuT=EY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0596C56202
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:00:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6314C221E9
	for <virtualization@archiver.kernel.org>; Wed, 18 Nov 2020 09:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epeFmXuG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6314C221E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DE505858B6;
	Wed, 18 Nov 2020 09:00:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 58Rh17c5FKkX; Wed, 18 Nov 2020 09:00:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 73D098561D;
	Wed, 18 Nov 2020 09:00:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69D5DC0800;
	Wed, 18 Nov 2020 09:00:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD3BFC07FF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:00:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C989287036
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:00:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iuE9F3sEtSIq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:00:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E3CB687183
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 09:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605690003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vDHRiKISJxGrQNI5r+p1qOzE9Z04EU79HQXJnXOQAyM=;
 b=epeFmXuG0tCYLP/m5ZSJlTUwZY/OUmPuk0HnZf3cC/iniYClXPfzqfzmRGrunc4VbqpBTi
 je6a7BZohCqrnSOK07kOHcaAdcq1OW3dFbOf43NZH6e7wNLbpqQwgamG/6Iubuuu3Xvl2/
 TNhd6CKN89NKkMCTXxgtWnlnb1TD0xo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-o6WLmsRwOteRK36m5sOFEQ-1; Wed, 18 Nov 2020 04:00:01 -0500
X-MC-Unique: o6WLmsRwOteRK36m5sOFEQ-1
Received: by mail-wr1-f69.google.com with SMTP id w17so640442wrp.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Nov 2020 01:00:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=vDHRiKISJxGrQNI5r+p1qOzE9Z04EU79HQXJnXOQAyM=;
 b=VOjYBZE217EXsIJispHYEACES6Yenzc6/Aimq39cYmUmMOcBFvWW9BcpVXDQxxUGxQ
 pcapkAjQ6Q25uYrf0kydYtu95HHSMgKkjfVFH7MEOQRAGD9wRWL8xLCwOGzCT2ngLLIQ
 Bk6VJQNdeNI4wt/AZwQzOpNK47nnMidk4P+9jeKsCu+e8Me7HDVxTPyznAfjZVIk9gwp
 gG13rEkn4mVb8dFtoY4WWdA6ffdtds8iuC4C1mqrgqeykAxYId9Er6FNLGkh8bxgedsB
 dD75xVnypKY+BY51sN/+2inVyi1bJRMKsh8xfPGZ2RwQhcWOjgY9Yy0Dqyah5W62HAvU
 Vrtw==
X-Gm-Message-State: AOAM533WDoCg3efKMECaksb96uNnXkfSarVI32WX5cPJ7wYdjJ1VdfmJ
 YwYuy9qGBoAOZADKVBAyBC8s4N8ahtj2nhU44VS7AWBtfjVrbkNgRi9a1WrLl89VQZgtFzOQt3U
 Y3pot7uVnt8d7zqZO29P5/+gKYXtNrdRlLrh/vy7DZw==
X-Received: by 2002:adf:e484:: with SMTP id i4mr3807467wrm.398.1605690000209; 
 Wed, 18 Nov 2020 01:00:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvrhlBebUzDcS1q8vIsRe9j3CAHx2KE5uTkubSY1aExSKkOG/BenM/FdfTnVGvEnynvcKDSg==
X-Received: by 2002:adf:e484:: with SMTP id i4mr3807461wrm.398.1605690000074; 
 Wed, 18 Nov 2020 01:00:00 -0800 (PST)
Received: from redhat.com (bzq-109-67-54-78.red.bezeqint.net. [109.67.54.78])
 by smtp.gmail.com with ESMTPSA id
 i11sm33187631wro.85.2020.11.18.00.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2020 00:59:59 -0800 (PST)
Date: Wed, 18 Nov 2020 03:59:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net] vhost_vdpa: Return -EFUALT if copy_from_user() fails
Message-ID: <20201118035912-mutt-send-email-mst@kernel.org>
References: <20201023120853.GI282278@mwanda>
 <20201023113326-mutt-send-email-mst@kernel.org>
 <4485cc8d-ac69-c725-8493-eda120e29c41@redhat.com>
 <e7242333-b364-c2d8-53f5-1f688fc4d0b5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <e7242333-b364-c2d8-53f5-1f688fc4d0b5@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kuba@kernel.org, Dan Carpenter <dan.carpenter@oracle.com>
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

T24gV2VkLCBOb3YgMTgsIDIwMjAgYXQgMDI6MDg6MTdQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEwLzI2IOS4iuWNiDEwOjU5LCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4g
Cj4gPiBPbiAyMDIwLzEwLzIzIOS4i+WNiDExOjM0LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiA+IE9uIEZyaSwgT2N0IDIzLCAyMDIwIGF0IDAzOjA4OjUzUE0gKzAzMDAsIERhbiBDYXJw
ZW50ZXIgd3JvdGU6Cj4gPiA+ID4gVGhlIGNvcHlfdG8vZnJvbV91c2VyKCkgZnVuY3Rpb25zIHJl
dHVybiB0aGUgbnVtYmVyIG9mIGJ5dGVzIHdoaWNoIHdlCj4gPiA+ID4gd2VyZW4ndCBhYmxlIHRv
IGNvcHkgYnV0IHRoZSBpb2N0bCBzaG91bGQgcmV0dXJuIC1FRkFVTFQgaWYgdGhleSBmYWlsLgo+
ID4gPiA+IAo+ID4gPiA+IEZpeGVzOiBhMTI3YzViYmI2YTggKCJ2aG9zdC12ZHBhOiBmaXggYmFj
a2VuZCBmZWF0dXJlIGlvY3RscyIpCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRGFuIENhcnBlbnRl
ciA8ZGFuLmNhcnBlbnRlckBvcmFjbGUuY29tPgo+ID4gPiBBY2tlZC1ieTogTWljaGFlbCBTLiBU
c2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+ID4gTmVlZGVkIGZvciBzdGFibGUgSSBndWVzcy4K
PiA+IAo+ID4gCj4gPiBBZ3JlZS4KPiA+IAo+ID4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+Cj4gCj4gCj4gSGkgTWljaGFlbC4KPiAKPiBJIGRvbid0IHNlZSB0aGlz
IGluIHlvdXIgdHJlZSwgcGxlYXNlIGNvbnNpZGVyIHRvIG1lcmdlLgo+IAo+IFRoYW5rcwo+IAoK
SSBkbyBzZWUgaXQgdGhlcmU6Cgpjb21taXQgNzkyMjQ2MGUzM2M4MWY0MWUwZDI0MjE0MTcyMjhi
MzJlNmZkYmU5NApBdXRob3I6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNv
bT4KRGF0ZTogICBGcmkgT2N0IDIzIDE1OjA4OjUzIDIwMjAgKzAzMDAKCiAgICB2aG9zdF92ZHBh
OiBSZXR1cm4gLUVGQVVMVCBpZiBjb3B5X2Zyb21fdXNlcigpIGZhaWxzCiAgICAKdGhlIHJlYXNv
biB5b3UgY2FuJ3QgZmluZCBpdCBpcyBwcm9iYWJseSBiZWNhdXNlIEkgZml4ZWQgdXAKYSB0eXBv
IGluIHRoZSBzdWJqZWN0LgoKCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
