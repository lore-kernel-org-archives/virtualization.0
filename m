Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40F161924
	for <virtualization@lists.linux.dev>; Mon, 17 Jun 2024 01:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718589108; cv=none; b=P9vrjpC8rimaxrlYFLP1C1TsJ0Bmjs9eTolAkYLsgHptb08NoYzEcYBUQOV0KYwJA2uFZ7bbe0Tle8hNuD02ouVnyAKN1AP0t/IOm0F+W+jyAn3NBLQLoB9fZpnrHEdCnWiQMIq1jljjDIJBeOPv4PkTN0tee4+NhSJzByYKB2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718589108; c=relaxed/simple;
	bh=KrtdDO/VCr23v8ybpPvgLXMiSCeSjc0+KH0kowuinfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uHBif3vqbcG/rQT+I516CpTQYxc/m/13KktQ2VJhQIS1/L6iQXk7W2/GRb09bbzPFHXLpOKnjFbekxrPUMZQKlcluCaLH5Gfe4Tuho6b/Zg0DwDY8KzT7M63dLBuP9SJbO3GXHfvYFfNcg5Kk/C1911ywt4I5E/WkI8UujQPTyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1IL27Vb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1IL27Vb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718589104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sFa9jqalWQkohxBGb7r1/BRwO9hzM28tWfgameCGoM=;
	b=H1IL27VbBgM5JBolGVSDIrSv8d4WCNJg3NMyous+u4IXMI2AMKmIJL+SMvmsXrhnS9INie
	lwmkDJ3+LG7aUI2dm7CEcOlZ8cP5buR3dodvRvGgeQyOOWlLNzBI+pNemIlEzBYIGn3FWT
	yxLFy2XbVNA8YALFngDgQtuFtAMqymo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-r4Nn9UI8PAWbgz0e8YuRkg-1; Sun, 16 Jun 2024 21:51:43 -0400
X-MC-Unique: r4Nn9UI8PAWbgz0e8YuRkg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6658175f9d4so3723994a12.0
        for <virtualization@lists.linux.dev>; Sun, 16 Jun 2024 18:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718589102; x=1719193902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sFa9jqalWQkohxBGb7r1/BRwO9hzM28tWfgameCGoM=;
        b=ClJaddY+lZMemZ4fldAwda2uVaKqHnk6S0nmud2QMVUtwXcbllDy6uLxQph5v31u+J
         7WTkI+AxFKYpZYoFiRUzYT00MhOxrXVKGXgKMid1BQl24ksivH/NmjiI3tSAaBHWJf6A
         8DooIUPuFLHrDgF2o57AlhYwFzNch8RTs5zwn2tRDyT5ZMyBUl7UIBPSktffWLGZeVe4
         6sfoqSE5CSqDBdZB6U7MT8sWr0v7+f+NMeezNTa4U+ZNpZU5D8niZfqAV74vWalh/1Xe
         MI9YWj7hQwv1Hj18yL4cQRCJNElQzh8XrRPiRBsLrBG0T83giaU1xx5bC+uoD3MtLPrE
         baBg==
X-Forwarded-Encrypted: i=1; AJvYcCVt8P1djbsSAqgbNhfQHyCrIUHHNdJQpBub3vGxmtmZg6Wb7emtyBjQ6GY5zP1XpZAkDOS+Azs43siQDaRfOHeLRYrRTPEsGrI3h4lWIqU=
X-Gm-Message-State: AOJu0YzWF4NUMld98YZvneWUAqmN5+pCGaF3lrwl8wGKQhLDfye7QnP1
	nQWpTmi7KRXcw2aG2JduOAOcF+lU+3ec7VH5nEU0xpS+S4LvfZAorqJKHGizF/leXhOfGSvPcUc
	XEX0AMr1Z5yqtdZJ4MtfzQOvqbpwoi96+qW7zJpXcltvJZPxtYgYiD6h2QeF6z9qYvTyUv0cHbw
	Hw/vXlQheChHCCfqyaAGFaUHFPPMT2OPMMCMcz/bY=
X-Received: by 2002:a05:6a20:9705:b0:1b6:d9fa:8bd with SMTP id adf61e73a8af0-1bae7e7d746mr9987502637.25.1718589102237;
        Sun, 16 Jun 2024 18:51:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKgEBaAC5HQqbCxUsXuTfI029p4WEvw6v7kCzjrPyFhRt1ZFQs3vMZt900K6rK/wsx8brxoPR4nl9Zu4d7zU0=
X-Received: by 2002:a05:6a20:9705:b0:1b6:d9fa:8bd with SMTP id
 adf61e73a8af0-1bae7e7d746mr9987491637.25.1718589101920; Sun, 16 Jun 2024
 18:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240614220422.42733-1-jain.abhinav177@gmail.com>
In-Reply-To: <20240614220422.42733-1-jain.abhinav177@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jun 2024 09:51:30 +0800
Message-ID: <CACGkMEt1nREjoe9bSmwoAmbbpA5mCSiC7QizE5rHCas0xvfgEA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Eliminate OOO packets during switching
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	javier.carrasco.cruz@gmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 15, 2024 at 6:05=E2=80=AFAM Abhinav Jain <jain.abhinav177@gmail=
.com> wrote:
>
> Disable the network device & turn off carrier before modifying the
> number of queue pairs.
> Process all the in-flight packets and then turn on carrier, followed
> by waking up all the queues on the network device.
>
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> ---
>  drivers/net/virtio_net.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d134544..d0a655a3b4c6 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3447,7 +3447,6 @@ static void virtnet_get_drvinfo(struct net_device *=
dev,
>
>  }
>
> -/* TODO: Eliminate OOO packets during switching */
>  static int virtnet_set_channels(struct net_device *dev,
>                                 struct ethtool_channels *channels)
>  {
> @@ -3471,6 +3470,15 @@ static int virtnet_set_channels(struct net_device =
*dev,
>         if (vi->rq[0].xdp_prog)
>                 return -EINVAL;
>
> +       /* Disable network device to prevent packet processing during
> +        * the switch.
> +        */
> +       netif_tx_disable(dev);
> +       netif_carrier_off(dev);

Any reason we don't need to synchronize with NAPI here?

Thanks

> +
> +       /* Make certain that all in-flight packets are processed. */
> +       synchronize_net();
> +
>         cpus_read_lock();
>         err =3D virtnet_set_queues(vi, queue_pairs);
>         if (err) {
> @@ -3482,7 +3490,12 @@ static int virtnet_set_channels(struct net_device =
*dev,
>
>         netif_set_real_num_tx_queues(dev, queue_pairs);
>         netif_set_real_num_rx_queues(dev, queue_pairs);
> - err:
> +
> +       /* Restart the network device */
> +       netif_carrier_on(dev);
> +       netif_tx_wake_all_queues(dev);
> +
> +err:
>         return err;
>  }
>
> --
> 2.34.1
>

