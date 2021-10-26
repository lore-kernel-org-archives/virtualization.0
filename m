Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F62C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 13:12:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255C8603E8
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 13:12:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 255C8603E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD31A40227;
	Tue, 26 Oct 2021 13:12:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J3nxwbcFPXnl; Tue, 26 Oct 2021 13:12:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 950954018F;
	Tue, 26 Oct 2021 13:12:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70C08C0019;
	Tue, 26 Oct 2021 13:12:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B59AC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8A79F60904
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VvyAZqV7z8Cw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:12:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3DE8C60871
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635253935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JfF5QnSoepJtVIYWrNgqTRcx2eo41RotT8ZEOsTG7jA=;
 b=QH3L32KXF4AW89jZjs2zeOcEfbbCpSozEN9sHJo0BK+bHlQCSLyVMVKzRAJ4KQnjJECmPs
 AzmRwAD2M7RBN4nZgAP94Un34et7yM6Ykkdn+bbSVotEMJ6T56wtf9xp03YaHUBOkCngKN
 NVuuOsTyaJrUlJxSpWEhIP1n9d32JMU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482--p4LFYgtNg2-DHsue_L08Q-1; Tue, 26 Oct 2021 09:12:13 -0400
X-MC-Unique: -p4LFYgtNg2-DHsue_L08Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 k28-20020a508adc000000b003dd5e21da4bso5373016edk.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 06:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=JfF5QnSoepJtVIYWrNgqTRcx2eo41RotT8ZEOsTG7jA=;
 b=k037cNyEcu8C9RxDNI0ufdS6hbo4Mbj3RX7SDiegOwqaYuqTgkgrWsW1rvd1exJdRw
 7icfk7ZwNlJ2Gtz46WQTs6JNM9n+MFinIFWGudBKCR0LlyjK7l0JrtJGX1BL97jyH/ku
 ThQHWXHLP9puIQvCAotScCP5IfBjD0zoRAtsqSHZ5bSblnRyP5Yd553Z4zpUTCD2lBpO
 ULV9JeQHzJp1EEHB7wisUy+ITVY9Ed9Cicz1fveavvzpdalrUVUt6DJXXED8zh1jr6ny
 c4lbIowl6iapa3WNFCtSyR0UHuMO8RAwQbpI9YP8JjAoBN3zUnJAUChxD0QAmP2IjZxN
 l2Cw==
X-Gm-Message-State: AOAM532Hjbr1tBub6MtSs2qIWl+YpPfUIdSJl36on6gyrfxoVA76QPzl
 nZuqa7GCbT1EfMTLwtC8f8+m3WZdkHhRn0yOrPZEfiOAz51eu2HVC7TybsQjCsTNjRPDjS+d0fr
 7T5HfzXJSN6bgF/iN9pyJFTvD6mCwKbKb8akB9OM7cQ==
X-Received: by 2002:a17:907:868b:: with SMTP id
 qa11mr3554136ejc.383.1635253932761; 
 Tue, 26 Oct 2021 06:12:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZuGokdqpZTs4aZU64EE4E6S4G3p9GdAaQT8SkJizqlPaWz+kkDdlEzh2g3feYBeW+vb/9gQ==
X-Received: by 2002:a17:907:868b:: with SMTP id
 qa11mr3554115ejc.383.1635253932591; 
 Tue, 26 Oct 2021 06:12:12 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id f9sm5489491edt.7.2021.10.26.06.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Oct 2021 06:12:12 -0700 (PDT)
Date: Tue, 26 Oct 2021 15:12:10 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v6 5/8] vdpa_sim_net: Enable user to set mac
 address and mtu
Message-ID: <20211026131210.66k5dpbxge3vmqt6@steredhat>
References: <20211026040243.79005-1-parav@nvidia.com>
 <20211026040243.79005-6-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211026040243.79005-6-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, mst@redhat.com, virtualization@lists.linux-foundation.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Oct 26, 2021 at 07:02:40AM +0300, Parav Pandit via Virtualization wrote:
>Enable user to set the mac address and mtu so that each vdpa device
>can have its own user specified mac address and mtu.
>
>Now that user is enabled to set the mac address, remove the module
>parameter for same.
>
>And example of setting mac addr and mtu and view the configuration:
>$ vdpa mgmtdev show
>vdpasim_net:
>  supported_classes net
>
>$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
>
>$ vdpa dev config show
>bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>
>Reviewed-by: Eli Cohen <elic@nvidia.com>
>---
>changelog:
>v4->v5:
> - updated commit log example for add command
>---
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 35 +++++++++++++++-------------
> 1 file changed, 19 insertions(+), 16 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
