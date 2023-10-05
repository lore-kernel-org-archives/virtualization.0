Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF059E9271B
	for <virtualization@archiver.kernel.org>; Thu,  5 Oct 2023 17:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B1B781882;
	Thu,  5 Oct 2023 17:31:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B1B781882
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=URqNeSnh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XloY5oi-Jr_R; Thu,  5 Oct 2023 17:31:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F68881D19;
	Thu,  5 Oct 2023 17:31:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F68881D19
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64FB3C0039;
	Thu,  5 Oct 2023 17:31:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDA75C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 17:31:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B964E41587
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 17:31:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B964E41587
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=URqNeSnh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P_4ghWY2AVJP
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 17:31:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9A4540385
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 Oct 2023 17:31:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9A4540385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696527077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVMW3T0+pSEq9HKF2UPuGay65ooHlYaMJ2N1UmHNeXc=;
 b=URqNeSnhMNdcmbf+i8L0XhnxarhPSjO0xeg4Fx00kAr1EKJ9qPGIRVJp7NtlCWlX79Jwfo
 fDXo863NRNPZAHj4o1gcl/WZGU5FvSuKds7rtXges63YhZLt+uIBoILm5sw7Cb34vCZCix
 bGJADnlPf6KXLXI4+EIE95jHasRMDKg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-g2x9gYNSP2-MdnEGqQ8wuA-1; Thu, 05 Oct 2023 13:31:16 -0400
X-MC-Unique: g2x9gYNSP2-MdnEGqQ8wuA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3247f646affso599046f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 Oct 2023 10:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696527075; x=1697131875;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uVMW3T0+pSEq9HKF2UPuGay65ooHlYaMJ2N1UmHNeXc=;
 b=B6TfGXLZf/gh7E3EslJuxrwQ02wEAwfE0OIzVPciS02Um23cEGQGdiO15guAZwDxUp
 BZCUrDuirQ0itagFmJAk5cNrXPQPv8rXZG5nCXt84B8QRoQ3UAZe9UjaovLQPipqJD3l
 esD/h+daEIJDM68C5I2746m63cJPKh7+VMupZTiBda0/LCCYz4cSsMB+vLxIv0DQG4KX
 S5Wcslq17cqM3nurcVCWgQb1wl2ATK+Ry7M9N0a3ssKglYnot/w44+uHieg1lX9+9LxD
 WgvyYIpvXeJIYTJGDwvZBJAXvu8Fp4rGRiXljOKGS1EHEUVYK3fBbolNZ4G1Iu6+cA/S
 aZLQ==
X-Gm-Message-State: AOJu0Yz/8v1MEr4v6X/PL8NPjNvfZyEmYuMd1+90DFBP1LRBLYAslYMK
 oRejrQrUc9e7bjUXNmW9JPjtGb07vF/0jT4hoFIfuD2Y6+TtNRMbLKVKhpD9H6lxiLiBKlLw9m4
 7Kq4KvKvfhPLeid4Z9h++9fT8I51XSNETab3gNjf9QQ==
X-Received: by 2002:a5d:6387:0:b0:323:1688:a70e with SMTP id
 p7-20020a5d6387000000b003231688a70emr2037583wru.16.1696527075271; 
 Thu, 05 Oct 2023 10:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS4ME6z6Ci9AzQVs9PTe4qHC/PkzQ3RLcGw2TNLGVY69OQGUue2EJ94jJFy9YSX4l9F5UW3A==
X-Received: by 2002:a5d:6387:0:b0:323:1688:a70e with SMTP id
 p7-20020a5d6387000000b003231688a70emr2037566wru.16.1696527074948; 
 Thu, 05 Oct 2023 10:31:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:cded:de7:6702:3b9d:235c])
 by smtp.gmail.com with ESMTPSA id
 n1-20020adffe01000000b0031ae8d86af4sm2228566wrr.103.2023.10.05.10.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 10:31:14 -0700 (PDT)
Date: Thu, 5 Oct 2023 13:31:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH vhost v2 00/16] vdpa: Add support for vq descriptor
 mappings
Message-ID: <20231005133054-mutt-send-email-mst@kernel.org>
References: <20230928164550.980832-2-dtatulea@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230928164550.980832-2-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, gal@nvidia.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
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

On Thu, Sep 28, 2023 at 07:45:11PM +0300, Dragos Tatulea wrote:
> This patch series adds support for vq descriptor table mappings which
> are used to improve vdpa live migration downtime. The improvement comes
> from using smaller mappings which take less time to create and destroy
> in hw.
> 
> The first part adds the vdpa core changes from Si-Wei [0].
> 
> The second part adds support in mlx5_vdpa:
> - Refactor the mr code to be able to cleanly add descriptor mappings.
> - Add hardware descriptor mr support.
> - Properly update iotlb for cvq during ASID switch.
> 
> Changes in v2:
> 
> - The "vdpa/mlx5: Enable hw support for vq descriptor mapping" change
>   was split off into two patches to avoid merge conflicts into the tree
>   of Linus.
> 
>   The first patch contains only changes for mlx5_ifc.h. This must be
>   applied into the mlx5-next tree [1] first. Once this patch is applied
>   on mlx5-next, the change has to be pulled fom mlx5-next into the vhost
>   tree and only then the remaining patches can be applied.


I get it you plan v3?

> [0] https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-email-si-wei.liu@oracle.com
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-next
> 
> Dragos Tatulea (13):
>   vdpa/mlx5: Expose descriptor group mkey hw capability
>   vdpa/mlx5: Create helper function for dma mappings
>   vdpa/mlx5: Decouple cvq iotlb handling from hw mapping code
>   vdpa/mlx5: Take cvq iotlb lock during refresh
>   vdpa/mlx5: Collapse "dvq" mr add/delete functions
>   vdpa/mlx5: Rename mr destroy functions
>   vdpa/mlx5: Allow creation/deletion of any given mr struct
>   vdpa/mlx5: Move mr mutex out of mr struct
>   vdpa/mlx5: Improve mr update flow
>   vdpa/mlx5: Introduce mr for vq descriptor
>   vdpa/mlx5: Enable hw support for vq descriptor mapping
>   vdpa/mlx5: Make iotlb helper functions more generic
>   vdpa/mlx5: Update cvq iotlb mapping on ASID change
> 
> Si-Wei Liu (3):
>   vdpa: introduce dedicated descriptor group for virtqueue
>   vhost-vdpa: introduce descriptor group backend feature
>   vhost-vdpa: uAPI to get dedicated descriptor group id
> 
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  31 +++--
>  drivers/vdpa/mlx5/core/mr.c        | 191 ++++++++++++++++-------------
>  drivers/vdpa/mlx5/core/resources.c |   6 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 100 ++++++++++-----
>  drivers/vhost/vdpa.c               |  27 ++++
>  include/linux/mlx5/mlx5_ifc.h      |   8 +-
>  include/linux/mlx5/mlx5_ifc_vdpa.h |   7 +-
>  include/linux/vdpa.h               |  11 ++
>  include/uapi/linux/vhost.h         |   8 ++
>  include/uapi/linux/vhost_types.h   |   5 +
>  10 files changed, 264 insertions(+), 130 deletions(-)
> 
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
