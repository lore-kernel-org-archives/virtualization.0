Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F56C19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 13:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39C43830DE;
	Thu, 11 Aug 2022 13:21:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 39C43830DE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IL7h606S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4-BfrGT5C6x5; Thu, 11 Aug 2022 13:21:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B32D8830D7;
	Thu, 11 Aug 2022 13:21:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B32D8830D7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 946BEC0032;
	Thu, 11 Aug 2022 13:21:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92401C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 69159830E2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:21:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 69159830E2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WkWHuVNVyBLg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:21:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96CAE830C5
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 96CAE830C5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660224104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YQ/ww/9ckIeROxjEQXnhq3Jhe1tMgbHNmdWNJOxnvZM=;
 b=IL7h606SIyr7tNwY/1yfwwfHkNQnU/Pswht+5SUqixNXGEz+MwFeYjZUdd4TFtPRlrIncf
 mNFOKbPN0PVh4jGb8BDE+3x2SSiotbrlorevYL37wQzasFQnTTtQwkBMNxv4tvzxWo253h
 hzyZjkQzaS98NfqymdVtRt+b27oXjO4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-120-KHUoovjiPKKha9lk1fpUhA-1; Thu, 11 Aug 2022 09:21:43 -0400
X-MC-Unique: KHUoovjiPKKha9lk1fpUhA-1
Received: by mail-wr1-f70.google.com with SMTP id
 j20-20020adfb314000000b00220d9957623so2687225wrd.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 06:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=YQ/ww/9ckIeROxjEQXnhq3Jhe1tMgbHNmdWNJOxnvZM=;
 b=RHyM3faHVk+Y215RI+O2ga9+TaDZydUayGu7rC1GNqFDxJ/G9qOr871DomufsaJQUL
 dGjlqE8OqKKclaKFxaLtk79BOkWOJxAb73Yw+Uy1N92o5z3Puhl6wzsYjzAwl7uJB3bd
 LvzRuIyuYRokbSDtUOG4TP/x7kdm9KMPOE2v1araT7c9FPon8LR0u33x5+trTR3UJkma
 nohjl70jBAbbw/mIuDFobHgCTaAq9wY0QalPmwqt6xkmgLSA3S2IwILMCcGI3mq6yla8
 odS7VDqEMUU0G5fRehTFMA73ydm32GrxGzmU+JITNxEQlPFQIHU4v3pR11m9rCmZ60pZ
 Mu9Q==
X-Gm-Message-State: ACgBeo0nRgHp+RWtg4/k9vi1r+xtMNsAX/qWljpCxAvLRDZmYOxQhM+q
 DR+W/z2craxc+Bjc1Do31Yz2CTCXiKWFh/X67zOisVi4KgvyvHvwITSU9WNqS4/SFBi31QPIMlH
 /frVe8x+EIJe5f285pjp/4/R0OJVN7ii15DAJcPLN0w==
X-Received: by 2002:a05:6000:1f82:b0:223:654e:eb9 with SMTP id
 bw2-20020a0560001f8200b00223654e0eb9mr8033762wrb.66.1660224102335; 
 Thu, 11 Aug 2022 06:21:42 -0700 (PDT)
X-Google-Smtp-Source: AA6agR41iBxzRwzE419iPHvxf5GJagrBOblxngLlXU0w8SvlFaheK++wbajJg/73znJUlV7HUAEjyA==
X-Received: by 2002:a05:6000:1f82:b0:223:654e:eb9 with SMTP id
 bw2-20020a0560001f8200b00223654e0eb9mr8033752wrb.66.1660224102110; 
 Thu, 11 Aug 2022 06:21:42 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 n187-20020a1ca4c4000000b003a513ee7830sm7609035wme.27.2022.08.11.06.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 06:21:41 -0700 (PDT)
Date: Thu, 11 Aug 2022 09:21:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [bug report] vdpa/mlx5: Support different address spaces for
 control and data
