Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB621E7A39
	for <virtualization@lists.linux.dev>; Wed,  7 Aug 2024 13:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036416; cv=none; b=Ti5wssbKGm37CXY1quZWJY0fJNRaQpuqLUDbt+L8S1jbW7vVq0tY4sJIhLTCtQZPB3/POdLTqASZAPdnfFAm5cswpPAAx7EGn5njPtGrwmEMMqVlB2rvpn61S+UtWLDzlGggvTnxdsJwL9if8gBXkv9Sf4rSoZMm+Tkj0EsJWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036416; c=relaxed/simple;
	bh=B5TAul6pQEovqLhyourP7SxXGeLecIH/bqwkZia6KCk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLdW5p+tveQiFVWf7UMMt9MAf07BNLPOLh83MSqAegB9EmI1XEiG9Fq9jD7E8MQm7Z6FmhmlmBpHj79Jh1jknqjgNx+czuHFK821Lhd9J1YHCSy5ek8MmV7uUM3rWQWQ1BbqhHcQFws1USUVGTTdB0OsZYp4z7y0H4xaGum2tWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDjiEhH5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDjiEhH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723036413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brdY5HnpsR0y5F2Yzt5j1HFAkG5VP62QeHIqopFFNHc=;
	b=GDjiEhH5F/LpYlC28dLto9wzsNT1xWnSTaZwipwQyWt7CCQNn8uYwX5x69qVyluLyEO6xG
	9MB2ZlytVSa/+yG+dof1HBOUV78h6I2HAG3MPxilQNOqow6xMEafJ8+DzGfUO0v1a6fWlo
	rYOBzOn7DaSJCujErXsMdJxViyWrAE8=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-wKTC-GqxON2BuB_y-ZVU3A-1; Wed, 07 Aug 2024 09:13:31 -0400
X-MC-Unique: wKTC-GqxON2BuB_y-ZVU3A-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-690d5456d8aso47496517b3.2
        for <virtualization@lists.linux.dev>; Wed, 07 Aug 2024 06:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723036408; x=1723641208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brdY5HnpsR0y5F2Yzt5j1HFAkG5VP62QeHIqopFFNHc=;
        b=Oke96Q5qo9Lbhd3Ur2MxyzIE1Wo9ToKencWbOI9I6OVzqbccw2A3SvxblY1kmx7LkW
         npoykX7WIpv2yRIwmjMcMyNOq4EjBd7Pf+dyGlYV2WXseiQokVJ9FSYy2NZU3Ubha/cu
         VUPnOy2F3eAwODgRqr19jfRMKe5+nLLPfFBnehs2XyAnbLIN05vjnp3x7cQL5X2O48gR
         POXnXRnsiweTb6iIDmmNp5KKxITLrRDoVC+Tsd2dGAt22dBG7kgtoeQuZyL78SOS7XWh
         QOQccb366CSXlPkKIgdvQRtOQfkQaqmu14wGstQmZR4V9AaXMp1qmJMQ2GuT2h3MjnYY
         0s3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUveYNCSr4+MAkt8NPJ5kdEHAJeJSRGQytFLzbPRMRAwDkk06H98v26FroxgjSTWfMgtOIiIsJvctKk41OZN03h1ydYzXtd1mqtlwDOct8=
X-Gm-Message-State: AOJu0Yx2/3oN9RRXA3tuw/K9iSCR4anYgzejckC4mYOzEqdzpegskXQe
	KKBhcYT7fOdCy+cCaRjOq2iUscPhOxbjvDwazd3qobAgSwRMVuCUdVP+rnuYbnNuwGjPpeFqqoN
	IDH1sdLhW/5f5sY7ebxQ/JHoXs3/yWK9NrAj+/P7RwUQsoMUyRtU6hb0iI8JJ0KcN25E/gjQnxP
	gC8RojcOGVldkpRjVXdIc34OacVdsY/s1k4VGcY34=
X-Received: by 2002:a81:8501:0:b0:673:b39a:92f0 with SMTP id 00721157ae682-6896077619dmr199554227b3.11.1723036407952;
        Wed, 07 Aug 2024 06:13:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLckjPO5vEq6WRdHZwb7UzgyFCEShaQG/I673zIIw/gNYCgN0NZkEOuJ1Ie1htXA1/CnJMmD521FROmaBczxU=
