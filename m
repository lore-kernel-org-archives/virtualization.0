Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2247C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 08:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 689A982443;
	Mon, 13 Jun 2022 08:10:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3XZemdHfqBes; Mon, 13 Jun 2022 08:10:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 089FF81D5F;
	Mon, 13 Jun 2022 08:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD265C0039;
	Mon, 13 Jun 2022 08:10:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1E70C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8C0EF415CB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NCu7dZlygymB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:10:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F0F340265
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 08:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655107853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o3I59FmykDLK1GNxLZhq5VJ8322YMgbR0Ph4Y1aaHOU=;
 b=OeK1DQ9CYl9tEOEP/Mtqyx9djBXPkQ+NUqevEx7oA91BFHk8aTzz4FpLruu5TJCsCiEfuc
 xdEGV1CEWPG6OOVVIdiDtzIIdMHaQUr5WZ09g7gBAgrhtsBFvcl39KZaX6/urXg79plFWL
 Ngl6ALMDkjxue7hYQkJTew9FcQmVyEc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-1mIPMPEuPiOqj9WSCLo4bQ-1; Mon, 13 Jun 2022 04:10:52 -0400
X-MC-Unique: 1mIPMPEuPiOqj9WSCLo4bQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 m20-20020a2ea594000000b00258f0218017so475646ljp.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o3I59FmykDLK1GNxLZhq5VJ8322YMgbR0Ph4Y1aaHOU=;
 b=f4u+LdKsDyWPN5WyTvhnN/XDRzPl38wDI56w1a8mUSvLxRKnLSlgaRUUvt2g2xgiSa
 tbZU7ucFBXBxArFIb9ZTS3S04yOuECeXHIRByrL5s8CwcDN/R5PJDaIYzCx0BMBMsVwS
 nv3ZK7MBK3LN9QvK32A669ObeaP25h626+kzL+GohVpkMphF8HL2/3C+hOx2wcEI/3HT
 6LW2XH2mta+msgsGW44eyKf2YBFiGpJPY4cIpvCxpoivGTI1rI1oBWmwq61x2y/GgoBQ
 LYdvt3eXLxeqip73o1mRvVJREjXIloSH8CXX6HewHqCft29Z1AT8Id9bVbv/wnisF74P
 dyag==
X-Gm-Message-State: AOAM533SBLVmva6NgsHs1lFWTvjgzwt8zK9evcYNML4fs024HZbXIORm
 NybxltaiJS+h2AlI5NGOaL8Q8YFizCTw9MLM+/6z6JS2bNE+FezA6M23TSEgI+pOOSq4IzCj8X/
 mQVuFiSdF+mGwccm4wOYbnNx8kw1Uaz+hPJWmOXCYSzQDaSDiq6vmKeJsyA==
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id
 m18-20020a194352000000b0047905d13fefmr35944833lfj.411.1655107849672; 
 Mon, 13 Jun 2022 01:10:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXvb0hR2HEZzfJ9SDV+9irQx/3lYtrRjA6yvv01usuhZ8nwVb+Wp5sp88+2Jmm40d9StFVtY2gm5fE/VRhrIo=
X-Received: by 2002:a19:4352:0:b0:479:5d1:3fef with SMTP id
 m18-20020a194352000000b0047905d13fefmr35944781lfj.411.1655107848004; Mon, 13
 Jun 2022 01:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220613075958.511064-1-elic@nvidia.com>
In-Reply-To: <20220613075958.511064-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Jun 2022 16:10:36 +0800
Message-ID: <CACGkMEsxgs4DTs3w0Mtwrn26Cpww=_5VuApCKm=tHrTwDmZ0rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Update Control VQ callback information
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Mon, Jun 13, 2022 at 4:00 PM Eli Cohen <elic@nvidia.com> wrote:
>
> The control VQ specific information is stored in the dedicated struct
> mlx5_control_vq. When the callback is updated through
> mlx5_vdpa_set_vq_cb(), make sure to update the control VQ struct.
>
> Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 1b6d46b86f81..789c078ff1af 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1962,6 +1962,8 @@ static void mlx5_vdpa_set_vq_cb(struct vdpa_device *vdev, u16 idx, struct vdpa_c
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
>
>         ndev->event_cbs[idx] = *cb;
> +       if (is_ctrl_vq_idx(mvdev, idx))
> +               mvdev->cvq.event_cb = *cb;
>  }
>

Acked-by: Jason Wang <jasowang@redhat.com)

In the future, I wonder if we can simply just use event_cbs[] since it
has took cvq into account:

struct vdpa_callback event_cbs[MLX5_MAX_SUPPORTED_VQS + 1];

Thanks

>  static void mlx5_cvq_notify(struct vringh *vring)
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
