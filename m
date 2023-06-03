Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA74C7EE29
	for <virtualization@archiver.kernel.org>; Sat,  3 Jun 2023 03:45:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 510F36103A;
	Sat,  3 Jun 2023 03:45:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 510F36103A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GEUFbYmboj77; Sat,  3 Jun 2023 03:45:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFA5C60B2E;
	Sat,  3 Jun 2023 03:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFA5C60B2E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8B19C0037;
	Sat,  3 Jun 2023 03:45:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56D56C0029
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jun 2023 03:45:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EA77845F3
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jun 2023 03:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EA77845F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YT9pu3lG8Cne
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jun 2023 03:45:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4D548845F2
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4D548845F2
 for <virtualization@lists.linux-foundation.org>;
 Sat,  3 Jun 2023 03:45:40 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52]:40116)
 by out01.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q5ICv-007FAM-Ob; Fri, 02 Jun 2023 21:45:38 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:45462
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q5ICu-006Cwo-Gt; Fri, 02 Jun 2023 21:45:37 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
In-Reply-To: <20230602192254.GD555@redhat.com> (Oleg Nesterov's message of
 "Fri, 2 Jun 2023 21:22:55 +0200")
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date: Fri, 02 Jun 2023 22:44:47 -0500
Message-ID: <87wn0l2or4.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
X-XM-SPF: eid=1q5ICu-006Cwo-Gt; ; ;
 mid=<87wn0l2or4.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX18rwwgl3V8rHDOCFR4O8oZK9le+ZTQfAnc=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 1/1] fork, vhost: Use CLONE_THREAD to fix freezer/ps
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

> Hi Mike,
>
> sorry, but somehow I can't understand this patch...
>
> I'll try to read it with a fresh head on Weekend, but for example,
>
> On 06/01, Mike Christie wrote:
>>
>>  static int vhost_task_fn(void *data)
>>  {
>>  	struct vhost_task *vtsk = data;
>> -	int ret;
>> +	bool dead = false;
>> +
>> +	for (;;) {
>> +		bool did_work;
>> +
>> +		/* mb paired w/ vhost_task_stop */
>> +		if (test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags))
>> +			break;
>> +
>> +		if (!dead && signal_pending(current)) {
>> +			struct ksignal ksig;
>> +			/*
>> +			 * Calling get_signal will block in SIGSTOP,
>> +			 * or clear fatal_signal_pending, but remember
>> +			 * what was set.
>> +			 *
>> +			 * This thread won't actually exit until all
>> +			 * of the file descriptors are closed, and
>> +			 * the release function is called.
>> +			 */
>> +			dead = get_signal(&ksig);
>> +			if (dead)
>> +				clear_thread_flag(TIF_SIGPENDING);
>
> this can't be right or I am totally confused.
>
> Another signal_wake_up() can come right after clear(SIGPENDING).

Technically yes.

However please not that prepare_signal does:
	if (signal->flags & SIGNAL_GROUP_EXIT)
		return false;

In general it is wrong to receive or attempt to process a signal
after task death has been decided.

Strictly speaking that doesn't cover de_thread, and coredumping
but still receiving any kind of signal at that point is rare
and generally wrong behavior.

Beyond that clearing TIF_SIGPENDING is just an optimization so
the thread can sleep in schedule and not spin.

> Again, I'll try to re-read this patch, but let me ask anyway...
>
> Do we have a plan B? I mean... iirc you have mentioned that you can
> change these code paths to do something like
>
> 	if (killed)
> 		tell_the_drivers_that_all_callbacks_will_fail();
>
>
> so that vhost_worker() can exit after get_signal() returns SIGKILL.
>
> Probably I misunderstood you, but it would be nice to avoid the changes
> in coredump/etc code just to add a temporary (iiuc!) fix.

One saving grace with the the vhost code is that you need to open
device nodes that normally have root-only permissions.

If we are willing to allow races in process shutdown to cause leaks I
think we can do something better, and put the burden of work on vhost
layer.

I will follow up with a patch doing that.

Eric

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
