Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4560733F363
	for <virtualization@lists.linux.dev>; Sat, 28 Feb 2026 03:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250589; cv=pass; b=WLqAYeyKXx2IwbX0T7nLXn2CA7Osdv2PVV9qOuLB2tl7g//F5pqTQoZQGQMI/vM9Ta7nyeatklVL5fqs56URJ/D6M6ufElTEOyjpgnL0WHwQQIVmjGXJlRUlmm4D6PJVSewz2yNBwbNaK2RI9QV+mo/x2l0Jgs+EMP0yScUmVBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250589; c=relaxed/simple;
	bh=EZa1kh9CK62/JXDCFyKF5ToCVB0A/vBhHQIAYBb+sew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A9L5K0JBszMjrSSFfAmEoaDqgGL4RzdV+2KyrcmFKdfdGJLQgTsvvuQeJYxdoU1RspTd8xsXPzj+S3hZzw5kOv1DiHx8Rb/mgEoFc8v+cS1XFxlkd/hdVkDQqowHwkxqvSmMFjoo2qE51HE3TvcnL6qu9VxPHtVSJTqbpSKJJJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJbtUAfn; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJbtUAfn"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38700168abaso37808511fa.3
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 19:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772250585; cv=none;
        d=google.com; s=arc-20240605;
        b=DxG9rKh/g8Yc+WDbEPD0lBjYwKjIghnPlfjFhjbsbP8g+k8pW4fju/cEGd/FFTqONH
         zyfrObmUhuUSDM7/jXlSzsb8l7BtYkzPNxwTL59H+/zoNG/9grlbEFPCmN8Ht+nM1fWC
         oknSWDI6VTbbbunWXB1MYxJ9PXK8/mLXUpb4fHASz/kwH/3Lsd667wkvqtlfUUK5FlUQ
         KhKMO1rPpFA8r3N7+9lNc+sujrCLA1woLK9pGiLv6NQ7ULsn/98qRioHg78mckoh0/Np
         w7NG8eBMJs9lS3CBtk7eRUQmigNjEh8n5DilgVu/AK27WAKzglX/BFohzc0Xtsuc6jAk
         PbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h+azeatVE+bg9NQS0j4OQgTTv+mlTqhdyDYGxIesJN4=;
        fh=76CTS/3S7n3iUgl5o4WFxAkaJvy8wIwSylwDLtTyvtI=;
        b=CgzjWK+pd8IUSxHddGDn1GeXX8QVcCRcgi33HTuVGNmFAGc61F4+DxeTEXJITGSxSu
         J26rFzKkeYve1ehlheS7s1hHJa+QQnosMtCfnnTS1wRyb+zu7DJcszHZ7Wy015nMHfYH
         OWKGA+142WOV0ZJlhNZhBBgTDnEo5ckMrtucdqqlCQwkyXbGmf+3XmCHiU7bl+yLqmHB
         QExfWjiv0BVtfGHxAaA78TYFT1GtWF+hNfjHSsaPePe9T7GQugDQA6gM3ctI1BWL4zUA
         nhKPgWzcOTWWjly2tmOXH5VqNjyjc/QlR5FmH3V32oc6YyrCwCLm7MjKdr45HFdh9GgX
         M0Qg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772250585; x=1772855385; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+azeatVE+bg9NQS0j4OQgTTv+mlTqhdyDYGxIesJN4=;
        b=RJbtUAfnLAu1ykAM3Dvj9Vmxy1yc/uuTfm+6HpgNLpg8HZegC7Xp63uA7gfKB7vNTk
         9jyF+gJiYL9d1XrAfH0cdng5VboDmhFZNIZBCK4jxuMD+U9RWoQIhrsjAwjw2cog1FPj
         4ZKdDDJvYyJ5x8wCwrCWuOP0y4+9sKmao/DOEuQdX/UJ56JWbZf20r30IUEvKL6vBNcL
         SOhoDlzz/1sEe2jia1WQ6UBmTVAiiL/+tMUOAuCuS03fkjnl5inXOXVbBzd2TuSugH4p
         FM283hbOeESYRmsIlLbzoV4j4tqUkIyymNYbbyPOQAmNxmcSwO/7NDpbG/wZGo9F5pwZ
         2Xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772250585; x=1772855385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+azeatVE+bg9NQS0j4OQgTTv+mlTqhdyDYGxIesJN4=;
        b=dgmSbKnJgWdC/v8xaX7sgYMUHiKvJ8FrYAUcaCuQqC+nccpJ/XEKqwhF9xqZsoGEDX
         6FznuS+duEF1bZ4nioJXGFsrqmx6zwNOlecHa1RG7kOZbnVZ5V4jgQ5YbmZNpq2u4cIA
         bSRN5toqHVyx6jAUv78HMGqRqLjro6q2tt1PUFmWkNEciu//A9ggOX+PHCMoqa72NIiv
         U/4e1TXgf1ctUcylHTzTdEdg2g+MUhJDsQzPLGGHGy3BL/KBKTyUCtC5vTjPyGRRXpPo
         W1r9ROjcaHBEKhOBFdPFjygVOaA6Dcu5to/YeW3WOKUOuqHW2xaCVCo7JB0NHqG+taDK
         OUYg==
