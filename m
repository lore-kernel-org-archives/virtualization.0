Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE91652
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Feb 2024 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708304972; cv=none; b=gC08E06DoFtTRMQDFOloASScWi4UZ483WC1jscvHQxD5HA3ciiKgv7NxYzT2bTGQm+I/LbeHdaaai5Nv2rjY2qZgo/GY7OzD8D5BPb4V8gaBPbecZfvKnkQHtPrLk44FX3uvu/O0rA2MTNbqRKcnmRdGk8U6PVPVAv2aC+P/A1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708304972; c=relaxed/simple;
	bh=kPxrv7W2yIJaZMQ1+gJwIp+HhCy5zI4R+ySZbaEIjB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvRcX/QiFKAvytaF4lEbzA39n8C4OtgE3NRIa9luv2AUtpufV5QQin4Sc+/lQ3/EKe4NccIPtKYUfGI9W7ce/io+3uq+7GPOMW1qL5kL2EGclC0QrSeVRHpJlwEpPuISJloVMxkHb7+rEf+hkYJ3FiWAnlIPmhtGpWVRi0fCeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z0D20dPv; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z0D20dPv"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7FD5880AF8
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Feb 2024 01:09:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id naDfr-mVyK92
	for <virtualization@lists.linux-foundation.org>;
	Mon, 19 Feb 2024 01:09:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=leiyang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org ADB8680AF6
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADB8680AF6
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z0D20dPv
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADB8680AF6
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Feb 2024 01:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708304967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8FH/IGXGIzL7Qe7et2w95vW7pDGEVjgey8bcDbORJ2E=;
	b=Z0D20dPvPMD6yIoXLgC93DocAGWnJZllQMSVF8yBFGah2yi7s2kzW2aspt5bsqTCPb0w+O
	qBgSNAd1tc3UGr2hH4Xtjk39hyRr83V8qE1aNF3qToJ3yBxY1CsV6qfJy4Ap42GSyd3N2n
	XszVnPcICkAMuoqoS/jedJ3hwDE7Yw4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-d8nB7cg8MQ68fV20rOobQg-1; Sun, 18 Feb 2024 20:09:25 -0500
X-MC-Unique: d8nB7cg8MQ68fV20rOobQg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5647132e2aeso212420a12.1
        for <virtualization@lists.linux-foundation.org>; Sun, 18 Feb 2024 17:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708304964; x=1708909764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FH/IGXGIzL7Qe7et2w95vW7pDGEVjgey8bcDbORJ2E=;
        b=Ns9B2Q8Mqaddht9zdNINmgTkiJs3kqwR5rcwsXqN1PdccEpJNQ0w4WlRcRBdha23gH
         Uymee6xDrUR9Fubj+grZ25a0WG+Qt1u7rHPCGsYVKvuRT4QgMQXh+zpTBwGVs4MR3fEa
         54A+rZGK+WT2o+7CiVYcqPpWUr4d7jFKMqwmEIxmr7Ch4jhmoITvUPXWQFT+64HZPdjA
         8e50DaARyaks9EHnoNQeGQRTq6EB0HLXwBAhhHblA+ETN4okEYXrRsyaaqn3kw1f1OG5
         2bCO53/DneHF9mTIQha4dqtFOequUbjIMxdDHM1YzTCmYsKbUhgkosu4bFbqkqzj0XpW
         cQ9A==
X-Forwarded-Encrypted: i=1; AJvYcCUVmVn1xldInkkowUhqBfZjGBm76lflWsFJpkLvLQONbn+8uq9LvXQCKgrOtxvw4a2Fh/90Mo6bUT8fiKK0lX1eA5Qx/EqXf50WbVSMsVQzNCytyaolW8onng==
X-Gm-Message-State: AOJu0YwW6Pon0uoh3iK1Hf1r+5DmTi8iqZAHzKvmaFyQYS5sLf4srH0g
	kpXoH0+5lyv7FUNdmBk9v3XSo+k/V0KhXwb0IuHrBph4/Z5VVK6hSBaGi3XOrA7OjxwB5inqMrk
	Dpi/xVsablXnplSZMpmembNO9Bj1HbfUj6a7U3dLLolZmlgPLOz39YfqxSaLxyXDMR52TiAyGLW
	5Dle+JPoenzbSmxED9nZcn09bRB7/xL8Tobq7UbGdOj2tAySPBNIyRbQ==
