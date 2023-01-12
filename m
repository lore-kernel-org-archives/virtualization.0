Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B375CC54EBD
	for <virtualization@archiver.kernel.org>; Thu, 12 Jan 2023 04:04:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BBDF417C3;
	Thu, 12 Jan 2023 04:04:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BBDF417C3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VbGi46hy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZogrsXL5yc0B; Thu, 12 Jan 2023 04:04:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0328541526;
	Thu, 12 Jan 2023 04:04:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0328541526
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D57D1C0032;
	Thu, 12 Jan 2023 04:04:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53A12C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 04:04:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3AE8F40467
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 04:04:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AE8F40467
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VbGi46hy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V3ZWzrZq9vsR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 04:04:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA2E640414
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AA2E640414
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Jan 2023 04:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673496252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t0OY2I1ezHTRqIu9Y/LC7ts0y7/Uyj7Fzh0DQLGJ/B0=;
 b=VbGi46hyHn/nK+ftT1d5RAMB9NqbhYtW3Sjo0W5xqbg8NijS7+XN8JtFf+om47xCjMqVtM
 URGpiuJ4iqrEbxyNKjj0YlS0nNJjc5BKh23EQAnewm+Tsh1dswalL6aRguXKTKzcCor73a
 Tzh2FB20cEFeu3xKEBkXPliGyh3S7mQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-639-ththIruTNo-dgi-q55XXZw-1; Wed, 11 Jan 2023 23:04:09 -0500
X-MC-Unique: ththIruTNo-dgi-q55XXZw-1
Received: by mail-oo1-f70.google.com with SMTP id
 g26-20020a4a755a000000b004dd8e8ace8bso6258936oof.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Jan 2023 20:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t0OY2I1ezHTRqIu9Y/LC7ts0y7/Uyj7Fzh0DQLGJ/B0=;
 b=4tZqhYmCImlnyN9vIgBYMfIehdvD2FduESh9HuHMmy26f2yP418Vr/1KoLXEEKNMMX
 3bOBKjbJQ+P/hOd7yYrvWT3hAxhjnjx2x16Xkj7KFSWcM8SWnGNSM8QKplPknTRGZcN2
 ThobKX3YT9rV1VCYJoL9ss2HdN6L/+mD/+i5YEoFUu01keaN1bLnfYqDU6eG8i7NdAIG
 +MGPfcRuCyBsOsHMSFg2MwxFpcVg3tMv5JHUeAdYxmkvNkuqqSNeu84H9bU4RhW/q4LY
 +yOOJ+Bq91+3YJ7PyZi074RulhEkOxrjp+9Zxy170hW/xa3WY9Qi5AbtfNh0vnP62ZDY
 /dYw==
X-Gm-Message-State: AFqh2kqshobQ5ZomdJBJrnIprU1l74WaAbAKeq31IdcxIrq1zh3bBAgT
 h3nqAPmSWrR/pub42GTjhcUIdLJOA+H+AwPYswjsdEXD/v7SM1MorZKyplOjv+2JfJSLh/nJii1
 887YJlA7ZZRliJazv65tbAEturTLx7omEViuz98hhY6xby5bmk40KD3Ck/A==
X-Received: by 2002:a05:6830:6481:b0:684:9f72:3fe3 with SMTP id
 ck1-20020a056830648100b006849f723fe3mr579250otb.201.1673496248610; 
 Wed, 11 Jan 2023 20:04:08 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvdhsnX1tQ73S1tyQpK140LB2FMMbmrPAh6IYodfSt/BgEx43J6hE6A3CR6z4IpaIqh9udBSGJaPJYAFihg+yY=
X-Received: by 2002:a05:6830:6481:b0:684:9f72:3fe3 with SMTP id
 ck1-20020a056830648100b006849f723fe3mr579244otb.201.1673496248425; Wed, 11
 Jan 2023 20:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20230111062809.25020-1-jasowang@redhat.com>
 <DM8PR12MB540054712BACEF34E065C2BBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB540054712BACEF34E065C2BBABFC9@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Jan 2023 12:03:57 +0800
Message-ID: <CACGkMEtNn5oiQEdY49O4TyCOV68AF7ypGzMQKzRaq0Tc6rvcYA@mail.gmail.com>
Subject: Re: [PATCH 0/5] virtio_ring: per virtqueue DMA device
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "gdawar@amd.com" <gdawar@amd.com>,
 "tanuj.kamde@amd.com" <tanuj.kamde@amd.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

On Wed, Jan 11, 2023 at 9:33 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 11 January 2023 8:28
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; gdawar@amd.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > tanuj.kamde@amd.com
> > Subject: [PATCH 0/5] virtio_ring: per virtqueue DMA device
> >
> > Hi All:
> >
> > In some cases, the virtqueue could be backed by different devices. One
> > example is that in the case of vDPA some parent may emualte virtqueue
> > via vringh. In this case, it would be wrong if we stick with the
> > physical DMA device for software emulated device, since there's no
> > easy way for vringh to know about the hardware IOMMU mappings.
> >
> > So this series tries to introduce per virtqueue DMA device, then
> > software virtqueues can utilize the transport specific method to
> > assign appropirate DMA device.
> >
> > This fixes the crash of mlx5_vdpa + virtio_vdpa when platform IOMMU is
> > enabled but not in the passthrough mode. The reason for the crash is
> > that the virito_ring tries to map the control virtqueue into platform
> > IOMMU but the vringh assumes a direct mapping (PA as IOVA). This is
> > fixed by advetise the vDPA device that doesnt do DMA (without a DMA
> > ops). So DMA API can go with the direct mapping then the vringh will
> > be happy since mlx5_vdpa assuems a direct/identical mapping by
> > default.
> >
>
> Could you provide instructions how to reproduce the crash you were seeing?

It should be something like:

1) boot host kernel with iommu enabled but not in passthrough mode: I
use intel_iommu=on
2) create vdpa device on top of mlx5_vdpa VF
3) bind the vdpa device to virtio_vdpa

Then I can see the crash.

Thanks

>
> > Please review.
> >
> > Thanks
> >
> > Jason Wang (5):
> >   virtio_ring: per virtqueue dma device
> >   vdpa: introduce get_vq_dma_device()
> >   virtio-vdpa: support per vq dma device
> >   vdpa: set dma mask for vDPA device
> >   vdpa: mlx5: support per virtqueue dma device
> >
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c |  11 +++
> >  drivers/vdpa/vdpa.c               |   5 ++
> >  drivers/virtio/virtio_ring.c      | 133 +++++++++++++++++++++---------
> >  drivers/virtio/virtio_vdpa.c      |  13 ++-
> >  include/linux/vdpa.h              |   6 ++
> >  include/linux/virtio_ring.h       |  16 ++++
> >  6 files changed, 141 insertions(+), 43 deletions(-)
> >
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
