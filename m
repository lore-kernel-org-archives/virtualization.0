Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19F32C7EE2E
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 15:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9A8CC40B13;
	Tue, 23 May 2023 15:57:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9A8CC40B13
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K4NiUB-qyxDH; Tue, 23 May 2023 15:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ED15C4020B;
	Tue, 23 May 2023 15:57:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED15C4020B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5892C0036;
	Tue, 23 May 2023 15:57:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64306C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 15:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2B7F240646
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 15:57:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2B7F240646
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QP1DA1JuE9zo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 15:57:15 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0D5B14020B
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0D5B14020B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 15:57:14 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52]:43398)
 by out02.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q1UNt-005YDB-2I; Tue, 23 May 2023 09:57:13 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:48834
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q1UNr-008Meo-P3; Tue, 23 May 2023 09:57:12 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
Date: Tue, 23 May 2023 10:57:04 -0500
In-Reply-To: <20230523121506.GA6562@redhat.com> (Oleg Nesterov's message of
 "Tue, 23 May 2023 14:15:06 +0200")
Message-ID: <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1q1UNr-008Meo-P3; ; ;
 mid=<87bkib6nxr.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX1/ZYI+rgtjgtOjfAlPhkboPTJIRJCH5jOE=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com, linux@leemhuis.info,
 linux-kernel@vger.kernel.org, stefanha@redhat.com, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org, torvalds@linux-foundation.org
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

Oleg Nesterov <oleg@redhat.com> writes:

> On 05/22, Oleg Nesterov wrote:
>>
>> Right now I think that "int dead" should die,
>
> No, probably we shouldn't call get_signal() if we have already
> dequeued SIGKILL.

Very much agreed.  It is one thing to add a patch to move do_exit
out of get_signal.  It is another to keep calling get_signal after
that.  Nothing tests that case, and so we get some weird behaviors.


>> but let me think tomorrow.
>
> May be something like this... I don't like it but I can't suggest anything better
> right now.
>
> 	bool killed = false;
>
> 	for (;;) {
> 		...
> 	
> 		node = llist_del_all(&worker->work_list);
> 		if (!node) {
> 			schedule();
> 			/*
> 			 * When we get a SIGKILL our release function will
> 			 * be called. That will stop new IOs from being queued
> 			 * and check for outstanding cmd responses. It will then
> 			 * call vhost_task_stop to tell us to return and exit.
> 			 */
> 			if (signal_pending(current)) {
> 				struct ksignal ksig;
>
> 				if (!killed)
> 					killed = get_signal(&ksig);
>
> 				clear_thread_flag(TIF_SIGPENDING);
> 			}
>
> 			continue;
> 		}

I want to point out that we need to consider not just SIGKILL, but
SIGABRT that causes a coredump, as well as the process peforming
an ordinary exit(2).  All of which will cause get_signal to return
SIGKILL in this context.

>
> -------------------------------------------------------------------------------
> But let me ask a couple of questions.

I share most of these questions.

> Let's forget this patch, let's look at the
> current code:
>
> 		node = llist_del_all(&worker->work_list);
> 		if (!node)
> 			schedule();
>
> 		node = llist_reverse_order(node);
> 		... process works ...
>
> To me this looks a bit confusing. Shouldn't we do
>
> 		if (!node) {
> 			schedule();
> 			continue;
> 		}
>
> just to make the code a bit more clear? If node == NULL then
> llist_reverse_order() and llist_for_each_entry_safe() will do nothing.
> But this is minor.
>
>
>
> 		/* make sure flag is seen after deletion */
> 		smp_wmb();
> 		llist_for_each_entry_safe(work, work_next, node, node) {
> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>
> I am not sure about smp_wmb + clear_bit. Once we clear VHOST_WORK_QUEUED,
> vhost_work_queue() can add this work again and change work->node->next.
>
> That is why we use _safe, but we need to ensure that llist_for_each_safe()
> completes LOAD(work->node->next) before VHOST_WORK_QUEUED is cleared.
>
> So it seems that smp_wmb() can't help and should be removed, instead we need
>
> 		llist_for_each_entry_safe(...) {
> 			smp_mb__before_atomic();
> 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>
> Also, if the work->fn pointer is not stable, we should read it before
> smp_mb__before_atomic() as well.
>
> No?
>
>
> 			__set_current_state(TASK_RUNNING);
>
> Why do we set TASK_RUNNING inside the loop? Does this mean that work->fn()
> can return with current->state != RUNNING ?
>
>
> 			work->fn(work);
>
> Now the main question. Whatever we do, SIGKILL/SIGSTOP/etc can come right
> before we call work->fn(). Is it "safe" to run this callback with
> signal_pending() or fatal_signal_pending() ?
>
>
> Finally. I never looked into drivers/vhost/ before so I don't understand
> this code at all, but let me ask anyway... Can we change vhost_dev_flush()
> to run the pending callbacks rather than wait for vhost_worker() ?
> I guess we can't, ->mm won't be correct, but can you confirm?

In a conversation long ago I remember hearing that vhost does not
support file descriptor passing.  Which means all of the file
descriptors should be in the same process.

Looking at the vhost code what I am seeing happening is that the
vhost_worker persists until vhost_dev_cleanup is called from
one of the vhost_???_release() functions.  The release functions
are only called after the last flush function completes.  See __fput
if you want to trace the details.


On one hand this all seems reasonable.  On the other hand I am not
seeing the code that prevents file descriptor passing.


It is probably not the worst thing in the world, but what this means
is now if you pass a copy of the vhost file descriptor to another
process the vhost_worker will persist, and thus the process will persist
until that copy of the file descriptor is closed.

Eric

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
