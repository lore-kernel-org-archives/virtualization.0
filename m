Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACCB4C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 08:38:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A96064F11
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 08:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A96064F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F11C5844AF;
	Fri,  5 Mar 2021 08:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iROEeykllREa; Fri,  5 Mar 2021 08:38:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99A9D84429;
	Fri,  5 Mar 2021 08:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77D8CC000B;
	Fri,  5 Mar 2021 08:38:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BADC2C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8F35844AF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:38:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 75v7kkfwWMIB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:38:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E5F1C84429
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614933517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAI/I8B7wpZIUjXzzsxu1gO3qnb8MhXPXX1hsky7UW0=;
 b=duCFqQf9ho5cF8PRY81PeT0PQX2EvfSTw5kljqfcPP4SfiVRMq7nAPoVI1+OYIINSyKKDo
 2ILs46jzXb9vwBcBYoH3liCmKlRwfkSIqTPqdUF5nyjgF4MzAxTitzYyVKR9o9WiVinmcp
 HpVUFxwE+rW9/pRFheGv+kmb0Ro+dNc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-7PbxKl8TN06KMrgrAPRMkw-1; Fri, 05 Mar 2021 03:38:36 -0500
X-MC-Unique: 7PbxKl8TN06KMrgrAPRMkw-1
Received: by mail-ej1-f71.google.com with SMTP id e13so534529ejd.21
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Mar 2021 00:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=YAI/I8B7wpZIUjXzzsxu1gO3qnb8MhXPXX1hsky7UW0=;
 b=gHohylGEqfqR2Onyfb+kMUXpAEJJpvtpI1oEzt9mUuGB4SEgkMudMJyVENWEKEPpfe
 XXs7TrzNjrrKFIuVZ1qAuUaYBfaznXZ/knRn/ynpbOnjo58ZKG5kcdaOonuJMk2YcucF
 fyuhWA3esUD314l/PBmjPb9hjRji0unsBc16B2ZR0vEb0CfqEmyleM+L6ndURXQwyUzv
 bAszL3DBecHVoImdWHSj3esvrHiCnJy4fEYYFHyhMryNyaVKfhJov7glb9QhAIlFrfpX
 LcxZqDw4LzbKpZIxSJbZiDA0eUYgGoT4UwjKJXXpzR2uleJMuxRW+aXySThXOBQV0bzL
 zbWg==
X-Gm-Message-State: AOAM530bKeX+6thaeg5M9tEqBgUA68HIeAlGCM5dFJyW6dmMeIImXYSS
 JEQV56jNE/uB7Db3yyBUuWryQsGKlVIhLfoNg9uKgGEd4waIPaiXkbYQ5l5eIFoR+qKIx46+FXH
 h78+yi9DzFLYiZvrTWMhJDvlX8u8mTNAet4osUjuLCA==
X-Received: by 2002:aa7:c4c2:: with SMTP id p2mr8145830edr.213.1614933514896; 
 Fri, 05 Mar 2021 00:38:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpKQMBiWEPcNeeOxJLoLVSCp4kYG/AfcmBBA9HYJJaMxhtQXqPnopI+sO2MueR69Vo1Ksn1A==
X-Received: by 2002:aa7:c4c2:: with SMTP id p2mr8145823edr.213.1614933514755; 
 Fri, 05 Mar 2021 00:38:34 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s18sm1227188edc.21.2021.03.05.00.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 00:38:34 -0800 (PST)
Date: Fri, 5 Mar 2021 09:38:32 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 01/10] vdpa: add get_config_size callback in
 vdpa_config_ops
Message-ID: <20210305083832.hotg52p7kluus2xq@steredhat>
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-2-sgarzare@redhat.com>
 <5de4cd5b-04cb-46ca-1717-075e5e8542fd@redhat.com>
 <20210302141516.oxsdb7jogrvu75yc@steredhat>
 <8a3f39ab-1cee-d0c3-e4d1-dc3ec492a763@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8a3f39ab-1cee-d0c3-e4d1-dc3ec492a763@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

