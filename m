Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E42FB2
	for <virtualization@lists.linux.dev>; Mon, 17 Mar 2025 00:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742171209; cv=none; b=SYM4tIRwl0qiflRXQzTzIvEiGzubzQxzx+egUAYlQw5DvH8UTcAR/ouCE/CTVGD/nmdsZPm8IfaZ2QvmvbM1PZznm5Gd3hwwlPTcF345tqdnmBgfT9oZwzdkAu0bObtAhPs+Tdb8ORTP73ETI0zfJiFYPwaOm3zg0lMq6gmFe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742171209; c=relaxed/simple;
	bh=/iLZeVGBseZg0Sgr9HpZSDE2yUmIBm3BJof2CSAxgo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMktmq38OwHMbbzM/lLQts/Q3MLWW8dbtobgxDx7dvVVHnILsts9313JyAFm6lkY9rgrafJRPxn4GprBLCFNdPIBfp0f1GZ/jWwePPnzhJ+Z0mCHilVgoSA1VrJeOPN2RLOCrDMkAhMMfxLSDeD2btW0jRoflZ47ToERGGYxJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dFEcVQ91; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFEcVQ91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742171204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YOcZgp8/tuVHGKfNlaTwfXI0xbH/R796rVlRuF7Xhjw=;
	b=dFEcVQ91Zv+TGqX0KmglBOCBoEzNjVjYh1kSZUSyez7Pn2od7gRxXEpigYHpRMzZ5xmEkY
	H0N9F5CHyv4bVV8WB6Ie0Ef4MoB5Bg+AdV3P1G1mq/5xP8Nct7J2muv7U6e2YEkYvxGSPO
	JwbuQV38c8DZwZsjOzbrnhlRTufdJoA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-6etPHKqcNeSELgQnIAN6LA-1; Sun, 16 Mar 2025 20:26:43 -0400
X-MC-Unique: 6etPHKqcNeSELgQnIAN6LA-1
X-Mimecast-MFC-AGG-ID: 6etPHKqcNeSELgQnIAN6LA_1742171202
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff798e8c3bso2413305a91.2
        for <virtualization@lists.linux.dev>; Sun, 16 Mar 2025 17:26:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742171202; x=1742776002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOcZgp8/tuVHGKfNlaTwfXI0xbH/R796rVlRuF7Xhjw=;
        b=fW3NP5JGXC4Hu+GmSDxjwatBHDB5MKUNJIQK4ISMPgepmQxiW6z0Pnrl8/K/PdzV9A
         /Isym0sU2s++/b9pvDgIdz7yWx5mMVgf0eHTnWTOyiNrDmO1/4UGFrLDPV6dvsgGZjvb
         aZAj+bLqCQeW9jtrSMXjp/fZDhNB636vEspM489uhYS/fG/wceghB7jFcSry/+/Gcn3s
         bstxvR139jErZygV0igxdva/hJaerQTVGckx7602/yz6N1ydonnfmSrZLVhjNoBeNxPk
         qNOgQk2EU3N50QnmGQB787Rhd1CopPM5LsL9fbV6+h7SVSAwq2eiMz2ceicsjovLUN1X
         SD5w==
X-Forwarded-Encrypted: i=1; AJvYcCXQKx3A//cx6oVemFZthKTTUTbV9xj1iYyUlyx24h8WdHXohjdjCeywmXjBI50noQnb4gKDIvi5xXmf1butxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtlxPw8LhtddWm8G9WdA3kyaaicJIRJrqoqjltLC8IBhSNFkhp
	uOQpchXamxdXk6bhh8hepcJ7i4RioA+UdSo48ZchjPUygz9ZRPD++U1rkGdYzfDaQFxSnbWOMm2
	BTxez6iIEhSGAdrz1cEJ2463HJUoIWV/51RIzFOWeMnCk3WGLuxTXVD/wTAFtgY6Lc3GmAfcLTw
	Pp2soxryLufg8NU95YTBDuQksN+2NM4tFmlv/B6JM=
