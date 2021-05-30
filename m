Return-Path: <SRS0=Dilt=KZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D550C47092
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:37:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1DB2610FC
	for <virtualization@archiver.kernel.org>; Sun, 30 May 2021 08:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DB2610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B31DF403D8;
	Sun, 30 May 2021 08:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id enm5NMjH4TM0; Sun, 30 May 2021 08:37:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1B045403C4;
	Sun, 30 May 2021 08:37:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5B4CC000D;
	Sun, 30 May 2021 08:37:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E977FC0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D7970403C6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6_-4ZVBKJ04I
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:37:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC600403C4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622363826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQkEWOyD2gUPYpz6u2yU+abakR+lg4Bi7q8CPHtEjSY=;
 b=YOskvroJSJARnduet9Hp8Z+EsmwubshfM4WJVWHClXdDLDt1+leqv2XBKEEqW2nW+ylgg5
 ZmghhMW8+up7w6MdswV+ZZ3WIMNoilGUl/oD0x3RSAeBEiLY/zMmGGwzFqJcHrQ8BNlcf4
 Eu7nwc0fLBROAoYj7Lh0YXtmckKuRvE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-PvW8DU4WORGdQ_SSjolDVA-1; Sun, 30 May 2021 04:37:04 -0400
X-MC-Unique: PvW8DU4WORGdQ_SSjolDVA-1
Received: by mail-wm1-f71.google.com with SMTP id
 n127-20020a1c27850000b02901717a27c785so3476690wmn.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 May 2021 01:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IQkEWOyD2gUPYpz6u2yU+abakR+lg4Bi7q8CPHtEjSY=;
 b=DY2VuJ5PmS/sC8J5izEgHaHA8TaRNQ/v6sCVa9kI+abtfZmPoh19rAjL43A6mTdf94
 QEq+ge+yc0bRjztnqSwgchjiCOPT6k5KZR6PEQIhUlJMqHydSyap6iYlE52uRDk5kwX3
 Jd73wMz2vZq9y8u5efv18Q3w1BcYPCuC66lMKY41BUfN+YITeGz0nPKsgsfgySKvQnzR
 kuDgnyelIREnB3b6aSldfSSspPcuEi5iYAjPgxCb2TChwbdNjh2pI1Oh8RAfc5tqHEK6
 4vQJY2dIEIxQ48GzOpY1fH2T5W9l1XNevYSa1+o2KjFiDwG0ud19dOvMarnPdjTSQZB3
 9bDw==
X-Gm-Message-State: AOAM531ym4fiIWFWi+6+Z1D5AeMq8Sv5lOlRMCBH/lbIsa+f6LlqHkJD
 Hdv56yR8iL1/jePEaBfeyHmiNZpQmoG+Gr5UzC29EAsvMkxVGQZm4ZprdUnYRgLrVrKqjbKRn+q
 tNZBRouWOyogtjpXIYZ1pMo+qXJ/ryiYkAo6puZWbhw==
X-Received: by 2002:a05:600c:3586:: with SMTP id
 p6mr21318794wmq.48.1622363823611; 
 Sun, 30 May 2021 01:37:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQuGYN7KsWAuWSTpviYAWENL+DHUSH/CxEH7tJEOWJ8LpEljHIYJ9S98xmXuElv9d6z5Ma4g==
X-Received: by 2002:a05:600c:3586:: with SMTP id
 p6mr21318782wmq.48.1622363823451; 
 Sun, 30 May 2021 01:37:03 -0700 (PDT)
Received: from redhat.com ([2a00:a040:196:94e6::1002])
 by smtp.gmail.com with ESMTPSA id z188sm11865697wme.38.2021.05.30.01.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 May 2021 01:37:02 -0700 (PDT)
Date: Sun, 30 May 2021 04:36:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Fix possible failure in umem size
 calculation
Message-ID: <20210530043634-mutt-send-email-mst@kernel.org>
References: <20210530063214.183335-1-elic@nvidia.com>
 <20210530040523-mutt-send-email-mst@kernel.org>
 <20210530081721.GB119906@mtl-vdi-166.wap.labs.mlnx>
 <20210530042055-mutt-send-email-mst@kernel.org>
 <20210530082748.GB120333@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210530082748.GB120333@mtl-vdi-166.wap.labs.mlnx>
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

On Sun, May 30, 2021 at 11:27:48AM +0300, Eli Cohen wrote:
> On Sun, May 30, 2021 at 04:21:07AM -0400, Michael S. Tsirkin wrote:
> > On Sun, May 30, 2021 at 11:17:21AM +0300, Eli Cohen wrote:
> > > On Sun, May 30, 2021 at 04:05:57AM -0400, Michael S. Tsirkin wrote:
> > > > On Sun, May 30, 2021 at 09:32:14AM +0300, Eli Cohen wrote:
> > > > > umem size is a 32 bit unsigned value so assigning it to an int could
> > > > > cause false failures. Set the calculated value inside the function and
> > > > > modify function name to reflect the fact it updates the size.
> > > > > 
> > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > 
> > > > could you clarify the impact of the bug please?
> > > > 
> > > 
> > > This was found by code revew. I did not see it causing trouble becuase
> > > umem sizes are small enough to fit in int. Nevertheless it's a bug that
> > > deserves a fix.
> > 
> > ok pls include this info in the commit log.
> > 
> 
> Not sure what info do you want me to include. Seems to me that the
> changelog already provides the required information.


that this was found by code review and has no practical impact.

> > > > 
> > > > > ---
> > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
> > > > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 53312f0460ad..fdf3e74bffbd 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
> > > > >  	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
> > > > >  }
> > > > >  
> > > > > -static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > > > -		     struct mlx5_vdpa_umem **umemp)
> > > > > +static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > > > +			  struct mlx5_vdpa_umem **umemp)
> > > > >  {
> > > > >  	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
> > > > >  	int p_a;
> > > > > @@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
> > > > >  		*umemp = &mvq->umem3;
> > > > >  		break;
> > > > >  	}
> > > > > -	return p_a * mvq->num_ent + p_b;
> > > > > +	(*umemp)->size = p_a * mvq->num_ent + p_b;
> > > > >  }
> > > > >  
> > > > >  static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
> > > > > @@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
> > > > >  	void *in;
> > > > >  	int err;
> > > > >  	__be64 *pas;
> > > > > -	int size;
> > > > >  	struct mlx5_vdpa_umem *umem;
> > > > >  
> > > > > -	size = umem_size(ndev, mvq, num, &umem);
> > > > > -	if (size < 0)
> > > > > -		return size;
> > > > > -
> > > > > -	umem->size = size;
> > > > > -	err = umem_frag_buf_alloc(ndev, umem, size);
> > > > > +	set_umem_size(ndev, mvq, num, &umem);
> > > > > +	err = umem_frag_buf_alloc(ndev, umem, umem->size);
> > > > >  	if (err)
> > > > >  		return err;
> > > > >  
> > > > > -- 
> > > > > 2.31.1
> > > > 
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
