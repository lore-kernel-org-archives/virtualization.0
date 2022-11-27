Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C84C43217
	for <virtualization@archiver.kernel.org>; Sun, 27 Nov 2022 16:34:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 302A481392;
	Sun, 27 Nov 2022 16:34:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 302A481392
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eKBdDDTw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rzqFTauecafe; Sun, 27 Nov 2022 16:34:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A045181385;
	Sun, 27 Nov 2022 16:34:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A045181385
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B1B7C0032;
	Sun, 27 Nov 2022 16:34:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B947C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 16:34:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3D42360B2E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 16:34:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D42360B2E
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=eKBdDDTw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id soKp8zir7Sz6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 16:34:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 22C7E60B24
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 22C7E60B24
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 16:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669566887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tv0i6Mb3/67wUHBrHUEJrFYjSPaDixK1VWQy8tVPRpc=;
 b=eKBdDDTwifn2TNWsCEZgGmnL5PwBrYhaYK6T/2fAurn9uEsR685KFyXT+bmFSNw7nu3Rd+
 uLS9FMAcRQfoTg8N4irTdw/iQMT5Vz+BffbVj2hUYmPPZ9M7svfZTtiUsKijtgo43pp7ak
 FbgSa/ENBcXHka6InfJBtdd0xFT3n58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-ggwf2ukLNEiNYx2W5v7_ig-1; Sun, 27 Nov 2022 11:34:46 -0500
X-MC-Unique: ggwf2ukLNEiNYx2W5v7_ig-1
Received: by mail-wm1-f70.google.com with SMTP id
 c187-20020a1c35c4000000b003cfee3c91cdso5152889wma.6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Nov 2022 08:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tv0i6Mb3/67wUHBrHUEJrFYjSPaDixK1VWQy8tVPRpc=;
 b=ElkCv5pvICg8T4GnMeoPY5ddw6bgwRSng21ygiFyy+LgcnbBnkOvH5BulgSXncO6I0
 KqBj+s26nIHhtZ4nQc/8W8pTywcUxqlvXy5GWO+qDT+x8HKQ7bhZnyamvNmSbs6/2W15
 nzBBiZYmgFAlFQMVufOZGpSKAS34O9lUwcnE+2g9lGBAD3PNRBf+CYWQdcKgGFO8z6mJ
 fqLqv5KUZh966DG4yBFqSrq7Me0dgbm2GDqKGcnQm7LOCAlkvNijZnQkQbWk6UVC2KtJ
 AxMECMa+yoaoYjtdnHWanxh8S9v5itL4jiKOdQWFKrN4AT2xMfd4MALo2rW0ywnAh+zs
 6lTQ==
X-Gm-Message-State: ANoB5pl1t0r8YF7UAQlycI/qDw+t/v8/x+K7KDsxinwvsHj879+EWtbh
 EbPsqLoRIeoat7Gy7gucY47W8zoIJ/sqgvuUoSPMvC341shvccs2wKyZgI4tN5suV7ZMvS0CYZb
 r/PjyWpKkRQvqJOYojnFwwVwXsNHNzWfvCmI2EZsO1w==
X-Received: by 2002:a05:600c:4e06:b0:3cf:703e:1d88 with SMTP id
 b6-20020a05600c4e0600b003cf703e1d88mr23369403wmq.155.1669566885116; 
 Sun, 27 Nov 2022 08:34:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5cUmg5EoGEynuuBBNzwkfATchN/A2m3eltFERYL+l0sxG3i2BIa2OQpQfV/VG64yqxo0qrUQ==
X-Received: by 2002:a05:600c:4e06:b0:3cf:703e:1d88 with SMTP id
 b6-20020a05600c4e0600b003cf703e1d88mr23369394wmq.155.1669566884863; 
 Sun, 27 Nov 2022 08:34:44 -0800 (PST)
Received: from redhat.com ([2.52.135.58]) by smtp.gmail.com with ESMTPSA id
 b10-20020adfde0a000000b0022e57e66824sm9966230wrm.99.2022.11.27.08.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Nov 2022 08:34:44 -0800 (PST)
