Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC69D2CCC2
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713423677; cv=none; b=RVcr9bJadT6PB7YNHTUgIRZGsj6ZUJn6JrjYHd+shSByCK8LlvAn0tUc+YXZ6NUTcOmojLQs4B6N8OVgIhDw1BjrSeuPExzQwlC3UD7zQIdsfEaSDw4P5uKXV2vJlLr8b+j1NDI7AIzMnyRmFNww2T9HK0n80mHmHYld67yly68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713423677; c=relaxed/simple;
	bh=3993xfPof64Hb4QLIVi9CQwUxRzHNgkffZ+zbDwPGc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Vx7iFAcZkzjUhoBsy7st5+ki6EK3m8kpGuU5ueDNunLxXEsY4MVE2FSeRrunBQIuFzDHUgqwpe1I+BygcasPgDcaOR1sUn/UoevwJQwt7NLIQJcYf+yfpBqwb+3wQPz586XTxER9O6Yh1KpYgV08r623Uw2lfs8ZJMuLm1hCVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M8WaN8PB; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8WaN8PB"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F56981F31
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:01:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TEag49Bg513z for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Apr 2024 07:01:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F2E4E80F00
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F2E4E80F00
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M8WaN8PB
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F2E4E80F00
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713423672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v30OwbEX4TC4WFCH5oVRFg8GSG48rN+H4hwtjldgncg=;
	b=M8WaN8PBl+jZgh1FkTq7X8FRfvMMl+Qw4BPIcKczyz+V6G6e/OHJF7q/DPA6dVjfZxIkR6
	WJqIoFYbkKMI2L9f1bpP9MrcQqVYNdyNtI8mO9Et/b2185hr2dQoJqEhP+dBV75q9Y97bc
	PVl79bKgUiSy+K1gD8rR28J4BuKHWME=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-JY-3afzoNxCFpmQ1DnvQiw-1; Thu, 18 Apr 2024 03:01:11 -0400
X-MC-Unique: JY-3afzoNxCFpmQ1DnvQiw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3473168c856so338532f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 00:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713423670; x=1714028470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v30OwbEX4TC4WFCH5oVRFg8GSG48rN+H4hwtjldgncg=;
        b=iKKLb1aRCHhS4p/0Tva6Bzoi6uCr7fgPwhW+RbAKVTx1aB4cSNzH1LgWeLN1kC1kjD
         3slVV9xeTNW+ZlWmNxOA6fCK30z6T44C4cjIZksiCrBQn43uit+7LTsZ26OsSmyTOCDU
         Bl9xnH9p31tFd5U5thrx0MAGPr5tynxc3DKABsVrZpVklCSZObl+axbP3g8Bx4756Ecu
         GiKJsaBFiLkaPSLJsvNngdpsceQFDxzPxJFbxQ7+a/52Pi5TdTi5VWXvU03EEGfEJBLs
         YSozqCVg7nyfh88sMTtdHAHWlvXsx47rg7BOCVzozUqPIN+cQB1EanBxuTVEs/slWWm9
         LUIg==
X-Forwarded-Encrypted: i=1; AJvYcCUhnsgCuiFTtYMiG2wg/JobB2vRxh386DzYPIO1EodLcnapxv+u5qBDvJO2R8wQc2qy9o9nEVQRQ1xs2Xqpx8zhmoGedjbM4rNFMkwmORbZsR+esBqZWBaNTw==
X-Gm-Message-State: AOJu0YxbUjwzZR1gvwfhY2H72s7BF112r84n6sJ/r/9a08nOqxwdcmgc
	C7VWxblSMMVOmS15XKu6ASB4oitBb8S37ANqE78EtmylLVlIrbsiooVrMc3LysPWhB8fSDGmilc
	+MC25fTo5hl8dtxW9e6kjtkuy/A54IRLcVYY0Ah/eoaqeRb1Qw1qqGG/zw3wwx0kVzitHea3wKM
	WLpUI=
X-Received: by 2002:a5d:6111:0:b0:346:c7ed:22de with SMTP id v17-20020a5d6111000000b00346c7ed22demr836811wrt.14.1713423669748;
        Thu, 18 Apr 2024 00:01:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMZqoIOEjbpuNuM1Pn3hNgXvbqV1URZWR/5KvhsEPQcybsq+dP6SHFblWTiCnDTvSeuSc0rA==
