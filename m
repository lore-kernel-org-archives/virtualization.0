Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0E832A3C8
	for <virtualization@lists.linux.dev>; Sat, 28 Feb 2026 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259431; cv=pass; b=fydRrgnVZOfOU/GVMcCP5ANBeb2omxHXQyIYDh8YAzyiSZFn2VcMJfN62lsQ8x1A89/06Jwr2+Y5MHYqFw+qvMcQ+wSSAzKFQVswWzhirAS3mI7fdusDh8cgqp2p5AKAnyhO5bHUYhdpiG4A7EYzDtsUP9HtmM4XzGrsA/HtB5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259431; c=relaxed/simple;
	bh=Pkpj4HbkFMotK8I4xPmcAoR30bgwmypSjnl8MO59Eug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHPGTCp39QGgROTjSc8zdzTqG1ZNzlPt7sltX9qHpTQKcsXTWBZjPf+X2BVgHzD8i6VYR54tNpdbL7v+2DPuJjYp/ubkKjMnnmL671XMzi6qmlyA5rZx8V1XduuSs8PcY3fOiqIANlDxd/OPlgFwiVmUEuBiaSTMCeHR8gYXpXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5zhtgGe; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5zhtgGe"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-389e139ee5eso37751841fa.0
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 22:17:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772259429; cv=none;
        d=google.com; s=arc-20240605;
        b=Zntes1Po9YycLisMeCEhD31BdDdv1lKW3hrXO4fa0XsJx2ECmJluj31jjgwGBLb1Fi
         aPqgHsscuP1LBXfLOiHvdrnIyps/USjOIMspXLoQjAATLhznHYpWQtLPfUzqLzfGjrr/
         4TCYXpI4RMDpNoFKQs9TW2fulJ9TSJTxB6aWm6KodoNXBdfzWT1QJyxka6J9vNtLNLlW
         yIrfo9g4XLByl6p65mM5XouETulWH78XgRxXzqUL9zzijT9tSvoDFiA4mApibrZORTKS
         ybzvupQNazFTlo6xRD0kj8ZSDjP7AUfaJX/bGlJdAxu7oKYYurWGaa4fENUGi2EkPd3d
         4cGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oeRlvqpds2atM/soIMS81zbOQD/yUki0VXg5EGmEj1A=;
        fh=KY8go6fkB8uRuhcKczZcHbXW5Ng6BPcAi/vA1i8nG60=;
        b=byAUVbY+OWzkeKloRAQ3YjxXwBSTCBawWo2vQtNC3LRi5bEKJn14QV/ViPSFuNDOKe
         ERC74zixegurKwcOE9x6fvuA4A454EihratR+d/yhiaber2S+E/j+inBD0AesH5FuUtG
         J1mFBjwtYUlo7j9GbVQ+jx8sYWsscSdauWk1Mki3IKDc9rEM7Qpoar5dPUs7cSbPeVcc
         zCnoMK5Cm28cLIZ3BdVOX7cS/rABW6gDHvV/wZsaruak2cwSPlVBtAT4WH/YYJwHriis
         eSQP2UN6ZEDVYCOGUyRvlKoC2EENQxzCoe+2ka8cIyv+AXKRQvcoMUjrT/pvZCsT+ftl
         8AiA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772259429; x=1772864229; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oeRlvqpds2atM/soIMS81zbOQD/yUki0VXg5EGmEj1A=;
        b=I5zhtgGeoILsnBhOTG31S5uKMJokfMJ0dtYTId+EtETBkq7vhEfhSC5/S6bNVUSEPN
         5qKqWeNB6PbqNZh7az5Dt7R9rfpEPugEe8X/27X+bwBUfQq1DYx6jvsBvsPbQ36g6FGj
         oUoPC08nbGoUqFOHycVMZf3NYUCgfPRB+iznlaKvCDLDZ9NpI8eXjWfjk9Bp3op/Xlwq
         apa/7SCAfuvwrTo4Ka7N16JlO+TPdFXmKFQyniEf3E9vuXHDJ1grTDdYfy4w62Uj9Z+8
         y3mW0H/Rk5Jyhr16k1MSIh0Tx1CyDq+LP1N92KHouAzZokyfrKRZWphkWguhsKf3JqIL
         JfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772259429; x=1772864229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oeRlvqpds2atM/soIMS81zbOQD/yUki0VXg5EGmEj1A=;
        b=qV6teMY3/oekJG4sOPC+Bntv3MfJqM6IJWtJJZItKaR1lpSL0uMgxA/ewm4tH3IYnq
         vgk9jYG3knh5kyaybuyoO4bkmkHFtkd8WVt244c3Dr58B7AAlwRim0oEbSOdBmfSTtgW
         /BelDWAhnwUxrIHN6ExUW1EfGyqmXRv68ysnNKNdWQU+kJfMXZB55RlaJzTmkOD6WxzB
         LGSgpByD7i3ivTAt2Eyn8RBI4Jbg4NFMgFmoqGPTf6734P1lp5bky5J/6LwsUV7UdkkE
         IJYVB53np3SJY6O1BkEoDTpkfkfTLoMIgQvVjo9i5Jb9g5rh4OESpbK+R7LW5xLsh08v
         8YHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVx9UNpgHNpgaNvdzkvnMbTwErKQ1NOX1P7GoWumzKBsSDg4pdwg3OVwCfSjAvtG/bix8cHQ6mvaTj/Tg+IA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZi1AvO5iGdN8nExaH26NwB2EwrP2lLrlNZdcaWwXLVG9nqzqZ
	pGQuTd/huu5BbL2MrYYUJIj9MoOU5UMtbgjMUYP4NcSCt4KI/AX4Qp7pOITfmG6tzdcLHfmpF64
	BKQzCT078lan0NnON6X1ldfsSlqSyNyo=
