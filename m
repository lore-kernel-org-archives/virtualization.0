Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32C8C61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 04:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2807C6072A;
	Thu, 16 Feb 2023 04:49:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2807C6072A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLSFFlBD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JU20cWuSKL77; Thu, 16 Feb 2023 04:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 898A560767;
	Thu, 16 Feb 2023 04:49:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 898A560767
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57E4FC0033;
	Thu, 16 Feb 2023 04:49:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6FDA4C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 04:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4482981F3E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 04:49:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4482981F3E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLSFFlBD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QAIpysJViBMh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 04:49:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 01A4281EFD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 01A4281EFD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 04:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676522949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NlDKmPgYGuj2vp+iCLyrQRKv19uw3gvLOjVZhG1ou+Q=;
 b=RLSFFlBDQ6oQxqqRUtPzPjCQM7FVikukIWhKt2uVcMvp61hBMNfBDgaoRRHSKoXh72PJUf
 E55XTrxjjQo4yn5Rdm5NNpnby8Afede8ZbA9VVLDWrLtoYagklxtzp9QPJ2GJGnyjnP6py
 TO7544Izkzbjq0JkPvI6W83uD8R2abk=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-179-OpslwMIXM-WhfK67ngJ_jA-1; Wed, 15 Feb 2023 23:49:00 -0500
X-MC-Unique: OpslwMIXM-WhfK67ngJ_jA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-163af100c41so611447fac.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 20:49:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NlDKmPgYGuj2vp+iCLyrQRKv19uw3gvLOjVZhG1ou+Q=;
 b=6ZEkbLNzcDJPKdmLiMt/Pfn3T/3HHaBlO19NJMQxCkAwWnohbw/Dll2v3f2/FJ0/W1
 HymHHVC2XMzwEL704SPoIEKEoGQ9jEVq0HZq4Y8g6oJLZZG8ORcuyKoom5OtEMKRD+Cw
 KSwFxTw8KbCHYAjk53vcDh5Uy2+2MKWYkOFpm/swoHkQhTBz0hRANk4aFirPFOYSlmU7
 ssEzbwm68gWYNRSPbSH8HhluyRmWtJ2uI5L/HvJHHt+vyccVoKw0IUpBphmolIqDLa0i
 8MrSJ3kaKaMgz/xgFVFWOqXZw9bOOGNWullwiHlIhy2aBcURYyyI3NTF1fG8OjS9nj/d
 3zSw==
X-Gm-Message-State: AO0yUKX+OKF3v7BACTCF2wRZ/3q5Fnqir3l8TaZ80ZiFiy1E8Um8/QOK
 CpY5JQJh14g2dNvP5nT8Qzshejv8O7csu7r/zk/hDZhE1R7nY0pKtW2hNm5NFEBcLmM/awHLiM6
 QOoaELLJONUNv/rOOtXze/1q4XWSgsVavHxmr1hieLQ/iBQDQHpexkzqeIg==
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr59821oib.35.1676522940057; 
 Wed, 15 Feb 2023 20:49:00 -0800 (PST)
X-Google-Smtp-Source: AK7set/penI+mI8fHaWiIdLRXLv5ATb6NdjbtjsVWvqsvhX3hGUAZ5SRLsbEAlIOAgsLajHHCClQY8yHruiDl9lWezI=
X-Received: by 2002:a05:6808:3186:b0:37d:5d77:e444 with SMTP id
 cd6-20020a056808318600b0037d5d77e444mr59814oib.35.1676522939846; Wed, 15 Feb
 2023 20:48:59 -0800 (PST)
MIME-Version: 1.0
References: <1676424640-11673-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1676424640-11673-1-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Feb 2023 12:48:48 +0800
Message-ID: <CACGkMEuckWowpA9q+ez0-U4FicamQ+5zXfumtQMA25jXpvL7uw@mail.gmail.com>
Subject: Re: [PATCH v3] vdpa/mlx5: should not activate virtq object when
 suspended
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: mst@redhat.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 elic@nvidia.com
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

On Wed, Feb 15, 2023 at 9:31 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Otherwise the virtqueue object to instate could point to invalid address
> that was unmapped from the MTT:
>
>   mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
>   CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
>   bad parameter(0x3), syndrome (0x5fa1c), err(-22)
>
> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
> Cc: Eli Cohen <elic@nvidia.com>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Reviewed-by: Eli Cohen <elic@nvidia.com>
>
> ---
> v3: move suspended to struct mlx5_vdpa_dev
> v2: removed the change for improving warning message
> ---
>  drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 +++++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> index 058fbe2..25fc412 100644
> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> @@ -96,6 +96,7 @@ struct mlx5_vdpa_dev {
>         struct mlx5_control_vq cvq;
>         struct workqueue_struct *wq;
>         unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
> +       bool suspended;
>  };
>
>  int mlx5_vdpa_alloc_pd(struct mlx5_vdpa_dev *dev, u32 *pdn, u16 uid);
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3a6dbbc6..daac3ab 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2411,7 +2411,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
>         if (err)
>                 goto err_mr;
>
> -       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspended)

One more thought,

Does this mean set_map() is forbidden during suspending? I'm not sure
this is correct or at least we need restrict in in the vDPA core.

Thanks

>                 goto err_mr;
>
>         restore_channels_info(ndev);
> @@ -2579,6 +2579,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
>         clear_vqs_ready(ndev);
>         mlx5_vdpa_destroy_mr(&ndev->mvdev);
>         ndev->mvdev.status = 0;
> +       ndev->mvdev.suspended = false;
>         ndev->cur_num_vqs = 0;
>         ndev->mvdev.cvq.received_desc = 0;
>         ndev->mvdev.cvq.completed_desc = 0;
> @@ -2815,6 +2816,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>         struct mlx5_vdpa_virtqueue *mvq;
>         int i;
>
> +       mlx5_vdpa_info(mvdev, "suspending device\n");
> +
>         down_write(&ndev->reslock);
>         ndev->nb_registered = false;
>         mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> @@ -2824,6 +2827,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
>                 suspend_vq(ndev, mvq);
>         }
>         mlx5_vdpa_cvq_suspend(mvdev);
> +       mvdev->suspended = true;
>         up_write(&ndev->reslock);
>         return 0;
>  }
> --
> 1.8.3.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
