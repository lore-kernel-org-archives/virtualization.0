Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC60AC433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 06:14:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3002540491;
	Mon, 16 May 2022 06:14:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Er5OTcf4zqij; Mon, 16 May 2022 06:14:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 47D2940274;
	Mon, 16 May 2022 06:14:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F8A2C0032;
	Mon, 16 May 2022 06:14:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BE2AC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 19750402F6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GqL-ZNBaWmeg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:14:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 604B540274
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:14:04 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5750FB80B46;
 Mon, 16 May 2022 06:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E56DC385AA;
 Mon, 16 May 2022 06:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652681640;
 bh=6fq8O5Ly0QSSfruMnibdmoSGWziOLJKOOia4lDYzOnY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=noaEmlaYCa5aEwjVMJ8pQFqsTp/Vslzduw0yD0aj55TUtAHrnkEp95hVFw00QR4uN
 T+4DWRqqNP07lnzpXTrqVbp9wLeG0ixHw7JW6FW3Ss0hLN4y9ejz8G7aPI3fjW107i
 aJK30KSjrJuLDXghJngA4RSsILZ6/LxpHVzZgvVA=
Date: Mon, 16 May 2022 08:13:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Message-ID: <YoHrpNeglOa7lBP5@kroah.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220516060342.106-2-xieyongji@bytedance.com>
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

On Mon, May 16, 2022 at 02:03:41PM +0800, Xie Yongji wrote:
> Introduce a device object for vdpa management device to control
> its lifecycle. And the device name will be used to match
> VDPA_ATTR_MGMTDEV_DEV_NAME field of netlink message rather than
> using parent device name.
> 
> With this patch applied, drivers should use vdpa_mgmtdev_alloc()
> or _vdpa_mgmtdev_alloc() to allocate a vDPA management device
> before calling vdpa_mgmtdev_register(). And some buggy empty
> release function can also be removed from the driver codes.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c      | 11 ++--
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    | 11 ++--
>  drivers/vdpa/vdpa.c                  | 92 ++++++++++++++++++++++++----
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 39 ++++--------
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 46 +++++---------
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 38 ++++--------
>  include/linux/vdpa.h                 | 38 +++++++++++-
>  7 files changed, 168 insertions(+), 107 deletions(-)
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
