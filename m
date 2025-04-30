Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7F23FE4
	for <virtualization@lists.linux.dev>; Wed, 30 Apr 2025 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745984973; cv=none; b=eAvfW4o3ZxGQzG5qRxrtSmsrBpJkd2oWcTi3yt+7Agnbo7BleToqazf7ustatpohexRZ+nwdNYL8jn2zAc4LEuZ29vq+55eSJyMaE7xk6zNjSYEO6deIWUCd05TD8tCnXOlN94Yt3fjt8bteewbSivxPeu4Z/LyUxW/SLDErt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745984973; c=relaxed/simple;
	bh=EMvs/epZCI5tIFnIxvolCpdi401Pvyo9p7L49rcaIH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ckaFkItpQbXYM4lR3aR8RXegJHS1VJsO9sib6EN24wfHAlpfLocoHNYpni3IN54pFDtkLyEYinDHYR4XT4PWRaNk+sylizq45Tlewa1OmOisljK6uQZHf1Rtz3/J/eeZCCedODfAADDu3GvQoQni80i244KCXXZvzlK1YQSmOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5v1PnlG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5v1PnlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745984970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6iLYad4+IAn2BhEwJSgEHfyjiXN3UZE/9OJrT4E642Q=;
	b=U5v1PnlG3yCHCjvPfiQtbxujrux5phqijHAP/E92bhFid0adVIk/FA+EzPjiG173/EzRGH
	XprwmJU09sedziQdCDfi7uBAtIPm0yb7Ndxk2ckLgbInhCe6sX/0105pRWBzgnsp/hnS0R
	TQAQeG026STPc+8GV0qw2cXmXpO4EUg=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-3N6CyQ5iPSaDextMVhHP1w-1; Tue, 29 Apr 2025 23:49:28 -0400
X-MC-Unique: 3N6CyQ5iPSaDextMVhHP1w-1
X-Mimecast-MFC-AGG-ID: 3N6CyQ5iPSaDextMVhHP1w_1745984968
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2240a96112fso105933565ad.2
        for <virtualization@lists.linux.dev>; Tue, 29 Apr 2025 20:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745984967; x=1746589767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iLYad4+IAn2BhEwJSgEHfyjiXN3UZE/9OJrT4E642Q=;
        b=Rq4XCYcVY7SqTrATzvP+nuXoNIA6ZzfusGKa7CrtRR/3GidsK3fGnn/t5zAIIsIksI
         8OosUj0cW9RWBINieJjYd7GhSyMo5wtjm6JL3AykWzQyb4cxWjeF9lSDd+/Pe5PBMfsp
         XkU1J5CLaH80/rvR9BWNryfQbu1RIgm+r/+QNnUWqGsgfxL4aYvf1PWsGGDVHwrRlznG
         X3CIXXcpxU3fQzWELe+6cCPnbGhvcNW+1H4Ec+9BCkLEiutIW1x9sbCQOUyR0Po5xvVT
         HzVRcMvIPYs3kr0sKYS5Gg9BVWXxyIBRcoaAO0A0QyZpBBRmXjEykveZM7/CD97bxVm3
         zhjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZYX7DNFHYCN9r5thbF2/KYemoZZwJ7V1vJKNGltZanAQheJNY2Tjp4EHAUXfyojB00yRUkMNz9DkdEZ+rGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzH+TOE8c9rjDGkMuBhPlThAXP1iR8cNmEHxcfh2pA7nXt/DSO+
	k7qRCRTRgAu8uf4mdA9yltShs+7SAY5hQp1AkDAaDZRJONTptcpB0UcnNFc+UyqYIC8dLX7NPqE
	s8yemXcFzEA+Izjdi9ZXVk1aXIlXaDP8UATNdFyR6WCePctKOiLojMB3dMlEiYu1iPN1OHlbYDF
	+JSo6kL48T/EkgYF/+/ksykwpzaimd+lJz/KTKcQY=
X-Gm-Gg: ASbGnctwGN2gT3kFKFL9kPDO2HL+f1T/FnvROxX35uZO9E+4OO8TAfez8jLy4HxuSUr
	qm1ECoaa9lq9M0lN1Rf2BA05tziDs6jzFlbGbTv03a9vWVCq1OVs/cJ9Q+8HsJdh2p7n3
