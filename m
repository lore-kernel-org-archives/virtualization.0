Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D33C4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 08:38:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1B4160FC0
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 08:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1B4160FC0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89F75404B6;
	Wed, 11 Aug 2021 08:38:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6xTsvd-Ur1R4; Wed, 11 Aug 2021 08:38:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 95D334049F;
	Wed, 11 Aug 2021 08:38:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7152C001B;
	Wed, 11 Aug 2021 08:37:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB006C001F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:37:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A3031608DC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:37:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XM2LSLPt1Q6j
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:37:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7F2A60889
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628671074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQGq2oZOOou0uTNhMEWRj+fRhTCJj6KrKluauxdPWec=;
 b=GE/DzZpXQmGBmy5KAOmeaW3rFXQcZDbd5hibOBxyCkiey8XL4iHPnwgNmWPlRmrIfCnX8m
 KJw4URZ64Jg4mFLDu8gkK7v5/OiWWXDoIvOthxf4+2INMLMlpqaiirFXZSmdjHE7qojqkR
 d85saej3L7g6Vkc5gazFsMdags1OSDk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-201-xYXG5u8QP923faUmaoQ__Q-1; Wed, 11 Aug 2021 04:37:53 -0400
X-MC-Unique: xYXG5u8QP923faUmaoQ__Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 t16-20020a17090ae510b0290178bb9f2f04so1884768pjy.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 01:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=VQGq2oZOOou0uTNhMEWRj+fRhTCJj6KrKluauxdPWec=;
 b=NtScwOrY8GBvzG8sf+DL6Skmtpl51m5cLUrTkLTMUjEn+zscC0ARWWWuSDHgHvl0H/
 nsdOEqX/YLXZy9PGaO8DMkIAFMUNh0GcRcaiRmrtpZURbROdzYMH+SjxLuUmEJuyTR2l
 lc9622eDfdEC4QTBQTEKih82DDvVPXZdfwzRHqZAlZf0VVpXebkSeOiyLodEThQIGZBv
 CeWaE0822vv1hVS16GwRc0JcClWCGmDBhTaUIDX6OOTClgEDh8cb27LEfHofTQwxlNs4
 xoFMPDYkKAJseck6E3EU6chL/lKfbEyXsGIjdok+u9lp0kslxEH5r75/kqReuobr3Aw3
 pHMA==
X-Gm-Message-State: AOAM530/Q3fIMKuz3+TkLWeEb6S4+tjItv/XavG4JYzJjYiG6HVj8F3N
 il54/+6qPQpNLmqNGLUxi2AEH218pX2grsmtQvNzR2QiwJMaYc5ZhE6NJAbH7jxuCCdKgwCnKjv
 ePiuEBjtFsgcn08HN0ROxKfMmSSmBcUlQu/mDWeBXrA==
X-Received: by 2002:a17:902:7611:b029:12b:e55e:6ee8 with SMTP id
 k17-20020a1709027611b029012be55e6ee8mr3400246pll.4.1628671072349; 
 Wed, 11 Aug 2021 01:37:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8M+P+1SPtfMiCt8mkLKE/uE5E3kENy5i80lkucyDlma2z4frINix2pdk2iHQ0iasUy7EKTA==
X-Received: by 2002:a17:902:7611:b029:12b:e55e:6ee8 with SMTP id
 k17-20020a1709027611b029012be55e6ee8mr3400230pll.4.1628671072113; 
 Wed, 11 Aug 2021 01:37:52 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id u24sm20027369pfm.85.2021.08.11.01.37.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Aug 2021 01:37:51 -0700 (PDT)
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Eli Cohen <elic@nvidia.com>
References: <20210809140800.97835-1-elic@nvidia.com>
 <20210809140800.97835-4-elic@nvidia.com>
 <07002568-e792-aa35-ec42-5e0f12883a03@redhat.com>
 <20210811075347.GC56418@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fccc39c8-f9af-e489-8804-511cb07f1ed2@redhat.com>
Date: Wed, 11 Aug 2021 16:37:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811075347.GC56418@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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

