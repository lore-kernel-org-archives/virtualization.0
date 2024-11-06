Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8291D5171
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883278; cv=none; b=PifgENZOzIqyfU8BEphcUk5jshgYOS9cgEovlnOjMHpeI3czx41frOs7HUxpu3xDIiXHeZ6kP8vUn78dZG6ENqVB38zWj9O0B+75y8bwbcWoLJGeDNbpGch9OEudYbzTEnEmDBcHrmNVEsskcbVXsjTuVbHkvnjS2FcqOuVy0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883278; c=relaxed/simple;
	bh=UNYKLzF4r5hBnINqn9birE+zQ/11rAm97XqSomm41EU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=CvrhtlwErAKvCiEk3X6drdeT3KIWMxxGrj8Le/6BuAjjEr+JEKTQKD/ZH8PGeNRuNYfeaUNAWu9GKqc4WUnT+OGDLyAuEtjqgC/OkFDjmOtqBixps/hCufcdZ91nTXHF9mG8eNHcbjqrvJ/c+1naG784WpQWoO/NFKYDUdvaGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0rULdsM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0rULdsM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730883276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fmyYpFxsyQqqojb1lv2cOtlXLCoNWTfRHptpZLl1D5g=;
	b=B0rULdsMtxkMBAhE8H1InLd8OlFhkl8F6FFtoMj4T84AcjT+mivW848GFZCdJVqmHDlz+a
	DZ1HeBiBWSpW2i4IQbqqrYqGggpVuKD7UGuUJhFpSsNY8JNQEYLieuoOaE2Ry2T3SrIQr6
	lU3zr56Z6++7b0JypPHZ+Zn7KjedAKw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Rk5H0tzrPIO7T0TXod3H8Q-1; Wed, 06 Nov 2024 03:54:33 -0500
X-MC-Unique: Rk5H0tzrPIO7T0TXod3H8Q-1
X-Mimecast-MFC-AGG-ID: Rk5H0tzrPIO7T0TXod3H8Q
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d67fe93c6so3587702f8f.0
        for <virtualization@lists.linux.dev>; Wed, 06 Nov 2024 00:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883272; x=1731488072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmyYpFxsyQqqojb1lv2cOtlXLCoNWTfRHptpZLl1D5g=;
        b=EqWdFd6k+73hb1Al8zMPBunNClNOqjt7Gdd7kuGW4HZ0MPXmAbhIvSflfj+ZudVMdS
         RnFRJOFbDUPikKX/Ntz0A3Gp7YobRyTxWwpbrLfNt6L7DtRBpn8LcVlqKJwzqJjlTbaa
         8xNxlnFyGsNJHpRJDqbS6nagxpOUusdJYASmQ2qER57mWnAD3bVwzOxqcGDct5j2upAW
         EALerX2NHMFIMaIvbgYfPS4YOUZEd1rd1lGq+HWK/1MGJRTRL3W2xiJkK5cNnRDxjbgY
         l3d+h7VGt/KMgP/uiuoQ6NBOGg63QTN5LOO8MlbryT186z8gum5Qi/yUs00/JTTMAkvM
         VWnA==
X-Forwarded-Encrypted: i=1; AJvYcCWAlQ4vj6Pwa9+4/ncTjlZIiqGVfamxQGVlfa+oudLh6/9XXVXXdo8znl4C4Fp5H9RU+zqY/Q1J3JTnIf2Wog==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEsjPjJ6CPjtb7+I4t0+P47Ag+Un3HemG8d+ubrqtE+RoatuVz
	HA6OuI2Y6Grd4unBoN138RPLovzywe8+4xp6lAZoexjRjvQYNXF9gbB385jhrs3gXWSwfCSlr88
	xyR/Y3gfE1WPMaZZLwR8jV5DFbcQseSJjM3WFIxzlrhAR4+ceSsDiraSNlwWVEF6h
X-Received: by 2002:a05:6000:4601:b0:381:e702:af15 with SMTP id ffacd0b85a97d-381e702b189mr2660255f8f.37.1730883271958;
        Wed, 06 Nov 2024 00:54:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEs4dAlZ/Ixnt7FpOJvTxE+WzTktExbu7DVSB0TSOaCg2HjETlp7pqbWm4LVa4ZdPMRcAZxg==
X-Received: by 2002:a05:6000:4601:b0:381:e702:af15 with SMTP id ffacd0b85a97d-381e702b189mr2660237f8f.37.1730883271620;
        Wed, 06 Nov 2024 00:54:31 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:e74:5fcf:8a69:659d:f2b2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1168afcsm18469576f8f.91.2024.11.06.00.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:54:30 -0800 (PST)
Date: Wed, 6 Nov 2024 03:54:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost/net: Set num_buffers for virtio 1.0
Message-ID: <20241106035029-mutt-send-email-mst@kernel.org>
References: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240915-v1-v1-1-f10d2cb5e759@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6hhfXdeU0lIgHl4mxnTFROumXvKSGKuUEhoOnacqlS0_1730883272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 15, 2024 at 10:35:53AM +0900, Akihiko Odaki wrote:
> The specification says the device MUST set num_buffers to 1 if
> VIRTIO_NET_F_MRG_RXBUF has not been negotiated.
> 
> Fixes: 41e3e42108bc ("vhost/net: enable virtio 1.0")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

True, this is out of spec. But, qemu is also out of spec :(

Given how many years this was out there, I wonder whether
we should just fix the spec, instead of changing now.

Jason, what's your take?


> ---
>  drivers/vhost/net.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index f16279351db5..d4d97fa9cc8f 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1107,6 +1107,7 @@ static void handle_rx(struct vhost_net *net)
>  	size_t vhost_hlen, sock_hlen;
>  	size_t vhost_len, sock_len;
>  	bool busyloop_intr = false;
> +	bool set_num_buffers;
>  	struct socket *sock;
>  	struct iov_iter fixup;
>  	__virtio16 num_buffers;
> @@ -1129,6 +1130,8 @@ static void handle_rx(struct vhost_net *net)
>  	vq_log = unlikely(vhost_has_feature(vq, VHOST_F_LOG_ALL)) ?
>  		vq->log : NULL;
>  	mergeable = vhost_has_feature(vq, VIRTIO_NET_F_MRG_RXBUF);
> +	set_num_buffers = mergeable ||
> +			  vhost_has_feature(vq, VIRTIO_F_VERSION_1);
>  
>  	do {
>  		sock_len = vhost_net_rx_peek_head_len(net, sock->sk,
> @@ -1205,7 +1208,7 @@ static void handle_rx(struct vhost_net *net)
>  		/* TODO: Should check and handle checksum. */
>  
>  		num_buffers = cpu_to_vhost16(vq, headcount);
> -		if (likely(mergeable) &&
> +		if (likely(set_num_buffers) &&
>  		    copy_to_iter(&num_buffers, sizeof num_buffers,
>  				 &fixup) != sizeof num_buffers) {
>  			vq_err(vq, "Failed num_buffers write");
> 
> ---
> base-commit: 46a0057a5853cbdb58211c19e89ba7777dc6fd50
> change-id: 20240908-v1-90fc83ff8b09
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>

