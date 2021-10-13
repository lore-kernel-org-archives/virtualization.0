Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46C5C433EF
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:04:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A16360F94
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A16360F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2995B4075D;
	Wed, 13 Oct 2021 10:04:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8j--8yjKve_b; Wed, 13 Oct 2021 10:04:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AD46440704;
	Wed, 13 Oct 2021 10:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F2BFC000F;
	Wed, 13 Oct 2021 10:04:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09F67C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E187982404
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7NhFMCT6LAMz
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:04:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE46481D5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634119487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OhtK0nXUdl5AJXub6wt3SlLG8E5tzLdcIINFEk1zgkM=;
 b=hoyEHYV79eFTasdlFBCqwqwILw3N715NHACSPzi94d8VQeD2okB7lbOjX3VppLGJO7bGv9
 fXjjG6jYQIueoACPww135Mqe1bFWaX+/FoQJbkBHp5hDEkupix4jD+h2WWWlw1AfsoCNzF
 D7w1ItOuRl8qDgTqMJ7mMvNvVQ08f3Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-jEk4-Yj0NHWYRTNmbuz9aA-1; Wed, 13 Oct 2021 06:04:46 -0400
X-MC-Unique: jEk4-Yj0NHWYRTNmbuz9aA-1
Received: by mail-wr1-f70.google.com with SMTP id
 j19-20020adfb313000000b00160a9de13b3so1566223wrd.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OhtK0nXUdl5AJXub6wt3SlLG8E5tzLdcIINFEk1zgkM=;
 b=geYQMtwoFRx3q41bzm0Q14kgAWIVfX8YvwWD189VWiLts63UyX8WmkNsfcvIfqluG6
 TZ59j1i+P+FoH2zNbaZSbCK6Mn7eVR/DT1dX9yYfhppDtw6Ds+9MBpqQNwjo6kfychh4
 IfhcnqF6VtDHECiqCYuLoYXzOQv+szBO0aBV0eNkJcQLWmV91CmkVc2DBZMwX32c5y+3
 gIP4zrvonC7Bhgq9Owlikfx2p7wg3fMCMPcDcC1Y/fjxovudHNNQxfqkw5IXuBrdzatA
 k9zxqWpwZHoNAPVMBMrCl1QlbGCqJPVkiqUqiCSmPLetT3ZdOmL5/HCYRkN4CymCtkdO
 8wNg==
X-Gm-Message-State: AOAM530m+goegi7kBYf6H7h6RO1jFZQoV/4eArDTg+JFB43P/t0ejJuM
 SOcvmG1G3D7gdVyO30140PAOpxrrh5EH13eSjz7L5wjItLj9OvzRXI/L8WpK8/YdREG6lLJttkz
 o9GtcScWch7XvQoz/j/kFDViG3JPnYLIFyLs53D4E1Q==
X-Received: by 2002:a5d:4344:: with SMTP id u4mr40366219wrr.106.1634119485498; 
 Wed, 13 Oct 2021 03:04:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGAAkxN28lCL/1rNJa4xwl0lLeA2jwCGcDEI+EhVuW39fm1FqtHtMBRNyPP8sfVmXbdTaljQ==
X-Received: by 2002:a5d:4344:: with SMTP id u4mr40366199wrr.106.1634119485316; 
 Wed, 13 Oct 2021 03:04:45 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id b3sm1591483wrp.52.2021.10.13.03.04.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 03:04:44 -0700 (PDT)
Date: Wed, 13 Oct 2021 06:04:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 01/12] virtio-blk: validate num_queues during probe
Message-ID: <20211013060341-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211012065227.9953-2-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Tue, Oct 12, 2021 at 02:52:16PM +0800, Jason Wang wrote:
> If an untrusted device neogitates BLK_F_MQ but advertises a zero
> num_queues, the driver may end up trying to allocating zero size
> buffers where ZERO_SIZE_PTR is returned which may pass the checking
> against the NULL. This will lead unexpected results.
> 
> Fixing this by using single queue if num_queues is zero.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

I'd rather fail probe so we don't need to support that.

> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 9b3bd083b411..9deff01a38cb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
>  				   struct virtio_blk_config, num_queues,
>  				   &num_vqs);
> -	if (err)
> +	/* We need at least one virtqueue */
> +	if (err || !num_vqs)
>  		num_vqs = 1;
>  
>  	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
