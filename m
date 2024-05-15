Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC1E433AF
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757876; cv=none; b=ltHzSv5LmEwChxiSh1rntnKJocyxaegDCdf1dG8i8s6ZAsGI99PiaG+lCSWzuOfKiofQ3bu1rfzxTN01C6pG2EBMhVHgZXycH6ctAPs6TuUM6gWkXMV1W/g06vSjZxfLPoOyZJQzEYwNrviWEpTqn08EJ4SqSwh/1haepWD2SbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757876; c=relaxed/simple;
	bh=GvT8NCrVesMZP2mgD0/C0swu92HLpfu9trh8HLWs/k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=WzCgiLtnIHfqpLP4rkLeVBH3llcIIhxKwP+NovtpjTcYSyuQEsXSY6JN4Z3+fjm631lBzVbsQ5tPqE9Aqa8IISZ2q228igS+YzOyjuKqNb81hj+0rphyKq3RHyD6dYDZPmpHdWY4CscyqVh5BxJc/3yXP0ck9Kq/Icba/RkWT14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwxnbRw0; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwxnbRw0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCBB540515
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:24:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Av-UdCp0KI8a for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 07:24:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A5DA64050E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A5DA64050E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NwxnbRw0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A5DA64050E
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 07:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715757870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDuCvhPAYphD3kd+uzs1uSsfl4gWw/I4bZKVYbBMBIo=;
	b=NwxnbRw055dG0M5qD/iq6jcf6aGr83O4pxHiGYZTkASnR2zAeCAJTbJ+gScwTHaaLcBh6x
	xSzEFj9JcoGbLxkVVVZlfMTDGIBHsIjgIZephZ7XSHGZahneXDAnGBdB96AKuzsI31/yDN
	JwxX8c+MZZ5qZv3BCFmb9Nbf/vQBp/k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-yaBD4tFeN5KF2iZet50vtQ-1; Wed, 15 May 2024 03:24:19 -0400
X-MC-Unique: yaBD4tFeN5KF2iZet50vtQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42003993265so21821655e9.1
        for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 00:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715757858; x=1716362658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hDuCvhPAYphD3kd+uzs1uSsfl4gWw/I4bZKVYbBMBIo=;
        b=QR1laJt+2aoaQTl5zGlqP0O9u/0pXZDsuBXNOqbwloZxKFVmk0zA1lJAppyYnrvfFg
         Xi/aU1m9XOQO2v+Icki3c/mv+05WThxim4q1tt6/XkyAxagyjbJsit5oqfAfw8rKL3px
         jpuPV8y+5PPw1j7T3hQwWkL4AtcCFFFLUZdxXFpDL0AVU+tETSS7bxZXTZZEQ7NscBu9
         jtxa3bt0wTmfWSgEVWg0+pdvO2UrbsCxboyD2Tlp9Baz6asCoZyy1lwlm3ht7jJRbOhT
         K0NbqugSC2RabqJqoBhxwjkwGlQKMoPb3Os99OTQrwbMnnD/HPiSriREn2zoAQI0AO4T
         mlzA==
X-Forwarded-Encrypted: i=1; AJvYcCUwO8KKZWeFyH6keJcEouzAANnDKvpGDifChsBzBv2CjR3EQfn9K3KFajYeCDyZvZyOBWrHUI76vPFa4HKTPQSLBqwffD+XU8TMyb3OX0toR6u28PZLZ0g61w==
X-Gm-Message-State: AOJu0YyFVjcqFs0lvxgRfDjKdtDtIY4op5APLsRuovdudnFL20Uvd9B/
	xi+1w/FElGZav2rFd61BXbQMUduhvj+URBpf1h5h318srgUyEVKbjwuIvFvfASGfIfGz1Vmmfbh
	+Sz7A/9lzbPQ4S6GZlMVrf7w6/zuI0zRpcVDRMYJHDsHNsOL1+aWmewurSlryAIXy5ljE+ZTjcT
	5sPTs=
X-Received: by 2002:a05:600c:790:b0:41b:5944:d05c with SMTP id 5b1f17b1804b1-41feaa38608mr162167045e9.15.1715757857628;
        Wed, 15 May 2024 00:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmxoBx3H9dfCJ0QQd18aYJUzpvIsGFX4MLd0PWC0qH5IDzsXv/sStQHZbn0QnVta5FvP5W0A==
