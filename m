Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C96334CDD
	for <virtualization@lists.linux.dev>; Mon, 11 Nov 2024 01:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731288970; cv=none; b=WD+Wxo8Y5V84QCNgQG2hLBrLRt5O2NmzGli2tKi+GE7/RfdEGAcf3m/lsa7zlNRuxxYxaP6CzrMVkPbe/xk89K8eVGH+ZFRerIq+NU9QjAZT8RFOwEOOtWosrcuFh5fmC/69DovqovH/Cj13X62Bgt8r/EMxC82xhNDiXTyll1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731288970; c=relaxed/simple;
	bh=XdGLyjxBtq7skX/bK0TG/Xfwr3W5VTrng1jSu08x37Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6Ws11D01AzJJV6KtX3wGpr68AmHNRpAQx6dPynVYyvusRw3RID8vDlXJeL4KqYWvvVay7Uk7UjnOwBP0993CH8y0KGgn30qSaSsVwzPPt0JaaiRwL+7459sBe0YAY0kACTIsy4WwFtK8dFeZkM00PQwtbYehSXKgDZvyCMdikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCnLBXFb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCnLBXFb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731288968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W/dbATLxL2+itDhzJeEzYBm61TCf+9wmLBdg3lhJg1U=;
	b=SCnLBXFbZSLntDeXOBUsmeOpwX8rCHCU4iqL/45fAAs41o84gNBryERBpEmrvezT+K83gz
	KeQPmUlul4nlw94bBdWE2cs2I/2vDHHj7GCdYgyN5WiOOLb7443ALEqUvT4vTWOx9jCYZd
	X7Qf3WSVuNoosyUz0ivBiw2wz8i9F5U=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-ga4skswQPfOFfWQJ5aG4Iw-1; Sun, 10 Nov 2024 20:36:04 -0500
X-MC-Unique: ga4skswQPfOFfWQJ5aG4Iw-1
X-Mimecast-MFC-AGG-ID: ga4skswQPfOFfWQJ5aG4Iw
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20c8b23167fso37672555ad.2
        for <virtualization@lists.linux.dev>; Sun, 10 Nov 2024 17:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731288964; x=1731893764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/dbATLxL2+itDhzJeEzYBm61TCf+9wmLBdg3lhJg1U=;
        b=nY/+H2k2WE2xc7tomDJLtWyHF15gY72ioRLizVbMj//uxieJGCBrCDgxRj94IHK+Wo
         370ifqsDdSvETkCeVm+N6WBXa+nP80oN1IlXO7S8ApyUWyY5DuJvfMya+4yqa5+sbDUf
         OhXYaZRDdBSAT0ErEhAVa5OUpboXinrv+/PtbPND9kVpO5nOQdlQGXuDtbOpGDF+Egcz
         76a21OQ5FabjN23UYBG8yialPw03h2u9HzZ5xmIfj5tk9HiWRnkyP/b5xX4RKU2rFhkt
         XuSBAKkjjgqxrFXoFvi97RetuI+lr88sZZEs1IWWxklIfmXeD2GSFKUzokceLO8mi54f
         pdOA==
X-Forwarded-Encrypted: i=1; AJvYcCWXnlOsQWIJHVpMCaI8Yb8PHRMEaXpccySurX6y8br3pUu39MhU0IaxPVd/XFG/b0LkcCQvcgbK9RL8dT2Zlg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVb8cCliPjpcRdtjyycq6lbt4GWZnFHAZ/xY/meFv1HAmJ2JTF
	HbQNpaKvSqr1V+oXT42FgxF1u4IX3ksEhtaQkFrmgwbOd0GjGTQsPBlt5uBbnhbCZLWNhbgmYBi
	JWb6eNWhdflpGCdlDSddopu1Nr7/3iURF83MkkinhnMTfDwN7KJXqIYn+cSIOuQ+9Z1B2CAmE1l
	KQafmsTZpMZaUh7dn/iwsGBQHAT6VNFACBc2b+ZXE=
X-Received: by 2002:a17:90b:2744:b0:2e2:af88:2b9f with SMTP id 98e67ed59e1d1-2e9b172005emr16972819a91.16.1731288963665;
        Sun, 10 Nov 2024 17:36:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0I8ydXA+f/porptghF/VJNNnyFOwaz2qko4ky8Boj/2OSboEeDKrdt8AhMzcp4lG0pNeDvvUUDBSXToarMbI=
X-Received: by 2002:a17:90b:2744:b0:2e2:af88:2b9f with SMTP id
 98e67ed59e1d1-2e9b172005emr16972792a91.16.1731288963254; Sun, 10 Nov 2024
 17:36:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241107085504.63131-1-xuanzhuo@linux.alibaba.com> <20241107085504.63131-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20241107085504.63131-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Nov 2024 09:35:51 +0800
Message-ID: <CACGkMEvzJiTTxibwrbGgdfb9Vq1xtYvEcvR9Y2L9UdOCiy77ug@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/13] virtio-net: rq submits premapped per-buffer
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	virtualization@lists.linux.dev, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8-A8I5oRlnhJaxcmEpr9yIcNzWDOVRG6J-ZV66J3nTs_1731288964
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 4:55=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> virtio-net rq submits premapped per-buffer by setting sg page to NULL;
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4b27ded8fc16..862beacef5d7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -539,6 +539,12 @@ static struct sk_buff *ptr_to_skb(void *ptr)
>         return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLA=
G);
>  }
>
> +static void sg_fill_dma(struct scatterlist *sg, dma_addr_t addr, u32 len=
)
> +{
> +       sg_dma_address(sg) =3D addr;
> +       sg_dma_len(sg) =3D len;
> +}
> +

In the future, we need to consider hiding those in the core.

Anyhow

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

