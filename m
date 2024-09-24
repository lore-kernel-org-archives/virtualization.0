Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D20148308
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727163829; cv=none; b=dnk3JEYtiYLV+5dOr8myvklOUVmRWaEHNUtTl72nae9WwldJqyrvzAFjBTEMqdKWjUVdbc+U1NtUud8APg+XHNLOhgjBzvGZk4i4J2rERXmnRuKVKz+XCc3JwCZO1FjaBcuFp0dPp31Oi7n1Bx441psplGIOKDQeKf5tlqy2Fe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727163829; c=relaxed/simple;
	bh=UU7qX41uAkDBCUy0XnOT3NeX1cw7axD/xz6j6BHgRsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxgOk8lZhMspgMi6XwpwrBbvhoF4ZSaBwXVYt6xxI0r+yGDzdNNmbrRl7CRyn+jfIQyM8y+8KnDI6t2Si0FeH53MspFex8bCYpg0PNXXVxLw16e+jWJeRJ1DUXF2haJpRGK65rRwBmjTUAbb+7Z3y3hWVEIcKVMhYgzOkJwXaug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9EzWIuc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9EzWIuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727163827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sd/bnnzJzJdkv8ZbLlpvLffK8I346cwr0/QVzzvREsY=;
	b=a9EzWIuc4DZaRjwy1DVe5iNBfrufeO6ng/fabfg2hITpNmDvAEL/wRJKPubRoWdRTzl/f8
	AzlMEnUKInK8BzPPLmOhfVUUFShZt0Mi1zcTYkr2sEHadkH3ITc6Dgj/Pr1ah33+isqlpK
	as2PpkIJGTlNKaIa6gCj1luOUKQ9rG0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-FkNECGkGOguXwqZOyLmSwQ-1; Tue, 24 Sep 2024 03:43:46 -0400
X-MC-Unique: FkNECGkGOguXwqZOyLmSwQ-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d877d7f9b4so5755240a91.3
        for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 00:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727163825; x=1727768625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd/bnnzJzJdkv8ZbLlpvLffK8I346cwr0/QVzzvREsY=;
        b=qxRTmbPVlwlaf8g7K33Drx0TMcRJjofJLfDVbKXIu0Qq3/j3BVu5eoFsAlkpJjej35
         STFxg/p4Lv9QCvEsua3v/0GIDq6PdwD/wnfb/SbctW3C9Xmf+4KWhdaOL1Cq4lV29VQn
         KzwUKTA4Ezi47MX9pbZIfR6CX0TcTVw2B/ASmtK90A8VXi21c+EuC79VYfT62PCdmeVH
         BOfz/vlbWkXUst41rHved14kIQ/MtyZpvZDxJiFFmo7Azk8LSItGrPm1MEJxZLJAdECC
         Tfdhe+eIAiqv/+PlTw++EyWqujl3M/5n3sLofSFQYIojT0wbVRx3K1eMMG/4pT3L6qbC
         pZYw==
X-Gm-Message-State: AOJu0YxnozC4e4uXWJ0XGDj0/5JDOS1HIgRdc0v4IgQA/NlOUnb4spk7
	5DoXvx48QPBP8Jg1ojQTXWppxpOHt6kzIEsAJlqPnzUU62By263rRKpYCa/qx8/Lp4Y80UNTF7S
	B3hBPrKxONfdYqcUl5AHRTBwISemUm6NRN2jYllLvT0T+oFiDP7V9fpzNdMb/XjxJb9utiaMr5l
	/z0Cw1OsJLhFCtRkbJVG95xg12wOyRTHo/I5ganvs=
X-Received: by 2002:a17:90a:da87:b0:2d8:f99d:48d2 with SMTP id 98e67ed59e1d1-2dd7f70f6famr15958897a91.29.1727163825043;
        Tue, 24 Sep 2024 00:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0+gIzMz2GXzofDVPp+N0+RslIpcesvc1C39NkG39H0QZ2cMLZOB/b9ilj4g/GDXxjLMrNJcgAcNohePyiDT4=
X-Received: by 2002:a17:90a:da87:b0:2d8:f99d:48d2 with SMTP id
 98e67ed59e1d1-2dd7f70f6famr15958879a91.29.1727163824594; Tue, 24 Sep 2024
 00:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240920140530.775307-1-schalla@marvell.com> <20240920140530.775307-3-schalla@marvell.com>
