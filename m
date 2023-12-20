Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02024AF91
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jnkv2fLH"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FEA961527
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:12:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3FEA961527
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Jnkv2fLH
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yAl89wFsfxzM
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:12:54 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 74CCB61524
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74CCB61524
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703088773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/R2O8TJ4542iZyXv/uB6h7A35AJkq8aJE1UHdDp43cM=;
	b=Jnkv2fLHkaQdxM/NL9/IWEXWG4NGcLqNBP1zG99IbjKL+c+DHmwv0kJ+BtScsPq/eK1EnQ
	ACFLhjRuOEWqPCRQHFeZonjtZSU58dl/rGklIMz2jqWE1nTJr5SHXAGrgsAa8MNxXS4D6I
	PvbLLthGlbxQfX3d61LyJAW4aKKCK6I=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-hnHh3Ao8Mw69QEAHsjWrUQ-1; Wed, 20 Dec 2023 11:12:51 -0500
X-MC-Unique: hnHh3Ao8Mw69QEAHsjWrUQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5e73e6a17d5so44106077b3.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:12:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088771; x=1703693571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/R2O8TJ4542iZyXv/uB6h7A35AJkq8aJE1UHdDp43cM=;
        b=n4W6yuiW0dkO8to9isrzF+HMmaw/b4g+F6+uzbrGWqDNvpO8uxCIZwtpv9uWX2Rbm7
         MDNeWnM/nSQJ0LE1a6TUslcaxXMC22fNyOk7tMPce9Pn51fUHmZlfmaA2/riDHn41D//
         00p220TM3g+jFQofWMFk3fSs7dJaGrWFhH3+DGQiT3mkgnAFF8QufQW4V2GlpdS3+4Vp
         JRZWCOktmDebDaSWU5bdLsleXBFn8qlQlYn4PdIWjDUzdcFxLDx/hYh1sns18AsmfzsD
         IK+qtPkqwFsrSB2AEkEw7JGVzh+gUxfNA97fogu4y37yt8WNKipQ9y0xAAo8Fw6FpNTI
         0lSA==
X-Gm-Message-State: AOJu0YwkDYli6yuT1+1/LLgFlDUEQHog17Pk3yiEj4bwqURRaZk8Biqf
	hmwdLHG99mSlWYSEUKJyGlvRQQ4NiVhZgTPPhNIwdOLvKWSy30bjfa2IIJWFQyM3c6Pmz7n24pH
	mQJbPudxzD4cb/AGEas/7G6i+iGYQ1FZT99cl5RYsguaz4P0GdvV7krrc2A==
X-Received: by 2002:a0d:c484:0:b0:5d7:1940:dd79 with SMTP id g126-20020a0dc484000000b005d71940dd79mr16406968ywd.79.1703088770846;
        Wed, 20 Dec 2023 08:12:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl9HuJvZdKloOZeydrDbBWg/CYLQwNnyxXZYFdRHvKNBSwps+IR8b+dmnGiDTqDuL+cw7PJL7bJDjI3MeSc9E=
X-Received: by 2002:a0d:c484:0:b0:5d7:1940:dd79 with SMTP id
 g126-20020a0dc484000000b005d71940dd79mr16406957ywd.79.1703088770610; Wed, 20
 Dec 2023 08:12:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-6-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-6-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:12:14 +0100
Message-ID: <CAJaqyWfXnRNDzCL3GgdQby7ZmKxxRic5wsi2RTX24sa1Lz4F4g@mail.gmail.com>
Subject: Re: [PATCH vhost v4 05/15] vdpa: Accept VHOST_BACKEND_F_CHANGEABLE_VQ_STATE_IN_SUSPEND
 backend feature
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Si-Wei Liu <si-wei.liu@oracle.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, virtualization@lists.linux-foundation.org, 
	Gal Pressman <gal@nvidia.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 7:09=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> If userland sets this feature, allow it.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 2250fcd90e5b..b4e8ddf86485 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -750,6 +750,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
>                                  BIT_ULL(VHOST_BACKEND_F_CHANGEABLE_VQ_AD=
DR_IN_SUSPEND) |
> +                                BIT_ULL(VHOST_BACKEND_F_CHANGEABLE_VQ_ST=
ATE_IN_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK)))
>                         return -EOPNOTSUPP;
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> --
> 2.43.0
>