X-Received: by 2002:a81:8501:0:b0:673:b39a:92f0 with SMTP id
 00721157ae682-6896077619dmr199553987b3.11.1723036407590; Wed, 07 Aug 2024
 06:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240802072039.267446-1-dtatulea@nvidia.com> <20240802072039.267446-5-dtatulea@nvidia.com>
In-Reply-To: <20240802072039.267446-5-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 7 Aug 2024 15:12:51 +0200
Message-ID: <CAJaqyWeQDgBAp=uAEy0XO1orCb0z+w-CidBnRORG+CjY2fVK0g@mail.gmail.com>
Subject: Re: [PATCH vhost 4/7] vdpa/mlx5: Use async API for vq modify commands
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Tariq Toukan <tariqt@nvidia.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 9:24=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
> Switch firmware vq modify command to be issued via the async API to
> allow future parallelization. The new refactored function applies the
> modify on a range of vqs and waits for their execution to complete.
>
> For now the command is still used in a serial fashion. A later patch
> will switch to modifying multiple vqs in parallel.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 150 ++++++++++++++++++++----------
>  1 file changed, 103 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/ml=
x5_vnet.c
> index be8df9d9f4df..e56a0ee1b725 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1189,6 +1189,12 @@ struct mlx5_virtqueue_query_mem {
>         u8 out[MLX5_ST_SZ_BYTES(query_virtio_net_q_out)];
>  };
>
> +struct mlx5_virtqueue_modify_mem {
> +       u8 in[MLX5_ST_SZ_BYTES(modify_virtio_net_q_in)];
> +       u8 out[MLX5_ST_SZ_BYTES(modify_virtio_net_q_out)];
> +};
> +
> +

Extra newline here.

