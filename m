Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FB9C433F5
	for <virtualization@archiver.kernel.org>; Fri, 17 Dec 2021 19:26:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8686640AC4;
	Fri, 17 Dec 2021 19:26:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TPlJqtry6Mih; Fri, 17 Dec 2021 19:26:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7413A404A9;
	Fri, 17 Dec 2021 19:26:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 472A9C002F;
	Fri, 17 Dec 2021 19:26:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D477DC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 19:26:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C23B2417A3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 19:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CLH85j_Fxu8B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 19:26:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D6E3B41793
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 19:26:52 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51]:60264)
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1myIsU-003GVL-G5; Fri, 17 Dec 2021 12:26:50 -0700
Received: from ip68-227-161-49.om.om.cox.net ([68.227.161.49]:43512
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1myIsT-004Mxi-0v; Fri, 17 Dec 2021 12:26:50 -0700
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mike Christie <michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Date: Fri, 17 Dec 2021 13:26:41 -0600
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com> (Mike
 Christie's message of "Mon, 29 Nov 2021 13:46:57 -0600")
Message-ID: <87tuf79gni.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1myIsT-004Mxi-0v; ; ;
 mid=<87tuf79gni.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.227.161.49; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX180LvusV5/qqDk8bOZub2tqU2IJcgsy1HU=
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

Mike Christie <michael.christie@oracle.com> writes:

> The following patches made over Linus's tree, allow the vhost layer to do
> a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
> io_uring does a copy_process against its userspace app. This allows the
> vhost layer's worker threads to inherit cgroups, namespaces, address
> space, etc and this worker thread will also be accounted for against that
> owner/parent process's RLIMIT_NPROC limit.
>
> If you are not familiar with qemu and vhost here is more detailed
> problem description:
>
> Qemu will create vhost devices in the kernel which perform network, SCSI,
> etc IO and management operations from worker threads created by the
> kthread API. Because the kthread API does a copy_process on the kthreadd
> thread, the vhost layer has to use kthread_use_mm to access the Qemu
> thread's memory and cgroup_attach_task_all to add itself to the Qemu
> thread's cgroups.
>
> The problem with this approach is that we then have to add new functions/
> args/functionality for every thing we want to inherit. I started doing
> that here:
>
> https://lkml.org/lkml/2021/6/23/1233
>
> for the RLIMIT_NPROC check, but it seems it might be easier to just
> inherit everything from the beginning, becuase I'd need to do something
> like that patch several times.

I read through the code and I don't see why you want to make these
almost threads of a process not actually threads of that process
(like the io_uring threads are).

As a separate process there are many things that will continue to be
disjoint.  If the thread changes cgroups for example your new process
won't follow.

If you want them to be actually processes with an lifetime independent
of the creating process I expect you want to reparent them to the local
init process.  Just so they don't confuse the process tree.  Plus init
processes know how to handle unexpected children.

What are the semantics you are aiming for?

I can see sense in generalizing some of the pieces of create_io_thread
but I think generalizing create_io_thread itself is premature.  The code
lives in kernel/fork.c because it is a very special thing that we want
to keep our eyes on.

Some of your generalization makes it much more difficult to tell what
your code is going to use because you remove hard codes that are there
to simplify the analysis of the situation.

My gut says adding a new create_vhost_worker and putting that in
kernel/fork.c is a lot safer and will allow much better code analysis.

If there a really are commonalities between creating a userspace process
that runs completely in the kernel and creating an additional userspace
thread we refactor the code and simplify things.

I am especially nervous about generalizing the io_uring code as it's
signal handling just barely works, and any generalization will cause it
to break.  So you are in the process of generalizing code that simply
can not handle the general case.  That scares me.

Eric

>
> V6:
> - Rename kernel_worker to user_worker and fix prefixes.
> - Add better patch descriptions.
> V5:
> - Handle kbuild errors by building patchset against current kernel that
>   has all deps merged. Also add patch to remove create_io_thread code as
>   it's not used anymore.
> - Rebase patchset against current kernel and handle a new vm PF_IO_WORKER
>   case added in 5.16-rc1.
> - Add PF_USER_WORKER flag so we can check it later after the initial
>   thread creation for the wake up, vm and singal cses.
> - Added patch to auto reap the worker thread.
> V4:
> - Drop NO_SIG patch and replaced with Christian's SIG_IGN patch.
> - Merged Christian's kernel_worker_flags_valid helpers into patch 5 that
>   added the new kernel worker functions.
> - Fixed extra "i" issue.
> - Added PF_USER_WORKER flag and added check that kernel_worker_start users
>   had that flag set. Also dropped patches that passed worker flags to
>   copy_thread and replaced with PF_USER_WORKER check.
> V3:
> - Add parentheses in p->flag and work_flags check in copy_thread.
> - Fix check in arm/arm64 which was doing the reverse of other archs
>   where it did likely(!flags) instead of unlikely(flags).
> V2:
> - Rename kernel_copy_process to kernel_worker.
> - Instead of exporting functions, make kernel_worker() a proper
>   function/API that does common work for the caller.
> - Instead of adding new fields to kernel_clone_args for each option
>   make it flag based similar to CLONE_*.
> - Drop unused completion struct in vhost.
> - Fix compile warnings by merging vhost cgroup cleanup patch and
>   vhost conversion patch.
> ~                              
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
