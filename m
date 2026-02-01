Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3031B10B
	for <virtualization@lists.linux.dev>; Sun,  1 Feb 2026 09:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769936715; cv=none; b=fidaRnQ60Xhnq13+wlbR1TTQADDypKfAPrU/J4ZpsEgUZnqNhCNGneMCOJIX1ZaRSvO/CM7yyzczNnCZgh8y6t+Zdcm6IY151hX1eBPLO7rZZmFFY82GEmjsKbyAXdJmDbS+hxsrsBT7RbwlXqb7/qfF5FzSifI5UWlyo7qN0UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769936715; c=relaxed/simple;
	bh=QEWaTUGYIM3AUbjp29sbAba2kUUYgtptVEBxmi5dzvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M+DFmCGKJEFTkLbd6kxaF1O3VNmzdGrPAQFbItTpMwuqMXyIXdN5QXlT42sX+FQDewJe5XeqHhv+R0FSn0PDxmACP/1yJoAmx6IHhcfMwzALUUNc4kfS27wOIVRdIB38h7QbRL5Xr6w4omDnzSKcTE8xrDult9rQQaJ6X4tPwHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RpOd99rs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RpOd99rs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769936712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n3PpGZtslxQ3EtKo9C9Fdk6vH37O76cwSZfkhQe8fSc=;
	b=RpOd99rsu2w5SJNX9Vk/2uYXjpY37sSLOPifsFbBCPR2lxnSDufXKc7NnyPnCOWmJRxCWf
	iugPXjU4PGQ9ZPxGcDShxsiHCJ7ydmPhIHoU1JvG5xjTfrHd/SG2vnPBnzDqLNIspl0SsU
	tRLf/0yCNLFLF2YEd7eOCdmU+GsGgWg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-_pNbQ3QQMOyDaQJw3qwivw-1; Sun, 01 Feb 2026 04:05:09 -0500
X-MC-Unique: _pNbQ3QQMOyDaQJw3qwivw-1
X-Mimecast-MFC-AGG-ID: _pNbQ3QQMOyDaQJw3qwivw_1769936708
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47ee056e5cfso31104455e9.1
        for <virtualization@lists.linux.dev>; Sun, 01 Feb 2026 01:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769936708; x=1770541508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3PpGZtslxQ3EtKo9C9Fdk6vH37O76cwSZfkhQe8fSc=;
        b=l5EPd/9Ed3i+/kO1xsH/D5FHHslr3bKrUr+NOyIBM4xRIb62khxSnilwG371KeIZla
         RowdDJqLWiw/YaVsu+Pu8iEhuo441EPCgPezijMFF/MIhCYKWg2v3PQOZZ/qbUaXHS4C
         8lCCPNHVjBb4oJs2+h5oQwBNhIlJ9fdMJtThWkp5Waz0Fyx166VjmRAAuJTXSriGZsG5
         A6y3+T5+sSYRbtJN0wKdelTzN990v5ixoekiO0hLfZa2NiMg5kYftRROnbPB9zJFH+AQ
         /ou9dWx6DusK2AuvlA8DGQv/k8iubQDz/B/LVbkM7p6AKL2FHX/KLhNeseoRyY9+NnbK
         6dPg==
X-Forwarded-Encrypted: i=1; AJvYcCVeAdPNn1bXDtiANrR8AOvPsmMqqRKhzxWx4CLdTIcboGLgnw68Z7A9f+1NTufvwBx3b1R+J7V22ei5E9gfbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyXJq4Vn40ASgOSLYIFLk/I594CtOAsmk9OnjU4ZA57Xig8Bv9m
	fQNRgv7wwl3hW2uKCx5Ext23TUb/OMm8ej04md509FqbUZqbTWQ0DNBz/ayDVgxFVel1s5o9ve6
	z/Qtnbgvgjgn5A/yx9c99Bncm6u/EUv1iu/heQI2SPaV5VNieh8sHLVehvohaNfb62szS
