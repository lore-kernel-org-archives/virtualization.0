Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21849C61DA3
	for <virtualization@archiver.kernel.org>; Thu, 26 Jan 2023 11:16:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8C7BE40C03;
	Thu, 26 Jan 2023 11:16:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C7BE40C03
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=brCnbvCw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oEJUALZNutQa; Thu, 26 Jan 2023 11:16:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E640F40124;
	Thu, 26 Jan 2023 11:16:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E640F40124
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC6A6C0032;
	Thu, 26 Jan 2023 11:16:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBE34C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 11:16:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 989FB81E2B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 11:16:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 989FB81E2B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com
 header.a=rsa-sha256 header.s=susede1 header.b=brCnbvCw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJHCkyKoYEnD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 11:16:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9777981446
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9777981446
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Jan 2023 11:16:37 +0000 (UTC)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E25A31FF65;
 Thu, 26 Jan 2023 11:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1674731794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VqvJ//mtxUzAL+qZwt9BocGJmjBDoQtWDsm6f0RHcJw=;
 b=brCnbvCw0yFj2KB2XLQOvhzBW6Pnv5+JFss008p+DODbsTxFtCHWxo09XShJcZe3aG8Xg8
 BfRTj2syQl/6yCyoMx/mZorf14W6aVLJvmfyfQs/BnHno/9Krlm5Qys3TD57sskrGWFsqp
 n7zaBtnzD4oinqFzvBdPIGyKD4DlvDY=
Received: from suse.cz (unknown [10.100.201.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B2CC52C141;
 Thu, 26 Jan 2023 11:16:34 +0000 (UTC)
Date: Thu, 26 Jan 2023 12:16:32 +0100
To: Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 2/2] vhost: check for pending livepatches from vhost
 worker kthreads
Message-ID: <Y9JhEJXFRDZjONAH@alley>
References: <20230120-vhost-klp-switching-v1-0-7c2b65519c43@kernel.org>
 <20230120-vhost-klp-switching-v1-2-7c2b65519c43@kernel.org>
 <Y8/ohzRGcOiqsh69@alley> <Y9ATo5FukOhphwqT@do-x1extreme>
 <Y9ETwsT4LTXyH/0m@alley> <Y9FfenH/p3qzRlar@do-x1extreme>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9FfenH/p3qzRlar@do-x1extreme>
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

On Wed 2023-01-25 10:57:30, Seth Forshee wrote:
> On Wed, Jan 25, 2023 at 12:34:26PM +0100, Petr Mladek wrote:
> > On Tue 2023-01-24 11:21:39, Seth Forshee wrote:
> > > On Tue, Jan 24, 2023 at 03:17:43PM +0100, Petr Mladek wrote:
> > > > On Fri 2023-01-20 16:12:22, Seth Forshee (DigitalOcean) wrote:
> > > > > Livepatch relies on stack checking of sleeping tasks to switch kthreads,
> > > > > so a busy kthread can block a livepatch transition indefinitely. We've
> > > > > seen this happen fairly often with busy vhost kthreads.
> > > > 
> > > > > --- a/drivers/vhost/vhost.c
> > > > > +++ b/drivers/vhost/vhost.c
> > > > > @@ -366,6 +367,9 @@ static int vhost_worker(void *data)
> > > > >  			if (need_resched())
> > > > >  				schedule();
> > > > >  		}
> > > > > +
> > > > > +		if (unlikely(klp_patch_pending(current)))
> > > > > +			klp_switch_current();
> > > > 
> > > > I suggest to use the following intead:
> > > > 
> > > > 		if (unlikely(klp_patch_pending(current)))
> > > > 			klp_update_patch_state(current);
> > > > 
> > > > We already use this in do_idle(). The reason is basically the same.
> > > > It is almost impossible to livepatch the idle task when a CPU is
> > > > very idle.
> > > > 
> > > > klp_update_patch_state(current) does not check the stack.
> > > > It switches the task immediately.
> > > > 
> > > > It should be safe because the kthread never leaves vhost_worker().
> > > > It means that the same kthread could never re-enter this function
> > > > and use the new code.
> > > 
> > > My knowledge of livepatching internals is fairly limited, so I'll accept
> > > it if you say that it's safe to do it this way. But let me ask about one
> > > scenario.
> > > 
> > > Let's say that a livepatch is loaded which replaces vhost_worker(). New
> > > vhost worker threads are started which use the replacement function. Now
> > > if the patch is disabled, these new worker threads would be switched
> > > despite still running the code from the patch module, correct? Could the
> > > module then be unloaded, freeing the memory containing the code these
> > > kthreads are executing?
> > 
> > The above scenario would require calling klp_update_patch_state() from
> > the code in the livepatch module. It is not possible at the moment because
> > this function is not exported for modules.
> 
> vhost can be built as a module, so in order to call
> klp_update_patch_state() from vhost_worker() it would have to be
> exported to modules.