Date: Sun, 27 Nov 2022 11:34:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] vduse: Fix a possible warning in vduse_create_dev()
Message-ID: <20221127113416-mutt-send-email-mst@kernel.org>
References: <20221126040000.775914-1-harshit.m.mogalapalli@oracle.com>
 <20221126181822-mutt-send-email-mst@kernel.org>
 <8253ab3f-b4f2-ff60-7e87-6455c9c10dc8@oracle.com>
MIME-Version: 1.0
In-Reply-To: <8253ab3f-b4f2-ff60-7e87-6455c9c10dc8@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Guanjun <guanjun@linux.alibaba.com>, error27@gmail.com,
 harshit.m.mogalapalli@gmail.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Gautam Dawar <gautam.dawar@xilinx.com>, Eli Cohen <elic@nvidia.com>
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

On Sun, Nov 27, 2022 at 08:16:24AM +0530, Harshit Mogalapalli wrote:
> Hi Micheal,
> 
> On 27/11/22 4:52 am, Michael S. Tsirkin wrote:
> > On Fri, Nov 25, 2022 at 07:59:58PM -0800, Harshit Mogalapalli wrote:
> > > As 'dev->vq_num' is user-controlled data, if user tries to allocate
> > > memory larger than(>=) MAX_ORDER, then kcalloc() will fail, it
> > > creates a stack trace and messes up dmesg with a warning.
> > > 
> > > Call trace:
> > > -> vduse_ioctl
> > > --> vduse_create_dev
> > > 'config->vq_num' is user data as it comes from ioctl, which is
> > > assigned to 'dev->vq_num'.
> > > 
> > > Add __GFP_NOWARN in order to avoid too large allocation warning.
> > > This is detected by static analysis using smatch.
> > > 
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > > ---
> > >   drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 35dceee3ed56..5e9546b16165 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1512,7 +1512,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > >   	dev->config_size = config->config_size;
> > >   	dev->vq_align = config->vq_align;
> > >   	dev->vq_num = config->vq_num;
> > > -	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs), GFP_KERNEL);
> > > +	dev->vqs = kcalloc(dev->vq_num, sizeof(*dev->vqs),
> > > +			   GFP_KERNEL | __GFP_NOWARN);
> > >   	if (!dev->vqs)
> > >   		goto err_vqs;
> > 
> 
> Thanks for checking the patch.
> 
> > This is insufficient - the real source of the problem is that
> > vq_num is not validated.
> > The thing to do is to validate config and limit vq_num to 0xffff;
> > 
> 
> 1557 static long vduse_ioctl(struct file *file, unsigned int cmd,
> 1558                         unsigned long arg)
> 1559 {
> 1560         int ret;
> 1561         void __user *argp = (void __user *)arg;
> 1564         mutex_lock(&vduse_lock);
> 1565         switch (cmd) {
>              ....
> 1584         case VDUSE_CREATE_DEV: {
> 1585                 struct vduse_dev_config config;
> 1587                 void *buf;
> 1588
> 1589                 ret = -EFAULT;
> 1590                 if (copy_from_user(&config, argp, size))
> 1591                         break;
> 1592
> 1593                 ret = -EINVAL;
> 1594                 if (vduse_validate_config(&config) == false)
> 1595                         break;
> 1596
> 1597                 buf = vmemdup_user(argp + size, config.config_size);
> 1598                 if (IS_ERR(buf)) {
> 1599                         ret = PTR_ERR(buf);
> 1600                         break;
> 1601                 }
> 1602                 config.name[VDUSE_NAME_MAX - 1] = '\0';
> 1603                 ret = vduse_create_dev(&config, buf,
> control->api_version);
> 1604                 if (ret)
> 1605                         kvfree(buf);
> 1606                 break;
> 1607         }
> 
> we have vduse_validate_config() being called in vduse_ioctl() which is the
> caller of vduse_create_dev(), so validate_config() is not necessary in
> vduse_create_dev() ?
> 
> Thanks,
> Harshit

OK but I don't see vduse_validate_config checking vq_num.

> > 
> > > -- 
> > > 2.38.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
