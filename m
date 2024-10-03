Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C216211CA0
	for <virtualization@lists.linux.dev>; Thu,  3 Oct 2024 01:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727919267; cv=none; b=SOjOZ0lL2DEWzNgu2K9v7tBPaU6fefvam4uOsVTwxjiZTjtBOupeLg1HlQgCQjyU/q4t2MIBZlCl2MF80A35B+yB2pXXNo4Sdf01O/JhLzDWzRQLCxs06sIXEDj8kghF1a/V6WkFgkdlhur3ohB/J8uk9QuiRN+lgDK+Z+AXZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727919267; c=relaxed/simple;
	bh=mmaUrN4Dm30mlJAYCNKceu7BnMA5aMALOTE+YcITCc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgimYRNvm3FZvjR31zpLsHXMpPIE/6pGtKUYN3UOy2FzapdL74FYtpLSAt7+BNHpm8bWBtKdMkkYodb1q1UP5oUjC+rweV02AS8t8LIvg9mSxH/vsDV/19Zb/Hr2cOc/e+ex3+aYnN38SJzeDGEr4cMVU75nGTet4tQgGjI/0VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PN7q2093; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PN7q2093"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so46327966b.2
        for <virtualization@lists.linux.dev>; Wed, 02 Oct 2024 18:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727919263; x=1728524063; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DV7X6w6WEiEDmMlQq+ioS4yyvRQLrPkx+bFuOa+5sxo=;
        b=PN7q2093Ik3R+RJS4BDzxGr/rZDod7/9x3a8mIWhm/EVBt3bsLRqOdQSkp+KJMPcGN
         BEEJGviKrPR1b7K7BSuc3sD3eLnnpGYc9UP8c9u3v5vxJPoMW+wbbzRrUnVKQn/UK9XP
         xKn5SRq/KJBSOQi5ZOjif6rWVbQi59Sq+4DGMEOvBnaSj6QqDdhEQmKQPxLi8/2fDaZA
         KY/cbUD7f+v4s+aOno5/o0D3okugw9Q29P95JMahwFT3QbjYhl4Qy16zfgkidGyQ5f6N
         GgjSirOBNmpjMM+IJSFKUcVcMvDoL1kFjVLz/zyR51rMt97jNiZP2YO8yfvWdPy66N3u
         feWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727919263; x=1728524063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DV7X6w6WEiEDmMlQq+ioS4yyvRQLrPkx+bFuOa+5sxo=;
        b=JI38ugh966Zz2na4Hn2agZbJclLOk7S9+xo1X0A/QCTNuwzQ+bcf0rYO8ARDXq4NkT
         qcVr2fKSt0hMQY1CUbG0lpj9EsOwikWKGMks1V2qqNtDAg3kAE3Uw2tdfnOfCaCPvePn
         TgntsLyhy0R6i+X1jhewK73WpSzjohDQ32LVZD+gbqNbEbSZqyiR3o5GTPOvMu5tF5ic
         dawtSYCJUUUHwWrsSGK2h++zyOTg0CaMunQgQdYLabuaBCQH/2/E3MvyD0Z9pPGnog15
         ce0/Ygck7X9t/Cj2Re1Vl3dFn1DhL27MW4BR31+ruyjUWYbqv6qjSE79T/zqqvf8Lyue
         WUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWS5uhcNCYUVHAByzFQMCB6Q9afbaAxI77mYcspWSQ46L8FUlmMk2gjuyHHb5UgNLMeaig9oBGMb8G4ga5XfQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz088BUqLCXwuI2EPtRHeqSEYHDRsIArtuKnjbP2BbNYOMEKtc0
	1BrLh2r6XIgznbrnovud4+Fq9Ep1d4ZNxzqNpo4bM4DBBEzRVwC3v5L9nCha
X-Google-Smtp-Source: AGHT+IEKU7TVq9K/bpf9fJy/0UOluYJcI2o5/6s1Yf9hUvaOWNNvq2hKSdZJYqbq5oGEnlxqZMVegQ==
X-Received: by 2002:a17:906:4fd4:b0:a8d:3338:a497 with SMTP id a640c23a62f3a-a98f8216ce5mr439831066b.4.1727919262819;
        Wed, 02 Oct 2024 18:34:22 -0700 (PDT)
Received: from fedora.. ([151.29.146.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99104d2863sm5688566b.220.2024.10.02.18.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 18:34:21 -0700 (PDT)
From: Luigi Leonardi <luigix25@gmail.com>
X-Google-Original-From: Luigi Leonardi <luigi.leonardi@outlook.com>
To: mst@redhat.com
Cc: brauner@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	eperezma@redhat.com,
	jasowang@redhat.com,
	kuba@kernel.org,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luigi.leonardi@outlook.com,
	marco.pinn95@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH] vsock/virtio: use GFP_ATOMIC under RCU read lock
Date: Thu,  3 Oct 2024 03:33:53 +0200
Message-ID: <20241003013353.116203-1-luigi.leonardi@outlook.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <3fbfb6e871f625f89eb578c7228e127437b1975a.1727876449.git.mst@redhat.com>
References: <3fbfb6e871f625f89eb578c7228e127437b1975a.1727876449.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Link: https://lore.kernel.org/all/hfcr2aget2zojmqpr4uhlzvnep4vgskblx5b6xf2ddosbsrke7@nt34bxgp7j2x
> Fixes: efcd71af38be ("vsock/virtio: avoid queuing packets when intermediate queue is empty")
> Reported-by: Christian Brauner <brauner@kernel.org>
> Cc: Stefano Garzarella <sgarzare@redhat.com>
> Cc: Luigi Leonardi <luigi.leonardi@outlook.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>
> Lightly tested. Christian, could you pls confirm this fixes the problem
> for you? Stefano, it's a holiday here - could you pls help test!
> Thanks!
>
>
>  net/vmw_vsock/virtio_transport.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index f992f9a216f0..0cd965f24609 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -96,7 +96,7 @@ static u32 virtio_transport_get_local_cid(void)
>
>  /* Caller need to hold vsock->tx_lock on vq */
>  static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
> -				     struct virtio_vsock *vsock)
> +				     struct virtio_vsock *vsock, gfp_t gfp)
>  {
>  	int ret, in_sg = 0, out_sg = 0;
>  	struct scatterlist **sgs;
> @@ -140,7 +140,7 @@ static int virtio_transport_send_skb(struct sk_buff *skb, struct virtqueue *vq,
>  		}
>  	}
>
> -	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
> +	ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, gfp);
>  	/* Usually this means that there is no more space available in
>  	 * the vq
>  	 */
> @@ -178,7 +178,7 @@ virtio_transport_send_pkt_work(struct work_struct *work)
>
>  		reply = virtio_vsock_skb_reply(skb);
>
> -		ret = virtio_transport_send_skb(skb, vq, vsock);
> +		ret = virtio_transport_send_skb(skb, vq, vsock, GFP_KERNEL);
>  		if (ret < 0) {
>  			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
>  			break;
> @@ -221,7 +221,7 @@ static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struc
>  	if (unlikely(ret == 0))
>  		return -EBUSY;
>
> -	ret = virtio_transport_send_skb(skb, vq, vsock);
> +	ret = virtio_transport_send_skb(skb, vq, vsock, GFP_ATOMIC);
>  	if (ret == 0)
>  		virtqueue_kick(vq);
>
> --
> MST
>
>

Thanks for fixing this!

I enabled CONFIG_DEBUG_ATOMIC_SLEEP as Stefano suggested and tested with and
without the fix, I can confirm that this fixes the problem.

Reviewed-by: Luigi Leonardi <luigi.leonardi@outlook.com>
