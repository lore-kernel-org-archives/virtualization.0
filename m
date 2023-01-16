Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF8AC3DA78
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 02:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B278813E7;
	Mon, 16 Jan 2023 02:49:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B278813E7
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f7dox+GT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bu50V8ePj6Va; Mon, 16 Jan 2023 02:49:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 86436813E8;
	Mon, 16 Jan 2023 02:49:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86436813E8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 586B7C0033;
	Mon, 16 Jan 2023 02:49:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8A49C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 02:49:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99A21813E8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 02:49:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99A21813E8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nkv5RwgcLoGe
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 02:49:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 98F80813E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 98F80813E7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 02:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673837363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rY+5DbLLon7IpXdDXykQnTd3J3XFXUn+jM1P9sxlSJQ=;
 b=f7dox+GTNpLsEkRzM7p71azAr7KpGCsbYviFTWCFZPMthwTidzKwiAEHh95jg7dr/vI6sh
 MhoKkVnEWjJdms1kt7+V3j+O9b5/wgYbgJqlZJhCJ78DafFsFdq8yFKG3KbMbqO1DHhQzA
 RlyxnMy0yqNBuOOHgscVwi32WE066cI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-617-AFbHFHczP3KXRl5UnaBQ4Q-1; Sun, 15 Jan 2023 21:49:22 -0500
X-MC-Unique: AFbHFHczP3KXRl5UnaBQ4Q-1
Received: by mail-oi1-f198.google.com with SMTP id
 d20-20020a05680808f400b0035e4213541cso6153284oic.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Jan 2023 18:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rY+5DbLLon7IpXdDXykQnTd3J3XFXUn+jM1P9sxlSJQ=;
 b=BqPYtl2VGoyNY+Hj7Cdstgr/ySK8khRajrBUswNFJAYRwieDimimfcNp6c9YqXKspb
 8AXRBf5PtE8mJ09WKlmcF28Spjo6E1esR88R1C7rhnHHxa1NJJtaa5u5SIhjE88vNp4i
 TaZ4ifrkLahnFDVnAo2CKY/Wp7kpQH8bAbytRC6SvpIEXSt4R70e195Q1dhU/eu5HF5f
 giqRBEaK6DHGNHaiG5UyFemhJbwhMTIFhOBP+kZWrqI7Xm0/EYr93QbaJX3G6gjPp3Zb
 S4R2HkEpWGo51zNclcXcn1P2MemVG4NX7Kjz4K1rPnowz/e+6/OqThigKKSIdUwGcq17
 fj5Q==
X-Gm-Message-State: AFqh2kocD+RvzV43d7Ly4qKdNcIQWiIv4BUXPzVcd+UxNSJxtTv03lDx
 QdaffopPLMHQeIdvRUkl8Rkm7CP5mtk6S68j5ChdlqrPImtFB2GVbe76fZDVxzMFS7sIJV2xSwR
 Uft83nQdos9yGSD6r5lg8GHJMxCkhnYLlEkSWg8rEck2vhuxBe408vPID1Q==
X-Received: by 2002:a05:6830:6481:b0:684:9f72:3fe3 with SMTP id
 ck1-20020a056830648100b006849f723fe3mr1350378otb.201.1673837361411; 
 Sun, 15 Jan 2023 18:49:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvO6FVjt9bvYf1kCUltQhsPShpvRiYCRk6EbN55E2Ai6Dqz4AuNGRG7U4Ab+Mh2kcQQo8MOTa4PLpkw6cCFeGw=
X-Received: by 2002:a05:6830:6481:b0:684:9f72:3fe3 with SMTP id
 ck1-20020a056830648100b006849f723fe3mr1350372otb.201.1673837361160; Sun, 15
 Jan 2023 18:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20230111062809.25020-1-jasowang@redhat.com>
 <20230111062809.25020-6-jasowang@redhat.com>
 <DM8PR12MB5400D84460E084D3459B49B1ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400D84460E084D3459B49B1ABC09@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 16 Jan 2023 10:49:10 +0800
Message-ID: <CACGkMEu4ZWgh8xb5xF26AEWafpX=CfUh_CcV0Nf97+iN9+E2ZA@mail.gmail.com>
Subject: Re: [PATCH 5/5] vdpa: mlx5: support per virtqueue dma device
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

