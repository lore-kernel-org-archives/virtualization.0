Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E227C24B4C
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFcM05VT"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5141981ECF
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 09:44:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5141981ECF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OFcM05VT
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XkTTHE4qqPeV
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 09:44:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8265981ECC
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 09:44:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8265981ECC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704447850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NIwLDUnI8NrUa1yoEmDStM8G2YxoAzCn45gUwvCVLMU=;
	b=OFcM05VTLt+3nrRea+aGtZBkDYzzzA3pvu3bkko0RGl7A2UFxnk0Al1dVVpvBgzWtSFMEo
	49EsMcOnMpjml7rD3aGgeinKp0xfrlUlkFmPKYdHMC3uwOJXtlP3b6AbJB9nB9t59FBMEw
	7+xXRNi9HMvWA49dBd5fZB7iCaG/P4A=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-6MCzwRmZNPOVXALoCi2l4g-1; Fri, 05 Jan 2024 04:44:02 -0500
X-MC-Unique: 6MCzwRmZNPOVXALoCi2l4g-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5eb8b6e777cso23398707b3.0
        for <virtualization@lists.linux-foundation.org>; Fri, 05 Jan 2024 01:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704447841; x=1705052641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIwLDUnI8NrUa1yoEmDStM8G2YxoAzCn45gUwvCVLMU=;
        b=XC3mP9lBS17kNb5wZC+BBYC+H552yZz3AR7hKaZOZbEw6W7qUiHZXvtcm7AAEcuu0W
         t/ebpfpcHvpB21p3Ip21PjNODqvbc7uF/SRRqsGWWyVhrGS6xMoCQ8YxPtQjCsFRnXo+
         Ijk1UYXsDDbTYEYqSNiXSomGgpKID9jiQVzmOIlmRkDmvTv7n+Uqj4xD6nIBtLyzbdgt
         zlRGJ7wntdZDezwPKyqFuQ4TjaElja7di5TjjoMBd/k1df5KhlAogRQXxKXODwZwH1w1
         WVPfWCRABVFoqORBpJpBeedUXsnIPF9B7mzFcLTiE3Zz3iIssef5DHUKOidOfmQA5lmd
         tF6A==
X-Gm-Message-State: AOJu0YzyVRuAVMRyKYiVl6raCRTKFFh04q7jsIMInIor+Lpcg9zsaar5
	+BkG4QfBvY17kvLRxoqvwxVbw8Typ98vk3H6aeID2o+v5keoO1Q//884o0cRSZ2rmmhr/fvvpwm
	2PVdye53gQcQrnEFR+4rc6vYzOgWHE2Q9WQ3O/W5aWgagD8TTtDyHYfZ6CwHRJG3IDA==
X-Received: by 2002:a0d:c042:0:b0:5ee:26aa:3d4 with SMTP id b63-20020a0dc042000000b005ee26aa03d4mr2038724ywd.43.1704447841456;
        Fri, 05 Jan 2024 01:44:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdAnA+xpbtbCqAMIEPbTW4gOvzkqFdMNwKSJx2Twyuke/V55aRkeGQnX3n3kmSfq6u7un2p348fwv2H8hb6Zc=
X-Received: by 2002:a0d:c042:0:b0:5ee:26aa:3d4 with SMTP id
 b63-20020a0dc042000000b005ee26aa03d4mr2038711ywd.43.1704447841236; Fri, 05
 Jan 2024 01:44:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com> <20240104153753.2931026-2-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-2-maxime.coquelin@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Jan 2024 10:43:25 +0100
Message-ID: <CAJaqyWd4UGpzscP=veX3DeyOF2gF6B2crQ6-R_Eo2tncZLgyAg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] vduse: validate block features only with block devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:38=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch is preliminary work to enable network device
> type support to VDUSE.
>
> As VIRTIO_BLK_F_CONFIG_WCE shares the same value as
> VIRTIO_NET_F_HOST_TSO4, we need to restrict its check
> to Virtio-blk device type.
>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 0ddd4b8abecb..0486ff672408 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1671,13 +1671,14 @@ static bool device_is_allowed(u32 device_id)
>         return false;
>  }
>
> -static bool features_is_valid(u64 features)
> +static bool features_is_valid(struct vduse_dev_config *config)
>  {
> -       if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> +       if (!(config->features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>                 return false;
>
>         /* Now we only support read-only configuration space */
> -       if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
> +       if ((config->device_id =3D=3D VIRTIO_ID_BLOCK) &&
> +                       (config->features & (1ULL << VIRTIO_BLK_F_CONFIG_=
WCE)))
>                 return false;
>
>         return true;
> @@ -1704,7 +1705,7 @@ static bool vduse_validate_config(struct vduse_dev_=
config *config)
>         if (!device_is_allowed(config->device_id))
>                 return false;
>
> -       if (!features_is_valid(config->features))
> +       if (!features_is_valid(config))
>                 return false;
>
>         return true;
> --
> 2.43.0
>
>

