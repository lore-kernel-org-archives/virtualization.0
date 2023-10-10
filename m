Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A23CD68F1
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 06:32:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 612A960F8D;
	Tue, 10 Oct 2023 06:32:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 612A960F8D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vv1feeZI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9etC183GaOGZ; Tue, 10 Oct 2023 06:32:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E84FC60F1C;
	Tue, 10 Oct 2023 06:32:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E84FC60F1C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0931C0039;
	Tue, 10 Oct 2023 06:32:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D21BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B77D81FB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:32:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B77D81FB2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Vv1feeZI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 70p23EZ_1VfL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:32:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F21BC81FB1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:32:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F21BC81FB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696919552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9kT46zzJ4Pv/uNaGDbttTONHdzkYaHl6vJNLUy+dGg=;
 b=Vv1feeZInTNjYkNm2qvXRlCiseHQMwjKwEl3hpPgAOSUu4U95hq0p3AupPSp8v7qMDuN8y
 I6vannLTDwnUMAstrzu7X0aabRg1pjrILGcN4Fk820MyRXeGOJ3kCv2M6OqnHKFJvz5+5s
 qr9PlrbOtrdugnCeI0nNVkHFzvffVLU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-fpOQCE40NdG8qDYN4Xt1Ew-1; Tue, 10 Oct 2023 02:32:14 -0400
X-MC-Unique: fpOQCE40NdG8qDYN4Xt1Ew-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5056eada207so4899376e87.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 23:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696919533; x=1697524333;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K9kT46zzJ4Pv/uNaGDbttTONHdzkYaHl6vJNLUy+dGg=;
 b=R6yhc9ZMEq4iHhPEYxm3glxTbvo0ahDdEORGq38Gbcoa4+8vABRxXgjO4umUpeORtH
 /p1SpLXjPdHH/0qgPj+5OnqTKldI56VTJST8xlX+Pa+83l/rwwV94qjpME6/zqrCpAiu
 4DQAjiMPRklDdaqp27FNlwldtPjaUgqP5KUvSJXSTz/6SW7mKEDOzF/0FrOjijju2Q5z
 fbJtRe+p0lLQ3EOutshMdr3pug8YmaeJ6l6VpnnLpoxiQ6br+D75Y/FAXQJVUdxeBAa3
 fPXP/5Big2my4DoJcngZ9veSTDxsNcFOIWZXgD9OfvPwjTr0FBs/m6JLduwZKx03AnQP
 seNQ==
X-Gm-Message-State: AOJu0YyJYGGP9gEsD+gX1cd3YhI3US3SaFJUIZxqflXun8oP8cNB0A+T
 7x50pQOSYxGklo4nJsaF7Cb23VcPPUozDZOV7a6YaHi0MdXxjLrnL/WGgEfMLWJinUTzQc+8mT/
 SVJQ/cia7lAQfqXRbtg9lV62KBQNmQlPWgAL+MBZlWNjYFy9hIF+S64XERw==
X-Received: by 2002:a05:6512:2392:b0:4f9:54f0:b6db with SMTP id
 c18-20020a056512239200b004f954f0b6dbmr18049573lfv.13.1696919533205; 
 Mon, 09 Oct 2023 23:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMuNalqFHbo9fbkOLQicOz6Sn3F911SHVPCJzCScea/EKBEn2jF2zne4YSBmcfHq0eewz0GZHEAMKr2KCyjms=
X-Received: by 2002:a05:6512:2392:b0:4f9:54f0:b6db with SMTP id
 c18-20020a056512239200b004f954f0b6dbmr18049550lfv.13.1696919532918; Mon, 09
 Oct 2023 23:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231009112401.1060447-1-dtatulea@nvidia.com>
 <20231009112401.1060447-15-dtatulea@nvidia.com>
In-Reply-To: <20231009112401.1060447-15-dtatulea@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:32:02 +0800
Message-ID: <CACGkMEtmwW_GdHqY-9+pioOZU79nJHc_bWn-iStahDNg7r=06A@mail.gmail.com>
Subject: Re: [PATCH vhost v3 14/16] vdpa/mlx5: Enable hw support for vq
 descriptor mapping
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
QG52aWRpYS5jb20+IHdyb3RlOgo+Cj4gVnEgZGVzY3JpcHRvciBtYXBwaW5ncyBhcmUgc3VwcG9y
dGVkIGluIGhhcmR3YXJlIGJ5IGZpbGxpbmcgaW4gYW4KPiBhZGRpdGlvbmFsIG1rZXkgd2hpY2gg
Y29udGFpbnMgdGhlIGRlc2NyaXB0b3IgbWFwcGluZ3MgdG8gdGhlIGh3IHZxLgo+Cj4gQSBwcmV2
aW91cyBwYXRjaCBpbiB0aGlzIHNlcmllcyBhZGRlZCBzdXBwb3J0IGZvciBodyBta2V5IChtcikg
Y3JlYXRpb24KPiBmb3IgQVNJRCAxLgo+Cj4gVGhpcyBwYXRjaCBmaWxscyBpbiBib3RoIHRoZSB2
cSBkYXRhIGFuZCB2cSBkZXNjcmlwdG9yIG1rZXlzIGJhc2VkIG9uCj4gZ3JvdXAgQVNJRCBtYXBw
aW5nLgo+Cj4gVGhlIGZlYXR1cmUgaXMgc2lnbmFsZWQgdG8gdGhlIHZkcGEgY29yZSB0aHJvdWdo
IHRoZSBwcmVzZW5jZSBvZiB0aGUKPiAuZ2V0X3ZxX2Rlc2NfZ3JvdXAgb3AuCj4KPiBBY2tlZC1i
eTogRXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTog
RHJhZ29zIFRhdHVsZWEgPGR0YXR1bGVhQG52aWRpYS5jb20+CgpBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
