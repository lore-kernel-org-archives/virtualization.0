Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36BA8C636CC
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 05:10:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC84A400A6;
	Thu, 16 Feb 2023 05:10:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC84A400A6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hg9vq+kL
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VhSs2llP9JyF; Thu, 16 Feb 2023 05:10:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 297C640B84;
	Thu, 16 Feb 2023 05:10:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 297C640B84
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06582C0032;
	Thu, 16 Feb 2023 05:10:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BE14C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:10:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E517040C83
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:10:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E517040C83
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1GidU-yI7pMQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:10:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B07DC40B84
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B07DC40B84
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 05:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676524236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CEOw+fFXvT/l5l18gNoMMgT+IO3GvsNReydBsGDaXBw=;
 b=hg9vq+kLbSCPUBCOLIZ3++Te3LsxiLCd+SVkzzDb+gvdVvl4LGFDXBDyhUdg2SnTsr1Z0N
 8czi+laYWOIp7CQ/4j1ZgL35HmVcWmxgfZo4MUHOD9shpmcnZb0G+sMGayIbHrVZ8/ouCL
 6+YJwGObwhVGFlAL9f+wWZrVUfmsB2c=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-502-sRUvjZGJPIe6ZAr6cwBJKw-1; Thu, 16 Feb 2023 00:10:35 -0500
X-MC-Unique: sRUvjZGJPIe6ZAr6cwBJKw-1
Received: by mail-ot1-f70.google.com with SMTP id
 bm4-20020a056830374400b00690d91ee5bcso187025otb.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 21:10:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CEOw+fFXvT/l5l18gNoMMgT+IO3GvsNReydBsGDaXBw=;
 b=Rlf0mmCg867aCve1gACqvY5BQkA8iwAgF62rUY3UvYLHRWg1xiQWamb6Ctj8ezxww6
 4Hgo8GI4wd1sc9BkO526Zm3sQOUah9KDPp81rX6pOzHGz26tWQGPaZw3PSoTpBwZC3kx
 GPNi37MojsgCTteC5wcnt7ykzlZ1QNJ9bLvn4L74OY94QwHXl0vT8KMgCR6TrTlyiZXW
 heXGmQNmVnuwk945AIuTVsLzB/AXzgPs9Jda9G0/E1v1Q/ovDfagwwcImeDVceeCC0l6
 6gXFW7fNPv8scElPmxmQW7oq2R9dRsaHcqSWgmKv2kjxFogJuLEaAyOaiRoumQ0/SK8+
 GIEw==
X-Gm-Message-State: AO0yUKV4l8D+hh8AzusgkZqGqWF8lXEH0TrDW0fxoPHp5cxhVqXELSBF
 u3LwYe6fb4nd713UPUchSFoXkVSXNPYT0CsQ6Tui7JXmzhszy6eaeAquWRhS1jgslbA8oSDvxd+
 KWh9PVNA7csJmuP1gJTTPJZHSR1BJ5BaynKzBCPsx8SIE5Gb5dksed718iQ==
X-Received: by 2002:a05:6871:84ca:b0:16a:2c1a:e416 with SMTP id
 sw10-20020a05687184ca00b0016a2c1ae416mr63866oab.35.1676524234414; 
 Wed, 15 Feb 2023 21:10:34 -0800 (PST)
X-Google-Smtp-Source: AK7set/KIXftRtboDYzsgFuohH6mdd4wAc8dK2MW76paQ88KbDnud3z3FIDB5p1pRuBJVDOzPWMr5/wdXAtMDdG88Xs=
X-Received: by 2002:a05:6871:84ca:b0:16a:2c1a:e416 with SMTP id
 sw10-20020a05687184ca00b0016a2c1ae416mr63865oab.35.1676524234152; Wed, 15 Feb
 2023 21:10:34 -0800 (PST)
MIME-Version: 1.0
References: <1676424640-11673-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEuckWowpA9q+ez0-U4FicamQ+5zXfumtQMA25jXpvL7uw@mail.gmail.com>
 <ea8bdfc7-46b9-8510-0a87-1fa6dd5759a1@oracle.com>
