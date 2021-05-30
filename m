Return-Path: <SRS0=Dilt=KZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D44C47089
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:19:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 618F7610CC
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 618F7610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EEF083B0E;
	Sun, 30 May 2021 08:19:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6TBCeBISEKGA; Sun, 30 May 2021 08:19:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id C781883AE9;
	Sun, 30 May 2021 08:19:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A1D0C000E;
	Sun, 30 May 2021 08:19:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70C4DC0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:19:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E9B54026D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:19:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TfLCvI0rtOwz
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:19:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 637FC40252
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622362748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZrzgekDde8XcJc+H0wAf58TmREEJyXT/86BNmij9h/4=;
 b=itUNNhgBSg2msHcp2Pko0ofSgXhrLKvXx9A5dPkkILdQfixgOJY7G247TNeGjYNAV1ERAI
 2ZOWTHdh1Sel4zb6ErFlAb6tvSzjGBfiueOHCIQ3YECfksKdtwG7mTAS0ad3BiYuAYn2Sv
 U8Ft1IVIKA+xlQ0hgIWjLkV1Q07IACg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-YjBGjDxdNpeoqKlsRFIoOg-1; Sun, 30 May 2021 04:19:06 -0400
X-MC-Unique: YjBGjDxdNpeoqKlsRFIoOg-1
Received: by mail-wm1-f69.google.com with SMTP id
 o126-20020a1c28840000b0290149b8f27c99so1815491wmo.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 01:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZrzgekDde8XcJc+H0wAf58TmREEJyXT/86BNmij9h/4=;
 b=LifVGiwploGSEf1CXgouSVfPzIkyT4VWwPpjNwVa5b5RkZhPYUExw1Bu8BJgv0u+u4
 EINtmj/zziAy/7n2eGOMKsJEei5t0mCQsSTVN5VtXdPT1kWQyenBzQP0zarZ6IyIookv
 jlbgtmCh7pWNgzNzWvRiO3xcYf/hAzR5ukOm/iOHl1RA4BLwYYLzXyttwv84sLvPnpei
 E2zMYTvUrTDITY1keNVY5vSufzYjbmeqNCPpgMDgm3uS7Dd5uVsDyJHnyEXagb/BrlR5
 tR2simynofHRnlCduJDOYILjDKNftHBHd5S0OhtR6NvoONc0iSvt1N0ZRiv0rZcDAFSC
 Mjaw==
X-Gm-Message-State: AOAM533YKTjSKxwVIIk+U6glf+QXNcLbWAgVbnd/gH7EBDFnZUchwSZM
 qFOA+bsnUCb6DH5vy2jRLEpLuaSHFjuQXzMlMgX2qR23jhg6akG62+ewChkbEmuaFhc+adNIJ65
 +z0LiqgCDlD8Xu8dEG7z6I6t6m+OGzoEa/vv7gVXgLA==
X-Received: by 2002:a1c:dcd7:: with SMTP id t206mr9401687wmg.121.1622362745454; 
 Sun, 30 May 2021 01:19:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxo/+Q9bh+z1Aiin4d0Fw94QcO8hSBoWoep74qVKoB+neJICUbCA6nlY1jCh4ZBOhBQIJJUUA==
X-Received: by 2002:a1c:dcd7:: with SMTP id t206mr9401672wmg.121.1622362745203; 
 Sun, 30 May 2021 01:19:05 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
 by smtp.gmail.com with ESMTPSA id n20sm11262618wmk.12.2021.05.30.01.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 May 2021 01:19:04 -0700 (PDT)
Date: Sun, 30 May 2021 04:19:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530041624-mutt-send-email-mst@kernel.org>
References: <20210530063128.183258-1-elic@nvidia.com>
 <20210530040458-mutt-send-email-mst@kernel.org>
 <20210530081536.GA119906@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210530081536.GA119906@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sun, May 30, 2021 at 11:15:36AM +0300, Eli Cohen wrote:
> On Sun, May 30, 2021 at 04:05:16AM -0400, Michael S. Tsirkin wrote:
> > On Sun, May 30, 2021 at 09:31:28AM +0300, Eli Cohen wrote:
> > > Fix copy paste bug assigning umem1 size to umem2 and umem3.
> > > 
> > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > 
> > could you clarify the impact of the bug please?
> > 
> 
> I leads to firmware failure to create the virtqueue resource when you
> try to use a 1:1 mapping MR. This kind of usage is presented in the
> virtio_vdpa support I sent earlier.

OK pls include this info in the commit log. And is 1:1 the only case where
sizes differ? Is it true that in other cases sizes are all the same?

> > > ---
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 189e4385df40..53312f0460ad 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
> > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> > >  	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> > > -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> > > +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
> > >  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> > > -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> > > +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> > >  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> > >  	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
> > >  		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> > > -- 
> > > 2.31.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
