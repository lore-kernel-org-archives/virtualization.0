Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B664EC433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 04:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F24160BCF;
	Tue, 22 Feb 2022 04:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8Rs3wKluboRM; Tue, 22 Feb 2022 04:03:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EA3F36068F;
	Tue, 22 Feb 2022 04:03:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD478C001A;
	Tue, 22 Feb 2022 04:03:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1CE2EC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F14734024A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nTmbfo67AS6f
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:03:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19B9840245
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 04:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645502617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lKf4MjVbZUBm3fTgWqxNbiuk0rsvQ53Db3zDfsWgwRY=;
 b=Ff21d/63EF7ROJYFry/h387PqUZ3ZxO7w/OatZxyPX9K/kF4Wic8OZWOixW2jCcB8dvb1Z
 yDqIj8CKs2klO71gbXB+R+IubPMAmJdP0MjOrvc2XSfidOndbBddxNMjW9kAi4tg+wPtOI
 /QA2E8Jxj52TVhNGvz+Pi64UC/yJ7D8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-fHsb6YNaM0iHfG41WuuIFw-1; Mon, 21 Feb 2022 23:03:35 -0500
X-MC-Unique: fHsb6YNaM0iHfG41WuuIFw-1
Received: by mail-lj1-f197.google.com with SMTP id
 20-20020a2e0914000000b0024635d136ddso3139123ljj.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Feb 2022 20:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lKf4MjVbZUBm3fTgWqxNbiuk0rsvQ53Db3zDfsWgwRY=;
 b=5KuZ9r/nTPBOfjRiYNoj5eHKAnXHHyiuj42T2drNWtHGJRR711ky5IxPD0sa3jvWJ6
 fggZron4BbMrtGQGW0orvETX5VqErWlQtcpqI71FI3mxnSea39bH7IKFNANB3g8scxri
 8YzdIFa4n2Zx/vLnW6LqK6eGTDJeB3mpbImQlo3PIiGQ3zKpYpyuvfgH4dQfb0WhrcEo
 GXEaRV/TiYuTg+uq9krzHXM9gMi3SCk2OEBMwN5M4MHPJ+fQVpQdYPmE3+hXCExI915h
 sPrYioYnYRaDfTCXoXcIzOvD0AO641tT/Pcm+82YJKaBNyO7sV7SkFOyF2U5gnDEgMvU
 MPYw==
X-Gm-Message-State: AOAM533cfjKqeqRXLXg2YGwePFXXyoljk9g08dUZcCjUlhlvrxjElMd3
 P9hDSjMEP5GvldDah0p+QO7TC/4B1DvN7d7vNHqt7DWf0DKes0TeQ9S8Ool2iV5CII4VXQxbke7
 dW7nd0QDQkdOkorLn6v54xwIx1Yn0ZwXeaN6WpoO/YI7HiyQyCqtOpw6uTA==
X-Received: by 2002:a05:6512:2808:b0:43f:4baa:7e5f with SMTP id
 cf8-20020a056512280800b0043f4baa7e5fmr15970963lfb.498.1645502614061; 
 Mon, 21 Feb 2022 20:03:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzAqs5EIgpavZOeq4gQ/EOWhds0EWOH56IIHk2I6dupiwD6ApmRiQ/2MFlm7PnLkx8olRQlyxVy6MmhXibECQQ=
X-Received: by 2002:a05:6512:2808:b0:43f:4baa:7e5f with SMTP id
 cf8-20020a056512280800b0043f4baa7e5fmr15970952lfb.498.1645502613887; Mon, 21
 Feb 2022 20:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20220221121927.194728-1-elic@nvidia.com>
In-Reply-To: <20220221121927.194728-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Feb 2022 12:03:22 +0800
Message-ID: <CACGkMEuUUsKAOGktSYhEvWN-LOfd6hUqMfnZcd2d+UHsf1ER-A@mail.gmail.com>
Subject: Re: [PATCH v1] net/mlx5: Add support for configuring max device MTU
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, Feb 21, 2022 at 8:19 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Allow an admin creating a vdpa device to specify the max MTU for the
> net device.
>
> For example, to create a device with max MTU of 1000, the following
> command can be used:
>
> $ vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 mtu 1000
>
> This configuration mechanism assumes that vdpa is the sole real user of
> the function. mlx5_core could theoretically change the mtu of the
> function using the ip command on the mlx5_core net device but this
> should not be done.
>
> Reviewed-by: Si-Wei Liu<si-wei.liu@oracle.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> v0 -> v1:
> Update changelog
>
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 32 ++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6156cf6e9377..be095dc1134e 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2689,6 +2689,28 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>         return ret;
>  }
>
> +static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
> +{
> +       int inlen = MLX5_ST_SZ_BYTES(modify_nic_vport_context_in);
> +       void *in;
> +       int err;
> +
> +       in = kvzalloc(inlen, GFP_KERNEL);
> +       if (!in)
> +               return -ENOMEM;
> +
> +       MLX5_SET(modify_nic_vport_context_in, in, field_select.mtu, 1);
> +       MLX5_SET(modify_nic_vport_context_in, in, nic_vport_context.mtu,
> +                mtu + MLX5V_ETH_HARD_MTU);
> +       MLX5_SET(modify_nic_vport_context_in, in, opcode,
> +                MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT);
> +
> +       err = mlx5_cmd_exec_in(mdev, modify_nic_vport_context, in);
> +
> +       kvfree(in);
> +       return err;
> +}
> +
>  static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>                              const struct vdpa_dev_set_config *add_config)
>  {
> @@ -2749,6 +2771,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>         mutex_init(&ndev->reslock);
>         mutex_init(&ndev->numq_lock);
>         config = &ndev->config;
> +
> +       if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
> +               err = config_func_mtu(mdev, add_config->net.mtu);
> +               if (err)
> +                       goto err_mtu;
> +       }
> +
>         err = query_mtu(mdev, &mtu);
>         if (err)
>                 goto err_mtu;
> @@ -2867,7 +2896,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>         mgtdev->mgtdev.device = mdev->device;
>         mgtdev->mgtdev.id_table = id_table;
>         mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> -                                         BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +                                         BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP) |
> +                                         BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
>         mgtdev->mgtdev.max_supported_vqs =
>                 MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
>         mgtdev->mgtdev.supported_features = get_supported_features(mdev);
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
