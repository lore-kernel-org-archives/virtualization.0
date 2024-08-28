Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63F176248
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724848502; cv=none; b=nhJv99spFVQHffhCdtrZIPMWOscZbDGWOqNUHjR9ZuEah4GBt/+UjI42YeET6LW/DEJ34m+Z+WXbGjXaogNqzu1pZ1NMdbjqLt3v41MulJ5iT6RbyScEfDoRTcDsqZXOHiC2HNajg2/6tGyIjq/8Vo8kQTtoib5XdQ87Xa0olNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724848502; c=relaxed/simple;
	bh=xr9rCmalwTDHQASNbbRaXPrtw5doK9XNIb6YW2DH0Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNzp9mIy7F7LNf3f5BDhHJN8UzMcemEn75hDOvSReJTYyaH7PyNNdrUICw5+qDkT68BxCTSjmeZBoCk6NSOo+/EV9k9Ug+LdG1dbwyzdGZYyQC6pABv6BZvkHJZY6J9rCl5Sr24fWQ0Syg7X1TjNOssCjUdQuZLf62sApJgPxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OwG1NdzH; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwG1NdzH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72955401FB
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 12:35:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IB5KWxP71jSE for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Aug 2024 12:34:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2ACA9400D1
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2ACA9400D1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OwG1NdzH
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2ACA9400D1
	for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 12:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724848497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKgQdLYmvUO4rlMn7GgO0+K/4t1iYIvHSsifkH21neI=;
	b=OwG1NdzH3oLUnQkNtSxDnjKlXxt1MmuY8zbaR0qmER1q6HxfFoUlg0z134tVWXKKIH5OdG
	CamiNXjVfZ4/51QS4DoTRXrOau9p4Sv7keErs9ZdxEbadEypDAaMSlsCB4GQoeF7uD25Jp
	rrmln7LKi2zgXdXn3nJryVkjh92oyKc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-Q3feW3NUPfCRAqBfU_EmUw-1; Wed, 28 Aug 2024 08:34:56 -0400
X-MC-Unique: Q3feW3NUPfCRAqBfU_EmUw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-68fd6ccd4c8so131593207b3.0
        for <virtualization@lists.linux-foundation.org>; Wed, 28 Aug 2024 05:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724848496; x=1725453296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKgQdLYmvUO4rlMn7GgO0+K/4t1iYIvHSsifkH21neI=;
        b=jVLH5ZMiRKQ7jszVlc9Ayk2Ba9vAv9v+iE2UmpMxJuIGksi0LVyB2lAQY6sClXiHOG
         nNWA1smwGR1lUyNbvVV/8IEj2iLDvkf7aMqpGmH+o14zACw6V8oCBBbMRahRgkD+cFng
         c2YD/6MSvdREUrAVnxuZs7f3JWEK9sqkHA341JVDlPRrsmGFYGo3P5npQc9ruylrEoY0
         AwjVbW74/+sn5gKx8UW/M9i2+Q5PwuIEdLvIyOaBFBLTiISouNwVSth0DdDRT29SMwL0
         GyabUimmlUqyWkgnKNfvQAGyR7ebpOHzZKECYiB5ZPb7tM6SD+cYMAEB0coq8XXjt31T
         711Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzrbAACrsD52cNLAogOWfTkv6f5gU1V8iavSmW9WTgVOOJXYyyOSICFP89Fnl6/PZF1oM7p1llRLScuS2crg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwGbDaIUxMgZJII/PbJO9RiFgSH2ggyCNgHNnYHa3oQLe3doPWq
	quCU3BX4sX0fX+Q80q+K03UGCt63up44pERnkguKAg/9YkMgIBetJwA1XZRDvghlT+TQfSvUL2v
	g0mCKLbPP4dxLu+941ctte1u68F1ikOQrlfct4tES14Rnn+P6/VqzeHVYKjFQ/6QTZ7NbyQ25X+
	1tVc3gB8mdzgo3aSzk/UHfzyKnt+R/ueh89vYWinQd6YQ0j3IJpbX55Q==
X-Received: by 2002:a05:690c:2e05:b0:6b1:a965:4ddf with SMTP id 00721157ae682-6d1706f1265mr15266597b3.27.1724848495902;
        Wed, 28 Aug 2024 05:34:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErDi/VtEGwo7N8x5mgE4Nl+/vuGpwZNUQLTxIhjgArE0tBJVoTCPNR1B97kg1Gan26xVVCBRWytq5JidxUZyQ=
X-Received: by 2002:a05:690c:2e05:b0:6b1:a965:4ddf with SMTP id
 00721157ae682-6d1706f1265mr15266457b3.27.1724848495614; Wed, 28 Aug 2024
 05:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240816090159.1967650-1-dtatulea@nvidia.com> <20240816090159.1967650-4-dtatulea@nvidia.com>
