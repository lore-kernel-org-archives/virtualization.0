Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF6A28C2BF
	for <virtualization@lists.linux.dev>; Thu,  8 Jan 2026 04:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847077; cv=none; b=UP/BHcbxkpB4Q/KUaAimo4qS/dIfDAEWsSgawaWLVBRq14MmkzSeBJAwkinrB8Ls8BYhfu1a20ultmZA3mdvw5DMCg8XYXPZSd/1VgSC951uE07I+VfvI25SsAAbPFRwejFUO5MpGuenIRULjfYTDFsUhj+uoX7nF2CEVnJ2E3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847077; c=relaxed/simple;
	bh=EHUBmEarbkqeknUga6s29EH7ucSXyuJH72yRaZDXOAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lo8EZcNHJNPeapmglHptqS0iOq8aShiUvQ3wTIZoarR5NS2rl8anwrsQ6k6UAJXr6L2RJZwdUQ3/IT3F6xjLsu7/NDJkoYTyEErM/+SS/hBUdX2hqv2EZQw99BIx9tE3Sh9WDXiDgzSNfWN6T/QoKW/QQn/ks8M1H/fu2+x77wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZVXjUO8P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZVXjUO8P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767847074;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nGJJ3mghZGQyoRGajBObKXNhhk9ab2WcIcydiR3jcw4=;
	b=ZVXjUO8PVn8FmelaUsOCcHfbJQBS6PYPrE3aLDfrAMSilKx6WisRlUp4ZLq0KZj8xP6azi
	COSa3bFGzkjfRqR0PPswqCwhozftBdlclgmDr/ZH5BbwCLzpZqjnx0OMM1eg6BoDdcJr2+
	cCJ69omyEUqvXrqghiUqAge+K7kHgJo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-mzj7XGFIM26x-c04d__7Yg-1; Wed, 07 Jan 2026 23:37:52 -0500
X-MC-Unique: mzj7XGFIM26x-c04d__7Yg-1
X-Mimecast-MFC-AGG-ID: mzj7XGFIM26x-c04d__7Yg_1767847072
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34c704d5d15so4824316a91.1
        for <virtualization@lists.linux.dev>; Wed, 07 Jan 2026 20:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767847072; x=1768451872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nGJJ3mghZGQyoRGajBObKXNhhk9ab2WcIcydiR3jcw4=;
        b=E1z8WG4nIj8Rb+w9SynMpSwrkMZyPdgedte+iJGRlPxA3QwirmlzOU7KhXcVRJW3RS
         pHSXh/dtlyCblK3R46pKEniI/+ffLXg7kwjNNpCO23XFIA5Yfk6S82mUMWKnR1iIhfQz
         LSVyzw65nwClmYW+mR2TxQvdb0/NZ12f6tjeQTZly25kKf2I1sojsWudP5Cv2ofrOxP0
         +Qg9XRpYqc6d4LT9y395AM+cRucuZff9XFndEyEDcZSzQzuZAaPdveyvr7MdZeE3wqGv
         t9Hs9FAdkEIUpJfpkOL2ukVJVVlDL3vMjIQ95nH5HZQlATVR8/QyxoRN6KkLQNX93Hmt
         Hn+w==
X-Forwarded-Encrypted: i=1; AJvYcCXgfYDDlXae6sLPZvlvybxWeg0BuaTQfdEMiQM5Cw/8uh/q2+TPLKRohzBUEYlO4JQHedGs0NCbKuT5YMW5aw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzaVwbZiDGxtanhJxNmg2KKhoo09utA9AkDfe8JQxtV1N8GCBDx
	IZ8gUms5SVNp7q3/MavoDRdovK+qZul33QbEAbdI3lYMgm7jCSHTVYK04CgeBWkqOmXpBYPavUF
	hmYD+WFo45bAbvlyA0TsCxSQrjTXnxbzdzY7qZjTx2cpUgqrvhLdjQlFT9P50UPu3SjKXf2l1HU
	GHrb+NUx/sN3b771nist0FZHJCzYdxKQ+df94/zJmT/SY=
X-Gm-Gg: AY/fxX5vzhUnah36/LcxSQml4hSQZDpSF8KDSyvB44yr8ipP8MPIazJRyap6gZzS6NU
	UyFZU1yt+pzB0AU7hLk9PIV9iguQLpALhiKfC6KfkrOhldypi/ZZ1HqZMBPzs/CVtkwtyWLzh+l
	PX9DEsCujDYSVE0a4Nh7hbx64wtiI2LOJPhdpDT2t3WpY7zicT+rIn93ep2jwv90I=
X-Received: by 2002:a17:90b:560b:b0:349:7fc6:18 with SMTP id 98e67ed59e1d1-34f68b9a22fmr4745627a91.13.1767847071688;
        Wed, 07 Jan 2026 20:37:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECns7jouA7f2VNHsoSXSn1GwNS9wwLb0mzRo21rU5B9H5vGzwBZRLYUrbrNqFBS4uDGJcoRqYkbR+MEJG9hv8=
X-Received: by 2002:a17:90b:560b:b0:349:7fc6:18 with SMTP id
 98e67ed59e1d1-34f68b9a22fmr4745605a91.13.1767847071303; Wed, 07 Jan 2026
 20:37:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260107210448.37851-1-simon.schippers@tu-dortmund.de> <20260107210448.37851-10-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260107210448.37851-10-simon.schippers@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Jan 2026 12:37:39 +0800