X-Forwarded-Encrypted: i=1; AJvYcCXSIk1w3qKigs9osFECCA8apRLSRYoJsBmSc0/KJHcytKFU/lm6tvPbPyOmgzlTngBAU/feNJ4woxXGi2Y6OA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtIVVW1d1XTKpIsHy9Joqn+O3YDMWPQ1kr0dXO6eraoSMhLHeR
	UM755SEbQyW6pDOMux8JEOC/tRLpospc8YfyL70/8CAH8cbeHwJa95Ik7jKhkI/sqvs5vQRoRLB
	P2CDUoc34E/iJLBWu4iCMqd9OHzWl78k=
X-Gm-Gg: ATEYQzyQp2mCaCBHhRNP622X1qrDsBjJl+bpwc17MMTmTS0Hrg6oaxAM7dfmLwSpgu/
	jjpY1oxWV9UdjrWt8zISV8mqXjBoUsR5WWd0M5k/3BncVU8SHqb9FDRSorxlYP30u/2KdywUAR2
	4DjTluMxbof0FQP5RgeWB3FuvmeoQxamEToNXGMjtXivdnNSlap8YvYP/wo8xpGAVown7z5VfXk
	hq1pf55R8VUCJdcJiPvqYRavw65nQIfGiZochd5K2S0Mm2TbpK1ZXBcsN0KHhqAL+G8ib8N+EIP
	oHWMWYMD
X-Received: by 2002:a05:651c:110e:b0:383:1d66:c204 with SMTP id
 38308e7fff4ca-389ff36cf14mr26540711fa.38.1772250584982; Fri, 27 Feb 2026
 19:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260227150949.13089-1-minhquangbui99@gmail.com>
In-Reply-To: <20260227150949.13089-1-minhquangbui99@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 28 Feb 2026 11:49:07 +0800
X-Gm-Features: AaiRm51f6hsgSdx76tSMlynHg4HKsjuSluFAz0ck0AkuBIp6rEBeo71YUrgL5A8
Message-ID: <CAL+tcoBdEQ0jhRCqpC8zoc+yLBYdYvLgBzF5Ov2284a87UM-UQ@mail.gmail.com>
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

Hi Bui,

On Fri, Feb 27, 2026 at 11:20=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
> wasting CPU cycles on polling. Users will be notified and they need to
> make a wakeup call after refilling the ring.
>
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index db88dcaefb20..494acc904b2c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_=
info *vi, struct receive_queue
>         xsk_buffs =3D rq->xsk_buffs;
>
>         num =3D xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
> -       if (!num)
> +       if (!num) {
> +               if (xsk_uses_need_wakeup(pool)) {
> +                       xsk_set_rx_need_wakeup(pool);
> +                       /* Return 0 instead of -ENOMEM so that NAPI is
> +                        * descheduled.
> +                        */
> +                       return 0;
> +               }
> +
>                 return -ENOMEM;
> +       } else {
> +               xsk_clear_rx_need_wakeup(pool);
> +       }
>
>         len =3D xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>
> @@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue *s=
q, struct xsk_buff_pool *pool,
>         return sent;
>  }
>
> -static void xsk_wakeup(struct send_queue *sq)
> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>  {
> -       if (napi_if_scheduled_mark_missed(&sq->napi))
> +       if (napi_if_scheduled_mark_missed(napi))
>                 return;
>
>         local_bh_disable();
> -       virtqueue_napi_schedule(&sq->napi, sq->vq);
> +       virtqueue_napi_schedule(napi, vq);
>         local_bh_enable();
>  }
>
>  static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>  {
>         struct virtnet_info *vi =3D netdev_priv(dev);
> -       struct send_queue *sq;
> +       struct napi_struct *napi;
> +       struct virtqueue *vq;
>
>         if (!netif_running(dev))
>                 return -ENETDOWN;
> @@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device *d=
ev, u32 qid, u32 flag)
>         if (qid >=3D vi->curr_queue_pairs)
>                 return -EINVAL;
>
> -       sq =3D &vi->sq[qid];
> +       if (flag =3D=3D XDP_WAKEUP_TX) {

Better use &?

Thanks,
Jason
