Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979A4CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 17:25:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0280F40621;
	Wed, 18 Oct 2023 17:25:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0280F40621
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RpLe8K5m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yN0cJIkfvhxv; Wed, 18 Oct 2023 17:24:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8E2C40004;
	Wed, 18 Oct 2023 17:24:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8E2C40004
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E936C0039;
	Wed, 18 Oct 2023 17:24:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD882C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:24:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4BF740199
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:24:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4BF740199
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JojqOpTAm47e
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:24:56 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E37E40004
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 17:24:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E37E40004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697649895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5AOd0/hJo+xQgO9OcEYZKv2n43WMiR7HBnvKw0ANJXA=;
 b=RpLe8K5mAbONvk3pVUNsI4+KdLJWkb4Zd9ewl7cxXQAdsznE4rGSePUyLJFZV8w27RY0b4
 i9ifvv9a0k6avUvykWdoY4WksisMo9a39GlOOQELElu2KislSdpYgCyQbG6VKGGHfv+yCk
 uTlHixqRbVjrgO5F6jvHbypvUdwpEc4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-iFPQk28bP6SKiRxqIcX9zw-1; Wed, 18 Oct 2023 13:24:53 -0400
X-MC-Unique: iFPQk28bP6SKiRxqIcX9zw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c506abc320so42210721fa.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 10:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697649892; x=1698254692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5AOd0/hJo+xQgO9OcEYZKv2n43WMiR7HBnvKw0ANJXA=;
 b=ZPaKHZ3TyC2w64e0w4gLcSw2ZnY4AuMS/uGcBcux24A4VoO0JY8vvGYBtDJaJKEnk8
 av6frrIKwRi1gomImiQmBUT+8M01zgTp9zGMYP9QS8cwxKO1cFdAt0nBAmhQc54bZ1A7
 D8aML+KRhKF2APQcVnUZHgiJhS6eORgpPAtMvYHtLJOkxnfSxoyuDZNos652r3Mk5rc5
 4tW+uGAyG2wtOGSW0fQhVjmDIx6msCnwsDd8MZ033mj7t0Ya5X3SjSsvfePJDpvDozGW
 yetB2yTnzNK5e61Q5Qq9O+6SlFNAyAbGw/3Zwk0iB9Wh+Upg0vGtahlOY5rgFDutyCqP
 ZaQA==
X-Gm-Message-State: AOJu0Yw+zl6LLip0jFBhRRTPAUxfjXtVtbglpBWChKjZDmsA7HAGl2HB
 DrjI8nMaP/Q2D6e1mRLI4j8VH/meXli1l+pfO1tFU3P7D3TfcFFbeHE+m02SYqhr1KnU57jiePi
 bqKlX4jIRuXC7qKemblJ8o7ghvw3z8e9H3WYkRT70rg==
X-Received: by 2002:a2e:3619:0:b0:2bf:a9b6:d254 with SMTP id
 d25-20020a2e3619000000b002bfa9b6d254mr3934009lja.50.1697649892291; 
 Wed, 18 Oct 2023 10:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBwF/FZH/EqE5Pe6mKGEiyQtBuyLQcUH3K5SG7IYfDvAmL8IFrvXOTzgtqDTf2JFbCaqPxsA==
X-Received: by 2002:a2e:3619:0:b0:2bf:a9b6:d254 with SMTP id
 d25-20020a2e3619000000b002bfa9b6d254mr3933990lja.50.1697649891837; 
 Wed, 18 Oct 2023 10:24:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c320900b0040644e699a0sm2184668wmp.45.2023.10.18.10.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 10:24:51 -0700 (PDT)
Date: Wed, 18 Oct 2023 13:24:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH vhost v4 00/16] vdpa: Add support for vq descriptor
 mappings
Message-ID: <20231018132347-mutt-send-email-mst@kernel.org>
References: <20231018171456.1624030-2-dtatulea@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231018171456.1624030-2-dtatulea@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, kvm@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, Oct 18, 2023 at 08:14:39PM +0300, Dragos Tatulea wrote:
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
> Changes in v4:
> 
> - Improved the handling of empty iotlbs. See mlx5_vdpa_change_map
>   section in patch "12/16 vdpa/mlx5: Improve mr upate flow".
> - Fixed a invalid usage of desc_group_mkey hw vq field when the
>   capability is not there. See patch
>   "15/16 vdpa/mlx5: Enable hw support for vq descriptor map".

At this point, whether this patchset makes it in 6.7 will largely depend
on how many rcs there are in 6.6, so it can get some time in next.


> Changes in v3:
> 
> - dup_iotlb now checks for src == dst case and returns an error.
> - Renamed iotlb parameter in dup_iotlb to dst.
> - Removed a redundant check of the asid value.
> - Fixed a commit message.
> - mx5_ifc.h patch has been applied to mlx5-vhost tree. When applying
>   this series please pull from that tree first.
> 
> Changes in v2:
> 
> - The "vdpa/mlx5: Enable hw support for vq descriptor mapping" change
>   was split off into two patches to avoid merge conflicts into the tree
>   of Linus.
> 
>   The first patch contains only changes for mlx5_ifc.h. This must be
>   applied into the mlx5-vdpa tree [1] first. Once this patch is applied
>   on mlx5-vdpa, the change has to be pulled fom mlx5-vdpa into the vhost
>   tree and only then the remaining patches can be applied.
> 
> [0] https://lore.kernel.org/virtualization/1694248959-13369-1-git-send-email-si-wei.liu@oracle.com
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git/log/?h=mlx5-vhost
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
>  drivers/vdpa/mlx5/core/mr.c        | 194 ++++++++++++++++-------------
>  drivers/vdpa/mlx5/core/resources.c |   6 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 105 +++++++++++-----
>  drivers/vhost/vdpa.c               |  27 ++++
>  include/linux/mlx5/mlx5_ifc.h      |   8 +-
>  include/linux/mlx5/mlx5_ifc_vdpa.h |   7 +-
>  include/linux/vdpa.h               |  11 ++
>  include/uapi/linux/vhost.h         |   8 ++
>  include/uapi/linux/vhost_types.h   |   5 +
>  10 files changed, 272 insertions(+), 130 deletions(-)
> 
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
