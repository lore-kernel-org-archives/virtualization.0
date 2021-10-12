Return-Path: <SRS0=TY3O=PA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6C4C433F5
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 11:16:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92DB56101D
	for <virtualization@archiver.kernel.org>; Tue, 12 Oct 2021 11:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92DB56101D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5107540393;
	Tue, 12 Oct 2021 11:16:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CzEV2SRs5i79; Tue, 12 Oct 2021 11:16:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B879840389;
	Tue, 12 Oct 2021 11:16:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 937FCC0011;
	Tue, 12 Oct 2021 11:16:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C488EC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 11:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B2C9540640
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 11:16:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IOCtuYOt9CS8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 11:16:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C600340625
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634037391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AMHiyzyJjXVhzhg0cTh0LW9oKsDVObYUCPUOFXh30gg=;
 b=MbbkGVTpk7v3cr8iSAV0xF6tqpphMdNw4kpVLzj9OLBZX37QgcLdf9zLJClJVv4Ou+y7yY
 bRd2bQ6uDDA5U1IAEoTZqkyvAdT6O/Rew4UaOfpnTjsGN4HtzVLT1lVUGyCy2Sk20vIePN
 fO5SJeMKlr+0cOmeNDG12zPDc7Yari8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-a0hej345M9C5dhEHJEKivQ-1; Tue, 12 Oct 2021 07:16:12 -0400
X-MC-Unique: a0hej345M9C5dhEHJEKivQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 g28-20020a50d0dc000000b003dae69dfe3aso18569419edf.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Oct 2021 04:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AMHiyzyJjXVhzhg0cTh0LW9oKsDVObYUCPUOFXh30gg=;
 b=tcyHtlz+jhgQi/mcOcNhThrg3wjqZtGpStdw9oHpjxHtcQF6uL9Mjv5eghFJ7xyEan
 4FrB1zptR3B3AC73hKNdvrIJrSMV+Ke1LGboAnNpemiOS1QbiwKzE/5yqezDlkw6uAnn
 TJy0MsPKbX3j2DY2iQpJAx7gvlr5pr1N1ep/NpOPkbXDLCm2olX0SK2+dxmYKRJ8ZQ7+
 axapS8V/6tVl0RniJ7KUr5QwyBHSYMkfEb3Q/9aA4B/8Swy6AGnc7XzMOg+3b+SWXP4q
 KGqYU1NwuL8VZ3dXLy0bupV1BRVbqFvzMPHqXpFGAOO4BsfxVC6SuatUunc4GYiv0MY6
 CXcA==
X-Gm-Message-State: AOAM5332e2ZHrDFjVsYOTtR0bK8kdN0YMYmjzKURNyQEJfFk0n72PdUI
 XEQcY54qIqFYBETI2K/0Yt+678lQcIYkCzAHh5JjZjEKzuRJmOXIb4sGCHQ5aqMM6MdQYIJfHgr
 6TYl4bLfe/zI2k0Tfly07E+UpL+qW9arF8CeyD2dmsw==
X-Received: by 2002:a50:fe03:: with SMTP id f3mr9292189edt.136.1634037371073; 
 Tue, 12 Oct 2021 04:16:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd/URL5pw6izXClolZNFJ+6uNDxVtrZRO7cbO0TSudUpwyflf8/yGeb3BNrZM4At2dztwdvw==
X-Received: by 2002:a50:fe03:: with SMTP id f3mr9292158edt.136.1634037370890; 
 Tue, 12 Oct 2021 04:16:10 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
 by smtp.gmail.com with ESMTPSA id o12sm5673421edw.84.2021.10.12.04.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Oct 2021 04:16:10 -0700 (PDT)
Date: Tue, 12 Oct 2021 07:16:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH mlx5-next 0/7] Clean MR key use across mlx5_* modules
Message-ID: <20211012071555-mutt-send-email-mst@kernel.org>
References: <cover.1634033956.git.leonro@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <cover.1634033956.git.leonro@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
 Maor Gottlieb <maorg@nvidia.com>, virtualization@lists.linux-foundation.org,
 Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

On Tue, Oct 12, 2021 at 01:26:28PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> This is cleanup series of mlx5_* MR mkey management.
> 
> Thanks


Looks fine superficially

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Aharon Landau (7):
>   RDMA/mlx5: Don't set esc_size in user mr
>   RDMA/mlx5: Remove iova from struct mlx5_core_mkey
>   RDMA/mlx5: Remove size from struct mlx5_core_mkey
>   RDMA/mlx5: Remove pd from struct mlx5_core_mkey
>   RDMA/mlx5: Replace struct mlx5_core_mkey by u32 key
>   RDMA/mlx5: Move struct mlx5_core_mkey to mlx5_ib
>   RDMA/mlx5: Attach ndescs to mlx5_ib_mkey
> 
>  drivers/infiniband/hw/mlx5/devx.c             | 13 +--
>  drivers/infiniband/hw/mlx5/devx.h             |  2 +-
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          | 31 ++++---
>  drivers/infiniband/hw/mlx5/mr.c               | 82 +++++++++----------
>  drivers/infiniband/hw/mlx5/odp.c              | 38 +++------
>  drivers/infiniband/hw/mlx5/wr.c               | 10 +--
>  .../mellanox/mlx5/core/diag/fw_tracer.c       |  6 +-
>  .../mellanox/mlx5/core/diag/fw_tracer.h       |  2 +-
>  .../mellanox/mlx5/core/diag/rsc_dump.c        | 10 +--
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/en/trap.c |  2 +-
>  .../ethernet/mellanox/mlx5/core/en_common.c   |  6 +-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 13 ++-
>  .../ethernet/mellanox/mlx5/core/fpga/conn.c   | 10 +--
>  .../ethernet/mellanox/mlx5/core/fpga/core.h   |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/mr.c  | 27 +++---
>  .../mellanox/mlx5/core/steering/dr_icm_pool.c | 10 +--
>  .../mellanox/mlx5/core/steering/dr_send.c     | 11 ++-
>  .../mellanox/mlx5/core/steering/dr_types.h    |  2 +-
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h            |  8 +-
>  drivers/vdpa/mlx5/core/mr.c                   |  8 +-
>  drivers/vdpa/mlx5/core/resources.c            | 13 +--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c             |  2 +-
>  include/linux/mlx5/driver.h                   | 30 ++-----
>  25 files changed, 147 insertions(+), 195 deletions(-)
> 
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
