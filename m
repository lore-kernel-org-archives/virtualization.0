Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AACF4C629
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aAYeNCKu"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1CF04161A
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:12:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1CF04161A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=aAYeNCKu
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1c_uDj2-xxlW
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:12:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9EB8415E7
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:12:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9EB8415E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703088754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vEaUEcnajrqgltfyosH4+omdF/fMexYhj4bOk+VvvgM=;
	b=aAYeNCKuFX0LtNZanY07NyIxH4iv+eNmZ4oc7aUEAz48jU/L3OTGNT5IDuaG2ffxGWJpXH
	m09PokzsUDXGLJg6oLyvBtHGu2vWNFcKOpCyXS5/g7Dr0DvUjONN0p47/NOk9o21ui4C5v
	0GfSZtMhMvpxzeudYHRYJjk2c6+RYfA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-M5jPG8UcMs2S3GVy98HlSA-1; Wed, 20 Dec 2023 11:12:32 -0500
X-MC-Unique: M5jPG8UcMs2S3GVy98HlSA-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-5e763e03f4dso29462697b3.2
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:12:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703088752; x=1703693552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEaUEcnajrqgltfyosH4+omdF/fMexYhj4bOk+VvvgM=;
        b=SCHr1jE0F2W/X/8/sqwRnng2EEnNk1ps6pJ9IR04+9YVJcPkA+fmF/xffQQPmOBxa+
         Ac325nJwqWuBfOUUgsaJTqpUIwA2EuwB97msaXU03+uLyQoSzCJ7Yk+ZEXZ/v8p21w6T
         R5AeB8rBh0RerKOmFTPPGl7yVRcHTQFqpmRlCkOZ6c7P1atIo1wQh3sdQa0LEwVelL0c
         zf9rS1OnEEPA4AN66/NLGFcbKesI492s78tGv0ux9cv72AgYaSDHNaR4/gv11MsHmZj/
         nOpi50gn5RvwfRYzPKavN0ytSjKC7W+7IntgxSdS5TpmmRylIxDmV6T2c84Jq5eFC4NP
         FwpQ==
X-Gm-Message-State: AOJu0YyR0Ck0XearJPNTDayG8uOoJaDfaGKplfTwd0eyIQXnZwxcxO6U
	GnHcvDYHUSr+tBbrKEr4prEQHN1HR+QjhaREz0xeqklLhJEg2/zgItxwHwXci3TMdDTyrLPI5cM
	nd7gt8dhT66hTfhnEtuYR1ipOtys2dL5VXi6xrPQ5cBoJ3roQN7ksQWxyXw==
X-Received: by 2002:a25:b28c:0:b0:dbd:ae7b:fa8 with SMTP id k12-20020a25b28c000000b00dbdae7b0fa8mr579083ybj.89.1703088752243;
        Wed, 20 Dec 2023 08:12:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHWUzQ5gSLWTlGDWQ2EyGysa9J4p1aJm/bZyTvMiHKlVwkL61HZXv/dGZYlfl74NKZqaTdvxihWh9dq51N+XM=
X-Received: by 2002:a25:b28c:0:b0:dbd:ae7b:fa8 with SMTP id
 k12-20020a25b28c000000b00dbdae7b0fa8mr579074ybj.89.1703088752028; Wed, 20 Dec
 2023 08:12:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-5-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-5-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:11:55 +0100
Message-ID: <CAJaqyWeZK5WmZRnUv4+MF=A1ALsx_OOcWHXDV1EquwpBhTkVJQ@mail.gmail.com>
Subject: Re: [PATCH vhost v4 04/15] vdpa: Accept VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND
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
> index da7ec77cdaff..2250fcd90e5b 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -749,6 +749,7 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                                  BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
> +                                BIT_ULL(VHOST_BACKEND_F_CHANGEABLE_VQ_AD=
DR_IN_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK)))
>                         return -EOPNOTSUPP;
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
> --
> 2.43.0
>

