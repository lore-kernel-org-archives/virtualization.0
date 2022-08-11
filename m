Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F367C19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 13:09:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C2BB340B70;
	Thu, 11 Aug 2022 13:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C2BB340B70
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IZtCE/3T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xiX3gStjpfzN; Thu, 11 Aug 2022 13:09:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4AE694014D;
	Thu, 11 Aug 2022 13:09:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AE694014D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1B52C0032;
	Thu, 11 Aug 2022 13:09:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF39FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:09:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C677D403E0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:09:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C677D403E0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qcqF1AYKy4bs
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:09:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0675A4014D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0675A4014D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660223353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ajTthCfqVpvQ8qkg7XqsP44LpCHQA/7+L+mYleCdpGs=;
 b=IZtCE/3Tj3Qv4kzzL14hvrWP5oaNmFWX0y0j39mnjrwN7VJBO+rJifjH2Rk00TGC+fuWko
 oy26uxJxW+6EHaPixIHAMiRXecBEaOtQ/eT2of8kJGJiZinrcESfVsHs3oUvcOCYT/xjm5
 s+RYENX8vg9nhGAgaA1GxGhjx7pDs38=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-44-9KzTdyyIMc6edkRX6ZuLcA-1; Thu, 11 Aug 2022 09:09:12 -0400
X-MC-Unique: 9KzTdyyIMc6edkRX6ZuLcA-1
Received: by mail-ed1-f72.google.com with SMTP id
 z6-20020a05640240c600b0043e1d52fd98so11060068edb.22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 06:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=ajTthCfqVpvQ8qkg7XqsP44LpCHQA/7+L+mYleCdpGs=;
 b=MyplTt25rx/ZdC2vnmB1HuDMO+9jBh1DINhpUMUjdLZm+Bmo+/R2dNNeWBIeQDwTy2
 MrjwLf5HZtrRJiPBsx4BRGFNh8mNp80ANr+5zDVhS3/k+KChft/yqPmDNMTcnmxjce+1
 jwEdMrS+62hq1M28ps6y09cgEI8lOGIoEiEgkQ0QhbrdWFSCFUb0tDLBQJLXkVlAemxY
 zEyIktGCSDvPAr1PA9PR+4y+bpYJCIGDeWaE5P3HF2LUg1ypIP+KSw+FQnNhtQPjBTED
 mz9ZgunWG13KJOE0Mki6A8f3hhrRFWEubBgY53+kPmwuhgFDls1yRyqNLpVMdWLHirQF
 D/jQ==
X-Gm-Message-State: ACgBeo2ZSBf/Z4GXIZvPQ67UzMoVBLta3Bxpt/0y1/PhqfGfyPXxAPEg
 Z1N5PthjpH2u2JZLpQ0c9KWUA1c6OSdfqPc3o8XOBSTemgK3Cv5W0KptdIT2emwaOEOtclpsQZd
 zVa23J+eN+eXVbwF+m+FIRNziFW1tfxMt6zUEfd+E7g==
X-Received: by 2002:aa7:d597:0:b0:43d:5bcf:f251 with SMTP id
 r23-20020aa7d597000000b0043d5bcff251mr30968507edq.15.1660223351021; 
 Thu, 11 Aug 2022 06:09:11 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5np/8sq5L7+K5htbY55ZXJfAszCRwBwVQwE4KJWYyPsuHWzb4xYBjzTZFtR7HWuuLtHY0vyA==
X-Received: by 2002:aa7:d597:0:b0:43d:5bcf:f251 with SMTP id
 r23-20020aa7d597000000b0043d5bcff251mr30968489edq.15.1660223350851; 
 Thu, 11 Aug 2022 06:09:10 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 m21-20020a170906721500b0073093eaf53esm3483525ejk.131.2022.08.11.06.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 06:09:10 -0700 (PDT)
Date: Thu, 11 Aug 2022 09:09:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [bug report] vdpa/mlx5: Support different address spaces for
 control and data
Message-ID: <20220811090706-mutt-send-email-mst@kernel.org>
References: <YvTcabeJrDkd7/MP@kili>
 <DM8PR12MB54007865AC6BC6FCEC9911FCAB649@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54007865AC6BC6FCEC9911FCAB649@DM8PR12MB5400.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eugenio Perez Martin <eperezma@redhat.com>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Thu, Aug 11, 2022 at 12:40:09PM +0000, Eli Cohen wrote:
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> > Sent: Thursday, August 11, 2022 1:40 PM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Subject: [bug report] vdpa/mlx5: Support different address spaces for control and data
> > 
> > Hello Eli Cohen,
> > 
> > The patch d5358cd0e369: "vdpa/mlx5: Support different address spaces
> > for control and data" from Jul 14, 2022, leads to the following
> > Smatch static checker warning:
> > 
> > 	drivers/vdpa/mlx5/net/mlx5_vnet.c:2676 mlx5_vdpa_set_map()
> > 	error: uninitialized symbol 'err'.
> > 
> > drivers/vdpa/mlx5/net/mlx5_vnet.c
> >     2657 static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
> >     2658                              struct vhost_iotlb *iotlb)
> >     2659 {
> >     2660         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >     2661         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >     2662         int err;
> >     2663
> >     2664         down_write(&ndev->reslock);
> >     2665         if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
> >     2666                 err = set_map_data(mvdev, iotlb);
> >     2667                 if (err)
> >     2668                         goto out;
> >     2669         }
> >     2670
> >     2671         if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid)
> >     2672                 err = set_map_control(mvdev, iotlb);
> > 
> > err not initialized on else path.  My guess is that one or both of these
> > conditions has to be true and this is a false positive but I don't know
> > the code well enough to be sure.
> 
> Thanks for reporting this.
> I think it would be better to return an error if the provided asid is not recognized.
> 
> Therefore I am thinking about adding something like this:
> 
>         if (asid != mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] &&
>             asid != mvdev->group2asid[MLX5_VDPA_CVQ_GROUP]) {
>                 err = -EINVAL;
>                 goto out;
>         }

I would probably chain the conditions:

if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
} else if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
} else {
                 err = -EINVAL;
                 goto out;
}


or alternatively initialize err with -EINVAL and be done with it.


> > 
> >     2673
> >     2674 out:
> >     2675         up_write(&ndev->reslock);
> > --> 2676         return err;
> >     2677 }
> > 
> > regards,
> > dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
