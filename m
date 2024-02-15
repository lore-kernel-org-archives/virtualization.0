Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC11EA7C
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708023388; cv=none; b=QvivVWoP2KM3REvhcJTIr0MN6j2njXvFgulJ7WToATWV25lPFB5tpL1/KhTLmm4we/hFQ7QgNK4VVaQbV0yIGe/5ml5VxLk2YmYCaFVBX8lz+dH+h2qnJNxhZCT8RrPs1baJVnswLdDoAI7qfTolB5SvxUxIV5obSVoZIWIOuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708023388; c=relaxed/simple;
	bh=iswaJizGMrxVOmW3tqLPz6j8KXZ8Pl63RUc6c0uW2W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPH5wWyrWvxKRIu6OJtP1O8Bm5emTK7uxefoJLqu43QBJnnyb2DSmA5Sh+ZIBzzzs6ZoLKcbQrmnvHnqJJ0HkgXhp6CZ7CwoAuYewa4qhqZYnOepb7RSxATbY7eARrYSDJucK+4dTI0c4GWvjpZxYaULvyIosJBEcgQob/Z3fzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iEvuog8z; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEvuog8z"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6757683CB2
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 18:56:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GYkEXgRjnIPg
	for <virtualization@lists.linux-foundation.org>;
	Thu, 15 Feb 2024 18:56:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9E9C082ACD
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E9C082ACD
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iEvuog8z
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9E9C082ACD
	for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 18:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708023384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVTAdOQgmER8bWwfNlNP64Nqike+7HMVq029igBvOfw=;
	b=iEvuog8zTjIbYQOoEEAKOINGc9xvYkSq7isdLVAKZyWp9iahZ5pjtR4ZFVUDxVOR4oqJA1
	AeR94oBWfv6vOSqquCg4wtMUwl0DKn9bqn2yDjbtiFjhFO2RUuGR0OJOlBVlADKnWVfhIi
	CwqbfiWfTclPFypJT2KNd3ylhDoGXqA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-0Wp7eEuFNHaSdXoGGmECjQ-1; Thu, 15 Feb 2024 13:56:22 -0500
X-MC-Unique: 0Wp7eEuFNHaSdXoGGmECjQ-1
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-dc647f65573so1955331276.2
        for <virtualization@lists.linux-foundation.org>; Thu, 15 Feb 2024 10:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708023382; x=1708628182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NVTAdOQgmER8bWwfNlNP64Nqike+7HMVq029igBvOfw=;
        b=XyCkxkl7aRxbnqGZkydX1ob3nUNo7NdP1V3QU8KkxbUqSg6FppPVbTtKDEHTnh56Sf
         dChxU0NPslamMOEXGWLo2cWmocI5knPW66Gc1vNT41Aipl2DZ6N/B4jmkMfE5BUNPEvO
         OlRbZFLraviwGopCNmWedrVGYn4KZIlU28eC5DdL879kdEof8xkpXgU592uvQ/qSAiL/
         BYkU9AvfTTBqZNc6nwZxY4KY0fm5C/FMxAbBgJ51X91GAIcv6crLNqtQVi5r0jDM8q/p
         odUChD1l6GGKJjZEh9M7sNxWkMUlLdOWo964lVnw7GptIwnJfCn7SG9eVylIyMq2dQqJ
         hVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhWtoHZJkP7eGRdLc+9FU1jwy42L4u8A8DJToYY11Y5m6YPt2KANsxbTyTlmV7o7RlLEnQn9nrhPt58ZpHcEAKTP6FzFfUbT/PewKGd6P7bMAYhizW02oBZQ==
X-Gm-Message-State: AOJu0Yzgjz8g47E4/oc2ZeuCLoHtW323zePiV9NFMfN91Kp9rFLmzPck
	560nJdjS8K1icDzvFK/nTwD8D7Hd5hgGbsoBlaqAADjLvVx/uYCaBoJT4qTsorZyj72qO4wLfG7
	N0diYBD5kqf0f6VjXZOq+KkmSj9mkRpgxDlctmceApGbE71Wl2EDCqXWjdjxv78IdmGCppQxOeE
	xZo9z9wmLWJtOS7346fJZw2bXEUpQ9TdaWicv0iA6ZsJ8/aYO5QZnyIQ==
X-Received: by 2002:a25:bccd:0:b0:dcc:d5aa:af36 with SMTP id l13-20020a25bccd000000b00dccd5aaaf36mr2616575ybm.44.1708023381998;
        Thu, 15 Feb 2024 10:56:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDZAWrZQHZwTTGxiFWzK4+OnTMnpfQAuYH7F0IALB8lvCCVYA1DJjBf4dGnc/en+JqKuCk47DS59xeHe2cL/w=
X-Received: by 2002:a25:bccd:0:b0:dcc:d5aa:af36 with SMTP id
 l13-20020a25bccd000000b00dccd5aaaf36mr2616566ybm.44.1708023381753; Thu, 15
 Feb 2024 10:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240215170507.3865986-1-jonah.palmer@oracle.com>
In-Reply-To: <20240215170507.3865986-1-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 15 Feb 2024 19:55:45 +0100
Message-ID: <CAJaqyWfRYj5+BCV5KRmj1xRUtaFg5ixU9SPciqyMRLfJ7ztu2g@mail.gmail.com>
Subject: Re: vdpa/mlx5: Allow CVQ size changes
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: si-wei.liu@oracle.com, virtualization@lists.linux-foundation.org, 
	dtatulea@nvidia.com, boris.ostrovsky@oracle.com, leiyang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 6:05=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
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
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index 778821bab7d9..c74de1fe6a94 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2276,9 +2276,15 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_devic=
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
> +                cvq->vring.vring.num =3D num;
> +                return;
> +        }
> +
>         mvq =3D &ndev->vqs[idx];
>         mvq->num_ent =3D num;
>  }
> @@ -2963,7 +2969,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mv=
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