X-Received: by 2002:a17:903:22ca:b0:223:f9a4:3fb6 with SMTP id d9443c01a7336-22df5764863mr14524155ad.11.1745984967693;
        Tue, 29 Apr 2025 20:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrWU7lQ72u8cfiUux+GL0b3nC1IPlTtMmeSaOeafTX5pPbkRhKG5d/EvAgBqORfyFxYJ9troaBuoeixFjcZoI=
X-Received: by 2002:a17:903:22ca:b0:223:f9a4:3fb6 with SMTP id
 d9443c01a7336-22df5764863mr14523895ad.11.1745984967332; Tue, 29 Apr 2025
 20:49:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250429143104.2576553-1-kuba@kernel.org>
In-Reply-To: <20250429143104.2576553-1-kuba@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 30 Apr 2025 11:49:15 +0800
X-Gm-Features: ATxdqUGV32LFMHov4kW8S9eFwg2EA10IIHrFgEiILPWhKTe-KYLV4nZPqSuKRhc
Message-ID: <CACGkMEs0LuLDdEphRcdmKthdJeNAJzHBqKTe8Euhm2adOS=k2w@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: don't re-enable refill work too early
 when NAPI is disabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, minhquangbui99@gmail.com, 
	romieu@fr.zoreil.com, kuniyu@amazon.com, virtualization@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yt8y1ujgEvrKuS3xYZVdCio6j8BnriyAWU0Oa5exE6I_1745984968
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 10:31=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Commit 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx"=
)
> fixed a deadlock between reconfig paths and refill work trying to disable
> the same NAPI instance. The refill work can't run in parallel with reconf=
ig
> because trying to double-disable a NAPI instance causes a stall under the
> instance lock, which the reconfig path needs to re-enable the NAPI and
> therefore unblock the stalled thread.
>
> There are two cases where we re-enable refill too early. One is in the
> virtnet_set_queues() handler. We call it when installing XDP:
>
>    virtnet_rx_pause_all(vi);
>    ...
>    virtnet_napi_tx_disable(..);
>    ...
>    virtnet_set_queues(..);
>    ...
>    virtnet_rx_resume_all(..);
>
> We want the work to be disabled until we call virtnet_rx_resume_all(),
> but virtnet_set_queues() kicks it before NAPIs were re-enabled.
>
> The other case is a more trivial case of mis-ordering in
> __virtnet_rx_resume() found by code inspection.
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx"=
)
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: mst@redhat.com
> CC: jasowang@redhat.com
> CC: xuanzhuo@linux.alibaba.com
> CC: eperezma@redhat.com
> CC: minhquangbui99@gmail.com
> CC: romieu@fr.zoreil.com
> CC: kuniyu@amazon.com
> CC: virtualization@lists.linux.dev
> ---
>  drivers/net/virtio_net.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 848fab51dfa1..4c904e176495 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3383,12 +3383,15 @@ static void __virtnet_rx_resume(struct virtnet_in=
fo *vi,
>                                 bool refill)
>  {
>         bool running =3D netif_running(vi->dev);
> +       bool schedule_refill =3D false;
>
>         if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -               schedule_delayed_work(&vi->refill, 0);
> -
> +               schedule_refill =3D true;
>         if (running)
>                 virtnet_napi_enable(rq);
> +
> +       if (schedule_refill)
> +               schedule_delayed_work(&vi->refill, 0);
>  }
>
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3728,7 +3731,7 @@ static int virtnet_set_queues(struct virtnet_info *=
vi, u16 queue_pairs)
>  succ:
>         vi->curr_queue_pairs =3D queue_pairs;
>         /* virtnet_open() will refill when device is going to up. */
> -       if (dev->flags & IFF_UP)
> +       if (dev->flags & IFF_UP && vi->refill_enabled)
>                 schedule_delayed_work(&vi->refill, 0);

This has the assumption that the toggle of the refill_enabled is under
RTNL. Though it's true now but it looks to me it's better to protect
it against refill_lock.

Thanks

>
>         return 0;
> --
> 2.49.0
>

