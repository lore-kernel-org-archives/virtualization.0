Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E0179AF
	for <virtualization@lists.linux.dev>; Tue,  6 Feb 2024 17:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707240981; cv=none; b=f6f7hZIi69EUnT2fgiuwRARjoTQH447CUK/NwSJaET8iTDn0VUnps0cdHnAqiymV5Dd29wweJdD0EI9V8un5TgxSrzfq4/BfBNg5mkrkBSJEAbHNUUcYxKscgXvJ/kpliBra6LRRNDCEY+imUi6HqBA95mbwsdrhhMph9DpT5uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707240981; c=relaxed/simple;
	bh=EgGDBbZ8+lAAJFJm66AGG91meRlr6iHc9QtL3E559gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as8ep8UOQ3WG1cgxvQcxMklgP6q3LeNvoc4ki2ZhL92O9VymQeCXLSP6IIMzuPrHnvcxq/MAfbWmWlck7KOsoTPpGHdWlp2mId9Id8UcN8ZpiseFU5kUrY0nab6q1y4xAMN73H1/x0A8RR5WewO/oO9nH34Nv10wn6DJvDv1tDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWofQWcu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWofQWcu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707240978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZENp1XRarjD9Kp7owUS6q4NwHgfnf3F2xZAxgOWi78s=;
	b=GWofQWculi2VckgXH7GFv8e9/tB+MXDqm4uAm9d/f5thpsBDnlu6jegoeOJexvdGQKzjVr
	0kZXvyjQRRpIbPwMn3PuGlT/5eTftVMjG37WH1WzOO0CfjCOsqtoW02/7hdRoorqhECdyl
	5/x5hcS5BA4jqVKyeC4GluMn0uQuc1c=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-EOryquBjMfyNW1M9d3OS1Q-1; Tue, 06 Feb 2024 12:36:17 -0500
X-MC-Unique: EOryquBjMfyNW1M9d3OS1Q-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5f874219ff9so10588127b3.0
        for <virtualization@lists.linux.dev>; Tue, 06 Feb 2024 09:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707240977; x=1707845777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZENp1XRarjD9Kp7owUS6q4NwHgfnf3F2xZAxgOWi78s=;
        b=LU/o/LqvYFQVcsU9Kl1n77FiBrxydCYT9xVeM98Ju1+OEOvsMxUYbli+ci9w0pB+h4
         TvsMxK9kPaiSs2d1nyOTXhmM9lWkHMgXMPjx/jk1LhslIjiNXNPJYUomYZOfSNc2WwTs
         mK/a7e7Hk2AEXKw5gjbqp61IRNtNSRls3+nA1p2z1LJyIjXXVLVU2i0J1J27/S7FeTVD
         o+Jw52cPlT9NurgbWDZL9hHmvhy3W8uKMcEtoF2pGGPafqJzEQiTgDRS1psuU4SSVfmv
         Axvt3HfWSd7vW3qX/+Bko+rAz2m2R7liquevnE2d4ZwicADzUBsIavFQALvXjq3yOoNZ
         Q/rw==
X-Gm-Message-State: AOJu0Yy0PfnoHuuafFt4Jcwdv7kc7Eh1hyZ6H5RX23nF02LnSB4n3LN/
	uyjpmz/ZQT5x1yR/ZFogUn7Q0DqsF+PLFXMThYNdCBq16VbxCg+T+rFOi2PvmQOiAFsEm2YFbD4
	SML9r118RqYKC6TArqyid/v9ELlPOXbSEmSac35g9Vz2NtiabDfZ1oUklg2bl2O5tYhj6nQeMls
	Zgyh35pgoozP/wlIsNe6/45yL0Ul/GawXXzegtVPQ=
X-Received: by 2002:a81:4ccb:0:b0:604:1e7:ed34 with SMTP id z194-20020a814ccb000000b0060401e7ed34mr1902294ywa.8.1707240976843;
        Tue, 06 Feb 2024 09:36:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxsoLYqSSMbCU77v90TG/WTQz3YG6Xm36n5Tc/zJRrQZ98F/A62FMnndvspiR9Sa5128FVBYVrznfqUq5khHM=
X-Received: by 2002:a81:4ccb:0:b0:604:1e7:ed34 with SMTP id
 z194-20020a814ccb000000b0060401e7ed34mr1902267ywa.8.1707240976523; Tue, 06
 Feb 2024 09:36:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240206145154.118044-1-sgarzare@redhat.com>
In-Reply-To: <20240206145154.118044-1-sgarzare@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 6 Feb 2024 18:35:40 +0100
Message-ID: <CAJaqyWc2GuTk4dKW98qPunKpOMVGZwWYZ4zpjp4KrGoAoqRwNw@mail.gmail.com>
Subject: Re: [PATCH] vhost-vdpa: fail enabling virtqueue in certain conditions
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev, Shannon Nelson <shannon.nelson@amd.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 3:52=E2=80=AFPM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
>
> If VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated, we expect
> the driver to enable virtqueue before setting DRIVER_OK. If the driver
> tries anyway, better to fail right away as soon as we get the ioctl.
> Let's also update the documentation to make it clearer.
>
> We had a problem in QEMU for not meeting this requirement, see
> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.co=
m/
>
> Fixes: 9f09fd6171fe ("vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK=
 backend feature")
> Cc: eperezma@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

Thanks!

> ---
>  include/uapi/linux/vhost_types.h | 3 ++-
>  drivers/vhost/vdpa.c             | 4 ++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index d7656908f730..5df49b6021a7 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -182,7 +182,8 @@ struct vhost_vdpa_iova_range {
>  /* Device can be resumed */
>  #define VHOST_BACKEND_F_RESUME  0x5
>  /* Device supports the driver enabling virtqueues both before and after
> - * DRIVER_OK
> + * DRIVER_OK. If this feature is not negotiated, the virtqueues must be
> + * enabled before setting DRIVER_OK.
>   */
>  #define VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK  0x6
>  /* Device may expose the virtqueue's descriptor area, driver area and
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index bc4a51e4638b..1fba305ba8c1 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -651,6 +651,10 @@ static long vhost_vdpa_vring_ioctl(struct vhost_vdpa=
 *v, unsigned int cmd,
>         case VHOST_VDPA_SET_VRING_ENABLE:
>                 if (copy_from_user(&s, argp, sizeof(s)))
>                         return -EFAULT;
> +               if (!vhost_backend_has_feature(vq,
> +                       VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK) &&
> +                   (ops->get_status(vdpa) & VIRTIO_CONFIG_S_DRIVER_OK))
> +                       return -EINVAL;
>                 ops->set_vq_ready(vdpa, idx, s.num);
>                 return 0;
>         case VHOST_VDPA_GET_VRING_GROUP:
> --
> 2.43.0
>

