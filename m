Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4732A533D6
	for <virtualization@lists.linux.dev>; Sat,  7 Mar 2026 04:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772856927; cv=pass; b=KzqoOpLCcpCEqZs07nIXVtZHzscxkmIqpibeN7liorZGWqgmSpjVkLCuFHejkHqNF6jQ1gdTsX6ZJTWwSIZOEwVQ1EiCprUReR06nacnQSf9cAWaj8gFz4fQFIMMEeauJWUkvp9KT2KmWfL/o0ugxDlrrNOG5qhIAJpNNkvXbc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772856927; c=relaxed/simple;
	bh=inCuuwoAcPbcYrioLOpQppPGQPvIuxp5NYrPNRRm17M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Luw2Il+N9RYldYW/oDEa+F/povDt6i8EQ9R58ZizveYSlqONDwkIvTjg37Lob+OWKlfdaTWuTrLta57sj01XUuqPLiMkxEJ2R8j9dmV1aQPtjDoHVcTEwpzMdLX7RmWGOxGGhGFZeknl3ZhLohOcbTzPeXS6zLiwZ9I5Aey5nF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CcP2fEQq; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CcP2fEQq"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899e87b04d8so115680526d6.3
        for <virtualization@lists.linux.dev>; Fri, 06 Mar 2026 20:15:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772856925; cv=none;
        d=google.com; s=arc-20240605;
        b=jELL3DeJfJs/RKfm33Pid2TxGGlIHlovyeK1IJ0Y9qQSYlGh7nMawDamSkXgjour+i
         1iDh8y6m1W7Ju5FzXRwO4LTZvq73Yh0icBR0Qdg76YnXVroxyBdAPdhF712sfpQLGJcM
         kN85QKruKjlQfWJhYXe7AzRKpqtdVpZyUNrQL57ZCefo1xeRPI1yysjpy7C4jPCDry77
         jjHeOU1q10FYe0UDCe8AOVEgI0/S+UOgqP2zTg/DLKwp23wYGPUodpgNVWbDfceMHrn3
         q65KeOoYtvNqusUmEo6rpdHFHa1Ww4l+gRVPmIsqEGSxt4o5msLckodajzmTgMfN7EPT
         w6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2j9Bldh73I1ZTU/gwH+Va1opxn4z5tE0/MvG0JXLOnM=;
        fh=5e0TOavOUMuNmE/6MJxvfZBAEtfUrmc/c/zZ7jG5KI8=;
        b=NZ2UESDDZTevYMT2AzC98m+1oYRBCawyqhz9A6XC5CSOBDGdziTnKDQr+PXIhgoFw+
         0BvQkVkWOUYqSdF++OF9H0waU1SZ2NgX3zEwwTBKMKLbIbORFidgR+M/bFxkopv5kEsi
         1CvtA2VpfvYNbcABU2k67ve/uRJ3AWXqQO7z/0VMcCTpb9MhqMLQlFac4RyIDFlZzWUi
         kS8GSHaHvGvb+Tn6SRU99ADvPMtXKu2E3zZBiC2vqQIfGAfjFqKFDU8XgQl5RsJPHnsm
         Anrt1dHLI1HvqewuUjh4yZTJ9cNbyW0sMFDw3l8rGvZlqJOKQfoRGx/RZawoLibbR1IM
         FM3w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772856925; x=1773461725; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2j9Bldh73I1ZTU/gwH+Va1opxn4z5tE0/MvG0JXLOnM=;
        b=CcP2fEQqSI2M99GnydIkGh7Wi0IAyDQQ7y/37LB5gyE8q2Z0i3TO92TlLdWtkw7D3V
         oeN8qqrzCkDIuUuh6rdspHgyNnI6Shnd2NpPbPL3iUkUIf6bzk+vG10t2QXObjDbekO2
         i/ppvn19xFFQVsA/H1A+4n8wxyIct0hiIbHQhxKvYS9xCOT8333FbIkCUurkboV7xSSb
         JFbJnVmJvA7H7LK5+UwywS7UQdBQM8VhONCmfX1iBSC7TCbsvN1ztncxlKjC1gr4L7uK
         Bblu5Sn2VAnGdKfqjcyaL7O2sDRCELeAnUiO+j4bHOT/a3PBHqqORG/BgNLZsrMN6OMX
         cSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772856925; x=1773461725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2j9Bldh73I1ZTU/gwH+Va1opxn4z5tE0/MvG0JXLOnM=;
        b=FnA96H+wBHmLoodPyGx2/CBMpG+ubDXjjpthuB60uOKFfCgyJtOinpngbFOMjhodAy
         hxBlOeF0LcuQma6I9w27nZSxvUEd/FA5tmsnhv4bU/NnIKBK6GtIDzQIruK0tBG60+QE
         UUCABzwL3oHOKQCq/aj/jk0ZkHfEXOa4OmprpPpdF6I4UPN+UCynd0ZJ/XRQR2o2tx1z
         eHAwUxV9o63pkzi/3UyhiLWMWzKSwOoJMtAQAyw36no8Pv4WHjEpTEeyY9W0kWZZAiJk
         Zv5LD/EmDQzuITMsIJdXo4GhiziYnZqDvJcV+yjjnENy538b68OV8Uls7cMq4189wiNC
         WeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrkJ/F6TJb06k9k24V6U+mjRFAueWwjeCNLYMR3thfxPBmeseWA2YHkq+R8v5k1oZz+/kctflzPGWARxq3VA==@lists.linux.dev
