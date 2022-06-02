Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB5DC433EF
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 07:38:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EB5360B9F;
	Thu,  2 Jun 2022 07:38:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tZsCUUup7FfM; Thu,  2 Jun 2022 07:38:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C683F607CA;
	Thu,  2 Jun 2022 07:38:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71C6CC0039;
	Thu,  2 Jun 2022 07:38:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C96BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6666060B88
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yeFp3dFUilgf
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:38:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B77AA607CA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 07:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654155505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8S6wLquatnItcWZvek3jQW4rbdDmqnYoTMJmalyKWOA=;
 b=f9ohzc5GT8Qq7F+bMZolT9iv6CX5sRzIcHYd5W7J7icN/lH53MNU7Tbz/kiRHwdfdSxzdM
 6ua8ZkEnB2c97t8L+IZVGEXXrvl1L+YH3WV8l9RLxHQdwtrhe1e4kmB0B7su/AwWexlcJu
 MIpxGZHRHAu9n8xiK1f4uqH17LOzpiA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-bvqpUNHLPMO4uCQJJ_9Kkg-1; Thu, 02 Jun 2022 03:38:24 -0400
X-MC-Unique: bvqpUNHLPMO4uCQJJ_9Kkg-1
Received: by mail-lf1-f69.google.com with SMTP id
 y22-20020ac24216000000b00478eb3ffbc9so2154641lfh.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 00:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8S6wLquatnItcWZvek3jQW4rbdDmqnYoTMJmalyKWOA=;
 b=nP8fWdZySFQCbaKXtBRgrkOZbkSqut+Vn7QInrwSVL2mNqP6cd39j2A+zCMjExNU4x
 xiOEX/ny1HY9yD2ZEwcevaV0U29bzKlZ72LkqeuHVs5fwMmAdsbp6WUnUrRLDDMVxWDI
 fg+jHPW0x4PXVXlTRkIsvEjGV7ddDOaEET0XpChGJqmqotU7rzmvmzB7rDjS9gY18q1z
 EFmvJL9wF4o0MFWBXqU69XT03Dk/IcJUAByg4n/VaXRVIzmNl9KGYGxTq4EdRHsZFkVc
 Pzk4HTqacDju0lioSgubKEpsX26TF2BgqmF98w9pMxEDtEn0KfPk+RdLq2EJGRdp7Pm3
 J74g==
X-Gm-Message-State: AOAM530MD34XFxgTO3t9SJVM8xtbFn9Q1Q+WIT/5xF0QJ6onKcsB9aEL
 vRN5gvRD53KVCncKxyomYTy3DDwAYR7ZXRNoj8XWhkkQfHQ8XqZ3R4ydyxj8aRijyNFgx2eKqwR
 3U/lWa+8Vh7s7zIn9qqwjKZ2QyTLjVouRE3xug7kBWv2PXgwO6ZVTPq4ZTg==
X-Received: by 2002:a05:6512:39d2:b0:478:5ad6:1989 with SMTP id
 k18-20020a05651239d200b004785ad61989mr2530130lfu.98.1654155503032; 
 Thu, 02 Jun 2022 00:38:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3O4k++MCpHtSuiX0ROlBjtZNZwtRKVz3FtxIFV/35s1PaTj2JIOrFkGUSJoEUttxJ7HDNqg4mOwQC1G1H/kg=
X-Received: by 2002:a05:6512:39d2:b0:478:5ad6:1989 with SMTP id
 k18-20020a05651239d200b004785ad61989mr2530120lfu.98.1654155502840; Thu, 02
 Jun 2022 00:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220602023845.2596397-1-lingshan.zhu@intel.com>
 <20220602023845.2596397-6-lingshan.zhu@intel.com>
In-Reply-To: <20220602023845.2596397-6-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 15:38:11 +0800
Message-ID: <CACGkMEtCKT5ib_+gUdryDXfxntTr_JF7fZpeePZ+=BFjY_TG+w@mail.gmail.com>
Subject: Re: [PATCH 5/6] vDPA: answer num of queue pairs = 1 to userspace when
 VIRTIO_NET_F_MQ == 0
To: Zhu Lingshan <lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: netdev <netdev@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

On Thu, Jun 2, 2022 at 10:48 AM Zhu Lingshan <lingshan.zhu@intel.com> wrote:
>
> If VIRTIO_NET_F_MQ == 0, the virtio device should have one queue pair,
> so when userspace querying queue pair numbers, it should return mq=1
> than zero

Spec said:

"max_virtqueue_pairs only exists if VIRTIO_NET_F_MQ is set"

So we are probably fine.

Thanks

>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  drivers/vdpa/vdpa.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 030d96bdeed2..50a11ece603e 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -818,9 +818,10 @@ static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
>         u16 val_u16;
>
>         if ((features & BIT_ULL(VIRTIO_NET_F_MQ)) == 0)
> -               return 0;
> +               val_u16 = 1;
> +       else
> +               val_u16 = le16_to_cpu((__force __le16)config->max_virtqueue_pairs);
>
> -       val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
>         return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
>  }
>
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
