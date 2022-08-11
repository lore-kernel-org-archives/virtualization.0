Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0FAC19F2A
	for <virtualization@archiver.kernel.org>; Thu, 11 Aug 2022 13:06:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AA81610F1;
	Thu, 11 Aug 2022 13:06:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1AA81610F1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kd+pM7jy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Om5f5pUY5rb; Thu, 11 Aug 2022 13:06:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 97931610EE;
	Thu, 11 Aug 2022 13:06:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 97931610EE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2723EC0033;
	Thu, 11 Aug 2022 13:06:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EDFF0C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C1C5483083
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C1C5483083
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Kd+pM7jy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kypiWogYVmGV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:06:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED62D8305C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED62D8305C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 13:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660223159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DD8tZMy2hsby/h4jj66LofzE7ALVQ9/itpXRAfTrj1A=;
 b=Kd+pM7jyjWFZcA4/ZiV46Gzi2+nwRjlql6r7YZcpGGkguVhMrhtn82KWu7a8hiVXHIebHU
 /JfoUfw4YuWYrZfllRzaNDLp0BMIwYHdtsu16Vm8wzCJ18kUfuAgYuwY9U56ZHbm+JXnbC
 epGKITV0h+YF5LNQqHoVRgIhtlmDUVE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-657-YzPcW9TJNeC2SkDA1s4HBQ-1; Thu, 11 Aug 2022 09:05:58 -0400
X-MC-Unique: YzPcW9TJNeC2SkDA1s4HBQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 js11-20020a17090797cb00b00730d73eac83so5425404ejc.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Aug 2022 06:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=DD8tZMy2hsby/h4jj66LofzE7ALVQ9/itpXRAfTrj1A=;
 b=7aGRKoEQXMKsP412WQnnd+jnWnk4iiu9HvOOkBUWsjOYt9dqXM4n4dcxf7kGIiMDaA
 wAhD7aYoCLDLGIHQ6j9oJKof6Hbs0tp71wGSqEKeI88A0GBKTVmrjGsBpoGGLhGaSOuR
 uxZgDKBwtpNIfT8tp0DSmQ2mAb8AI7bRoduuyO/+fUzG3T8F0/v2mWTnr3Q8NUYnG3x7
 5nOM6zCbuc8UlcyYLR9MpiYlp356uPSMJ0YRTV8iehwkDC/FA8GOBAhDllPwbuy3QgUM
 8dguhquXTIiUxqidfXZDhVf/GeuyXTyY/L4EBZptcvREi+e7cJNZiNIaG5OIE97iEaFs
 I3QA==
X-Gm-Message-State: ACgBeo14UpvxZgTkfxflDIkj/KTa2E6u4VeJ14MA+WsBFv43dAI1XJYD
 brJXJk2XDx+MyFrlwh+eQ9rJeWbed1LYEIgt+Wl90mSH2hiArvkDRAzAUxcPPcpogdhruY/vBQI
 QNGT/sWxx41QN9BtKhvDT8lssBxuxAmiDwPEzNFRHPg==
X-Received: by 2002:a17:907:2bc4:b0:730:aa9c:bd86 with SMTP id
 gv4-20020a1709072bc400b00730aa9cbd86mr24445823ejc.341.1660223157739; 
 Thu, 11 Aug 2022 06:05:57 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4/WV9sQs77DWIC6jZmsofcpXPUJzwlmh0eIkhWZrNZmesghCJTA/ShsGVSoerPC0/kNiT5zQ==
X-Received: by 2002:a17:907:2bc4:b0:730:aa9c:bd86 with SMTP id
 gv4-20020a1709072bc400b00730aa9cbd86mr24445800ejc.341.1660223157481; 
 Thu, 11 Aug 2022 06:05:57 -0700 (PDT)
Received: from redhat.com ([2.52.152.113]) by smtp.gmail.com with ESMTPSA id
 s15-20020a170906284f00b0072f9dc2c246sm3470265ejc.133.2022.08.11.06.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Aug 2022 06:05:57 -0700 (PDT)
Date: Thu, 11 Aug 2022 09:05:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [bug report] vdpa/mlx5: Support different address spaces for
 control and data
Message-ID: <20220811090529-mutt-send-email-mst@kernel.org>
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

Patch on top pls? Time's running short.


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
