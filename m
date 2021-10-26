Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD591C433FE
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:29:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7F460E75
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A7F460E75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 24E3480D8C;
	Tue, 26 Oct 2021 02:29:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xMWsRtUoniWJ; Tue, 26 Oct 2021 02:29:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CA1A480A53;
	Tue, 26 Oct 2021 02:29:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 935E9C0019;
	Tue, 26 Oct 2021 02:29:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A290BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:29:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 82DDF4013D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7O7oxDdJj1wv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:29:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1211E400E1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635215389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bK/ePsOXvnwATuPJ538FYYy/I3va7wErG+x6S0m8LPc=;
 b=Q36tLKepzd3J0S5Q+d4NHzg4le38tLEMEgU1YPTi9fQ8HlkDJ7u1Xo6ZnBoq3sxQMMD3H2
 Gr59T568yDfb1XdolfVGx2Cl2/aDNxNa8NvOv0MH8AUkpcdi1SNc81Y179bEbZM9ZuEiAq
 +PKH5xsk/QiOzscpEJy/vxRjf6S0//E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-BpkurupyOhO3aA2Le3_yvg-1; Mon, 25 Oct 2021 22:29:48 -0400
X-MC-Unique: BpkurupyOhO3aA2Le3_yvg-1
Received: by mail-lj1-f197.google.com with SMTP id
 f6-20020a2e9e86000000b00211349f9ce3so3676600ljk.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 19:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bK/ePsOXvnwATuPJ538FYYy/I3va7wErG+x6S0m8LPc=;
 b=FdRtkGo594GSADJB7vhr9Jy24JHkNT/RcxuDJyJZJt1d7NYkhbxFHYbvNJfLnWuDwO
 F3aW1oyAiRADFvaudO//OCib69OenBA4qFI0OvfcayokJ1Rt5UmKl4AsV1DAu8+b1RkZ
 zNPubLu49Hm49IQsNTNjid99impcQeXyCFtBsWJ/if+wEiNPSdi2MU/pyxP4OylBkisi
 axP9vlU+LkOl0cGDfvFkK6wJZGd2dTV0VCmxrZU0pULZXv1sMdi9qDiUoWR/OFbWORyS
 xrqwjcupM8EGBDLqRNx2TvPAlLBDMkNe58FyDm28d7FzYvpAvCymRTYSxK1WPjPW9pfX
 safA==
X-Gm-Message-State: AOAM533fbQbyr9JGY5qO7+baJ9rFo74Uo2W0OehmTyiu5MIyQ4bwji/9
 RQLsBGTMo/cPeZBWUsvXQsnhUeLuxBuXsQXqRR60OHUkDpKwpn/wKzlu9ICYrOUrsqJLiJFM6VX
 IYIB6Ojrvh5rrHnnFtgIxgUfC/xGqw/H4ncFpF73QFxrPF5ItufFj5v5smA==
X-Received: by 2002:a2e:8846:: with SMTP id z6mr1572334ljj.277.1635215386526; 
 Mon, 25 Oct 2021 19:29:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynH2p5Q/d3q8po75eyLScuoBHurmQzxoMQYZvDuVwpXkiyjRKbg3lG4lyNps31IP9RfRnyLeR+hJ3uxAAQOeI=
X-Received: by 2002:a2e:8846:: with SMTP id z6mr1572308ljj.277.1635215386353; 
 Mon, 25 Oct 2021 19:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20211025102240.22801-1-colin.i.king@gmail.com>
In-Reply-To: <20211025102240.22801-1-colin.i.king@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 10:29:35 +0800
Message-ID: <CACGkMEv2UOaf0phkXYsV=L3fn3BCxXUj-Vx3o1MeYQhvY_B-wg@mail.gmail.com>
Subject: Re: [PATCH][next] virtio_blk: Fix spelling mistake: "advertisted" ->
 "advertised"
To: Colin Ian King <colin.i.king@googlemail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jens Axboe <axboe@kernel.dk>, "Michael S . Tsirkin" <mst@redhat.com>,
 kernel-janitors@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Mon, Oct 25, 2021 at 6:22 PM Colin Ian King
<colin.i.king@googlemail.com> wrote:
>
> There is a spelling mistake in a dev_err error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c336d9bb9105..9dd0099d2bd2 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -560,7 +560,7 @@ static int init_vq(struct virtio_blk *vblk)
>         if (err)
>                 num_vqs = 1;
>         if (!err && !num_vqs) {
> -               dev_err(&vdev->dev, "MQ advertisted but zero queues reported\n");
> +               dev_err(&vdev->dev, "MQ advertised but zero queues reported\n");
>                 return -EINVAL;
>         }
>
> --
> 2.32.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
