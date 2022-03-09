Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D243C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 18:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 067F4611A5;
	Wed,  9 Mar 2022 18:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VLe2ucJV4uzq; Wed,  9 Mar 2022 18:52:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B55E60F85;
	Wed,  9 Mar 2022 18:52:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70819C001D;
	Wed,  9 Mar 2022 18:52:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B83A6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 18:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A76CB416C7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 18:52:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVnGTHTABJ-W
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 18:52:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8C53416C4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 18:52:19 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 94242617B2;
 Wed,  9 Mar 2022 18:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C080C340E8;
 Wed,  9 Mar 2022 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646851938;
 bh=+DArKuMQB9BQkZlj+Yn2vhSYyPx0dFjihiD/ugKfs0c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pNwOz/O350LawkZ11VLNBaL29p5mLGQfBB9ek/jPonM2muArkMoSvGSE2iq+2g12I
 /nqelezUJclPT0eBHTnJmhXU1OqI+YF6Qcl9VhqiM75nq9nOXWVdaRfYTT/Gr6IzSk
 H1U2gADjw9Z4EXphZxYh7qe4CIlRg8louWTLmzdaSNr4SF5WIpBooX1lVRvC9zNzSu
 KDoNnpgnaS2sSB0TBKejk5kYdEJOBkBuejNt0/vQM5o2mfJEHtXtBp99L9LU9mHDjg
 6dfRL012U0mlSinfdHoag68biryeVsHI4846od/XzU7Gg7r66SOwpphjJ8se5mWsdk
 j5pebiOooB5tA==
Date: Wed, 9 Mar 2022 20:52:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <Yij3XqLpOu18Kw8A@unreal>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
 <Yicalf1I6oBytbse@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yicalf1I6oBytbse@kroah.com>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Lee Jones <lee.jones@linaro.org>
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

On Tue, Mar 08, 2022 at 09:57:57AM +0100, Greg KH wrote:
> On Tue, Mar 08, 2022 at 08:10:06AM +0000, Lee Jones wrote:
> > On Mon, 07 Mar 2022, Greg KH wrote:
> > 
> > > On Mon, Mar 07, 2022 at 07:17:57PM +0000, Lee Jones wrote:
> > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > > > to vhost_get_vq_desc().  All we have to do here is take the same lock
> > > > during virtqueue clean-up and we mitigate the reported issues.
> > > > 
> > > > Also WARN() as a precautionary measure.  The purpose of this is to
> > > > capture possible future race conditions which may pop up over time.
> > > > 
> > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > > > 
> > > > Cc: <stable@vger.kernel.org>
> > > > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/vhost/vhost.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > 
> > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > index 59edb5a1ffe28..ef7e371e3e649 100644
> > > > --- a/drivers/vhost/vhost.c
> > > > +++ b/drivers/vhost/vhost.c
> > > > @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > >  	int i;
> > > >  
> > > >  	for (i = 0; i < dev->nvqs; ++i) {
> > > > +		/* No workers should run here by design. However, races have
> > > > +		 * previously occurred where drivers have been unable to flush
> > > > +		 * all work properly prior to clean-up.  Without a successful
> > > > +		 * flush the guest will malfunction, but avoiding host memory
> > > > +		 * corruption in those cases does seem preferable.
> > > > +		 */
> > > > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> > > 
> > > So you are trading one syzbot triggered issue for another one in the
> > > future?  :)
> > > 
> > > If this ever can happen, handle it, but don't log it with a WARN_ON() as
> > > that will trigger the panic-on-warn boxes, as well as syzbot.  Unless
> > > you want that to happen?
> > 
> > No, Syzbot doesn't report warnings, only BUGs and memory corruption.
> 
> Has it changed?  Last I looked, it did trigger on WARN_* calls, which
> has resulted in a huge number of kernel fixes because of that.
> 
> > > And what happens if the mutex is locked _RIGHT_ after you checked it?
> > > You still have a race...
> > 
> > No, we miss a warning that one time.  Memory is still protected.
> 
> Then don't warn on something that doesn't matter.  This line can be
> dropped as there's nothing anyone can do about it, right?

Greg, at least two other reviewers said that this line shouldn't be at
all.

https://lore.kernel.org/all/CACGkMEsjmCNQPjxPjXL0WUfbMg8ARnumEp4yjUxqznMKR1nKSQ@mail.gmail.com/
https://lore.kernel.org/all/YiG61RqXFvq%2Ft0fB@unreal/
https://lore.kernel.org/all/YiETnIcfZCLb63oB@unreal/

Thanks

> 
> thanks,
> 
> greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
