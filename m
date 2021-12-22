Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CDC4C433F5
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 00:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2514841549;
	Wed, 22 Dec 2021 00:20:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U4QjYiR2AhZz; Wed, 22 Dec 2021 00:20:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7F45941520;
	Wed, 22 Dec 2021 00:20:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D09AC001E;
	Wed, 22 Dec 2021 00:20:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1085C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 00:20:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8619040A6C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 00:20:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2_16j1Umda5g
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 00:20:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F322940124
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 00:20:32 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51]:53740)
 by out02.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mzpMp-0047Cz-Mi; Tue, 21 Dec 2021 17:20:29 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:42868
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1mzpMn-0018SB-6e; Tue, 21 Dec 2021 17:20:27 -0700
From: ebiederm@xmission.com (Eric W. Biederman)
To: michael.christie@oracle.com
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <87tuf79gni.fsf@email.froward.int.ebiederm.org>
 <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
Date: Tue, 21 Dec 2021 18:20:17 -0600
In-Reply-To: <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com> (michael
 christie's message of "Fri, 17 Dec 2021 16:08:14 -0600")
Message-ID: <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1mzpMn-0018SB-6e; ; ;
 mid=<87tuf11oe6.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.227.161.49; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX18WccbykfiYCIa8HygQrNw5fA+7liuIPb4=
X-SA-Exim-Connect-IP: 68.227.161.49
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Cc: axboe@kernel.dk, hdanton@sina.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 hch@infradead.org, vverma@digitalocean.com, geert@linux-m68k.org,
 stefanha@redhat.com, christian.brauner@ubuntu.com
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

> On 12/17/21 1:26 PM, Eric W. Biederman wrote:
>> Mike Christie <michael.christie@oracle.com> writes:
>> 
>>> The following patches made over Linus's tree, allow the vhost layer to do
>>> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
>>> io_uring does a copy_process against its userspace app. This allows the
>>> vhost layer's worker threads to inherit cgroups, namespaces, address
>>> space, etc and this worker thread will also be accounted for against that
>>> owner/parent process's RLIMIT_NPROC limit.
>>>
>>> If you are not familiar with qemu and vhost here is more detailed
>>> problem description:
>>>
>>> Qemu will create vhost devices in the kernel which perform network, SCSI,
>>> etc IO and management operations from worker threads created by the
>>> kthread API. Because the kthread API does a copy_process on the kthreadd
>>> thread, the vhost layer has to use kthread_use_mm to access the Qemu
>>> thread's memory and cgroup_attach_task_all to add itself to the Qemu
>>> thread's cgroups.
>>>
>>> The problem with this approach is that we then have to add new functions/
>>> args/functionality for every thing we want to inherit. I started doing
>>> that here:
>>>
>>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1233__;!!ACWV5N9M2RV99hQ!eIaEe9V8mCgGU6vyvaWTKGi3Zlnz0rgk5Y-0nsBXRbsuVZsM8lYfHr8I8GRuoLYPYrOB$ 
>>>
>>> for the RLIMIT_NPROC check, but it seems it might be easier to just
>>> inherit everything from the beginning, becuase I'd need to do something
>>> like that patch several times.
>> 
>> I read through the code and I don't see why you want to make these
>> almost threads of a process not actually threads of that process
>> (like the io_uring threads are).
>> 
>> As a separate process there are many things that will continue to be
>> disjoint.  If the thread changes cgroups for example your new process
>> won't follow.
>> 
>> If you want them to be actually processes with an lifetime independent
>> of the creating process I expect you want to reparent them to the local
>> init process.  Just so they don't confuse the process tree.  Plus init
>> processes know how to handle unexpected children.
>> 
>> What are the semantics you are aiming for?
>> 
>
> Hi Eric,
>
> Right now, for vhost we need the thread being created:
>
> 1. added to the caller's cgroup.
> 2. to share the mm struct with the caller.
> 3. to be accounted for under the caller's nproc rlimit value.
>
> For 1 and 2, we have cgroup_attach_task_all and get_task_mm
> already.
>
> This patchset started with me just trying to handle #3 by modifying kthreads
> like here:
>
> https://lkml.org/lkml/2021/6/23/1234
>
> So we can use kthreads and the existing helpers and add:
>
> A. a ucounts version of the above patches in the link
>
> or
>
> B. a helper that does something like copy_process's use of
> is_ucounts_overlimit and vhost can call that.
>
> instead of this patchset.

I don't fundamentally hate the patchset.  I do have concerns about
the completely broken patch.

With respect this patchset my gut says decide.  Are you a thread of the
process (just use create_io_worker) are you a separate process forked
from the caller (use a cousin of create_io_worker but don't touch
create_io_worker).  I think being a process vs being a thread is such a
fundamental difference we don't want to mix the helpers.

> Before we even get to the next section below, do you consider items 1 - 3
> something we need an API based on copy_process for?

I think 3 staying in the callers nproc strongly suggests you want to
reuse copy_process.  Which gets back to my question do you want
a thread or do you want a process.


For me a key detail is what is the lifetime of the vhost device?

Does the vhost go away when the caller goes away?

  If so you can create a thread in the caller's process that only performs
  work in kernel space.  At which point you are essentially
  create_io_thread.

If the vhost device can live after the caller goes away how is that managed?
  Especially when you are tied to the caller's mm.

  If your device lives on after the caller then you should be a separate
  process forked from the caller.


> Do you think I should just do A or B above, or do you have another idea? If
> so can we get agreement on that from everyone?

Like I said.  I don't hate this patchset.  I think you just tried to be
a little too general.


With kthreads you are fighting very hard to get something that is not
part of the process tree to act like it is part of the process tree.
Which strongly suggests you should be part of the process tree.

As long as you don't have important state you will need to fight to get
separate from the process.

If you do have important state that needs to not come from the process
figuring out how to make a kthread work may be safer.

I don't currently know vhost devices well enough to answer that question.

> I thought my patches in that link were a little hacky in how they passed
> around the user/creds info. I thought maybe it shouldn't be passed around like
> that, so switched to the copy_process based approach which did everything for
> me. And I thought io_uring needed something similar as us so I made it generic.
>
> I don't have a preference. You and Christian are the experts, so I'll leave it
> to you guys.

I hope this gives you some useful direction.

Eric


>> I can see sense in generalizing some of the pieces of create_io_thread
>> but I think generalizing create_io_thread itself is premature.  The code
>> lives in kernel/fork.c because it is a very special thing that we want
>> to keep our eyes on.
>> 
>> Some of your generalization makes it much more difficult to tell what
>> your code is going to use because you remove hard codes that are there
>> to simplify the analysis of the situation.
>> 
>> My gut says adding a new create_vhost_worker and putting that in
>> kernel/fork.c is a lot safer and will allow much better code analysis.
>> 
>> If there a really are commonalities between creating a userspace process
>> that runs completely in the kernel and creating an additional userspace
>> thread we refactor the code and simplify things.
>> 
>> I am especially nervous about generalizing the io_uring code as it's
>> signal handling just barely works, and any generalization will cause it
>> to break.  So you are in the process of generalizing code that simply
>> can not handle the general case.  That scares me
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
