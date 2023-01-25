Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 560DCC27C76
	for <virtualization@archiver.kernel.org>; Wed, 25 Jan 2023 11:34:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCEF482041;
	Wed, 25 Jan 2023 11:34:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCEF482041
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=pTPV48cc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m06VeGxF_KTx; Wed, 25 Jan 2023 11:34:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BCFA82044;
	Wed, 25 Jan 2023 11:34:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BCFA82044
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F039BC0033;
	Wed, 25 Jan 2023 11:34:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16821C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 11:34:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E590C60F95
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 11:34:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E590C60F95
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=pTPV48cc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dvo75ZGytQWT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 11:34:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D9B760F54
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D9B760F54
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Jan 2023 11:34:31 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 26FFB1FD87;
 Wed, 25 Jan 2023 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674646469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l49gqrR00YStom+4XbW1P7OXxNNfJs2Zagbrz3cxZDY=;
 b=pTPV48ccsT35BHMOK1sMKdn9C2GwooatjjrH9AG3y4DLkRYKxLgTungIRgVixtSoT/oTI7
 woGGottIqQtagTebAP0C3aYeI+CJUFAZI+E8AKxN9K2BTe+2UjhTJJIVLyw/f4/HVOHl/Y
 BaQIEOw585ptaepsLrRy58308FjTRts=
Received: from suse.cz (unknown [10.100.201.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0223E2C141;
 Wed, 25 Jan 2023 11:34:28 +0000 (UTC)
Date: Wed, 25 Jan 2023 12:34:26 +0100
To: Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 2/2] vhost: check for pending livepatches from vhost
 worker kthreads
Message-ID: <Y9ETwsT4LTXyH/0m@alley>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
 <20230120-vhost-klp-switching-v1-2-7c2b65519c43@kernel.org>
 <Y8/ohzRGcOiqsh69@alley> <Y9ATo5FukOhphwqT@do-x1extreme>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9ATo5FukOhphwqT@do-x1extreme>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, live-patching@vger.kernel.org,
 Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>
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
From: Petr Mladek via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue 2023-01-24 11:21:39, Seth Forshee wrote:
> On Tue, Jan 24, 2023 at 03:17:43PM +0100, Petr Mladek wrote:
> > On Fri 2023-01-20 16:12:22, Seth Forshee (DigitalOcean) wrote:
> > > Livepatch relies on stack checking of sleeping tasks to switch kthreads,
> > > so a busy kthread can block a livepatch transition indefinitely. We've
> > > seen this happen fairly often with busy vhost kthreads.
> > 
> > To be precise, it would be "indefinitely" only when the kthread never
> > sleeps.
> > 
> > But yes. I believe that the problem is real. It might be almost
> > impossible to livepatch some busy kthreads, especially when they
> > have a dedicated CPU.
> > 
> > 
> > > Add a check to call klp_switch_current() from vhost_worker() when a
> > > livepatch is pending. In testing this allowed vhost kthreads to switch
> > > immediately when they had previously blocked livepatch transitions for
> > > long periods of time.
> > > 
> > > Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> > > ---
> > >  drivers/vhost/vhost.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> > > index cbe72bfd2f1f..d8624f1f2d64 100644
> > > --- a/drivers/vhost/vhost.c
> > > +++ b/drivers/vhost/vhost.c
> > > @@ -366,6 +367,9 @@ static int vhost_worker(void *data)
> > >  			if (need_resched())
> > >  				schedule();
> > >  		}
> > > +
> > > +		if (unlikely(klp_patch_pending(current)))
> > > +			klp_switch_current();
> > 
> > I suggest to use the following intead:
> > 
> > 		if (unlikely(klp_patch_pending(current)))
> > 			klp_update_patch_state(current);
> > 
> > We already use this in do_idle(). The reason is basically the same.
> > It is almost impossible to livepatch the idle task when a CPU is
> > very idle.
> > 
> > klp_update_patch_state(current) does not check the stack.
> > It switches the task immediately.
> > 
> > It should be safe because the kthread never leaves vhost_worker().
> > It means that the same kthread could never re-enter this function
> > and use the new code.
> 
> My knowledge of livepatching internals is fairly limited, so I'll accept
> it if you say that it's safe to do it this way. But let me ask about one
> scenario.
> 
> Let's say that a livepatch is loaded which replaces vhost_worker(). New
> vhost worker threads are started which use the replacement function. Now
> if the patch is disabled, these new worker threads would be switched
> despite still running the code from the patch module, correct? Could the
> module then be unloaded, freeing the memory containing the code these
> kthreads are executing?

Great catch! Yes, this might theoretically happen.

The above scenario would require calling klp_update_patch_state() from
the code in the livepatch module. It is not possible at the moment because
this function is not exported for modules.

Hmm, the same problem might be when we livepatch a function that calls
another function that calls klp_update_patch_state(). But in this case
it would be kthread() from kernel/kthread.c. It would affect any
running kthread. I doubt that anyone would seriously think about
livepatching this function.

A good enough solution might be to document this. Livepatches could
not be created blindly. There are more situations where the
livepatch is tricky or not possible at all.

Crazy idea. We could prevent this problem even technically. A solution
would be to increment a per-process counter in klp_ftrace_handler() when a
function is redirected(). And klp_update_patch_state() might refuse
the migration when this counter is not zero. But it would require
to use a trampoline on return that would decrement the counter.
I am not sure if this is worth the complexity.

One the other hand, this counter might actually remove the need
of the reliable backtrace. It is possible that I miss something
or that it is not easy/possible to implement the return trampoline.


Back to the original problem. I still consider calling
klp_update_patch_state(current) in vhost_worker() safe.

Best Regards,
Petr
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
