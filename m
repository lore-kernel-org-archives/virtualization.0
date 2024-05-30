Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345BF4D8B2
	for <virtualization@lists.linux.dev>; Thu, 30 May 2024 09:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060627; cv=none; b=u1WUSf9CbY6niQTuW5iDMfY4tpo3l3oX2VixrCqKDnOZb2Ieat0CONUN7JSZkxvYskKbLzvAAnvurvcMfhke/aNaLeYQw/gQqOd+xXFJ83qTIiHToJoSV7j8K8Uc37BRgmeAfK5V2xogJ4e0h5f6dyXrZGUXHwiVBsd72ZFjid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060627; c=relaxed/simple;
	bh=Qvvm7yXi7fdn9ZQxdd4sSR2uFtuRkZJ1zm/Rv/gmONE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JuBjY71bORA0gKX42T11F3edGp95j+hPCixZ2lvte4CreBjaCRsYwfk6xI/SJh9z5IgTBsue+Gj6e7G8huLAbMXUX27I6fpTcnIho2u9yN8UbPTGazL9t4wF8clIS+lc2Ct5Y5iE5piJknr86ah9WaJnKTvfwpa0w5ORYlk+zTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f34y7qZU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f34y7qZU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717060625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lMkW1PqnAjWl0A+6StZOUl5hBdvwmGS5SCjr1iUxRvU=;
	b=f34y7qZUFxTG1KKvaVaGf648+qs44I7p4Zs5LMMlmiRn8hsdQluADBMkuoSy0S3OlLpdPS
	pTzmAZr7DTtDp3LTQybyic6+5j6gB+2jvPUY84sCs0rPN5mlrcqwQ0QYdZvX7oE7SQxkBA
	Ic5iXTJHJQcG7GnRgtjTcqeR03eiKGQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-s9915kJzMVeoY25bSvfbkA-1; Thu, 30 May 2024 05:17:01 -0400
X-MC-Unique: s9915kJzMVeoY25bSvfbkA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-35559d30617so566974f8f.2
        for <virtualization@lists.linux.dev>; Thu, 30 May 2024 02:17:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717060620; x=1717665420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lMkW1PqnAjWl0A+6StZOUl5hBdvwmGS5SCjr1iUxRvU=;
        b=lY1Ddh+gfKO9eVfoyOkIwRGIDR+bU5flPH/1f1w6TEufv+glhH1c1Kqg+/yGrZtgSs
         zKWdC+0BAGIXfCApZ8tt/MXXeGiO2hsnAgFu2J1wRieOKguUnYW5/XDaTeB7DtkKsBdt
         DImpOSNrncGdHHBRYA2IHwf7nogrypEFc5xTITaFMmW80Q+RodKGgGwy1i/X9VSymmTB
         9HpS2abEz4SKpbmEo6PzsB1SAfeOHKR1h9AVAgUx56vNBhIyc+jbww+GRDXCSZ50I4e+
         3rUDYnRfxKksMgoLngNQ9++BuRWwJvf4RHCBF8r5/u7ulr0a2PgyGFOa6/jQ/fjhh49o
         tspQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoEYO/fEHit75NKfyWOrCI0RGi3iRVFO+etO2LnXWcS+KmgnmSdwGcGR4mmfRaMFe/dN8BlhBZhnY+Gcpc/Et20Z+XSt6IvHhyZrrN5wo=
X-Gm-Message-State: AOJu0YxtUIUAMRZH0MRLyIU54CbfxaZfkSF4qEUuta8SQcxMPxcoIkPM
	LY5LYlsyGQttnglVDFDti46GwDyrDiTnK/QJd3St2SfMRQqOllWslEzP1uW8YTZanrDYknkMtIX
	dss+tJe3EeB0PUW6I+U7CqcQkuYe8PvudV1WWzg+HaO+1T7Pmc23UwibtdI5mAQtV
X-Received: by 2002:a5d:6850:0:b0:354:eb62:365a with SMTP id ffacd0b85a97d-35dc008e9a0mr1447381f8f.25.1717060619757;
        Thu, 30 May 2024 02:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi3J261H+kvNlM51nAbEppEo0zvT/nXdwb2pSpj63MFdYMyK0Nzg/1FLCsBdnPikDYyBa54A==
X-Received: by 2002:a5d:6850:0:b0:354:eb62:365a with SMTP id ffacd0b85a97d-35dc008e9a0mr1447350f8f.25.1717060619144;
        Thu, 30 May 2024 02:16:59 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:fb20:c957:3427:ac94:f0a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3574c7017d1sm14349827f8f.76.2024.05.30.02.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:16:58 -0700 (PDT)
Date: Thu, 30 May 2024 05:16:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net v3 2/2] virtio_net: fix a spurious deadlock issue
Message-ID: <20240530051420-mutt-send-email-mst@kernel.org>
References: <20240528134116.117426-1-hengqi@linux.alibaba.com>
 <20240528134116.117426-3-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240528134116.117426-3-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 28, 2024 at 09:41:16PM +0800, Heng Qi wrote:
