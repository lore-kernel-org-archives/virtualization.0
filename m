Return-Path: <SRS0=ROIW=NA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A4FC4338F
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:50:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E9F6023B
	for <virtualization@archiver.kernel.org>; Mon,  9 Aug 2021 09:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1E9F6023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 84BD140199;
	Mon,  9 Aug 2021 09:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tgQIExUOb021; Mon,  9 Aug 2021 09:50:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2A33B40166;
	Mon,  9 Aug 2021 09:50:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B27EC001A;
	Mon,  9 Aug 2021 09:50:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CB1CC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4C0D960718
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:50:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eu1qBCeBwM0O
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:50:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C65F6060C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Aug 2021 09:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628502609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PkX+2tTogIs6tvQdnsgqG+XxwOeFR9L2WRK+61WURRg=;
 b=TiSUVsCnSLkDfjnKYUpQX/3tM0HGsj3KGwlvI55oS9fM/APiJaPAN4zuMKPc5x8pkJGCrE
 x25tHshr40AFB0Cam4eDwFHRscEFO8+sahf7X1YI1YHxgW9gZws32CqbOtzzHrsXMH6+cA
 /VIPnznnxUykNfWhAuxxZS+AmT+nBsw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-F1A5JuPhOzCxc3gp-ezQtw-1; Mon, 09 Aug 2021 05:50:07 -0400
X-MC-Unique: F1A5JuPhOzCxc3gp-ezQtw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a19-20020a1709063e93b0290551ea218ea2so907305ejj.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 02:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PkX+2tTogIs6tvQdnsgqG+XxwOeFR9L2WRK+61WURRg=;
 b=no8Wro7SOvJSBH2u0iF7e2YTOFgooBnq402M8f58+OOQ0D604novpMJvEcH9a4HYYf
 aE1QwYL+Pt1bo3Bs5qho2W0qXXlQTjZ0JJ+rMLnYn9Ka3s662Z5c9LPZm0fOJdkUHhnj
 pXeC1VIkWoZfuwp9DIT5kGshzhc60oZdlyaIglHYyZy7SDQjanJ9U8IX7k7LpK1HaqGS
 bk9aKFr/ZK9xDpg4FcvjZgSfELFfwv/AHxEXw1OE5fS3D6uCKSZ3DoDf6lF47iQeyOeu
 kS50HLOtC3YcBfwqbLwtbvWFQCYFUt5ih2szSt4Sl+If8FXfwOTXzGnqQPMli1Lbdm2F
 H8cQ==
X-Gm-Message-State: AOAM533lz4GdpsvSxuxGJPUU8zHH2YLsc/Cn//mXL9xo+/9jdB2tcRk5
 79cQN37qDf5MLwLEcfAQtS719rafnw5apaZgvKCTXty5gt5pxneNfyhGuMz8XJ7tB5qW2ETHl1y
 zv97MU4RGxCYhDhdqiJYOwEBq34LqvRJDF1MKnSNs8Q==
X-Received: by 2002:aa7:db94:: with SMTP id u20mr28554640edt.381.1628502606788; 
 Mon, 09 Aug 2021 02:50:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNGOe0GZ0TOB8GNUtzbzeq16znrU0pPlxVGE8W/oFDSUwSOfFJAmkQokx9HNj5lGLbn1zNAg==
X-Received: by 2002:aa7:db94:: with SMTP id u20mr28554625edt.381.1628502606644; 
 Mon, 09 Aug 2021 02:50:06 -0700 (PDT)
Received: from redhat.com ([2.55.145.148])
 by smtp.gmail.com with ESMTPSA id n16sm125052edv.73.2021.08.09.02.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Aug 2021 02:50:06 -0700 (PDT)
Date: Mon, 9 Aug 2021 05:50:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 0/3] vdpa/mlx5: Add Control VQ and MAC and Multi queue
 support
Message-ID: <20210809054908-mutt-send-email-mst@kernel.org>
References: <20210809080043.169701-1-elic@nvidia.com>
 <20210809053528-mutt-send-email-mst@kernel.org>
 <20210809094803.GA217441@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210809094803.GA217441@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org
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

On Mon, Aug 09, 2021 at 12:48:03PM +0300, Eli Cohen wrote:
> On Mon, Aug 09, 2021 at 05:35:49AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 09, 2021 at 11:00:40AM +0300, Eli Cohen wrote:
> > > Hi Michael,
> > > 
> > > First patch is just a cleaup.
> > > Second patch adds control virtqueue support for mlx5_vdpa and handle MAC
> > > configutations through the control VQ.
> > > Third patch adds multi queue support for mlx5_vdpa accepting
> > > configurations from the control VQ.
> > 
> > Threading broken again :(
> 
> My mail client failed after sending the first two patches so I sent the
> other two as distinct emails. I assume it is realted but how can you see
> that threading is broken?

Patches 2 and 3 do not have In-Reply-To or References headers.

Patch 1 does:

In-Reply-To: <20210809080043.169701-1-elic@nvidia.com>
References: <20210809080043.169701-1-elic@nvidia.com>

One way to fix the setup is using git-send-email.



> > 
> > > Eli Cohen (3):
> > >   vdpa/mlx5: Remove redundant header file inclusion
> > >   vdpa/mlx5: Add support for control VQ and MAC setting
> > >   vdpa/mlx5: Add multiqueue support
> > > 
> > >  drivers/vdpa/mlx5/core/mlx5_vdpa.h |  25 +-
> > >  drivers/vdpa/mlx5/core/mr.c        |  87 ++++--
> > >  drivers/vdpa/mlx5/core/resources.c |  41 +++
> > >  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 471 +++++++++++++++++++++++++----
> > >  4 files changed, 549 insertions(+), 75 deletions(-)
> > > 
> > > -- 
> > > 2.31.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
