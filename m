Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34436C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 06:31:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D441C40129;
	Tue, 26 Apr 2022 06:31:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qi8SaPegPGLM; Tue, 26 Apr 2022 06:31:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7134640204;
	Tue, 26 Apr 2022 06:31:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4518EC0039;
	Tue, 26 Apr 2022 06:31:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC55CC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8C9E40204
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:31:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZrkUmk0s5Mgi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:31:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 88D2640129
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:31:11 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4F2E9B81C17;
 Tue, 26 Apr 2022 06:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1FEC385A0;
 Tue, 26 Apr 2022 06:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650954667;
 bh=lqnrpEKQOuMfPH6GYY28U3wO31/9OTEThTe0MnNEy5o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pIj8NAqg/sK+08dG8EFPLS5kS/frmEbKdv04qO2pChL23Cyb1UchYz8zHvVzJzoR+
 uAKiNqJ3uyF5tFkClIWrdZSsAuHZO6opu/lsoMd8Om9yBnLqe4ekJ1SkZSJrgmVxiV
 yxAzSIVuyOjfYLZVf5Pt6OCVruh5y8/Axh2e2AUU=
Date: Tue, 26 Apr 2022 08:31:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] vduse: Fix NULL pointer dereference on sysfs access
Message-ID: <YmeRp87WgjC9Bjr+@kroah.com>
References: <20220426060103.104-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220426060103.104-1-xieyongji@bytedance.com>
Cc: mst@redhat.com, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mcgrof@kernel.org,
 oliver.sang@intel.com, akpm@linux-foundation.org
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

On Tue, Apr 26, 2022 at 02:01:03PM +0800, Xie Yongji wrote:
> The control device has no drvdata. So we will get a NULL
> NULL pointer dereference when accessing control device's
> msg_timeout via sysfs:
> 
> [ 132.841881][ T3644] BUG: kernel NULL pointer dereference, address: 00000000000000f8
> [ 132.850619][ T3644] RIP: 0010:msg_timeout_show (drivers/vdpa/vdpa_user/vduse_dev.c:1271)
> [ 132.869447][ T3644] dev_attr_show (drivers/base/core.c:2094)
> [ 132.870215][ T3644] sysfs_kf_seq_show (fs/sysfs/file.c:59)
> [ 132.871164][ T3644] ? device_remove_bin_file (drivers/base/core.c:2088)
> [ 132.872082][ T3644] kernfs_seq_show (fs/kernfs/file.c:164)
> [ 132.872838][ T3644] seq_read_iter (fs/seq_file.c:230)
> [ 132.873578][ T3644] ? __vmalloc_area_node (mm/vmalloc.c:3041)
> [ 132.874532][ T3644] kernfs_fop_read_iter (fs/kernfs/file.c:238)
> [ 132.875513][ T3644] __kernel_read (fs/read_write.c:440 (discriminator 1))
> [ 132.876319][ T3644] kernel_read (fs/read_write.c:459)
> [ 132.877129][ T3644] kernel_read_file (fs/kernel_read_file.c:94)
> [ 132.877978][ T3644] kernel_read_file_from_fd (include/linux/file.h:45 fs/kernel_read_file.c:186)
> [ 132.879019][ T3644] __do_sys_finit_module (kernel/module.c:4207)
> [ 132.879930][ T3644] __ia32_sys_finit_module (kernel/module.c:4189)
> [ 132.880930][ T3644] do_int80_syscall_32 (arch/x86/entry/common.c:112 arch/x86/entry/common.c:132)
> [ 132.881847][ T3644] entry_INT80_compat (arch/x86/entry/entry_64_compat.S:419)
> 
> To fix it, let's add a NULL check in msg_timeout_show() and
> msg_timeout_store().
> 
> Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index f85d1a08ed87..f1c42f4aabb4 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1268,6 +1268,9 @@ static ssize_t msg_timeout_show(struct device *device,
>  {
>  	struct vduse_dev *dev = dev_get_drvdata(device);
>  
> +	if (!dev)
> +		return -EPERM;
> +
>  	return sysfs_emit(buf, "%u\n", dev->msg_timeout);

What prevents the pointer from going away right after you checked it if
this is something that changes over time?

If this attribute is never going to be valid for this device, just do
not create it.

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