>  struct mlx5_vdpa_async_virtqueue_cmd {
>         int err;
>         struct mlx5_async_work cb_work;
> @@ -1202,6 +1208,7 @@ struct mlx5_vdpa_async_virtqueue_cmd {
>
>         union {
>                 struct mlx5_virtqueue_query_mem query;
> +               struct mlx5_virtqueue_modify_mem modify;
>         };
>  };
>
> @@ -1384,51 +1391,35 @@ static bool modifiable_virtqueue_fields(struct ml=
x5_vdpa_virtqueue *mvq)
>         return true;
>  }
>
> -static int modify_virtqueue(struct mlx5_vdpa_net *ndev,
> -                           struct mlx5_vdpa_virtqueue *mvq,
> -                           int state)
> +static void fill_modify_virtqueue_cmd(struct mlx5_vdpa_net *ndev,
> +                                     struct mlx5_vdpa_virtqueue *mvq,
> +                                     int state,
> +                                     struct mlx5_vdpa_async_virtqueue_cm=
d *cmd)
>  {
> -       int inlen =3D MLX5_ST_SZ_BYTES(modify_virtio_net_q_in);
> -       u32 out[MLX5_ST_SZ_DW(modify_virtio_net_q_out)] =3D {};
>         struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>         struct mlx5_vdpa_mr *desc_mr =3D NULL;
>         struct mlx5_vdpa_mr *vq_mr =3D NULL;
> -       bool state_change =3D false;
>         void *obj_context;
>         void *cmd_hdr;
>         void *vq_ctx;
> -       void *in;
> -       int err;
>
> -       if (mvq->fw_state =3D=3D MLX5_VIRTIO_NET_Q_OBJECT_NONE)
> -               return 0;
> -
> -       if (!modifiable_virtqueue_fields(mvq))
> -               return -EINVAL;
> -
> -       in =3D kzalloc(inlen, GFP_KERNEL);
> -       if (!in)
> -               return -ENOMEM;
> +       cmd->in =3D &cmd->modify.in;
> +       cmd->inlen =3D sizeof(cmd->modify.in);
> +       cmd->out =3D &cmd->modify.out;
> +       cmd->outlen =3D sizeof(cmd->modify.out);
>
> -       cmd_hdr =3D MLX5_ADDR_OF(modify_virtio_net_q_in, in, general_obj_=
in_cmd_hdr);
> +       cmd_hdr =3D MLX5_ADDR_OF(modify_virtio_net_q_in, cmd->in, general=
_obj_in_cmd_hdr);
>
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, opcode, MLX5_CMD_OP_MOD=
IFY_GENERAL_OBJECT);
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_type, MLX5_OBJ_TYPE=
_VIRTIO_NET_Q);
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, obj_id, mvq->virtq_id);
>         MLX5_SET(general_obj_in_cmd_hdr, cmd_hdr, uid, ndev->mvdev.res.ui=
d);
>
> -       obj_context =3D MLX5_ADDR_OF(modify_virtio_net_q_in, in, obj_cont=
ext);
> +       obj_context =3D MLX5_ADDR_OF(modify_virtio_net_q_in, cmd->in, obj=
_context);
>         vq_ctx =3D MLX5_ADDR_OF(virtio_net_q_object, obj_context, virtio_=
q_context);
>
> -       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE) {
> -               if (!is_valid_state_change(mvq->fw_state, state, is_resum=
able(ndev))) {
> -                       err =3D -EINVAL;
> -                       goto done;
> -               }
> -
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE)
>                 MLX5_SET(virtio_net_q_object, obj_context, state, state);
> -               state_change =3D true;
> -       }
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_ADDRS)=
 {
>                 MLX5_SET64(virtio_q, vq_ctx, desc_addr, mvq->desc_addr);
> @@ -1474,38 +1465,36 @@ static int modify_virtqueue(struct mlx5_vdpa_net =
*ndev,
>         }
>
>         MLX5_SET64(virtio_net_q_object, obj_context, modify_field_select,=
 mvq->modified_fields);
> -       err =3D mlx5_cmd_exec(ndev->mvdev.mdev, in, inlen, out, sizeof(ou=
t));
> -       if (err)
> -               goto done;
> +}
>
> -       if (state_change)
> -               mvq->fw_state =3D state;
> +static void modify_virtqueue_end(struct mlx5_vdpa_net *ndev,
> +                                struct mlx5_vdpa_virtqueue *mvq,
> +                                int state)
> +{
> +       struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_VIRTIO_Q_MKEY) =
{
> +               unsigned int asid =3D mvdev->group2asid[MLX5_VDPA_DATAVQ_=
GROUP];
> +               struct mlx5_vdpa_mr *vq_mr =3D mvdev->mr[asid];
> +
>                 mlx5_vdpa_put_mr(mvdev, mvq->vq_mr);
>                 mlx5_vdpa_get_mr(mvdev, vq_mr);
>                 mvq->vq_mr =3D vq_mr;
>         }
>
>         if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_DESC_GROUP_MKEY=
) {
> +               unsigned int asid =3D mvdev->group2asid[MLX5_VDPA_DATAVQ_=
DESC_GROUP];
> +               struct mlx5_vdpa_mr *desc_mr =3D mvdev->mr[asid];
> +
>                 mlx5_vdpa_put_mr(mvdev, mvq->desc_mr);
>                 mlx5_vdpa_get_mr(mvdev, desc_mr);
>                 mvq->desc_mr =3D desc_mr;
>         }
>
> -       mvq->modified_fields =3D 0;
> -
> -done:
> -       kfree(in);
> -       return err;
> -}
> +       if (mvq->modified_fields & MLX5_VIRTQ_MODIFY_MASK_STATE)
> +               mvq->fw_state =3D state;
>
> -static int modify_virtqueue_state(struct mlx5_vdpa_net *ndev,
> -                                 struct mlx5_vdpa_virtqueue *mvq,
> -                                 unsigned int state)
> -{
> -       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_STATE;
> -       return modify_virtqueue(ndev, mvq, state);
> +       mvq->modified_fields =3D 0;
>  }
>
>  static int counter_set_alloc(struct mlx5_vdpa_net *ndev, struct mlx5_vdp=
a_virtqueue *mvq)
> @@ -1658,6 +1647,73 @@ static int setup_vq(struct mlx5_vdpa_net *ndev,
>         return err;
>  }
>
> +static int modify_virtqueues(struct mlx5_vdpa_net *ndev, int start_vq, i=
nt num_vqs, int state)
> +{
> +       struct mlx5_vdpa_async_virtqueue_cmd *cmds;
> +       struct mlx5_vdpa_dev *mvdev =3D &ndev->mvdev;
> +       int err =3D 0;
> +
> +       WARN(start_vq + num_vqs > mvdev->max_vqs, "modify vq range invali=
d [%d, %d), max_vqs: %u\n",
> +            start_vq, start_vq + num_vqs, mvdev->max_vqs);
> +
> +       cmds =3D kvcalloc(num_vqs, sizeof(*cmds), GFP_KERNEL);
> +       if (!cmds)
> +               return -ENOMEM;
> +
> +       for (int i =3D 0; i < num_vqs; i++) {
> +               struct mlx5_vdpa_async_virtqueue_cmd *cmd =3D &cmds[i];
> +               struct mlx5_vdpa_virtqueue *mvq;
> +               int vq_idx =3D start_vq + i;
> +
> +               mvq =3D &ndev->vqs[vq_idx];
> +
> +               if (!modifiable_virtqueue_fields(mvq)) {
> +                       err =3D -EINVAL;
> +                       goto done;
> +               }
> +
> +               if (mvq->fw_state !=3D state) {
> +                       if (!is_valid_state_change(mvq->fw_state, state, =
is_resumable(ndev))) {
> +                               err =3D -EINVAL;
> +                               goto done;
> +                       }
> +
> +                       mvq->modified_fields |=3D MLX5_VIRTQ_MODIFY_MASK_=
STATE;
> +               }
> +
> +               fill_modify_virtqueue_cmd(ndev, mvq, state, cmd);
> +       }
> +
> +       err =3D exec_virtqueue_async_cmds(ndev, cmds, num_vqs);
> +       if (err) {
> +               mlx5_vdpa_err(mvdev, "error issuing modify cmd for vq ran=
ge [%d, %d)\n",
> +                             start_vq, start_vq + num_vqs);
> +               goto done;
> +       }
> +
> +       for (int i =3D 0; i < num_vqs; i++) {
> +               struct mlx5_vdpa_async_virtqueue_cmd *cmd =3D &cmds[i];
> +               struct mlx5_vdpa_virtqueue *mvq;
> +               int vq_idx =3D start_vq + i;
> +
> +               mvq =3D &ndev->vqs[vq_idx];
> +
> +               if (cmd->err) {
> +                       mlx5_vdpa_err(mvdev, "modify vq %d failed, state:=
 %d -> %d, err: %d\n",
> +                                     vq_idx, mvq->fw_state, state, err);
> +                       if (!err)
> +                               err =3D cmd->err;
> +                       continue;
> +               }
> +
> +               modify_virtqueue_end(ndev, mvq, state);
> +       }
> +
> +done:
> +       kfree(cmds);
> +       return err;
> +}
> +
>  static int suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtq=
ueue *mvq)
>  {
>         struct mlx5_virtq_attr attr;
> @@ -1669,7 +1725,7 @@ static int suspend_vq(struct mlx5_vdpa_net *ndev, s=
truct mlx5_vdpa_virtqueue *mv
>         if (mvq->fw_state !=3D MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY)
>                 return 0;
>
> -       err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJEC=
T_STATE_SUSPEND);
> +       err =3D modify_virtqueues(ndev, mvq->index, 1, MLX5_VIRTIO_NET_Q_=
OBJECT_STATE_SUSPEND);
>         if (err) {
>                 mlx5_vdpa_err(&ndev->mvdev, "modify to suspend failed, er=
r: %d\n", err);
>                 return err;
> @@ -1716,7 +1772,7 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, st=
ruct mlx5_vdpa_virtqueue *mvq
>                 /* Due to a FW quirk we need to modify the VQ fields firs=
t then change state.
>                  * This should be fixed soon. After that, a single comman=
d can be used.
>                  */
> -               err =3D modify_virtqueue(ndev, mvq, 0);
> +               err =3D modify_virtqueues(ndev, mvq->index, 1, mvq->fw_st=
ate);
>                 if (err) {
>                         mlx5_vdpa_err(&ndev->mvdev,
>                                 "modify vq properties failed for vq %u, e=
rr: %d\n",
> @@ -1738,7 +1794,7 @@ static int resume_vq(struct mlx5_vdpa_net *ndev, st=
ruct mlx5_vdpa_virtqueue *mvq
>                 return -EINVAL;
>         }
>
> -       err =3D modify_virtqueue_state(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJEC=
T_STATE_RDY);
> +       err =3D modify_virtqueues(ndev, mvq->index, 1, MLX5_VIRTIO_NET_Q_=
OBJECT_STATE_RDY);
>         if (err)
>                 mlx5_vdpa_err(&ndev->mvdev, "modify to resume failed for =
vq %u, err: %d\n",
>                               mvq->index, err);
> --
> 2.45.2
>

