Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225EEC433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 02:25:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 94DF740186;
	Fri,  7 Jan 2022 02:25:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GqD5aD8wMr5a; Fri,  7 Jan 2022 02:25:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED46F400E5;
	Fri,  7 Jan 2022 02:25:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0FC9C0030;
	Fri,  7 Jan 2022 02:25:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90059C001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:25:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 839DD42982
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:25:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LznZxZtrHtUz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:25:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E59042976
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 02:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641522304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NdLI+JY15a2+Gt1cY6WpfausBPRh25LVXAMJd9mKg3c=;
 b=icoUFjVhcpBGrEIANTqun+Od2tvnv1vfyF/xZyli/IBbgC0+9SvwsHx0RVIP2UhYAsc9dC
 WsDU8vIz2E2rtg1qBZj56rPnyU+btdWZlY2sO8pltjr2zlYghpfPWgoXnybFf3dOUHMKyk
 oP4J4Ph4ZH7Koh55OrVRDRNEdLW70h0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-Rtn_P55qMNSDFTn_AzYg2g-1; Thu, 06 Jan 2022 21:25:03 -0500
X-MC-Unique: Rtn_P55qMNSDFTn_AzYg2g-1
Received: by mail-lf1-f71.google.com with SMTP id
 h7-20020ac24da7000000b0042521f16f1fso1305772lfe.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Jan 2022 18:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NdLI+JY15a2+Gt1cY6WpfausBPRh25LVXAMJd9mKg3c=;
 b=Fd78l8nHC8u84NjFUS44tf2eQv8Jyg/iduWKO1LixRx5szCUsMcUUaitjbFZtZjVvV
 Knq/mktNUCAdsU3eC61GAdCFWRxUSdrURAkMSmmAIk/PJxRjdoZXJoA0Auuqx6wlgSJi
 5HuwD6QjkiS5PG+jpBkVdQfUi8hXrAmhEk4zuiybjPK9jdLKJ5G4cREejSk/stoCrSO1
 fw0JTelfFlKHT3dazyQu9fTnrwGVkBBp7e+fW9qQNMfTdkrd77ou8M6hhJh3pZEqFGc6
 wlJyxak6v2NgtFDOOB53aeQEWeVN0iLB2TbfRaw6+kFcoO/O1YGT6MTk/dGYyyezqedu
 Im7g==
X-Gm-Message-State: AOAM530d1h1t5lh6OTj9JbUXd/90QO/T+4oH+m84GmQTUvHDjKoX4PHk
 1xEt1uowgM1+E4dL5NEu3WDeFEZmpYGQHCHlo9D5TTNRmVTMpPqiWvymFvmeTFUwW/SMuamu2Ms
 svkNvo9Rrd46ihnkME5eiFetVHnvoybLCDkJ8C4Wu1cUIU9KTBurg5OVMFA==
X-Received: by 2002:a2e:8543:: with SMTP id u3mr45052779ljj.307.1641522301427; 
 Thu, 06 Jan 2022 18:25:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQdgl8Lhz6/KjVCb1IwvdC/dDvHzQIuoVfmyd1mtC2fcVs0Fp2KcMCv0CRdLYPdrAELdSHWNAe70sNvp+Z5sg=
X-Received: by 2002:a2e:8543:: with SMTP id u3mr45052762ljj.307.1641522301235; 
 Thu, 06 Jan 2022 18:25:01 -0800 (PST)
MIME-Version: 1.0
References: <20220106130046.422417-1-mst@redhat.com>
In-Reply-To: <20220106130046.422417-1-mst@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 7 Jan 2022 10:24:50 +0800
Message-ID: <CACGkMEtitniJqz0gMp4YY=sf_Nb0v8Z-xXyF9P_rh=+58Sn6Yg@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: mark ring unused on error
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Jan 6, 2022 at 9:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> A recently added error path does not mark ring unused when exiting on
> OOM, which will lead to BUG on the next entry in debug builds.
>
> TODO: refactor code so we have START_USE and END_USE in the same function.
>
> Fixes: fc6d70f40b3d ("virtio_ring: check desc == NULL when using indirect with packed")
> Cc: "Xuan Zhuo" <xuanzhuo@linux.alibaba.com>
> Cc: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/virtio/virtio_ring.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 028b05d44546..962f1477b1fa 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1197,8 +1197,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>         if (virtqueue_use_indirect(_vq, total_sg)) {
>                 err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
>                                                     in_sgs, data, gfp);
> -               if (err != -ENOMEM)
> +               if (err != -ENOMEM) {
> +                       END_USE(vq);
>                         return err;
> +               }
>
>                 /* fall back on direct */
>         }
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
