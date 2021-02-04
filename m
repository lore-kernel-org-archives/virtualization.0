Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41383C433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 11:15:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83FDB64F58
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 11:15:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FDB64F58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4A16685FA2;
	Thu,  4 Feb 2021 11:15:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TlBGI3oxJXzB; Thu,  4 Feb 2021 11:15:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 698FD85116;
	Thu,  4 Feb 2021 11:15:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47E30C07FD;
	Thu,  4 Feb 2021 11:15:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F5E2C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 11:15:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3AD3585FA2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 11:15:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ab_Tx5Hnzcy8
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 11:15:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 514BD85116
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 11:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612437341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qoCXSM3x1453D5cy2M9+HjONE+SF332T3WjcmPo3zwQ=;
 b=LaBUz0HJRJdUYXCKMVDxdHAd7FBt3xMSiGRxsc13FKs7UCPXDHqO/A3OGZhoR4c2KF7j6a
 g01la/v/zmo5AAQnZMR/6TVoHNnKWu4mBZ/Xhh0DR0Xo4AX/qr5CVzAgnRJmGd/s2s6Sag
 t0VCWk0vKbHJFK3WMaRITrF+p0gpqyQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-1bhNQUBeOa65lgI_euExSQ-1; Thu, 04 Feb 2021 06:15:39 -0500
X-MC-Unique: 1bhNQUBeOa65lgI_euExSQ-1
Received: by mail-wr1-f72.google.com with SMTP id u3so2468005wri.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 Feb 2021 03:15:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qoCXSM3x1453D5cy2M9+HjONE+SF332T3WjcmPo3zwQ=;
 b=OKqoeAmK3ilJF+k1ktIMuBzgf5QhmbbTgGqvh21JWlF4HSZAQ/QO2sLqnf8JTpvd2h
 f/Kqj7WWbYM3v5mPBwmDOPedT5Yaw739EbHqJa48NrIwR3YAH8khYDXR4q9lUr+Im8jf
 CzFg4N4bxtGMJJzyqIMDqclZEdvYyd6JAEN0A12B6KYM9y67zjZa5mO6MhLVCPSm35D1
 7ClaWimixKMIlLD6AuYMmC8Rir9mAsuGhmaNgEvKveyShU3GMzDzbob0+LW/ouJfS+e2
 8tMdtwK0L5t6cVG5hXUXUeRrpEzAgfhHNeedJNfMn7hJxbCgfhw+o0px9raR5GNuAndO
 NJMw==
X-Gm-Message-State: AOAM532cdgg6sziMHMRcKzNTe3ZoEmtGvuxKa5EBDPLKLlrYZvOuhTFs
 oeq2bDMbYUEhHHRx7vPQ9rhgvY6t6ILvP5qxA+zDXs/9gMls/2QHhP+n7aCmCBr6gtaV18zjbNp
 uZMXfmgvJyBm5TqpZPjEuWuVhTiTeR71MS0QL6BKvrw==
X-Received: by 2002:a05:600c:4e91:: with SMTP id
 f17mr6949389wmq.142.1612437338179; 
 Thu, 04 Feb 2021 03:15:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoH31eq0xrG5bA5hKL2moTr1CUTmVw/CmmxcHyW3z5rgCB/yN+sHG1ZHGilqu7BS20kfgfPw==
X-Received: by 2002:a05:600c:4e91:: with SMTP id
 f17mr6949375wmq.142.1612437338004; 
 Thu, 04 Feb 2021 03:15:38 -0800 (PST)
Received: from amorenoz.users.ipa.redhat.com ([94.73.56.18])
 by smtp.gmail.com with ESMTPSA id j4sm7741855wru.20.2021.02.04.03.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Feb 2021 03:15:37 -0800 (PST)
