Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32628CF7F
	for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432789; cv=none; b=Q+XMRmhkVyzTvnDpdVhfb01CYQROnoCTo8j/YS+xjyOFFdwa7B3BUe9Cx2iHrOSUm8K0nwVUhBS4cVAofmZwdlIBbXKjqZuZKpTri0bYntmlBQNHJJJ5FBYmHx6b8DagL2FA20Ba70lzauLSCG4+C2jNX65hHBDQz3aiaJj49pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432789; c=relaxed/simple;
	bh=PH84kld/sKE+RhISrTjG1cjFnL0yLAXB9xK4PwFZaMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGZUpQDyoNXseNo1IRmc+tDnZrsh6cIOa0pWGRCz4jXpGvbsW3ebjHyd528ql7+LeFSNQX9w6WQhkedBD8pWmSzMDUvTAUbONzm/XKFCi3cqLS65p04S4HVKWMNvxEiKmxqdYHKtzEldFUSPNuRuchHjdE3s9Ge150nokHKwneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPZyS1i4; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPZyS1i4"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2263428c8baso21295ad.1
        for <virtualization@lists.linux.dev>; Wed, 23 Apr 2025 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745432786; x=1746037586; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0kIM1GyroCk3zmwGLYPwDaNY7xBbvOnwGmlKqF+IzQ=;
        b=wPZyS1i4TaW+x7z/fqGedUM5gfsMlmsyvX+m0cvZnbt5L3WVur6EOdlggQioT0Y4Po
         lyHBmt8hEOUvTVqm7U8VM7zre8pC4K//ZOctYJ7ch551IVbypk7/xccnRFmY2BbEvhBG
         ibRZZ7riu30hJQOVXrkac/1Qf8lOmkfi0dd5pAQwHDHaafcYV0NkJ4ZaQu/73ZK8773e
         t0b3pDjKV8EtifcsRJZEoCzsLMXA/wFu9gsoXLf3I/jK6IZHDetEHPdfcVmcuIYvsSFU
         NX4g0/tfnaIwye3jKwsIgYkx91q7KR/8Wf8UdnxLJJhV86OBevlYnqsuzLHN2t6r9Qwi
         OFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745432786; x=1746037586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0kIM1GyroCk3zmwGLYPwDaNY7xBbvOnwGmlKqF+IzQ=;
        b=pgEsxdZ86SIrQhwfp39suyY+Ow1+ezFZCh5GCXnxWK/m064/wCFfvdkO2s70xa/o0R
         T1R/KlTMhuWstk8cjIN3QDV3uLBEEeij7Ib2C6Xfum3OxPFqt+yhc4mOkRBZSj4yBjA9
         ek/8u4gJC29cSRrunj7noeXQMFXHeZ9ItB+Ly2gfRWvcTlTA5MwVYJJXJ98mGSlZvnXG
         ryKpTn862E4xl8BtOEKFd4r5QknLLvWfunf7QAJ8Gn3kEGnmhhB5hQBIakQzBc/EhIvV
         ZZOWByiNOJ+6ZIu3zW5hi9LLFxTj+LcaugdH7ged9Po34w0xWxcToE7+Dvc/qBABdO6w
         ZiLw==
X-Forwarded-Encrypted: i=1; AJvYcCWp4GOemrPAB+HeqF76SCANv2VwyLqejOykQjFmnaZwdjyzzxSk1roqoj+vo9audy+DgrZsLrBBWECcCfjFcg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJPHWo4XkQY4RIwtxzjmFZ4wpL9QkcXsIZc7ySkzfB5ZOdY6gB
	PLn2hGlRqxo0DRrnQOSmAF4F/loLPCjRthKNDpjGz5xD8sqDEopf8mGlNa5ezVqLKn5ugC+Lpva
	/O8DkErs90w6DOTP1T4FJqy5wjtoa86uk7URl
X-Gm-Gg: ASbGncseewSuxzJCleHPadYrYN4QDSa2Q7z/cZSFIeIvxtruYAtlHNsH0k9ZfxGgqIE
	LE1Dzf1360cELLnIGlojdt/qJQSrju9+G6vjI+hYZU71rUf4StejDLTo+5nVYhc5g7Ade9zbMR/
	t6PRxkZrMFhXWVD1m77I/2/UFeWstgPls1V1gzLNXR9hBaR6p+74AqPiY=
