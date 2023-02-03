Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E615DC61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 08:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7442242590;
	Fri,  3 Feb 2023 08:14:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7442242590
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QP7oYfyO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q7nGaTQuFpd4; Fri,  3 Feb 2023 08:14:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8C01D41BB3;
	Fri,  3 Feb 2023 08:14:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8C01D41BB3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61818C0032;
	Fri,  3 Feb 2023 08:14:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED2CBC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:14:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BFD53820B3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:14:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BFD53820B3
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QP7oYfyO
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KI3bNabGkekN
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:14:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B474820B1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B474820B1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675412074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RBSNvTzGGuF/AnMtphdz8gAhAXklpF3dQGWk2OV7ssc=;
 b=QP7oYfyO15EdW4bZHYjM7C7zrf60fgZ8Of75gzjSVNOflzB1fdQx6TtCMMXBH1nJnkLTDs
 dk+ILqggmpC6iJgo/UYNjtNL25h1pR/MGCzLpEZ8WxNXKc+il2dQruBJbtaG2pyQaDlFpV
 jh+CbfPzY8LA2JQvaq6npMh5xEAHnVo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-r4VxaZMjM7emQjCuvpChxQ-1; Fri, 03 Feb 2023 03:14:33 -0500
X-MC-Unique: r4VxaZMjM7emQjCuvpChxQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 e9-20020a5d6d09000000b002c172f173a9so566867wrq.17
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 00:14:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RBSNvTzGGuF/AnMtphdz8gAhAXklpF3dQGWk2OV7ssc=;
 b=1en3LscwFg10qsGNUAcXoV6eInj6izfaYZf28yyCa9AkidsHcKzpkVGeyLMd/2jE3j
 9RZgIGNn9NSuYtSLgjbm+n34Wd6JdvlnMfDZfHLMlJKmvRf/lhvs1mgjX++1oLfghram
 YRq7vlm1PdQVeV+2553ebOfrbFv8d40/dlM6L2ENJqochVfb8pPRzWkqWwHKSwzNSNbl
 rmmmyYLhHUm0SGMJaokzE/oiZvoxEnqBxiWASG4ZVrLi1h2FigKc2cUgeRkWjvrlYu3+
 wf2aF819KIpUA+llFauOi2sVbJ/GZOYEQ+ALJcOqE5RuokoqiyNdTfnaI4plXrmUrrKq
 DNyQ==
X-Gm-Message-State: AO0yUKVXRYIbTIvsQC2DHQqRUoYyaUxW6da666m9ZCQIB1dqNxmUCEiC
 7MNwOdpmh6QSBcqSmkbBTh/OFc2Pis/HYHZkA1LJOKB6xGmb0wXXin89hXfyxnHOVHT+cRURBsH
 BQLQGy2ON3txSn5jhV1sqySYibL3m9ZC/nwslA5gQhA==
X-Received: by 2002:a7b:ce11:0:b0:3dc:5302:ad9 with SMTP id
 m17-20020a7bce11000000b003dc53020ad9mr10452474wmc.27.1675412072422; 
 Fri, 03 Feb 2023 00:14:32 -0800 (PST)
X-Google-Smtp-Source: AK7set9XLR1nt2yYDupc37z1u66lHeROwAvON4PoONn4AVsn75DKzjR5/jFjM4/qc6XCMKADet3/GQ==
X-Received: by 2002:a7b:ce11:0:b0:3dc:5302:ad9 with SMTP id
 m17-20020a7bce11000000b003dc53020ad9mr10452458wmc.27.1675412072183; 
 Fri, 03 Feb 2023 00:14:32 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 v9-20020a05600c470900b003dfe549da4fsm1622359wmo.18.2023.02.03.00.14.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 00:14:31 -0800 (PST)
Date: Fri, 3 Feb 2023 03:14:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v2 6/7] vdpa/mlx5: conditionally show MTU and STATUS in
 config space
Message-ID: <20230203030944-mutt-send-email-mst@kernel.org>
References: <1675207345-22328-1-git-send-email-si-wei.liu@oracle.com>
 <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1675207345-22328-7-git-send-email-si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, elic@nvidia.com,
 virtualization@lists.linux-foundation.org
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

On Tue, Jan 31, 2023 at 03:22:24PM -0800, Si-Wei Liu wrote:
> The spec says:
>     mtu only exists if VIRTIO_NET_F_MTU is set
>     status only exists if VIRTIO_NET_F_STATUS is set
> 
> We should only show MTU and STATUS conditionally depending on
> the feature bits.
> 
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

so change the subject pls. it seems to say you are showing them
when you previously didn't, what's going on is something like:

	make MTU/status access conditional on feature bits

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3a6dbbc6..3d49eae 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3009,6 +3009,8 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>  	struct mlx5_vdpa_wq_ent *wqent;
>  
>  	if (event == MLX5_EVENT_TYPE_PORT_CHANGE) {
> +		if (!(ndev->mvdev.actual_features & BIT_ULL(VIRTIO_NET_F_STATUS)))
> +			return NOTIFY_DONE;
>  		switch (eqe->sub_type) {
>  		case MLX5_PORT_CHANGE_SUBTYPE_DOWN:
>  		case MLX5_PORT_CHANGE_SUBTYPE_ACTIVE:
> @@ -3118,16 +3120,20 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>  			goto err_alloc;
>  	}
>  
> -	err = query_mtu(mdev, &mtu);
> -	if (err)
> -		goto err_alloc;
> +	if (device_features & BIT_ULL(VIRTIO_NET_F_MTU)) {
> +		err = query_mtu(mdev, &mtu);
> +		if (err)
> +			goto err_alloc;
>  
> -	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> +		ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, mtu);
> +	}
>  
> -	if (get_link_state(mvdev))
> -		ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> -	else
> -		ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +	if (device_features & BIT_ULL(VIRTIO_NET_F_STATUS)) {
> +		if (get_link_state(mvdev))
> +			ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> +		else
> +			ndev->config.status &= cpu_to_mlx5vdpa16(mvdev, ~VIRTIO_NET_S_LINK_UP);
> +	}
>  
>  	if (add_config->mask & (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR)) {
>  		memcpy(ndev->config.mac, add_config->net.mac, ETH_ALEN);
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
