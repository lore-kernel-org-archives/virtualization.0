Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80633CD68ED
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 06:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0541660EA6;
	Tue, 10 Oct 2023 06:24:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0541660EA6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gM0oGBEM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ISOEh0JVkU6l; Tue, 10 Oct 2023 06:24:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 645F160E37;
	Tue, 10 Oct 2023 06:24:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 645F160E37
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34F93C0039;
	Tue, 10 Oct 2023 06:24:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5DD2C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B08A4416C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:24:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B08A4416C5
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gM0oGBEM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eZWWST_OCvHS
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:24:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3D059410D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:24:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D059410D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696919083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1AqkLrzrIXxwvm4PGZ1aUIreaVgNNNZ9t0/4h1i7AZY=;
 b=gM0oGBEMp6KHPvdPCJXzv5D+MxnLVg2GK8J0TKPMjLg+CskOYpO5LEt+GY8WtiXyPTnZws
 Qp/Xg16TxzwVHmjeBrHa5sL8jWGf0YJ9s7/QcFp7NtFGN36ZuNOiY/I3j9RmGzKb5lKWN9
 x18baZrkt4yTrlWM7JXpNPqUFYfADGQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-zSi-uZkzMLmOKQmE4t7kGw-1; Tue, 10 Oct 2023 02:24:41 -0400
X-MC-Unique: zSi-uZkzMLmOKQmE4t7kGw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5068bf0b443so2966538e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 23:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696919080; x=1697523880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1AqkLrzrIXxwvm4PGZ1aUIreaVgNNNZ9t0/4h1i7AZY=;
 b=ZfW5PL8oCBiEbuBy1fMawHEAottdnpyALw2ddxhwN2HSlkZRGHOtm60zlq9vf9WAYA
 BZYV2W3zwVB7q7e32/2VYBCm1VCjQbB15NuF3k1GkmUxwFCuGGKOw+UUQ7D4f95+o+QJ
 u/1SHuFI18fAMleKJVnF4sXsLXHIOFsvAICjNJtUMD/toNLiBJnOYuiqbkoJSzer8YRA
 r6jIUOpO4m9xpUGMQhHwHzwFc4q15yqpweCqCm0LgVM5G0ZmBDYigipRSTs9h6hBMC+g
 E9JXibaLdOlTzrXZK3fpKqllgUMV+rrVIOt47DoWuVVFd+WFHpWdfwt2c0VUaZXihzS0
 o0gQ==
X-Gm-Message-State: AOJu0Yx++hjtYWEpKw80aS9T7nYzrsDEFa5lrBa5ewCYmR7c+8qqDXvw
 UlmF+UtecZLqZg+98AxzvByiewH3oSJTbvNUEL2CXMpRwQIvkSDnQ0XuD7Rr/AmuUhhp0inYl8C
 Lwlfcb0P8hJ+JwSslZGTjtkJEQEbWKXWwEmyjb8rSV+tsuCP/vhZ5Pph50w==
X-Received: by 2002:a19:f015:0:b0:500:d970:6541 with SMTP id
 p21-20020a19f015000000b00500d9706541mr13782366lfc.39.1696919079957; 
 Mon, 09 Oct 2023 23:24:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7xUE6pgdBc/7IGhtXyNcrZjmsd0aJhTSJHQ75/95fWLdH7kgG7RJO/mGmbpq6jQLfRM7uFrYPEqqarKGGcNc=
X-Received: by 2002:a19:f015:0:b0:500:d970:6541 with SMTP id
 p21-20020a19f015000000b00500d9706541mr13782360lfc.39.1696919079631; Mon, 09
 Oct 2023 23:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
 <20231009112401.1060447-11-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-11-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:24:28 +0800
Message-ID: <CACGkMEuMnx0s6t-8FhT67Bd3-RYnZkFWUE+SfY2VByy0GbynAA@mail.gmail.com>
Subject: Re: [PATCH vhost v3 10/16] vdpa/mlx5: Allow creation/deletion of any
 given mr struct
To: Dragos Tatulea <dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eugenio Perez Martin <eperezma@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>
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

T24gTW9uLCBPY3QgOSwgMjAyMyBhdCA3OjI14oCvUE0gRHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVh
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBhZGFwdHMgdGhlIG1yIGNyZWF0aW9u
L2RlbGV0aW9uIGNvZGUgdG8gYmUgYWJsZSB0byB3b3JrIHdpdGgKPiBhbnkgZ2l2ZW4gbXIgc3Ry
dWN0IHBvaW50ZXIuIEFsbCB0aGUgQVBJcyBhcmUgYWRhcHRlZCB0byB0YWtlIGFuIGV4dHJhCj4g
cGFyYW1ldGVyIGZvciB0aGUgbXIuCj4KPiBtbHg1X3ZkcGFfY3JlYXRlL2RlbGV0ZV9tciBkb2Vz
bid0IG5lZWQgYSBBU0lEIHBhcmFtZXRlciBhbnltb3JlLiBUaGUKPiBjaGVjayBpcyBkb25lIGlu
IHRoZSBjYWxsZXIgaW5zdGVhZCAobWx4NV9zZXRfbWFwKS4KPgo+IFRoaXMgY2hhbmdlIGlzIG5l
ZWRlZCBmb3IgYSBmb2xsb3d1cCBwYXRjaCB3aGljaCB3aWxsIGludHJvZHVjZSBhbgo+IGFkZGl0
aW9uYWwgbXIgZm9yIHRoZSB2cSBkZXNjcmlwdG9yIGRhdGEuCj4KPiBTaWduZWQtb2ZmLWJ5OiBE
cmFnb3MgVGF0dWxlYSA8ZHRhdHVsZWFAbnZpZGlhLmNvbT4KPiBBY2tlZC1ieTogRXVnZW5pbyBQ
w6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