I see.

> > Hmm, the same problem might be when we livepatch a function that calls
> > another function that calls klp_update_patch_state(). But in this case
> > it would be kthread() from kernel/kthread.c. It would affect any
> > running kthread. I doubt that anyone would seriously think about
> > livepatching this function.
> 
> Yes, there are clearly certain functions that are not safe/practical to
> patch, and authors need to know what they are doing. Most kthread main()
> functions probably qualify as impractical at best, at least without a
> strategy to restart relevant kthreads.
> 
> But a livepatch transition will normally stall if patching these
> functions when a relevant kthread is running (unless the patch is
> forced), so a patch author who made a mistake should quickly notice.
> vhost_worker() would behave differently.

Another crazy idea:

/**
 * klp_update_patch_state_safe() - do not update the path state when
 *	called from a livepatch.
 * @task: task_struct to be updated
 * @calller_addr: address of the function which  calls this one
 *
 * Do not update the patch set when called from a livepatch.
 * It would allow to remove the livepatch module even when
 * the code still might be in use.
 */
void klp_update_patch_state_safe(struct task_struct *task, void *caller_addr)
{
	static bool checked;
	static bool safe;

	if (unlikely(!checked)) {
		struct module *mod;

		preempt_disable();
		mod = __module_address(caller_addr);
		if (!mod || !is_livepatch_module(mod))
			safe = true;
		checked = true;
		preempt_enable();
	}

	if (safe)
		klp_update_patch_state(task);
}

and use in vhost_worker()

		if (unlikely(klp_patch_pending(current)))
			klp_update_patch_state_safe(current, vhost_worker);

Even better might be to get the caller address using some compiler
macro. I guess that it should be possible.

And even better would be to detect this at the compile time. But
I do not know how to do so.

> > A good enough solution might be to document this. Livepatches could
> > not be created blindly. There are more situations where the
> > livepatch is tricky or not possible at all.
> 
> I can add this if you like. Is Documentation/livepatch/livepatch.rst the
> right place for this?

Yes, the best place probably would be "7. Limitations" section in
Documentation/livepatch/livepatch.rst.

Even better would be to add a document about the best practices.
We have dreamed about it for years ;-)

> > Crazy idea. We could prevent this problem even technically. A solution
> > would be to increment a per-process counter in klp_ftrace_handler() when a
> > function is redirected(). And klp_update_patch_state() might refuse
> > the migration when this counter is not zero. But it would require
> > to use a trampoline on return that would decrement the counter.
> > I am not sure if this is worth the complexity.
> > 
> > One the other hand, this counter might actually remove the need
> > of the reliable backtrace. It is possible that I miss something
> > or that it is not easy/possible to implement the return trampoline.
> 
> I agree this should work for unpatching, and even for patching a
> function which is already patched.
> 
> Maybe I'm misunderstanding, but this would only work for unpatching or
> patching an already-patched function, wouldn't it? Because the original
> functions would not increment the counter so you would not know if tasks
> still had those on their call stacks.

Right. I knew that it could not be that easy. Otherwise, we would have
used it. I just did not spent enough cycles on the idea yesterday.

> > Back to the original problem. I still consider calling
> > klp_update_patch_state(current) in vhost_worker() safe.
> 
> Okay, I can send a v2 which does this, so long as it's okay to export
> klp_update_patch_state() to modules.

It would be acceptable for me if we added a warning above the function
definition and into the livepatch documentation.

But I would prefer klp_update_patch_state_safe() if it worked. It is
possible that I have missed something.

Best Regards,
Petr
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
