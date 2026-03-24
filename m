Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF5237B3FD
	for <virtualization@lists.linux.dev>; Tue, 24 Mar 2026 01:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316881; cv=none; b=VKvw2sw8THLfPrOrKop63gZ35DfOO2A86HgDBnOaK3OGM8sFA6E7ut8lR75MtehzLduh3qzpy0a9hOo6IvNfbv81JQzP0eRHmuir0v+cEWzxT9KmnoQGx6PnEgxZDKYLPslG5d02BAXjP1gwa2sMCCUmCh2IVr8VLexcP81m31Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316881; c=relaxed/simple;
	bh=1L07aR3dyNbqvLj4qfcGbhsAv2cKMDPsFOknuyeD7BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npa0cLSyy2dJ5pi2WLyaCw25a3hVM4vvzhzQoG9H9Aoh0zQE2OuzfS8RUI/wR7COqB0O8h/cOxxSs64oO0LjJP/nA9kSuycx1FrKgyQWk8aej+2cnNe3c2BmffrQJO2I0YW71Ao4s6yxq20ySy+c4Mek5FQ5od42UnZOtDzkXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Er+r2EoM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Er+r2EoM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774316877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
	b=Er+r2EoMjVFxEP8ShzTzZVB1q2vwUTatyXrxzQ7w/gIKyk5Ch+kn/dvRpeFXeaF1hYsjJY
	axTWFSVQcCnH6xROvmhW+IGvk2lM9tv40figr9tpOcjmKuLHPBapcUYpl1cuaEMOZ+Q/GE
	PVsaVcCDz/NThqXhLQMRqP9urfqUis4=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-wweyaR4INim-LvFcAma9fQ-1; Mon, 23 Mar 2026 21:47:56 -0400
X-MC-Unique: wweyaR4INim-LvFcAma9fQ-1
X-Mimecast-MFC-AGG-ID: wweyaR4INim-LvFcAma9fQ_1774316875
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b06395b7a7so59756495ad.2
        for <virtualization@lists.linux.dev>; Mon, 23 Mar 2026 18:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316874; x=1774921674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7KeDh9Pakphb6ZSva9CV9D2G9FSHn5iAsu9ki0fn1BA=;
        b=MOhXDzK3L+Z1XwucIn3nZ2osvhjhxAgdfIr1wbHCketH2ukgLsl4q2zmkBT6Y2RKuB
         CiifqmdYsGzS+uy4u86BG129m2A4ZOupZ9AsfR/79ux9TnoaNBqgqJjrKDw9NfMGO6GN
         nKPRjm0kFIZRkNgYgCTMZYehmZ/coJBPKZBcjl5DZ0Kr+YNTl1NI84VViRWPDnAyFY5a
         Tm0FbCH4C0gAnrsfJGaiyhGwbrn2RzAUtOqm3qaycdRYkvHMwoXWTayIi1yxSUs5SbN4
         ntVTEIHMwE4XTYsSpg3BylEaXYteY6bsEKzuYz2WmB4rB4rh0ITpmDnRoL3PkkYhvhE6
         qg8g==
X-Forwarded-Encrypted: i=1; AJvYcCVyei4MyR5jVCJfjxIYjvwZ3ax63Vh5j48ekHNsP1HBU54stv0TkH1q3fgPTylH6QJPKjqjaCk0A0afXh/BeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwO7KcUPNGhzLn0wuWbtyvg6VPUrL0yRbHLOfLTs4grj0MrP70J
	07R+egseP3rjOmwhet3DQkuhbIFf+t1nu4oK+ZK6/6U1ezAn3JXL75IxI0sygE0wdH7G2ZiNwxC
	az+d1Fn+bXZhvRMtPi/Yu0QJnffPIjA1IdbT1mTd8oOfkRRjvbd/lQEDIp53LGlZycBYgQMTgiR
	iA2oqV1E+Q36jFTKmfn1D9gerDBxMR4zk7kjx/s0vQXLvfFx2dYQhAMA==
X-Gm-Gg: ATEYQzxjUG0RWYA7VyctLOWAnq59pGEl1xJbibB4av5G4pIVRekCEP/GlHK/HQV7b2E
	i1ZF1RTifn9ZPEuNu7tfJNCTXQMZIBOgN8T87FyrN2/ANcraMgX6tYUTqyIc6IFJ/gYYbP/pmnE
	/oVsQr+KcDEzFMlm5uih5C5jCjFwmH88MESQ6Nla5SZkGeoYOOOLLa/Lv6fxGNyhVPkfLSy0voy
	xjXvlk=
X-Received: by 2002:a17:902:e541:b0:2ae:cb0e:fd60 with SMTP id d9443c01a7336-2b08270e18fmr130322595ad.5.1774316874161;
        Mon, 23 Mar 2026 18:47:54 -0700 (PDT)
X-Received: by 2002:a17:902:e541:b0:2ae:cb0e:fd60 with SMTP id
 d9443c01a7336-2b08270e18fmr130322365ad.5.1774316873607; Mon, 23 Mar 2026
 18:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de> <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260312130639.138988-3-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Mar 2026 09:47:41 +0800
