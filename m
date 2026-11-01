Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793545952;
	b=Rs9b6b6R/hyN+IhsgzU0xQVw6H0167weJ1MiYXPlveWx4U0t7Yv6E5VoNlZqk7AGGiLF
	 6//l+fJqc9b5L39QpUk5v2ZD0HbtASrJVBKxYUUO8z5kwKLdjfvDTsRrKkkRr9Xl9+63n
	 3ElbH6TJK5lu6pZzK4uzakR+ggJJnVjux9d3ckvE6OafCizKEW9fZXWKbBDrHGtg/Nhx0
	 waw27It/Rf7N59SWjm+qFanDwW/IzQ44vqh/C1gscTOiOX1KeCtkX2uGd8QrLSWJqV01E
	 wTNSyo3J+EVxWBcoUqoQwQny+z91YxtcGfAJDhJJi6GHytN681ka7X5QrigKx1FIemg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793545952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=all53W212qfVQZxgrADCjlSx0QnufdCZT2b108/WkDY=;
	b=z1FHSp756BRd8zwnsMA8oZSUE5uhMjsAz/w6eSJYYSD7/97JhGaKG9YR22xAnpNH6XWj
	 4QsOnBJxeSWaYXbBnToTs/F6Ndu7WJ13HbOlZmEAZ5dd8cQgcl9T7QojJMciYwQYr8FM9
	 XoKTp5gTnSSDiJS8dHqobUqI8QBIj/dOcDwr6e8TGow45ogG1WMx/ERsBplcf+wHD0Vsv
	 RECpg7NbQ1xs/xNnXtqlmR7HgwPWKZaYCgg90ewiWmygLd1DgbR3G3xTRwqSIDaqvsbbf
	 htrwousGbAPazFMbhWO0MpT2yv79ZjOPERRUiS+7PcMRvva/k0VHFpdKiSLQuY4Mh+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sar5omN0;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B0606A327
	for <virtualization@lists.linux.dev>; Sun,  1 Nov 2026 15:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 974B0606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sar5omN0
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1379509e0c.0
        for <virtualization@lists.linux.dev>; Sun, 01 Nov 2026 07:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793545951; x=1794150751; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=all53W212qfVQZxgrADCjlSx0QnufdCZT2b108/WkDY=;
        b=sar5omN0gQ65rvLmtfUsdT+f7uBZE1gpunkntY21JUdeFMYZ3M52JDlcZrHXdlNW1v
         BLxYA4lmzPJYQYOES2Iisfy087tnY5cs3zwC+y54DEinCd+Bj8aixte3j+2FRikKzGaM
         GxqOs8gRvRvveV9t80i44Br+0D+/jCPSur580HtMedlyc5DBqDO8RAAYUJ1Z5A4UeMpK
         358dP+MybCh+FmqCfRsetgSG/r+Z5kXmYEctoTFDmVyeR/Ik19qDRmXp1/J4Yu2IkMMd
         R/dPhiThj6+HGHEKTcSLObh/K8rqbenvjcWXGTb6XkdaVQBD+YrLHLP+JKKnY15H4QBd
         emSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793545951; x=1794150751;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=all53W212qfVQZxgrADCjlSx0QnufdCZT2b108/WkDY=;
        b=TgP77EYUaUcxcnyRV81Raf+veL42+7gtGZtkp8wEa/Z/Z6++881o5D/P+4cf7l6b09
         QMptOaFURCfRmpB72TU9H90+piEfifoP7EBAsMRrqBXh5elpEjU3G02G3B/ayxHuZOW/
         vkJRkI3YleN1aoYeUSpaLcvf0QhSQlY1OZrxVBYb1PNEyulKqPk09JZnbcK+3Raqp8dw
         i8Vhe8kkUOAaywVm9BuGDVhDTOiThD/o36QJkfraA0vHLPVcmJ/1sqQnH4dzRSCbLvQk
         1FeX1pDMhlL7lj8hNYMyz64hx+8HnWm7kTbN80hX8Nh8QIbTdPuVEmZoUg7WlYmgk28Q
         8hAQ==
X-Forwarded-Encrypted: i=1; AKwUvBz19CndPF3tSwBaM9LYPpvC55PMzG6z407GOu1xAO4PmLD8p43TUXeFc+oiPcfAeUsXUvwTLkH4NWoZFDEWMA==@lists.linux.dev
X-Gm-Message-State: AFq9FYL4SmsK4LViCvV5QpK4wyOVMKys96sKI12K00/dAQUWGBsN2Kb2
	ZegtujaNN6DBeLLkR5aJLRJlGiC7kCjixtk7j6zcI6Bm3vJTnKhva+vY
