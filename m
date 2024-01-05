Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9915B250E7
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JzB2nUyL"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22E6861445
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 10:00:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22E6861445
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JzB2nUyL
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vOggkdi5I9rp
	for <virtualization@lists.linux-foundation.org>;
	Fri,  5 Jan 2024 10:00:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4E5D661442
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jan 2024 10:00:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E5D661442
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704448845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDTL7eZEwQEt4FJfs0Pl8u53p2yeEWxqLY7MxE4u220=;
	b=JzB2nUyLdYe3+1pJ9eZKxlNlQZY3/+4FrRlSk20JxZ1dd9yTTteIEVw95Ekze0RMpP9IIz
	CzgQNg0AGCxEt0BtHB1itx2WIMur7EKwRllr9Bz4BO+wiyFS94vPooxx6eLgDnqOd9pjP0
	nyHSiOWELo3PoRmPCoO8/OLdccmaz+o=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-pyTvqIPIOmOUFe2zDr4guQ-1; Fri, 05 Jan 2024 05:00:38 -0500
X-MC-Unique: pyTvqIPIOmOUFe2zDr4guQ-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5e8996ead39so30053397b3.3
        for <virtualization@lists.linux-foundation.org>; Fri, 05 Jan 2024 02:00:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448838; x=1705053638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WDTL7eZEwQEt4FJfs0Pl8u53p2yeEWxqLY7MxE4u220=;
        b=bzY693TuDYyLkjjOBcwEfZlgKtB34W7aIkJO0XLBwp1QCx1RQFIorndA9M/oQG5Vds
         mSEFppTd1UmAT4uoGVjTZWV/k4TfixUsex7YsRALIUcBwIxAueNZq8F2C26BoOhipL4G
         Q143XGLeHg4c9Ytf1WxdV9+du9abY+VmnV0yy8OoSO3i1ZdfFM/SNLrGsh6jlH6bwKYG
         3fZCfMIqbiRGtgA8bsocDgLCm90BHoO4r0ybzT5q1yF6/Ph1QpT0BsVvpDWaSMaPwV6k
         gdUbHqgZXQM4gbiTYuvuGQ3bZS3a3vVO/EcUdQFy3xliAiUJsoBFOba+O2KjNAljQC07
         eFIw==
X-Gm-Message-State: AOJu0YweksCQbyhTy6HUhDS44QvRUg+fEjOgt34q+eW8w4s16/YADJEa
	ulpaOkO4rV8IJVGbzhitERvy3mva0sKAqG2MQGvxrVZ3zVU6b2c1HPuCdOuM6TGr9Bfvu4U3mhC
	LZx2Zne8C4UKnifQVQUI/inigca/4pcDzfjZjZTWBCvKR5kzgdgivVMxMDPIj885DRg==
X-Received: by 2002:a81:5c07:0:b0:5e7:a7f6:47ee with SMTP id q7-20020a815c07000000b005e7a7f647eemr1962165ywb.80.1704448838215;
        Fri, 05 Jan 2024 02:00:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHp80U4Fd+oLUI0ZzXKfeVM274HiCmXkNGJQljLBxBgi1oqb8H43lLPLE8Q4KVwka5d4Qc9Wk8GVOawxsKqLKk=
X-Received: by 2002:a81:5c07:0:b0:5e7:a7f6:47ee with SMTP id
 q7-20020a815c07000000b005e7a7f647eemr1962155ywb.80.1704448837970; Fri, 05 Jan
 2024 02:00:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240104153753.2931026-1-maxime.coquelin@redhat.com> <20240104153753.2931026-4-maxime.coquelin@redhat.com>
In-Reply-To: <20240104153753.2931026-4-maxime.coquelin@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 5 Jan 2024 11:00:01 +0100
Message-ID: <CAJaqyWeMwC9-GFq4VpaES1NDTNziUnQ7PkD3xPfoYvVsCSvaqg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] vduse: enable Virtio-net device type
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	xieyongji@bytedance.com, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org, david.marchand@redhat.com, lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:39=E2=80=AFPM Maxime Coquelin
<maxime.coquelin@redhat.com> wrote:
>
> This patch adds Virtio-net device type to the supported
> devices types.
>
> Initialization fails if the device does not support
> VIRTIO_F_VERSION_1 feature, in order to guarantee the
> configuration space is read-only. It also fails with
> -EPERM if the CAP_NET_ADMIN is missing.
>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/=
vduse_dev.c
> index 94f54ea2eb06..4057b34ff995 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -151,6 +151,7 @@ static struct workqueue_struct *vduse_irq_bound_wq;
>
>  static u32 allowed_device_id[] =3D {
>         VIRTIO_ID_BLOCK,
> +       VIRTIO_ID_NET,
>  };
>
>  static inline struct vduse_dev *vdpa_to_vduse(struct vdpa_device *vdpa)
> @@ -1694,6 +1695,10 @@ static bool features_is_valid(struct vduse_dev_con=
fig *config)
>                         (config->features & VDUSE_NET_INVALID_FEATURES_MA=
SK))
>                 return false;
>
> +       if ((config->device_id =3D=3D VIRTIO_ID_NET) &&
> +                       !(config->features & (1ULL << VIRTIO_F_VERSION_1)=
))
> +               return false;
> +
>         return true;
>  }
>
> @@ -1801,6 +1806,10 @@ static int vduse_create_dev(struct vduse_dev_confi=
g *config,
>         int ret;
>         struct vduse_dev *dev;
>
> +       ret =3D -EPERM;
> +       if ((config->device_id =3D=3D VIRTIO_ID_NET) && !capable(CAP_NET_=
ADMIN))
> +               goto err;
> +
>         ret =3D -EEXIST;
>         if (vduse_find_dev(config->name))
>                 goto err;
> @@ -2044,6 +2053,7 @@ static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtd=
ev_ops =3D {
>
>  static struct virtio_device_id id_table[] =3D {
>         { VIRTIO_ID_BLOCK, VIRTIO_DEV_ANY_ID },
> +       { VIRTIO_ID_NET, VIRTIO_DEV_ANY_ID },
>         { 0 },
>  };
>
> --
> 2.43.0
>
>

