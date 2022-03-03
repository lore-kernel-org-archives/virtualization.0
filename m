Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB59C4332F
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 19:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 54426403CF;
	Thu,  3 Mar 2022 19:14:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hJRH280VtQ7v; Thu,  3 Mar 2022 19:14:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C379F40154;
	Thu,  3 Mar 2022 19:14:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 95CF3C0012;
	Thu,  3 Mar 2022 19:14:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A3B03C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 19:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D66840162
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 19:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vatN1WWfLQUQ
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 19:14:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 879C740154
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 19:14:44 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id B1542B82684;
 Thu,  3 Mar 2022 19:14:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1002AC004E1;
 Thu,  3 Mar 2022 19:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646334880;
 bh=65NU4OmMIt5EFn/vNTZOvIr2kIZ0haZ0h8eEAdsZw8s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CrAUGcfsum5yXJwnDJdL4zllI0l2ylsQSR7U5pCNZe8w5kgnKsF08bzWOVxktO+AP
 96IZy37imHsp+qYWFVm6A2v+Hu7BfOCpM/xsSQ0rLGpCm1VvIlW8QAq8jbupsDCmRM
 qRX/AnILHatxBU9fx7kFIP43wqQ6Q/1KlngSluUam4I++GMKD6HISZ4UoXD8dHlGNC
 Fyqspnfc8YAOa+LecnLTm7owS+UIV5AfkNCBiIjlXJoaqEw8+Drnq3LV9JgYPco3s7
 uNEvfZXnLqux6soIBRzrSrX5VQ7SkTe8zeU2Wl1+OZ/pTCESk41cmMjy4Yt2yDiy3k
 Bvo2g/t8Z1dxg==
Date: Thu, 3 Mar 2022 21:14:36 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held
 whilst clean-up in progress
Message-ID: <YiETnIcfZCLb63oB@unreal>
References: <20220303151929.2505822-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220303151929.2505822-1-lee.jones@linaro.org>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Thu, Mar 03, 2022 at 03:19:29PM +0000, Lee Jones wrote:
> All workers/users should be halted before any clean-up should take place.
> 
> Suggested-by:  Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/vhost/vhost.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index bbaff6a5e21b8..d935d2506963f 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -693,6 +693,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
>  	int i;
>  
>  	for (i = 0; i < dev->nvqs; ++i) {
> +		/* Ideally all workers should be stopped prior to clean-up */
> +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> +
>  		mutex_lock(&dev->vqs[i]->mutex);

I know nothing about vhost, but this construction and patch looks
strange to me.

If all workers were stopped, you won't need mutex_lock(). The mutex_lock
here suggests to me that workers can still run here.

Thanks

>  		if (dev->vqs[i]->error_ctx)
>  			eventfd_ctx_put(dev->vqs[i]->error_ctx);
> -- 
> 2.35.1.574.g5d30c73bfb-goog
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
