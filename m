Return-Path: <SRS0=cta8=MK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB646C636C8
	for <virtualization@archiver.kernel.org>; Sun, 18 Jul 2021 13:58:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 333EA61183
	for <virtualization@archiver.kernel.org>; Sun, 18 Jul 2021 13:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333EA61183
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D868840468;
	Sun, 18 Jul 2021 13:58:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fIP-47FHPJ_X; Sun, 18 Jul 2021 13:58:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E66B540466;
	Sun, 18 Jul 2021 13:58:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A4207C0010;
	Sun, 18 Jul 2021 13:58:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1664CC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 13:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0581560606
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 13:58:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BprHv87CWkhI
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 13:58:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E293460603
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 13:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626616703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=19v5D8bRVm+lStdjgUon0q9aeP8opTApQap714gjX7U=;
 b=bbH3KmwZ4E3/yyqFAD7Ifp12Kpvzwf3onioPvhaKzVKYHnlyrwZtz1fXuCN9UPnAs8MM5+
 BSMi/7nHtcWyKukdHSt5uVDJ9ZnWqG3mOMspnJUa+5XYNfalI6EGPEkJWSQW3c2+4UCs72
 u41LzJ68QhMxdL7+S8tCm8SR6oyaeAE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-dBivO9TTPHOJwjzzLtc88w-1; Sun, 18 Jul 2021 09:58:22 -0400
X-MC-Unique: dBivO9TTPHOJwjzzLtc88w-1
Received: by mail-wm1-f72.google.com with SMTP id
 k16-20020a7bc3100000b02901d849b41038so3306254wmj.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 06:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=19v5D8bRVm+lStdjgUon0q9aeP8opTApQap714gjX7U=;
 b=pWYVOJ/RhsUBQZsd5cq+uwVXocan/Rbd8k1Ckqgpd/FHg61UPqYjMJSmxR4e0SL665
 TbMiNdsUlWuUKqmWE099wnsOKAPTEyoaIhRSfBJqiIDcQGfqOCOFgd504YIUPI6gXxr1
 GAoIObIwe7Xuuz7NblMNLqtW2yDq3SduisedHiVvJ6WmQUpLqYoRO/r8RX5ryjSISj4S
 5dJAzw9Fz8mvNmgPhgTWlOt3jGPbgMszdD80jxJl7NCmPzUrHVlmjmIXvN6chTz+9Pmk
 fd+AoaNJUed0ulTU5LIwyhWvztqv0r38mpOdkxYRyowcuaNIp0wnHjccXw2bzdzxkEcL
 1NDA==
X-Gm-Message-State: AOAM531hcItaHJB7/NBMn0Bb9oSQLwH3B6maI4qYiDugYxZdWxDYjf+P
 OJbM60mo95di4NjbFmhS5TZfcWhrActbSnDTMySLDJr2OXeQ3kF133icxD3Lj5JW51aLyCzOu9n
 Fjd+9V/t8D+zciJCyx6MzsRbG0wfBVbTUSWINk1LSRA==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr5083520wru.80.1626616701139;
 Sun, 18 Jul 2021 06:58:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwF7QfXkH4VrgcY96cSNBnRG8DR0SNMZ2/Sbv43p7XU/OxiIQSeCAAcCG8kp14LFV47h3tTuA==
X-Received: by 2002:a5d:6889:: with SMTP id h9mr5083506wru.80.1626616700970;
 Sun, 18 Jul 2021 06:58:20 -0700 (PDT)
Received: from redhat.com ([2.55.29.175])
 by smtp.gmail.com with ESMTPSA id o18sm16881198wrx.21.2021.07.18.06.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jul 2021 06:58:20 -0700 (PDT)
Date: Sun, 18 Jul 2021 09:58:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH mlx5-next] IB/mlx5: Rename is_apu_thread_cq function to
 is_apu_cq
Message-ID: <20210718095805-mutt-send-email-mst@kernel.org>
References: <0e3364dab7e0e4eea5423878b01aa42470be8d36.1626609184.git.leonro@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <0e3364dab7e0e4eea5423878b01aa42470be8d36.1626609184.git.leonro@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Tal Gilboa <talgi@nvidia.com>
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

