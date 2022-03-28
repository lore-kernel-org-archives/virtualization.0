Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F60CC433FE
	for <virtualization@archiver.kernel.org>; Mon, 28 Mar 2022 20:57:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BA7A82425;
	Mon, 28 Mar 2022 20:57:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 90Pa4WmXmATt; Mon, 28 Mar 2022 20:57:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1614981D24;
	Mon, 28 Mar 2022 20:57:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9616C002C;
	Mon, 28 Mar 2022 20:57:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E925C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DE3860B0B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AJcGHRlKJrTr
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:57:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9393F606C6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 20:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648501050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6NsKJxe+7SAFVcBgW4uEsAlRiZARoKwGNqa10R93Kzs=;
 b=gQaVeW2HcGoUPgki3graMOdidyov6MCpTG1IzJJPvj/kznadOnWi+LNTm2GxBEcE9Rw7+E
 IfE1JDyX+BU/Zh25F8BN2wZDuffr00EBdNi0ZYErhoYrRB/zCIX0DRW3Sfh5glmWerz/tt
 ac1qnw16l5nlo5krXwGgzuOE+opuasg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-2dOQPhphNfKPJbSXExl2pA-1; Mon, 28 Mar 2022 16:57:29 -0400
X-MC-Unique: 2dOQPhphNfKPJbSXExl2pA-1
Received: by mail-wm1-f72.google.com with SMTP id
 n19-20020a7bcbd3000000b0038c94b86258so228245wmi.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Mar 2022 13:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6NsKJxe+7SAFVcBgW4uEsAlRiZARoKwGNqa10R93Kzs=;
 b=NcvucJuU/wYAEzizSfSX65M6lekDugu7X8Y9ItlBZ+zATbEHwWdxSN6BqXTDcE3pKc
 MrAbveY8JMASjOFEZRkUruylmB+y0O4y1FGbx1MqFO64JbanG5A5z2lLdLsju1wHQ3Yr
 IatWT1bnRd8PFWL7FQoI1pFsB/PgK3WdGfKSqs8SsG3OkMVr82REh2aaBX1sLi+949cL
 HGQax1DNRd8z9Cge9GES+XsyFcrBnWzhoqpvbSd25SgR7JxNOkFa21gC3h9lM8P8+xfp
 K0XIanucbzNJ7wPRKs1nNpn/W+gu/8NvYu/kYu2Uqr7u9uHyityl5cMuqmeYPyldxvgq
 EHBA==
X-Gm-Message-State: AOAM531T3EuyqG/Cca2QCJ1kmrkDiDaqaJZEaGzuf7IsG2AnV2UqfMwL
 cbgDlAJz+ay3Q1+x5pQd/WNu7gWKTKoK2B+dr7kQPT7YtCxwH1jACTUiqrtOGG9929Kx3wdPP+Z
 5DmmUHi47jHTxCjnXiywovrokl+/UQRv7c9KM4cKvJQ==
X-Received: by 2002:adf:f2c6:0:b0:203:f0ba:424c with SMTP id
 d6-20020adff2c6000000b00203f0ba424cmr25758798wrp.663.1648501047754; 
 Mon, 28 Mar 2022 13:57:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY4jaPe6GQT7AX9aKWMvcigAJnlb9ZwnyZXtZzcup1yjeifadaXBc4bYS6qhlPL270LJJo8w==
X-Received: by 2002:adf:f2c6:0:b0:203:f0ba:424c with SMTP id
 d6-20020adff2c6000000b00203f0ba424cmr25758768wrp.663.1648501047509; 
 Mon, 28 Mar 2022 13:57:27 -0700 (PDT)
Received: from redhat.com ([2.52.9.207]) by smtp.gmail.com with ESMTPSA id
 b10-20020a05600018aa00b002042a98168csm15260829wri.15.2022.03.28.13.57.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Mar 2022 13:57:26 -0700 (PDT)
Date: Mon, 28 Mar 2022 16:57:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v1] net/mlx5: Add support for configuring max device MTU
Message-ID: <20220328165657-mutt-send-email-mst@kernel.org>
References: <20220221121927.194728-1-elic@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220221121927.194728-1-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Mon, Feb 21, 2022 at 02:19:27PM +0200, Eli Cohen wrote:
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

missing space before <

> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
> Update changelog


can you rebase pls? does not seem to apply

>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 32 ++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 6156cf6e9377..be095dc1134e 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2689,6 +2689,28 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>  	return ret;
>  }
>  
> +static int config_func_mtu(struct mlx5_core_dev *mdev, u16 mtu)
> +{
> +	int inlen = MLX5_ST_SZ_BYTES(modify_nic_vport_context_in);
> +	void *in;
> +	int err;
> +
> +	in = kvzalloc(inlen, GFP_KERNEL);
> +	if (!in)
> +		return -ENOMEM;
> +
> +	MLX5_SET(modify_nic_vport_context_in, in, field_select.mtu, 1);
> +	MLX5_SET(modify_nic_vport_context_in, in, nic_vport_context.mtu,
> +		 mtu + MLX5V_ETH_HARD_MTU);
> +	MLX5_SET(modify_nic_vport_context_in, in, opcode,
> +		 MLX5_CMD_OP_MODIFY_NIC_VPORT_CONTEXT);
> +
> +	err = mlx5_cmd_exec_in(mdev, modify_nic_vport_context, in);
> +
> +	kvfree(in);
> +	return err;
> +}
> +
>  static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  			     const struct vdpa_dev_set_config *add_config)
>  {
> @@ -2749,6 +2771,13 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  	mutex_init(&ndev->reslock);
>  	mutex_init(&ndev->numq_lock);
>  	config = &ndev->config;
> +
> +	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)) {
> +		err = config_func_mtu(mdev, add_config->net.mtu);
> +		if (err)
> +			goto err_mtu;
> +	}
> +
>  	err = query_mtu(mdev, &mtu);
>  	if (err)
>  		goto err_mtu;
> @@ -2867,7 +2896,8 @@ static int mlx5v_probe(struct auxiliary_device *adev,
>  	mgtdev->mgtdev.device = mdev->device;
>  	mgtdev->mgtdev.id_table = id_table;
>  	mgtdev->mgtdev.config_attr_mask = BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) |
> -					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP) |
> +					  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
>  	mgtdev->mgtdev.max_supported_vqs =
>  		MLX5_CAP_DEV_VDPA_EMULATION(mdev, max_num_virtio_queues) + 1;
>  	mgtdev->mgtdev.supported_features = get_supported_features(mdev);
> -- 
> 2.35.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
