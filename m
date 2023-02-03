Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB87AC636CC
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6AD0B6129E;
	Fri,  3 Feb 2023 09:33:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6AD0B6129E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O+eU6mLD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9iBPfJDps8H9; Fri,  3 Feb 2023 09:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 66CFA6129D;
	Fri,  3 Feb 2023 09:33:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 66CFA6129D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 344B1C0033;
	Fri,  3 Feb 2023 09:33:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD190C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 98130429ED
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:33:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98130429ED
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O+eU6mLD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TqbiYf9tg5_J
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D989C41912
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D989C41912
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675416807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eTuF1WykcCSNrFr4rtL95OxtxlYr91slBMxyY1t6p2A=;
 b=O+eU6mLD9KXBv7UXMDyJRTtwCo8Wtqgr5Ji3ikPSYdIvoSqFVdqcUiNzVjhyqmhnVSYqOF
 zg1+BhyRI15lIwHItg8kwX0fqNMN/3stnjwA8xuEw/4GeIzR76JopFP7+NXWLuFeXqRSUV
 g07OUn1aKyIlZppcvSNgL1Vd2/kB8pM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-121-v07h9-3VMquZavXLWs7DAg-1; Fri, 03 Feb 2023 04:33:26 -0500
X-MC-Unique: v07h9-3VMquZavXLWs7DAg-1
Received: by mail-ed1-f69.google.com with SMTP id
 s13-20020aa7d78d000000b004a95f05cbc2so773959edq.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 01:33:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTuF1WykcCSNrFr4rtL95OxtxlYr91slBMxyY1t6p2A=;
 b=QADwZI2jWfjD31hLJyoqflJnHO+v6mHZ6sDAO7g8+7Lx0xiPsbMZ8oqGgluPoSbSlY
 4w91LKRtoVOA7u2Iitkmz7OI4uLbGNObo/H7zr+sVQ4CoEDRNzJGt3cNPKwq/hVccJjg
 h1Hvm6b5FQikZyJ3ISYxUSJtRQLu75/9DbrIw/e7NVU7xMLtk7DDoqFHx+ibCTYyrHPd
 5qa1qQlRQHSNcWYu2ja16SN9WJATFRXK2v6zzhx/880c02oV42Cu2EquGgdNXYT4GDHp
 rEOPOtIR6nC6hTQcxpHNIhubkdAko/407xMQSL2A0zqyByNaw3+M8lP/7JFyENxGrvke
 VqLw==
X-Gm-Message-State: AO0yUKWzetPkLjmyyfGAItB1QYn+in9Jmq/NzRedekbWHRtSW8ynVQbl
 uNvNbwtFhyiivWg+zKL4aNnxvwXDr5Ceb1Yf4yA9xn4H75ek9QIeTwZrmXoHlWn4QwyVE2NR5hY
 DEhsTJI/Xd7oupRr8CYYX+t47ap7Q2lUJfg8ihoM9kA==
X-Received: by 2002:a05:6402:1bc6:b0:499:bcd7:a968 with SMTP id
 ch6-20020a0564021bc600b00499bcd7a968mr9213897edb.22.1675416804882; 
 Fri, 03 Feb 2023 01:33:24 -0800 (PST)
X-Google-Smtp-Source: AK7set8d34tbWWobIW5aS5AN6AQqasOyyBEp9/nVTeqh1Y44lnrSAJMaw7sr2zjw/V/WcE79dz7tIg==
X-Received: by 2002:a05:6402:1bc6:b0:499:bcd7:a968 with SMTP id
 ch6-20020a0564021bc600b00499bcd7a968mr9213886edb.22.1675416804672; 
 Fri, 03 Feb 2023 01:33:24 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 ev26-20020a056402541a00b00494dcc5047asm849138edb.22.2023.02.03.01.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 01:33:24 -0800 (PST)
Date: Fri, 3 Feb 2023 04:33:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 5/5] vdpa: mlx5: support per virtqueue dma device
Message-ID: <20230203043307-mutt-send-email-mst@kernel.org>
References: <20230119061525.75068-1-jasowang@redhat.com>
 <20230119061525.75068-6-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230119061525.75068-6-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: gdawar@amd.com, elic@nvidia.com, virtualization@lists.linux-foundation.org,
 tanuj.kamde@amd.com, linux-kernel@vger.kernel.org
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

