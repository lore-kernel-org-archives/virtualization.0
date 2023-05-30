Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9748AC77B7E
	for <virtualization@archiver.kernel.org>; Tue, 30 May 2023 02:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 105D381DF7;
	Tue, 30 May 2023 02:48:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 105D381DF7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f_iAKkYMGYwR; Tue, 30 May 2023 02:48:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8E64081DA3;
	Tue, 30 May 2023 02:48:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E64081DA3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 657BEC0035;
	Tue, 30 May 2023 02:48:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F00DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 02:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A2B540137
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 02:48:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A2B540137
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cVYJhDC-AGCT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 02:48:43 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5099340025
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5099340025
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 02:48:43 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51]:42588)
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q3pPe-007jSW-3z; Mon, 29 May 2023 20:48:42 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:56626
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q3pPd-009vMy-1g; Mon, 29 May 2023 20:48:41 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: michael.christie@oracle.com
References: <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
 <20230529111859.GA15193@redhat.com>
 <022f4de6-9eae-0a94-0f55-b84be4982fc3@oracle.com>
 <20230529174646.GB15193@redhat.com>
 <ff1bce1a-62d8-1b2e-4560-1ce1ffc209bc@oracle.com>
 <723ac1ba-31d2-92fe-4010-42d8cd70d5df@oracle.com>
Date: Mon, 29 May 2023 21:48:34 -0500
In-Reply-To: <723ac1ba-31d2-92fe-4010-42d8cd70d5df@oracle.com> (michael
 christie's message of "Mon, 29 May 2023 14:46:57 -0500")
Message-ID: <87bki2h6v1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1q3pPd-009vMy-1g; ; ;
 mid=<87bki2h6v1.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX19wSqLMTVFEWgLETMysNGRtJ36mwutxbSI=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 stefanha@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
 virtualization@lists.linux-foundation.org,
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

michael.christie@oracle.com writes:

> On 5/29/23 2:35 PM, Mike Christie wrote:
>>> Hmm... If we you CLONE_THREAD the exiting vhost_worker() will auto-reap itself,
>> Oh wait, are you saying that when we get auto-reaped then we would do the last
>> fput and call the file_operations->release function right? We actually set
>> task_struct->files = NULL for the vhost_task task_struct, so I think we call
>> release a little sooner than you think.
>> 
>> vhost_task_create() sets kernel_clone_args->no_files, so the vhost_task task_struc
>> that gets created works like kthreads where it doesn't do a CLONE_FILES and it
>> doesn't do a dup_fd.
>> 
>> So when we do de_thread() -> zap_other_threads(), that will kill all the threads
>> in the group right? So when they exit, it will call our release function since
>> we don't have refcount on ourself.
>> 
>
> Just to make sure I'm on the same page now.
>
> In the past thread when were discussing the patch below and you guys were saying
> that it doesn't really ignore SIGKILL because we will hit the
> SIGNAL_GROUP_EXIT/group_exec_task checks and the parent is going to exit, it was
> on purpose.
>
> Instead of a signal to tell me when do exit, I was using the parent exiting and doing
> the last fput on the vhost device's file which calls our release function. That then
> allowed the vhost code to use the vhost_task to handle the outstanding IOs and then
> do vhost_task_should_stop to tell the vhost_task to exit when the oustanding IO
> had completed.
>
> On the vhost side of things it's really nice, because all the shutdown paths work
> the same and we don't need rcu/locking in the main IO path to handle the vhost_task
> exiting while we are using it.

The code below does nothing for exec.

You really need to call get_signal to handle SIGSTOP/freeze/process exit.

A variant on my coredump proposal looks like it can handle exec as well.
It isn't pretty but it looks good enough for right now.

If you could test the patch I posted up thread I think that is something
imperfect that is good enough for now.

Eric
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
