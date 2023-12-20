Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAEE2D614
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sx3FdSrE"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4D2C881FC9
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:31:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D2C881FC9
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Sx3FdSrE
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id enIDij8aR1Ih
	for <virtualization@lists.linux-foundation.org>;
	Wed, 20 Dec 2023 16:31:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 769078145F
	for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 16:31:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 769078145F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703089900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IgZDAP5MsLlemQXzE+yHPnrJJciIAnmmc9CrE5dpHC4=;
	b=Sx3FdSrEl8SfJC0OUF1JBPvaldcaiYPkWVbFaTo636Got2yCEaC/6Z/45Y+DFfBW7eO1pc
	az8wrjOveS57PtmO+hALSq4G3lRN54naOvEbsD4alvzGtpRnK/rJd5EMwMh+caIqFkFXYI
	VsDu5YkVizUkrmLYYoNAfymsqhELfY0=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-Uqf6wj0gP_u9ssU3_zXcbg-1; Wed, 20 Dec 2023 11:31:38 -0500
X-MC-Unique: Uqf6wj0gP_u9ssU3_zXcbg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5e8e0c7f9a8so4668627b3.0
        for <virtualization@lists.linux-foundation.org>; Wed, 20 Dec 2023 08:31:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703089898; x=1703694698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgZDAP5MsLlemQXzE+yHPnrJJciIAnmmc9CrE5dpHC4=;
        b=JgP0tjThrrbYm1ZxImbP9F+ns4zGQLLLDY9bWeI0kIEacaYZ+ont5hTneEgenPJdzR
         h6NFHzHEJFSsDaIh0A+gQqBoCo3rvchjwgas+c1GIgeIvAkD7mS6RFPnSa5CCZbq1UzH
         J9FuBaNHNHwP2IPRKw0h3xc2cbVLCCA4wH55PioV/xLkTf/QXuczMe0HIW0/cvm3Yvqg
         eVA/DB6m5hXRjL9OybGPK/qrxYktX3NYGr5nHb01URiczT/lXkTfTlT1rxf07/Rr5nRy
         E9WWFliQqs68lk6ejYpxlhlFvrWUebuuCeogg7+b2YrQG+J0hxWu0BbZBaT4IKLbNcrd
         C6Lw==
X-Gm-Message-State: AOJu0YxVIcFrryzJGIBpjKwiTOIymJR5629Dcbnfks4Y6eHbVczcljdD
	tPXjm92kNbCoipQ2ZpfqnM3BgG9B0iQCMOdJ2j9HXSPDgGCgoT84Ya3VBrC7CWiy6wfRuPhMEli
	sTRW11IRx29aAEL9jLBT0mX1vxWHAO9CC/zhns++6X3hrhsagY2zSWlYtLg==
X-Received: by 2002:a0d:dd82:0:b0:5e6:e9d0:990b with SMTP id g124-20020a0ddd82000000b005e6e9d0990bmr1808823ywe.32.1703089898121;
        Wed, 20 Dec 2023 08:31:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1KXR2BgnYGD0+xnFjeY7zp2Hbz1GeSRtIDMZmECKqn9k3gArnzq6WK6nrkxuFCZoLxJrHlOvpLl9D9VtzDrA=
X-Received: by 2002:a0d:dd82:0:b0:5e6:e9d0:990b with SMTP id
 g124-20020a0ddd82000000b005e6e9d0990bmr1808809ywe.32.1703089897863; Wed, 20
 Dec 2023 08:31:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231219180858.120898-1-dtatulea@nvidia.com> <20231219180858.120898-8-dtatulea@nvidia.com>
In-Reply-To: <20231219180858.120898-8-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 20 Dec 2023 17:31:01 +0100
Message-ID: <CAJaqyWet3m8HmHRTJNshQgCn0jqyrO476j0Z-rwwqyDNj4B66w@mail.gmail.com>
Subject: Re: [PATCH vhost v4 07/15] vdpa: Block vq address change in DRIVER_OK
 unless device supports it
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
> Virtqueue address change during DRIVE_OK is not supported by the virtio
> standard. Allow this op in DRIVER_OK only for devices that support
> changing the address during DRIVER_OK if the device is suspended.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Suggested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vhost/vdpa.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 00b4fa8e89f2..6bfa3391935a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -625,6 +625,29 @@ static long vhost_vdpa_resume(struct vhost_vdpa *v)
>         return ret;
>  }
>
> +static bool vhost_vdpa_vq_config_allowed(struct vhost_vdpa *v, unsigned =
int cmd)
> +{
> +       struct vdpa_device *vdpa =3D v->vdpa;
> +       const struct vdpa_config_ops *ops =3D vdpa->config;
> +       int feature;
> +
> +       if (!(ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +               return true;
> +
> +       if (!v->suspended)
> +               return false;
> +
> +       switch (cmd) {
> +       case VHOST_SET_VRING_ADDR:
> +               feature =3D VHOST_BACKEND_F_CHANGEABLE_VQ_ADDR_IN_SUSPEND=
;
> +               break;
> +       default:
> +               return false;
> +       }
> +
> +       return v->vdev.vqs && vhost_backend_has_feature(v->vdev.vqs[0], f=
eature);
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cm=
d,
>                                    void __user *argp)
>  {
> @@ -703,6 +726,9 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa =
*v, unsigned int cmd,
>
>         switch (cmd) {
>         case VHOST_SET_VRING_ADDR:
> +               if (!vhost_vdpa_vq_config_allowed(v, cmd))
> +                       return -EOPNOTSUPP;
> +
>                 if (ops->set_vq_address(vdpa, idx,
>                                         (u64)(uintptr_t)vq->desc,
>                                         (u64)(uintptr_t)vq->avail,
> --
> 2.43.0
>

