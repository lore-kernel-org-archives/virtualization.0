Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05A02FDC51
	for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 11:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757936292; cv=none; b=QEZie6Rzgotok7PRFGWBTrb52rxtb2l6sFPaanPqxf+bRVGGy0Yr7KdGWbToF8VDRoOUyp5eYxdOzO4nok+a4hhb2eyb5O0WmtV4puVOI5BoBP4ScVzxvdC8x7m7vJ4HT7TP7NCi/OcoIRa4uVO/kYnuXpf3AfCT7uicbole5IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757936292; c=relaxed/simple;
	bh=DtpYL1MzMO59HaNPliuxasN+81gY5KxCeSX8joTRWjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Lu880Zk3DnBTVQ+oCcitRuT1PdJv06wFwVbOKspJzogkgJtzqLLtGCAqKTAApNLMYFuxDL1XNQ3kOZdemgcDTt6dpDO/CjQpIkkbjEZQ6ejdERqmGce+8eteAIN6+U6qu8HrPqaTK9O6r6u8sMnZMjwoQitrF+H4fX4mbAK6FNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dNljkQzr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dNljkQzr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757936288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=39jZ4OPAPIvuhnUtLzb8a5ybFIk25brxp1aIYN08MjM=;
	b=dNljkQzrICOfFQAte+4hBYXl9xk536Mh/PrqWGarPGKFZxq2eJ92LWFK4mcE2dqJXYqB0b
	59sGGdxhNP5bTFKuHvOIh4e0VatEZpKD+sTjmplNoH4Po/7fdzAnfYq5JdOOv24Y5ghoaQ
	Yv8tk3iOyqN+3SMLn8T+xHFRseeUPgE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-EgATOm_SNNOEANYUxJaupg-1; Mon, 15 Sep 2025 07:38:07 -0400
X-MC-Unique: EgATOm_SNNOEANYUxJaupg-1
X-Mimecast-MFC-AGG-ID: EgATOm_SNNOEANYUxJaupg_1757936286
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e40057d90aso1410264f8f.0
        for <virtualization@lists.linux.dev>; Mon, 15 Sep 2025 04:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757936286; x=1758541086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39jZ4OPAPIvuhnUtLzb8a5ybFIk25brxp1aIYN08MjM=;
        b=FE8KoFE2znR8uI9HM4AUGrv5RRTxCjnQqjonLtr/sVZGkumfWLVpCrMioMs968mYp9
         1E0lAvTPWE36ihQyMV22D3G3xJ4WktttO3l2w0rEfqBrCVNKgiKFkp8eNAgaGDGdRwyg
         vUG/3zvvT9mTaGI2fAPF1ZhKT/AAmdv1SqxkQ9+5HxBifDwDx0+3aUFKwn4Ds3vXg85P
         muXfk+l7NRxuu55h6As9VN8U7X/1dvNO7n/vLImjzOkHeD3o3G0DCTvq0GPpjy+uV24v
         ZkoFD7j0+475Jep2DUzejVfis0Z3y3E2B81h2u2nYmoreDEkRkR3pTDmOjBf8+Anu+hz
         7Rpw==
X-Forwarded-Encrypted: i=1; AJvYcCUiTI7T93js3rXO4CWc9BdF6XL+xzEghOixVQ1Zfm/x2IYVa2UMvjiW/RR/uj9GAvGnknk39qwwh9khoO1ZEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzY5Lhwm5W8nxCNB4Hl85PjB7lw18pgzwKdf8nrCvlNDUkgmfY5
	bG8udcyTQBXvJ0mpCY+ylZGy/vuOySD28evr2ELAI4+ZAFXp2IPnKiswuXmHg7Z+eNwPNHnE5fJ
	Gs4pAxnwtgxmFrpGjC8cqZpNXP+xS58kqGuZp72aN0DAgkZbSxqHruM0D3DOB4wwZ1+Pa
X-Gm-Gg: ASbGncsdqdNSwP4us+/bWUrMgnxfPRMXCDICb1GUqkX5FaLfjpLPBI4+4/GVpt4tBzM
	ERwDWx4P7Kx3vIWokztbU1aCe8qyvbKaV4BaVrXDGvOis7m7K++kZwIJKa5FqIDTJ/pyTVD+GxG
	WnwPSm+jxM/nePNwmhjd8HS7pEQX84kCDrYsFNqv/ZVgaK/MzjxDdQltiLONkFu9p9o5amme9Tp
	3sXoy7Goi8vygkMW7bk9Zjv5R5jDK2M0rbO4j2azMGorxDs8zIaJom1wLPUySyc0jb6WpKfevl6
	P/a5f+Qc2yCTkvB9A4pMoXCfEiYfwLcckw==
X-Received: by 2002:a05:6000:4011:b0:3ea:9042:e67e with SMTP id ffacd0b85a97d-3ea9042ed5emr2860196f8f.27.1757936286375;
        Mon, 15 Sep 2025 04:38:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvNoI1D/uJWt4h3s+V0LcUEucReRdXNza2d/QlgTnZdSjXQ7v/FZ9grJzMVk85TQEVfXoE4A==
X-Received: by 2002:a05:6000:4011:b0:3ea:9042:e67e with SMTP id ffacd0b85a97d-3ea9042ed5emr2860172f8f.27.1757936285881;
        Mon, 15 Sep 2025 04:38:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:151b:1100:901d:65fe:87c2:7b22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8892afc04sm9667404f8f.13.2025.09.15.04.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:38:05 -0700 (PDT)
Date: Mon, 15 Sep 2025 07:38:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net V2 2/2] vhost-net: correctly flush batched packet
 before enabling notification
Message-ID: <20250915073616-mutt-send-email-mst@kernel.org>
References: <20250915024703.2206-1-jasowang@redhat.com>
 <20250915024703.2206-2-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250915024703.2206-2-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aF2fM5Nbj7TaC1IzkI-KpioZO-h2PdGnO6fJT6ysWcs_1757936286
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 15, 2025 at 10:47:03AM +0800, Jason Wang wrote:
> Commit 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after
> sendmsg") tries to defer the notification enabling by moving the logic
> out of the loop after the vhost_tx_batch() when nothing new is
> spotted. This will bring side effects as the new logic would be reused
> for several other error conditions.
> 
> One example is the IOTLB: when there's an IOTLB miss, get_tx_bufs()
> might return -EAGAIN and exit the loop and see there's still available
> buffers, so it will queue the tx work again until userspace feed the
> IOTLB entry correctly. This will slowdown the tx processing and
> trigger the TX watchdog in the guest as reported in
> https://lkml.org/lkml/2025/9/10/1596.
> 
> Fixing this via partially reverting 8c2e6b26ffe2 and sticking the
> notification enabling logic inside the loop when nothing new is
> spotted and flush the batched before.
> 
> Reported-by: Jon Kohler <jon@nutanix.com>
> Cc: stable@vger.kernel.org
> Fixes: 8c2e6b26ffe2 ("vhost/net: Defer TX queue re-enable until after sendmsg")
> Signed-off-by: Jason Wang <jasowang@redhat.com>


I still think it's better to structure this as 2 patches:
1. the revert to fix the deadlock
2. one line addition of vhost_tx_batch(net, nvq, sock, &msg);
   to get back the performance of 8c2e6b26ffe2


Not critical though



> ---
> Changes since V1:
> - Tweak the commit log
> - Typo fixes

but you didn't fix them all :(

See below

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

notifications

> +			 * unnecssary virtqueue kicks.


unnecessary

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