X-Received: by 2002:a5d:6111:0:b0:346:c7ed:22de with SMTP id v17-20020a5d6111000000b00346c7ed22demr836785wrt.14.1713423669148;
        Thu, 18 Apr 2024 00:01:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1fc:1e9b:54cd:34ea:3dbb:5a75])
        by smtp.gmail.com with ESMTPSA id bf7-20020a0560001cc700b003439d2a5f99sm1030301wrb.55.2024.04.18.00.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:01:08 -0700 (PDT)
Date: Thu, 18 Apr 2024 03:01:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Jason Wang <jasowang@redhat.com>, oleg@redhat.com,
	ebiederm@xmission.com, virtualization@lists.linux-foundation.org,
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org,
	Andreas Karis <akaris@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
Message-ID: <20240417150923-mutt-send-email-mst@kernel.org>
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com>
 <9f75952f-c1a4-4483-8ec7-beddf022a821@oracle.com>
 <CACGkMEuY9cyCb+myzscHDetbfmDLZN-_JAFvZaAfrO0-Mc0FTA@mail.gmail.com>
 <06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com>
 <CACGkMEtm=YwQ6ZVyPGz+T=H2E8u6etv9OKbibtfMdzA7K6GibQ@mail.gmail.com>
 <CACGkMEumEd+5bEjKosK3jY8TxveEas+QAOVSCEiYsR56Ag3C0w@mail.gmail.com>
 <edc792c4-30c9-4065-bf09-657bd7766d04@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <edc792c4-30c9-4065-bf09-657bd7766d04@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Apr 17, 2024 at 11:03:07AM -0500, Mike Christie wrote:
