Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8711DC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 10:26:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2ECFB83096;
	Tue, 26 Apr 2022 10:26:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3oZRwMsl4K9d; Tue, 26 Apr 2022 10:26:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 98DB382FA2;
	Tue, 26 Apr 2022 10:26:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A8A4C0032;
	Tue, 26 Apr 2022 10:26:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F1DB0C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 10:26:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EEB3C82FA5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 10:26:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hIuBmqL80Y1P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 10:26:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74FDC82FA2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 10:26:14 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7C8C9B81D31;
 Tue, 26 Apr 2022 10:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3638C385A0;
 Tue, 26 Apr 2022 10:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650968770;
 bh=2OBnOnd6mJaMJKrh4oIOTXhW7D16xDRsgp42ko9TU7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M94X8ae4FhkiaEvi6ftxfGvWAX5tc2606oAPLTEHoV9z0cRBYpLAzUkhxVzDSI79L
 5ijUcCPnTyOETg4RgCB0SilUFieMUdO/kj/rZLLOZYcDst1SR9E88dMV+uJWd5BJik
 z4AS1vI+5kVIJsxPIDQ0nuCselw7cgWUa/3ehjJQ=
Date: Tue, 26 Apr 2022 12:26:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2] vduse: Fix NULL pointer dereference on sysfs access
Message-ID: <YmfIv2YuARnPe97k@kroah.com>
References: <20220426073656.229-1-xieyongji@bytedance.com>
 <YmeoSuMfsdVxuGlf@kroah.com>
 <CACycT3sLgihkgX5cB6GxDehaTsPn9rqhtWF7G_=J=__oTopJZw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACycT3sLgihkgX5cB6GxDehaTsPn9rqhtWF7G_=J=__oTopJZw@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stable@vger.kernel.org,
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

On Tue, Apr 26, 2022 at 05:41:15PM +0800, Yongji Xie wrote:
> On Tue, Apr 26, 2022 at 4:07 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Apr 26, 2022 at 03:36:56PM +0800, Xie Yongji wrote:
> > > The control device has no drvdata. So we will get a
> > > NULL pointer dereference when accessing control
> > > device's msg_timeout attribute via sysfs:
> > >
> > > [ 132.841881][ T3644] BUG: kernel NULL pointer dereference, address: 00000000000000f8
> > > [ 132.850619][ T3644] RIP: 0010:msg_timeout_show (drivers/vdpa/vdpa_user/vduse_dev.c:1271)
> > > [ 132.869447][ T3644] dev_attr_show (drivers/base/core.c:2094)
> > > [ 132.870215][ T3644] sysfs_kf_seq_show (fs/sysfs/file.c:59)
> > > [ 132.871164][ T3644] ? device_remove_bin_file (drivers/base/core.c:2088)
> > > [ 132.872082][ T3644] kernfs_seq_show (fs/kernfs/file.c:164)
> > > [ 132.872838][ T3644] seq_read_iter (fs/seq_file.c:230)
> > > [ 132.873578][ T3644] ? __vmalloc_area_node (mm/vmalloc.c:3041)
> > > [ 132.874532][ T3644] kernfs_fop_read_iter (fs/kernfs/file.c:238)
> > > [ 132.875513][ T3644] __kernel_read (fs/read_write.c:440 (discriminator 1))
> > > [ 132.876319][ T3644] kernel_read (fs/read_write.c:459)
> > > [ 132.877129][ T3644] kernel_read_file (fs/kernel_read_file.c:94)
> > > [ 132.877978][ T3644] kernel_read_file_from_fd (include/linux/file.h:45 fs/kernel_read_file.c:186)
> > > [ 132.879019][ T3644] __do_sys_finit_module (kernel/module.c:4207)
> > > [ 132.879930][ T3644] __ia32_sys_finit_module (kernel/module.c:4189)
> > > [ 132.880930][ T3644] do_int80_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:132)
> > > [ 132.881847][ T3644] entry_INT80_compat (arch/x86/entry/entry_64_compat.S:419)
> > >
> > > To fix it, don't create the unneeded attribute for
> > > control device anymore.
> > >
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index f85d1a08ed87..160e40d03084 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1344,9 +1344,9 @@ static int vduse_create_dev(struct vduse_dev_config *config,
> > >
> > >       dev->minor = ret;
> > >       dev->msg_timeout = VDUSE_MSG_DEFAULT_TIMEOUT;
> > > -     dev->dev = device_create(vduse_class, NULL,
> > > -                              MKDEV(MAJOR(vduse_major), dev->minor),
> > > -                              dev, "%s", config->name);
> > > +     dev->dev = device_create_with_groups(vduse_class, NULL,
> > > +                             MKDEV(MAJOR(vduse_major), dev->minor),
> > > +                             dev, vduse_dev_groups, "%s", config->name);
> > >       if (IS_ERR(dev->dev)) {
> > >               ret = PTR_ERR(dev->dev);
> > >               goto err_dev;
> > > @@ -1595,7 +1595,6 @@ static int vduse_init(void)
> > >               return PTR_ERR(vduse_class);
> > >
> > >       vduse_class->devnode = vduse_devnode;
> > > -     vduse_class->dev_groups = vduse_dev_groups;
> >
> > Ok, this looks much better.
> >
> > But wow, there are some problems in this code overall.  I see a number
> > of flat-out-wrong things in there that should have been caught by code
> > reviews.  Some examples:
> >         - empty release() callbacks.  That is a huge sign the code
> >           design is wrong and broken and you are just trying to make the
> >           driver core quiet for some reason.  The documentation in the
> >           kernel explains why this is not ok.
> 
> Sorry, I failed to find the documentation. Do you mean we should
> remove the empty release() callbacks?

Yes, why are they needed?

(hint, retorical question, you added them to remove the driver core
warning when the device is removed, which means someone added them just
because they thought that their code could ignore the hints that the
driver core was telling them.)

Please properly free the memory here.

> >         - __module_get(THIS_MODULE);  That's racy, buggy, and doesn't do
> >           what you think it does.  Please never ever ever do that.  It
> >           too is a sign of a broken design.
> 
> I don't find a good way to remove it. We have to make sure the module
> can't be removed until all vduse devices are destroyed.

That will happen automatically when the module is removed.

> And I think __module_get(THIS_MODULE) should be safe in our case since
> we always call it when we have a reference from open().

What happened if someone removed the module _right before_ this was
called?  You can not grab your own reference count safely.

Please just remove it, it's not needed and is broken.  There should not
be any reason that the module can not be unloaded, UNLESS a file handle
is open, and you properly handle that already.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
