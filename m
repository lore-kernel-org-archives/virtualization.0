Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30440C43334
	for <virtualization@archiver.kernel.org>; Thu,  2 Jun 2022 09:51:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D328B60806;
	Thu,  2 Jun 2022 09:51:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e0pbHvgTveq8; Thu,  2 Jun 2022 09:51:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 82F3A60B2D;
	Thu,  2 Jun 2022 09:51:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59C26C0032;
	Thu,  2 Jun 2022 09:51:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A70FDC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8247660B2D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:51:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gi7tF8Myj_gI
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:51:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE3C260806
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 09:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654163494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+kegU7ORx0W8UnxolSPCB9JQoq9JSMa2fSWT0u2zedo=;
 b=iU50wQzwdlbWykldp4ZfK1GXjC/JuKAoldyrXKZE9f59hUkp8I171ZrmggR4CLEN+MjReH
 UDre0CjfoVSqzvNsjhbaLot+eUxNKNnpIuJPCUWA8Tci8TYF67SvXlYLR00aLLfwCtOORC
 mE3o5WXDYj4m4TVC7LyoPyO/30QWuu4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-235-3FJL5CjDOkqG0-FjDSaJ2Q-1; Thu, 02 Jun 2022 05:51:33 -0400
X-MC-Unique: 3FJL5CjDOkqG0-FjDSaJ2Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 o3-20020a05600c510300b0039743540ac7so2166683wms.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Jun 2022 02:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+kegU7ORx0W8UnxolSPCB9JQoq9JSMa2fSWT0u2zedo=;
 b=LNZ6JyB+VNKvIh6REaKFEvekHO8przKtMSxyICbwFh576NyKBAlPCH/h/+o6WDHC0B
 G/eQAIBC6l+nuOQUytkRC3y4wKMBG5ak0/DK+NaGJWG2Rxwu8U/KO89OVQRmApwAM3+4
 wyMG8R0GKRoxhgxpQDt75l3vmu6927+sOcJ5VX9kLs/x2w3CmKagkZ8SdiCOEOmlWcbX
 1SVS9WSZ5Ht65W1m2Bk4oVjvJUHIWYyb0FP2ospH09CeHX/lqOZKcXLDqoBUHldpYJEN
 uUS/iwhOy1NRrLbuTOPnHJTYEJK9DOZFm1rKc3h6DX8g9j7q71goB81R9H3ngdqHyKL6
 q/6w==
X-Gm-Message-State: AOAM533KvsCGXSQTSvYPar1rRwsCQuzWSecD0K+1A5d94FbHA+Oq0b+7
 kVegQN62YcAA55/6lL9h5O/Jx3NcTwBXdwowrdpx1RiPiSaoqmblkmtnQUJlps7P+GJwa/rkTV1
 JvNWDQtfVY6CvxdU3KX0dwqNziLEZpjOKjyqG9zFkmg==
X-Received: by 2002:a5d:64ac:0:b0:211:7f3b:a0d4 with SMTP id
 m12-20020a5d64ac000000b002117f3ba0d4mr3004789wrp.490.1654163491435; 
 Thu, 02 Jun 2022 02:51:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCe/mjZchJWw3n43gLEvTclxgrryh7EI+ogi7ouPTFMNYR2LffHT+ygDCYALQpH0gwN+7kGg==
X-Received: by 2002:a5d:64ac:0:b0:211:7f3b:a0d4 with SMTP id
 m12-20020a5d64ac000000b002117f3ba0d4mr3004761wrp.490.1654163491211; 
 Thu, 02 Jun 2022 02:51:31 -0700 (PDT)
Received: from redhat.com ([2.52.157.68]) by smtp.gmail.com with ESMTPSA id
 q16-20020adfcd90000000b00213abce60e4sm401297wrj.111.2022.06.02.02.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 02:51:30 -0700 (PDT)
