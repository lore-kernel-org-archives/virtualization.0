Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BBEC433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 11:10:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E530461056
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 11:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E530461056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD059829B1;
	Wed, 13 Oct 2021 11:10:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FxrIrwUUWubK; Wed, 13 Oct 2021 11:10:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 408348299D;
	Wed, 13 Oct 2021 11:10:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 074BAC000F;
	Wed, 13 Oct 2021 11:10:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C0CBC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:10:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5CFB2404B5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:10:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MYWUj_4IDeOo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:10:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86A7640229
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 11:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634123418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+yEWRHrOtnfoSmtPUaziGhzFSHwj+uYbiAVAyWuwVn8=;
 b=iDRcoaaQgh8OlvhFhOSHV6Zz9BWv+aT+cpnxhlZtbnlB0XndwaCu3Lwa4lm+/XKG67q5bM
 3ulzk0LNHBm7g0RsXu7Mg9W/s9b7goegcXqemBaLr0k03XOpmYJCmZIcL7QufoO+yc16O8
 jiw0q2ZSayP1u2bLrHvrDNbBtu3aovs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-KYlctGlWP1W8QJ4H00VNRQ-1; Wed, 13 Oct 2021 07:10:17 -0400
X-MC-Unique: KYlctGlWP1W8QJ4H00VNRQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 41-20020adf802c000000b00161123698e0so1674506wrk.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 04:10:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+yEWRHrOtnfoSmtPUaziGhzFSHwj+uYbiAVAyWuwVn8=;
 b=uqcGaEENsztBy6WusdEWvS8oF5mRfPbZRHCkv4qpw9R7zfFSktjDjLOS7cQhORC6rj
 qKM3Y1OPBmIkgL62/kB7J4Pju7aCGiNCgCwRfCFvlRd9XxtFfRpHpB7vTBPz9Dz+dL01
 n8eaVj28auPPwIyQ0vTV3Z9hrq9eBx/xNOk/n4RnNZxceJJ2u/Qjr1nmzMBN87dY7jSz
 YJMxxC/63wwU3G2O1djZk2b1xPHYBId8dzNYIMi9x54RUlZY2jOJoFzqGC9qPLdBSLdF
 6+YTjqjN6doWbbPjNfqfcchAPoWFIVUN6ep5juRvKhJiD08FzIvmYTPnZbKbvnrGRDo1
 iG6A==
X-Gm-Message-State: AOAM532BVQRdM2xAdwrfd1uzSIziJOtkstC/2S9JIaVuvMJVVGA0GJAx
 1xz2l3w7xe1ejb/S66Nn8iLvEII9Buhp/PQoPSPwu7l5IoS8eI/YtYyGylCBJ5Hj3bCGVHAoGwM
 30DM88bYNSYt3O8iZIvotC/tA6fYwRGsXP2C9Mu436A==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr10104551wru.437.1634123416103; 
 Wed, 13 Oct 2021 04:10:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxChu2pUD2m2nFHdsCiOklPHcdOR4K0FtEBCdpnnV1b6Xcu2DdfRGFqkWigWIL8mzNNICm2Jw==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr10104526wru.437.1634123415841; 
 Wed, 13 Oct 2021 04:10:15 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id 25sm4911705wmo.18.2021.10.13.04.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 04:10:15 -0700 (PDT)
Date: Wed, 13 Oct 2021 07:10:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] vduse: Fix race condition between resetting and irq
 injecting
Message-ID: <20211013070657-mutt-send-email-mst@kernel.org>
References: <20210929083050.88-1-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20210929083050.88-1-xieyongji@bytedance.com>
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

On Wed, Sep 29, 2021 at 04:30:50PM +0800, Xie Yongji wrote:
> The interrupt might be triggered after a reset since there is
> no synchronization between resetting and irq injecting.

In fact, irq_lock is already used to synchronize with
irqs. Why isn't taking and releasing it enough?

> And it
> might break something if the interrupt is delayed until a new
> round of device initialization.
> 
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index cefb301b2ee4..841667a896dd 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -80,6 +80,7 @@ struct vduse_dev {
>  	struct vdpa_callback config_cb;
>  	struct work_struct inject;
>  	spinlock_t irq_lock;
> +	struct rw_semaphore rwsem;
>  	int minor;
>  	bool broken;
>  	bool connected;

What does this lock protect? Use a more descriptive name pls,
and maybe add a comment.


> @@ -410,6 +411,8 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>  	if (domain->bounce_map)
>  		vduse_domain_reset_bounce_map(domain);
>  
> +	down_write(&dev->rwsem);
> +
>  	dev->status = 0;
>  	dev->driver_features = 0;
>  	dev->generation++;
> @@ -443,6 +446,8 @@ static void vduse_dev_reset(struct vduse_dev *dev)
>  		flush_work(&vq->inject);
>  		flush_work(&vq->kick);
>  	}
> +
> +	up_write(&dev->rwsem);
>  }
>  
>  static int vduse_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 idx,
> @@ -885,6 +890,23 @@ static void vduse_vq_irq_inject(struct work_struct *work)
>  	spin_unlock_irq(&vq->irq_lock);
>  }
>  
> +static int vduse_dev_queue_irq_work(struct vduse_dev *dev,
> +				    struct work_struct *irq_work)
> +{
> +	int ret = -EINVAL;
> +
> +	down_read(&dev->rwsem);
> +	if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		goto unlock;
> +
> +	ret = 0;
> +	queue_work(vduse_irq_wq, irq_work);
> +unlock:
> +	up_read(&dev->rwsem);
> +
> +	return ret;
> +}
> +
>  static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  			    unsigned long arg)
>  {


so that's a lot of overhead for an irq.
Normally the way to address races like this is to add
flushing to the reset path, not locking to irq path.


> @@ -966,12 +988,7 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		break;
>  	}
>  	case VDUSE_DEV_INJECT_CONFIG_IRQ:
> -		ret = -EINVAL;
> -		if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -			break;
> -
> -		ret = 0;
> -		queue_work(vduse_irq_wq, &dev->inject);
> +		ret = vduse_dev_queue_irq_work(dev, &dev->inject);
>  		break;
>  	case VDUSE_VQ_SETUP: {
>  		struct vduse_vq_config config;
> @@ -1049,10 +1066,6 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  	case VDUSE_VQ_INJECT_IRQ: {
>  		u32 index;
>  
> -		ret = -EINVAL;
> -		if (!(dev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> -			break;
> -
>  		ret = -EFAULT;
>  		if (get_user(index, (u32 __user *)argp))
>  			break;
> @@ -1061,9 +1074,8 @@ static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
>  		if (index >= dev->vq_num)
>  			break;
>  
> -		ret = 0;
>  		index = array_index_nospec(index, dev->vq_num);
> -		queue_work(vduse_irq_wq, &dev->vqs[index].inject);
> +		ret = vduse_dev_queue_irq_work(dev, &dev->vqs[index].inject);
>  		break;
>  	}
>  	default:
> @@ -1144,6 +1156,7 @@ static struct vduse_dev *vduse_dev_create(void)
>  	INIT_LIST_HEAD(&dev->send_list);
>  	INIT_LIST_HEAD(&dev->recv_list);
>  	spin_lock_init(&dev->irq_lock);
> +	init_rwsem(&dev->rwsem);
>  
>  	INIT_WORK(&dev->inject, vduse_dev_irq_inject);
>  	init_waitqueue_head(&dev->waitq);
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
