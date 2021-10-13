Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72708C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 11:27:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1949760527
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 11:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1949760527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C873E81A5C;
	Wed, 13 Oct 2021 11:26:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G82fnb52lyNo; Wed, 13 Oct 2021 11:26:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 808AA819FC;
	Wed, 13 Oct 2021 11:26:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62CD7C0011;
	Wed, 13 Oct 2021 11:26:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22F57C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:26:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECFEE404B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ig1cNGs4Z08X
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:26:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1E67240247
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634124414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O9bhQZmpxxOKA/+YG1DUAh1p76fjJv8+FHlMSab1AvY=;
 b=jTrlJSWDR+Kwu5YYIgAiwDUrY8fHD3dIuUrR4cqCNNK9JJaw02ZRTth/fkAaW65hK8TegI
 FPmel0XsmDRDvoOaZTYmLEpcoXR6ZSWdjSpuZ8DgeDr2OVQU2uZmmvXTrNN6LlY1C4Xnl/
 i4DINMEMtKaFMprYDgzOU30jvt0TgyM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-_v-izOaRNHuxPFwa9oYwCw-1; Wed, 13 Oct 2021 07:26:53 -0400
X-MC-Unique: _v-izOaRNHuxPFwa9oYwCw-1
Received: by mail-wr1-f70.google.com with SMTP id
 f1-20020a5d64c1000000b001611832aefeso1702140wri.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=O9bhQZmpxxOKA/+YG1DUAh1p76fjJv8+FHlMSab1AvY=;
 b=MsV69G1UvQTaaskTUaYdC2CTM28/nhjAKN3YVSbqAU1RKf0igsL6QYc/hOo7Gu0rsU
 Qc43XfvJxozstqdC1TZHwZzKK8adM1kn7n1BxRMIhgKJX4/LGRH88k+zF8EbxZ8IPLOp
 +2L9igKsDnNmVPrX9pYxv8SY38Q+7UYpyx7TafB6ARI9886xn/9ru7j+a+yINylCbm1n
 9bE+PyYFQ2lMjqxvoml+KQoefqJtMPOL85ZeawtgwrmKe0m312jqiKOTuIRHeYSeAkVV
 2bru0ewlSu6zHPec74pL/TNtMW5Xq5o8dNnNaHXxTORl+OadQsbnY1ALvu48WwhQnd96
 Kq2A==
X-Gm-Message-State: AOAM532Kb6zu+0ryACMbDpTXP1UbTjJhQm/906oLZVkBbxFuM3b7B21c
 2ilceCzwn5BBkdAsrJ9E8gqQDcw00t+WMxixbTORu5t7gr/5MVcxNyQS/KJ5BNWHZxWPPvU98Ve
 nkV0cYJRy131yByc/ijumExBG4l6ZjLTnZvbA7VTGFA==
X-Received: by 2002:a1c:7302:: with SMTP id d2mr12208288wmb.92.1634124412308; 
 Wed, 13 Oct 2021 04:26:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDNYrby7Wygbfp6JXO7Rqd1ntc7JdOhbtmuBdMSTKwKEkZLATQmgusIz1NVUmtE5DMu8jDkA==
X-Received: by 2002:a1c:7302:: with SMTP id d2mr12208270wmb.92.1634124412122; 
 Wed, 13 Oct 2021 04:26:52 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id m4sm5236657wrz.45.2021.10.13.04.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 04:26:51 -0700 (PDT)
Date: Wed, 13 Oct 2021 07:26:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] vduse: Disallow injecting interrupt before DRIVER_OK is
 set
Message-ID: <20211013071759-mutt-send-email-mst@kernel.org>
References: <20210923075722.98-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210923075722.98-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Thu, Sep 23, 2021 at 03:57:22PM +0800, Xie Yongji wrote:
> The interrupt callback should not be triggered before DRIVER_OK
> is set. Otherwise, it might break the virtio device driver.
> So let's add a check to avoid the unexpected behavior.
> 
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

OK I guess, except - what about locking/ordering in all this?

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 29a38ecba19e..972c13a7e5da 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -968,6 +968,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  	}
>  	case VDUSE_DEV_INJECT_CONFIG_IRQ:
> +		ret = -EINVAL;
> +		if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +			break;
> +
>  		ret = 0;
>  		queue_work(vduse_irq_wq, &dev->inject);
>  		break;
> @@ -1047,6 +1051,10 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case VDUSE_VQ_INJECT_IRQ: {
>  		u32 index;
>  
> +		ret = -EINVAL;
> +		if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +			break;
> +
>  		ret = -EFAULT;
>  		if (get_user(index, (u32 __user *)argp))
>  			break;
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