CuWcqCAyMDIxLzgvMTEg5LiL5Y2IMzo1MywgRWxpIENvaGVuIOWGmemBkzoKPj4gT25lIHRoaW5n
IG5lZWQgdG8gc29sdmUgZm9yIG1xIGlzIHRoYXQgdGhlOgo+Pgo+Pgo+Pj4gK3N0YXRpYyB1MTYg
Y3RybF92cV9pZHgoc3RydWN0ICBtbHg1X3ZkcGFfZGV2ICptdmRldikKPj4+ICt7Cj4+PiArwqAg
wqAgwqByZXR1cm4gMiAqICBtbHg1X3ZkcGFfbWF4X3FwcyhtdmRldi0+bWF4X3Zxcyk7Cj4+PiAr
fQo+PiBXZSBzaG91bGQgaGFuZGxlIHRoZSBjYXNlIHdoZW4gTVEgaXMgc3VwcG9ydGVkIGJ5IHRo
ZSBkZXZpY2UgYnV0IG5vdCB0aGUKPj4gZHJpdmVyLgo+Pgo+PiBFLmcgaW4gdGhlIGNhc2Ugd2hl
biB3ZSBoYXZlIDIgcXVldWUgcGFpcnM6Cj4+Cj4+IFdoZW4gTVEgaXMgZW5hYmxlZCwgY3ZxIGlz
IHF1ZXVlIDQKPj4KPj4gV2hlbiBNUSBpcyBub3QgZW5hYmxlZCwgY3ZxIGlzIHF1ZXVlIDIKPj4K
PiBUaGVyZSdzIHNvbWUgaXNzdWUgd2l0aCB0aGlzLiBJIGdldCBjYWxsYmFja3MgdGFyZ2V0aW5n
IHNwZWNpZmljCj4gdmlydHF1ZXVlcyBiZWZvcmUgZmVhdHVyZXMgbmVnb3RpYXRpb24gaGFzIGJl
ZW4gY29tcGxldGVkLgo+Cj4gU3BlY2lmaWNhbGx5LCBJIGdldCBzZXRfdnFfY2IoKSBjYWxscy4g
QXQgdGhpcyBwb2ludCBJIG11c3Qga25vdyB0aGUKPiBjb250cm9sIHZxIGluZGV4LgoKClNvIEkg
dGhpbmsgd2UgbmVlZCBkbyBib3RoOgoKMSkgQXQgb25lIGhhbmQsIGl0J3MgYSBidWcgZm9yIHRo
ZSB1c2Vyc3BhY2UgdG8gdXNlIHZxX2luZGV4IGJlZm9yZSAKZmVhdHVyZSBpcyBuZWdvdGlhdGVk
CgoobG9va3MgbGlrZSBhIGJ1ZyBpbiBteSBjdnEgc2VyaWVzIHRoYXQgd2lsbCBjYWxsIFNFVF9W
UklOR19DQUxMIGJlZm9yZSAKZmVhdHVyZSBpcyBuZWdvdGlhdGUsIHdoaWNoIEkgd2lsbCBsb29r
KS4KCjIpIEF0IHRoZSBvdGhlciBoYW5kLCB0aGUgZHJpdmVyIHNob3VsZCBiZSBhYmxlIHRvIGRl
YWwgd2l0aCB0aGF0CgoKPgo+IEkgdGhpbmsgdGhlIENWUSBpbmRleCBtdXN0IG5vdCBkZXBlbmQg
b24gdGhlIG5lZ290aWF0ZWQgZmVhdHVyZXMgYnV0Cj4gcmF0aGVyIGRlcGVuZCBvZiB0aGUgdmFs
dWUgdGhlIGRldmljZSBkcml2ZXIgcHJvdmlkZXMgaW4gdGhlIGNhbGwgdG8KPiBfdmRwYV9yZWdp
c3Rlcl9kZXZpY2UoKS4KCgpBdCB0aGUgdmlydGlvIGxldmVsLCBpdCdzIHRvbyBsYXRlIHRvIGNo
YW5nZSB0aGF0IGFuZCBpdCBicmVha3MgdGhlIApiYWNrd2FyZCBjb21wYXRpYmlsaXR5LgoKQnV0
IGF0IHRoZSB2RFBBIGxldmVsLCB0aGUgdW5kZXIgbGF5ZXIgZGV2aWNlIGNhbiBtYXAgdmlydGlv
IGN2cSB0byBhbnkgCm9mIGl0J3MgdmlydHF1ZXVlLgoKRS5nIG1hcCBjdnEgKGluZGV4IDIpIHRv
IG1seDUgY3ZxICh0aGUgbGFzdCkuCgpUaGFua3MKCgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
