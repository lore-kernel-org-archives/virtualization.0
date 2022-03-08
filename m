Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F589C433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 11:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C736D41607;
	Tue,  8 Mar 2022 11:45:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id druUg8XKTTIn; Tue,  8 Mar 2022 11:45:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5BE5F415EF;
	Tue,  8 Mar 2022 11:45:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DAE3C0012;
	Tue,  8 Mar 2022 11:45:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 997B4C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:45:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 97A2082835
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8HNgLxjH6Wra
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:45:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE3E381000
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 11:45:24 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8C28B61677;
 Tue,  8 Mar 2022 11:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A4FC340EF;
 Tue,  8 Mar 2022 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1646739923;
 bh=oBE/zMen2HSeQ61tFkpIsOqX+zRcQylTYn4A2plQBms=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fnNU1DGAk8UP7tGvZNdQ9xso1j65GJzO6cQWnOgI5hwAnF7U6/tTfFm94k0Nla+7p
 clrhfifAkvV98p59qFtxBhNDmasMFmceGcGdcNcEWZnl3H+nxpEBzzB+albM8b+DGN
 0WSUNc4TwtDkyHejVx1Ixds8VWFHKPKWv1KCmZ4w=
Date: Tue, 8 Mar 2022 12:45:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/1] vhost: Protect the virtqueue from being cleared
 whilst still in use
Message-ID: <YidBz7SxED2ii1Lh@kroah.com>
References: <20220307191757.3177139-1-lee.jones@linaro.org>
 <YiZeB7l49KC2Y5Gz@kroah.com> <YicPXnNFHpoJHcUN@google.com>
 <Yicalf1I6oBytbse@kroah.com> <Yicer3yGg5rrdSIs@google.com>
 <YicolvcbY9VT6AKc@kroah.com>
 <20220308055003-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220308055003-mutt-send-email-mst@kernel.org>
Cc: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
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

On Tue, Mar 08, 2022 at 05:55:58AM -0500, Michael S. Tsirkin wrote:
> On Tue, Mar 08, 2022 at 10:57:42AM +0100, Greg KH wrote:
> > On Tue, Mar 08, 2022 at 09:15:27AM +0000, Lee Jones wrote:
> > > On Tue, 08 Mar 2022, Greg KH wrote:
> > > 
> > > > On Tue, Mar 08, 2022 at 08:10:06AM +0000, Lee Jones wrote:
> > > > > On Mon, 07 Mar 2022, Greg KH wrote:
> > > > > 
> > > > > > On Mon, Mar 07, 2022 at 07:17:57PM +0000, Lee Jones wrote:
> > > > > > > vhost_vsock_handle_tx_kick() already holds the mutex during its call
> > > > > > > to vhost_get_vq_desc().  All we have to do here is take the same lock
> > > > > > > during virtqueue clean-up and we mitigate the reported issues.
> > > > > > > 
> > > > > > > Also WARN() as a precautionary measure.  The purpose of this is to
> > > > > > > capture possible future race conditions which may pop up over time.
> > > > > > > 
> > > > > > > Link: https://syzkaller.appspot.com/bug?extid=279432d30d825e63ba00
> > > > > > > 
> > > > > > > Cc: <stable@vger.kernel.org>
> > > > > > > Reported-by: syzbot+adc3cb32385586bec859@syzkaller.appspotmail.com
> > > > > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > > > > ---
> > > > > > >  drivers/vhost/vhost.c | 10 ++++++++++
> > > > > > >  1 file changed, 10 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > > > > > index 59edb5a1ffe28..ef7e371e3e649 100644
> > > > > > > --- a/drivers/vhost/vhost.c
> > > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > > @@ -693,6 +693,15 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
> > > > > > >  	int i;
> > > > > > >  
> > > > > > >  	for (i = 0; i < dev->nvqs; ++i) {
> > > > > > > +		/* No workers should run here by design. However, races have
> > > > > > > +		 * previously occurred where drivers have been unable to flush
> > > > > > > +		 * all work properly prior to clean-up.  Without a successful
> > > > > > > +		 * flush the guest will malfunction, but avoiding host memory
> > > > > > > +		 * corruption in those cases does seem preferable.
> > > > > > > +		 */
> > > > > > > +		WARN_ON(mutex_is_locked(&dev->vqs[i]->mutex));
> > > > > > 
> > > > > > So you are trading one syzbot triggered issue for another one in the
> > > > > > future?  :)
> > > > > > 
> > > > > > If this ever can happen, handle it, but don't log it with a WARN_ON() as
> > > > > > that will trigger the panic-on-warn boxes, as well as syzbot.  Unless
> > > > > > you want that to happen?
> > > > > 
> > > > > No, Syzbot doesn't report warnings, only BUGs and memory corruption.
> > > > 
> > > > Has it changed?  Last I looked, it did trigger on WARN_* calls, which
> > > > has resulted in a huge number of kernel fixes because of that.
> > > 
> > > Everything is customisable in syzkaller, so maybe there are specific
> > > builds which panic_on_warn enabled, but none that I'm involved with
> > > do.
> > 
> > Many systems run with panic-on-warn (i.e. the cloud), as they want to
> > drop a box and restart it if anything goes wrong.
> > 
> > That's why syzbot reports on WARN_* calls.  They should never be
> > reachable by userspace actions.
> > 
> > > Here follows a topical example.  The report above in the Link: tag
> > > comes with a crashlog [0].  In there you can see the WARN() at the
> > > bottom of vhost_dev_cleanup() trigger many times due to a populated
> > > (non-flushed) worker list, before finally tripping the BUG() which
> > > triggers the report:
> > > 
> > > [0] https://syzkaller.appspot.com/text?tag=CrashLog&x=16a61fce700000
> > 
> > Ok, so both happens here.  But don't add a warning for something that
> > can't happen.  Just handle it and move on.  It looks like you are
> > handling it in this code, so please drop the WARN_ON().
> > 
> > thanks,
> > 
> > greg k-h
> 
> Hmm. Well this will mean if we ever reintroduce the bug then
> syzkaller will not catch it for us :( And the bug is there,
> it just results in a hard to reproduce error for userspace.

Is this an error you can recover from in the kernel?  What is userspace
supposed to know with this information when it sees it?

> Not sure what to do here. Export panic_on_warn flag to modules
> and check it here?

Hah, no, never do that :)

thanks,

greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