Date: Thu, 2 Jun 2022 05:51:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] vduse: Fix NULL pointer dereference on sysfs access
Message-ID: <20220602055103-mutt-send-email-mst@kernel.org>
References: <20220426073656.229-1-xieyongji@bytedance.com>
 <CACycT3v+r1-RO1q_BuStkaais7n0yDXK4gT89WhchpX3AvRPcg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3v+r1-RO1q_BuStkaais7n0yDXK4gT89WhchpX3AvRPcg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 virtualization <virtualization@lists.linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>,
 kernel test robot <oliver.sang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
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

On Thu, Jun 02, 2022 at 12:55:02PM +0800, Yongji Xie wrote:
> Ping.

Thanks for the reminder!
Will queue for rc2, rc1 has too much stuff already.

> On Tue, Apr 26, 2022 at 3:36 PM Xie Yongji <xieyongji@bytedance.com> wrote:
> >
> > The control device has no drvdata. So we will get a
> > NULL pointer dereference when accessing control
> > device's msg_timeout attribute via sysfs:
> >
> > [ 132.841881][ T3644] BUG: kernel NULL pointer dereference, address: 00000000000000f8
> > [ 132.850619][ T3644] RIP: 0010:msg_timeout_show (drivers/vdpa/vdpa_user/vduse_dev.c:1271)
> > [ 132.869447][ T3644] dev_attr_show (drivers/base/core.c:2094)
> > [ 132.870215][ T3644] sysfs_kf_seq_show (fs/sysfs/file.c:59)
> > [ 132.871164][ T3644] ? device_remove_bin_file (drivers/base/core.c:2088)
> > [ 132.872082][ T3644] kernfs_seq_show (fs/kernfs/file.c:164)
> > [ 132.872838][ T3644] seq_read_iter (fs/seq_file.c:230)
> > [ 132.873578][ T3644] ? __vmalloc_area_node (mm/vmalloc.c:3041)
> > [ 132.874532][ T3644] kernfs_fop_read_iter (fs/kernfs/file.c:238)
> > [ 132.875513][ T3644] __kernel_read (fs/read_write.c:440 (discriminator 1))
> > [ 132.876319][ T3644] kernel_read (fs/read_write.c:459)
> > [ 132.877129][ T3644] kernel_read_file (fs/kernel_read_file.c:94)
> > [ 132.877978][ T3644] kernel_read_file_from_fd (include/linux/file.h:45 fs/kernel_read_file.c:186)
> > [ 132.879019][ T3644] __do_sys_finit_module (kernel/module.c:4207)
> > [ 132.879930][ T3644] __ia32_sys_finit_module (kernel/module.c:4189)
> > [ 132.880930][ T3644] do_int80_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:132)
> > [ 132.881847][ T3644] entry_INT80_compat (arch/x86/entry/entry_64_compat.S:419)
> >
> > To fix it, don't create the unneeded attribute for
> > control device anymore.
> >
> > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > index f85d1a08ed87..160e40d03084 100644
> > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > @@ -1344,9 +1344,9 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> >
> >         dev->minor = ret;
> >         dev->msg_timeout = VDUSE_MSG_DEFAULT_TIMEOUT;
> > -       dev->dev = device_create(vduse_class, NULL,
> > -                                MKDEV(MAJOR(vduse_major), dev->minor),
> > -                                dev, "%s", config->name);
> > +       dev->dev = device_create_with_groups(vduse_class, NULL,
> > +                               MKDEV(MAJOR(vduse_major), dev->minor),
> > +                               dev, vduse_dev_groups, "%s", config->name);
> >         if (IS_ERR(dev->dev)) {
> >                 ret = PTR_ERR(dev->dev);
> >                 goto err_dev;
> > @@ -1595,7 +1595,6 @@ static int vduse_init(void)
> >                 return PTR_ERR(vduse_class);
> >
> >         vduse_class->devnode = vduse_devnode;
> > -       vduse_class->dev_groups = vduse_dev_groups;
> >
> >         ret = alloc_chrdev_region(&vduse_major, 0, VDUSE_DEV_MAX, "vduse");
> >         if (ret)
> > --
> > 2.20.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