X-Gm-Features: AaiRm5055yjwQj85B9qlGmz19tgY1mSWOMYoiCzZMRlFulSK7W_m9HQa_Y7M5ps
Message-ID: <CACGkMEuea9iPKojWqa0oJQWLMrqKtF+mQ6Aqm8D1XceWe6oveA@mail.gmail.com>
Subject: Re: [PATCH net-next v8 2/4] vhost-net: wake queue of tun/tap after
 ptr_ring consume
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4ApCuLDTmSal4ganpb-AnHCGy5I0NGQZN-H8-JrUGkQ_1774316875
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 9:07=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> Add tun_wake_queue() to tun.c and export it for use by vhost-net. The
> function validates that the file belongs to a tun/tap device,
> dereferences the tun_struct under RCU, and delegates to
> __tun_wake_queue().
>
> vhost_net_buf_produce() now calls tun_wake_queue() after a successful
> batched consume of the ring to allow the netdev subqueue to be woken up.
>
> Without the corresponding queue stopping (introduced in a subsequent
> commit), this patch alone causes a slight throughput regression for a
> tap+vhost-net setup sending to a qemu VM:
> 3.948 Mpps to 3.888 Mpps (-1.5%).
>
> Details: AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU
> threads, XDP drop program active in VM, pktgen sender; Avg over
> 20 runs @ 100,000,000 packets. SRSO and spectre v2 mitigations disabled.
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c      | 21 +++++++++++++++++++++
>  drivers/vhost/net.c    | 15 +++++++++++----
>  include/linux/if_tun.h |  3 +++
>  3 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index a82d665dab5f..b86582cc6cb6 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -3760,6 +3760,27 @@ struct ptr_ring *tun_get_tx_ring(struct file *file=
)
>  }
>  EXPORT_SYMBOL_GPL(tun_get_tx_ring);
>
> +void tun_wake_queue(struct file *file)
> +{
> +       struct tun_file *tfile;
> +       struct tun_struct *tun;
> +
> +       if (file->f_op !=3D &tun_fops)
> +               return;
> +       tfile =3D file->private_data;
> +       if (!tfile)
> +               return;
> +
> +       rcu_read_lock();
> +
> +       tun =3D rcu_dereference(tfile->tun);
> +       if (tun)
> +               __tun_wake_queue(tun, tfile);
> +
> +       rcu_read_unlock();
> +}
> +EXPORT_SYMBOL_GPL(tun_wake_queue);
> +
>  module_init(tun_init);
>  module_exit(tun_cleanup);
>  MODULE_DESCRIPTION(DRV_DESCRIPTION);
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 80965181920c..c8ef804ef28c 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -176,13 +176,19 @@ static void *vhost_net_buf_consume(struct vhost_net=
_buf *rxq)
>         return ret;
>  }
>
> -static int vhost_net_buf_produce(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_produce(struct sock *sk,
> +                                struct vhost_net_virtqueue *nvq)
>  {
> +       struct file *file =3D sk->sk_socket->file;
>         struct vhost_net_buf *rxq =3D &nvq->rxq;
>
>         rxq->head =3D 0;
>         rxq->tail =3D ptr_ring_consume_batched(nvq->rx_ring, rxq->queue,
>                                               VHOST_NET_BATCH);
> +
> +       if (rxq->tail)
> +               tun_wake_queue(file);
> +
>         return rxq->tail;
>  }
>
> @@ -209,14 +215,15 @@ static int vhost_net_buf_peek_len(void *ptr)
>         return __skb_array_len_with_tag(ptr);
>  }
>
> -static int vhost_net_buf_peek(struct vhost_net_virtqueue *nvq)
> +static int vhost_net_buf_peek(struct sock *sk,
> +                             struct vhost_net_virtqueue *nvq)
>  {
>         struct vhost_net_buf *rxq =3D &nvq->rxq;
>
>         if (!vhost_net_buf_is_empty(rxq))
>                 goto out;
>
> -       if (!vhost_net_buf_produce(nvq))
> +       if (!vhost_net_buf_produce(sk, nvq))
>                 return 0;
>
>  out:
> @@ -995,7 +1002,7 @@ static int peek_head_len(struct vhost_net_virtqueue =
*rvq, struct sock *sk)
>         unsigned long flags;
>
>         if (rvq->rx_ring)
> -               return vhost_net_buf_peek(rvq);
> +               return vhost_net_buf_peek(sk, rvq);
>
>         spin_lock_irqsave(&sk->sk_receive_queue.lock, flags);
>         head =3D skb_peek(&sk->sk_receive_queue);
> diff --git a/include/linux/if_tun.h b/include/linux/if_tun.h
> index 80166eb62f41..ab3b4ebca059 100644
> --- a/include/linux/if_tun.h
> +++ b/include/linux/if_tun.h
> @@ -22,6 +22,7 @@ struct tun_msg_ctl {
>  #if defined(CONFIG_TUN) || defined(CONFIG_TUN_MODULE)
>  struct socket *tun_get_socket(struct file *);
>  struct ptr_ring *tun_get_tx_ring(struct file *file);
> +void tun_wake_queue(struct file *file);
>
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
> @@ -55,6 +56,8 @@ static inline struct ptr_ring *tun_get_tx_ring(struct f=
ile *f)
>         return ERR_PTR(-EINVAL);
>  }
>
> +static inline void tun_wake_queue(struct file *f) {}
> +
>  static inline bool tun_is_xdp_frame(void *ptr)
>  {
>         return false;
> --
> 2.43.0
>

