Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48373C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 12:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D955A60AA0;
	Wed,  8 Jun 2022 12:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l1bZnG9HVtqe; Wed,  8 Jun 2022 12:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6E43660640;
	Wed,  8 Jun 2022 12:52:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D1A5C0039;
	Wed,  8 Jun 2022 12:52:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84082C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 12:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5E686831CA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 12:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vewGsCj0ZKgl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 12:52:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 86FD8831B0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654692719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mz+mEKznZ4YkzrtEHnGGxYGAfNYpR4omjcfYj9XsMt4=;
 b=Mdfqq3HSto3cb/ADmItvONnuK8g66UaVWCoWLWIMc+Nq43ky7cs5k1eUxGh1K8fWoVj6C6
 kA2VXnREFoZLMDBgzPcV8BoRT63IKmV932kzUVAsYoOECVtlD2K1srjnjaVZrdIVpKJRwc
 axNR/9AmMb/ilp4AdLnkhcT0M1P7Snw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-CKx7x88bODycmubMz1r7HQ-1; Wed, 08 Jun 2022 08:51:58 -0400
X-MC-Unique: CKx7x88bODycmubMz1r7HQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 i67-20020a1c3b46000000b0039c65f0e4ccso265354wma.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Jun 2022 05:51:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Mz+mEKznZ4YkzrtEHnGGxYGAfNYpR4omjcfYj9XsMt4=;
 b=Src4+YGEcB0FE3UfFf2T8iFK1ydzJQE1d8OIUepVcMO8TrQ0tvNFMmEqG4VJKozF5E
 gq/fd6TAiB9XJGlHRGnwZkEr1kQXweXCw0K7LxkDj8HweSnUv2NlkbQdJmbd/NLl8nlv
 BIzXpK0D8tBR0nKtT7m+XwHkyn6dcBo3f/4OCuPY6+rhzIhQkIWouTXixTugbPVSDOgD
 Amr4AFVkE+/+s3BbyP9zFUicbpN9PxiLB9rT04KDegfJMJ7rOE+6vc3iZYIpBJvWTGEk
 1a9rUVLFMi5NISwKUK3A/LWgieyMxFvsHXs1er8DW/yxbse629kF8wnnA0Hkd9NFdgye
 7Fsw==
X-Gm-Message-State: AOAM533XFmt5ZAPrp8x0AnZcvSCMPVarlX2Bx76HbVX2Gvbe08HlQ5+7
 2jdFnFM3ZL4ztL/8uk0ZyVIrld5Nc1PGJieeGCXfVcLjDm6VoEgEoC7cDTQ8cpmkZj00HDf1EwW
 Zc5o59P4OCEIR1F66O7/pSrlR2ahRPkt2QWUW87dBzA==
X-Received: by 2002:a05:6000:2a8:b0:213:ba0c:fef8 with SMTP id
 l8-20020a05600002a800b00213ba0cfef8mr28660000wry.485.1654692716600; 
 Wed, 08 Jun 2022 05:51:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyEvuVnHPbh1Pwji+4efIhOO+jRS9yko+Rj5RWlqq1wts/bzOt9ul1CrVpwkKJduoyDthZzyA==
X-Received: by 2002:a05:6000:2a8:b0:213:ba0c:fef8 with SMTP id
 l8-20020a05600002a800b00213ba0cfef8mr28659981wry.485.1654692716340; 
 Wed, 08 Jun 2022 05:51:56 -0700 (PDT)
Received: from redhat.com ([176.12.150.13]) by smtp.gmail.com with ESMTPSA id
 h6-20020adfa4c6000000b0020fe61acd09sm22283068wrb.12.2022.06.08.05.51.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jun 2022 05:51:55 -0700 (PDT)
Date: Wed, 8 Jun 2022 08:51:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] vduse: Fix NULL pointer dereference on sysfs access
Message-ID: <20220608085133-mutt-send-email-mst@kernel.org>
References: <20220426073656.229-1-xieyongji@bytedance.com>
 <YmeoSuMfsdVxuGlf@kroah.com>
MIME-Version: 1.0
In-Reply-To: <YmeoSuMfsdVxuGlf@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, mcgrof@kernel.org, oliver.sang@intel.com,
 akpm@linux-foundation.org
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

On Tue, Apr 26, 2022 at 10:07:38AM +0200, Greg KH wrote:
> On Tue, Apr 26, 2022 at 03:36:56PM +0800, Xie Yongji wrote:
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
> >  	dev->minor = ret;
> >  	dev->msg_timeout = VDUSE_MSG_DEFAULT_TIMEOUT;
> > -	dev->dev = device_create(vduse_class, NULL,
> > -				 MKDEV(MAJOR(vduse_major), dev->minor),
> > -				 dev, "%s", config->name);
> > +	dev->dev = device_create_with_groups(vduse_class, NULL,
> > +				MKDEV(MAJOR(vduse_major), dev->minor),
> > +				dev, vduse_dev_groups, "%s", config->name);
> >  	if (IS_ERR(dev->dev)) {
> >  		ret = PTR_ERR(dev->dev);
> >  		goto err_dev;
> > @@ -1595,7 +1595,6 @@ static int vduse_init(void)
> >  		return PTR_ERR(vduse_class);
> >  
> >  	vduse_class->devnode = vduse_devnode;
> > -	vduse_class->dev_groups = vduse_dev_groups;
> 
> Ok, this looks much better.
> 
> But wow, there are some problems in this code overall.  I see a number
> of flat-out-wrong things in there that should have been caught by code
> reviews.  Some examples:
> 	- empty release() callbacks.  That is a huge sign the code
> 	  design is wrong and broken and you are just trying to make the
> 	  driver core quiet for some reason.  The documentation in the
> 	  kernel explains why this is not ok.
> 	- __module_get(THIS_MODULE);  That's racy, buggy, and doesn't do
> 	  what you think it does.  Please never ever ever do that.  It
> 	  too is a sign of a broken design.
> 	- no Documentation/ABI/ entries for the sysfs files here.  I
> 	  think it's burried in some other documentation file but that's
> 	  not the correct place for it and if you run scripts/get_abi.pl
> 	  with the code loaded it will rightly complain about this.
> 
> Do you want to address these, or do you want patches for them?
> 
> thanks,
> 
> greg k-h

So, any patches?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
