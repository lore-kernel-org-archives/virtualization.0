Return-Path: <SRS0=m9lB=HX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282FEC433DB
	for <virtualization@archiver.kernel.org>; Sun, 21 Feb 2021 21:52:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 934AB64EB4
	for <virtualization@archiver.kernel.org>; Sun, 21 Feb 2021 21:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934AB64EB4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4264185ABE;
	Sun, 21 Feb 2021 21:52:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u3aXFOwmVGTC; Sun, 21 Feb 2021 21:52:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 73AAF85AA1;
	Sun, 21 Feb 2021 21:52:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62DF8C000B;
	Sun, 21 Feb 2021 21:52:14 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98AFEC0001
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 21:52:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 84EED86F73
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 21:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GDC5-N7cAnD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 21:52:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9723E81B74
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 21:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613944331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U4JsN97Zzk+H8tb+mmssPj3kHXJxDnBczVQV8wHqk+k=;
 b=awBSl4/lEAHkkGzWBIozLn3f6bD4vHUvn19yTKxJ/ZT9vdkMVXwvhmVx8IaipOGc0g2K1l
 CLvXqL3IBydw9W1G9JK1Cz1JhVDBLudhlv33JgwPXcUiOfn93K5dD1gM93II2XqscMH/21
 9ePV4NUUbQEdEgfYYNMPM66+MbH1r7c=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-BbquuXlvOUOYpvv1FUFnjg-1; Sun, 21 Feb 2021 16:52:09 -0500
X-MC-Unique: BbquuXlvOUOYpvv1FUFnjg-1
Received: by mail-ed1-f70.google.com with SMTP id t9so6059371edd.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 21 Feb 2021 13:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U4JsN97Zzk+H8tb+mmssPj3kHXJxDnBczVQV8wHqk+k=;
 b=DcQSdzk9bxqSIRN/opFnpJDMlRKY4Mosg/VwaE1NbcG2MHDcALNpdGe01a8EPXylra
 gbHUqFIToP5qN9Gb3WgtMqkYKW6TFUGlxvPu/vBv5FpRIMU9vB/Nt3TeCsN/1FUbGllL
 hL/ZJgEvS7Yw6OmVZPJnC3ch5aFeBPg+c+9uPVdjfWkZ4pURud37EfvXmIvXCzSHAmBL
 1kG1V2BGQKlcTvqCQ8P9kYYfTHpDGgepKcVt7Bg8+WeBACoHfos4PYLkgZcsVDpkJxlZ
 hMxs4KGpwoQnj6xkwZwhopsSI+Tow90l7zSTQOwtcJ7qDVItrRmf1/ltv4ko7FQtl2EU
 +NhA==
X-Gm-Message-State: AOAM5323XVIkT8BHBoTqaUhObBoCs0BPXlDejMXMBzLpToobGDlJu7JG
 JIyF5IvzM1cYn8atwkllc66jDu0mWh5KcLJQ3LFO3kJOmRtVTafJlFXZxM8g0AM1wiLaRU0PEc1
 /cjnJDt1HiLuu0ZfrWd6KdR+eTGOtMjFiJKV9/mzOeQ==
X-Received: by 2002:a50:d302:: with SMTP id g2mr19664801edh.75.1613944328565; 
 Sun, 21 Feb 2021 13:52:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzgYIXSiqbazhwzI8TFh//3IRP1DzyO5yog4TY97wdwAVbNltx2njk4e91QiFVuiQ2EuP71Eg==
X-Received: by 2002:a50:d302:: with SMTP id g2mr19664791edh.75.1613944328428; 
 Sun, 21 Feb 2021 13:52:08 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id by8sm6554697edb.95.2021.02.21.13.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Feb 2021 13:52:07 -0800 (PST)
Date: Sun, 21 Feb 2021 16:52:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210221165047-mutt-send-email-mst@kernel.org>
References: <1613735698-3328-1-git-send-email-si-wei.liu@oracle.com>
 <20210221144437.GA82010@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210221144437.GA82010@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Sun, Feb 21, 2021 at 04:44:37PM +0200, Eli Cohen wrote:
> On Fri, Feb 19, 2021 at 06:54:58AM -0500, Si-Wei Liu wrote:
> > Commit 452639a64ad8 ("vdpa: make sure set_features is invoked
> > for legacy") made an exception for legacy guests to reset
> > features to 0, when config space is accessed before features
> > are set. We should relieve the verify_min_features() check
> > and allow features reset to 0 for this case.
> > 
> > It's worth noting that not just legacy guests could access
> > config space before features are set. For instance, when
> > feature VIRTIO_NET_F_MTU is advertised some modern driver
> > will try to access and validate the MTU present in the config
> > space before virtio features are set. Rejecting reset to 0
> > prematurely causes correct MTU and link status unable to load
> > for the very first config space access, rendering issues like
> > guest showing inaccurate MTU value, or failure to reject
> > out-of-range MTU.
> > 
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 7c1f789..540dd67 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1490,14 +1490,6 @@ static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
> >  	return mvdev->mlx_features;
> >  }
> >  
> > -static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> > -{
> > -	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)))
> > -		return -EOPNOTSUPP;
> > -
> > -	return 0;
> > -}
> > -
> 
> But what if VIRTIO_F_ACCESS_PLATFORM is not offerred? This does not
> support such cases.

Did you mean "catch such cases" rather than "support"?


> Maybe we should call verify_min_features() from mlx5_vdpa_set_status()
> just before attempting to call setup_driver().
> 
> >  static int setup_virtqueues(struct mlx5_vdpa_net *ndev)
> >  {
> >  	int err;
> > @@ -1558,18 +1550,13 @@ static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
> >  {
> >  	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >  	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > -	int err;
> >  
> >  	print_features(mvdev, features, true);
> >  
> > -	err = verify_min_features(mvdev, features);
> > -	if (err)
> > -		return err;
> > -
> >  	ndev->mvdev.actual_features = features & ndev->mvdev.mlx_features;
> >  	ndev->config.mtu = cpu_to_mlx5vdpa16(mvdev, ndev->mtu);
> >  	ndev->config.status |= cpu_to_mlx5vdpa16(mvdev, VIRTIO_NET_S_LINK_UP);
> > -	return err;
> > +	return 0;
> >  }
> >  
> >  static void mlx5_vdpa_set_config_cb(struct vdpa_device *vdev, struct vdpa_callback *cb)
> > -- 
> > 1.8.3.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
