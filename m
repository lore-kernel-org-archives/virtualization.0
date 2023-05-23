Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602A6C77B75
	for <virtualization@archiver.kernel.org>; Tue, 23 May 2023 15:31:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA0418321B;
	Tue, 23 May 2023 15:31:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CA0418321B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jv9fx9rm4vuB; Tue, 23 May 2023 15:31:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5C74683051;
	Tue, 23 May 2023 15:31:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5C74683051
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30F55C0036;
	Tue, 23 May 2023 15:31:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 79BF6C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 15:31:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4AD5841C86
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 15:31:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4AD5841C86
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8qsZQa8HjBK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 15:31:08 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CF6FC41CF2
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF6FC41CF2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 May 2023 15:31:07 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51]:34090)
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q1Tyb-00EE6n-4l; Tue, 23 May 2023 09:31:05 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:45292
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q1TyZ-007oCX-Qg; Tue, 23 May 2023 09:31:04 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230522025124.5863-2-michael.christie@oracle.com> (Mike
 Christie's message of "Sun, 21 May 2023 21:51:22 -0500")
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-2-michael.christie@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date: Tue, 23 May 2023 10:30:35 -0500
Message-ID: <87fs7n9ias.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
X-XM-SPF: eid=1q1TyZ-007oCX-Qg; ; ;
 mid=<87fs7n9ias.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX1+s/DSlpo+vEYOge0Lgj9pKdKRgJGOmkLw=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/3] signal: Don't always put SIGKILL in shared_pending
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, oleg@redhat.com, stefanha@redhat.com,
 linux@leemhuis.info, nicolas.dichtel@6wind.com,
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

Mike Christie <michael.christie@oracle.com> writes:

> When get_pending detects the task has been marked to be killed we try to
       ^^^^^^^^^^^ get_signal
> clean up the SIGKLL by doing a sigdelset and recalc_sigpending, but we
> still leave it in shared_pending. If the signal is being short circuit
> delivered there is no need to put in shared_pending so this adds a check
> in complete_signal.
>
> This patch was modified from Eric Biederman <ebiederm@xmission.com>
> original patch.
>
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  kernel/signal.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f6330f0e9ca..3dc99b9aec7f 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1052,6 +1052,14 @@ static void complete_signal(int sig, struct task_struct *p, enum pid_type type)
>  			signal->flags = SIGNAL_GROUP_EXIT;
>  			signal->group_exit_code = sig;
>  			signal->group_stop_count = 0;
> +
> +			/*
> +			 * The signal is being short circuit delivered so
> +			 * don't set pending.
> +			 */
> +			if (type != PIDTYPE_PID)
> +				sigdelset(&signal->shared_pending.signal, sig);
> +
>  			t = p;
>  			do {
>  				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);

Oleg Nesterov <oleg@redhat.com> writes:
>
> Eric, sorry. I fail to understand this patch.
>
> How can it help? And whom?

You were looking at why recalc_sigpending was resulting in
TIF_SIGPENDING set.

The big bug was that get_signal was getting called by the thread after
the thread had realized it was part of a group exit.

The minor bug is that SIGKILL was stuck in shared_pending and causing
recalc_sigpending to set TIF_SIGPENDING after get_signal removed the
per thread flag that asks the thread to exit.



The fact is that fatal signals (that pass all of the checks) are
delivered right there in complete_signal so it does not make sense from
a data structure consistency standpoint to leave the fatal signal (like
SIGKILL) in shared_pending.

Outside of this case it will only affect coredumps and other analyzers
that run at process exit.



One thing I am looking at is that the vhost code shares a common problem
with the coredump code to pipes.  There is code that tests
signal_pending() and does something with it after signal processing has
completed.

Fixing the data structure to be consistent seems like one way to handle
that situation.

Eric
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