On Sun, Jan 15, 2023 at 7:08 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, 11 January 2023 8:28
> > To: mst@redhat.com; jasowang@redhat.com
> > Cc: Eli Cohen <elic@nvidia.com>; gdawar@amd.com;
> > virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> > tanuj.kamde@amd.com
> > Subject: [PATCH 5/5] vdpa: mlx5: support per virtqueue dma device
> >
> > This patch implements per virtqueue dma device for mlx5_vdpa. This is
> > needed for virtio_vdpa to work for CVQ which is backed by vringh but
> > not DMA. We simply advertise the vDPA device itself as the DMA device
> > for CVQ then DMA API can simply use PA so the identical mapping for
> > CVQ can still be used. Otherwise the identical (1:1) mapping won't
> > work when platform IOMMU is enabled since the IOVA is allocated on
> > demand which is not necessarily the PA.
> >
> > This fixes the following crash when mlx5 vDPA device is bound to
> > virtio-vdpa with platform IOMMU enabled but not in passthrough mode:
> >
> > BUG: unable to handle page fault for address: ff2fb3063deb1002
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 1393001067 P4D 1393002067 PUD 0
> > Oops: 0000 [#1] PREEMPT SMP NOPTI
> > CPU: 55 PID: 8923 Comm: kworker/u112:3 Kdump: loaded Not tainted 6.1.0+
> > #7
> > Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.5.4 12/17/2021
> > Workqueue: mlx5_vdpa_wq mlx5_cvq_kick_handler [mlx5_vdpa]
> > RIP: 0010:vringh_getdesc_iotlb+0x93/0x1d0 [vringh]
> > Code: 14 25 40 ef 01 00 83 82 c0 0a 00 00 01 48 2b 05 93 5a 1b ea 8b 4c 24
> > 14 48 c1 f8 06 48 c1 e0 0c 48 03 05 90 5a 1b ea 48 01 c8 <0f> b7 00 83 aa c0
> > 0a 00 00 01 65 ff 0d bc e4 41 3f 0f 84 05 01 00
> > RSP: 0018:ff46821ba664fdf8 EFLAGS: 00010282
> > RAX: ff2fb3063deb1002 RBX: 0000000000000a20 RCX: 0000000000000002
> > RDX: ff2fb318d2f94380 RSI: 0000000000000002 RDI: 0000000000000001
> > RBP: ff2fb3065e832410 R08: ff46821ba664fe00 R09: 0000000000000001
> > R10: 0000000000000000 R11: 000000000000000d R12: ff2fb3065e832488
> > R13: ff2fb3065e8324a8 R14: ff2fb3065e8324c8 R15: ff2fb3065e8324a8
> > FS:  0000000000000000(0000) GS:ff2fb3257fac0000(0000)
> > knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ff2fb3063deb1002 CR3: 0000001392010006 CR4: 0000000000771ee0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> > <TASK>
> >   mlx5_cvq_kick_handler+0x89/0x2b0 [mlx5_vdpa]
> >   process_one_work+0x1e2/0x3b0
> >   ? rescuer_thread+0x390/0x390
> >   worker_thread+0x50/0x3a0
> >   ? rescuer_thread+0x390/0x390
> >   kthread+0xd6/0x100
> >   ? kthread_complete_and_exit+0x20/0x20
> >   ret_from_fork+0x1f/0x30
> >   </TASK>
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>
> mlx5_get_vq_dma_dev needs to made static.

Right, I will fix it in v2.

> Other than that:
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> Tested-by: <elic@nvidia.com>

Thanks

>
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> Tested-by: <elic@nvidia.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 6632651b1e54..b0e74c25bf48 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -2682,6 +2682,16 @@ static int mlx5_vdpa_set_map(struct vdpa_device
> > *vdev, unsigned int asid,
> >       return err;
> >  }
> >
> > +struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
> > +{
> > +     struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > +
> > +     if (is_ctrl_vq_idx(mvdev, idx))
> > +             return &vdev->dev;
> > +
> > +     return mvdev->vdev.dma_dev;
> > +}
> > +
> >  static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >  {
> >       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > @@ -2897,6 +2907,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops
> > = {
> >       .get_generation = mlx5_vdpa_get_generation,
> >       .set_map = mlx5_vdpa_set_map,
> >       .set_group_asid = mlx5_set_group_asid,
> > +     .get_vq_dma_dev = mlx5_get_vq_dma_dev,
> >       .free = mlx5_vdpa_free,
> >       .suspend = mlx5_vdpa_suspend,
> >  };
> > --
> > 2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