> When the following snippet is run, lockdep will report a deadlock[1].
> 
>   /* Acquire all queues dim_locks */
>   for (i = 0; i < vi->max_queue_pairs; i++)
>           mutex_lock(&vi->rq[i].dim_lock);
> 
> There's no deadlock here because the vq locks are always taken
> in the same order, but lockdep can not figure it out. So refactoring
> the code to alleviate the problem.
> 
> [1]
> ========================================================
> WARNING: possible recursive locking detected
> 6.9.0-rc7+ #319 Not tainted
> --------------------------------------------
> ethtool/962 is trying to acquire lock:
> 
> but task is already holding lock:
> 
> other info that might help us debug this:
> Possible unsafe locking scenario:
> 
>       CPU0
>       ----
>  lock(&vi->rq[i].dim_lock);
>  lock(&vi->rq[i].dim_lock);
> 
> *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 3 locks held by ethtool/962:
>  #0: ffffffff82dbaab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40
>  #1: ffffffff82dad0a8 (rtnl_mutex){+.+.}-{3:3}, at:
> 				ethnl_default_set_doit+0xbe/0x1e0
> 
> stack backtrace:
> CPU: 6 PID: 962 Comm: ethtool Not tainted 6.9.0-rc7+ #319
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 	   rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x79/0xb0
>  check_deadlock+0x130/0x220
>  __lock_acquire+0x861/0x990
>  lock_acquire.part.0+0x72/0x1d0
>  ? lock_acquire+0xf8/0x130
>  __mutex_lock+0x71/0xd50
>  virtnet_set_coalesce+0x151/0x190
>  __ethnl_set_coalesce.isra.0+0x3f8/0x4d0
>  ethnl_set_coalesce+0x34/0x90
>  ethnl_default_set_doit+0xdd/0x1e0
>  genl_family_rcv_msg_doit+0xdc/0x130
>  genl_family_rcv_msg+0x154/0x230
>  ? __pfx_ethnl_default_set_doit+0x10/0x10
>  genl_rcv_msg+0x4b/0xa0
>  ? __pfx_genl_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x5a/0x110
>  genl_rcv+0x28/0x40
>  netlink_unicast+0x1af/0x280
>  netlink_sendmsg+0x20e/0x460
>  __sys_sendto+0x1fe/0x210
>  ? find_held_lock+0x2b/0x80
>  ? do_user_addr_fault+0x3a2/0x8a0
>  ? __lock_release+0x5e/0x160
>  ? do_user_addr_fault+0x3a2/0x8a0
>  ? lock_release+0x72/0x140
>  ? do_user_addr_fault+0x3a7/0x8a0
>  __x64_sys_sendto+0x29/0x30
>  do_syscall_64+0x78/0x180
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 4d4ac2ececd3 ("virtio_net: Add a lock for per queue RX coalesce")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  drivers/net/virtio_net.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4f828a9e5889..ecb5203d0372 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4257,7 +4257,6 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  	struct virtio_net_ctrl_coal_rx *coal_rx __free(kfree) = NULL;
>  	bool rx_ctrl_dim_on = !!ec->use_adaptive_rx_coalesce;
>  	struct scatterlist sgs_rx;
> -	int ret = 0;
>  	int i;
>  
>  	if (rx_ctrl_dim_on && !virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> @@ -4267,27 +4266,27 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
>  		return -EINVAL;
>  
> -	/* Acquire all queues dim_locks */
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> -		mutex_lock(&vi->rq[i].dim_lock);
> -
>  	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
>  		vi->rx_dim_enabled = true;
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			mutex_lock(&vi->rq[i].dim_lock);
>  			vi->rq[i].dim_enabled = true;
> -		goto unlock;
> +			mutex_unlock(&vi->rq[i].dim_lock);
> +		}
> +		return 0;
>  	}
>  
>  	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
> -	if (!coal_rx) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> +	if (!coal_rx)
> +		return -ENOMEM;
>  
>  	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
>  		vi->rx_dim_enabled = false;
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			mutex_lock(&vi->rq[i].dim_lock);
>  			vi->rq[i].dim_enabled = false;
> +			mutex_unlock(&vi->rq[i].dim_lock);
> +		}
>  	}
>  
>  	/* Since the per-queue coalescing params can be set,
> @@ -4300,22 +4299,19 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>  
>  	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>  				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> -				  &sgs_rx)) {
> -		ret = -EINVAL;
> -		goto unlock;
> -	}
> +				  &sgs_rx))
> +		return -EINVAL;
>  
>  	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
>  	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		mutex_lock(&vi->rq[i].dim_lock);
>  		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
>  		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> -	}
> -unlock:
> -	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
>  		mutex_unlock(&vi->rq[i].dim_lock);
> +	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int virtnet_send_notf_coal_cmds(struct virtnet_info *vi,
> -- 
> 2.32.0.3.g01195cf9f