X-Google-Smtp-Source: AGHT+IFz1R1LxqWEGYRLYWO5W96XWnv2bqJz15jEINPSBmb87YsKZWzWOfr6fveduQ8KQij52ltnpYxHcWerkniTavs=
X-Received: by 2002:a17:903:3bce:b0:215:8232:5596 with SMTP id
 d9443c01a7336-22db218a627mr293845ad.16.1745432785574; Wed, 23 Apr 2025
 11:26:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250423031117.907681-1-almasrymina@google.com> <20250423031117.907681-8-almasrymina@google.com>
In-Reply-To: <20250423031117.907681-8-almasrymina@google.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Wed, 23 Apr 2025 11:26:14 -0700
X-Gm-Features: ATxdqUHnKDzCBYG80n4IAQ6Tqlf6P8u3mDu-47naFBmrHiwPtX2MRzVq-LrB7oQ
Message-ID: <CAEAWyHdYEzHLbW1Z=nS1yGdnbFA2HU7wb4nFZ1TmqGaUZoq9Tg@mail.gmail.com>
Subject: Re: [PATCH net-next v10 7/9] gve: add netmem TX support to GVE
 DQO-RDA mode
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 8:11=E2=80=AFPM Mina Almasry <almasrymina@google.co=
m> wrote:
>
> Use netmem_dma_*() helpers in gve_tx_dqo.c DQO-RDA paths to
> enable netmem TX support in that mode.
>
> Declare support for netmem TX in GVE DQO-RDA mode.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> v10:
> - Move setting dev->netmem_tx to right after priv is initialized
>   (Harshitha)
>
> v4:
> - New patch
> ---
>  drivers/net/ethernet/google/gve/gve_main.c   | 4 ++++
>  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 8 +++++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/eth=
ernet/google/gve/gve_main.c
> index 8aaac91013777..b49c74620799e 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -2659,12 +2659,16 @@ static int gve_probe(struct pci_dev *pdev, const =
struct pci_device_id *ent)
>         if (err)
>                 goto abort_with_wq;
>
> +       if (!gve_is_gqi(priv) && !gve_is_qpl(priv))
> +               dev->netmem_tx =3D true;
> +
>         err =3D register_netdev(dev);
>         if (err)
>                 goto abort_with_gve_init;
>
>         dev_info(&pdev->dev, "GVE version %s\n", gve_version_str);
>         dev_info(&pdev->dev, "GVE queue format %d\n", (int)priv->queue_fo=
rmat);
> +
nit: accidental extra empty line, but

Acked-by: Harshitha Ramamurthy <hramamurthy@google.com>

>         gve_clear_probe_in_progress(priv);
>         queue_work(priv->gve_wq, &priv->service_task);
>         return 0;
> diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net/e=
thernet/google/gve/gve_tx_dqo.c
> index 2eba868d80370..a27f1574a7337 100644
> --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> @@ -660,7 +660,8 @@ static int gve_tx_add_skb_no_copy_dqo(struct gve_tx_r=
ing *tx,
>                         goto err;
>
>                 dma_unmap_len_set(pkt, len[pkt->num_bufs], len);
> -               dma_unmap_addr_set(pkt, dma[pkt->num_bufs], addr);
> +               netmem_dma_unmap_addr_set(skb_frag_netmem(frag), pkt,
> +                                         dma[pkt->num_bufs], addr);
>                 ++pkt->num_bufs;
>
>                 gve_tx_fill_pkt_desc_dqo(tx, desc_idx, skb, len, addr,
> @@ -1038,8 +1039,9 @@ static void gve_unmap_packet(struct device *dev,
>         dma_unmap_single(dev, dma_unmap_addr(pkt, dma[0]),
>                          dma_unmap_len(pkt, len[0]), DMA_TO_DEVICE);
>         for (i =3D 1; i < pkt->num_bufs; i++) {
> -               dma_unmap_page(dev, dma_unmap_addr(pkt, dma[i]),
> -                              dma_unmap_len(pkt, len[i]), DMA_TO_DEVICE)=
;
> +               netmem_dma_unmap_page_attrs(dev, dma_unmap_addr(pkt, dma[=
i]),
> +                                           dma_unmap_len(pkt, len[i]),
> +                                           DMA_TO_DEVICE, 0);
>         }
>         pkt->num_bufs =3D 0;
>  }
> --
> 2.49.0.805.g082f7c87e0-goog
>
