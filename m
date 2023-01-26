Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81EA8C61DA3
	for <virtualization@archiver.kernel.org>; Thu, 26 Jan 2023 11:49:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E1834418C3;
	Thu, 26 Jan 2023 11:49:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E1834418C3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=PFl31Vyw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9re_cv7V-8bW; Thu, 26 Jan 2023 11:49:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4A79418DA;
	Thu, 26 Jan 2023 11:49:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E4A79418DA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5B5AC0032;
	Thu, 26 Jan 2023 11:49:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF4EEC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 11:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ABFA40919
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 11:49:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9ABFA40919
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=PFl31Vyw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9075DVRAL-DS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 11:49:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1BC4C40124
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1BC4C40124
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 11:49:27 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5E8441FF3F;
 Thu, 26 Jan 2023 11:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674733765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XxsY7YJivcVXv/JzbSrqly22j3+hrQ/gP/mZJ85hOmM=;
 b=PFl31VywpTHBZGWIgd9uRk3v2XHk0OLkw48lxQB/Gf3mKcK58iqtZ3FZUImQd8Nyga0fYC
 I05ylbJXSO1YY7P958zJ2LoobK/Eawt+RRMwuU1lwWEjpe2OrTfaHDDtPazu5rH1A6XY3E
 N8Jrtmby4uUXUY6wJs3SPw1ZmNSAW9g=
Received: from suse.cz (unknown [10.100.208.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3A4912C141;
 Thu, 26 Jan 2023 11:49:25 +0000 (UTC)
Date: Thu, 26 Jan 2023 12:49:24 +0100
To: Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 2/2] vhost: check for pending livepatches from vhost
 worker kthreads
Message-ID: <Y9JoxAHLplZoVPea@alley>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
 <20230120-vhost-klp-switching-v1-2-7c2b65519c43@kernel.org>
 <Y8/ohzRGcOiqsh69@alley> <Y9ATo5FukOhphwqT@do-x1extreme>
 <Y9ETwsT4LTXyH/0m@alley> <Y9FfenH/p3qzRlar@do-x1extreme>
 <Y9JhEJXFRDZjONAH@alley>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9JhEJXFRDZjONAH@alley>
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

On Thu 2023-01-26 12:16:36, Petr Mladek wrote:
> On Wed 2023-01-25 10:57:30, Seth Forshee wrote:
> > On Wed, Jan 25, 2023 at 12:34:26PM +0100, Petr Mladek wrote:
> > > On Tue 2023-01-24 11:21:39, Seth Forshee wrote:
> > > > On Tue, Jan 24, 2023 at 03:17:43PM +0100, Petr Mladek wrote:
> > > > > On Fri 2023-01-20 16:12:22, Seth Forshee (DigitalOcean) wrote:
> > > > > > Livepatch relies on stack checking of sleeping tasks to switch kthreads,
> > > > > > so a busy kthread can block a livepatch transition indefinitely. We've
> > > > > > seen this happen fairly often with busy vhost kthreads.
> > > > > 
> > > > > > --- a/drivers/vhost/vhost.c
> > > > > > +++ b/drivers/vhost/vhost.c
> > > > > > @@ -366,6 +367,9 @@ static int vhost_worker(void *data)
> > > > > >  			if (need_resched())
> > > > > >  				schedule();
> > > > > >  		}
> > > > > > +
> > > > > > +		if (unlikely(klp_patch_pending(current)))
> > > > > > +			klp_switch_current();
> > > > > 
> > > > > I suggest to use the following intead:
> > > > > 
> > > > > 		if (unlikely(klp_patch_pending(current)))
> > > > > 			klp_update_patch_state(current);
> > > > > 
> > > > > We already use this in do_idle(). The reason is basically the same.
> > > > > It is almost impossible to livepatch the idle task when a CPU is
> > > > > very idle.
> > > > > 
> > > > Let's say that a livepatch is loaded which replaces vhost_worker(). New
> > > > vhost worker threads are started which use the replacement function. Now
> > > > if the patch is disabled, these new worker threads would be switched
> > > > despite still running the code from the patch module, correct? Could the
> > > > module then be unloaded, freeing the memory containing the code these
> > > > kthreads are executing?
> > > 
> > > Hmm, the same problem might be when we livepatch a function that calls
> > > another function that calls klp_update_patch_state(). But in this case
> > > it would be kthread() from kernel/kthread.c. It would affect any
> > > running kthread. I doubt that anyone would seriously think about
> > > livepatching this function.

And I missed something. klp_update_patch_state_safe(), proposed below,
would not cover the above scenario.

It might be possible to add something similar to kthread()
function. I think that it is the only "livepatchable" function
that might call vhost_worker(). We could block
klp_update_patch_state() for the entire kthread when the kthread()
function is called from a livepatch.

Well, it is all just the best effort. The reference counting in
the ftrace handler would be more reliable. But it would require
adding the trampoline on the return.

> /**
>  * klp_update_patch_state_safe() - do not update the path state when
>  *	called from a livepatch.
>  * @task: task_struct to be updated
>  * @calller_addr: address of the function which  calls this one
>  *
>  * Do not update the patch set when called from a livepatch.
>  * It would allow to remove the livepatch module even when
>  * the code still might be in use.
>  */
> void klp_update_patch_state_safe(struct task_struct *task, void *caller_addr)
> {
> 	static bool checked;
> 	static bool safe;
> 
> 	if (unlikely(!checked)) {
> 		struct module *mod;
> 
> 		preempt_disable();
> 		mod = __module_address(caller_addr);
> 		if (!mod || !is_livepatch_module(mod))
> 			safe = true;
> 		checked = true;
> 		preempt_enable();
> 	}
> 
> 	if (safe)
> 		klp_update_patch_state(task);
> }
> 
> and use in vhost_worker()
> 
> 		if (unlikely(klp_patch_pending(current)))
> 			klp_update_patch_state_safe(current, vhost_worker);
> 
> Even better might be to get the caller address using some compiler
> macro. I guess that it should be possible.
> 
> And even better would be to detect this at the compile time. But
> I do not know how to do so.
> 
> > Okay, I can send a v2 which does this, so long as it's okay to export
> > klp_update_patch_state() to modules.
> 
> It would be acceptable for me if we added a warning above the function
> definition and into the livepatch documentation.

I would probably go this way after all. Still thinking...

Best Regards,
Petr
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