X-Gm-Gg: ASbGncuQjl/oaqsSjYEfIfvNpR1gabM4AMDBN4eQU06Rsti9Z6vWhBf0Z3LEe2ehiiX
	3cKD78ZNQsPLGtcpLyUpZTwE//SB3j3BO2OHGhI/3VogqYoO3awQIa564VGUfPGnDtnFAFIQlTg
	==
X-Received: by 2002:a05:6a20:2589:b0:1f5:8748:76cc with SMTP id adf61e73a8af0-1f5c12ec885mr12690835637.31.1742171202486;
        Sun, 16 Mar 2025 17:26:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcug+Yyw+eml79Skzv3IE+Mls90QaEVal9tNp24iyB07+1Eu0UE4llVFclpQ1PL56l8PLPNU3dXcmt9R6xQ9M=
X-Received: by 2002:a05:6a20:2589:b0:1f5:8748:76cc with SMTP id
 adf61e73a8af0-1f5c12ec885mr12690809637.31.1742171202079; Sun, 16 Mar 2025
 17:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67c7761a.050a0220.15b4b9.0018.GAE@google.com> <20250312130412.3516307-1-quic_zhonhan@quicinc.com>
In-Reply-To: <20250312130412.3516307-1-quic_zhonhan@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Mar 2025 08:26:30 +0800
X-Gm-Features: AQ5f1Jp7pXl7FKd2PoyweWeIqinsO9jQrjigO6XDQe8P2hB1cDsf_Tx2SHTuUYc
Message-ID: <CACGkMEvRGp3cbZEwsAU0NBGJzzp899=tPMLQwYJx7LsA8RTqww@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_ring: Fix data race by tagging event_triggered
 as racy for KCSAN
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bQTXS9EmgG__-ReLCc1_yzLMnUrtJSOoBQ4Uf2ZKBYE_1742171202
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 9:04=E2=80=AFPM Zhongqiu Han <quic_zhonhan@quicinc.=
com> wrote:
>
> syzbot reports a data-race when accessing the event_triggered, here is th=
e
> simplified stack when the issue occurred:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb_delay=
ed
>
> write to 0xffff8881025bc452 of 1 bytes by task 3288 on cpu 0:
>  virtqueue_enable_cb_delayed+0x42/0x3c0 drivers/virtio/virtio_ring.c:2653
>  start_xmit+0x230/0x1310 drivers/net/virtio_net.c:3264
>  __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5160 [inline]
>  xmit_one net/core/dev.c:3800 [inline]
>
> read to 0xffff8881025bc452 of 1 bytes by interrupt on cpu 1:
>  virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:880 [inline]
>  virtqueue_disable_cb+0x92/0x180 drivers/virtio/virtio_ring.c:2566
>  skb_xmit_done+0x5f/0x140 drivers/net/virtio_net.c:777
>  vring_interrupt+0x161/0x190 drivers/virtio/virtio_ring.c:2715
>  __handle_irq_event_percpu+0x95/0x490 kernel/irq/handle.c:158
>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>
> value changed: 0x01 -> 0x00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> When the data race occurs, the function virtqueue_enable_cb_delayed() set=
s
> event_triggered to false, and virtqueue_disable_cb_split/packed() reads i=
t
> as false due to the race condition. Since event_triggered is an unreliabl=
e
> hint used for optimization, this should only cause the driver temporarily
> suggest that the device not send an interrupt notification when the event
> index is used.
>
> Fix this KCSAN reported data-race issue by explicitly tagging the access =
as
> data_racy.
>
> Reported-by: syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67c7761a.050a0220.15b4b9.0018.GAE@goo=
gle.com/
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
> v1 -> v2:
> - Use data_race() instead of memory barriers.
> - Simplify and rewrite commit messages.
> - Link to v1: https://lore.kernel.org/all/20250311131735.3205493-1-quic_z=
honhan@quicinc.com/
>
>  drivers/virtio/virtio_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fdd2d2b07b5a..b784aab66867 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2650,7 +2650,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *=
_vq)
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (vq->event_triggered)
> -               vq->event_triggered =3D false;
> +               data_race(vq->event_triggered =3D false);
>
>         return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) =
:
>                                  virtqueue_enable_cb_delayed_split(_vq);
> --
> 2.25.1
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