X-Received: by 2002:a17:906:b785:b0:a3d:6160:fcca with SMTP id dt5-20020a170906b78500b00a3d6160fccamr9138341ejb.69.1708304964560;
        Sun, 18 Feb 2024 17:09:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2skZ0uE5cETDN0mtHmDLiYuDbMpFEFyh55kaJoE+fMvltoEYczRmuSuwF6ckMHLeGtM1ZbxIq+RQSU3/YY/M=
X-Received: by 2002:a17:906:b785:b0:a3d:6160:fcca with SMTP id
 dt5-20020a170906b78500b00a3d6160fccamr9138336ejb.69.1708304964285; Sun, 18
 Feb 2024 17:09:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240216142502.78095-1-jonah.palmer@oracle.com>
In-Reply-To: <20240216142502.78095-1-jonah.palmer@oracle.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 19 Feb 2024 09:08:47 +0800
Message-ID: <CAPpAL=zp+VxFUNw5W2jB0ENhYZ4Ts5+gAH7cQu-7LMhFnApqrA@mail.gmail.com>
Subject: Re: [PATCH v2] vdpa/mlx5: Allow CVQ size changes
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, si-wei.liu@oracle.com, 
	virtualization@lists.linux-foundation.org, dtatulea@nvidia.com, 
	boris.ostrovsky@oracle.com, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

QE tested this patch's V2, qemu no longer print error messages
"qemu-system-x86_64: Insufficient written data (0)" after
enable/disable multi queues multi times inside guest. Both "x-svq=3Don
'' and without it are all test pass.

Tested-by: Lei Yang <leiyang@redhat.com>

On Fri, Feb 16, 2024 at 10:25=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.=
com> wrote:
>
> The MLX driver was not updating its control virtqueue size at set_vq_num
> and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
> setup_cvq_vring.
>
> Qemu would try to set the size to 64 by default, however, because the
> CVQ size always was initialized to 16, an error would be thrown when
> sending >16 control messages (as used-ring entry 17 is initialized to 0).
> For example, starting a guest with x-svq=3Don and then executing the
> following command would produce the error below:
>
>  # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done
>
>  qemu-system-x86_64: Insufficient written data (0)
>  [  435.331223] virtio_net virtio0: Failed to set mac address by vq comma=
nd.
>  SIOCSIFHWADDR: Invalid argument
>
> Acked-by: Dragos Tatulea <dtatulea@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 778821bab7d9..ecfc16151d61 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -151,8 +151,6 @@ static void teardown_driver(struct mlx5_vdpa_net *nde=
v);
>
>  static bool mlx5_vdpa_debug;
>
> -#define MLX5_CVQ_MAX_ENT 16
> -
>  #define MLX5_LOG_VIO_FLAG(_feature)                                     =
                           \
>         do {                                                             =
                          \
>                 if (features & BIT_ULL(_feature))                        =
                          \
> @@ -2276,9 +2274,16 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_devic=
e *vdev, u16 idx, u32 num)
>         struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
>         struct mlx5_vdpa_virtqueue *mvq;
>
> -       if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
> +       if (!is_index_valid(mvdev, idx))
>                 return;
>
> +        if (is_ctrl_vq_idx(mvdev, idx)) {
> +                struct mlx5_control_vq *cvq =3D &mvdev->cvq;
> +
> +                cvq->vring.vring.num =3D num;
> +                return;
> +        }
> +
>         mvq =3D &ndev->vqs[idx];
>         mvq->num_ent =3D num;
>  }
> @@ -2963,7 +2968,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mv=
dev)
>                 u16 idx =3D cvq->vring.last_avail_idx;
>
>                 err =3D vringh_init_iotlb(&cvq->vring, mvdev->actual_feat=
ures,
> -                                       MLX5_CVQ_MAX_ENT, false,
> +                                       cvq->vring.vring.num, false,
>                                         (struct vring_desc *)(uintptr_t)c=
vq->desc_addr,
>                                         (struct vring_avail *)(uintptr_t)=
cvq->driver_addr,
>                                         (struct vring_used *)(uintptr_t)c=
vq->device_addr);
> --
> 2.39.3
>