X-Gm-Gg: AYBFou2foXQof46x8u79ElxjAqJRcP6+RbmzB5SEkL5PQNNmT4GT9EKWLztHVJ1tJ7C
	EvQRvI0FrPxgEj6ZnA8z34b3dqteCRs/3+Gii32Z0iuIpIhPG4NhkqZ8p+PobVcP5lbVHidaFJU
	+C7/ize5Wl7PPhZhgpW3B9ayPqCBpM4CX6PrO5Xi22e+SnHUltU6of1pUdRKhUwY2GtdksRyJV+
	+n5JIrPLh29deIXXQO0b/ePNEPcuYQPRHp9NSOVv2elZFTXTHSHzAnnAkmPuDPSDmabMooRpnWa
	TnluzVrIziMt8Ke8hmQicZR+3A/o84bT60QB3cV7aVs/3u3uA7X37ZPE94TKguFkRL77jKvOtSI
	MtRoSwVAhXxGFYOg5v0Ds4+MpQBdpOEikvFP2WYB1py9MFjkDoBjF48B2ndMlPaGVxh34Cdr6FP
	zrOar3BEU+3V+6UIWTehBFTnx/rf7360wVLkLG/7ErTEIxCX7uiha2t2EL+TsEW0HszE/DHC0US
	KSJAbHXSpYx3EN02HlNLbmUN+BkWujDK+weep7UFGqpTR2LMdwsDZxfg+eO51y95FOv4r//vQKb
	53jI7Vr8hvb4pAgBV8B0hw23OlSXdKEBiBOcWxGNnFqCrtQdzZTG2RclpbHDtEBuzaJf8f5OWyl
	gZl6dfAczBWmJweBbh9uuQo3kPWeLdca+hzcvsr1kN8fhvR3cf3nPC7bpHZ0u/FzvQpwz
X-Received: by 2002:a05:6122:c250:b0:5ec:7589:f9e0 with SMTP id 71dfb90a1353d-5ec758a14bbmr1957487e0c.11.1793545951557;
        Sun, 01 Nov 2026 07:12:31 -0800 (PST)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bba011sm8346081e0c.5.2026.11.01.07.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:12:30 -0800 (PST)
Date: Sun, 01 Nov 2026 10:12:30 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 kvm@vger.kernel.org
Message-ID: <willemdebruijn.kernel.9c17365c41b3@gmail.com>
In-Reply-To: <20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
References: <20261026-v6-7-topic-virtio-net-ptp-v4-0-008af03cd43b@pengutronix.de>
 <20261026-v6-7-topic-virtio-net-ptp-v4-5-008af03cd43b@pengutronix.de>
Subject: Re: [PATCH RFC v4 5/6] virtio-net: add XDP rx timestamp metadata
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Steffen Trumtrar wrote:
> For the skb, the timestamp is read from the header before the XDP
> program runs, so XDP_PASS keeps it even if the program changes the
> packet. XDP therefore works with rx timestamping enabled.
> =

> Add xmo_rx_timestamp so XDP programs can read the timestamp with
> bpf_xdp_metadata_rx_timestamp(). It returns -ENODATA if timestamping
> is not enabled or the device did not timestamp the packet. Install the
> metadata ops also if only VIRTIO_NET_F_RX_TSTAMP is negotiated;
> rx_hash returns -ENODATA then.
> =

> Like virtnet_xdp_rx_hash(), the callback finds the header relative to
> xdp->data, so it has to be called before bpf_xdp_adjust_head().
> =

> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> =

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 23af10c613b48..e79b65653fad7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6848,8 +6848,30 @@ static int virtnet_xdp_rx_hash(const struct xdp_=
md *_ctx, u32 *hash,
>  	return 0;
>  }
>  =

> +static int virtnet_xdp_rx_timestamp(const struct xdp_md *_ctx, u64 *ti=
mestamp)
> +{
> +	const struct xdp_buff *xdp =3D (void *)_ctx;
> +	const struct virtio_net_common_hdr *hdr;
> +	struct virtnet_info *vi;
> +	u64 tstamp;
> +
> +	vi =3D netdev_priv(xdp->rxq->dev);
> +	if (!READ_ONCE(vi->hwts_rx_en))
> +		return -ENODATA;
> +
> +	hdr =3D (const struct virtio_net_common_hdr *)(xdp->data - vi->hdr_le=
n);

    Reading `hdr->tstamp` in place from `xdp->data - vi->hdr_len` violate=
s the XDP
    metadata area contract (`Documentation/networking/xdp-rx-metadata.rst=
`: drivers
    must copy device-reserved metadata out of `[data_hard_start, data)` b=
efore
    presenting the frame to XDP) and breaks standard XDP metadata consume=
rs:
    - `hdr->tstamp` sits at `[xdp->data - 8, xdp->data)`. Standard XDP pr=
ograms=E2=80=94such
      as `tools/testing/selftests/bpf/progs/xdp_hw_metadata.c`=E2=80=94ca=
ll
      `bpf_xdp_adjust_meta(ctx, -(int)sizeof(struct xdp_meta))` first, in=
itialize
      fields in `meta` (e.g. `meta->hint_valid =3D 0` at `[xdp->data - 4,=
 xdp->data)`),
      and only then call `bpf_xdp_metadata_rx_timestamp(ctx, &meta->rx_ti=
mestamp)`.
      Initializing `meta` overwrites `hdr->tstamp` (and `hdr->hash_v1_hdr=
`) before
      this kfunc runs.
    - Calling `bpf_xdp_adjust_head()` before reading metadata also shifts=
 `xdp->data`,
      reading arbitrary bytes at `xdp->data - vi->hdr_len`.

    Wrap `struct xdp_buff` in a driver struct on the stack (`container_of=
`, and in
    `struct xdp_buff_xsk`'s `cb` verified with `XSK_CHECK_PRIV_TYPE()` fo=
r AF_XDP,
    matching `gve`/`igc`/`ice`/`mlx5`) and stash `tstamp` (already extrac=
ted in
    `receive_buf()` and `virtnet_receive_xsk_buf()` before XDP runs) and =
the hash
    fields before `bpf_prog_run_xdp()`.
