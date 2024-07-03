Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95A918308A
	for <virtualization@lists.linux.dev>; Wed,  3 Jul 2024 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023704; cv=none; b=JO49XSPy6kBP0uE3kU6WgV44SV5EsqRcxnLjll05eiqDxLobQfr0O42nIl/811mrtNPe82wcr0suSyEgyDU7vKYGxG8kBdhJV4C5505AlbkgFhAxYjq8EPJfPKWjrJhoMwCylNH38WmQP31U26ABQBHNuGPSPb2e2YviqmknQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023704; c=relaxed/simple;
	bh=TcS0Nab4P1uInJHhXVtq4QA+KS6M5rJkuPOwVobX3GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdfvIZ/Vyb5c0hC/3FDna0dBtbiEZodKxgej2BbZBVGaX3E776OLANEAi22cfRfjgYZT4JnU8e4vYjP7WXU0lSLEeB3WIiNfDPUdspiFqlFSHchsXv80/t1cg+bmSDvSANLTwaMx63vMAH/OW1KPAhc6bvsJYm8BmVxXS50tvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ezuJzVc8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ezuJzVc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720023701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RvzgALGPKTw1bigvFfaZyijkP2+PzdDyQ0IADPOqqJg=;
	b=ezuJzVc8UOPBaQWGQJaWDHmAWZgzKLjDmsxIlmSrRUatxAW8fPSsDgPJT8HRB2Q0YSYdwG
	Mz4qHLp8hzX3BCl5OoNZ14KoxwK4r/HAy9XhCCGUZxKiaYK8RR8WUTFA0hwkzxiOyU+J8S
	9P2zqVp8RSFyY6qva5owpxXge+LfwGY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-RvAbXWWpPUWcS_9z9_OHow-1; Wed, 03 Jul 2024 12:21:40 -0400
X-MC-Unique: RvAbXWWpPUWcS_9z9_OHow-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-58b3fcf235dso1772967a12.2
        for <virtualization@lists.linux.dev>; Wed, 03 Jul 2024 09:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023699; x=1720628499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvzgALGPKTw1bigvFfaZyijkP2+PzdDyQ0IADPOqqJg=;
        b=oClrwb7zgsoPqsr/w867AEJz8p47cviCgvXq0rBYqY4K94fbnGqGPbWbWmZEvOZafl
         41Bu3NyY81Wu5WxCNmSMo2sNK+bGKLDszzRlkHvZ1oid7klcG8mMMNzjlbbYjWLXaRAh
         HkP5AXEUGZmkH8Zol8N+tlMaflvoYau1hZa+HKDv9ESbnospNsvMC5xIQ4KoiFfUS+Qj
         VybyNc5/oRwIrcfybkoqvEelTStDYc0VVFWzKjylWNAQTLqjaKD46QaWFiQQlkFysVjq
         1Bw3PO8fX3tmnMEDq8s6KXYeLFTcFsgPq/Isofduw/iOGCCW8CNU3oWAMysRcWCmgl8t
         eUDg==
X-Forwarded-Encrypted: i=1; AJvYcCW5B+j2+QbjuqSHrqY5Tea7tXrLG9rkYf0jHZjQOYdVc1qQ/1bmaD6/srWIncvgPDt+gXpHdkVd5DlYlcP3gqurWuHLYnf5O4OdSVK3X1Q=
X-Gm-Message-State: AOJu0Yzk4/5Nwb+6spnZpV9Lj7TgPviR68ZLSGm+6t8+f9Si82+cnH/Z
	aJA845XJV4IzlFymG92tLf6VMpGRXa9jZotkvxRlM2lEjZSYSFbbLSJDNF7GJm8BFfnb49M7ZLm
	pAXTcqN4dPHaYR6G3XSRey7DYUF0Jgp//tlsKMxfzYvri4YsY70K5+CqSPyBvvvXNhDvoaMHVEv
	/LYomieP+uKmL3ORTtyphLNw6CRUuZYtILGLOpIhk=
X-Received: by 2002:a05:6402:2113:b0:57a:2ccb:b3f2 with SMTP id 4fb4d7f45d1cf-5879f59bc0dmr8314482a12.16.1720023699470;
        Wed, 03 Jul 2024 09:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLrQmfzqoCkSKEjGQCytFKKt1qFveCCZLiKDvdyFB5I6punigduS2DoMmXGBJNBjrgv6P7Ec5gPWUP4aOKX74=
X-Received: by 2002:a05:6402:2113:b0:57a:2ccb:b3f2 with SMTP id
 4fb4d7f45d1cf-5879f59bc0dmr8314456a12.16.1720023699020; Wed, 03 Jul 2024
 09:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240626-stage-vdpa-vq-precreate-v2-0-560c491078df@nvidia.com> <20240626-stage-vdpa-vq-precreate-v2-16-560c491078df@nvidia.com>
In-Reply-To: <20240626-stage-vdpa-vq-precreate-v2-16-560c491078df@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 3 Jul 2024 18:21:01 +0200
Message-ID: <CAJaqyWdK4u0Y2EbgyWsYupLvybuBK=waf_qhUqne2q9wHvuEqA@mail.gmail.com>
Subject: Re: [PATCH vhost v2 16/24] vdpa/mlx5: Accept Init -> Ready VQ
 transition in resume_vq()
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	Cosmin Ratiu <cratiu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 12:28=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Until now resume_vq() was used only for the suspend/resume scenario.
> This change also allows calling resume_vq() to bring it from Init to
> Ready state (VQ initialization).
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 0a62ce0b4af8..adcc4d63cf83 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1557,11 +1557,31 @@ static void suspend_vqs(struct mlx5_vdpa_net *nde=
v)
>
>  static void resume_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq=
ueue *mvq)
>  {
> -       if (!mvq->initialized || !is_resumable(ndev))
> +       if (!mvq->initialized)
>                 return;
>
> -       if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND)
> +       switch (mvq->fw_state) {
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_INIT:
> +               /* Due to a FW quirk we need to modify the VQ fields firs=
t then change state.
> +                * This should be fixed soon. After that, a single comman=
d can be used.
> +                */
> +               if (modify_virtqueue(ndev, mvq, 0))
> +                       mlx5_vdpa_warn(&ndev->mvdev,
> +                               "modify vq properties failed for vq %u\n"=
, mvq->index);
> +               break;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_SUSPEND:
> +               if (!is_resumable(ndev)) {
> +                       mlx5_vdpa_warn(&ndev->mvdev, "vq %d is not resuma=
ble\n", mvq->index);
> +                       return;
> +               }
> +               break;
> +       case MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY:
>                 return;
> +       default:
> +               mlx5_vdpa_warn(&ndev->mvdev, "resume vq %u called from ba=
d state %d\n",
> +                              mvq->index, mvq->fw_state);
> +               return;
> +       }
>
>         if (modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_ST=
ATE_RDY))
>                 mlx5_vdpa_warn(&ndev->mvdev, "modify to resume failed for=
 vq %u\n", mvq->index);
>
> --
> 2.45.1
>