In-Reply-To: <ea8bdfc7-46b9-8510-0a87-1fa6dd5759a1@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 16 Feb 2023 13:10:23 +0800
Message-ID: <CACGkMEsnLfrGOa2gqT8n9W4pFxnpHWwsmjokx2kqojo=O37O-Q@mail.gmail.com>
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

On Thu, Feb 16, 2023 at 1:03 PM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 2/15/2023 8:48 PM, Jason Wang wrote:
> > On Wed, Feb 15, 2023 at 9:31 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >> Otherwise the virtqueue object to instate could point to invalid address
> >> that was unmapped from the MTT:
> >>
> >>    mlx5_core 0000:41:04.2: mlx5_cmd_out_err:782:(pid 8321):
> >>    CREATE_GENERAL_OBJECT(0xa00) op_mod(0xd) failed, status
> >>    bad parameter(0x3), syndrome (0x5fa1c), err(-22)
> >>
> >> Fixes: cae15c2ed8e6 ("vdpa/mlx5: Implement susupend virtqueue callback")
> >> Cc: Eli Cohen <elic@nvidia.com>
> >> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> >> Reviewed-by: Eli Cohen <elic@nvidia.com>
> >>
> >> ---
> >> v3: move suspended to struct mlx5_vdpa_dev
> >> v2: removed the change for improving warning message
> >> ---
> >>   drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
> >>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 +++++-
> >>   2 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >> index 058fbe2..25fc412 100644
> >> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> >> @@ -96,6 +96,7 @@ struct mlx5_vdpa_dev {
> >>          struct mlx5_control_vq cvq;
> >>          struct workqueue_struct *wq;
> >>          unsigned int group2asid[MLX5_VDPA_NUMVQ_GROUPS];
> >> +       bool suspended;
> >>   };
> >>
> >>   int mlx5_vdpa_alloc_pd(struct mlx5_vdpa_dev *dev, u32 *pdn, u16 uid);
> >> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> index 3a6dbbc6..daac3ab 100644
> >> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> >> @@ -2411,7 +2411,7 @@ static int mlx5_vdpa_change_map(struct mlx5_vdpa_dev *mvdev,
> >>          if (err)
> >>                  goto err_mr;
> >>
> >> -       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK))
> >> +       if (!(mvdev->status & VIRTIO_CONFIG_S_DRIVER_OK) || mvdev->suspended)
> > One more thought,
> >
> > Does this mean set_map() is forbidden during suspending?
> No, it will not. Instead it now allows set_map() to proceed even if
> mapping is shrinking while device is suspended. The "goto err_mr" below
> actually returns 0 when it leaves mlx5_vdpa_change_map().

You're right.

So

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> -Siwei
>
> >   I'm not sure
> > this is correct or at least we need restrict in in the vDPA core.
> >
> > Thanks
> >
> >>                  goto err_mr;
> >>
> >>          restore_channels_info(ndev);
> >> @@ -2579,6 +2579,7 @@ static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> >>          clear_vqs_ready(ndev);
> >>          mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >>          ndev->mvdev.status = 0;
> >> +       ndev->mvdev.suspended = false;
> >>          ndev->cur_num_vqs = 0;
> >>          ndev->mvdev.cvq.received_desc = 0;
> >>          ndev->mvdev.cvq.completed_desc = 0;
> >> @@ -2815,6 +2816,8 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
> >>          struct mlx5_vdpa_virtqueue *mvq;
> >>          int i;
> >>
> >> +       mlx5_vdpa_info(mvdev, "suspending device\n");
> >> +
> >>          down_write(&ndev->reslock);
> >>          ndev->nb_registered = false;
> >>          mlx5_notifier_unregister(mvdev->mdev, &ndev->nb);
> >> @@ -2824,6 +2827,7 @@ static int mlx5_vdpa_suspend(struct vdpa_device *vdev)
> >>                  suspend_vq(ndev, mvq);
> >>          }
> >>          mlx5_vdpa_cvq_suspend(mvdev);
> >> +       mvdev->suspended = true;
> >>          up_write(&ndev->reslock);
> >>          return 0;
> >>   }
> >> --
> >> 1.8.3.1
> >>
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
