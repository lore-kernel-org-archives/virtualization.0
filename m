Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBA9C433F5
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 06:14:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E40CD60DDF;
	Mon, 16 May 2022 06:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OUKVo1FQRKie; Mon, 16 May 2022 06:14:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8211F60A46;
	Mon, 16 May 2022 06:14:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56C6DC0032;
	Mon, 16 May 2022 06:14:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C7D0C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:14:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 04D3840364
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:14:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MBfRadxO97BI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:14:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A33B64011D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 06:14:16 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DF9D6B80B48;
 Mon, 16 May 2022 06:14:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46ECEC385B8;
 Mon, 16 May 2022 06:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652681653;
 bh=ab3eEGJB9uefOEURnNplTjvDpQ/KhtB3KCKpl0zehRk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=zAh9j8mqzrpzeqwNpmNJJnYInkvpLgPV81J+nIaE7i6hcMCy9JchruxBTRWrI+JKf
 Z2CeBASwGZRSWL4Qce8triuB+Wq04F+n9xM6ThtPX4fvYhHnedeLn2+tgYAGRHtHk4
 qsJr3eQHi0mF8uof74SlhqxjdIXHMvu9p9tHY08o=
Date: Mon, 16 May 2022 08:14:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 3/3] Docs/ABI/testing: Add VDUSE sysfs interface ABI
 document
Message-ID: <YoHrsVWsLZtJSLDc@kroah.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-3-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220516060342.106-3-xieyongji@bytedance.com>
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

On Mon, May 16, 2022 at 02:03:42PM +0800, Xie Yongji wrote:
> This adds missing documentation for VDUSE sysfs interface ABI
> under Documentation/ABI/testing.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  Documentation/ABI/testing/sysfs-class-vduse | 33 +++++++++++++++++++++
>  MAINTAINERS                                 |  1 +
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-vduse
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-vduse b/Documentation/ABI/testing/sysfs-class-vduse
> new file mode 100644
> index 000000000000..2f2bc5c8fc48
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-vduse
> @@ -0,0 +1,33 @@
> +What:		/sys/class/vduse/
> +Date:		Oct 2021
> +KernelVersion:	5.15
> +Contact:	Yongji Xie <xieyongji@bytedance.com>
> +Description:
> +		The vduse/ class sub-directory belongs to the VDUSE
> +		framework and provides a sysfs interface for configuring
> +		VDUSE devices.
> +
> +What:		/sys/class/vduse/control/
> +Date:		Oct 2021
> +KernelVersion:	5.15
> +Contact:	Yongji Xie <xieyongji@bytedance.com>
> +Description:
> +		This directory entry is created for the control device
> +		of VDUSE framework.
> +
> +What:		/sys/class/vduse/<device-name>/
> +Date:		Oct 2021
> +KernelVersion:	5.15
> +Contact:	Yongji Xie <xieyongji@bytedance.com>
> +Description:
> +		This directory entry is created when a VDUSE device is
> +		created via the control device.
> +
> +What:		/sys/class/vduse/<device-name>/msg_timeout
> +Date:		Oct 2021
> +KernelVersion:	5.15
> +Contact:	Yongji Xie <xieyongji@bytedance.com>
> +Description:
> +		(RW) The timeout (in seconds) for waiting for the control
> +		message's response from userspace. Default value is 30s.
> +		Writing a '0' to the file means to disable the timeout.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d6d879cb0afd..d9a423de2f4d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20842,6 +20842,7 @@ M:	Jason Wang <jasowang@redhat.com>
>  L:	virtualization@lists.linux-foundation.org
>  S:	Maintained
>  F:	Documentation/ABI/testing/sysfs-bus-vdpa
> +F:	Documentation/ABI/testing/sysfs-class-vduse
>  F:	Documentation/devicetree/bindings/virtio/
>  F:	drivers/block/virtio_blk.c
>  F:	drivers/crypto/virtio/
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