T24gVGh1LCBNYXIgMDQsIDIwMjEgYXQgMDQ6MzQ6NTJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8zLzIgMTA6MTUg5LiL5Y2ILCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+T24gVHVlLCBNYXIgMDIsIDIwMjEgYXQgMTI6MTQ6MTNQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Cj4+Pk9uIDIwMjEvMi8xNiA1OjQ0IOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxh
IHdyb3RlOgo+Pj4+VGhpcyBuZXcgY2FsbGJhY2sgaXMgdXNlZCB0byBnZXQgdGhlIHNpemUgb2Yg
dGhlIGNvbmZpZ3VyYXRpb24gc3BhY2UKPj4+Pm9mIHZEUEEgZGV2aWNlcy4KPj4+Pgo+Pj4+U2ln
bmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+Pj4+
LS0tCj4+Pj7CoGluY2x1ZGUvbGludXgvdmRwYS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fCA0ICsrKysKPj4+PsKgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uY8KgwqAgfCA2ICsr
KysrKwo+Pj4+wqBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA2ICsrKysrKwo+
Pj4+wqBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uY8KgIHwgOSArKysrKysrKysKPj4+
PsKgNCBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspCj4+Pj4KPj4+PmRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+Pj5pbmRleCA0
YWI1NDk0NTAzYTguLmZkZGY0MmIxNzU3MyAxMDA2NDQKPj4+Pi0tLSBhL2luY2x1ZGUvbGludXgv
dmRwYS5oCj4+Pj4rKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+QEAgLTE1MCw2ICsxNTAs
OSBAQCBzdHJ1Y3QgdmRwYV9pb3ZhX3JhbmdlIHsKPj4+PsKgICogQHNldF9zdGF0dXM6wqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBTZXQgdGhlIGRldmljZSBzdGF0dXMKPj4+PsKgICrCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgQHZkZXY6IHZkcGEgZGV2aWNlCj4+Pj7CoCAqwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIEBzdGF0dXM6IHZpcnRpbyBkZXZpY2Ugc3RhdHVzCj4+Pj4r
ICogQGdldF9jb25maWdfc2l6ZTrCoMKgwqDCoMKgwqDCoCBHZXQgdGhlIHNpemUgb2YgdGhlIGNv
bmZpZ3VyYXRpb24gc3BhY2UKPj4+PisgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBA
dmRldjogdmRwYSBkZXZpY2UKPj4+PisgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBS
ZXR1cm5zIHNpemVfdDogY29uZmlndXJhdGlvbiBzaXplCj4+Pgo+Pj4KPj4+UmV0aGluayBhYm91
dCB0aGlzLCBob3cgbXVjaCB3ZSBjb3VsZCBnYWluIGJ5IGludHJvZHVjaW5nIGEgCj4+PmRlZGlj
YXRlZCBvcHMgaGVyZT8gRS5nIHdvdWxkIGl0IGJlIHNpbXBsZXIgaWYgd2Ugc2ltcGx5IGludHJv
ZHVjZSAKPj4+YSBtYXhfY29uZmlnX3NpemUgdG8gdmRwYSBkZXZpY2U/Cj4+Cj4+TWFpbmx5IGJl
Y2F1c2UgaW4gdGhpcyB3YXkgd2UgZG9uJ3QgaGF2ZSB0byBhZGQgbmV3IHBhcmFtZXRlcnMgdG8g
Cj4+dGhlIHZkcGFfYWxsb2NfZGV2aWNlKCkgZnVuY3Rpb24uCj4+Cj4+V2UgZG8gdGhlIHNhbWUg
Zm9yIGV4YW1wbGUgZm9yICdnZXRfZGV2aWNlX2lkJywgJ2dldF92ZW5kb3JfaWQnLCAKPj4nZ2V0
X3ZxX251bV9tYXgnLiBBbGwgb2YgdGhlc2UgYXJlIHVzdWFsbHkgc3RhdGljLCBidXQgd2UgaGF2
ZSBvcHMuCj4+SSB0aGluayBiZWNhdXNlIGl0J3MgZWFzaWVyIHRvIGV4dGVuZC4KPj4KPj5JIGRv
bid0IGtub3cgaWYgaXQncyB3b3J0aCBhZGRpbmcgYSBuZXcgc3RydWN0dXJlIGZvciB0aGVzZSBz
dGF0aWMgCj4+dmFsdWVzIGF0IHRoaXMgcG9pbnQsIGxpa2UgJ3N0cnVjdCB2ZHBhX2NvbmZpZ19w
YXJhbXMnLgo+Cj4KPlllcywgdGhhdCdzIHRoZSBwb2ludC4gSSB0aGluayBmb3IgYW55IHN0YXRp
YyB2YWx1ZXMsIGl0IHNob3VsZCBiZSBzZXQgCj5kdXJpbmcgZGV2aWNlIGFsbG9jYXRpb24uCgpZ
ZWFoLCBJIHNlZS4KCj4KPkknbSBmaW5lIHdpdGggYm90aC4KPgoKQE1pY2hhZWwgYW55IHRob3Vn
aHRzPwoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
