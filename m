Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52D2D7A8
	for <virtualization@lists.linux.dev>; Sat, 11 May 2024 03:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715398321; cv=none; b=Y/Y09CtFfAooBQ+ESjAbQh6xFtO6fT6RhIZE96t/T3TNpOEYjkKbgx8/FLSmbVQCfhxUNWcxTt2+i6VbjJbH1VeUl7As6Vgsb1DvZbdb+LgWgYklOELQX5vnFxIzSVXRSLx7wbgf1TqVYMLs8HVvKyEkWuhwP2oyTk1g2tFIEZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715398321; c=relaxed/simple;
	bh=k74GQ5uTlanNKEBqFG+YfCXARAad6aZ8GQrXlAA/Gis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxgCUfq5/rYaiPm2qpHQ+zo+KlisOwKlfBCQRvxAdDSF+zvIlknyOe5J+fQIcGTEL32o9HCyUqEM9cFOf8IhdZvTT6OwDAyFyJaQ3k7Zvqdmqm45gs5XA9IMGFwQpIBUg3AZZycDckHBuKxyi5Qj1e0OZBc7/sQtdqIvLyL6Q90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVwRHvku; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVwRHvku"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51fc01b6fe7so2792876e87.0
        for <virtualization@lists.linux.dev>; Fri, 10 May 2024 20:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715398317; x=1716003117; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bet+86JPzdUIr/52bYNt4dp7zDPRay7patpJlaTQxt4=;
        b=BVwRHvkuQnIq0HoluJZfiODJROOhqSQnLumBh/vNcWXAg8OE0OjetHspQ3pAsAI2SH
         Kq1Hm0PrEIMnqUVikkbSG7Cujvh8cWPXE8WDGXanm6BRs3M0p5vtq2msvrQ8N7U+P2yw
         a2fMxHocNv0juQPoburv1K8XZIWxcuFfaDU8D8X4EY24vugksqqNscFL4YzDIBIyH7Qb
         wZVRMUuU/jG32yZXeNTXXvlETsJKAfWdp58KiIt3mFxyaFZqDBmgb2+x4xgebhydfgfd
         ez3e/TJvnhtMpq4bNQ4/M1uVQIDki/hJoZ4zF2PdaSKUf/S52guy07RG76u40U+gQfjQ
         yOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715398317; x=1716003117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bet+86JPzdUIr/52bYNt4dp7zDPRay7patpJlaTQxt4=;
        b=d49FSnHeYZizs/TNv+w6OwI/hjrwaHFjvN8FYWf8wh7ogmZVz5KqLBp6dMhHki2x+j
         oMTlPxX7viAk8NxE0x4jbNjF85SAnEDvBIvQL4XZDTlqG+ga5mAIZrXBtjY5CfKjXBnM
         9Y9buKHlsA0iU8T/oXTqVgz0S8bocbAhy8z5qSUJHPz7S2qB4sd2dw3atvnPbkUB5iLX
         gIdMbWWxFzs8zqlE6MB7nggdEJ0ZrxCq6zLtxagklgEk5NA48/bf/aE85GavvPbXr+Qm
         DhwwXr99ynPtavJp8kTQGUiiY31LErkATrMgOIdybSa/y5IUKzFF1mq069LOuSKgw2NM
         qW+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVDAieOj9M/4XQL4/ARTxzl16NjhSn1M26twBFfXgS64RGNNA819h2l1HxUZk2QV483emOsRhkiaZSMMaqV5Bz9vbsspzaNzmUbdJ1fn8=
X-Gm-Message-State: AOJu0YyORX1LmjhqLH9AkUT96D9UAcBJHa6jEw1RBu7bJS4vMGF5gbEM
	z2mNPEnv78ArHPotmZEa4e54TyCBbNwheUz0VNhKiwmo/LVRUd4v6sFOHOi5Gab2shMt5jHC28G
	XADsPueRg1dnKAgkZ4Bs60aiNyZ8=
X-Google-Smtp-Source: AGHT+IHhRTHg5msUv+nda60P8Qu5F8FmHirX2Tw1rE8ahnYhJjqHin8GASHCvEByhmUgihzyEXlNvQ4q+Lkvlkj8nK8=
X-Received: by 2002:a05:6512:230a:b0:51c:c2c1:6f58 with SMTP id
 2adb3069b0e04-522105792e0mr3025298e87.55.1715398316715; Fri, 10 May 2024
 20:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240510201927.1821109-1-danielj@nvidia.com> <20240510201927.1821109-2-danielj@nvidia.com>
