Return-Path: <SRS0=59V0=JE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE820C433B4
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 13:45:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69DAF6138B
	for <virtualization@archiver.kernel.org>; Wed,  7 Apr 2021 13:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69DAF6138B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 219B040F05;
	Wed,  7 Apr 2021 13:45:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KyEXz1dwn_Of; Wed,  7 Apr 2021 13:45:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 738FF403B4;
	Wed,  7 Apr 2021 13:45:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E737C000C;
	Wed,  7 Apr 2021 13:45:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 523BDC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 13:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 34BDE40422
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 13:45:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YiyQ5wMDvjPg
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 13:45:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7397240001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  7 Apr 2021 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1617803124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bhx0J6ZxHu7gUJKkHgrAFr4iPYg1Rtg0anx/v/GSPdc=;
 b=H+Ml3+4e9XWbAlI9HhaXJ1e+82YZrIpkeXDTv+9pOnO9n6cRl8QNVJszpvX2H12S+6fZv2
 nw9JECVZT4R4SEi7o+t6AcC9AKiyI5oY1rxkleZaDRwfVdHe3H/F2Qv0DmRdSWDSgPOawm
 Ecx8iRLoXHMvpViV55LMJtcCFuyB9lw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-Xb9wQSN1NgGrHYOoYTmCMQ-1; Wed, 07 Apr 2021 09:45:21 -0400
X-MC-Unique: Xb9wQSN1NgGrHYOoYTmCMQ-1
Received: by mail-wm1-f69.google.com with SMTP id k7so1176789wmr.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 07 Apr 2021 06:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bhx0J6ZxHu7gUJKkHgrAFr4iPYg1Rtg0anx/v/GSPdc=;
 b=OgTChjXHxSEtO1w8/XvacgtJNaU1WL32IwiiczG5vMF+0SQuj6DfkWTwUlCDoCcyVQ
 1Ogoz+XARMzQzuN3vYKf/42pbPF4i7q70tB0wjPed7aSRiRLTsUzekCjc7/LlqfZ/RLv
 JvHy7Cc5P/M86XOwPiMcX5hh8AycsLtsM4iQ7AbKllQstozaTBwLhuP6j/RE5LfArr3U
 3/wr3xKW8weGWnhP4gkRcRTYUY3xFPnlgMQ/eO/g/SmDqr/GGxCtxDodnbPv1Bp2FPW7
 /6gm1EgnZk0QZANJQ5HmBKJMVuT+W35ZZ9sAlQtHGArOoIAxLDLIpTBwxpEpmieIAf+z
 Gmjg==
X-Gm-Message-State: AOAM532MtARLFEHTYGIcuuIY3XNYqRnAyKSTethw6Sv2P4FfhdJ2XTOs
 uL9OJYjtW7lzbY1UtCJECcvdA6FniLO8lmICkJXwSzpt/f/FBaq8qcfytacD4/1+i8hUAgmtinZ
 c81i3VI3bpZ56koxsJkeRs1/63poza1BbLv6Tu59EAw==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr3189981wmb.106.1617803120573; 
 Wed, 07 Apr 2021 06:45:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoa3hzK2qRbtyhoXwG1LeYRU4EzokhkXEsDJNaLwR4TpykE6x7fSXkSh9k7ujLZ0TaZTHxSg==
X-Received: by 2002:a1c:1b4d:: with SMTP id b74mr3189967wmb.106.1617803120419; 
 Wed, 07 Apr 2021 06:45:20 -0700 (PDT)
Received: from redhat.com ([2a10:800e:f0d3:0:b69b:9fb8:3947:5636])
 by smtp.gmail.com with ESMTPSA id p17sm8664990wmg.5.2021.04.07.06.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Apr 2021 06:45:19 -0700 (PDT)
Date: Wed, 7 Apr 2021 09:45:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/3] virito_pci: add timeout to reset device operation
Message-ID: <20210407094228-mutt-send-email-mst@kernel.org>
References: <20210407120924.133294-1-mgurtovoy@nvidia.com>
 <20210407120924.133294-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20210407120924.133294-2-mgurtovoy@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: nitzanc@nvidia.com, oren@nvidia.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

On Wed, Apr 07, 2021 at 12:09:23PM +0000, Max Gurtovoy wrote:
> According to the spec after writing 0 to device_status, the driver MUST
> wait for a read of device_status to return 0 before reinitializing the
> device. In case we have a device that won't return 0, the reset
> operation will loop forever and cause the host/vm to stuck. Set timeout
> for 3 minutes before giving up on the device.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/virtio/virtio_pci_modern.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index cc3412a96a17..dcee616e8d21 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -162,6 +162,7 @@ static int vp_reset(struct virtio_device *vdev)
>  {
>  	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>  	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
> +	unsigned long timeout = jiffies + msecs_to_jiffies(180000);
>  
>  	/* 0 status means a reset. */
>  	vp_modern_set_status(mdev, 0);
> @@ -169,9 +170,16 @@ static int vp_reset(struct virtio_device *vdev)
>  	 * device_status to return 0 before reinitializing the device.
>  	 * This will flush out the status write, and flush in device writes,
>  	 * including MSI-X interrupts, if any.
> +	 * Set a timeout before giving up on the device.
>  	 */
> -	while (vp_modern_get_status(mdev))
> +	while (vp_modern_get_status(mdev)) {
> +		if (time_after(jiffies, timeout)) {
> +			dev_err(&vdev->dev, "virtio: device not ready. "
> +				"Aborting. Try again later\n");
> +			return -EAGAIN;
> +		}
>  		msleep(1);
> +	}
>  	/* Flush pending VQ/configuration callbacks. */
>  	vp_synchronize_vectors(vdev);
>  	return 0;

Problem is everyone just ignores the return code from reset.
Timing out like that has a chance to cause a lot of trouble
if the device remains active - we need to make reset robust.

What exactly is going on with the device that
get status never returns 0? E.g. maybe it's in a state
where it's returning all 1's because it's wedged permanently -
using that would be better...



> -- 
> 2.25.4

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
