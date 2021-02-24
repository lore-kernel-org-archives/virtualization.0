Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F3C433E0
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:43:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1DE60233
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 08:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1DE60233
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 344236F5E4;
	Wed, 24 Feb 2021 08:43:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jKLtRssVOh9V; Wed, 24 Feb 2021 08:43:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7275606E2;
	Wed, 24 Feb 2021 08:43:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AB82C000A;
	Wed, 24 Feb 2021 08:43:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5EF7C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:43:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CC4804EBE9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:43:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aOAQeufX_SGH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:43:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 021A14EBCD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 08:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614156199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NVOivrQkbhUYYYcVGD6e4aORmI1x2sDphQp+U9sGHXA=;
 b=F9+tRs+DVtxq94MecSunsk7kXVDBdIC7nGvfShJtoED/2bkFkAn/rxVB/Uh9JuoTSVydmo
 hbQnpn7536gQa5YpO7coRqdrgCGTihFtki26NGAS2Jdjc+W/aQ+SKeHvNihFNumOxiEUAW
 ipVwRdPKe/Vi7lxFPrTDubRLM1bC4Hk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-TYJipcvVPSWyEkIdnqyhug-1; Wed, 24 Feb 2021 03:43:18 -0500
X-MC-Unique: TYJipcvVPSWyEkIdnqyhug-1
Received: by mail-wr1-f70.google.com with SMTP id d7so714273wri.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 00:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NVOivrQkbhUYYYcVGD6e4aORmI1x2sDphQp+U9sGHXA=;
 b=AzjpMGnXjjcj7z+Ugi4YLKo8jxbSDiYGx0HEq6ZZWng7M/F3V2jgde5ZEsTVjG8KP8
 kEoXxtlnEvHoU8OyQ4yRsZENqbew9y6J2KY6heDLZTKbQ8TmetiIK1d1uyfGcPtzeF6p
 /zNbURovRZWaM+UHM70LkdKSsmJYFOEn165bSwTQs4jNXzdIMMELhM0LEcRd3UoPT2wj
 0c91Jm48pQcoX5WZJ3PZWr0sDC9S4nHrn30Mt+iAptR6lx4HuvvIEjhbA2OMNd74G9u4
 S9XE7HYNs5treMsnCb0fjkziJ/lxfU5zUyILOk3veRS77DzNcyZ2iClqmHOVGwzyKh8y
 vXLg==
X-Gm-Message-State: AOAM530casG0A4aWSK64Go42VcCLiuazByFaXiqCpFNaZtSHPbfzDMpA
 sKAs0/xBtr+HauIzOI+O8/8YjllMDToNxXMnH57JyxgmmlYCLQGAFAgRMjPzJ9S1sR9Jgall+D/
 KWlRa0QJ8BzVfTsMLIM9+okRwrWvREaujUkqdxnOYCQ==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr2668463wmh.111.1614156196958; 
 Wed, 24 Feb 2021 00:43:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRkCwcT9hRuAmpCp7SDuEw17ulTeSXlbxTyKBOWvlFkXiNm9VLPs2WH/dTrgyX5sOSIXsenA==
X-Received: by 2002:a7b:cc0c:: with SMTP id f12mr2668455wmh.111.1614156196796; 
 Wed, 24 Feb 2021 00:43:16 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id q20sm1614382wmc.14.2021.02.24.00.43.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Feb 2021 00:43:16 -0800 (PST)
Date: Wed, 24 Feb 2021 03:43:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210224034240-mutt-send-email-mst@kernel.org>
References: <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <0559fd8c-ff44-cb7a-8a74-71976dd2ee33@redhat.com>
 <20210224014232-mutt-send-email-mst@kernel.org>
 <ce6b0380-bc4c-bcb8-db82-2605e819702c@redhat.com>
 <20210224021222-mutt-send-email-mst@kernel.org>
 <babc654d-8dcd-d8a2-c3b6-d20cc4fc554c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <babc654d-8dcd-d8a2-c3b6-d20cc4fc554c@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, elic@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Wed, Feb 24, 2021 at 04:26:43PM +0800, Jason Wang wrote:
>     Basically on first guest access QEMU would tell kernel whether
>     guest is using the legacy or the modern interface.
>     E.g. virtio_pci_config_read/virtio_pci_config_write will call ioctl(ENABLE_LEGACY, 1)
>     while virtio_pci_common_read will call ioctl(ENABLE_LEGACY, 0)
> 
> 
> But this trick work only for PCI I think?
> 
> Thanks

ccw has a revision it can check. mmio does not have transitional devices
at all.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