X-Gm-Gg: AZuq6aIRQ/XdX7kzb7QhJB+7+LWKWOOQLFXwwJW6AFyV7VAYG8CsBIyvYRiUPeaQqtx
	ImH7h3+mKmwSnQQZK891Rw9GxpZP6cIPTFmIGY7YFK7st/GitAspk/SV0eWr9uIsdPaOSECK4s8
	t9FB5zpFsXNtkwmO6eTODRRuD8Nc0SRxId2IwUtn6lH4iqVkfnylkwex2dYTzNNsstK5d5k/U7m
	yLjPzAQ2WPdfZwY+x7p38dgztCzYoSlzpnbCrioIbU6AWQjP/B+4lsW7fPrNAoGf/7DpUlSd3ej
	Q5WU/COqrVC2p3SriNUUbCrAzUckNpcfnP2z5Fo648wNPEwtIIEVxz4gKmRo68JZ8o45Hi1TRR+
	617JOobBVe1rjGEBqGtjwrdU4HtF8cI0itA==
X-Received: by 2002:a05:600c:4e56:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-482db47cd9emr108399905e9.17.1769936708028;
        Sun, 01 Feb 2026 01:05:08 -0800 (PST)
X-Received: by 2002:a05:600c:4e56:b0:47e:f481:24b7 with SMTP id 5b1f17b1804b1-482db47cd9emr108399225e9.17.1769936707599;
        Sun, 01 Feb 2026 01:05:07 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e04c13a2sm61038245e9.5.2026.02.01.01.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 01:05:07 -0800 (PST)
Date: Sun, 1 Feb 2026 04:05:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: chia-yu.chang@nokia-bell-labs.com
Cc: tariqt@nvidia.com, linux-rdma@vger.kernel.org, shaojijie@huawei.com,
	shenjian15@huawei.com, salil.mehta@huawei.com, mbloch@nvidia.com,
	saeedm@nvidia.com, leon@kernel.org, eperezma@redhat.com,
	brett.creeley@amd.com, jasowang@redhat.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	pabeni@redhat.com, edumazet@google.com, parav@nvidia.com,
	linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
	kuba@kernel.org, stephen@networkplumber.org,
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net,
	liuhangbin@gmail.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, ij@kernel.org,
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Subject: Re: [PATCH v1 net-next 2/3] net: hns3/mlx5e: avoid corrupting CWR
 flag when receiving GRO packet
Message-ID: <20260201040151-mutt-send-email-mst@kernel.org>
References: <20260131225510.2946-1-chia-yu.chang@nokia-bell-labs.com>
 <20260131225510.2946-3-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260131225510.2946-3-chia-yu.chang@nokia-bell-labs.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MzKxNVRxsjciba2d_JnERZY1TjrrVO6DpoV8N6iNdaA_1769936708
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 31, 2026 at 11:55:09PM +0100, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> In Accurate ECN, ACE counter (AE, ECE, CWR flags) changes only when new
> CE packets arrive, while setting SKB_GSO_TCP_ECN in case of not knowing
> the ECN variant can result in header change that corrupts the ACE field.
> The new flag SKB_GSO_TCP_ACCECN is to prevent SKB_GSO_TCP_ECN or
> NETIF_F_TSO_ECN offloading to be used because they would corrupt CWR
> flag somewhere.
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Not my driver, but a better format is something along the lines of:

Currently .... this is wrong because ... as the result .... fix this by ...
so that ....

the coding style does say that you should use the imperative form.



> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index a47464a22751..3a1cf4335477 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -3897,7 +3897,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
>  
>  	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
>  	if (th->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>  
>  	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
>  		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> index 1fc3720d2201..d174f83478a3 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
> @@ -1311,7 +1311,7 @@ static void mlx5e_shampo_update_ipv4_tcp_hdr(struct mlx5e_rq *rq, struct iphdr *
>  	skb->csum_offset = offsetof(struct tcphdr, check);
>  
>  	if (tcp->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>  }
>  
>  static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr *ipv6,
> @@ -1332,7 +1332,7 @@ static void mlx5e_shampo_update_ipv6_tcp_hdr(struct mlx5e_rq *rq, struct ipv6hdr
>  	skb->csum_offset = offsetof(struct tcphdr, check);
>  
>  	if (tcp->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
>  }
>  
>  static void mlx5e_shampo_update_hdr(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe, bool match)
> -- 
> 2.34.1