X-Gm-Features: AQt7F2qCw4tSinw_uRQv6jndxzlecHSCxyFfKRavPy7gsUnUcdmHs2F5zxEB4h4
Message-ID: <CACGkMEuQikCsHn9cdhVxxHbjKAyW288SPNxAyXQ7FWNxd7Qenw@mail.gmail.com>
Subject: Re: [PATCH net-next v7 9/9] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when qdisc is present
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, leiyang@redhat.com, 
	stephen@networkplumber.org, jon@nutanix.com, tim.gebauer@tu-dortmund.de, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zETnVE_pIFofBRXUXsBIMR0U_LgZRjx3sJ3269XSKi4_1767847072
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 5:06=E2=80=AFAM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> This commit prevents tail-drop when a qdisc is present and the ptr_ring
> becomes full. Once an entry is successfully produced and the ptr_ring
> reaches capacity, the netdev queue is stopped instead of dropping
> subsequent packets.
>
> If producing an entry fails anyways, the tun_net_xmit returns
> NETDEV_TX_BUSY, again avoiding a drop. Such failures are expected because
> LLTX is enabled and the transmit path operates without the usual locking.
> As a result, concurrent calls to tun_net_xmit() are not prevented.
>
> The existing __{tun,tap}_ring_consume functions free space in the
> ptr_ring and wake the netdev queue. Races between this wakeup and the
> queue-stop logic could leave the queue stopped indefinitely. To prevent
> this, a memory barrier is enforced (as discussed in a similar
> implementation in [1]), followed by a recheck that wakes the queue if
> space is already available.
>
> If no qdisc is present, the previous tail-drop behavior is preserved.
>
> +-------------------------+-----------+---------------+----------------+
> | pktgen benchmarks to    | Stock     | Patched with  | Patched with   |
> | Debian VM, i5 6300HQ,   |           | noqueue qdisc | fq_codel qdisc |
> | 10M packets             |           |               |                |
> +-----------+-------------+-----------+---------------+----------------+
> | TAP       | Transmitted | 196 Kpps  | 195 Kpps      | 185 Kpps       |
> |           +-------------+-----------+---------------+----------------+
> |           | Lost        | 1618 Kpps | 1556 Kpps     | 0              |
> +-----------+-------------+-----------+---------------+----------------+
> | TAP       | Transmitted | 577 Kpps  | 582 Kpps      | 578 Kpps       |
> |  +        +-------------+-----------+---------------+----------------+
> | vhost-net | Lost        | 1170 Kpps | 1109 Kpps     | 0              |
> +-----------+-------------+-----------+---------------+----------------+
>
> [1] Link: https://lore.kernel.org/all/20250424085358.75d817ae@kernel.org/
>
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  drivers/net/tun.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
> index 71b6981d07d7..74d7fd09e9ba 100644
> --- a/drivers/net/tun.c
> +++ b/drivers/net/tun.c
> @@ -1008,6 +1008,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb=
, struct net_device *dev)
>         struct netdev_queue *queue;
>         struct tun_file *tfile;
>         int len =3D skb->len;
> +       bool qdisc_present;
> +       int ret;
>
>         rcu_read_lock();
>         tfile =3D rcu_dereference(tun->tfiles[txq]);
> @@ -1060,13 +1062,38 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *s=
kb, struct net_device *dev)
>
>         nf_reset_ct(skb);
>
> -       if (ptr_ring_produce(&tfile->tx_ring, skb)) {
> +       queue =3D netdev_get_tx_queue(dev, txq);
> +       qdisc_present =3D !qdisc_txq_has_no_queue(queue);
> +
> +       spin_lock(&tfile->tx_ring.producer_lock);
> +       ret =3D __ptr_ring_produce(&tfile->tx_ring, skb);
> +       if (__ptr_ring_produce_peek(&tfile->tx_ring) && qdisc_present) {
> +               netif_tx_stop_queue(queue);
> +               /* Avoid races with queue wake-up in
> +                * __{tun,tap}_ring_consume by waking if space is
> +                * available in a re-check.
> +                * The barrier makes sure that the stop is visible before
> +                * we re-check.
> +                */
> +               smp_mb__after_atomic();
> +               if (!__ptr_ring_produce_peek(&tfile->tx_ring))
> +                       netif_tx_wake_queue(queue);

I'm not sure I will get here, but I think those should be moved to the
following if(ret) check. If __ptr_ring_produce() succeed, there's no
need to bother with those queue stop/wake logic?

> +       }
> +       spin_unlock(&tfile->tx_ring.producer_lock);
> +
> +       if (ret) {
> +               /* If a qdisc is attached to our virtual device,
> +                * returning NETDEV_TX_BUSY is allowed.
> +                */
> +               if (qdisc_present) {
> +                       rcu_read_unlock();
> +                       return NETDEV_TX_BUSY;
> +               }
>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
>                 goto drop;
>         }
>
>         /* dev->lltx requires to do our own update of trans_start */
> -       queue =3D netdev_get_tx_queue(dev, txq);
>         txq_trans_cond_update(queue);
>
>         /* Notify and wake up reader process */
> --
> 2.43.0
>

Thanks

