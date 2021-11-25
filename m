Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405F8C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 04:58:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D41B840148;
	Thu, 25 Nov 2021 04:58:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9Zq34wI6OZz; Thu, 25 Nov 2021 04:58:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 896DD40137;
	Thu, 25 Nov 2021 04:58:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68630C0038;
	Thu, 25 Nov 2021 04:58:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0981DC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:58:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E31494019B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:58:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mbESNK7ksps7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:58:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9365E40018
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637816287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wD/Csusyg+qgnaaQtpUZmnyaw7Q9TS9WMBjGvlmLROM=;
 b=Ex0y4S1vTK68gqNIP7jHV1d9l3zYqtJqlWPshvesIN/Fp8LUw9du/12OghcrT4Br7ied6I
 HSyQTYNCuCVb2C8WhydTidhdKiDrJYBMzL9pSi8kY7rWN7lWqhb59S0i/u9m/sPn0XoWT2
 09FxTSP9Cyzvt5/8NlOPnZsNJ8Lx7No=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-9IcLZT98PHOhIB5AWBUxzA-1; Wed, 24 Nov 2021 23:58:06 -0500
X-MC-Unique: 9IcLZT98PHOhIB5AWBUxzA-1
Received: by mail-lj1-f199.google.com with SMTP id
 d20-20020a05651c111400b00218c6372b7eso1511356ljo.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 20:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wD/Csusyg+qgnaaQtpUZmnyaw7Q9TS9WMBjGvlmLROM=;
 b=hf40rqM1edK26cnicwZa/QwrFTyGthIbufbYCIpEpn+b4RPuAAyNEIL5bcd9mD0T5R
 BUNp4BqvThSRgCVZcnisZiIbn1+R3aRzDmcoKGiJLBtJk90dACwNYypwJDu1gMP3bHNl
 2eX0SpZ8Ert0rdKvQniQrJnVtxZ8NNgj5g5o7/r95J1yuulX7xWZ9XQxEotIQjNxki8l
 5cSmdVF6zt/5By8bM39Ah4WwaW5YQEiIHjPADweoM/muX6WKk8Y/gwRJm1V/7LTJUECI
 aD+LZft9YALduMvMXdU/GzpHTIDofENu+uhlIh2F1foCSDnVQDAmRAblw9UM0SMmS/Ie
 0I1A==
X-Gm-Message-State: AOAM530Tkzb46PFph4xB79n+95izNxG6S66keVWVDOH6VTj4yIpuOLZZ
 WV6ht+QNXwqz3jjCom0W9GNQC8zopnWpqppjEc2ZUmlzQ71unoHx/n7FwkigT5xIY7GWn7Na8Jb
 hTqOAOrEbDiv0Z91vYfhXoNvvCulYjPXcW9s7RQE91ViFhkp5aUse+g6hqA==
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr21768517ljp.362.1637816284659; 
 Wed, 24 Nov 2021 20:58:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyS11lzpvV9AY5HWECbZf+1K8F6aEnjgaBNlGd4bcNLP6wJkdBzKAITe4J7Tuv2pwiw+SepynwftFgn0WII09E=
X-Received: by 2002:a2e:b88d:: with SMTP id r13mr21768502ljp.362.1637816284472; 
 Wed, 24 Nov 2021 20:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20211124165531.42624-1-elic@nvidia.com>
 <20211124165531.42624-3-elic@nvidia.com>
In-Reply-To: <20211124165531.42624-3-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 12:57:53 +0800
Message-ID: <CACGkMEtzoTaXKtNB9+53FboD9XC=O77pDeiGq6ZCbZkXuBZi5Q@mail.gmail.com>
Subject: Re: [PATH v1 2/2] vdpa/mlx5: Add support for reading descriptor
 statistics
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, si-wei.liu@oracle.com
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

On Thu, Nov 25, 2021 at 12:56 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Implement the get_vq_stats calback of vdpa_config_ops to return the
> statistics for a virtqueue.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> V0 -> V1:
> Use mutex to sync stats query with change of number of queues
>

[...]

> +static int mlx5_get_vq_stats(struct vdpa_device *vdev, u16 *idx,
> +                            struct vdpa_vq_stats *stats)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +       struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> +       struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[*idx];
> +       struct mlx5_control_vq *cvq;
> +       int err;
> +
> +       mutex_lock(&ndev->numq_lock);
> +       if ((!ctrl_vq_active(mvdev) && *idx >= ndev->cur_num_vqs) ||
> +           (*idx != ctrl_vq_idx(mvdev) && *idx >= ndev->cur_num_vqs)) {
> +               err = -EINVAL;
> +               goto out;

Interesting, I wonder if it's simpler that we just allow stats up to
the max vqs. It's sometimes useful to dump the stats of all the vqs so
we can let that policy to userspace. Then we can get rid of the mutex.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