In-Reply-To: <20240816090159.1967650-4-dtatulea@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 28 Aug 2024 14:34:19 +0200
Message-ID: <CAJaqyWd=Nhd5e=0VTb+HQJdCS1QW+XPih2UeACDXhAf+pyo20A@mail.gmail.com>
Subject: Re: [PATCH vhost v2 03/10] vdpa/mlx5: Introduce async fw command wrapper
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	virtualization@lists.linux-foundation.org, Si-Wei Liu <si-wei.liu@oracle.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Tariq Toukan <tariqt@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:02=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.co=
m> wrote:
>
> Introduce a new function mlx5_vdpa_exec_async_cmds() which
> wraps the mlx5_core async firmware command API in a way
> that will be used to parallelize certain operation in this
> driver.
>
> The wrapper deals with the case when mlx5_cmd_exec_cb() returns
> EBUSY due to the command being throttled.
>
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>

Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h | 15 ++++++
>  drivers/vdpa/mlx5/core/resources.c | 73 ++++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/=
mlx5_vdpa.h
> index 424d445ebee4..b34e9b93d56e 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -105,6 +105,18 @@ struct mlx5_vdpa_dev {
>         bool suspended;
>  };
>
> +struct mlx5_vdpa_async_cmd {
> +       int err;
> +       struct mlx5_async_work cb_work;
> +       struct completion cmd_done;
> +
> +       void *in;
> +       size_t inlen;
> +
> +       void *out;
> +       size_t outlen;
> +};
> +
>  int mlx5_vdpa_create_tis(struct mlx5_vdpa_dev *mvdev, void *in, u32 *tis=
n);
>  void mlx5_vdpa_destroy_tis(struct mlx5_vdpa_dev *mvdev, u32 tisn);
>  int mlx5_vdpa_create_rqt(struct mlx5_vdpa_dev *mvdev, void *in, int inle=
n, u32 *rqtn);
> @@ -134,6 +146,9 @@ int mlx5_vdpa_update_cvq_iotlb(struct mlx5_vdpa_dev *=
mvdev,
>                                 unsigned int asid);
>  int mlx5_vdpa_create_dma_mr(struct mlx5_vdpa_dev *mvdev);
>  int mlx5_vdpa_reset_mr(struct mlx5_vdpa_dev *mvdev, unsigned int asid);
> +int mlx5_vdpa_exec_async_cmds(struct mlx5_vdpa_dev *mvdev,
> +                             struct mlx5_vdpa_async_cmd *cmds,
> +                             int num_cmds);
>
>  #define mlx5_vdpa_err(__dev, format, ...)                               =
                           \
>         dev_err((__dev)->mdev->device, "%s:%d:(pid %d) error: " format, _=
_func__, __LINE__,        \
> diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/=
resources.c
> index 5c5a41b64bfc..22ea32fe007b 100644
> --- a/drivers/vdpa/mlx5/core/resources.c
> +++ b/drivers/vdpa/mlx5/core/resources.c
> @@ -321,3 +321,76 @@ void mlx5_vdpa_free_resources(struct mlx5_vdpa_dev *=
mvdev)
>         mutex_destroy(&mvdev->mr_mtx);
>         res->valid =3D false;
>  }
> +
> +static void virtqueue_cmd_callback(int status, struct mlx5_async_work *c=
ontext)
> +{
> +       struct mlx5_vdpa_async_cmd *cmd =3D
> +               container_of(context, struct mlx5_vdpa_async_cmd, cb_work=
);
> +
> +       cmd->err =3D mlx5_cmd_check(context->ctx->dev, status, cmd->in, c=
md->out);
> +       complete(&cmd->cmd_done);
> +}
> +
> +static int issue_async_cmd(struct mlx5_vdpa_dev *mvdev,
> +                          struct mlx5_vdpa_async_cmd *cmds,
> +                          int issued,
> +                          int *completed)
> +
> +{
> +       struct mlx5_vdpa_async_cmd *cmd =3D &cmds[issued];
> +       int err;
> +
> +retry:
> +       err =3D mlx5_cmd_exec_cb(&mvdev->async_ctx,
> +                              cmd->in, cmd->inlen,
> +                              cmd->out, cmd->outlen,
> +                              virtqueue_cmd_callback,
> +                              &cmd->cb_work);
> +       if (err =3D=3D -EBUSY) {
> +               if (*completed < issued) {
> +                       /* Throttled by own commands: wait for oldest com=
pletion. */
> +                       wait_for_completion(&cmds[*completed].cmd_done);
> +                       (*completed)++;
> +
> +                       goto retry;
> +               } else {
> +                       /* Throttled by external commands: switch to sync=
 api. */
> +                       err =3D mlx5_cmd_exec(mvdev->mdev,
> +                                           cmd->in, cmd->inlen,
> +                                           cmd->out, cmd->outlen);
> +                       if (!err)
> +                               (*completed)++;
> +               }
> +       }
> +
> +       return err;
> +}
> +
> +int mlx5_vdpa_exec_async_cmds(struct mlx5_vdpa_dev *mvdev,
> +                             struct mlx5_vdpa_async_cmd *cmds,
> +                             int num_cmds)
> +{
> +       int completed =3D 0;
> +       int issued =3D 0;
> +       int err =3D 0;
> +
> +       for (int i =3D 0; i < num_cmds; i++)
> +               init_completion(&cmds[i].cmd_done);
> +
> +       while (issued < num_cmds) {
> +
> +               err =3D issue_async_cmd(mvdev, cmds, issued, &completed);
> +               if (err) {
> +                       mlx5_vdpa_err(mvdev, "error issuing command %d of=
 %d: %d\n",
> +                                     issued, num_cmds, err);
> +                       break;
> +               }
> +
> +               issued++;
> +       }
> +
> +       while (completed < issued)
> +               wait_for_completion(&cmds[completed++].cmd_done);
> +
> +       return err;
> +}
> --
> 2.45.1
>

