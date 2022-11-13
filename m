Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C09C433FE
	for <virtualization@archiver.kernel.org>; Sun, 13 Nov 2022 13:51:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 64D564088E;
	Sun, 13 Nov 2022 13:51:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64D564088E
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=P5vuobHB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8vRlYYOEwOO1; Sun, 13 Nov 2022 13:51:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB9DE40879;
	Sun, 13 Nov 2022 13:51:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AB9DE40879
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76FD0C0033;
	Sun, 13 Nov 2022 13:51:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA2E4C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 13:51:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF1AF81449
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 13:51:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AF1AF81449
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=P5vuobHB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id thwFs3-tFYlc
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 13:51:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 866D581448
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 866D581448
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 13:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668347496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K2EsNeyXyYyKVLHR+aWkmyeBAXArz2HHJA7VFNui1Vw=;
 b=P5vuobHB2EfVb6VIpNZAklESOTg5fhiBVCJBV7Ij9PskYqjhP2FtBGUoRceNtiQXoLgk5Y
 r/Shg0cg4ob/xV6xYNyC5UT1oShFl2oxGwl3Lydak5jZ+pVC1PZc60XqRgcoY3FgkwyxFW
 yQAe5gdLSq/FuPqbAUKHdZXPf255EOw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-DyjF7fr-OhenYIJYpMiiXw-1; Sun, 13 Nov 2022 08:51:35 -0500
X-MC-Unique: DyjF7fr-OhenYIJYpMiiXw-1
Received: by mail-wr1-f71.google.com with SMTP id
 k1-20020adfb341000000b00238745c9b1aso1512264wrd.5
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 05:51:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K2EsNeyXyYyKVLHR+aWkmyeBAXArz2HHJA7VFNui1Vw=;
 b=0HKYv8/Lc0wS3bU3v2pS6ILgW7qPVfp80uHH6vK2bH5QTLIjVzq1vwvaHB/ewbvCMc
 ACAT7QEacfzgOYvOcGO0l2z6UYGKnw0lDe3FB+IRGLqNUYxz3tM34Fq4KCVdbQe2OG3x
 7VW76HmJZkZe0DJJiczCEM3wOwMFkRjTnCunYoiAimBnYn+UFQF2N8vZUad53ihVi4V6
 2uaPAgeYcumo3AyPmWKYU4yHe46wNkGO6fGGp0ND5FDNindYYYdqgAwtKIQ9h97BnCD7
 6y+3XOLtqb0fr7jyZDutDvrRbFxTNuuTkkdg8uFl1Yc0wtTMaq4eAuF+wy0gAjDvb8II
 XMPQ==
X-Gm-Message-State: ANoB5pk/2eN85NWBP5JTYa30rf6Jel0YjIKTRu9sF2gJYQ//4Stu2odj
 9YfBTEGHr7pwSm4BqJO50F3qdriYhIHbFfScWD5sMQ9uujZHnIN5ZAMis1p34eS7TC15Tg+WDTR
 yKsxmZW06aADHvLMc5+BudFPTGd/WJ+QL51k/lHYPUQ==
X-Received: by 2002:adf:f502:0:b0:238:c1d5:3293 with SMTP id
 q2-20020adff502000000b00238c1d53293mr5206676wro.446.1668347493938; 
 Sun, 13 Nov 2022 05:51:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4wod2BYxiettS1eLmQzICjf4VHtw9Y5QjE6qq4HdDPw+URGaNVqNF3AD3g0sPJxpVkObInww==
X-Received: by 2002:adf:f502:0:b0:238:c1d5:3293 with SMTP id
 q2-20020adff502000000b00238c1d53293mr5206663wro.446.1668347493650; 
 Sun, 13 Nov 2022 05:51:33 -0800 (PST)
Received: from redhat.com ([2.52.4.127]) by smtp.gmail.com with ESMTPSA id
 m66-20020a1c2645000000b003cfd58409desm5641085wmm.13.2022.11.13.05.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Nov 2022 05:51:33 -0800 (PST)
Date: Sun, 13 Nov 2022 08:51:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 0/7] vdpa/mlx5: Add debugfs subtree and fixes
Message-ID: <20221113085044-mutt-send-email-mst@kernel.org>
References: <20221113134442.152695-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20221113134442.152695-1-elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lulu@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com
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

On Sun, Nov 13, 2022 at 03:44:35PM +0200, Eli Cohen wrote:
> This series is a resend of previously sent patch list. It adds a few
> fixes so I treat as a v0 of a new series.
> 
> It adds a kernel config param CONFIG_MLX5_VDPA_STEERING_DEBUG that when
> eabled allows to read rx unicast and multicast counters per tagged or untagged traffic.
> 
> Examples:
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/mcast/packets
> $ cat /sys/kernel/debug/mlx5/mlx5_core.sf.1/vdpa-0/rx/untagged/ucast/bytes


Thanks!
Is this patchset intended for 6.2 then?

> 
> Eli Cohen (7):
>   vdpa/mlx5: Fix rule forwarding VLAN to TIR
>   vdpa/mlx5: Fix wrong mac address deletion
>   vdpa/mlx5: Move some definitions to a new header file
>   vdpa/mlx5: Add debugfs subtree
>   vdpa/mlx5: Add RX counters to debugfs
>   vdpa/mlx5: Avoid using reslock in event_handler
>   vdpa/mlx5: Avoid overwriting CVQ iotlb
> 
>  drivers/vdpa/Kconfig               |  12 ++
>  drivers/vdpa/mlx5/Makefile         |   2 +-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |   5 +-
>  drivers/vdpa/mlx5/core/mr.c        |  44 ++---
>  drivers/vdpa/mlx5/net/debug.c      | 152 ++++++++++++++++++
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 248 ++++++++++++++---------------
>  drivers/vdpa/mlx5/net/mlx5_vnet.h  |  94 +++++++++++
>  7 files changed, 411 insertions(+), 146 deletions(-)
>  create mode 100644 drivers/vdpa/mlx5/net/debug.c
>  create mode 100644 drivers/vdpa/mlx5/net/mlx5_vnet.h
> 
> -- 
> 2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
