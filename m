Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC12D26E161
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667045; cv=none; b=htnlWMRG62D6yTRovh6Qzgs5U88oBxppRa2WyGDd/emQIAvfvBwBfZQHUSE+y3m3L2P+9noBJ49VHbe3+PUZSi3py3k9MSAPgFjFvB75+hWlhH9lAhoLQb0/QINDKeIEM/IiDyv/xncl9ZqyvtZ4vnHeMLfH9Fb02TvZmyeb5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667045; c=relaxed/simple;
	bh=eIehRNox/dG9Q/NjSvCbhxAAOwBQCzMl/Y+73D6b6cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=W76qCErcs+CPWmrCA9AD2Mzq0oPCzHEJjkPTwtOJXz4td7y4s0zsarg+gqgw/PNBgTfeZoyMq0vMevrfiI/XvRH3dPHcRXgiB5PYu48s1/LhXFgzPRQg/COojLueR5QNCMHG5lqS+3RoDEXjKnHyL6b/K8DhPOHQViaGZW1+WS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dw7lbyV1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dw7lbyV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bGhSd8CvNyRTKzq49MHrvoxg5fRG/+TgxZE8XqY/Z/Y=;
	b=dw7lbyV1uAyUvQeBntax1lqec9je/V7K4z0hn4m+rei4jme5QqeFr5bG+oLLrRnKnxsbic
	7dkcHCag5IQEPQgn1An8VEF7XuPUaK30wcATMnsUoiOTzicV9fUFbG6TiGg8aMlTB5g4j9
	Y9n49vofSTJyfeOMcJ6W5hjFAp01uu0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-W9RkhtGpNjmHklaFiCmOzA-1; Fri, 12 Sep 2025 04:50:40 -0400
X-MC-Unique: W9RkhtGpNjmHklaFiCmOzA-1
X-Mimecast-MFC-AGG-ID: W9RkhtGpNjmHklaFiCmOzA_1757667040
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e7c2273e69so37346f8f.1
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 01:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667039; x=1758271839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGhSd8CvNyRTKzq49MHrvoxg5fRG/+TgxZE8XqY/Z/Y=;
        b=Wg9FGOxedp1I2k/ss/rj8fb8bjKoBkWSTdHVp2WHDkGbWpNrbdo2CR6/CgFktSZcR/
         aOpnDMrwfk+Paecg/KiWi22r41bXnHjEyPPc+/CXlVXp1Dy85OU6mJxCQIlq7N4ws4UA
         DnbwI/VoFO3EfkpaHXrEIPEW5lu1CKK3oBG3FLIePGEW4ege/9POPlKRvVyRm0vZZqw6
         uJ0EuqDLmVdIvoR3GRzqpWZRPSOy5feia+5JJMKKArsdpQx2TWqd8pJKF3+oGfGVGuEz
         cohr/lD2NxohlziUtMB6wgjt2PZa+3E9tSgFNDf5WtRV9tMWjfeN+sJuLkEaT5ZNE59B
         W3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUWofAKkTUkIVrT2p+bWtTFtoIUL1U81Wwow7pN5MEvFNE1/+11qp3XI8bnr4sb7eubgJkJTljqEV92xpR8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoB+nzO/x/BZ5nPeFC+86ZmRd5dMRoisUNi9a0ecmDkIq1opxN
	oErPqCuaoAugxcmggHlE7f1yN4OVcgGIdj62OAeloENdc7FUV91IHeRK/YLjp5YcPVXdAHI4LOA
	rh+lHlqk+NsIWxiexJN+jv8SM4/CYG3mjuNaCsOeslCfzJUky4ZTTByt5n90PR1rSn67M0M1Xt8
	x5
