Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E51CC433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:10:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F1060FD7
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 08:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D1F1060FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A78FD403A3;
	Mon, 25 Oct 2021 08:10:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6Bz8Q9gaPqe; Mon, 25 Oct 2021 08:10:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 526B040317;
	Mon, 25 Oct 2021 08:10:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38676C0019;
	Mon, 25 Oct 2021 08:10:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91BD9C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8CEE9400DA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:10:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bsinbuzTigKT
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:10:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0654400C4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 08:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635149439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1wwkVww9E2LBE7RG0KzHsvesXXMQWsLToX9VH5gNciU=;
 b=e7a3w+Ym0feOcEoSsb3/6LMAydOU7u0YpdeKUCTZQL5Z3j0udlkygakBo7rPuEB8lRfNVN
 VAMFQCcwUwORj/cbSqpi//stq3QeFolYFGqDWlwkX3dpjGltW3qCaiOyhXyTwdqGdMt6Qi
 GvJzUUhV0c/JkYIyXUvFgh5iLDSBMTg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-tBc9H_tyOUq3QOSTBZPwHA-1; Mon, 25 Oct 2021 04:10:37 -0400
X-MC-Unique: tBc9H_tyOUq3QOSTBZPwHA-1
Received: by mail-ed1-f70.google.com with SMTP id
 f4-20020a50e084000000b003db585bc274so9056963edl.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=1wwkVww9E2LBE7RG0KzHsvesXXMQWsLToX9VH5gNciU=;
 b=4XLjkSmmVba3IiPVohmS30TIXg6FxRFMviX3ETEDwm/nAfA/A8d+BKmtf6XMlqVrbP
 YSMG0vROa9xy2ePynPaby7Pb9DSUZAo7scNhjLecFyoIOVVxc/qTFlCZdiwx/M2NzMyY
 xWY32Ov8AXMurVGmzxJOzshRtbz2Rp4C4cm/xKZcpyNIZYDYoAN4ItXkqaFNlt6LkumZ
 ErstG4PoYNoJYDc7kDnBIRSxVXOMQjcKecE0aHY7r8Y/9g5SeRy7VQHGAZM+l6lLHCmY
 /BrpXexIBYYvi0b5QWo6D1uIhENhKgFF5ZurQ9euvq6D9kbGx/UGhLQTYiVMlm2jmZPi
 EHUw==
X-Gm-Message-State: AOAM531/WPy6x1vZqly6ZbE6mbi5iDG3hN4ZMj4audmM9zSpRCgpd8nD
 NQbqFT8h6kvAlEH5uSm7Bsj+G//x3zGCOGLHTegAigIKFaqQfQ+oTXnTXpVm8wV5mPgmcSJMQUT
 GscU23JXg/W56pJCRNnv2fm2FA0o7kSmut2tYYd2VeA==
X-Received: by 2002:a17:906:9241:: with SMTP id
 c1mr21366174ejx.125.1635149436189; 
 Mon, 25 Oct 2021 01:10:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVe3WVm90XuaiUCC60E2ZpA4DTWjLIYjwiY3PJ+0raJVUnEQfIP+46tQkiQXbInriwJygGrw==
X-Received: by 2002:a17:906:9241:: with SMTP id
 c1mr21366161ejx.125.1635149436011; 
 Mon, 25 Oct 2021 01:10:36 -0700 (PDT)
Received: from redhat.com ([2.55.151.113])
 by smtp.gmail.com with ESMTPSA id h20sm190808ede.19.2021.10.25.01.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 01:10:35 -0700 (PDT)
Date: Mon, 25 Oct 2021 04:10:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v4 2/8] vdpa: Introduce query of device config
 layout
Message-ID: <20211025041006-mutt-send-email-mst@kernel.org>
References: <20211021163509.6978-1-parav@nvidia.com>
 <20211021163509.6978-3-parav@nvidia.com>
 <05bf6f39-66fc-cd9a-83d7-0836caf53239@redhat.com>
 <PH0PR12MB5481196C8E3509E55709C91FDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481196C8E3509E55709C91FDC839@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBPY3QgMjUsIDIwMjEgYXQgMDY6NTk6NTZBTSArMDAwMCwgUGFyYXYgUGFuZGl0IHdy
b3RlOgo+IAo+IAo+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+
IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAyNSwgMjAyMSAxMTozNiBBTQo+ID4gCj4gPiAKPiA+IOWc
qCAyMDIxLzEwLzIyIOS4iuWNiDEyOjM1LCBQYXJhdiBQYW5kaXQg5YaZ6YGTOgo+ID4gPiBJbnRy
b2R1Y2UgYSBjb21tYW5kIHRvIHF1ZXJ5IGEgZGV2aWNlIGNvbmZpZyBsYXlvdXQuCj4gPiA+Cj4g
PiA+IEFuIGV4YW1wbGUgcXVlcnkgb2YgbmV0d29yayB2ZHBhIGRldmljZToKPiA+ID4KPiA+ID4g
JCB2ZHBhIGRldiBhZGQgbmFtZSBiYXIgbWdtdGRldiB2ZHBhc2ltX25ldAo+ID4gPgo+ID4gPiAk
IHZkcGEgZGV2IGNvbmZpZyBzaG93Cj4gPiA+IGJhcjogbWFjIDAwOjM1OjA5OjE5OjQ4OjA1IGxp
bmsgdXAgbGlua19hbm5vdW5jZSBmYWxzZSBtdHUgMTUwMAo+ID4gCj4gPiAKPiA+IE5pdDogaXQg
bG9va3MgdG8gbWUgdGhpcyBwYXRjaCBkb2Vzbid0IGV4cG9zZSBsaW5rX2Fubm91bmNlIGJ1dAo+
ID4gbWF4X3ZpcnRxdWV1ZV9wYWlycy4KPiBJdCBkb2VzIGV4cG9zZSB0aGUgbmV0IHN0YXR1cyBm
aWVsZCB0aGF0IGNvbnRhaW5zIHRoZSBsaW5rX2Fubm91bmNlLgo+IEkgbWlzc2VkIHRvIHVwZGF0
ZSB0aGUgZXhhbXBsZSBmb3IgaW5jbHVkaW5nIG1heF92cV9wYWlycy4KPiA+IAo+ID4gT3RoZXIg
bG9va3MgZ29vZC4KPiA+IAo+ID4gVGhhbmtzCgpQb3N0IGEgY29ycmVjdGVkIGNvbW1pdCBsb2c/
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
