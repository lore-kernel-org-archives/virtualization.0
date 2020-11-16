Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C595FC4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 09:40:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ABA02225B
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 09:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8fZC4gu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABA02225B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F335822C2;
	Mon, 16 Nov 2020 09:40:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BM_7MKIyPleg; Mon, 16 Nov 2020 09:40:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1DA89822AE;
	Mon, 16 Nov 2020 09:40:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB608C0891;
	Mon, 16 Nov 2020 09:40:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91513C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:40:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8CA3F82221
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:40:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h2cPmiGUtqjs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:40:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BB1EC8208A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 09:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605519600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ctbNdgMCLqm0MmL6XQ46F/duayfW4vdoR6bBEw0CqiM=;
 b=b8fZC4gueD5StJBsKu7a6oIDMHKdAuHL/RiYLiFpeW1GozT4Jc8TcPHyWbKkL78ZVZI8Na
 vwioMz93VIPBGRRK81+OrOIecfZ/4xZlq5hOVoAm5rgnxiSTI48PU60kTbo81iCtAvCDvF
 UT1psN3gzqxWhD6T1qjv0p/Jf1GY0YY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-f8nW03GgNByC1sJsKDZZyQ-1; Mon, 16 Nov 2020 04:39:58 -0500
X-MC-Unique: f8nW03GgNByC1sJsKDZZyQ-1
Received: by mail-wm1-f71.google.com with SMTP id h2so10028264wmm.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 01:39:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ctbNdgMCLqm0MmL6XQ46F/duayfW4vdoR6bBEw0CqiM=;
 b=e08KJpzFZwXziMGZWnk/JB/+NbghlpjP20QwUizyn8VYvz+R2gxeI5phahr8nXaiJU
 QDY3a4T7wlWrD3g/MZEse197HqYp7HQh2hw8FtOEnofJ5Gt9dJfWb1B/vZEjIXrSnoRD
 dliIv5hUBm+ZH7g27QTEfWBiSUEvy/aY3cCyHz4TjrH95jK0dzsiL0dcTQKMD8D7GFbs
 wwdw7FQwpneCLcrhZClVmWVCSQ4iFo2aKypr1+ehI+IuQN2g1i9w4BJBi/9k7Avia8jY
 2iR6+DBKkeiXRhGaJOxA2FcBwobJYXNFtfewwby8D3VpSz7yy3jjXf8sn7mvpgkVeGES
 PoxQ==
X-Gm-Message-State: AOAM530XB8SeXWwXw6No5KijKON+3tfXPJCDdr0HmDF3IWTLD5U7NVTI
 NXlBHPSyXALS4tTfF5+/Ipc8fxUDfMix+34pdXCHQJC70MwyvgxMdw9TUf6VuYoo7W50FmrESiq
 zexoL9nP3dxYDCf1DUfGmfMfNzYi9OWPnP7wQlBD0iA==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr11028705wmf.76.1605519597622; 
 Mon, 16 Nov 2020 01:39:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3nAGrNoe04CizjIX7ieFEVYDthOVy/X7dUVJm6aMD7Taix3cf0pxgzpGIP9IGHbQZEQHmlA==
X-Received: by 2002:a1c:bac1:: with SMTP id k184mr11028685wmf.76.1605519597450; 
 Mon, 16 Nov 2020 01:39:57 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id t74sm19457618wmt.8.2020.11.16.01.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 01:39:56 -0800 (PST)
Date: Mon, 16 Nov 2020 10:39:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 02/12] vdpa: split vdpasim to core and net modules
Message-ID: <20201116093954.svf6yjmmn55mdtl4@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-3-sgarzare@redhat.com>
 <d2224629-6ca1-ed06-e2e9-f6008a3af727@redhat.com>
MIME-Version: 1.0
In-Reply-To: <d2224629-6ca1-ed06-e2e9-f6008a3af727@redhat.com>
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

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MDA6MTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8xMyDkuIvljYg5OjQ3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+RnJvbTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4KPj4KPj5JbnRyb2R1
Y2UgbmV3IHZkcGFfc2ltX25ldCBhbmQgdmRwYV9zaW0gKGNvcmUpIGRyaXZlcnMuIFRoaXMgaXMg
YQo+PnByZXBhcmF0aW9uIGZvciBhZGRpbmcgYSB2ZHBhIHNpbXVsYXRvciBtb2R1bGUgZm9yIGJs
b2NrIGRldmljZXMuCj4+Cj4+U2lnbmVkLW9mZi1ieTogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lA
bnZpZGlhLmNvbT4KPj5bc2dhcnphcmU6IHZhcmlvdXMgY2xlYW51cHMvZml4ZXNdCj4+U2lnbmVk
LW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+Pi0tLQo+
PnYxOgo+Pi0gUmVtb3ZlZCB1bnVzZWQgaGVhZGVycwo+Pi0gUmVtb3ZlZCBlbXB0eSBtb2R1bGVf
aW5pdCgpIG1vZHVsZV9leGl0KCkKPj4tIE1vdmVkIHZkcGFzaW1faXNfbGl0dGxlX2VuZGlhbigp
IGluIHZkcGFfc2ltLmgKPj4tIE1vdmVkIHZkcGFzaW0xNl90b19jcHUvY3B1X3RvX3ZkcGFzaW0x
NigpIGluIHZkcGFfc2ltLmgKPj4tIEFkZGVkIHZkcGFzaW0qX3RvX2NwdS9jcHVfdG9fdmRwYXNp
bSooKSBhbHNvIGZvciAzMiBhbmQgNjQKPj4tIFJlcGxhY2VkICdzZWxlY3QgVkRQQV9TSU0nIHdp
dGggJ2RlcGVuZHMgb24gVkRQQV9TSU0nIHNpbmNlIHNlbGVjdGVkCj4+ICAgb3B0aW9uIGNhbiBu
b3QgZGVwZW5kIG9uIG90aGVyIFtKYXNvbl0KPgo+Cj5JZiBwb3NzaWJsZSwgSSB3b3VsZCBzdWdn
ZXN0IHRvIHNwbGl0IHRoaXMgcGF0Y2ggZnVydGhlcjoKPgo+MSkgY29udmVydCB0byB1c2Ugdm9p
ZCAqY29uZmlnLCBhbmQgYW4gYXR0cmlidXRlIGZvciBzZXR0aW5nIGNvbmZpZyAKPnNpemUgZHVy
aW5nIGFsbG9jYXRpb24KPjIpIGludHJvZHVjZSBzdXBwb3J0ZWRfZmVhdHVyZXMKPjMpIG90aGVy
IGF0dHJpYnV0ZXMgKCN2cXMpCj40KSByZW5hbWUgY29uZmlnIG9wcyAobW9yZSBnZW5lcmljIG9u
ZSkKPjUpIGludHJvZHVjZSBvcHMgZm9yIHNldHxnZXRfY29uZmlnLCBzZXRfZ2V0X2ZlYXR1cmVz
Cj42KSByZWFsIHNwbGl0Cj4KCk9rYXksIEknbGwgdHJ5IHRvIHNwbGl0IE1heCdzIHBhdGNoIGZv
bGxvd2luZyB5b3VyIHN1Z2dlc3Rpb24uCkl0IHNob3VsZCBiZSBjbGVhbmVyLgoKVGhhbmtzLApT
dGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
