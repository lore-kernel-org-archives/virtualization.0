Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517425F994
	for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757667079; cv=none; b=u4qc03gmB1NkoC468sVZ8J55KPj4XnK1s6Pp/Hro8ZQG9R25Z99sCSVDN5L29MJ/1kXDFY6ZlZr744zMX+J/HtqhcHF0ni165X2eBMoaKgXwTiGckkP1hXNqmYpxteDWOQA6rK8rpyAMaaBF789eEJsQREmOAYcs1IvrFxvq7T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757667079; c=relaxed/simple;
	bh=47vQnPYhJDC8oGXmWGPzVRbfS0hchpXRA0GG7BlSkd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=XBKbrmTzLwXbglIakLFeDoauYrUtcTIZecd4cNyikirV3+3jybIWFhNJQFUjdj7bf/77hN+2WcEuoYpP/h0QrBUC6qhje6BuzFhfrwf8twxOWSHmCJEu1//ZiuDxMCQOB1GpFQ+fJJbIT0cHrhgvQ/hRoFjTVrhYimQzIQfMRb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HevlWepv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HevlWepv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757667075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8kMSCxiL40HDEAJ/S1kTvsHr28EdmEyCSrCl/4d+5lY=;
	b=HevlWepvgxJ88W9Ts9BuIqyl6X6wjaMuG53WrjpKj1/I3Qc/UEXkHIuwyKVj6Qj+uUIvTW
	W2JXDz/emA+hfvPRz/F0bAx+byGaNXUP7u/GRaPo0Z2W7sE084ti+4PJu8pogAKWVPdaXC
	8TxulreLS5JfcTQPkglxc4WkFDLble0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-uPa1gh8_MmemkgbQp076LQ-1; Fri, 12 Sep 2025 04:51:13 -0400
X-MC-Unique: uPa1gh8_MmemkgbQp076LQ-1
X-Mimecast-MFC-AGG-ID: uPa1gh8_MmemkgbQp076LQ_1757667073
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e424a186fcso905936f8f.0
        for <virtualization@lists.linux.dev>; Fri, 12 Sep 2025 01:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757667072; x=1758271872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kMSCxiL40HDEAJ/S1kTvsHr28EdmEyCSrCl/4d+5lY=;
        b=al6x+a696AFEF1BRfarc062nZ1fWLXEy0y/k7MixmtiIpRBeEhWAru+jVgWdee/hUi
         tPELa3Pe9uutSonu4XV/WP0jdyLzrDJpAhbnEV78KbOyN2CGHENFidI+wrN1AGIh6ukx
         IMJqsMhfQYrsY+d3Nx+kgZijHebjn4npwZfwpfy8RSQPutvkR/qEfFc05bn0svd8Y5UV
         2sbo2Ov2pc4rZH+w+QCc/MZ0FB+JkBqjxNyaQkCjqh8fABtjyEM+aBI9R2L4DeFZQNwh
         5HMs2/qn6b/55IYZj05UfXFEa5Om1IEfdtArHj/KpVTdhwlf1RSqqVlUZtZPSinnp1VR
         2TTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrIRgSKl2oZ9BCUjFj3Yt1ZwjUxfp0gIxhYlmRI6p/UZsnbHWBD86EruJjDGdocEzYZPs9C+01PvZd5Vp9Bw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxs7+i1dxDcU0gVp3hY61ToJAg6YCHgOhzt77z5LpCncptd5fs0
	hnaQZYp0Q6XBEB35Jet6UFlQiPB0CM9DNfhE0ToO4ONtw+FJu5bWdELcOeeOcbtuv86PpmN4o/E
	R5UpQksQFvnFbJhw+JA5H/VUNBLobWX0ORL65lphpA8IcVIwF2KzAB8qY+H3sy7ZVQNEN
