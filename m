Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53D5143C67
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 03:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930752; cv=none; b=HbyvYdo241Id6N5DqsBgB3kSYN8Og4Ow+4dA/0FN0CO0TvXp+vCeJFZ7uCKA5BCbAfgIqm5WC1JkqPSaqrAxXU10SJn2qo+5Qah3xZTktJuXD+OFeAYfUfdsrDuS16Dz+CNZvFGSKDIHudNfvollOKiCJCpgToFbTcQ+WM2r0/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930752; c=relaxed/simple;
	bh=grgr8wFdoOCKelHN0/YG8NRrSXx88B1nTn4dCXxCUnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tD3Ced10NE8d7FOoZ5j05t9M9lblRpKYiRFbUNlBEs3CjdSyQR6zKQhCBsiEFJgFnElYTY78NB3vtslGLJdRazR4JBTIM24WYsghD89GM6+kp3+vY978Qga+UGppmahkoQ5FsXVH48meIzUOv54o52kdpAcwu9c5nsOv4pY30b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsXnMLS/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsXnMLS/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713930748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJbnHKMdDBEsQMRLBXg/P+JcLGfgFupAvDL3tdrY4dk=;
	b=YsXnMLS/wDVCN+7ictbVWKro5FOPRT+orrqKBW04uzuhvFWN75Q4uiFeDGs8NADG/ppp4a
	LXUgw/c702sHVH0UNgC5Y+QQlgHWc3FyR3FWcq5YkFqgnDSY1YEtz8XbhInFsCP9e8q17R
	HVa29b+X7w0bsqt4npoeqva8csL2y7g=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-8MpBv_ogPwOeAqFfC9WwiQ-1; Tue, 23 Apr 2024 23:52:27 -0400
X-MC-Unique: 8MpBv_ogPwOeAqFfC9WwiQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-60361c6fa70so1461729a12.3
        for <virtualization@lists.linux.dev>; Tue, 23 Apr 2024 20:52:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713930746; x=1714535546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJbnHKMdDBEsQMRLBXg/P+JcLGfgFupAvDL3tdrY4dk=;
        b=UNK1ymeS4lTS3ssvJ6e5e0L/EdACV4yXUCU+r8y5g5RVwvq1w6Uq2+WJN61SdDJW5+
         3ZNSQ1v7AMFU1gsxAEvFKzaC/c6VVVCfff7vmuVeJwL8qmttuU0nLSRGD6aLjISgpB7t
         sQlm2D8TTVY8WZUICfkyULu4ygc1uB84ihxuD65bNdV4XY7kUEZxVjgTD9mm2RrR85Kt
         Ns8/QSly4cvdwdUKFouSPUP+Dfjy0XOQiDT+hw7POoZgoRd4aR41zlIbRCAEx/+ib/0y
         IZgycAi4VH49+WR77WnvEVbjp6/dMH4efh+ss60Jx/+6yyae50nXYX9Tvb8VePdEfXkP
         CUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfUQKREUdSFKnkSmhiT9L8vgIVzpF4XbekabbE5eCcZ6cSiW4NYEYRuxtjtKeUJcserfECUerk4uk/7M+0XrcAp56alSkUejgNm9zgNig=
X-Gm-Message-State: AOJu0YwzKppnqZaOjmC4XhL0cgo+T2kz2KK6jmnIHyfTAY1rYF/HVlcw
	dSJKZzvOlmsHjNxo1znLLVfBt6ffoYkc4CN+VeMLhriMG5fFxKsmPQV/2WTfJlaoImDahSixRzg
	i8jN9i/a0QahkhDqroWTWUzI7DdzIFJx0Wn1hU534LujTY2i4yjshd2QKhQXcL/yGI7Ujvgcviv
	rcZpmXSLqMo7A/WWtFSutLJ09DXn69d96dPUg2kz0=
X-Received: by 2002:a05:6a20:9187:b0:1aa:118c:22cd with SMTP id v7-20020a056a20918700b001aa118c22cdmr1538203pzd.62.1713930746041;
        Tue, 23 Apr 2024 20:52:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGA+deojCMQ8Z7djFD6weadRa90BTPWmlecKHcAHl1rKT0HigiYFO4WsDxVxXKywA17hDJwnoWBOWI53prC8JI=
