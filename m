Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E86C001E0
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 19:04:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 052EE6132B;
	Thu, 10 Aug 2023 19:04:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 052EE6132B
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z4SGxL4e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8iWskgme1656; Thu, 10 Aug 2023 19:04:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 79B5A6132F;
	Thu, 10 Aug 2023 19:04:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79B5A6132F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50506C0072;
	Thu, 10 Aug 2023 19:04:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB000C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5C8B6132F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:04:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C5C8B6132F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tsw8Egt5-zhe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:04:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AE3076132B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 19:04:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AE3076132B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691694275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f/d485k4GYGK+Hhxc7O7Vh9Y7TOuExVY3FHsGQcP80A=;
 b=Z4SGxL4eNgYfr79Rsx074Wd0vKYVE9MvpjASXpuVKdC28dlGQecfd5JVHw9+B0nr9x6iWu
 tLsJ722VHPCR8a9vKY8qs+6/hPu4JjN/vy98FwxPU/kDsWcuiwgFQsOFgsq35W3N/S+MSj
 ZD5cKTmiP5RlgGY6ATrbCM2aZKvD+XM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-lQUhFKSsNfuNphYOnB7rOw-1; Thu, 10 Aug 2023 15:04:34 -0400
X-MC-Unique: lQUhFKSsNfuNphYOnB7rOw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe4cca36b7so8056475e9.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691694272; x=1692299072;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/d485k4GYGK+Hhxc7O7Vh9Y7TOuExVY3FHsGQcP80A=;
 b=cAPhA+x9XdBcYbYgunULT/tQ5B36iTr7RiArBg4ygk3ErqMiw/EcqDEVIj7zFiRiNq
 cR0Kk/tA09D6nijxVWeQINt2xPCM+bNN4A6DAQuoqB818MX9l3fUVEu410tv4InjRvZ5
 dqVXwK6ycXTPyGxsy0as9hfRbhWPhq/ffcrmPMGzcOerwXdMgTz1a3NJQ5TkbHJ5va2Y
 1kIsHOtzahzJn7RFRv0l1ewhm1rcwxfiGMISHS0SK8cn9FSbGiM43mmntuLc/H0pymR2
 EvMvo/3BAb00GJx16lDgSuW4IOcKJpW4O89uTRIgLZPCPaKP0DOhrZDp2e1LlZElUqXU
 bCzA==
X-Gm-Message-State: AOJu0Yzslk0nxXF2wxJxGhx1Rbv5uQbwQLdJzfpfY6vWDxsb/Y8TB1NR
 yAIxFDko4EWiLYlusW9IBzkqokoI/4rPCXH4Sj0hCj9bL2xFiXMNXytZ5T4cP6Il7R3ZqLfHUmr
 MUIT2jC6inKR29B/R/gruL+7NNzHy0TUfELELRQhA2w==
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id
 v22-20020a1cf716000000b003fc009273d6mr2665602wmh.11.1691694272140; 
 Thu, 10 Aug 2023 12:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7XXbeFXHjJXPtbXknI7UArQUoxvGNLo3LCjH5yIBicBM7CJNAjsPriiFtN22BWjuicw51CA==
X-Received: by 2002:a1c:f716:0:b0:3fc:92:73d6 with SMTP id
 v22-20020a1cf716000000b003fc009273d6mr2665591wmh.11.1691694271848; 
 Thu, 10 Aug 2023 12:04:31 -0700 (PDT)
Received: from redhat.com ([2.55.27.97]) by smtp.gmail.com with ESMTPSA id
 p16-20020a05600c205000b003fe26bf65e7sm2928355wmg.13.2023.08.10.12.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 12:04:31 -0700 (PDT)
Date: Thu, 10 Aug 2023 15:04:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v3 0/3] vduse: add support for networking devices
Message-ID: <20230810150347-mutt-send-email-mst@kernel.org>
References: <20230705100430.61927-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230705100430.61927-1-maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Jul 05, 2023 at 12:04:27PM +0200, Maxime Coquelin wrote:
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support using split rings layout (merged in
> DPDK v23.07-rc1).
> 
> Control queue support (and so multiqueue) has also been
> tested, but requires a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably,
> so while Jason rework is done, a patch is added to disable
> CVQ and features that depend on it (tested also with DPDK
> v23.07-rc1).


So I can put this in next, the issue I think is
that of security: currently selinux can if necessary block
access to creating virtio block devices.
But if we have more than one type we need a way for selinux to
block specific types. Can be a patch on top but pls work to
address.

Another question is that with this userspace can inject
packets directly into net stack. Should we check CAP_NET_ADMIN
or such?



> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/
> 
> v2 -> v3 changes:
> =================
> - Use allow list instead of deny list (Michael)
> 
> v1 -> v2 changes:
> =================
> - Add a patch to disable CVQ (Michael)
> 
> RFC -> v1 changes:
> ==================
> - Fail device init if it does not support VERSION_1 (Jason)
> 
> Maxime Coquelin (3):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
>   vduse: Temporarily disable control queue features
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 51 +++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
