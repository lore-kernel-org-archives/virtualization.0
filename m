Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E581ECAAD3
	for <virtualization@archiver.kernel.org>; Wed, 14 Sep 2022 04:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4B9F4059E;
	Wed, 14 Sep 2022 04:44:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4B9F4059E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Wk8s75CZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id umu6Bk52NPSC; Wed, 14 Sep 2022 04:44:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10171400E9;
	Wed, 14 Sep 2022 04:44:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10171400E9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1377C0033;
	Wed, 14 Sep 2022 04:44:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22B77C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 04:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E96D9400E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 04:44:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E96D9400E9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wh5lh9rltsS1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 04:44:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06D8D4059E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06D8D4059E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Sep 2022 04:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663130668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0uP/dYDukfABPX5tOREjXIZp/drleC3gX1NDy3hW6L4=;
 b=Wk8s75CZI3gyqtsKJ+1FmRrDdY5sG/v4QjkIENf3rgPEVbfmB1pO1dSbLbnYOJD1h2Qn8P
 q9/m7+0mYAdKQ3VpKJnkRaE5zA+T0Jd9sYGFvMmnplkfCkXytVXAu3SwuwQyBfTgp/jhJ2
 DiTjlrzEVibJip0N41mF3x84AwL3DH8=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-591-RMArXO7QMUKZw4zzbDJ2Uw-1; Wed, 14 Sep 2022 00:44:27 -0400
X-MC-Unique: RMArXO7QMUKZw4zzbDJ2Uw-1
Received: by mail-vk1-f198.google.com with SMTP id
 x3-20020a1f3103000000b003a285826de2so1300175vkx.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Sep 2022 21:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=0uP/dYDukfABPX5tOREjXIZp/drleC3gX1NDy3hW6L4=;
 b=HA/mqt4NyucCg+WjHTvZYpGcq+9wdS/6eK91eDL7O+oPqt6b69luInvcKyxCfxfKDq
 PLrEbZfcisN8EiLzW+BYQoJO21dBoEO2zAEIxyJ1PXpky1oEt1+mO3oZmsvw4/Pu3SYw
 8nt1FDgm4sx1Hx8tqY22ikqeJEBSOSFiyFJyd/aQAIycB52eKuPvgX1cqAghWOlyIor5
 /Y+l7jLaynfUebd6UjD7Zp4dNgcYo8DWU+rjOoF8JIi9WKumRqXXFeJ/8PXd+/C3KP0l
 4x6g9/hnSR7ARZeh/0NFCcPLy/sOdVTFhr0JzwdLt3UhWrb1jgXUQAdjBCYqtk8Ym9uu
 HP0w==
X-Gm-Message-State: ACgBeo09XtSUm6nYy0LH6EA9gA/geRqtRK4emu9+heEEQN7OMRf3unvf
 gyJ1fcHoHXKd5yNkJTHh1jgqzVLxoSUi2gVqyFcct8m3ZniRWaua8d1qF+i3MvA97RZ2Qiz/0Rr
 anYyaFVRbVA6JCzBDKnroGaYAyfdHFmWe6NZVkXNZIGqJi64HzCQrGGMkYA==
X-Received: by 2002:a1f:108:0:b0:3a2:3f56:967b with SMTP id
 8-20020a1f0108000000b003a23f56967bmr4435941vkb.32.1663130665640; 
 Tue, 13 Sep 2022 21:44:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7UhudjBls/ikR/JKeDLGFvRxTVDmrJAnM5qjcacsqhaaksSBrx9zugp57J3hVHXHMLi7JBQ5TWqQsryli5FPk=
X-Received: by 2002:a1f:108:0:b0:3a2:3f56:967b with SMTP id
 8-20020a1f0108000000b003a23f56967bmr4435935vkb.32.1663130665389; Tue, 13 Sep
 2022 21:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220912125019.833708-1-elic@nvidia.com>
In-Reply-To: <20220912125019.833708-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 14 Sep 2022 12:44:14 +0800
Message-ID: <CACGkMEsMm8nfsFNa=B-Zv-fukNex+M8vVoKOfjpr-TxgKXnVhA@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Fix MQ to support non power of two num queues
To: Eli Cohen <elic@nvidia.com>
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

