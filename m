Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2931BC4A
	for <virtualization@lists.linux.dev>; Tue, 16 Jan 2024 13:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I40hhrkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705410919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WI664CwiFfrGDN1gZMoEqTeGnvPzqmrpes8IX8DTN08=;
	b=I40hhrkN4iDu/m6lrAVswiG9o1+2Y2fZ9rLpSHX63ehSdPViFKyF0BwEKwnvdqicXGsSfu
	kQbwm68N1Vuh+hFU/npR+XQ/Oxhgxp3RO5VrlTO1k0SeDcs39eYNq+SRJGKr6kV0j/16lV
	0b0hMivm/yAwj/O3WRamO+IiLHuErBw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-vemvEtftM7mttotZKFPhTQ-1; Tue, 16 Jan 2024 08:15:18 -0500
X-MC-Unique: vemvEtftM7mttotZKFPhTQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40e5769e2deso47421695e9.2
        for <virtualization@lists.linux.dev>; Tue, 16 Jan 2024 05:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705410915; x=1706015715;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI664CwiFfrGDN1gZMoEqTeGnvPzqmrpes8IX8DTN08=;
        b=rKTrUFfjZuuYk9Jjse1CxVJbDmou/ifkdaEP9QEq2scjpoVOFxEIPoHYTcQuU1+Wzg
         vsOBKDK+Hf+vNk8gy418WAPfAXqWLnraH26sx8QjT8tQ2rGPCbYri1GwwC7RwzZKwq4k
         08BnRRBVE/1K1RZYivow8samEv1sZEMyrrhMRgIFMACmSPmJW5kKSfbth7O4fR7kmMRG
         +zkIpy/O5jtXZDDqzW9ttIiJqW7YbqZo2h9jBpEAFbsl+fxKh2N6/tfzXndd3f+c24lm
         FVnIQSZtihuncoCjqNSNp88wAkzDVQ9T2pnoMtSflnhKAjHva1LHKWL6us65ZoJTEpAa
         avXw==
X-Gm-Message-State: AOJu0YyXRIGp5xaKrsn5nOdhcxk8sAieNDsuQpMAGCDCsG7IkFp6rpv+
	oCfoc4lifc2jKBJkeESDqqw711/RYh/QDLr13FvR1IZTW2I2o1rirXbi3osTfdCAtMhMVvNeeOo
	tztLIQUYrYe1UsqkrM/2MOyE/DNWSnjwmJnw=
X-Received: by 2002:a7b:cd15:0:b0:40e:46f5:e5ef with SMTP id f21-20020a7bcd15000000b0040e46f5e5efmr2815407wmj.21.1705410914988;
        Tue, 16 Jan 2024 05:15:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUFiMiTWk4bUINhKfc0247wBh/bRaZbbmaxFbHP+hCcvjwqqLmh5eYjPZIgFNnXOOJe7av2g==
X-Received: by 2002:a7b:cd15:0:b0:40e:46f5:e5ef with SMTP id f21-20020a7bcd15000000b0040e46f5e5efmr2815401wmj.21.1705410914679;
        Tue, 16 Jan 2024 05:15:14 -0800 (PST)
Received: from redhat.com ([2.52.29.192])
        by smtp.gmail.com with ESMTPSA id v4-20020a05600c470400b0040e45799541sm23113390wmo.15.2024.01.16.05.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 05:15:13 -0800 (PST)
Date: Tue, 16 Jan 2024 08:15:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/3] virtio-net: fix possible dim status
 unrecoverable
Message-ID: <20240116081442-mutt-send-email-mst@kernel.org>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <1705410693-118895-2-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1705410693-118895-2-git-send-email-hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 16, 2024 at 09:11:31PM +0800, Heng Qi wrote:
> When the dim worker is scheduled, if it fails to acquire the lock,
> dim may not be able to return to the working state later.
> 
> For example, the following single queue scenario:
>   1. The dim worker of rxq0 is scheduled, and the dim status is
>      changed to DIM_APPLY_NEW_PROFILE;
>   2. The ethtool command is holding rtnl lock;
>   3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
>      to acquire the lock and exits;
> 
> Then, even if net_dim is invoked again, it cannot work because the
> state is not restored to DIM_START_MEASURE.
> 
> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
> Belongs to the net branch.
> 
>  drivers/net/virtio_net.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d7ce4a1..f6ac3e7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3524,8 +3524,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>  	struct dim_cq_moder update_moder;
>  	int i, qnum, err;
>  
> -	if (!rtnl_trylock())
> +	if (!rtnl_trylock()) {
> +		schedule_work(&dim->work);
>  		return;
> +	}
>  
>  	/* Each rxq's work is queued by "net_dim()->schedule_work()"
>  	 * in response to NAPI traffic changes. Note that dim->profile_ix

OK but this means that in cleanup it is not sufficient to flush
dim work - it can requeue itself.


> -- 
> 1.8.3.1