X-Received: by 2002:a05:600c:790:b0:41b:5944:d05c with SMTP id 5b1f17b1804b1-41feaa38608mr162166655e9.15.1715757856920;
        Wed, 15 May 2024 00:24:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:55e:463:726a:3c7c:48d4:74fe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm220112945e9.36.2024.05.15.00.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 00:24:16 -0700 (PDT)
Date: Wed, 15 May 2024 03:24:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Andreas Karis <akaris@redhat.com>,
	Mike Christie <michael.christie@oracle.com>, oleg@redhat.com,
	ebiederm@xmission.com, virtualization@lists.linux-foundation.org,
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
Message-ID: <20240515032050-mutt-send-email-mst@kernel.org>
References: <06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com>
 <CACGkMEtm=YwQ6ZVyPGz+T=H2E8u6etv9OKbibtfMdzA7K6GibQ@mail.gmail.com>
 <CACGkMEumEd+5bEjKosK3jY8TxveEas+QAOVSCEiYsR56Ag3C0w@mail.gmail.com>
 <edc792c4-30c9-4065-bf09-657bd7766d04@oracle.com>
 <CACGkMEsH=+e+E234KymEdvZT-4K37X3iEmTKpvqGpMvSPkzRLQ@mail.gmail.com>
 <20240418030112-mutt-send-email-mst@kernel.org>
 <CAFZ-RRMMbwN=TwBsEJ_L98yH5+EmXcH8Oq0gjZ=8PU6kDn4=Rg@mail.gmail.com>
 <CACGkMEtA+n3=EmJ+ykK9eUZwUBjKRUB0sT0UG59zmeG99p3VeQ@mail.gmail.com>
 <CACGkMEvO1D4QJnMncOEZYqAtNO5ZujcWJ_FXDrb+7C__3WFjXw@mail.gmail.com>
 <CACGkMEs-urygu=h4_Y75ojwCKvRXH39fr-HpSTHchT8eL7issA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs-urygu=h4_Y75ojwCKvRXH39fr-HpSTHchT8eL7issA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 15, 2024 at 02:27:32PM +0800, Jason Wang wrote:
> On Fri, Apr 19, 2024 at 8:40 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Fri, Apr 19, 2024 at 8:37 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 5:26 PM Andreas Karis <akaris@redhat.com> wrote:
> > > >
> > > > Not a kernel developer, so sorry if this here is pointless spam.
> > > >
> > > > But qemu is not the only thing consuming /dev/vhost-net:
> > > > https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html
> > > >
> > > > Before the series of patches around
> > > > https://github.com/torvalds/linux/commit/e297cd54b3f81d652456ae6cb93941fc6b5c6683,
> > > > you would run a DPDK application inside namespaces of container
> > > > "blue", but then the vhost-... threads were spawned as children of
> > > > kthreadd and run in the global namespaces. That seemed counter
> > > > intuitive, and what's worse, the DPDK application running inside the
> > > > "blue" container namespaces cannot see and thus cannot modify
> > > > scheduling attributes and affinity of its own vhost-... threads. In
> > > > scenarios with pretty strict isolation/pinning requirements, the
> > > > vhost-... threads could easily be scheduled on the same CPUs as the
> > > > DPDK poll mode drivers (because they inherit the calling process' CPU
> > > > affinity), and there's no way for the DPDK process itself to move the
> > > > vhost-... threads to other CPUs. Also, if the DPDK process ran as
> > > > SCHED_RR, the vhost-.... thread would still be SCHED_NORMAL.
> > > >
> > > > After the patch series, the fact that the vhost-... threads run as
> > > > tasks of the process that requests them seems more natural and gives
> > > > us as users the kind of control that we'd want from within the
> > > > container to modify the vhost-... threads' scheduling and affinity.
> > > > The vhost-... thread as a child of the DPDK application inherits the
> > > > same scheduling class, CPU set, etc and the DPDK process can easily
> > > > change those attributes.
> > > >
> > > > However, if another user was used to the old behavior, and their
> > > > entire tooling was created for the old behavior (imagine someone wrote
> > > > a bunch of scripts/services to force affinity from the global PID
> > > > namespace for those vhost-... threads), and now this change was
> > > > introduced, it would break their tooling. So because _I_ might fancy
> > > > the new behavior, but user _B_ might be all set up for the old
> > > > kthreadd, shouldn't there be a flag or configuration for the user to:
> > > >
> > > > if (new_flag)
> > > >     vhost_task_create()
> > > > else
> > > >     kthread_create()
> > > >
> > > > I don't know what kind of flag or knob I'd expect here, but it could
> > > > be granular for the calling process (a new syscall?), or a kernel
> > > > flag, etc. But something that let's the admin choose how the kernel
> > > > spawns the vhost-... threads?
> > >
> > > A flag via uAPI that could be controlled by the user of vhost-net via
> > > syscall. For example, it could be done via set/get_backend_feautre()
> > > syscall.
> >
> > So it can be controlled by the admin if we want.
> >
> > Thanks
> 
> Michael, does the flag make sense or not?
> 
> Thanks

