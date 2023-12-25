Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7995741C6A
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 14:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYz1nR65"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 18BC481464
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 14:41:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 18BC481464
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eYz1nR65
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P1b9BKW6vkrC
	for <virtualization@lists.linux-foundation.org>;
	Mon, 25 Dec 2023 14:41:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21A36813BC
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 14:41:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21A36813BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703515266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jCpX86PoGZe+01z8F2Jmte5yGSzORMYuWo+w6Pq78Nw=;
	b=eYz1nR65iP7gufZz8GEI/g47jXKi7KPpvjXYHwO7teNOe5Rt59XbKMMw8HZm/IcDNyFKLU
	3/xQ7UEGYOAJ10gqvfcUXnlU8xO8W+jO6Cw7fkhrQKZtXsjwp8pq84FWSzAPDqTmc/G6OU
	7mK8oZW35exZV2T9i5zfYHh5uUynNmc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-AQwN34jGPWGVefYHXi_Ohg-1; Mon, 25 Dec 2023 09:41:05 -0500
X-MC-Unique: AQwN34jGPWGVefYHXi_Ohg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33688aa4316so2351647f8f.2
        for <virtualization@lists.linux-foundation.org>; Mon, 25 Dec 2023 06:41:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703515264; x=1704120064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCpX86PoGZe+01z8F2Jmte5yGSzORMYuWo+w6Pq78Nw=;
        b=U2+WwFO24TMtLCHzT716OQ3yDdnM29AMQ1XoJ8dc51z5Wq/hAdR4ht8NwCVd12+HLi
         RF1EJGu+lL1yRVqw0ivlM743WP4KKC81awk9M/QZck+iz6TkWxCI6Bmgo+fgCbvHvKJa
         2RwfVlTaHra4mEPeDj1oAvykxUqA8g5bJUY+qkUgU9ps7rpCctwJQZF6JwBPTJsFwv4A
         faDFuaylecRIoiOYLLOaumk8UVCMlVYnC+4FQoVi3jyYc8LK2AqEwiA7VYezYlGV7QyY
         7OAIbkx14GMhgQtWdp3sDlyANR7ntH08vUdgHPv4lcViacc6eDXTxTR2PfvpUlt613sy
         YVZA==
X-Gm-Message-State: AOJu0YxARvYm2sR6KeSa6F2uFG/y1Odu9DXVzzzf1gFKYMkihlwhdLgL
	9V84qulCkZQLcbSlspV6fHXv1aCk8IbB60zbXese3dH/BKNObgz8w+KBhlSr96vrpfH+qRECVd/
	aNe8M7HnODVBBtv83DQuO7xWyHrEWhOg22V5fSl7gvIho8MuUUg==
X-Received: by 2002:a5d:4a07:0:b0:336:645e:3d9f with SMTP id m7-20020a5d4a07000000b00336645e3d9fmr3220796wrq.124.1703515263953;
        Mon, 25 Dec 2023 06:41:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj2DpqtPqEpTmnkMcmDdAWO/NAH2KYQxWHYBlyJnk5k2kalANc7ZkucSVc2LG3TSg8UKmMaA==
X-Received: by 2002:a5d:4a07:0:b0:336:645e:3d9f with SMTP id m7-20020a5d4a07000000b00336645e3d9fmr3220783wrq.124.1703515263641;
        Mon, 25 Dec 2023 06:41:03 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
        by smtp.gmail.com with ESMTPSA id e14-20020a5d6d0e000000b00336cbbf2e0fsm1042391wrq.27.2023.12.25.06.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 06:41:02 -0800 (PST)
Date: Mon, 25 Dec 2023 09:41:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio Perez Martin <eperezma@redhat.com>,
	Si-Wei Liu <si-wei.liu@oracle.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	virtualization@lists.linux-foundation.org,
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v4 00/15] vdpa/mlx5: Add support for resumable vqs
Message-ID: <20231225094040-mutt-send-email-mst@kernel.org>
References: <20231219180858.120898-1-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231219180858.120898-1-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 19, 2023 at 08:08:43PM +0200, Dragos Tatulea wrote:
> Add support for resumable vqs in the mlx5_vdpa driver. This is a
> firmware feature that can be used for the following benefits:
> - Full device .suspend/.resume.
> - .set_map doesn't need to destroy and create new vqs anymore just to
>   update the map. When resumable vqs are supported it is enough to
>   suspend the vqs, set the new maps, and then resume the vqs.
> 
> The first patch exposes relevant bits for the feature in mlx5_ifc.h.
> That means it needs to be applied to the mlx5-vhost tree [0] first. Once
> applied there, the change has to be pulled from mlx5-vhost into the
> vhost tree and only then the remaining patches can be applied. Same flow
> as the vq descriptor mappings patchset [1].
> 
> The second part implements the vdpa backend feature support to allow
> vq state and address changes when the device is in DRIVER_OK state and
> suspended.
> 
> The third part adds support for seletively modifying vq parameters. This
> is needed to be able to use resumable vqs.
> 
> Then the actual support for resumable vqs is added.
> 
> The last part of the series introduces reference counting for mrs which
> is necessary to avoid freeing mkeys too early or leaking them.


I lost track. Are you going to send v5 or not?

> * Changes in v4:
> - Added vdpa backend feature support for changing vq properties in
>   DRIVER_OK when device is suspended. Added support in the driver as
>   well.
> - Dropped Acked-by for the patches that had the tag mistakenly
>   added.
> 
> * Changes in v3:
> - Faulty version. Please ignore.
> 
> * Changes in v2:
> - Added mr refcounting patches.
> - Deleted unnecessary patch: "vdpa/mlx5: Split function into locked and
>   unlocked variants"
> - Small print improvement in "Introduce per vq and device resume"
>   patch.
> - Patch 1/7 has been applied to mlx5-vhost branch.
> 
> 
> Dragos Tatulea (15):
>   vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND flag
>   vdpa: Add VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND flag
>   vdpa: Accept VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND backend
>     feature
>   vdpa: Accept VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND backend
>     feature
>   vdpa: Track device suspended state
>   vdpa: Block vq address change in DRIVER_OK unless device supports it
>   vdpa: Block vq state change in DRIVER_OK unless device supports it
>   vdpa/mlx5: Expose resumable vq capability
>   vdpa/mlx5: Allow modifying multiple vq fields in one modify command
>   vdpa/mlx5: Introduce per vq and device resume
>   vdpa/mlx5: Mark vq addrs for modification in hw vq
>   vdpa/mlx5: Mark vq state for modification in hw vq
>   vdpa/mlx5: Use vq suspend/resume during .set_map
>   vdpa/mlx5: Introduce reference counting to mrs
>   vdpa/mlx5: Add mkey leak detection
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  10 +-
>  drivers/vdpa/mlx5/core/mr.c        |  69 +++++++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 218 ++++++++++++++++++++++++++---
>  drivers/vhost/vdpa.c               |  51 ++++++-
>  include/linux/mlx5/mlx5_ifc.h      |   3 +-
>  include/linux/mlx5/mlx5_ifc_vdpa.h |   4 +
>  include/uapi/linux/vhost_types.h   |   8 ++
>  7 files changed, 322 insertions(+), 41 deletions(-)
> 
> -- 
> 2.43.0

