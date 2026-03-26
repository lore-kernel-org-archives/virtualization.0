Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99B4CB5B
	for <virtualization@lists.linux.dev>; Thu, 26 Mar 2026 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774490976; cv=none; b=IeyUxIV+3B22yUvIya9XPkVoS3tR2JHT0A0/7A2sONYoYiwR4b+8qp9zxfUrLCEC34ohzOnepOih8cEUARvY8zIAgL8iqiC+nrtspT3IqRR6UeFbNF6QatDnp/MuR/A8D4p4TVqOZt77B9y/YCErWjN77xl71l/nesjL17RxJPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774490976; c=relaxed/simple;
	bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvg4Qy/Csdtl2yrV8xh034DW5HUrJa+F6Feipqp/Dx0O00sE9Ak5qQin+RgDB/1uRmtpCWUMdr8bPu2R7Hyx1Js5V4GRcpkK2pyNLcODRYhosKiDAEMNTDCKYI+p6qTmEvRK14Gw/GLQQDFYJF1WOUZRJoILsHpYMDNU1Jl+8iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhhjxEP9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhhjxEP9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774490973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
	b=YhhjxEP9T/XBh3WBIxgezTgdymDF/hLrXkDIGQ2sGcbqxfn+cigJejGhxzlWx4FYDbS7DE
	9cNoilqCK1Jbu8VCu9IQBSE0tnYz9g4JWnjyPUSTCnzgrpNcGnFeURlWe5DkhA9/DfEMlM
	YeXqOwNSc3wpaJeWPcdpsq7vR54y7pQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-hd2xbYIiMainQE3aC70LbQ-1; Wed, 25 Mar 2026 22:09:30 -0400
X-MC-Unique: hd2xbYIiMainQE3aC70LbQ-1
X-Mimecast-MFC-AGG-ID: hd2xbYIiMainQE3aC70LbQ_1774490969
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c0234c1fso610855a91.2
        for <virtualization@lists.linux.dev>; Wed, 25 Mar 2026 19:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774490969; x=1775095769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SM+x8B+Pz15Gvc1EQP2Y8VvxinV8pQbKuNafLtpnPcE=;
        b=Z0ojrvn9gsUPga2nJHAX5hgJfqAioGN3now4Bp7zRsuIYcrH5+xuvnEGR/9c3oTs5O
         /E5Vafjlt+6j6rhHA8C1K+X5SVo7vb9J1q3wjtdIT5lRVQWh4HBgVfQtSegruAZ5pfPF
         eaNV2XGTxs0mm/KiujdrJYF6OQBdshF4CD4zG2GUJ1bxB0Jies18jVb9hKohZ10/+vDe
         N5g1/7pTWoOt4RwFAksvcva8ekbqk2NLPo1L1BBO7I1OCkztA20QqrTpNWlJqLBcWdYv
         Ym4lpj/CSc2JIf2wlMxDd/jiIuIur3GBzJoWx0BV+Xl4suTzuqioF39unf+EtHlFktO+
         fNMA==
X-Forwarded-Encrypted: i=1; AJvYcCWHJhLIZtt+cHcQZNYZAbn0ol3j/PBh7j3PwtIv7DgkRWKq3FCrfMTKhUarXDEtIc/yOEQyJarMX4MrXFw5ww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzM/+vA0lYEg7gJbtm9sT2A6L7/yezo3kiIEL2LEDWbdKaAaasR
	rJADGO2xDvmXaecGbTIaTXHqhYp+eQ54QNh3RlkH17YddLI2xGOJRiuEK63bExtnPEv0BaiZ4Cz
	8FeAR7v81p3Zt58blMueIgB1ZSyuDZwZM6kGif10W73OIZeVTyVTqpzypstmuzYrane4aqFuxCc
	jPVVr4aenVdkv9HIH8KELzH71U7LU1uDngqF/+YgzlHHw=
X-Gm-Gg: ATEYQzxhMw7PUEusHZE+3IHUlc3M7cg4xBuQwrcvBDks5Pr55uHgB+F4MMi0NgOkxNj
	U8SGSHorIQge6uf1t9XalEsrs0HInwCN2FgjyBT8hpCtTbaVDJqjDKyZyPUF23kQOX0lisA3Vb3
	RIRdUgrdGBnAUEnOcgcm4oHY++B/S90UIZJYUoHGBaxPJKPRdYClLrkor78h1xn/MRPI1KQAssU
	bGq
X-Received: by 2002:a05:6a20:3d1c:b0:398:8546:c3fc with SMTP id adf61e73a8af0-39c4ab516d8mr6008482637.7.1774490969220;
        Wed, 25 Mar 2026 19:09:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d1c:b0:398:8546:c3fc with SMTP id
 adf61e73a8af0-39c4ab516d8mr6008444637.7.1774490968666; Wed, 25 Mar 2026
 19:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
In-Reply-To: <f4caa9be9e5addae7851c012cab0a733be7f0974.1774365273.git.mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 26 Mar 2026 10:09:17 +0800
X-Gm-Features: AQROBzAQPVawV1gSLClGfkluwZR06MG28vS66UgSXN-aCJ_PcJcLGWhQhc3M-Xc
Message-ID: <CACGkMEt146_eZCuTt3qP02sjFXPMHb-1s_TcMnOBXox5k87Ugw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: sync RX buffer before reading the header
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Omar Elghoul <oelghoul@linux.ibm.com>, 
	Srikanth Aithal <sraithal@amd.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Vishwanath Seshagiri <vishs@meta.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BcbvvnpFHTaplYAuVpk5lcIKw_JkTBB6tB8MXVIxhbU_1774490969
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:16=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> receive_buf() reads the virtio header through buf before
> page_pool_dma_sync_for_cpu() runs in receive_small() or
> receive_mergeable(). The header buffer is thus unsynchronized at the
> point where flags and, for mergeable buffers, num_buffers are consumed.
>
> Omar Elghoul reported that on s390x Secure Execution this showed up as
> greatly reduced virtio-net performance together with "bad gso" and
> "bad csum" messages in dmesg. This is because with SE sync actually
> copies data, so the header is uninitialized.
>
> Move the sync into receive_buf() so the
> header is synchronized before any access through buf.
>
> Tool use: Cursor with GPT-5.4 drafted the initial code move from prompt:
> "in drivers/net/virtio_net.c, move page_pool_dma_sync_for_cpu on receive
> path to before memory is accessed through buf".
> The result and the commit log were reviewed and edited manually.
>
> Fixes: 168b61da6871 ("virtio_net: add page_pool support for buffer alloca=
tion")
> Reported-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Tested-by: Srikanth Aithal <sraithal@amd.com>
> Tested-by: Omar Elghoul <oelghoul@linux.ibm.com>
> Link: https://lore.kernel.org/r/20260323150136.14452-1-oelghoul@linux.ibm=
.com
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