On Sun, Jul 18, 2021 at 02:54:13PM +0300, Leon Romanovsky wrote:
> From: Tal Gilboa <talgi@nvidia.com>
> 
> is_apu_thread_cq() used to detect CQs which are attached to APU
> threads. This was extended to support other elements as well,
> so the function was renamed to is_apu_cq().
> 
> c_eqn_or_apu_element was extended from 8 bits to 32 bits, which wan't
> reflected when the APU support was first introduced.
> 
> Signed-off-by: Tal Gilboa <talgi@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

vdpa bits
Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/infiniband/hw/mlx5/cq.c                            | 2 +-
>  drivers/infiniband/hw/mlx5/devx.c                          | 7 +++----
>  drivers/net/ethernet/mellanox/mlx5/core/cq.c               | 3 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c          | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c        | 2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c | 2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c                          | 2 +-
>  include/linux/mlx5/mlx5_ifc.h                              | 5 ++---
>  8 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
> index aef87a7c01ff..464e6a1ecdb0 100644
> --- a/drivers/infiniband/hw/mlx5/cq.c
> +++ b/drivers/infiniband/hw/mlx5/cq.c
> @@ -997,7 +997,7 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  				  MLX5_IB_CQ_PR_FLAGS_CQE_128_PAD));
>  	MLX5_SET(cqc, cqc, log_cq_size, ilog2(entries));
>  	MLX5_SET(cqc, cqc, uar_page, index);
> -	MLX5_SET(cqc, cqc, c_eqn, eqn);
> +	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, eqn);
>  	MLX5_SET64(cqc, cqc, dbr_addr, cq->db.dma);
>  	if (cq->create_flags & IB_UVERBS_CQ_FLAGS_IGNORE_OVERRUN)
>  		MLX5_SET(cqc, cqc, oi, 1);
> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
> index edcac8b3f384..31f5f4c73d25 100644
> --- a/drivers/infiniband/hw/mlx5/devx.c
> +++ b/drivers/infiniband/hw/mlx5/devx.c
> @@ -1437,11 +1437,10 @@ static void devx_cq_comp(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe)
>  	rcu_read_unlock();
>  }
>  
> -static bool is_apu_thread_cq(struct mlx5_ib_dev *dev, const void *in)
> +static bool is_apu_cq(struct mlx5_ib_dev *dev, const void *in)
>  {
>  	if (!MLX5_CAP_GEN(dev->mdev, apu) ||
> -	    !MLX5_GET(cqc, MLX5_ADDR_OF(create_cq_in, in, cq_context),
> -		      apu_thread_cq))
> +	    !MLX5_GET(cqc, MLX5_ADDR_OF(create_cq_in, in, cq_context), apu_cq))
>  		return false;
>  
>  	return true;
> @@ -1501,7 +1500,7 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
>  		err = mlx5_core_create_dct(dev, &obj->core_dct, cmd_in,
>  					   cmd_in_len, cmd_out, cmd_out_len);
>  	} else if (opcode == MLX5_CMD_OP_CREATE_CQ &&
> -		   !is_apu_thread_cq(dev, cmd_in)) {
> +		   !is_apu_cq(dev, cmd_in)) {
>  		obj->flags |= DEVX_OBJ_FLAGS_CQ;
>  		obj->core_cq.comp = devx_cq_comp;
>  		err = mlx5_core_create_cq(dev->mdev, &obj->core_cq,
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cq.c b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> index df3e4938ecdd..99ec278d0370 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cq.c
> @@ -89,7 +89,8 @@ static void mlx5_add_cq_to_tasklet(struct mlx5_core_cq *cq,
>  int mlx5_core_create_cq(struct mlx5_core_dev *dev, struct mlx5_core_cq *cq,
>  			u32 *in, int inlen, u32 *out, int outlen)
>  {
> -	int eqn = MLX5_GET(cqc, MLX5_ADDR_OF(create_cq_in, in, cq_context), c_eqn);
> +	int eqn = MLX5_GET(cqc, MLX5_ADDR_OF(create_cq_in, in, cq_context),
> +			   c_eqn_or_apu_element);
>  	u32 din[MLX5_ST_SZ_DW(destroy_cq_in)] = {};
>  	struct mlx5_eq_comp *eq;
>  	int err;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index c47603a952f3..308ccace48d0 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -1626,7 +1626,7 @@ static int mlx5e_create_cq(struct mlx5e_cq *cq, struct mlx5e_cq_param *param)
>  				  (__be64 *)MLX5_ADDR_OF(create_cq_in, in, pas));
>  
>  	MLX5_SET(cqc,   cqc, cq_period_mode, param->cq_period_mode);
> -	MLX5_SET(cqc,   cqc, c_eqn,         eqn);
> +	MLX5_SET(cqc,   cqc, c_eqn_or_apu_element, eqn);
>  	MLX5_SET(cqc,   cqc, uar_page,      mdev->priv.uar->index);
>  	MLX5_SET(cqc,   cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
>  					    MLX5_ADAPTER_PAGE_SHIFT);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> index 6f78716ff321..9bb4944820df 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/conn.c
> @@ -454,7 +454,7 @@ static int mlx5_fpga_conn_create_cq(struct mlx5_fpga_conn *conn, int cq_size)
>  
>  	cqc = MLX5_ADDR_OF(create_cq_in, in, cq_context);
>  	MLX5_SET(cqc, cqc, log_cq_size, ilog2(cq_size));
> -	MLX5_SET(cqc, cqc, c_eqn, eqn);
> +	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, eqn);
>  	MLX5_SET(cqc, cqc, uar_page, fdev->conn_res.uar->index);
>  	MLX5_SET(cqc, cqc, log_page_size, conn->cq.wq_ctrl.buf.page_shift -
>  			   MLX5_ADAPTER_PAGE_SHIFT);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
> index d1300b16d054..a4a3ee87a903 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_send.c
> @@ -790,7 +790,7 @@ static struct mlx5dr_cq *dr_create_cq(struct mlx5_core_dev *mdev,
>  
>  	cqc = MLX5_ADDR_OF(create_cq_in, in, cq_context);
>  	MLX5_SET(cqc, cqc, log_cq_size, ilog2(ncqe));
> -	MLX5_SET(cqc, cqc, c_eqn, eqn);
> +	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, eqn);
>  	MLX5_SET(cqc, cqc, uar_page, uar->index);
>  	MLX5_SET(cqc, cqc, log_page_size, cq->wq_ctrl.buf.page_shift -
>  		 MLX5_ADAPTER_PAGE_SHIFT);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 0121c7c49396..83fa3c26cbd2 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -573,7 +573,7 @@ static int cq_create(struct mlx5_vdpa_net *ndev, u16 idx, u32 num_ent)
>  	cqc = MLX5_ADDR_OF(create_cq_in, in, cq_context);
>  	MLX5_SET(cqc, cqc, log_cq_size, ilog2(num_ent));
>  	MLX5_SET(cqc, cqc, uar_page, ndev->mvdev.res.uar->index);
> -	MLX5_SET(cqc, cqc, c_eqn, eqn);
> +	MLX5_SET(cqc, cqc, c_eqn_or_apu_element, eqn);
>  	MLX5_SET64(cqc, cqc, dbr_addr, vcq->db.dma);
>  
>  	err = mlx5_core_create_cq(mdev, &vcq->mcq, in, inlen, out, sizeof(out));
> diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> index c980eab89867..e93f16b87312 100644
> --- a/include/linux/mlx5/mlx5_ifc.h
> +++ b/include/linux/mlx5/mlx5_ifc.h
> @@ -3923,7 +3923,7 @@ struct mlx5_ifc_cqc_bits {
>  	u8         status[0x4];
>  	u8         reserved_at_4[0x2];
>  	u8         dbr_umem_valid[0x1];
> -	u8         apu_thread_cq[0x1];
> +	u8         apu_cq[0x1];
>  	u8         cqe_sz[0x3];
>  	u8         cc[0x1];
>  	u8         reserved_at_c[0x1];
> @@ -3949,8 +3949,7 @@ struct mlx5_ifc_cqc_bits {
>  	u8         cq_period[0xc];
>  	u8         cq_max_count[0x10];
>  
> -	u8         reserved_at_a0[0x18];
> -	u8         c_eqn[0x8];
> +	u8         c_eqn_or_apu_element[0x20];
>  
>  	u8         reserved_at_c0[0x3];
>  	u8         log_page_size[0x5];
> -- 
> 2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
