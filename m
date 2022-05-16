Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63214C433F5
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 06:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 021024011D;
	Mon, 16 May 2022 06:21:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eo1RrLfwRRVb; Mon, 16 May 2022 06:21:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9ACE740148;
	Mon, 16 May 2022 06:21:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 691D7C0032;
	Mon, 16 May 2022 06:21:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8121DC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 695D1812FE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:21:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A8TIFjFtk2KO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:21:30 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 511648128F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:21:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id 10395CE1047;
 Mon, 16 May 2022 06:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECD1C385AA;
 Mon, 16 May 2022 06:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652681616;
 bh=WsHiSw3wi94yAeuQMFRuzTaGuW1wgereK3pwDUGl5BU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nBhMZYPypXC4gYBgge5DjDqACvx6qCXc4ZMpt8Y5v17+6OPOPeB8XK7JYgNmRGzFJ
 7hfSgbh/7bVphNebWABEhC6DpWs6Bgb5L7rIEHV3V60Z5PnUg2a4D9r5YD21O9xoNy
 Gn7QsJX6V5G3VF+YWJVdy21XRsW1n4DF0BALArDo=
Date: Mon, 16 May 2022 08:13:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 1/3] vduse: Pass management device pointer to
 vduse_dev_init_vdpa()
Message-ID: <YoHrjF3leYdTOs9q@kroah.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220516060342.106-1-xieyongji@bytedance.com>
Cc: mst@redhat.com, virtualization@lists.linux-foundation.org, elic@nvidia.com,
 lingshan.zhu@intel.com
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

On Mon, May 16, 2022 at 02:03:40PM +0800, Xie Yongji wrote:
> Pass management device pointer from vdpa_dev_add() to
> vduse_dev_init_vdpa() rather than using the static
> variable directly.
> 
> No functional change.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 160e40d03084..d3bf55a58cd2 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1484,9 +1484,8 @@ static struct device vduse_mgmtdev = {
>  	.release = vduse_mgmtdev_release,
>  };
>  
> -static struct vdpa_mgmt_dev mgmt_dev;
> -
> -static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
> +static int vduse_dev_init_vdpa(struct vduse_dev *dev,
> +			       struct vdpa_mgmt_dev *mdev, const char *name)
>  {
>  	struct vduse_vdpa *vdev;
>  	int ret;
> @@ -1509,7 +1508,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  	}
>  	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
>  	vdev->vdpa.dma_dev = &vdev->vdpa.dev;
> -	vdev->vdpa.mdev = &mgmt_dev;
> +	vdev->vdpa.mdev = mdev;
>  
>  	return 0;
>  }
> @@ -1526,7 +1525,7 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>  		mutex_unlock(&vduse_lock);
>  		return -EINVAL;
>  	}
> -	ret = vduse_dev_init_vdpa(dev, name);
> +	ret = vduse_dev_init_vdpa(dev, mdev, name);
>  	mutex_unlock(&vduse_lock);
>  	if (ret)
>  		return ret;
> -- 
> 2.20.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