In-Reply-To: <20240920140530.775307-3-schalla@marvell.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 24 Sep 2024 15:43:33 +0800
Message-ID: <CACGkMEuB8BikU7or6wso9ortoQfX+cCw-Q=x3o_rtdmVTqLZiQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vhost-vdpa: introduce NO-IOMMU backend feature bit
To: Srujana Challa <schalla@marvell.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, mst@redhat.com, 
	eperezma@redhat.com, ndabilpuram@marvell.com, jerinj@marvell.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 10:05=E2=80=AFPM Srujana Challa <schalla@marvell.co=
m> wrote:
>
> This patch introduces the VHOST_BACKEND_F_NOIOMMU feature flag.
> This flag allows userspace to identify if the driver can operate
> without an IOMMU, providing more flexibility in environments where
> IOMMU is not available or desired.
>
> Key changes include:
>     - Addition of the VHOST_BACKEND_F_NOIOMMU feature flag.
>     - Updates to vhost_vdpa_unlocked_ioctl to handle the NO-IOMMU
>       feature.
> The NO-IOMMU mode is enabled if:
>     - The vdpa device lacks an IOMMU domain.
>     - The system has the required RAWIO permissions.
>     - The vdpa device explicitly supports NO-IOMMU mode.
>
> This feature flag indicates to userspace that the driver can safely
> operate in NO-IOMMU mode. If the flag is absent, userspace should
> assume NO-IOMMU mode is unsupported and take appropriate actions.

This seems contradictory to what you said in patch 1

"""
When enabled, this mode provides no
device isolation, no DMA translation, no host kernel protection, and
cannot be used for device assignment to virtual machines.
"""

And I wonder what "appropriate actions" could the userspace take?
Generally, the IOMMU concept should be hidden from the userspace.

Thanks

>
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  drivers/vhost/vdpa.c             | 11 ++++++++++-
>  include/uapi/linux/vhost_types.h |  2 ++
>  2 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index b3085189ea4a..de47349eceff 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -797,7 +797,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                                  BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST) |
>                                  BIT_ULL(VHOST_BACKEND_F_SUSPEND) |
>                                  BIT_ULL(VHOST_BACKEND_F_RESUME) |
> -                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK)))
> +                                BIT_ULL(VHOST_BACKEND_F_ENABLE_AFTER_DRI=
VER_OK) |
> +                                BIT_ULL(VHOST_BACKEND_F_NOIOMMU)))
>                         return -EOPNOTSUPP;
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_SUSPEND)) &&
>                      !vhost_vdpa_can_suspend(v))
> @@ -814,6 +815,12 @@ static long vhost_vdpa_unlocked_ioctl(struct file *f=
ilep,
>                 if ((features & BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSIST)) &=
&
>                      !vhost_vdpa_has_persistent_map(v))
>                         return -EOPNOTSUPP;
> +               if ((features & BIT_ULL(VHOST_BACKEND_F_NOIOMMU)) &&
> +                   !v->noiommu_en)
> +                       return -EOPNOTSUPP;
> +               if (!(features & BIT_ULL(VHOST_BACKEND_F_NOIOMMU)) &&
> +                   v->noiommu_en)
> +                       return -EOPNOTSUPP;
>                 vhost_set_backend_features(&v->vdev, features);
>                 return 0;
>         }
> @@ -871,6 +878,8 @@ static long vhost_vdpa_unlocked_ioctl(struct file *fi=
lep,
>                         features |=3D BIT_ULL(VHOST_BACKEND_F_DESC_ASID);
>                 if (vhost_vdpa_has_persistent_map(v))
>                         features |=3D BIT_ULL(VHOST_BACKEND_F_IOTLB_PERSI=
ST);
> +               if (v->noiommu_en)
> +                       features |=3D BIT_ULL(VHOST_BACKEND_F_NOIOMMU);
>                 features |=3D vhost_vdpa_get_backend_features(v);
>                 if (copy_to_user(featurep, &features, sizeof(features)))
>                         r =3D -EFAULT;
> diff --git a/include/uapi/linux/vhost_types.h b/include/uapi/linux/vhost_=
types.h
> index d7656908f730..dda673c3456a 100644
> --- a/include/uapi/linux/vhost_types.h
> +++ b/include/uapi/linux/vhost_types.h
> @@ -192,5 +192,7 @@ struct vhost_vdpa_iova_range {
>  #define VHOST_BACKEND_F_DESC_ASID    0x7
>  /* IOTLB don't flush memory mapping across device reset */
>  #define VHOST_BACKEND_F_IOTLB_PERSIST  0x8
> +/* Enables the device to operate in NO-IOMMU mode as well */
> +#define VHOST_BACKEND_F_NOIOMMU  0x9
>
>  #endif
> --
> 2.25.1
>

