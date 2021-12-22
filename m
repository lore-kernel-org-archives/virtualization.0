Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BF0C433EF
	for <virtualization@archiver.kernel.org>; Wed, 22 Dec 2021 18:24:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8F9FF404CF;
	Wed, 22 Dec 2021 18:24:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W7S7jH-_69FU; Wed, 22 Dec 2021 18:24:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1DF940131;
	Wed, 22 Dec 2021 18:24:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FB31C002F;
	Wed, 22 Dec 2021 18:24:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92B13C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 18:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6A90A81BC6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 18:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MWBZtoKQgp5I
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 18:24:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 35C0A81A4E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 18:24:53 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51]:50884)
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1n06IE-00DHk6-MV; Wed, 22 Dec 2021 11:24:50 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:47466
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1n06IC-004wrR-9I; Wed, 22 Dec 2021 11:24:50 -0700
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mike Christie <michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
 <87tuf79gni.fsf@email.froward.int.ebiederm.org>
 <a171238e-d731-1c22-af72-0f7faf7f4bea@oracle.com>
 <87tuf11oe6.fsf@email.froward.int.ebiederm.org>
 <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com>
Date: Wed, 22 Dec 2021 12:24:08 -0600
In-Reply-To: <a3bd6fe7-1775-6fdd-3a02-e779c4d4e498@oracle.com> (Mike
 Christie's message of "Wed, 22 Dec 2021 11:32:25 -0600")
Message-ID: <87pmpoxzuf.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1n06IC-004wrR-9I; ; ;
 mid=<87pmpoxzuf.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.110.24.146; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX194jyDU5R7FpENXqa8npM2lamawzXnFLtk=
X-SA-Exim-Connect-IP: 68.110.24.146
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

Mike Christie <michael.christie@oracle.com> writes:

> On 12/21/21 6:20 PM, Eric W. Biederman wrote:
>> michael.christie@oracle.com writes:
>> 
>>> On 12/17/21 1:26 PM, Eric W. Biederman wrote:
>>>> Mike Christie <michael.christie@oracle.com> writes:
>>>>
>>>>> The following patches made over Linus's tree, allow the vhost layer to do
>>>>> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
>>>>> io_uring does a copy_process against its userspace app. This allows the
>>>>> vhost layer's worker threads to inherit cgroups, namespaces, address
>>>>> space, etc and this worker thread will also be accounted for against that
>>>>> owner/parent process's RLIMIT_NPROC limit.
>>>>>
>>>>> If you are not familiar with qemu and vhost here is more detailed
>>>>> problem description:
>>>>>
>>>>> Qemu will create vhost devices in the kernel which perform network, SCSI,
>>>>> etc IO and management operations from worker threads created by the
>>>>> kthread API. Because the kthread API does a copy_process on the kthreadd
>>>>> thread, the vhost layer has to use kthread_use_mm to access the Qemu
>>>>> thread's memory and cgroup_attach_task_all to add itself to the Qemu
>>>>> thread's cgroups.
>>>>>
>>>>> The problem with this approach is that we then have to add new functions/
>>>>> args/functionality for every thing we want to inherit. I started doing
>>>>> that here:
>>>>>
>>>>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1233__;!!ACWV5N9M2RV99hQ!eIaEe9V8mCgGU6vyvaWTKGi3Zlnz0rgk5Y-0nsBXRbsuVZsM8lYfHr8I8GRuoLYPYrOB$ 
>>>>>
>>>>> for the RLIMIT_NPROC check, but it seems it might be easier to just
>>>>> inherit everything from the beginning, becuase I'd need to do something
>>>>> like that patch several times.
>>>>
>>>> I read through the code and I don't see why you want to make these
>>>> almost threads of a process not actually threads of that process
>>>> (like the io_uring threads are).
>>>>
>>>> As a separate process there are many things that will continue to be
>>>> disjoint.  If the thread changes cgroups for example your new process
>>>> won't follow.
>>>>
>>>> If you want them to be actually processes with an lifetime independent
>>>> of the creating process I expect you want to reparent them to the local
>>>> init process.  Just so they don't confuse the process tree.  Plus init
>>>> processes know how to handle unexpected children.
>>>>
>>>> What are the semantics you are aiming for?
>>>>
>>>
>>> Hi Eric,
>>>
>>> Right now, for vhost we need the thread being created:
>>>
>>> 1. added to the caller's cgroup.
>>> 2. to share the mm struct with the caller.
>>> 3. to be accounted for under the caller's nproc rlimit value.
>>>
>>> For 1 and 2, we have cgroup_attach_task_all and get_task_mm
>>> already.
>>>
>>> This patchset started with me just trying to handle #3 by modifying kthreads
>>> like here:
>>>
>>> https://urldefense.com/v3/__https://lkml.org/lkml/2021/6/23/1234__;!!ACWV5N9M2RV99hQ!bvqZOWy7TxQyq18L4I_a5MxP2OX0V2imOYEJrWsc-LkyVTI_zpFzxyV2pM_dgYywwH2y$ 
>>>
>>> So we can use kthreads and the existing helpers and add:
>>>
>>> A. a ucounts version of the above patches in the link
>>>
>>> or
>>>
>>> B. a helper that does something like copy_process's use of
>>> is_ucounts_overlimit and vhost can call that.
>>>
>>> instead of this patchset.
>> 
>> I don't fundamentally hate the patchset.  I do have concerns about
>> the completely broken patch.
>> 
>> With respect this patchset my gut says decide.  Are you a thread of the
>> process (just use create_io_worker) are you a separate process forked
>> from the caller (use a cousin of create_io_worker but don't touch
>> create_io_worker).  I think being a process vs being a thread is such a
>> fundamental difference we don't want to mix the helpers.
>> 
>>> Before we even get to the next section below, do you consider items 1 - 3
>>> something we need an API based on copy_process for?
>> 
>> I think 3 staying in the callers nproc strongly suggests you want to
>> reuse copy_process.  Which gets back to my question do you want
>> a thread or do you want a process.
>> 
>> 
>> For me a key detail is what is the lifetime of the vhost device?
>> 
>> Does the vhost go away when the caller goes away?
>
> Yes. When the caller, normally qemu in our case, that created the worker
> thread exits, then we free the vhost devices and stop and free the worker
> threads we are creating in this patchset.
>
> However, I'm not sure if it makes a difference to you, but we also have second
> way to free a vhost device and its worker thread. The user can run a command
> that instructs the the qemu process to free the vhost device and its worker
> thread.

I dug a little deeper to understand how this works, and it appears to be
a standard file descriptor based API.  The last close of the file
descriptor is what causes the vhost_dev_cleanup to be called which shuts
down the thread.

This means that in rare cases the file descriptor can be passed to
another process and be held open there, even after the main process
exits.

This says to me that much as it might be handy your thread does not
strictly share the same lifetime as your qemu process.


>>   If so you can create a thread in the caller's process that only performs
>>   work in kernel space.  At which point you are essentially
>>   create_io_thread.
>> 
>> If the vhost device can live after the caller goes away how is that managed?
>
> When the caller goes away we free the devices and their worker threads.
>
> Either before the caller exists it does an explicit close to release the device
> which frees the device and its worker thread, or when the process exits and the
> kernel does a put on its open devices that will trigger the vhost device's release
> function and we free device and its thread at that time.

All of which says to me that the vhost devices semantically work well as
separate processes (that never run userspace code) not as threads of the
creating userspace process.

So I would recommend creating a minimal version of the kthread api,
using create_process targeted only at the vhost case.  Essentially what
you have done with this patchset, but without any configuration knobs
from the callers perspective.

Which means that you can hard code calling ignore_signals, and the
like, instead of needing to have a separate configuration knob for each
place io_workers are different from vhost_workers.

In the future I can see io_workers evolving into a general user space
thread that only runs code in the kernel abstraction, and I can see
vhost_workers evolving into a general user space process that only runs
code in the kernel abstraction.

For now we don't need that generality so please just create a
create_vhost_process helper akin to create_io_thread that does just what
you need.

I don't know if it is better to base it on kernel_clone or on
copy_process.  All I am certain of is that you need to set
"args->exit_signal = -1;".  This prevents having to play games with
do_notify_parent.

Eric
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