> On 4/16/24 10:50 PM, Jason Wang wrote:
> > On Mon, Apr 15, 2024 at 4:52 PM Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On Sat, Apr 13, 2024 at 12:53 AM <michael.christie@oracle.com> wrote:
> >>>
> >>> On 4/11/24 10:28 PM, Jason Wang wrote:
> >>>> On Fri, Apr 12, 2024 at 12:19 AM Mike Christie
> >>>> <michael.christie@oracle.com> wrote:
> >>>>>
> >>>>> On 4/11/24 3:39 AM, Jason Wang wrote:
> >>>>>> On Sat, Mar 16, 2024 at 8:47 AM Mike Christie
> >>>>>> <michael.christie@oracle.com> wrote:
> >>>>>>>
> >>>>>>> The following patches were made over Linus's tree and also apply over
> >>>>>>> mst's vhost branch. The patches add the ability for vhost_tasks to
> >>>>>>> handle SIGKILL by flushing queued works, stop new works from being
> >>>>>>> queued, and prepare the task for an early exit.
> >>>>>>>
> >>>>>>> This removes the need for the signal/coredump hacks added in:
> >>>>>>>
> >>>>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> >>>>>>>
> >>>>>>> when the vhost_task patches were initially merged and fix the issue
> >>>>>>> in this thread:
> >>>>>>>
> >>>>>>> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
> >>>>>>>
> >>>>>>> Long Background:
> >>>>>>>
> >>>>>>> The original vhost worker code didn't support any signals. If the
> >>>>>>> userspace application that owned the worker got a SIGKILL, the app/
> >>>>>>> process would exit dropping all references to the device and then the
> >>>>>>> file operation's release function would be called. From there we would
> >>>>>>> wait on running IO then cleanup the device's memory.
> >>>>>>
> >>>>>> A dumb question.
> >>>>>>
> >>>>>> Is this a user space noticeable change? For example, with this series
> >>>>>> a SIGKILL may shutdown the datapath ...
> >>>>>
> >>>>> It already changed in 6.4. We basically added a new interface to shutdown
> >>>>> everything (userspace and vhost kernel parts). So we won't just shutdown
> >>>>> the data path while userspace is still running. We will shutdown everything
> >>>>> now if you send a SIGKILL to a vhost worker's thread.
> >>>>
> >>>> If I understand correctly, for example Qemu can still live is SIGKILL
> >>>> is just send to vhost thread.
> >>>
> >>> Pre-6.4 qemu could still survive if only the vhost thread got a SIGKILL.
> >>> We used kthreads which are special and can ignore it like how userspace
> >>> can ignore SIGHUP.
> >>>
> >>> 6.4 and newer kernels cannot survive. Even if the vhost thread sort of
> >>> ignores it like I described below where, the signal is still delivered
> >>> to the other qemu threads due to the shared signal handler. Userspace
> >>> can't ignore SIGKILL. It doesn't have any say in the matter, and the
> >>> kernel forces them to exit.
> >>
> >> Ok, I see, so the reason is that vhost belongs to the same thread
> >> group as the owner now.
> >>
> >>>
> >>>>
> >>>> If this is correct, guests may detect this (for example virtio-net has
> >>>> a watchdog).
> >>>>
> >>>
> >>> What did you mean by that part? Do you mean if the vhost thread were to
> >>> exit, so drivers/vhost/net.c couldn't process IO, then the watchdog in
> >>> the guest (virtio-net driver in the guest kernel) would detect that?
> >>
> >> I meant this one. But since we are using CLONE_THREAD, we won't see these.
> >>
> >>> Or
> >>> are you saying the watchdog in the guest can detect signals that the
> >>> host gets?
> >>>
> >>>
> >>>>>
> >>>>> Here are a lots of details:
> >>>>>
> >>>>> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent any signal
> >>>>> to a vhost worker, we ignore it. Nothing happens. kthreads are special and
> >>>>> can ignore all signals.
> >>>>>
> >>>>> You could think of it as the worker is a completely different process than
> >>>>> qemu/userspace so they have completely different signal handlers. The
> >>>>> vhost worker signal handler ignores all signals even SIGKILL.
> >>>>
> >>>> Yes.
> >>>>
> >>>>>
> >>>>> If you send a SIGKILL to a qemu thread, then it just exits right away. We
> >>>>> don't get to do an explicit close() on the vhost device and we don't get
> >>>>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kernel exit
> >>>>> code runs and releases refcounts on the device/file, then the vhost device's
> >>>>> file_operations->release function is called. vhost_dev_cleanup then stops
> >>>>> the vhost worker.
> >>>>
> >>>> Right.
> >>>>
> >>>>>
> >>>>> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so the worker
> >>>>> can be thought of as a thread within the userspace process. With that
> >>>>> change we have the same signal handler as the userspace process.
> >>>>>
> >>>>> If you send a SIGKILL to a qemu thread then it works like above.
> >>>>>
> >>>>> If you send a SIGKILL to a vhost worker, the vhost worker still sort of
> >>>>> ignores it (that is the hack that I mentioned at the beginning of this
> >>>>> thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
> >>>>> then just continue to process works until file_operations->release
> >>>>> calls
> >>>>
> >>>> Yes, so this sticks to the behaviour before vhost_tasks.
> >>>
> >>> Not exactly. The vhost_task stays alive temporarily.
> >>>
> >>> The signal is still delivered to the userspace threads and they will
> >>> exit due to getting the SIGKILL also. SIGKILL goes to all the threads in
> >>> the process and all userspace threads exit like normal because the vhost
> >>> task and normal old userspace threads share a signal handler. When
> >>> userspace exits, the kernel force drops the refcounts on the vhost
> >>> devices and that runs the release function so the vhost_task will then exit.
> >>>
> >>> So what I'm trying to say is that in 6.4 we already changed the behavior.
> >>
> >> Yes. To say the truth, it looks even worse but it might be too late to fix.
> > 
> > Andres (cced) has identified two other possible changes:
> > 
> > 1) doesn't run in the global PID namespace but run in the namespace of owner
> 
> Yeah, I mentioned that one in vhost.h like it's a feature and when posting
> the patches I mentioned it as a possible fix. I mean I thought we wanted it
> to work like qemu and iothreads where the iothread would inherit all those
> values automatically.
> 
> At the time, I thought we didn't inherit the namespace, like we did the cgroup,
> because there was no kernel function for it (like how we didn't inherit v2
> cgroups until recently when someone added some code for that).
> 
> I don't know if it's allowed to have something like qemu in namespace N but then
> have it's children (vhost thread in this case) in the global namespace. I'll
> look into it.

Yea a big if.

> > 2) doesn't inherit kthreadd's scheduling attributes but the owner
> 
> Same as above for this one. I thought I was fixing a bug where before
> we had to manually tune the vhost thread's values but for iothreads they
> automatically got setup.
> 
> Just to clarify this one. When we used kthreads, kthread() will reset the
> scheduler priority for the kthread that's created, so we got the default
> values instead of inheriting kthreadd's values.  So we would want:
> 
> +	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> 
> in vhost_task_fn() instead of inheriting kthreadd's values.
> 
> > 
> > Though such a change makes more sense for some use cases, it may break others.
> > 
> > I wonder if we need to introduce a new flag and bring the old kthread
> 
> Do you mean something like a module param?
> 
> > codes if the flag is not set? Then we would not end up trying to align
> > the behaviour?
> >
> 
> Let me know what you guys prefer. The sched part is easy. The namespace
> part might be more difficult, but I will look into it if you want it.