In-Reply-To: <20240510201927.1821109-2-danielj@nvidia.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 11 May 2024 11:31:19 +0800
Message-ID: <CAL+tcoB0TmcNoLdFMcfOCKGbkqAttV7UpCZf8D3TTjKwvgw7Yw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] netdev: Add queue stats for TX stop and wake
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	jiri@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 4:20=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> TX queue stop and wake are counted by some drivers.
> Support reporting these via netdev-genl queue stats.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Good to see this finally :)

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

> ---
>  Documentation/netlink/specs/netdev.yaml | 14 ++++++++++++++
>  include/net/netdev_queues.h             |  3 +++
>  include/uapi/linux/netdev.h             |  2 ++
>  net/core/netdev-genl.c                  |  4 +++-
>  tools/include/uapi/linux/netdev.h       |  2 ++
>  5 files changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 2be4b3714d17..11a32373365a 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -439,6 +439,20 @@ attribute-sets:
>            Number of the packets dropped by the device due to the transmi=
t
>            packets bitrate exceeding the device rate limit.
>          type: uint
> +      -
> +        name: tx-stop
> +        doc: |
> +          Number of times driver paused accepting new tx packets
> +          from the stack to this queue, because the queue was full.
> +          Note that if BQL is supported and enabled on the device
> +          the networking stack will avoid queuing a lot of data at once.
> +        type: uint
> +      -
> +        name: tx-wake
> +        doc: |
> +          Number of times driver re-started accepting send
> +          requests to this queue from the stack.
> +        type: uint
>
>  operations:
>    list:
> diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> index e7b84f018cee..a8a7e48dfa6c 100644
> --- a/include/net/netdev_queues.h
> +++ b/include/net/netdev_queues.h
> @@ -41,6 +41,9 @@ struct netdev_queue_stats_tx {
>         u64 hw_gso_wire_bytes;
>
>         u64 hw_drop_ratelimits;
> +
> +       u64 stop;
> +       u64 wake;
>  };
>
>  /**
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index cf24f1d9adf8..a8188202413e 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -165,6 +165,8 @@ enum {
>         NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
>         NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
>         NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
> +       NETDEV_A_QSTATS_TX_STOP,
> +       NETDEV_A_QSTATS_TX_WAKE,
>
>         __NETDEV_A_QSTATS_MAX,
>         NETDEV_A_QSTATS_MAX =3D (__NETDEV_A_QSTATS_MAX - 1)
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 4b5054087309..1f6ae6379e0f 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -517,7 +517,9 @@ netdev_nl_stats_write_tx(struct sk_buff *rsp, struct =
netdev_queue_stats_tx *tx)
>             netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_BYTES, tx->hw_=
gso_bytes) ||
>             netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS, =
tx->hw_gso_wire_packets) ||
>             netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES, tx=
->hw_gso_wire_bytes) ||
> -           netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, t=
x->hw_drop_ratelimits))
> +           netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS, t=
x->hw_drop_ratelimits) ||
> +           netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_STOP, tx->stop) ||
> +           netdev_stat_put(rsp, NETDEV_A_QSTATS_TX_WAKE, tx->wake))
>                 return -EMSGSIZE;
>         return 0;
>  }
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux=
/netdev.h
> index cf24f1d9adf8..a8188202413e 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -165,6 +165,8 @@ enum {
>         NETDEV_A_QSTATS_TX_HW_GSO_WIRE_PACKETS,
>         NETDEV_A_QSTATS_TX_HW_GSO_WIRE_BYTES,
>         NETDEV_A_QSTATS_TX_HW_DROP_RATELIMITS,
> +       NETDEV_A_QSTATS_TX_STOP,
> +       NETDEV_A_QSTATS_TX_WAKE,
>
>         __NETDEV_A_QSTATS_MAX,
>         NETDEV_A_QSTATS_MAX =3D (__NETDEV_A_QSTATS_MAX - 1)
> --
> 2.45.0
>
>
