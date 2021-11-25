Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A22C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 07:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B1DE682591;
	Thu, 25 Nov 2021 07:22:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hDi7XlTWO_VY; Thu, 25 Nov 2021 07:22:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6569480DB1;
	Thu, 25 Nov 2021 07:22:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1EDCFC002F;
	Thu, 25 Nov 2021 07:22:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E8A8C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C22A80DF9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:22:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0YCZhtI8YLKc
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:22:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E89980DB1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637824968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=34Z1rBc9Z4HMyyKHRKonHY094GFevaktip+aHDsH7EI=;
 b=QS2yjNOmJmi3vA04CAcTdxb1JfdqAT+xGq/GGpOU3eLvht2sVw6o+pBiemrW995ihn6KiR
 lOYOH3md+Y/KZelm3WWdAWjU4hR6wm8A7EgaMp9eYAsxCFTjxllNLph5jgkzT1vZdIsOEq
 N5lwKNGFiK5m5WpoSE388KL6b4n/1wM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-6FFy1ibQN1yCMfKmDpHkuA-1; Thu, 25 Nov 2021 02:22:47 -0500
X-MC-Unique: 6FFy1ibQN1yCMfKmDpHkuA-1
Received: by mail-ed1-f69.google.com with SMTP id
 w4-20020aa7cb44000000b003e7c0f7cfffso4686253edt.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 23:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=34Z1rBc9Z4HMyyKHRKonHY094GFevaktip+aHDsH7EI=;
 b=o92UL8cbDpqt231+J3kSVT/JcNCbXwJGxrzSedINHEAm4TSCKI0lStSvI43RhWiLGR
 dkGIX8c7Wf4eR/SFKbe3BSqLAHmJKb0L7WAjOwvIKNSzJUl8K5mWoe8Rj0a4jCRU1WjI
 Ef7RnO4hWvYqhHfdTrQ81e7qO1FhV7r02niC4Ufu/wGBCZibraz3YvAhTCbk8pmBXukS
 Pq6EFHT+7Y60UrqM+eiSiAOBJEY01Q6TbO+sz+TmXZurvOqAR51f9Qs/N98LZ7PANuEO
 9ru4yCl83hk0LWBTsXHfOBZSFSSrmEA6IrKrjHYX2jDgehD98XRlAeStGF9RVG4psAxg
 kwpw==
X-Gm-Message-State: AOAM531zuXoDi+PmFaDw+7J18NE4ZqAkaTXpmp/FeOpt7xR8CcTIFrb6
 lkKkIRq5nsI23c24vmID08joK+gGhJlALEsAvkgHmIBo643N8VqRjPCoolBogJcFcFSByU0N94x
 4LWIwitHqED6ln02ZSrZUNHyzFV6yQAAwbqmZeI9sbQ==
X-Received: by 2002:a17:906:5653:: with SMTP id
 v19mr28888680ejr.360.1637824966159; 
 Wed, 24 Nov 2021 23:22:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQpX91yK4lsOm8qjodnph1kZ42NTVUq4XKO6Luvyw5PkZARqx9WoYtQBPPotIor6xipF/blA==
X-Received: by 2002:a17:906:5653:: with SMTP id
 v19mr28888665ejr.360.1637824966017; 
 Wed, 24 Nov 2021 23:22:46 -0800 (PST)
Received: from redhat.com ([45.15.18.67])
 by smtp.gmail.com with ESMTPSA id l26sm1278927eda.20.2021.11.24.23.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Nov 2021 23:22:45 -0800 (PST)
Date: Thu, 25 Nov 2021 02:22:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] net/mlx5_vdpa: Increase the limit on the number of
 virtuques
Message-ID: <20211125022223-mutt-send-email-mst@kernel.org>
References: <20211124171953.57858-1-elic@nvidia.com>
 <1b98e4ad-ed83-7410-6381-a973ddc3912a@oracle.com>
 <20211125070126.GB211101@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20211125070126.GB211101@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Thu, Nov 25, 2021 at 09:01:26AM +0200, Eli Cohen wrote:
> On Wed, Nov 24, 2021 at 03:55:34PM -0800, Si-Wei Liu wrote:
> > 
> > 
> > On 11/24/2021 9:19 AM, Eli Cohen wrote:
> > > Increase the limit on the maximum number of supported virtqueues to 256
> > > to match hardware capabilities.
> > > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > > ---
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index ed7a63e48335..8f2918a8efc6 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -135,7 +135,7 @@ struct mlx5_vdpa_virtqueue {
> > >   /* We will remove this limitation once mlx5_vdpa_alloc_resources()
> > >    * provides for driver space allocation
> > >    */
> > > -#define MLX5_MAX_SUPPORTED_VQS 16
> > > +#define MLX5_MAX_SUPPORTED_VQS 256
> > Did we check how much increase of memory footprint ended up with on struct
> > mlx5_vdpa_net?
> > 
> 
> The grow is 1048 * 240 = 251520 bytes.


Pls include this info in the commit log.

> > -Siwei
> > 
> > >   static bool is_index_valid(struct mlx5_vdpa_dev *mvdev, u16 idx)
> > >   {
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