On Thu, Jan 19, 2023 at 02:15:25PM +0800, Jason Wang wrote:
> This patch implements per virtqueue dma device for mlx5_vdpa. This is
> needed for virtio_vdpa to work for CVQ which is backed by vringh but
> not DMA. We simply advertise the vDPA device itself as the DMA device
> for CVQ then DMA API can simply use PA so the identical mapping for
> CVQ can still be used. Otherwise the identical (1:1) mapping won't
> work when platform IOMMU is enabled since the IOVA is allocated on
> demand which is not necessarily the PA.
> 
> This fixes the following crash when mlx5 vDPA device is bound to
> virtio-vdpa with platform IOMMU enabled but not in passthrough mode:
> 
> BUG: unable to handle page fault for address: ff2fb3063deb1002
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 1393001067 P4D 1393002067 PUD 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> CPU: 55 PID: 8923 Comm: kworker/u112:3 Kdump: loaded Not tainted 6.1.0+ #7
> Hardware name: Dell Inc. PowerEdge R750/0PJ80M, BIOS 1.5.4 12/17/2021
> Workqueue: mlx5_vdpa_wq mlx5_cvq_kick_handler [mlx5_vdpa]
> RIP: 0010:vringh_getdesc_iotlb+0x93/0x1d0 [vringh]
> Code: 14 25 40 ef 01 00 83 82 c0 0a 00 00 01 48 2b 05 93 5a 1b ea 8b 4c 24 14 48 c1 f8 06 48 c1 e0 0c 48 03 05 90 5a 1b ea 48 01 c8 <0f> b7 00 83 aa c0 0a 00 00 01 65 ff 0d bc e4 41 3f 0f 84 05 01 00
> RSP: 0018:ff46821ba664fdf8 EFLAGS: 00010282
> RAX: ff2fb3063deb1002 RBX: 0000000000000a20 RCX: 0000000000000002
> RDX: ff2fb318d2f94380 RSI: 0000000000000002 RDI: 0000000000000001
> RBP: ff2fb3065e832410 R08: ff46821ba664fe00 R09: 0000000000000001
> R10: 0000000000000000 R11: 000000000000000d R12: ff2fb3065e832488
> R13: ff2fb3065e8324a8 R14: ff2fb3065e8324c8 R15: ff2fb3065e8324a8
> FS:  0000000000000000(0000) GS:ff2fb3257fac0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ff2fb3063deb1002 CR3: 0000001392010006 CR4: 0000000000771ee0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
> <TASK>
>   mlx5_cvq_kick_handler+0x89/0x2b0 [mlx5_vdpa]
>   process_one_work+0x1e2/0x3b0
>   ? rescuer_thread+0x390/0x390
>   worker_thread+0x50/0x3a0
>   ? rescuer_thread+0x390/0x390
>   kthread+0xd6/0x100
>   ? kthread_complete_and_exit+0x20/0x20
>   ret_from_fork+0x1f/0x30
>   </TASK>
> 
> Reviewed-by: Eli Cohen <elic@nvidia.com>
> Tested-by: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Jason how about a Fixes tag here?

> ---
> Changes since V1:
> - make mlx5_get_vq_dma_dev() static
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6632651b1e54..97d1ada7f4db 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2682,6 +2682,16 @@ static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
>  	return err;
>  }
>  
> +static struct device *mlx5_get_vq_dma_dev(struct vdpa_device *vdev, u16 idx)
> +{
> +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +
> +	if (is_ctrl_vq_idx(mvdev, idx))
> +		return &vdev->dev;
> +
> +	return mvdev->vdev.dma_dev;
> +}
> +
>  static void mlx5_vdpa_free(struct vdpa_device *vdev)
>  {
>  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> @@ -2897,6 +2907,7 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>  	.get_generation = mlx5_vdpa_get_generation,
>  	.set_map = mlx5_vdpa_set_map,
>  	.set_group_asid = mlx5_set_group_asid,
> +	.get_vq_dma_dev = mlx5_get_vq_dma_dev,
>  	.free = mlx5_vdpa_free,
>  	.suspend = mlx5_vdpa_suspend,
>  };
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
