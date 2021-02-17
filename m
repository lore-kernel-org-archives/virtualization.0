Return-Path: <SRS0=bBcF=HT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AFAC433DB
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 21:20:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660A464E4B
	for <virtualization@archiver.kernel.org>; Wed, 17 Feb 2021 21:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660A464E4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0E13A86FB2;
	Wed, 17 Feb 2021 21:20:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HXohS9+PbX0q; Wed, 17 Feb 2021 21:20:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 607A186F8C;
	Wed, 17 Feb 2021 21:20:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 33EE4C000E;
	Wed, 17 Feb 2021 21:20:26 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 261CAC000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 21:20:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 18FBC86F8C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 21:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pKhNWlgMg6sZ
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 21:20:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8E5C086F72
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613596822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dnUfiwdq5gxWn7kuZ9KofRt51rZIFhafBYYbLyCXkSs=;
 b=UT93BHdrPxnfeckh/XeGI+uoU3PW0GDgxYURuj8tbxSfCUQsX6KTz+zLzyf7edt9LB0EZa
 E05XDDma8Sws6+XwzedYGii7s7RlA+mYsQ/AWJ/fIL9Z/A3ZCuZD/S7PskWXBiO+UiPRBk
 b47yxhgVQPRHS/J79nfVP1zz0foHGKI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-SqcfX6cTNi-1pd1PstsxwA-1; Wed, 17 Feb 2021 16:20:20 -0500
X-MC-Unique: SqcfX6cTNi-1pd1PstsxwA-1
Received: by mail-ed1-f72.google.com with SMTP id q2so11168333edt.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Feb 2021 13:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dnUfiwdq5gxWn7kuZ9KofRt51rZIFhafBYYbLyCXkSs=;
 b=NWbrNHedCQwGyzlkbYXflF15M3XN2czwJfUNjRRC1WTmL70XldAsEdv0V7jRL/6bkA
 wgXfa3HPg4CQqwETl41UGeiOJVJjFZLCMZBYOUqp+8L7jrhnG6ogwI/oRRC8zbJ97VqA
 +zarQXtUtN6PnGTHxLNOtVYDqqMV4QePM+l4YWqbqg6bIWGrhytoaW3u2SxoV5EKzqrz
 ONZoUxCPnwlz8nG+L3xu0wShUTBOYKqCusA8kKk6EiP9oWySeVrYybWRfj8x+AgeQQBh
 koezFxa59Lmh4l50LHRcVvnXLh79JulS1xT+A8ylBfuSNwTrwGNOBOP1kr3Bc2S/CYAk
 ArkQ==
X-Gm-Message-State: AOAM531T9XEJPGLgccNvxZBM+obpfSXZtuFjpgIk4yRb/N1LZPZrkc0Z
 mX1hscpbLy67swZ/EzYgdBjOECdiWBw6howCI/0e+2uwPt8Cnm+SFeecSqEN+++AplaroKzDxsR
 jcrg+I46BFhGya3xBAw5kdkRSI5BGhWuiEVIZK6y18w==
X-Received: by 2002:aa7:d68d:: with SMTP id d13mr728750edr.291.1613596819517; 
 Wed, 17 Feb 2021 13:20:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLOH8aMmh5snYzz9S7cR4u4nYqA6EuVxyyVAfvIIkVTeOvC+C0pe7pnz/oSv3yn+vdF7N9Jg==
X-Received: by 2002:aa7:d68d:: with SMTP id d13mr728678edr.291.1613596818439; 
 Wed, 17 Feb 2021 13:20:18 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id x25sm1651338edv.65.2021.02.17.13.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Feb 2021 13:20:17 -0800 (PST)
Date: Wed, 17 Feb 2021 16:20:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix suspend/resume index restoration
Message-ID: <20210217161858-mutt-send-email-mst@kernel.org>
References: <20210216162001.83541-1-elic@nvidia.com>
 <4ecc1c7f-4f5a-68be-6734-e18dfeb91437@oracle.com>
MIME-Version: 1.0
In-Reply-To: <4ecc1c7f-4f5a-68be-6734-e18dfeb91437@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Wed, Feb 17, 2021 at 11:42:48AM -0800, Si-Wei Liu wrote:
> 
> 
> On 2/16/2021 8:20 AM, Eli Cohen wrote:
> > When we suspend the VM, the VDPA interface will be reset. When the VM is
> > resumed again, clear_virtqueues() will clear the available and used
> > indices resulting in hardware virqtqueue objects becoming out of sync.
> > We can avoid this function alltogether since qemu will clear them if
> > required, e.g. when the VM went through a reboot.
> > 
> > Moreover, since the hw available and used indices should always be
> > identical on query and should be restored to the same value same value
> > for virtqueues that complete in order, we set the single value provided
> > by set_vq_state(). In get_vq_state() we return the value of hardware
> > used index.
> > 
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> Acked-by: Si-Wei Liu <si-wei.liu@oracle.com>


Seems to also fix b35ccebe3ef76168aa2edaa35809c0232cb3578e, right?


> > ---
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c | 17 ++++-------------
> >   1 file changed, 4 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index b8e9d525d66c..a51b0f86afe2 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1169,6 +1169,7 @@ static void suspend_vq(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
> >   		return;
> >   	}
> >   	mvq->avail_idx = attr.available_index;
> > +	mvq->used_idx = attr.used_index;
> >   }
> >   static void suspend_vqs(struct mlx5_vdpa_net *ndev)
> > @@ -1426,6 +1427,7 @@ static int mlx5_vdpa_set_vq_state(struct vdpa_device *vdev, u16 idx,
> >   		return -EINVAL;
> >   	}
> > +	mvq->used_idx = state->avail_index;
> >   	mvq->avail_idx = state->avail_index;
> >   	return 0;
> >   }
> > @@ -1443,7 +1445,7 @@ static int mlx5_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa
> >   	 * that cares about emulating the index after vq is stopped.
> >   	 */
> >   	if (!mvq->initialized) {
> > -		state->avail_index = mvq->avail_idx;
> > +		state->avail_index = mvq->used_idx;
> >   		return 0;
> >   	}
> > @@ -1452,7 +1454,7 @@ static int mlx5_vdpa_get_vq_state(struct vdpa_device *vdev, u16 idx, struct vdpa
> >   		mlx5_vdpa_warn(mvdev, "failed to query virtqueue\n");
> >   		return err;
> >   	}
> > -	state->avail_index = attr.available_index;
> > +	state->avail_index = attr.used_index;
> >   	return 0;
> >   }
> > @@ -1532,16 +1534,6 @@ static void teardown_virtqueues(struct mlx5_vdpa_net *ndev)
> >   	}
> >   }
> > -static void clear_virtqueues(struct mlx5_vdpa_net *ndev)
> > -{
> > -	int i;
> > -
> > -	for (i = ndev->mvdev.max_vqs - 1; i >= 0; i--) {
> > -		ndev->vqs[i].avail_idx = 0;
> > -		ndev->vqs[i].used_idx = 0;
> > -	}
> > -}
> > -
> >   /* TODO: cross-endian support */
> >   static inline bool mlx5_vdpa_is_little_endian(struct mlx5_vdpa_dev *mvdev)
> >   {
> > @@ -1777,7 +1769,6 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> >   	if (!status) {
> >   		mlx5_vdpa_info(mvdev, "performing device reset\n");
> >   		teardown_driver(ndev);
> > -		clear_virtqueues(ndev);
> >   		mlx5_vdpa_destroy_mr(&ndev->mvdev);
> >   		ndev->mvdev.status = 0;
> >   		++mvdev->generation;

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
