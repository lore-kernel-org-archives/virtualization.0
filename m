Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C87FC433F5
	for <virtualization@archiver.kernel.org>; Wed,  8 Dec 2021 20:35:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1AC44013D;
	Wed,  8 Dec 2021 20:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ymAEmDzYxpiE; Wed,  8 Dec 2021 20:35:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E08A401E2;
	Wed,  8 Dec 2021 20:35:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4FB1C001E;
	Wed,  8 Dec 2021 20:35:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 54A0EC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:35:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 32794408F2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:35:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SchQJAcDbCZz
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:35:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2C5AB408E0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 20:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638995701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjyPhtqWKvXzJTb8n9gdEmIwnhAiXQ7NBxC0TZtycX4=;
 b=iU441YIPv6z8L6YB6j0hinRH4isbzyiRX3/64RNSvezcD9MIut3DfQUrekFxSWI3naznuW
 hrdpCFxVnbCjRmUjPkLBWucfojiCAf1eg8LbR3sfcTDzKYM0VhCvqG+AMxjeTmTDccPNNg
 35Mil93bgs5IU9uf7ozmjahcPFYv/Pw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-3F3mPgXJNYS8u8ZOQShB8w-1; Wed, 08 Dec 2021 15:34:57 -0500
X-MC-Unique: 3F3mPgXJNYS8u8ZOQShB8w-1
Received: by mail-wm1-f69.google.com with SMTP id
 k25-20020a05600c1c9900b00332f798ba1dso3601106wms.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 12:34:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gjyPhtqWKvXzJTb8n9gdEmIwnhAiXQ7NBxC0TZtycX4=;
 b=B9zvnOnhKH8T+OuVGqKlUPdTRNvQ5i8mu8Q5v8VB4IVZR430aRNkL+XEkOa39BYq42
 oDa5MVDWnRM9UM6Do5vDLtBaFQu8APvkltz7WfccSZqeYepAiTDMpU03F0vYaKj52aEk
 PFHLAQVdtvk0DrXQORb4Gc6gKcE9VmVSXb5vordvNQobHgJ3EWGo0YGziST4WX4Lo0rk
 FIhwHx+O3JeDbqa+1Dz0J5exwji7N96wf9znLPj3Cdi6GrkOmVdf9Av4kf7YEqVAQMKc
 X+wr+K82kw/vfJNt0uOvXSbnrs1XkAazjVjqXSy6jmcnvDeF1zOmnEBDYx5TbOli8T5l
 XeNA==
X-Gm-Message-State: AOAM531eh8KpS7Jsf47qTMgdLkx6Ziex4O6gp4HdGq6grRmiO3C6tSvl
 kGa/21r2aURnQL79Ne3Wt/WgzGwejXf6tfFH2eSxmDBNMli0sgM7ICm+LkqBXGRr6X1NqGwAWlw
 fH4QKuEB9ZNA2gADysS6Pr4FN1fH6uHohO7K3QKq75w==
X-Received: by 2002:a05:600c:4c96:: with SMTP id
 g22mr1377787wmp.46.1638995696546; 
 Wed, 08 Dec 2021 12:34:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhVE0pRRj446c43wOm/g7vW0Fq22NttrqLV7/KdxC1GrV37iQQjLydSqa0AKfBqzDP2eJIiw==
X-Received: by 2002:a05:600c:4c96:: with SMTP id
 g22mr1377758wmp.46.1638995696364; 
 Wed, 08 Dec 2021 12:34:56 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
 by smtp.gmail.com with ESMTPSA id y7sm3590205wrw.55.2021.12.08.12.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Dec 2021 12:34:55 -0800 (PST)
Date: Wed, 8 Dec 2021 15:34:51 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH V6 01/10] Use copy_process in vhost layer
Message-ID: <20211208153420-mutt-send-email-mst@kernel.org>
References: <20211129194707.5863-1-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, hdanton@sina.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 vverma@digitalocean.com, geert@linux-m68k.org, stefanha@redhat.com,
 christian.brauner@ubuntu.com
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

On Mon, Nov 29, 2021 at 01:46:57PM -0600, Mike Christie wrote:
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


So who's merging this? Me? Did all patches get acked by appropriate
maintainers?

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

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