X-Gm-Gg: ASbGncuetgzxYD1DA24RTVkDnvJrfLYGHTVGnAVltnLzDJojBkMtiv9N9twOV1VMJNf
	erL5eIycY5qtwsEfKE/do2EwLtvWvIt3QNg2LPMq4dTNtjyA4NFQkR675VXw8cpsJPxhQ6TbrCd
	VDSdk2FWtjPtwaVCtiTZeHn6deEvJwtMZ+Fv3PKOYy5kmurAHhjpRlQ7FbqI/L4kGTpHIQE/QCi
	HO/3+kZi/ItA5uO/Xl/8MgUmN7dzlZZrVkrvLiWIXddkbZBFQoT3AfC1/eijoMmS1RtfwVOybmG
	14zK9dNCytwQsj6rpoLPMZ4An12Z/jJ4
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1991854f8f.25.1757667039439;
        Fri, 12 Sep 2025 01:50:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS2Tz/SulTKIR1f9nSWXhOdRDsMn29o7jRrHZHGh4hg8LiyfPRYgIJgThyJhmqJvpcfuVOUA==
X-Received: by 2002:a05:6000:178b:b0:3e7:5f26:f1f3 with SMTP id ffacd0b85a97d-3e7658c0f20mr1991827f8f.25.1757667038953;
        Fri, 12 Sep 2025 01:50:38 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7b42bdc5asm321061f8f.21.2025.09.12.01.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:50:38 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:50:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] vhost-net: correctly flush batched packet before
 enabling notification
Message-ID: <20250912044523-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
 <20250912082658.2262-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250912082658.2262-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9C9Nkoq55t26vwnogqTMwyMGlr2xRHMOououOPC9jRM_1757667040
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2025 at 04:26:58PM +0800, Jason Wang wrote:
> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> sendmsg") tries to defer the notification enabling by moving the logic
> out of the loop after the vhost_tx_batch() when nothing new is
> spotted. This will bring side effects as the new logic would be reused
> for several other error conditions.
> 
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and may
> trigger the TX watchdog in the guest.

It's not that it might.
Pls clarify that it *has been reported* to do exactly that,
and add a link to the report.


> Fixing this by stick the notificaiton enabling logic inside the loop
> when nothing new is spotted and flush the batched before.
> 
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

So this is mostly a revert, but with
                     vhost_tx_batch(net, nvq, sock, &msg);
added in to avoid regressing performance.

If you do not want to structure it like this (revert+optimization),
then pls make that clear in the message.


> ---
>  drivers/vhost/net.c | 33 +++++++++++++--------------------
>  1 file changed, 13 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 16e39f3ab956..3611b7537932 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -765,11 +765,11 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  	int err;
>  	int sent_pkts = 0;
>  	bool sock_can_batch = (sock->sk->sk_sndbuf == INT_MAX);
> -	bool busyloop_intr;
>  	bool in_order = vhost_has_feature(vq, VIRTIO_F_IN_ORDER);
>  
>  	do {
> -		busyloop_intr = false;
> +		bool busyloop_intr = false;
> +
>  		if (nvq->done_idx == VHOST_NET_BATCH)
>  			vhost_tx_batch(net, nvq, sock, &msg);
>  
> @@ -780,10 +780,18 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> -			/* Kicks are disabled at this point, break loop and
> -			 * process any remaining batched packets. Queue will
> -			 * be re-enabled afterwards.
> +			/* Flush batched packets before enabling
> +			 * virqtueue notification to reduce
> +			 * unnecssary virtqueue kicks.

typos: virtqueue, unnecessary

>  			 */
> +			vhost_tx_batch(net, nvq, sock, &msg);
> +			if (unlikely(busyloop_intr)) {
> +				vhost_poll_queue(&vq->poll);
> +			} else if (unlikely(vhost_enable_notify(&net->dev,
> +								vq))) {
> +				vhost_disable_notify(&net->dev, vq);
> +				continue;
> +			}
>  			break;
>  		}
>  
> @@ -839,22 +847,7 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> -	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> -
> -	if (unlikely(busyloop_intr))
> -		/* If interrupted while doing busy polling, requeue the
> -		 * handler to be fair handle_rx as well as other tasks
> -		 * waiting on cpu.
> -		 */
> -		vhost_poll_queue(&vq->poll);
> -	else
> -		/* All of our work has been completed; however, before
> -		 * leaving the TX handler, do one last check for work,
> -		 * and requeue handler if necessary. If there is no work,
> -		 * queue will be reenabled.
> -		 */
> -		vhost_net_busy_poll_try_queue(net, vq);
>  }
>  
>  static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> -- 
> 2.34.1

