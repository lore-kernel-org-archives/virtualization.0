Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1E5C433F5
	for <virtualization@archiver.kernel.org>; Thu, 12 May 2022 05:24:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1C3540BB3;
	Thu, 12 May 2022 05:24:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KtNIU_xKMNAy; Thu, 12 May 2022 05:24:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 6301340B9F;
	Thu, 12 May 2022 05:24:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45AB6C0032;
	Thu, 12 May 2022 05:24:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E62D3C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C50F140B9F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CNqwL0CpsZ2Z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:24:01 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6900E400B8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 May 2022 05:24:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 97D39B825FA;
 Thu, 12 May 2022 05:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28541C385B8;
 Thu, 12 May 2022 05:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652333037;
 bh=iO2XqMZ4UyTum1iHdMB3o2nnYEFFUVsy85GicIgHU4k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TxuI3xhlbDa1zm54BuKSo88OVHci46cONQ6B6B51sCflmop3Ao4FzLFCLgMnWo2Lj
 yfzMKJH8EOIelZQ/6RVuw0svbG/ZqOAI44OQLLE3HiblPjy7o3QxL5AibZ2Lzf5BaC
 slIOs08BpRcHjvrshL/spDTVrEdFjmu15JpPWgZI=
Date: Thu, 12 May 2022 07:23:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH 1/2] vduse: Remove empty vduse_mgmtdev_release()
Message-ID: <YnyZ6LiaQDxRSD/b@kroah.com>
References: <20220511135523.147-1-xieyongji@bytedance.com>
 <YnvB2ZxyzGRkPwbm@kroah.com>
 <CACycT3s_-E=whAX02C0KKnr-1qx2yWdvTrRnQN=Km1L98VFThg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACycT3s_-E=whAX02C0KKnr-1qx2yWdvTrRnQN=Km1L98VFThg@mail.gmail.com>
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Thu, May 12, 2022 at 01:19:58PM +0800, Yongji Xie wrote:
> On Wed, May 11, 2022 at 10:02 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, May 11, 2022 at 09:55:22PM +0800, Xie Yongji wrote:
> > > It's not recommended to provide an "empty" release function
> > > for the device object as Documentation/core-api/kobject.rst
> > > mentioned.
> >
> > "it is a bug to have an empty release function" is more like it :)
> >
> 
> OK.
> 
> > > So let's allocate the device object dynamically
> > > to get rid of it.
> >
> > Much better, but not quite there, see below for details.
> >
> > >
> > > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > > ---
> > >  drivers/vdpa/vdpa_user/vduse_dev.c | 43 +++++++++++++++++-------------
> > >  1 file changed, 25 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > index 160e40d03084..a8a5ebaefa10 100644
> > > --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> > > +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> > > @@ -1475,15 +1475,6 @@ static char *vduse_devnode(struct device *dev, umode_t *mode)
> > >       return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
> > >  }
> > >
> > > -static void vduse_mgmtdev_release(struct device *dev)
> > > -{
> > > -}
> > > -
> > > -static struct device vduse_mgmtdev = {
> > > -     .init_name = "vduse",
> > > -     .release = vduse_mgmtdev_release,
> > > -};
> > > -
> > >  static struct vdpa_mgmt_dev mgmt_dev;
> >
> > Close.  This should be a pointer and the device structure within it
> > should control the lifecycle of that structure.  It should not be a
> > single static structure like this, that's very odd.
> >
> 
> OK, I can define mgmt_dev as a pointer. But the device is defined as a
> parent device for structure vdpa_mgmt_dev. So I think we can't use it
> to control the lifecycle of the structure vdpa_mgmt_dev.

You should be able to control the lifecycle of it, especially if it is
the parent device of something.  To not do that correctly is to have
everything messed up as you should be using the driver model properly.
As it is, you are not :(

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
