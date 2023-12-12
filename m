Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA981E46
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvmeRO2t"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 26FE440169
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 19:22:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 26FE440169
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VvmeRO2t
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aIPbRu8jrJqi
	for <virtualization@lists.linux-foundation.org>;
	Tue, 12 Dec 2023 19:21:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C4838400C7
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 19:21:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C4838400C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702408917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HurXK5gBPsoHICW5D8Za3/oNGdjuLwbQTQMZFCsDbks=;
	b=VvmeRO2tpnLMrykxEzARNtl5q3bApuIZZxN305Pdw93lj47BIgW0YZABZvQLzRnYEWaI0J
	Uz8CmfE/kRDpZveeoo0U8NkOpngT94eyI6Zn9qxl11zaD/4wGtgC/meF65kdvHvcJzK5+q
	FlgB153cWIhlU55J9N/RPiyPYIzetk0=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-9XAC3lhgNeOS4M_cqszSyw-1; Tue, 12 Dec 2023 14:21:51 -0500
X-MC-Unique: 9XAC3lhgNeOS4M_cqszSyw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5d0c4ba7081so71638757b3.0
        for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 11:21:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702408911; x=1703013711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HurXK5gBPsoHICW5D8Za3/oNGdjuLwbQTQMZFCsDbks=;
        b=FdO1xYO7tBMs1DVARph/UkHiYPke6bi/daJYCTAvpbZqtb0QnCtwcHNwae4vmdkUFC
         +1Vgg5dm/slv0XPfTtwUqBBIwWh1pASTAeMvrswdqAYs+csWP3Wh7iDujypJEomLtrqf
         srmTvEv+OlomEGbt67YwExRDyPKPjKBvKq7Z5jXAzkVq8s7i3hNERGhBwJkEsoq9d8ax
         98rdywB+ztvo9BagrvhHnIhi8jB4x+8XVnfQTNJUNTQ3oaOvPfvYtXSLlBP38RqPx6WF
         g+rHcBQcVZhPsYdZg2hKq1tFAtYYOVEXlGitlwmpRSEvwJB0RqCLWZOJCu8txzBEa3cU
         mj3w==
X-Gm-Message-State: AOJu0YyAq+aqmMfvfJq2aL0mODz2rCCUhbKZylNVmXVdHyTFiyMPBeMT
	Rh3BZ7P7m7r/17z5QNCo4gnL3olKUaSp2eVthSTtjsg5k+fVnC/wRkT4OA3CnUF6kPPPlkpPhOQ
	OQzEc/wsdYQzrvNH8XVXNdHfmydnvrZyoqbD0HQHMHXS5Tks56CbgievZ3w==
X-Received: by 2002:a25:6084:0:b0:dbc:cbb7:1396 with SMTP id u126-20020a256084000000b00dbccbb71396mr42499ybb.79.1702408911406;
        Tue, 12 Dec 2023 11:21:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwE2PBBX/zi/0sI1dUGV/OYZrCz+Jc8U/PqiB/t32suOa+Cugn7mXgjVi34mzvQKsQy4dZIOiVC3cueoVPamw=
X-Received: by 2002:a25:6084:0:b0:dbc:cbb7:1396 with SMTP id
 u126-20020a256084000000b00dbccbb71396mr42489ybb.79.1702408911135; Tue, 12 Dec
 2023 11:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231205104609.876194-1-dtatulea@nvidia.com> <20231205104609.876194-5-dtatulea@nvidia.com>
In-Reply-To: <20231205104609.876194-5-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 12 Dec 2023 20:21:14 +0100
Message-ID: <CAJaqyWeEY9LNTE8QEnJgLhgS7HiXr5gJEwwPBrC3RRBsAE4_7Q@mail.gmail.com>
Subject: Re: [PATCH vhost v2 4/8] vdpa/mlx5: Mark vq addrs for modification in
 hw vq
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

On Tue, Dec 5, 2023 at 11:46=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
> Addresses get set by .set_vq_address. hw vq addresses will be updated on
> next modify_virtqueue.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

I'm kind of ok with this patch and the next one about state, but I
didn't ack them in the previous series.

My main concern is that it is not valid to change the vq address after
DRIVER_OK in VirtIO, which vDPA follows. Only memory maps are ok to
change at this moment. I'm not sure about vq state in vDPA, but vhost
forbids changing it with an active backend.

Suspend is not defined in VirtIO at this moment though, so maybe it is
ok to decide that all of these parameters may change during suspend.
Maybe the best thing is to protect this with a vDPA feature flag.

Jason, what do you think?

Thanks!

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 9 +++++++++
>  include/linux/mlx5/mlx5_ifc_vdpa.h | 1 +
>  2 files changed, 10 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index f8f088cced50..80e066de0866 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1209,6 +1209,7 @@ static int modify_virtqueue(struct mlx5_vdpa_net *n=
dev,
>         bool state_change =3D false;
>         void *obj_context;
>         void *cmd_hdr;
> +       void *vq_ctx;
>         void *in;
>         int err;
>
> @@ -1230,6 +1231,7 @@ static int modify_virtqueue(struct mlx5_vdpa_net *n=
dev,
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.ui=
d);
>
>         obj_context =3D MLX5_ADDR_OF(modify_virtio_net_q_in, in, obj_cont=
ext);
> +       vq_ctx =3D MLX5_ADDR_OF(virtio_net_q_object, obj_context, virtio_=
q_context);
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE) {
>                 if (!is_valid_state_change(mvq->fw_state, state, is_resum=
able(ndev))) {
> @@ -1241,6 +1243,12 @@ static int modify_virtqueue(struct mlx5_vdpa_net *=
ndev,
>                 state_change =3D true;
>         }
>
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS)=
 {
> +               MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
> +               MLX5_SET64(virtio_q, vq_ctx, used_addr, mvq->device_addr)=
;
> +               MLX5_SET64(virtio_q, vq_ctx, available_addr, mvq->driver_=
addr);
> +       }
> +
>         MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select,=
 mvq->modified_fields);
>         err =3D mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(ou=
t));
>         if (err)
> @@ -2202,6 +2210,7 @@ static int mlx5_vdpa_set_vq_address(struct vdpa_dev=
ice *vdev, u16 idx, u64 desc_
>         mvq->desc_addr =3D desc_area;
>         mvq->device_addr =3D device_area;
>         mvq->driver_addr =3D driver_area;
> +       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS;
>         return 0;
>  }
>
> diff --git a/include/linux/mlx5/mlx5_ifc_vdpa.h b/include/linux/mlx5/mlx5=
_ifc_vdpa.h
> index b86d51a855f6..9594ac405740 100644
> --- a/include/linux/mlx5/mlx5_ifc_vdpa.h
> +++ b/include/linux/mlx5/mlx5_ifc_vdpa.h
> @@ -145,6 +145,7 @@ enum {
>         MLX5_VIRTQ_MODIFY_MASK_STATE                    =3D (u64)1 << 0,
>         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_PARAMS      =3D (u64)1 << 3,
>         MLX5_VIRTQ_MODIFY_MASK_DIRTY_BITMAP_DUMP_ENABLE =3D (u64)1 << 4,
> +       MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS           =3D (u64)1 << 6,
>         MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY          =3D (u64)1 << 14,
>  };
>
> --
> 2.42.0
>

