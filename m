Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91A0C64E8A
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 11:10:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F692076E
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 11:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHF1rvEu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F692076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 62E8585E7D;
	Mon, 30 Nov 2020 11:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jrgkYQxZ6PVq; Mon, 30 Nov 2020 11:10:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E3CEE8554A;
	Mon, 30 Nov 2020 11:10:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA7F8C163C;
	Mon, 30 Nov 2020 11:10:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 739FBC0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 11:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6147185E2B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 11:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O4HgtsfF0gUG
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 11:10:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7255D8554A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606734627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bBA2P9rkCmIFocbgo88SKG1Ky5jlDdKUXcYMQbA/xcY=;
 b=gHF1rvEujk5H9YIRj1+0ZZlgPfWcyEAs2fGg5nNsfJpt4Pgk03xq8vkJqgWH6xCtEiq5Qj
 7gCQWrr1g89JLEOxL8VmTiVzse3L7Fy2ZUHJftvWwQzbw7/vTveT41ix5gzvWO7fIV9gmt
 u01hujbvfvrTcVj5SmGszvf+5DiIICo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-gwjYjfhLM0Ot40Nq8GEUwA-1; Mon, 30 Nov 2020 06:10:20 -0500
X-MC-Unique: gwjYjfhLM0Ot40Nq8GEUwA-1
Received: by mail-wm1-f70.google.com with SMTP id q17so4253917wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:10:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=bBA2P9rkCmIFocbgo88SKG1Ky5jlDdKUXcYMQbA/xcY=;
 b=iZWRrBmRDooK9n/LOr21FIlhWWHrkOwIbyRbhxty9aVRxXCHnMO7UELbZXvcZtD5OM
 IrBaCROdxDWW978+oFOTNdumRgZ/sEx48zulc94LKO+RBfGqIeZvZNmdoWompkZbFBOC
 gAnM/Fu9nY4JzUf6QeAA8HY8Xk5rNmqraMzNfLZ75DBeDrGddAdspk6UwylPdDbFhjo2
 ryZFUHEQqrdAA1c6fLarARyXhk9CiqDsCUVm5Ti1yqA/DgWnVm1t0dSLd/BDEhBgQdoR
 hpuH1/Wx4DhElXBcd1zyUTbOPktD4djSJHZn2f8sFo4mosH71l2+Lzl6gpOMOxifMOQY
 65yg==
X-Gm-Message-State: AOAM532EHlC0lUAbXe8iSYpWmzqouPLjCC8xfaFB/XVmO73FdFPZQyZ/
 t1wqc6g3+X3aFlFQndMH2ugX70+unbHrBSjkjzyN1DUjjCZfJHgtXf5tt0CUC/cju2pOBd3ZzBR
 Tf5Bi3ctgyfHRaGxmH40y5xGCTWPJ8ys0gd90l9ShEA==
X-Received: by 2002:adf:c452:: with SMTP id a18mr28254904wrg.189.1606734619412; 
 Mon, 30 Nov 2020 03:10:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymQVb/kChQ/Fx2/IqMU8g40mwj11rjePfVOwyuBCUP+xmJ0inwWZbZZ1mfbCHPL0E3AvfBFg==
X-Received: by 2002:adf:c452:: with SMTP id a18mr28254887wrg.189.1606734619219; 
 Mon, 30 Nov 2020 03:10:19 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id f199sm24129875wme.15.2020.11.30.03.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 03:10:18 -0800 (PST)
Date: Mon, 30 Nov 2020 12:10:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 02/17] vdpa_sim: remove unnecessary headers inclusion
Message-ID: <20201130111015.74h3ratcegf6xlw5@steredhat>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-3-sgarzare@redhat.com>
 <f900316d-a642-714e-65b6-5b6cc4b79b48@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f900316d-a642-714e-65b6-5b6cc4b79b48@redhat.com>
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

T24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6MDQ6NDlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8yNiDkuIvljYgxMDo0OSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+PlNvbWUgaGVhZGVycyBhcmUgbm90IG5lY2Vzc2FyeSwgc28gbGV0J3MgcmVtb3ZlIHRoZW0g
dG8gZG8KPj5zb21lIGNsZWFuaW5nLgo+Pgo+PlNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFy
ZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4tLS0KPj4gIGRyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jIHwgMTMgLS0tLS0tLS0tLS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDEzIGRl
bGV0aW9ucygtKQo+Pgo+PmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW0uYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+aW5kZXggNmE5MGZkYjlj
YmZjLi5jNmVhZjYyZGY4ZWMgMTAwNjQ0Cj4+LS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3Zk
cGFfc2ltLmMKPj4rKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+PkBAIC03
LDI0ICs3LDExIEBACj4+ICAgKgo+PiAgICovCj4+LSNpbmNsdWRlIDxsaW51eC9pbml0Lmg+Cj4+
ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+Cj4+LSNpbmNsdWRlIDxsaW51eC9kZXZpY2UuaD4K
Pgo+Cj5JIHRoaW5rIHRoZSBydWxlIGlzIHRvIG1ha2Ugc3VyZSBlLmcgdGhlIHN0cnVjdHVyZSBk
ZWZpbml0aW9uIGNhbiBiZSAKPnZpYSBkaXJlY3QgaW5jbHVzaW9uLiBFLmcgc3RydWN0IGRldmlj
ZSB7fSBpcyBkZWZpbmVkIGluIHRoaXMgZmlsZS4KPgo+Cj4+LSNpbmNsdWRlIDxsaW51eC9rZXJu
ZWwuaD4KPj4tI2luY2x1ZGUgPGxpbnV4L2ZzLmg+Cj4+LSNpbmNsdWRlIDxsaW51eC9wb2xsLmg+
Cj4+LSNpbmNsdWRlIDxsaW51eC9zbGFiLmg+Cj4+LSNpbmNsdWRlIDxsaW51eC9zY2hlZC5oPgo+
Pi0jaW5jbHVkZSA8bGludXgvd2FpdC5oPgo+Pi0jaW5jbHVkZSA8bGludXgvdXVpZC5oPgo+Pi0j
aW5jbHVkZSA8bGludXgvaW9tbXUuaD4KPj4gICNpbmNsdWRlIDxsaW51eC9kbWEtbWFwLW9wcy5o
Pgo+Pi0jaW5jbHVkZSA8bGludXgvc3lzZnMuaD4KPj4tI2luY2x1ZGUgPGxpbnV4L2ZpbGUuaD4K
Pj4gICNpbmNsdWRlIDxsaW51eC9ldGhlcmRldmljZS5oPgo+PiAgI2luY2x1ZGUgPGxpbnV4L3Zy
aW5naC5oPgo+PiAgI2luY2x1ZGUgPGxpbnV4L3ZkcGEuaD4KPj4tI2luY2x1ZGUgPGxpbnV4L3Zp
cnRpb19ieXRlb3JkZXIuaD4KPgo+Cj5BbmQgdGhlwqAgX19jcHVfdG9fdmlydGlvMTYgaXMgZGVm
aW5lZCBpbiB0aGlzIGZpbGUuCj4KCk9rYXksIEknbGwga2VlcCB0aGlzIHR3byBpbmNsdWRlcyBh
bmQgY2hlY2sgYmV0dGVyIHRoZSBvdGhlcnMuCgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
