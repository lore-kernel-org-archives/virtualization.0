Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B0CC7EE23
	for <virtualization@archiver.kernel.org>; Tue, 16 May 2023 20:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8FF738422D;
	Tue, 16 May 2023 20:12:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8FF738422D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSaXztLgHKx9; Tue, 16 May 2023 20:12:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 173E384226;
	Tue, 16 May 2023 20:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 173E384226
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0E83C0036;
	Tue, 16 May 2023 20:12:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 535B9C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 227F78421B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:12:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 227F78421B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lg7Pkk-wLPFM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:12:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60D8F84219
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 60D8F84219
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 May 2023 20:12:53 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51]:33060)
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pz12Q-002ZBM-Ml; Tue, 16 May 2023 14:12:50 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:41298
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1pz12P-005t0v-G7; Tue, 16 May 2023 14:12:50 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
References: <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
 <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
 <CAHk-=wicXCNR1bBioaAiBqEDgv-CoQD9z2RsM2VOTPzkK0xr8g@mail.gmail.com>
 <20230515-vollrausch-liebgeworden-2765f3ca3540@brauner>
 <CAHk-=wgXJ5VS1iBkfsG=HDjsyhn5XYDKt5xhQcNuz-e7VKyg8A@mail.gmail.com>
 <122b597e-a5fa-daf7-27bb-6f04fa98d496@oracle.com>
 <CAHk-=wgTpRDwS+F0Gd6+bM+TEh+x4Aiz8EBDTnTm3Q4TFdWOww@mail.gmail.com>
 <87cz30s20y.fsf@email.froward.int.ebiederm.org>
 <20230516183757.GA1286@redhat.com>
Date: Tue, 16 May 2023 15:12:10 -0500
In-Reply-To: <20230516183757.GA1286@redhat.com> (Oleg Nesterov's message of
 "Tue, 16 May 2023 20:37:57 +0200")
Message-ID: <87mt24ox2d.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1pz12P-005t0v-G7; ; ;
 mid=<87mt24ox2d.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX1//rdFVubSWApRxlVrJbJVsmsZmIf/63yc=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>, mst@redhat.com,
 linux-kernel@vger.kernel.org, konrad.wilk@oracle.com,
 Thorsten Leemhuis <linux@leemhuis.info>,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 stefanha@redhat.com, nicolas.dichtel@6wind.com,
 Linus Torvalds <torvalds@linux-foundation.org>
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

> On 05/16, Eric W. Biederman wrote:
>>
>> A kernel thread can block SIGKILL and that is supported.
>>
>> For a thread that is part of a process you can't block SIGKILL when the
>> task is part of a user mode process.
>
> Or SIGSTOP. Another thread can call do_signal_stop()->signal_wake_up/etc.

Yes, ignoring SIGSTOP leads to the same kind of rendezvous issues as
SIGKILL.

>> There is this bit in complete_signal when SIGKILL is delivered to any
>> thread in the process.
>>
>> 			t = p;
>> 			do {
>> 				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
>> 				sigaddset(&t->pending.signal, SIGKILL);
>> 				signal_wake_up(t, 1);
>> 			} while_each_thread(p, t);
>
> That is why the latest version adds try_set_pending_sigkill(). No, no,
> it is not that I think this is a good idea.

I see that try_set_pending_sigkill in the patch now.

That try_set_pending_sigkill just keeps the process from reporting
that it has exited, and extend the process exit indefinitely.

SIGNAL_GROUP_EXIT has already been set, so the KILL signal was
already delivered and the process is exiting.

>> For clarity that sigaddset(&t->pending.signal, SIGKILL);  Really isn't
>> setting SIGKILL pending,
>
> Hmm. it does? Nevermind.

The point is that what try_set_pending_sigkill in the patch is doing is
keeping the "you are dead exit now" flag, from being set.

That flag is what fatal_signal_pending always tests, because we can only
know if a fatal signal is pending if we have performed short circuit
delivery on the signal.

The result is the effects of the change are mostly what people expect.
The difference the semantics being changed aren't what people think they
are.

AKA process exit is being ignored for the thread, not that SIGKILL is
being blocked.

>> The important part of that code is that SIGNAL_GROUP_EXIT gets set.
>> That indicates the entire process is being torn down.
>
> Yes. and the same is true for io-thread even if it calls get_signal()
> and dequeues SIGKILL and clears TIF_SIGPENDING.
>
>> but in that case the vhost logic needs to act like a process, just
>> like io_uring does.
>
> confused... create_io_thread() creates a sub-thread too?

Yes, create_io_uring creates an ordinary user space thread that never
runs any code in user space.

> Although I never understood this logic. I can't even understand the usage
> of lower_32_bits() in create_io_thread().

As far as I can tell lower_32_bits(flags) is just defensive programming
that just copies the code in clone.  The code just as easily have said
u32 flags, or have just populated .flags directly.  Then .exit_signal
could have been set to 0.  Later copy_process will set .exit_signal = -1
because CLONE_THREAD is set.

The reason for adding create_io_thread calling copy_process as I recall
so that the new task does not start automatically.  This allows
functions like io_init_new_worker to initialize the new task without
races and then call wake_up_new_task.

Eric

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
