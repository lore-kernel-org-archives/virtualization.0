Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AC2E95A8F
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 04:28:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D4FD82204;
	Sun,  8 Oct 2023 04:28:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D4FD82204
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BLKgnDB/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F3e05dBA8Jjw; Sun,  8 Oct 2023 04:28:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BB6DF821E1;
	Sun,  8 Oct 2023 04:28:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB6DF821E1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97675C0071;
	Sun,  8 Oct 2023 04:28:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B3E1C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:28:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DA2A160BDC
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:28:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DA2A160BDC
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BLKgnDB/
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MTW2kG71eZ09
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:28:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0E4EA60B68
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 04:28:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0E4EA60B68
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696739317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vxT8bBpg2V2sCWkrIObviz4MEWDATPF4LhOqMoHGX6U=;
 b=BLKgnDB/5vypUc77E/RQRt7yMPU5hHgNfEaNAeZSqgllQ7EKgLmtbFdj68GDa6w7oIp6DD
 HZxDjAdY8FLN/jbR6k+GRAF/sSLsAiYFBjLbJ9OiI5e26O26XlVXvSG6CsoHB7ZBcDyEFg
 q/vHEjLSSqQ+VpAVJZOFrrd2jqCjYhY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-11x55jycMXGb80ybeutN5w-1; Sun, 08 Oct 2023 00:28:35 -0400
X-MC-Unique: 11x55jycMXGb80ybeutN5w-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5047e8f812bso3322236e87.3
 for <virtualization@lists.linux-foundation.org>;
 Sat, 07 Oct 2023 21:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696739313; x=1697344113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vxT8bBpg2V2sCWkrIObviz4MEWDATPF4LhOqMoHGX6U=;
 b=hcAFCiwDw4HzedCXZ+wCOjG+kbM9/VCzJ0ki0TwlmmvDsVzbGPb5LlwNFjxRcaNTXP
 5QdBFwhodE9rKT1OrKmnwRhnkyH2ft1Zv2TowZhgkkg9jc4amI+RzA88PqhKRfWUdTYc
 hGpNmME7kfvUbFkoHP19KNAMVceBGFIgw7fExCvE+/mOPSkqqc909nvbhnvZj5SPEuga
 KLelaeRQHyEqb1kHZ6hdcVL7a+ga1P3380zORYb4z0WqTQpJnHgF8pM3lCagGLGfXf1L
 Bofg/ETVb8XE5alASY+iIwAKWfpHDPcyjohmZ8rrB3LgUKUpLIZLrcRhQPzyPeTAT/iT
 gfng==
X-Gm-Message-State: AOJu0Yx3GBmox+xY+Lc1WMWZa8w/AeAY5l4WAojysb1tPxx4VT1PzKol
 2TEMB+UrJa2rJ2d/D67RIfA+GxhONoK9KGZFhs/SxovngrYlkRQUeYjOgRnG40YaCxR51kjhw8X
 ls+Q8ieaz56mH5Q2dJXe0tGnW2Lt9sa+5yzYnUOE+2uClMUxU2CFx4MTBCw==
X-Received: by 2002:a05:6512:3c9c:b0:503:99d:5a97 with SMTP id
 h28-20020a0565123c9c00b00503099d5a97mr12369556lfv.20.1696739313659; 
 Sat, 07 Oct 2023 21:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoEe5Q/MlUvUVOzxqVsG9NUenNLyabZh1JOdQa1QFbx1vsgKHGV/b4ObGp9egUs1P1EC63rh8s6MrImoMupDQ=
X-Received: by 2002:a05:6512:3c9c:b0:503:99d:5a97 with SMTP id
 h28-20020a0565123c9c00b00503099d5a97mr12369541lfv.20.1696739313349; Sat, 07
 Oct 2023 21:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
 <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEv9_+6sYp1JZpCZr19csg0jO-jLVhuygWqm+s9mWr3Lew@mail.gmail.com>
 <20230926074520-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230926074520-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 8 Oct 2023 12:28:21 +0800
Message-ID: <CACGkMEtq_2xyRuOcgaVp11jxwCX_vfKxncCcke6_Z2nLKgpKww@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

T24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgNzo0OeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMTA6MzI6MzlB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IEl0J3MgdGhlIGltcGxlbWVudGF0aW9uIGRl
dGFpbHMgaW4gbGVnYWN5LiBUaGUgZGV2aWNlIG5lZWRzIHRvIG1ha2UKPiA+IHN1cmUgKHJlc2V0
KSB0aGUgZHJpdmVyIGNhbiB3b3JrIChpcyBkb25lIGJlZm9yZSBnZXRfc3RhdHVzIHJldHVybiku
Cj4KPiBJIHRoaW5rIHRoYXQgdGhlcmUncyBubyB3YXkgdG8gbWFrZSBpdCByZWxpYWJseSB3b3Jr
IGZvciBhbGwgbGVnYWN5IGRyaXZlcnMuCgpZZXMsIHdlIG1heSBoYXZlIGFuY2llbnQgZHJpdmVy
cy4KCj4KPiBUaGV5IGp1c3QgYXNzdW1lZCBhIHNvZnR3YXJlIGJhY2tlbmQgYW5kIGRpZCBub3Qg
Ym90aGVyIHdpdGggRE1BCj4gb3JkZXJpbmcuIFlvdSBjYW4gdHJ5IHRvIGF2b2lkIHJlc2V0cywg
dGhleSBhcmUgbm90IHRoYXQgY29tbW9uIHNvCj4gdGhpbmdzIHdpbGwgdGVuZCB0byBtb3N0bHkg
d29yayBpZiB5b3UgZG9uJ3Qgc3RyZXNzIHRoZW0gdG8gbXVjaCB3aXRoCj4gdGhpbmdzIGxpa2Ug
aG90IHBsdWcvdW5wbHVnIGluIGEgbG9vcC4gIE9yIHlvdSBjYW4gdHJ5IHRvIHVzZSBhIGRyaXZl
cgo+IGFmdGVyIDIwMTEgd2hpY2ggaXMgbW9yZSBhd2FyZSBvZiBoYXJkd2FyZSBvcmRlcmluZyBh
bmQgZmx1c2hlcyB0aGUKPiByZXNldCB3cml0ZSB3aXRoIGEgcmVhZC4gIE9uZSBvZiB0aGVzZSB0
d28gdHJpY2tzLCBJIHRoaW5rLCBpcyB0aGUgbWFnaWMKPiBiZWhpbmQgdGhlIGRldmljZSBleHBv
c2luZyBtZW1vcnkgYmFyIDAgdGhhdCB5b3UgbWVudGlvbi4KClJpZ2h0IHRoaXMgaXMgd2hhdCBJ
IHNlZSBmb3IgaGFyZHdhcmUgbGVnYWN5IGRldmljZXMgc2hpcHBlZCBieSBzb21lCmNsb3VkIHZl
bmRvcnMuCgpUaGFua3MKCj4KPiAtLQo+IE1TVAo+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
