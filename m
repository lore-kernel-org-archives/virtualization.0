Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0B7C433EF
	for <virtualization@archiver.kernel.org>; Fri,  4 Mar 2022 07:08:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BC9A83E60;
	Fri,  4 Mar 2022 07:08:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8SKKOy5x7hVm; Fri,  4 Mar 2022 07:08:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0A6648329A;
	Fri,  4 Mar 2022 07:08:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B739EC001D;
	Fri,  4 Mar 2022 07:08:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1236C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 07:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9559C4011A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 07:08:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CxHz8MpdnkWE
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 07:08:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4E8EF400CC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Mar 2022 07:08:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 903F4B81EA6;
 Fri,  4 Mar 2022 07:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE489C36AE2;
 Fri,  4 Mar 2022 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646377690;
 bh=yQYBzWouNWOyD9zM5WtI9fIV8Tp/PcZjsK5VYT69gEM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G2dtgef9seu1rfUTmGaIXrWAUcOn2Gy1WhrcXurBrEpz4hhDxdQg7EuNpftnUXTtq
 JBjN5h0HVmLOkCA8JyqebsGSz1ffWON8GKhccz7Q5MuDxS0yeif3v1gVvhTo9iy6Z4
 Yw6NZHCj6bSAU0PEYw//6qnMTd2WRw8pJiHKGe6JiSFkn463dtBONTLAz/3Kg2qOg6
 AdlvY4hZkaePiNMTjfX3xpLCbwh6s4cGOiFALYCVSglUJl2L8ebgwYO1lzaPPco9Q0
 Vz3MokG1wkJrp38nUB/wBYXbGjM1z0dCF6Rn3lWXwku46vZjTmVwOoV0nx1hn+/02I
 9AGKhomxWLQYw==
Date: Fri, 4 Mar 2022 09:08:05 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held
 whilst clean-up in progress
Message-ID: <YiG61RqXFvq/t0fB@unreal>
References: <20220303151929.2505822-1-lee.jones@linaro.org>
 <YiETnIcfZCLb63oB@unreal>
 <20220303155645-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220303155645-mutt-send-email-mst@kernel.org>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Lee Jones <lee.jones@linaro.org>
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

On Thu, Mar 03, 2022 at 04:01:06PM -0500, Michael S. Tsirkin wrote:
> On Thu, Mar 03, 2022 at 09:14:36PM +0200, Leon Romanovsky wrote:
> > On Thu, Mar 03, 2022 at 03:19:29PM +0000, Lee Jones wrote:
> > > All workers/users should be halted before any clean-up should take place.
> > > 
> > > Suggested-by:  Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/vhost/vhost.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index bbaff6a5e21b8..d935d2506963f 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -693,6 +693,9 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > >  	int i;
> > >  
> > >  	for (i = 0; i < dev->nvqs; ++i) {
> > > +		/* Ideally all workers should be stopped prior to clean-up */
> > > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> > > +
> > >  		mutex_lock(&dev->vqs[i]->mutex);
> > 
> > I know nothing about vhost, but this construction and patch looks
> > strange to me.
> > 
> > If all workers were stopped, you won't need mutex_lock(). The mutex_lock
> > here suggests to me that workers can still run here.
> > 
> > Thanks
> 
> 
> "Ideally" here is misleading, we need a bigger detailed comment
> along the lines of:
> 
> /* 
>  * By design, no workers can run here. But if there's a bug and the
>  * driver did not flush all work properly then they might, and we
>  * encountered such bugs in the past.  With no proper flush guest won't
>  * work correctly but avoiding host memory corruption in this case
>  * sounds like a good idea.
>  */

This description looks better, but the check is inherently racy.
Why don't you add a comment and mutex_lock()? The WARN_ON here is
more distraction than actual help.

Thanks

> 
> > >  		if (dev->vqs[i]->error_ctx)
> > >  			eventfd_ctx_put(dev->vqs[i]->error_ctx);
> > > -- 
> > > 2.35.1.574.g5d30c73bfb-goog
> > > 
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
