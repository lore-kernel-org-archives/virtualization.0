Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A530BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 31 May 2022 16:18:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FFED6128F;
	Tue, 31 May 2022 16:18:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N4Z9C9JoVae3; Tue, 31 May 2022 16:18:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CFA3761287;
	Tue, 31 May 2022 16:18:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C7FCC0039;
	Tue, 31 May 2022 16:18:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51B9EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:18:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F61741C00
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:18:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6yXnNvFDuLN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:18:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BED0641A33
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 16:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654013932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YtoJsV/pAwLuD0XYy5XZQJJtondD7Ct4J80qDODwKmo=;
 b=ODLVHbLqE7hXDWStfta2c9uTfvFLu1BnpWrLHhBWKGdxYW6PigZ0b4YJTtlFHYmhR0mtFj
 lBQE7KCoutQjC3q2RCqB4CjPaL64qI+nkhGrSFO0aYcO/+PjTkONxRIi87MfVSAuGa+G9I
 Y5FmCnuWG83TUWtfgRj1+myA8Cbjhtc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-so3SIth4NLiuhETSTeMiMA-1; Tue, 31 May 2022 12:18:51 -0400
X-MC-Unique: so3SIth4NLiuhETSTeMiMA-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg13-20020a05600c3c8d00b003974d0ff917so1540363wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 May 2022 09:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YtoJsV/pAwLuD0XYy5XZQJJtondD7Ct4J80qDODwKmo=;
 b=5uyR4EKkj4Gq7HnJ+2pN3IM30umhg5G6+SElzqdmVa6Y3+QY9ZWZ0cmJbofQLiWyEA
 cm2L8jOgG21tSRFzlYzOobbv1fa920sVtrYdQP0Aoup7enDgXKTfZ3+qJ/7Rxo7+lhd8
 D3tgpibZnk8mw7mcgUMeQ3qhHcp1/bJtlH3SUQ/SJuBbBfbVhl6RIhB43JumFCMKhY2s
 X2Vc3Wl2aW+eGoJL0rp+xBqIW+rGL8jIUlW+D5WcSKrRFZjbdxtrRwNxpa//8H0tySOX
 FdcIExcNgWjtfZtwaLxB1LW9AeRuZ20IT92A9XsYlqIzq3uOnVe8U0EOr/dtErytcifu
 wenA==
X-Gm-Message-State: AOAM530qa4YgQz44zGcrRxqjQRT5ikTl9mVfRuz2SXFOHa9KUm5WjeAb
 x2b9BZzNugkT0o2XBH79AhLS+j6/540EjpMKRjuDm0C6KMe8uJ4dXzT+Br5/PMls0GA7t54rJa0
 5SMlwL/+1d+mJUp3AOc/kSu8zIVxKYSOVizsoivPsHw==
X-Received: by 2002:a05:600c:3646:b0:397:326d:eac7 with SMTP id
 y6-20020a05600c364600b00397326deac7mr25225082wmq.43.1654013930043; 
 Tue, 31 May 2022 09:18:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+BdBaQ0bOBc902fQ3zUVwJD7Nos9AeOAqNHRZ/i3ghUNUlKXPeQbyPlkHAXavv8IJGuTT/Q==
X-Received: by 2002:a05:600c:3646:b0:397:326d:eac7 with SMTP id
 y6-20020a05600c364600b00397326deac7mr25225067wmq.43.1654013929840; 
 Tue, 31 May 2022 09:18:49 -0700 (PDT)
Received: from redhat.com ([2.52.157.68]) by smtp.gmail.com with ESMTPSA id
 d22-20020a05600c34d600b0039736892653sm2451571wmq.27.2022.05.31.09.18.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 May 2022 09:18:49 -0700 (PDT)
Date: Tue, 31 May 2022 12:18:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V9 0/8] Use copy_process in vhost layer
Message-ID: <20220531121659-mutt-send-email-mst@kernel.org>
References: <20220512214704.104472-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20220512214704.104472-1-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com
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

On Thu, May 12, 2022 at 04:46:56PM -0500, Mike Christie wrote:
> The following patches were made over Eric's tree:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git
> 
> and his kthread-cleanups-for-v5.19 branch. They allow the vhost layer to
> do a copy_process on the thread that does the VHOST_SET_OWNER ioctl like how
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

Series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Who is going to merge this?

> V9:
> - Rebase against Eric's kthread-cleanups-for-v5.19 branch. Drop patches
> no longer needed due to kernel clone arg and pf io worker patches in that
> branch.
> V8:
> - Fix kzalloc GFP use.
> - Fix email subject version number.
> V7:
> - Drop generic user_worker_* helpers and replace with vhost_task specific
>   ones.
> - Drop autoreap patch. Use kernel_wait4 instead.
> - Fix issue where vhost.ko could be removed while the worker function is
>   still running.
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
> 
> 
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