X-Gm-Gg: ASbGnctGC0i+2YTyGGTrSzBWI9jUuzkL0pICt2SnG67/CcL4YvfeP6svTvqvsMWXDsL
	JEtPwyyVphg2uYFCbpiA2wxA8IoLG+PrxVgimzdRH4MzM2gx78A6F2xH3iI4lurSuXX7/IeGUhI
	YvRzjeUYFM9j7MJkgm+MgKO7pTgnpNhGNrLnUdXZlh+yYFjYP9JM7pLh4oeaRvBK2xTRBU6VJ8E
	j9G3ShU/hZQK/3LK04NS9xiRGpz4hlCZfOdRng7vOoY5WJliXv3eIu8fDjiRcFLnYbkIosMV3Ob
	ev96AEF76ZHwcXD0a3cuJIJz6FKZCqZU
X-Received: by 2002:a05:6000:2407:b0:3e3:24c3:6d71 with SMTP id ffacd0b85a97d-3e76559415fmr1647255f8f.1.1757667072458;
        Fri, 12 Sep 2025 01:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZ2GT21YnVBh75Wd3k+yoprEvCJQn5G2Y8wrMGySDHgCshlINWqkn9hIrIH8egTbTA2leqKQ==
X-Received: by 2002:a05:6000:2407:b0:3e3:24c3:6d71 with SMTP id ffacd0b85a97d-3e76559415fmr1647225f8f.1.1757667072042;
        Fri, 12 Sep 2025 01:51:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:c800:2952:74e:d261:8021])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e41b6dbdbsm40474885e9.22.2025.09.12.01.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 01:51:11 -0700 (PDT)
Date: Fri, 12 Sep 2025 04:51:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com, jonah.palmer@oracle.com, kuba@kernel.org,
	jon@nutanix.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] vhost-net: unbreak busy polling
Message-ID: <20250912045102-mutt-send-email-mst@kernel.org>
References: <20250912082658.2262-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250912082658.2262-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: h8Cz-8MvxnTFHSiz0iOI8sEzOp-8_GQwcyw3jbdqbD8_1757667073
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 12, 2025 at 04:26:57PM +0800, Jason Wang wrote:
> Commit 67a873df0c41 ("vhost: basic in order support") pass the number
> of used elem to vhost_net_rx_peek_head_len() to make sure it can
> signal the used correctly before trying to do busy polling. But it
> forgets to clear the count, this would cause the count run out of sync
> with handle_rx() and break the busy polling.
> 
> Fixing this by passing the pointer of the count and clearing it after
> the signaling the used.
> 
> Cc: stable@vger.kernel.org
> Fixes: 67a873df0c41 ("vhost: basic in order support")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/net.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c6508fe0d5c8..16e39f3ab956 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1014,7 +1014,7 @@ static int peek_head_len(struct vhost_net_virtqueue *rvq, struct sock *sk)
>  }
>  
>  static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
> -				      bool *busyloop_intr, unsigned int count)
> +				      bool *busyloop_intr, unsigned int *count)
>  {
>  	struct vhost_net_virtqueue *rnvq = &net->vqs[VHOST_NET_VQ_RX];
>  	struct vhost_net_virtqueue *tnvq = &net->vqs[VHOST_NET_VQ_TX];
> @@ -1024,7 +1024,8 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>  
>  	if (!len && rvq->busyloop_timeout) {
>  		/* Flush batched heads first */
> -		vhost_net_signal_used(rnvq, count);
> +		vhost_net_signal_used(rnvq, *count);
> +		*count = 0;
>  		/* Both tx vq and rx socket were polled here */
>  		vhost_net_busy_poll(net, rvq, tvq, busyloop_intr, true);
>  
> @@ -1180,7 +1181,7 @@ static void handle_rx(struct vhost_net *net)
>  
>  	do {
>  		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> -						      &busyloop_intr, count);
> +						      &busyloop_intr, &count);
>  		if (!sock_len)
>  			break;
>  		sock_len += sock_hlen;
> -- 
> 2.34.1