X-Gm-Message-State: AOJu0YztQwAdpQvduzqW6TlkSfouriDiu/NNUiCID8jnERd8hF5Lkz5l
	Z27Bt22IH1Cc8hh2kg+XKKock21uJHCmR43kXz0FqLcqH4JiJiRL75Pb7WMUOYsLeD5xeSTgY/d
	MhX1TYIo8aXFdha39x4BqCo1LaDYaO7pu75T5Wkxr
X-Gm-Gg: ATEYQzxwShBz5nhiEZ3neVuu0GsSSnl4VYXZjtbZ02mrbJOuwAudvwwHsI33VISA5bJ
	JJsyodN05+csNWymyOkrdIBDzVurp+PsrM+6FfcoxwGoZ+TJRASL/JwTWG0fiMQpzYxX2D0KtFU
	ffn0oSr+DrFrvCWTvadCXVvxF7cMGi9uHmXhVB2aXEeXtYkTzFE8z3knWU1a2QykGl6XUYGZMSU
	EK40ZxPJgbv9elhBBuD+FV40yaLPnV2MVcB4holiusg3S7AqSfn8k1Aw9LFbZyMU/nzl6KHvnu/
	hgLZxfZ+
X-Received: by 2002:a05:6214:2604:b0:894:6112:457c with SMTP id
 6a1803df08f44-89a30b1fef8mr66196616d6.56.1772856924630; Fri, 06 Mar 2026
 20:15:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260307035110.7121-1-xietangxin@yeah.net>
In-Reply-To: <20260307035110.7121-1-xietangxin@yeah.net>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 7 Mar 2026 05:15:13 +0100
X-Gm-Features: AaiRm52Y7DK7119F2b2_eY2drAyaACtUvQzw-3G9kiGO-BiPanreNTAMyjIr48o
Message-ID: <CANn89i+Km-6ixX=mQEZSf_vAbYo4ECge8-jY8s3vLXJ87D63sA@mail.gmail.com>
Subject: Re: [PATCH] virtio_net: Fix UAF on dst_ops when IFF_XMIT_DST_RELEASE
 is cleared and napi_tx is false
To: xietangxin <xietangxin@yeah.net>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 7, 2026 at 4:52=E2=80=AFAM xietangxin <xietangxin@yeah.net> wro=
te:
>
> A UAF issue occurs when the virtio_net driver is configured with napi_tx=
=3DN
> and the device's IFF_XMIT_DST_RELEASE flag is cleared
> (e.g., during the configuration of tc route filter rules).
>
> When IFF_XMIT_DST_RELEASE is removed from the net_device, the network sta=
ck
> expects the driver to hold the reference to skb->dst until the packet
> is fully transmitted and freed. In virtio_net with napi_tx=3DN,
> skbs may remain in the virtio transmit ring for an extended period.
>
> If the network namespace is destroyed while these skbs are still pending,
> the corresponding dst_ops structure has freed. When a subsequent packet
> is transmitted, free_old_xmit() is triggered to clean up old skbs.
> It then calls dst_release() on the skb associated with the stale dst_entr=
y.
> Since the dst_ops (referenced by the dst_entry) has already been freed,
> a UAF kernel paging request occurs.
>
> fix it by adds skb_dst_drop(skb) in start_xmit to explicitly release
> the dst reference before the skb is queued in virtio_net.
>
> Call Trace:
>  Unable to handle kernel paging request at virtual address ffff80007e1500=
00
>  CPU: 2 UID: 0 PID: 6236 Comm: ping Kdump: loaded Not tainted 7.0.0-rc1+ =
#6 PREEMPT
>   ...
>   percpu_counter_add_batch+0x3c/0x158 lib/percpu_counter.c:98 (P)
>   dst_release+0xe0/0x110  net/core/dst.c:177
>   skb_release_head_state+0xe8/0x108 net/core/skbuff.c:1177
>   sk_skb_reason_drop+0x54/0x2d8 net/core/skbuff.c:1255
>   dev_kfree_skb_any_reason+0x64/0x78 net/core/dev.c:3469
>   napi_consume_skb+0x1c4/0x3a0 net/core/skbuff.c:1527
>   __free_old_xmit+0x164/0x230  drivers/net/virtio_net.c:611 [virtio_net]
>   free_old_xmit drivers/net/virtio_net.c:1081 [virtio_net]
>   start_xmit+0x7c/0x530 drivers/net/virtio_net.c:3329 [virtio_net]
>   ...
>
> Reproduction Steps:
> NETDEV=3D"enp3s0"
>
> config_qdisc_route_filter() {
>     tc qdisc del dev $NETDEV root
>     tc qdisc add dev $NETDEV root handle 1: prio
>     tc filter add dev $NETDEV parent 1:0 protocol ip prio 100 route to 10=
0 flowid 1:1
>     ip route add 192.168.1.100/32 dev $NETDEV realm 100
> }
>
> test_ns() {
>     ip netns add testns
>     ip link set $NETDEV netns testns
>     ip netns exec testns ifconfig $NETDEV  10.0.32.46/24
>     ip netns exec testns ping -c 1 10.0.32.1
>     ip netns del testns
> }
>
> config_qdisc_route_filter
>
> test_ns
> sleep 2
> test_ns
>
> Signed-off-by: xietangxin <xietangxin@yeah.net>
> ---
>  drivers/net/virtio_net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 72d6a9c6a..5b13a61b3 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3351,6 +3351,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, =
struct net_device *dev)
>         /* Don't wait up for transmitted skbs to be freed. */
>         if (!use_napi) {
>                 skb_orphan(skb);
> +               skb_dst_drop(skb);
>                 nf_reset_ct(skb);
>         }

This probably could skb_release_head_state() at this point.

Thanks.