On Mon, Sep 12, 2022 at 8:50 PM Eli Cohen <elic@nvidia.com> wrote:
>
> RQT objects require that a power of two value be configured for both
> rqt_max_size and rqt_actual size.
>
> For create_rqt, make sure to round up to the power of two the value of
> given by the user who created the vdpa device and given by
> ndev->rqt_size. The actual size is also rounded up to the power of two
> using the current number of VQs given by ndev->cur_num_vqs.
>
> Same goes with modify_rqt where we need to make sure act size is power
> of two based on the new number of QPs.
>
> Without this patch, attempt to create a device with non power of two QPs
> would result in error from firmware.
>
> Fixes: 52893733f2c5 ("vdpa/mlx5: Add multiqueue support")
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index ed100a35e596..90913365def4 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1320,6 +1320,8 @@ static void teardown_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *
>
>  static int create_rqt(struct mlx5_vdpa_net *ndev)
>  {
> +       int rqt_table_size = roundup_pow_of_two(ndev->rqt_size);
> +       int act_sz = roundup_pow_of_two(ndev->cur_num_vqs / 2);
>         __be32 *list;
>         void *rqtc;
>         int inlen;
> @@ -1327,7 +1329,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>         int i, j;
>         int err;
>
> -       inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> +       inlen = MLX5_ST_SZ_BYTES(create_rqt_in) + rqt_table_size * MLX5_ST_SZ_BYTES(rq_num);
>         in = kzalloc(inlen, GFP_KERNEL);
>         if (!in)
>                 return -ENOMEM;
> @@ -1336,12 +1338,12 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>         rqtc = MLX5_ADDR_OF(create_rqt_in, in, rqt_context);
>
>         MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
> -       MLX5_SET(rqtc, rqtc, rqt_max_size, ndev->rqt_size);
> +       MLX5_SET(rqtc, rqtc, rqt_max_size, rqt_table_size);
>         list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -       for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> +       for (i = 0, j = 0; i < act_sz; i++, j += 2)
>                 list[i] = cpu_to_be32(ndev->vqs[j % ndev->cur_num_vqs].virtq_id);
>
> -       MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> +       MLX5_SET(rqtc, rqtc, rqt_actual_size, act_sz);
>         err = mlx5_vdpa_create_rqt(&ndev->mvdev, in, inlen, &ndev->res.rqtn);
>         kfree(in);
>         if (err)
> @@ -1354,6 +1356,7 @@ static int create_rqt(struct mlx5_vdpa_net *ndev)
>
>  static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>  {
> +       int act_sz = roundup_pow_of_two(num / 2);
>         __be32 *list;
>         void *rqtc;
>         int inlen;
> @@ -1361,7 +1364,7 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>         int i, j;
>         int err;
>
> -       inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + ndev->rqt_size * MLX5_ST_SZ_BYTES(rq_num);
> +       inlen = MLX5_ST_SZ_BYTES(modify_rqt_in) + act_sz * MLX5_ST_SZ_BYTES(rq_num);
>         in = kzalloc(inlen, GFP_KERNEL);
>         if (!in)
>                 return -ENOMEM;
> @@ -1372,10 +1375,10 @@ static int modify_rqt(struct mlx5_vdpa_net *ndev, int num)
>         MLX5_SET(rqtc, rqtc, list_q_type, MLX5_RQTC_LIST_Q_TYPE_VIRTIO_NET_Q);
>
>         list = MLX5_ADDR_OF(rqtc, rqtc, rq_num[0]);
> -       for (i = 0, j = 0; i < ndev->rqt_size; i++, j += 2)
> +       for (i = 0, j = 0; i < act_sz; i++, j = j + 2)
>                 list[i] = cpu_to_be32(ndev->vqs[j % num].virtq_id);
>
> -       MLX5_SET(rqtc, rqtc, rqt_actual_size, ndev->rqt_size);
> +       MLX5_SET(rqtc, rqtc, rqt_actual_size, act_sz);
>         err = mlx5_vdpa_modify_rqt(&ndev->mvdev, in, inlen, ndev->res.rqtn);
>         kfree(in);
>         if (err)
> --
> 2.35.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