So you want a flag to bring back the pre-6.4 behaviour?
Given the behaviour has been in an upstream kernel already,
I'd be inclined to say let's wait until there's an actual
report of a follout, and then look for work-arounds.
Otherwise we don't really know if we are even fixing anything.

> >
> > >
> > > Thanks
> > >
> > > >
> > > > On Thu, Apr 18, 2024 at 9:07 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Thu, Apr 18, 2024 at 12:08:52PM +0800, Jason Wang wrote:
> > > > > > On Thu, Apr 18, 2024 at 12:10 AM Mike Christie
> > > > > > <michael.christie@oracle.com> wrote:
> > > > > > >
> > > > > > > On 4/16/24 10:50 PM, Jason Wang wrote:
> > > > > > > > On Mon, Apr 15, 2024 at 4:52 PM Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > >>
> > > > > > > >> On Sat, Apr 13, 2024 at 12:53 AM <michael.christie@oracle.com> wrote:
> > > > > > > >>>
> > > > > > > >>> On 4/11/24 10:28 PM, Jason Wang wrote:
> > > > > > > >>>> On Fri, Apr 12, 2024 at 12:19 AM Mike Christie
> > > > > > > >>>> <michael.christie@oracle.com> wrote:
> > > > > > > >>>>>
> > > > > > > >>>>> On 4/11/24 3:39 AM, Jason Wang wrote:
> > > > > > > >>>>>> On Sat, Mar 16, 2024 at 8:47 AM Mike Christie
> > > > > > > >>>>>> <michael.christie@oracle.com> wrote:
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> The following patches were made over Linus's tree and also apply over
> > > > > > > >>>>>>> mst's vhost branch. The patches add the ability for vhost_tasks to
> > > > > > > >>>>>>> handle SIGKILL by flushing queued works, stop new works from being
> > > > > > > >>>>>>> queued, and prepare the task for an early exit.
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> This removes the need for the signal/coredump hacks added in:
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> when the vhost_task patches were initially merged and fix the issue
> > > > > > > >>>>>>> in this thread:
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> Long Background:
> > > > > > > >>>>>>>
> > > > > > > >>>>>>> The original vhost worker code didn't support any signals. If the
> > > > > > > >>>>>>> userspace application that owned the worker got a SIGKILL, the app/
> > > > > > > >>>>>>> process would exit dropping all references to the device and then the
> > > > > > > >>>>>>> file operation's release function would be called. From there we would
> > > > > > > >>>>>>> wait on running IO then cleanup the device's memory.
> > > > > > > >>>>>>
> > > > > > > >>>>>> A dumb question.
> > > > > > > >>>>>>
> > > > > > > >>>>>> Is this a user space noticeable change? For example, with this series
> > > > > > > >>>>>> a SIGKILL may shutdown the datapath ...
> > > > > > > >>>>>
> > > > > > > >>>>> It already changed in 6.4. We basically added a new interface to shutdown
> > > > > > > >>>>> everything (userspace and vhost kernel parts). So we won't just shutdown
> > > > > > > >>>>> the data path while userspace is still running. We will shutdown everything
> > > > > > > >>>>> now if you send a SIGKILL to a vhost worker's thread.
> > > > > > > >>>>
> > > > > > > >>>> If I understand correctly, for example Qemu can still live is SIGKILL
> > > > > > > >>>> is just send to vhost thread.
> > > > > > > >>>
> > > > > > > >>> Pre-6.4 qemu could still survive if only the vhost thread got a SIGKILL.
> > > > > > > >>> We used kthreads which are special and can ignore it like how userspace
> > > > > > > >>> can ignore SIGHUP.
> > > > > > > >>>
> > > > > > > >>> 6.4 and newer kernels cannot survive. Even if the vhost thread sort of
> > > > > > > >>> ignores it like I described below where, the signal is still delivered
> > > > > > > >>> to the other qemu threads due to the shared signal handler. Userspace
> > > > > > > >>> can't ignore SIGKILL. It doesn't have any say in the matter, and the
> > > > > > > >>> kernel forces them to exit.
> > > > > > > >>
> > > > > > > >> Ok, I see, so the reason is that vhost belongs to the same thread
> > > > > > > >> group as the owner now.
> > > > > > > >>
> > > > > > > >>>
> > > > > > > >>>>
> > > > > > > >>>> If this is correct, guests may detect this (for example virtio-net has
> > > > > > > >>>> a watchdog).
> > > > > > > >>>>
> > > > > > > >>>
> > > > > > > >>> What did you mean by that part? Do you mean if the vhost thread were to
> > > > > > > >>> exit, so drivers/vhost/net.c couldn't process IO, then the watchdog in
> > > > > > > >>> the guest (virtio-net driver in the guest kernel) would detect that?
> > > > > > > >>
> > > > > > > >> I meant this one. But since we are using CLONE_THREAD, we won't see these.
> > > > > > > >>
> > > > > > > >>> Or
> > > > > > > >>> are you saying the watchdog in the guest can detect signals that the
> > > > > > > >>> host gets?
> > > > > > > >>>
> > > > > > > >>>
> > > > > > > >>>>>
> > > > > > > >>>>> Here are a lots of details:
> > > > > > > >>>>>
> > > > > > > >>>>> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent any signal
> > > > > > > >>>>> to a vhost worker, we ignore it. Nothing happens. kthreads are special and
> > > > > > > >>>>> can ignore all signals.
> > > > > > > >>>>>
> > > > > > > >>>>> You could think of it as the worker is a completely different process than
> > > > > > > >>>>> qemu/userspace so they have completely different signal handlers. The
> > > > > > > >>>>> vhost worker signal handler ignores all signals even SIGKILL.
> > > > > > > >>>>
> > > > > > > >>>> Yes.
> > > > > > > >>>>
> > > > > > > >>>>>
> > > > > > > >>>>> If you send a SIGKILL to a qemu thread, then it just exits right away. We
> > > > > > > >>>>> don't get to do an explicit close() on the vhost device and we don't get
> > > > > > > >>>>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kernel exit
> > > > > > > >>>>> code runs and releases refcounts on the device/file, then the vhost device's
> > > > > > > >>>>> file_operations->release function is called. vhost_dev_cleanup then stops
> > > > > > > >>>>> the vhost worker.
> > > > > > > >>>>
> > > > > > > >>>> Right.
> > > > > > > >>>>
> > > > > > > >>>>>
> > > > > > > >>>>> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so the worker
> > > > > > > >>>>> can be thought of as a thread within the userspace process. With that
> > > > > > > >>>>> change we have the same signal handler as the userspace process.
> > > > > > > >>>>>
> > > > > > > >>>>> If you send a SIGKILL to a qemu thread then it works like above.
> > > > > > > >>>>>
> > > > > > > >>>>> If you send a SIGKILL to a vhost worker, the vhost worker still sort of
> > > > > > > >>>>> ignores it (that is the hack that I mentioned at the beginning of this
> > > > > > > >>>>> thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
> > > > > > > >>>>> then just continue to process works until file_operations->release
> > > > > > > >>>>> calls
> > > > > > > >>>>
> > > > > > > >>>> Yes, so this sticks to the behaviour before vhost_tasks.
> > > > > > > >>>
> > > > > > > >>> Not exactly. The vhost_task stays alive temporarily.
> > > > > > > >>>
> > > > > > > >>> The signal is still delivered to the userspace threads and they will
> > > > > > > >>> exit due to getting the SIGKILL also. SIGKILL goes to all the threads in
> > > > > > > >>> the process and all userspace threads exit like normal because the vhost
> > > > > > > >>> task and normal old userspace threads share a signal handler. When
> > > > > > > >>> userspace exits, the kernel force drops the refcounts on the vhost
> > > > > > > >>> devices and that runs the release function so the vhost_task will then exit.
> > > > > > > >>>
> > > > > > > >>> So what I'm trying to say is that in 6.4 we already changed the behavior.
> > > > > > > >>
> > > > > > > >> Yes. To say the truth, it looks even worse but it might be too late to fix.
> > > > > > > >
> > > > > > > > Andres (cced) has identified two other possible changes:
> > > > > > > >
> > > > > > > > 1) doesn't run in the global PID namespace but run in the namespace of owner
> > > > > > >
> > > > > > > Yeah, I mentioned that one in vhost.h like it's a feature and when posting
> > > > > > > the patches I mentioned it as a possible fix. I mean I thought we wanted it
> > > > > > > to work like qemu and iothreads where the iothread would inherit all those
> > > > > > > values automatically.
> > > > > >
> > > > > > Right, but it could be noticed by the userspace, especially for the
> > > > > > one that tries to do tweak on the performance.
> > > > > >
> > > > > > The root cause is the that now we do copy_processs() in the process of
> > > > > > Qemu instead of the kthreadd. Which result of the the differences of
> > > > > > namespace (I think PID namespace is not the only one we see
> > > > > > difference) and others for the vhost task.
> > > > >
> > > > > Leaking things out of a namespace looks more like a bug.
> > > > > If you really have to be pedantic, the thing to add would
> > > > > be a namespace flag not a qemu flag. Userspace running inside
> > > > > a namespace really must have no say about whether to leak
> > > > > info out of it.
> > > > >
> > > > > > >
> > > > > > > At the time, I thought we didn't inherit the namespace, like we did the cgroup,
> > > > > > > because there was no kernel function for it (like how we didn't inherit v2
> > > > > > > cgroups until recently when someone added some code for that).
> > > > > > >
> > > > > > > I don't know if it's allowed to have something like qemu in namespace N but then
> > > > > > > have it's children (vhost thread in this case) in the global namespace.
> > > > > > > I'll
> > > > > > > look into it.
> > > > > >
> > > > > > Instead of moving vhost thread between difference namespaces, I wonder
> > > > > > if the following is simpler:
> > > > > >
> > > > > > if (new_flag)
> > > > > >     vhost_task_create()
> > > > > > else
> > > > > >     kthread_create()
> > > > > >
> > > > > > New flag inherits the attributes of Qemu (namespaces, rlimit, cgroup,
> > > > > > scheduling attributes ...) which is what we want. Without the new
> > > > > > flag, we stick exactly to the behaviour as in the past to unbreak
> > > > > > existing userspace.
> > > > > >
> > > > > > >
> > > > > > > > 2) doesn't inherit kthreadd's scheduling attributes but the owner
> > > > > > >
> > > > > > > Same as above for this one. I thought I was fixing a bug where before
> > > > > > > we had to manually tune the vhost thread's values but for iothreads they
> > > > > > > automatically got setup.
> > > > > > >
> > > > > > > Just to clarify this one. When we used kthreads, kthread() will reset the
> > > > > > > scheduler priority for the kthread that's created, so we got the default
> > > > > > > values instead of inheriting kthreadd's values.  So we would want:
> > > > > > >
> > > > > > > +       sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> > > > > > >
> > > > > > > in vhost_task_fn() instead of inheriting kthreadd's values.
> > > > > > >
> > > > > > > >
> > > > > > > > Though such a change makes more sense for some use cases, it may break others.
> > > > > > > >
> > > > > > > > I wonder if we need to introduce a new flag and bring the old kthread
> > > > > > >
> > > > > > > Do you mean something like a module param?
> > > > > >
> > > > > > This requires the management layer to know if it has a new user space
> > > > > > or not which is hard. A better place is to introduce backend features.
> > > > > >
> > > > > > >
> > > > > > > > codes if the flag is not set? Then we would not end up trying to align
> > > > > > > > the behaviour?
> > > > > > > >
> > > > > > >
> > > > > > > Let me know what you guys prefer. The sched part is easy. The namespace
> > > > > > > part might be more difficult, but I will look into it if you want it.
> > > > > >
> > > > > > Thanks a lot. I think it would be better to have the namespace part
> > > > > > (as well as other namespaces) then we don't need to answer hard
> > > > > > questions like if it can break user space or not.
> > > > > >
> > > > > > >
> > > > >
> > > >