Subject: Re: [PATCH iproute2-next v3 0/5] Add vdpa device management tool
To: Jason Wang <jasowang@redhat.com>, Parav Pandit <parav@nvidia.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 dsahern@gmail.com, stephen@networkplumber.org, mst@redhat.com
References: <20210122112654.9593-3-parav@nvidia.com>
 <20210202103518.3858-1-parav@nvidia.com>
 <99106d07-1730-6ed8-c847-0400be0dcd57@redhat.com>
From: Adrian Moreno <amorenoz@redhat.com>
Message-ID: <1d1ff638-d498-6675-ead5-6e09213af3a8@redhat.com>
Date: Thu, 4 Feb 2021 12:15:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <99106d07-1730-6ed8-c847-0400be0dcd57@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=amorenoz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

U29ycnkgSSBoYXZlIG5vdCBmb2xsb3dlZCB0aGlzIHdvcmsgYXMgY2xvc2UgYXMgSSB3b3VsZCBo
YXZlIHdhbnRlZC4KU29tZSBxdWVzdGlvbnMgYmVsb3cuCgpPbiAyLzQvMjEgNDoxNiBBTSwgSmFz
b24gV2FuZyB3cm90ZToKPiAKPiBPbiAyMDIxLzIvMiDkuIvljYg2OjM1LCBQYXJhdiBQYW5kaXQg
d3JvdGU6Cj4+IExpbnV4IHZkcGEgaW50ZXJmYWNlIGFsbG93cyB2ZHBhIGRldmljZSBtYW5hZ2Vt
ZW50IGZ1bmN0aW9uYWxpdHkuCj4+IFRoaXMgaW5jbHVkZXMgYWRkaW5nLCByZW1vdmluZywgcXVl
cnlpbmcgdmRwYSBkZXZpY2VzLgo+Pgo+PiB2ZHBhIGludGVyZmFjZSBhbHNvIGluY2x1ZGVzIHNo
b3dpbmcgc3VwcG9ydGVkIG1hbmFnZW1lbnQgZGV2aWNlcwo+PiB3aGljaCBzdXBwb3J0IHN1Y2gg
b3BlcmF0aW9ucy4KPj4KPj4gVGhpcyBwYXRjaHNldCBpbmNsdWRlcyBrZXJuZWwgdWFwaSBoZWFk
ZXJzIGFuZCBhIHZkcGEgdG9vbC4KPj4KPj4gZXhhbXBsZXM6Cj4+Cj4+ICQgdmRwYSBtZ210ZGV2
IHNob3cKPj4gdmRwYXNpbToKPj4gwqDCoCBzdXBwb3J0ZWRfY2xhc3NlcyBuZXQKPj4KPj4gJCB2
ZHBhIG1nbXRkZXYgc2hvdyAtanAKPj4gewo+PiDCoMKgwqDCoCAic2hvdyI6IHsKPj4gwqDCoMKg
wqDCoMKgwqDCoCAidmRwYXNpbSI6IHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJzdXBw
b3J0ZWRfY2xhc3NlcyI6IFsgIm5ldCIgXQo+PiDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKg
wqAgfQo+PiB9Cj4+CgpIb3cgY2FuIGEgdXNlciBlc3RhYmxpc2ggdGhlIHJlbGF0aW9uc2hpcCBi
ZXR3ZWVuIGEgbWdtdGRldiBhbmQgaXQncyBwYXJlbnQKZGV2aWNlIChwY2kgdmYsIHNmLCBldGMp
PwoKPj4gQ3JlYXRlIGEgdmRwYSBkZXZpY2Ugb2YgdHlwZSBuZXR3b3JraW5nIG5hbWVkIGFzICJm
b28yIiBmcm9tCj4+IHRoZSBtYW5hZ2VtZW50IGRldmljZSB2ZHBhc2ltX25ldDoKPj4KPj4gJCB2
ZHBhIGRldiBhZGQgbWdtdGRldiB2ZHBhc2ltX25ldCBuYW1lIGZvbzIKPj4KCkkgZ3Vlc3MgdGhp
cyBjb21tYW5kIHdpbGwgYWNjZXB0IGEgJ3R5cGUnIHBhcmFtZXRlciBvbmNlIG1vcmUgc3VwcG9y
dGVkX2NsYXNzZXMKYXJlIGFkZGVkPwoKQWxzbywgd2lsbCB0aGlzIHRvb2wgYWxzbyBoYW5kbGUg
dGhlIHZkcGEgZHJpdmVyIGJpbmRpbmcgb3Igd2lsbCB0aGUgdXNlciBoYW5kbGUKdGhhdCB0aHJv
dWdoIHRoZSB2ZHBhIGJ1cycgc3lzZnMgaW50ZXJmYWNlPwoKPj4gU2hvdyB0aGUgbmV3bHkgY3Jl
YXRlZCB2ZHBhIGRldmljZSBieSBpdHMgbmFtZToKPj4gJCB2ZHBhIGRldiBzaG93IGZvbzIKPj4g
Zm9vMjogdHlwZSBuZXR3b3JrIG1nbXRkZXYgdmRwYXNpbV9uZXQgdmVuZG9yX2lkIDAgbWF4X3Zx
cyAyIG1heF92cV9zaXplIDI1Ngo+Pgo+PiAkIHZkcGEgZGV2IHNob3cgZm9vMiAtanAKPj4gewo+
PiDCoMKgwqDCoCAiZGV2Ijogewo+PiDCoMKgwqDCoMKgwqDCoMKgICJmb28yIjogewo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgInR5cGUiOiAibmV0d29yayIsCj4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAibWdtdGRldiI6ICJ2ZHBhc2ltX25ldCIsCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAidmVuZG9yX2lkIjogMCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJtYXhf
dnFzIjogMiwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJtYXhfdnFfc2l6ZSI6IDI1Ngo+
PiDCoMKgwqDCoMKgwqDCoMKgIH0KPj4gwqDCoMKgwqAgfQo+PiB9Cj4+Cj4+IERlbGV0ZSB0aGUg
dmRwYSBkZXZpY2UgYWZ0ZXIgaXRzIHVzZToKPj4gJCB2ZHBhIGRldiBkZWwgZm9vMgo+Pgo+PiBQ
YXRjaCBzdW1tYXJ5Ogo+PiBQYXRjaC0xIGFkZHMga2VybmVsIGhlYWRlcnMgZm9yIHZkcGEgc3Vi
c3lzdGVtCj4+IFBhdGNoLTIgYWRkcyBsaWJyYXJ5IHJvdXRpbmVzIGZvciBpbmRlbnQgaGFuZGxp
bmcKPj4gUGF0Y2gtMyBhZGRzIGxpYnJhcnkgcm91dGluZXMgZm9yIGdlbmVyaWMgc29ja2V0IGNv
bW11bmljYXRpb24KPj4gUEF0Y2gtNCBhZGRzIGxpYnJhcnkgcm91dGluZSBmb3IgbnVtYmVyIHRv
IHN0cmluZyBtYXBwaW5nCj4+IFBhdGNoLTUgYWRkcyB2ZHBhIHRvb2wKPj4KPj4gS2VybmVsIGhl
YWRlcnMgYXJlIGZyb20gdGhlIHZob3N0IGtlcm5lbCB0cmVlIFsxXSBmcm9tIGJyYW5jaCBsaW51
eC1uZXh0Lgo+Pgo+PiBbMV0gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvbXN0L3Zob3N0LmdpdAo+Pgo+PiAtLS0KPiAKPiAKPiBBZGRpbmcgQWRyaWFuIHRv
IHNlZSBpZiB0aGlzIGxvb2tzIGdvb2QgZm9yIGs4cyBpbnRlZ3JhdGlvbi4KPiAKPiBUaGFua3MK
PiAKClRoYW5rcwotLSAKQWRyacOhbiBNb3Jlbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