X-Received: by 2002:a05:6a20:9187:b0:1aa:118c:22cd with SMTP id
 v7-20020a056a20918700b001aa118c22cdmr1538188pzd.62.1713930745714; Tue, 23 Apr
 2024 20:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240423113141.1752-1-xuanzhuo@linux.alibaba.com> <20240423113141.1752-6-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240423113141.1752-6-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 24 Apr 2024 11:52:12 +0800
Message-ID: <CACGkMEvaJuujaXoJ3jnvMFYX1-CnXH7cUEz4KbXivgEmt=OUxA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 5/8] virtio_net: add the total stats field
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@google.com>, Amritha Nambiar <amritha.nambiar@intel.com>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:32=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> Now, we just show the stats of every queue.
>
> But for the user, the total values of every stat may are valuable.
>
> NIC statistics:
>      rx_packets: 373522
>      rx_bytes: 85919736
>      rx_drops: 0
>      rx_xdp_packets: 0
>      rx_xdp_tx: 0
>      rx_xdp_redirects: 0
>      rx_xdp_drops: 0
>      rx_kicks: 11125
>      rx_hw_notifications: 0
>      rx_hw_packets: 1325870
>      rx_hw_bytes: 263348963
>      rx_hw_interrupts: 0
>      rx_hw_drops: 1451
>      rx_hw_drop_overruns: 0
>      rx_hw_csum_valid: 1325870
>      rx_hw_needs_csum: 1325870
>      rx_hw_csum_none: 0
>      rx_hw_csum_bad: 0
>      rx_hw_ratelimit_packets: 0
>      rx_hw_ratelimit_bytes: 0
>      tx_packets: 10050
>      tx_bytes: 1230176
>      tx_xdp_tx: 0
>      tx_xdp_tx_drops: 0
>      tx_kicks: 10050
>      tx_timeouts: 0
>      tx_hw_notifications: 0
>      tx_hw_packets: 32281
>      tx_hw_bytes: 4315590
>      tx_hw_interrupts: 0
>      tx_hw_drops: 0
>      tx_hw_drop_malformed: 0
>      tx_hw_csum_none: 0
>      tx_hw_needs_csum: 32281
>      tx_hw_ratelimit_packets: 0
>      tx_hw_ratelimit_bytes: 0
>      rx0_packets: 373522
>      rx0_bytes: 85919736
>      rx0_drops: 0
>      rx0_xdp_packets: 0
>      rx0_xdp_tx: 0
>      rx0_xdp_redirects: 0
>      rx0_xdp_drops: 0
>      rx0_kicks: 11125
>      rx0_hw_notifications: 0
>      rx0_hw_packets: 1325870
>      rx0_hw_bytes: 263348963
>      rx0_hw_interrupts: 0
>      rx0_hw_drops: 1451
>      rx0_hw_drop_overruns: 0
>      rx0_hw_csum_valid: 1325870
>      rx0_hw_needs_csum: 1325870
>      rx0_hw_csum_none: 0
>      rx0_hw_csum_bad: 0
>      rx0_hw_ratelimit_packets: 0
>      rx0_hw_ratelimit_bytes: 0
>      tx0_packets: 10050
>      tx0_bytes: 1230176
>      tx0_xdp_tx: 0
>      tx0_xdp_tx_drops: 0
>      tx0_kicks: 10050
>      tx0_timeouts: 0
>      tx0_hw_notifications: 0
>      tx0_hw_packets: 32281
>      tx0_hw_bytes: 4315590
>      tx0_hw_interrupts: 0
>      tx0_hw_drops: 0
>      tx0_hw_drop_malformed: 0
>      tx0_hw_csum_none: 0
>      tx0_hw_needs_csum: 32281
>      tx0_hw_ratelimit_packets: 0
>      tx0_hw_ratelimit_bytes: 0
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 69 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6d24cd8fb15f..8a4d22f5f5b1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3344,14 +3344,15 @@ static void virtnet_stats_sprintf(u8 **p, const c=
har *fmt, const char *noq_fmt,
>         }
>  }
>
> +/* qid =3D=3D -1: for rx/tx queue total field */
>  static void virtnet_get_stats_string(struct virtnet_info *vi, int type, =
int qid, u8 **data)

Nit: -1 for all seems to be a wired API, could we have the caller to
iterate the possible qid?

Other parts look good.

Thanks

