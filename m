Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96F8C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 11:59:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57A0A60B37;
	Wed,  6 Apr 2022 11:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EwojlM3_DnI0; Wed,  6 Apr 2022 11:59:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F13FB60A74;
	Wed,  6 Apr 2022 11:59:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C757DC001D;
	Wed,  6 Apr 2022 11:59:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B5D8BC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 944B0405E6
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:59:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FkoDhnuhNMXA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:59:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF593400B8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649246379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dicVFjsXOIL9hOndQjIV/DVmY/a3j1A4etYvxOxmSgQ=;
 b=CFDFwyu9YIaadaE3pVmYVzGubOYqPE8WQgaIB5qu2VsrMNjVgdB1/yfc00kIr3EjlNj8iC
 4fHohE2Xlgx7NvaMTv75kCCYn4A9Fe6FPqNDZJtSMyUNLrYCaJ6Z3SezQua+9x+leBzOZj
 JbHrclj/WbSBX8QEUhJR4hleTDBGDrE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-BQS4JENePwia6ftPjVS0ew-1; Wed, 06 Apr 2022 07:59:38 -0400
X-MC-Unique: BQS4JENePwia6ftPjVS0ew-1
Received: by mail-wm1-f70.google.com with SMTP id
 r206-20020a1c44d7000000b0038e6a1b25f1so2862441wma.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 06 Apr 2022 04:59:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dicVFjsXOIL9hOndQjIV/DVmY/a3j1A4etYvxOxmSgQ=;
 b=AY0er8UQ3Y9ws9e58hLNKGar4By1kvhgCHnc2pJVikLzJjUSOmH367qL/lYjoa4ns6
 n/JZAjA54PLVRPo+DYpJ2ubkgc4dPPNMHWUxB6wPWepgIqtcbusW9sZOJ7RMHPLZcP8v
 BZVVoUMtrG/ELIO5Jl8eEI8cvxNDUbw8Uuh63i9Nkr8DvEiUqsuIcJp+ili9NOEsWI4c
 5rZMdVKrkJzKt/J7ptEj22Q/EfBRH8uo6sdHyASSMbhIR/0WJ+mCmUjLJtRbiFHZSvZE
 L85Y3owjx16RJhTVZjMEz6GlN5jvYCl6+V1pikF0WlQs1zbYJgQXgi21HME8+aV2mh9q
 hQCw==
X-Gm-Message-State: AOAM533BtJdLLMaI56C2Husk+LFPbvikV7laNTQmw1cF378AHdTVQxn8
 6JjEygPCpbqF21hxJzwqAdcHKLP3UD0DvbQy3Y0UMluzMqMNpnWuZpsfnZYSHHb7PHt/E07BrcR
 XwwktDB4XC8bjc5KFGNMF7j8qKBqYIkHnN9cFz1r8Cw==
X-Received: by 2002:adf:fc90:0:b0:206:e7b:cd63 with SMTP id
 g16-20020adffc90000000b002060e7bcd63mr6304658wrr.511.1649246377515; 
 Wed, 06 Apr 2022 04:59:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXEb2qJOGVPTkba/SZuCnqqnQUU7IQyRanDtldo58dlWits4116YDR77kPcSHcn0/MUmK+Vg==
X-Received: by 2002:adf:fc90:0:b0:206:e7b:cd63 with SMTP id
 g16-20020adffc90000000b002060e7bcd63mr6304642wrr.511.1649246377324; 
 Wed, 06 Apr 2022 04:59:37 -0700 (PDT)
Received: from redhat.com ([2.55.179.195]) by smtp.gmail.com with ESMTPSA id
 u13-20020a05600c19cd00b0038cb84f4218sm5055607wmq.27.2022.04.06.04.59.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Apr 2022 04:59:36 -0700 (PDT)
Date: Wed, 6 Apr 2022 07:59:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 3/5] virtio: introduce config op to synchronize vring
 callbacks
Message-ID: <20220406075405-mutt-send-email-mst@kernel.org>
References: <20220406083538.16274-1-jasowang@redhat.com>
 <20220406083538.16274-4-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220406083538.16274-4-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Paul E. McKenney" <paulmck@kernel.org>, peterz@infradead.org,
 maz@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, tglx@linutronix.de
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

On Wed, Apr 06, 2022 at 04:35:36PM +0800, Jason Wang wrote:
> This patch introduce

introduces

> a new

new

> virtio config ops to vring
> callbacks. Transport specific method is required to call
> synchornize_irq() on the IRQs. For the transport that doesn't provide
> synchronize_vqs(), use synchornize_rcu() as a fallback.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/virtio_config.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b341dd62aa4d..08b73d9bbff2 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -57,6 +57,8 @@ struct virtio_shm_region {
>   *		include a NULL entry for vqs unused by driver
>   *	Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
> + * @synchronize_vqs: synchronize with the virtqueue callbacks.
> + *	vdev: the virtio_device

I think I prefer synchronize_callbacks

>   * @get_features: get the array of feature bits for this device.
>   *	vdev: the virtio_device
>   *	Returns the first 64 feature bits (all we currently need).
> @@ -89,6 +91,7 @@ struct virtio_config_ops {
>  			const char * const names[], const bool *ctx,
>  			struct irq_affinity *desc);
>  	void (*del_vqs)(struct virtio_device *);
> +	void (*synchronize_vqs)(struct virtio_device *);
>  	u64 (*get_features)(struct virtio_device *vdev);
>  	int (*finalize_features)(struct virtio_device *vdev);
>  	const char *(*bus_name)(struct virtio_device *vdev);
> @@ -217,6 +220,19 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
>  				      desc);
>  }
>  
> +/**
> + * virtio_synchronize_vqs - synchronize with virtqueue callbacks
> + * @vdev: the device
> + */
> +static inline
> +void virtio_synchronize_vqs(struct virtio_device *dev)
> +{
> +	if (dev->config->synchronize_vqs)
> +		dev->config->synchronize_vqs(dev);
> +	else
> +		synchronize_rcu();

I am not sure about this fallback and the latency impact.
Maybe synchronize_rcu_expedited is better here.

> +}
> +
>  /**
>   * virtio_device_ready - enable vq use in probe function
>   * @vdev: the device
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