Message-ID: <20220811091349-mutt-send-email-mst@kernel.org>
References: <YvTcabeJrDkd7/MP@kili>
 <DM8PR12MB54007865AC6BC6FCEC9911FCAB649@DM8PR12MB5400.namprd12.prod.outlook.com>
 <20220811090706-mutt-send-email-mst@kernel.org>
 <DM8PR12MB54007F39684505DC60ACB92CAB649@DM8PR12MB5400.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM8PR12MB54007F39684505DC60ACB92CAB649@DM8PR12MB5400.namprd12.prod.outlook.com>
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

On Thu, Aug 11, 2022 at 01:11:11PM +0000, Eli Cohen wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, August 11, 2022 4:09 PM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>; Jason Wang <jasowang@redhat.com>; Eugenio Perez Martin
> > <eperezma@redhat.com>; virtualization@lists.linux-foundation.org
> > Subject: Re: [bug report] vdpa/mlx5: Support different address spaces for control and data
> > 
> > On Thu, Aug 11, 2022 at 12:40:09PM +0000, Eli Cohen wrote:
> > > > From: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Sent: Thursday, August 11, 2022 1:40 PM
> > > > To: Eli Cohen <elic@nvidia.com>
> > > > Cc: virtualization@lists.linux-foundation.org
> > > > Subject: [bug report] vdpa/mlx5: Support different address spaces for control and data
> > > >
> > > > Hello Eli Cohen,
> > > >
> > > > The patch d5358cd0e369: "vdpa/mlx5: Support different address spaces
> > > > for control and data" from Jul 14, 2022, leads to the following
> > > > Smatch static checker warning:
> > > >
> > > > 	drivers/vdpa/mlx5/net/mlx5_vnet.c:2676 mlx5_vdpa_set_map()
> > > > 	error: uninitialized symbol 'err'.
> > > >
> > > > drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > >     2657 static int mlx5_vdpa_set_map(struct vdpa_device *vdev, unsigned int asid,
> > > >     2658                              struct vhost_iotlb *iotlb)
> > > >     2659 {
> > > >     2660         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > >     2661         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> > > >     2662         int err;
> > > >     2663
> > > >     2664         down_write(&ndev->reslock);
> > > >     2665         if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
> > > >     2666                 err = set_map_data(mvdev, iotlb);
> > > >     2667                 if (err)
> > > >     2668                         goto out;
> > > >     2669         }
> > > >     2670
> > > >     2671         if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid)
> > > >     2672                 err = set_map_control(mvdev, iotlb);
> > > >
> > > > err not initialized on else path.  My guess is that one or both of these
> > > > conditions has to be true and this is a false positive but I don't know
> > > > the code well enough to be sure.
> > >
> > > Thanks for reporting this.
> > > I think it would be better to return an error if the provided asid is not recognized.
> > >
> > > Therefore I am thinking about adding something like this:
> > >
> > >         if (asid != mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] &&
> > >             asid != mvdev->group2asid[MLX5_VDPA_CVQ_GROUP]) {
> > >                 err = -EINVAL;
> > >                 goto out;
> > >         }
> > 
> > I would probably chain the conditions:
> > 
> > if (mvdev->group2asid[MLX5_VDPA_DATAVQ_GROUP] == asid) {
> > } else if (mvdev->group2asid[MLX5_VDPA_CVQ_GROUP] == asid) {
> > } else {
> >                  err = -EINVAL;
> >                  goto out;
> > }
> > 
> > 
> > or alternatively initialize err with -EINVAL and be done with it.
> > 
> This makes more sense.
> Will send a patch in an hour.


Just making sure, the only result without this patch is that
and iotlb might be created without a mapping.
But nothing terrible bad will happen things just won't work
but this userspace is already buggy.
Right?

> > 
> > > >
> > > >     2673
> > > >     2674 out:
> > > >     2675         up_write(&ndev->reslock);
> > > > --> 2676         return err;
> > > >     2677 }
> > > >
> > > > regards,
> > > > dan carpenter

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
