Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3D9C433EF
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 02:35:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71A5B40924;
	Wed, 12 Jan 2022 02:35:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11wLowoRl9Td; Wed, 12 Jan 2022 02:35:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B8F6C40939;
	Wed, 12 Jan 2022 02:35:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9429AC002F;
	Wed, 12 Jan 2022 02:35:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B754C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:35:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3A8F483F09
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:35:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2enRnwjlTkYT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:35:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8004083F08
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641954924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p9JZnnhK2vlfStgckjEq3pwHsmac9WX4pj5kmY0eIc4=;
 b=U+wpv/ApkgHB7wlgCVPQBbquI3IbKz3Ul5m9g7k0P7ADee+gzozXVBF/gbIBf8XWyAxNFt
 S/bMNsBoHxm9uqeIum24mEVyltHqDzJXJNbCYLJh8cD1I7S6nU+/ow7LVawgKmQZq+i1w/
 ZBCwggfTT5tfPCeEL7g6t9E0Aapo6oQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-446-qdOuxliMOO6tDXBJIV4MBA-1; Tue, 11 Jan 2022 21:35:21 -0500
X-MC-Unique: qdOuxliMOO6tDXBJIV4MBA-1
Received: by mail-lf1-f72.google.com with SMTP id
 v7-20020a056512048700b0042d99b3a962so615612lfq.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 18:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p9JZnnhK2vlfStgckjEq3pwHsmac9WX4pj5kmY0eIc4=;
 b=vILbdUMSpFX+5lgDpvL27HQ+LUs7eLEp0U8MKDHxlTr/hQ6lznZpuiuXIFv4EvWcsG
 0KluemoEVZIHuGo2n+FLHF4gUa6n02lQuMdsw0QQiJMru7UHhQy/eMGkus7hRKCccLjE
 mxYM4OyNX/oCIFe8dE4GDuVhVDa5tAS/pka/CBrhfsICkt22QDfsF/LehqWS+BJQMz8o
 RdJNGca6NiEdiumab0y0eD8GpEKmXKjZAwRUC8rcwLkfDOEc2v0sr7wdujsvaivqxdde
 KPb/tyJbtyosYuWIQ5MD0O4o7hMzdp7v0KXGdgpSOfLvR6dlmnR+5FcfQAnolNMRwaBP
 rmEg==
X-Gm-Message-State: AOAM531zZ8gFXPbG5p/yth8Yu20wmX15J4iZphV026D6Bfp41Lb1Nb9J
 n7XPrZNzu4Qo2OMW9+lUCQMVRL318zy4/5K3Jziu5PwxeWNPc1d4nq+T2sNNQJEKc0vsJB/HBSd
 6PUuzcoGqrzyf9WmzSx3I+czmWN6OSOnc37sB7Ihq9DoyEcgmQewOWPOzvA==
X-Received: by 2002:a2e:b791:: with SMTP id n17mr4750582ljo.307.1641954919517; 
 Tue, 11 Jan 2022 18:35:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw69A9oJBNrY3fnjH3prBtSTXXi+ZShpFK+Pj4DkGsUUEVNppewHWoCXntdcGQ6eRw3+xyOn3ybU0CTGCH4Z3A=
X-Received: by 2002:a2e:b791:: with SMTP id n17mr4750574ljo.307.1641954919337; 
 Tue, 11 Jan 2022 18:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20220111183400.38418-1-elic@nvidia.com>
 <20220111183400.38418-4-elic@nvidia.com>
In-Reply-To: <20220111183400.38418-4-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 10:35:08 +0800
Message-ID: <CACGkMEuxjmYhy1QfoWb8S-S4-CfijLxs=21_F_Jv486otdUG=g@mail.gmail.com>
Subject: Re: [PATCH 3/4] vdpa/mlx5: Fix is_index_valid() to refer to features
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

On Wed, Jan 12, 2022 at 2:34 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Make sure the decision whether an index received through a callback is
> valid or not consults the negotiated features.
>
> The motivation for this was due to a case encountered where I shut down
> the VM. After the reset operation was called features were already
> clear, I got get_vq_state() call which caused out array bounds
> access since is_index_valid() reported the index value.
>
> So this is more of not hit a bug since the call shouldn't have been made
> first place.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index d1ff65065fb1..9eacfdb48434 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -133,10 +133,14 @@ struct mlx5_vdpa_virtqueue {
>
>  static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
>  {
> -       if (unlikely(idx > mvdev->max_idx))
> -               return false;
> +       if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_MQ))) {
> +               if (!(mvdev->actual_features & BIT_ULL(VIRTIO_NET_F_CTRL_VQ)))
> +                       return idx < 2;
> +               else
> +                       return idx < 3;
> +       }
>
> -       return true;
> +       return idx <= mvdev->max_idx;
>  }
>
>  struct mlx5_vdpa_net {
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
