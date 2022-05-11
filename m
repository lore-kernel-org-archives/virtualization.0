Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287FFC433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 14:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AC6C6410C1;
	Wed, 11 May 2022 14:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dqSH0Wd5c_fH; Wed, 11 May 2022 14:02:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B02D40272;
	Wed, 11 May 2022 14:02:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ED2D9C0032;
	Wed, 11 May 2022 14:02:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85578C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 64FC2828AA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8wpvY9i_cEA5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:02:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06E9982F8B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 14:02:05 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D497361D0B;
 Wed, 11 May 2022 14:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7182C34113;
 Wed, 11 May 2022 14:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652277724;
 bh=9jpc4ztUZ6mtjkmJ3SJHM7E0C3hEVy05mFI8/FvEfNU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oZtH4SpzpVtdw3LMPferUROn8e/1WNKkzTUnpXRoWVEP8NB9reS1s5RDyzyb0CNfZ
 f+fWRMEZ+m2pv93zjRvMgKiqwohV4KQJ0arxU+MBzERpXPziEKHX21AXRIHsf8Na6b
 OdEcjSS7FgLG3haaubVmEgBjtO6OzJ6D5hsJOiOk=
Date: Wed, 11 May 2022 16:02:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 1/2] vduse: Remove empty vduse_mgmtdev_release()
Message-ID: <YnvB2ZxyzGRkPwbm@kroah.com>
References: <20220511135523.147-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220511135523.147-1-xieyongji@bytedance.com>
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

On Wed, May 11, 2022 at 09:55:22PM +0800, Xie Yongji wrote:
> It's not recommended to provide an "empty" release function
> for the device object as Documentation/core-api/kobject.rst
> mentioned.

"it is a bug to have an empty release function" is more like it :)

> So let's allocate the device object dynamically
> to get rid of it.

Much better, but not quite there, see below for details.

> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 43 +++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 160e40d03084..a8a5ebaefa10 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1475,15 +1475,6 @@ static char *vduse_devnode(struct device *dev, umode_t *mode)
>  	return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
>  }
>  
> -static void vduse_mgmtdev_release(struct device *dev)
> -{
> -}
> -
> -static struct device vduse_mgmtdev = {
> -	.init_name = "vduse",
> -	.release = vduse_mgmtdev_release,
> -};
> -
>  static struct vdpa_mgmt_dev mgmt_dev;

Close.  This should be a pointer and the device structure within it
should control the lifecycle of that structure.  It should not be a
single static structure like this, that's very odd.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