X-Gm-Gg: ATEYQzx5UiuXGXeHLee9mRITnOlN9hrvVnmosc9ZY3mbuEIqmxWXp8E5Pgd1c18dOJU
	yoWB2tNtKIdI7GSBGAYRBvjaFUt4BSfYYbV3AvZbqFLA3QLfUYFTikawKNysWp7YVJucvuE+4ET
	NQQxvpE1J3Eoo250rwdIM+jCrH1G5p1knW2hO/p0j3bbZSBbECwn7hX7l2oohiFHd7ZLqMbRqVV
	iLlJoIZf79dBg2t/sxtGd4v8+4F1B7Fvw3MEE5BF2NFlRiyWWJJ1ql/njt16YlH+vcfbv7G+D5E
	LFZgR7Ly
X-Received: by 2002:a2e:9e81:0:b0:383:1d89:8d0c with SMTP id
 38308e7fff4ca-389ff137ea1mr28249491fa.15.1772259428376; Fri, 27 Feb 2026
 22:17:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260227150949.13089-1-minhquangbui99@gmail.com>
 <CAL+tcoBdEQ0jhRCqpC8zoc+yLBYdYvLgBzF5Ov2284a87UM-UQ@mail.gmail.com> <43b3b8dc-bc99-497a-a845-a9697c126d3f@gmail.com>
In-Reply-To: <43b3b8dc-bc99-497a-a845-a9697c126d3f@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 28 Feb 2026 14:16:30 +0800
X-Gm-Features: AaiRm50hAty-9UFJICMMw6r0XvXAs1z_2STWM9epUEykww4BmxZrz84SC04ahM4
Message-ID: <CAL+tcoAy7YjkODWp=nCagEJwOzhqt_BL4kcfxpj=FSiAXP_+qg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: xsk: Support wakeup on RX side
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 28, 2026 at 1:03=E2=80=AFPM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> Hi Jason,
>
> On 2/28/26 10:49, Jason Xing wrote:
> > Hi Bui,
> >
> > On Fri, Feb 27, 2026 at 11:20=E2=80=AFPM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buff=
er
> >> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> >> wasting CPU cycles on polling. Users will be notified and they need to
> >> make a wakeup call after refilling the ring.
> >>
> >> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >> ---
> >>   drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
> >>   1 file changed, 30 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >> index db88dcaefb20..494acc904b2c 100644
> >> --- a/drivers/net/virtio_net.c
> >> +++ b/drivers/net/virtio_net.c
> >> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtn=
et_info *vi, struct receive_queue
> >>          xsk_buffs =3D rq->xsk_buffs;
> >>
> >>          num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_fre=
e);
> >> -       if (!num)
> >> +       if (!num) {
> >> +               if (xsk_uses_need_wakeup(pool)) {
> >> +                       xsk_set_rx_need_wakeup(pool);
> >> +                       /* Return 0 instead of -ENOMEM so that NAPI is
> >> +                        * descheduled.
> >> +                        */
> >> +                       return 0;
> >> +               }
> >> +
> >>                  return -ENOMEM;
> >> +       } else {
> >> +               xsk_clear_rx_need_wakeup(pool);
> >> +       }
> >>
> >>          len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> >>
> >> @@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue=
 *sq, struct xsk_buff_pool *pool,
> >>          return sent;
> >>   }
> >>
> >> -static void xsk_wakeup(struct send_queue *sq)
> >> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq=
)
> >>   {
> >> -       if (napi_if_scheduled_mark_missed(&sq->napi))
> >> +       if (napi_if_scheduled_mark_missed(napi))
> >>                  return;
> >>
> >>          local_bh_disable();
> >> -       virtqueue_napi_schedule(&sq->napi, sq->vq);
> >> +       virtqueue_napi_schedule(napi, vq);
> >>          local_bh_enable();
> >>   }
> >>
> >>   static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 f=
lag)
> >>   {
> >>          struct virtnet_info *vi =3D netdev_priv(dev);
> >> -       struct send_queue *sq;
> >> +       struct napi_struct *napi;
> >> +       struct virtqueue *vq;
> >>
> >>          if (!netif_running(dev))
> >>                  return -ENETDOWN;
> >> @@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device=
 *dev, u32 qid, u32 flag)
> >>          if (qid >=3D vi->curr_queue_pairs)
> >>                  return -EINVAL;
> >>
> >> -       sq =3D &vi->sq[qid];
> >> +       if (flag =3D=3D XDP_WAKEUP_TX) {
> > Better use &?
>
> Sorry, I don't get your point. Can you elaborate more?

Oh, I meant using 'flag & XDP_WAKEUP_TX' is preferrable. IIUC, since
this patch provides a way to enable the RX flag, for virtio_net, this
flag can be set by TX and RX altogether? Please see this call trace:
xsk_poll()->xsk_wakeup(xs, pool->cached_need_wakeup).

Thanks,
Jason
