Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3092D057
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713424074; cv=none; b=kHEiGaPMhzEeUH1SEu7mfUFwXHwMklpyvIYMWcBGN3pPpO51KeASLyrR1aO3f5GEnHUB8ZHZ2XnHGngDAKl/IBoOJKQRDvU7hF6ND4G0yD8VQ/IbjLkGjTiDL6cMqQw2SB2MCc4OUwmceeqGhM0Wl34XnB/vDssatLa9hGMIXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713424074; c=relaxed/simple;
	bh=FLbS8mBApMxSY5z2FDdJ1IdvfQ9i5+eWtSGzIXm4tlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OV/KYXbjiyTbtQ/nmiH0aXj9a6LfNg6Yry2f6HmMd0o79ode47D/945SB7Bpj+ZfpQUraVKELrm+4Z649eSjDz4lcMy8kU6lWcoYAsZr5rzbgQN9GXcJarz8mg3ALhj0IgYzSrV5W9fhMKkvyjoAbWDetTVorIryEkgtcsHcN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEZgr4RR; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEZgr4RR"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2526B60733
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:07:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CwRRxZLIHSgK for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Apr 2024 07:07:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org DC20960658
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DC20960658
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CEZgr4RR
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DC20960658
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 07:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713424068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZL8BHn/vcZec8zyYnqOaygL7IfMTxKzjAezdathMmD0=;
	b=CEZgr4RRlM7E9siFLGBsm+IktJSX/vc4slfITeutRY+Qg0xq/X7OWh/0IdzCOLCBqKURez
	0fOfQKBiTJ/LgQF4pHSEqOZx03brw2c0dz7gVMQM9p4WOhQqU2aq7MReJAVF+pB8Jz6Ozh
	AaZKHv8hO++pKP+SCpNT3d58N+QVuvQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-mpIpGnbeMzeCpqQn-94VnA-1; Thu, 18 Apr 2024 03:07:47 -0400
X-MC-Unique: mpIpGnbeMzeCpqQn-94VnA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-349cafdc8f0so318845f8f.1
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 00:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713424066; x=1714028866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL8BHn/vcZec8zyYnqOaygL7IfMTxKzjAezdathMmD0=;
        b=NC32kdy3CEPHxbO0qKbDFxybw5xrBjXXjr9VPPIm2UxshpRNqhF6deOTjCZHW+uB2O
         4Gmse/qMPlB9hAKeQDa20I+8pu1ThxLRNpMIMDwaAFL9rOQ5Y+FbZlWVTCUWFUNiguSq
         Vaff6plYp/DQvtpKKknND2xrPILBmzLbCZvtKpTCwcWl+kHmQQakrAoCyhrj+gfIijS3
         Q9X0jfKeMiZutM++KGMuxyjsIjI83wyztWto/ugVKFlq9JpMNSwQcffHkVMeeHZS9ADC
         sCWtzDlDx4n2HBWmoeoOwymTPncgGskjmz+TWrHFYMc3F9IMiCNSofUlB18CoUEGIQYG
         VAoA==
X-Forwarded-Encrypted: i=1; AJvYcCV8cDdA9j9KXWgPcfvnIbfuhGukEsqm5DVU8wmrRuJcM5Vj/+lD/ecAC4zNdi2PBOqxsddAHx7eQhkhydQACDj5rJPJO/9iGcq7yQkZGtkOM1aaNkyMCC4T6Q==
X-Gm-Message-State: AOJu0YzwNFpYyvaXRp5pMZDgkRDRgJcIszL79SU9mnmqdNozF4xB10Vi
	C0zASvogmTHL0/27iPLixf/mDx0KtLKjX6rlg5PgwhJsGBTIPpUoEbww+ajqyX2rGy5ZExgEcAl
	3/LnM4oYbTumfCWY8JrAKSWiVNZbsP1z7mJK9gchpIynia1/+0tXFImGQT8jfUpMUvUF+9uKC/N
	1Vd0Y=
X-Received: by 2002:adf:e541:0:b0:347:3d28:c872 with SMTP id z1-20020adfe541000000b003473d28c872mr1195534wrm.9.1713424065508;
        Thu, 18 Apr 2024 00:07:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/RDDI3VE9mSVzSBU/sn/yFVFrWXULKUWsv8iktKMmomF5QrG0/0pio9N4BliaVs+q0r7N6w==
X-Received: by 2002:adf:e541:0:b0:347:3d28:c872 with SMTP id z1-20020adfe541000000b003473d28c872mr1195503wrm.9.1713424064748;
        Thu, 18 Apr 2024 00:07:44 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1fc:1e9b:54cd:34ea:3dbb:5a75])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d5044000000b00343daeddcb2sm1047469wrt.45.2024.04.18.00.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 00:07:44 -0700 (PDT)
Date: Thu, 18 Apr 2024 03:07:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, oleg@redhat.com,
	ebiederm@xmission.com, virtualization@lists.linux-foundation.org,
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org,
	Andreas Karis <akaris@redhat.com>,
	Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
Message-ID: <20240418030112-mutt-send-email-mst@kernel.org>
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com>
 <9f75952f-c1a4-4483-8ec7-beddf022a821@oracle.com>
 <CACGkMEuY9cyCb+myzscHDetbfmDLZN-_JAFvZaAfrO0-Mc0FTA@mail.gmail.com>
 <06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com>
 <CACGkMEtm=YwQ6ZVyPGz+T=H2E8u6etv9OKbibtfMdzA7K6GibQ@mail.gmail.com>
 <CACGkMEumEd+5bEjKosK3jY8TxveEas+QAOVSCEiYsR56Ag3C0w@mail.gmail.com>
 <edc792c4-30c9-4065-bf09-657bd7766d04@oracle.com>
 <CACGkMEsH=+e+E234KymEdvZT-4K37X3iEmTKpvqGpMvSPkzRLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsH=+e+E234KymEdvZT-4K37X3iEmTKpvqGpMvSPkzRLQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Apr 18, 2024 at 12:08:52PM +0800, Jason Wang wrote:
> On Thu, Apr 18, 2024 at 12:10 AM Mike Christie
> <michael.christie@oracle.com> wrote:
> >
> > On 4/16/24 10:50 PM, Jason Wang wrote:
> > > On Mon, Apr 15, 2024 at 4:52 PM Jason Wang <jasowang@redhat.com> wrote:
> > >>
> > >> On Sat, Apr 13, 2024 at 12:53 AM <michael.christie@oracle.com> wrote:
> > >>>
> > >>> On 4/11/24 10:28 PM, Jason Wang wrote:
> > >>>> On Fri, Apr 12, 2024 at 12:19 AM Mike Christie
> > >>>> <michael.christie@oracle.com> wrote:
> > >>>>>
> > >>>>> On 4/11/24 3:39 AM, Jason Wang wrote:
> > >>>>>> On Sat, Mar 16, 2024 at 8:47 AM Mike Christie
> > >>>>>> <michael.christie@oracle.com> wrote:
> > >>>>>>>
> > >>>>>>> The following patches were made over Linus's tree and also apply over
> > >>>>>>> mst's vhost branch. The patches add the ability for vhost_tasks to
> > >>>>>>> handle SIGKILL by flushing queued works, stop new works from being
> > >>>>>>> queued, and prepare the task for an early exit.
> > >>>>>>>
> > >>>>>>> This removes the need for the signal/coredump hacks added in:
> > >>>>>>>
> > >>>>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> > >>>>>>>
> > >>>>>>> when the vhost_task patches were initially merged and fix the issue
> > >>>>>>> in this thread:
> > >>>>>>>
> > >>>>>>> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
> > >>>>>>>
> > >>>>>>> Long Background:
> > >>>>>>>
> > >>>>>>> The original vhost worker code didn't support any signals. If the
> > >>>>>>> userspace application that owned the worker got a SIGKILL, the app/
> > >>>>>>> process would exit dropping all references to the device and then the
> > >>>>>>> file operation's release function would be called. From there we would
> > >>>>>>> wait on running IO then cleanup the device's memory.
> > >>>>>>
> > >>>>>> A dumb question.
> > >>>>>>
> > >>>>>> Is this a user space noticeable change? For example, with this series
> > >>>>>> a SIGKILL may shutdown the datapath ...
> > >>>>>
> > >>>>> It already changed in 6.4. We basically added a new interface to shutdown
> > >>>>> everything (userspace and vhost kernel parts). So we won't just shutdown
> > >>>>> the data path while userspace is still running. We will shutdown everything
> > >>>>> now if you send a SIGKILL to a vhost worker's thread.
> > >>>>
> > >>>> If I understand correctly, for example Qemu can still live is SIGKILL
> > >>>> is just send to vhost thread.
> > >>>
> > >>> Pre-6.4 qemu could still survive if only the vhost thread got a SIGKILL.
> > >>> We used kthreads which are special and can ignore it like how userspace
> > >>> can ignore SIGHUP.
> > >>>
> > >>> 6.4 and newer kernels cannot survive. Even if the vhost thread sort of
> > >>> ignores it like I described below where, the signal is still delivered
> > >>> to the other qemu threads due to the shared signal handler. Userspace
> > >>> can't ignore SIGKILL. It doesn't have any say in the matter, and the
> > >>> kernel forces them to exit.
> > >>
> > >> Ok, I see, so the reason is that vhost belongs to the same thread
> > >> group as the owner now.
> > >>
> > >>>
> > >>>>
> > >>>> If this is correct, guests may detect this (for example virtio-net has
> > >>>> a watchdog).
> > >>>>
> > >>>
> > >>> What did you mean by that part? Do you mean if the vhost thread were to
> > >>> exit, so drivers/vhost/net.c couldn't process IO, then the watchdog in
> > >>> the guest (virtio-net driver in the guest kernel) would detect that?
> > >>
> > >> I meant this one. But since we are using CLONE_THREAD, we won't see these.
> > >>
> > >>> Or
> > >>> are you saying the watchdog in the guest can detect signals that the
> > >>> host gets?
> > >>>
> > >>>
> > >>>>>
> > >>>>> Here are a lots of details:
> > >>>>>
> > >>>>> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent any signal
> > >>>>> to a vhost worker, we ignore it. Nothing happens. kthreads are special and
> > >>>>> can ignore all signals.
> > >>>>>
> > >>>>> You could think of it as the worker is a completely different process than
> > >>>>> qemu/userspace so they have completely different signal handlers. The
> > >>>>> vhost worker signal handler ignores all signals even SIGKILL.
> > >>>>
> > >>>> Yes.
> > >>>>
> > >>>>>
> > >>>>> If you send a SIGKILL to a qemu thread, then it just exits right away. We
> > >>>>> don't get to do an explicit close() on the vhost device and we don't get
> > >>>>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kernel exit
> > >>>>> code runs and releases refcounts on the device/file, then the vhost device's
> > >>>>> file_operations->release function is called. vhost_dev_cleanup then stops
> > >>>>> the vhost worker.
> > >>>>
> > >>>> Right.
> > >>>>
> > >>>>>
> > >>>>> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so the worker
> > >>>>> can be thought of as a thread within the userspace process. With that
> > >>>>> change we have the same signal handler as the userspace process.
> > >>>>>
> > >>>>> If you send a SIGKILL to a qemu thread then it works like above.
> > >>>>>
> > >>>>> If you send a SIGKILL to a vhost worker, the vhost worker still sort of
> > >>>>> ignores it (that is the hack that I mentioned at the beginning of this
> > >>>>> thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
> > >>>>> then just continue to process works until file_operations->release
> > >>>>> calls
> > >>>>
> > >>>> Yes, so this sticks to the behaviour before vhost_tasks.
> > >>>
> > >>> Not exactly. The vhost_task stays alive temporarily.
> > >>>
> > >>> The signal is still delivered to the userspace threads and they will
> > >>> exit due to getting the SIGKILL also. SIGKILL goes to all the threads in
> > >>> the process and all userspace threads exit like normal because the vhost
> > >>> task and normal old userspace threads share a signal handler. When
> > >>> userspace exits, the kernel force drops the refcounts on the vhost
> > >>> devices and that runs the release function so the vhost_task will then exit.
> > >>>
> > >>> So what I'm trying to say is that in 6.4 we already changed the behavior.
> > >>
> > >> Yes. To say the truth, it looks even worse but it might be too late to fix.
> > >
> > > Andres (cced) has identified two other possible changes:
> > >
> > > 1) doesn't run in the global PID namespace but run in the namespace of owner
> >
> > Yeah, I mentioned that one in vhost.h like it's a feature and when posting
> > the patches I mentioned it as a possible fix. I mean I thought we wanted it
> > to work like qemu and iothreads where the iothread would inherit all those
> > values automatically.
> 
> Right, but it could be noticed by the userspace, especially for the
> one that tries to do tweak on the performance.
> 
> The root cause is the that now we do copy_processs() in the process of
> Qemu instead of the kthreadd. Which result of the the differences of
> namespace (I think PID namespace is not the only one we see
> difference) and others for the vhost task.

Leaking things out of a namespace looks more like a bug.
If you really have to be pedantic, the thing to add would
be a namespace flag not a qemu flag. Userspace running inside
a namespace really must have no say about whether to leak
info out of it.

> >
> > At the time, I thought we didn't inherit the namespace, like we did the cgroup,
> > because there was no kernel function for it (like how we didn't inherit v2
> > cgroups until recently when someone added some code for that).
> >
> > I don't know if it's allowed to have something like qemu in namespace N but then
> > have it's children (vhost thread in this case) in the global namespace.
> > I'll
> > look into it.
> 
> Instead of moving vhost thread between difference namespaces, I wonder
> if the following is simpler:
> 
> if (new_flag)
>     vhost_task_create()
> else
>     kthread_create()
> 
> New flag inherits the attributes of Qemu (namespaces, rlimit, cgroup,
> scheduling attributes ...) which is what we want. Without the new
> flag, we stick exactly to the behaviour as in the past to unbreak
> existing userspace.
> 
> >
> > > 2) doesn't inherit kthreadd's scheduling attributes but the owner
> >
> > Same as above for this one. I thought I was fixing a bug where before
> > we had to manually tune the vhost thread's values but for iothreads they
> > automatically got setup.
> >
> > Just to clarify this one. When we used kthreads, kthread() will reset the
> > scheduler priority for the kthread that's created, so we got the default
> > values instead of inheriting kthreadd's values.  So we would want:
> >
> > +       sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> >
> > in vhost_task_fn() instead of inheriting kthreadd's values.
> >
> > >
> > > Though such a change makes more sense for some use cases, it may break others.
> > >
> > > I wonder if we need to introduce a new flag and bring the old kthread
> >
> > Do you mean something like a module param?
> 
> This requires the management layer to know if it has a new user space
> or not which is hard. A better place is to introduce backend features.
> 
> >
> > > codes if the flag is not set? Then we would not end up trying to align
> > > the behaviour?
> > >
> >
> > Let me know what you guys prefer. The sched part is easy. The namespace
> > part might be more difficult, but I will look into it if you want it.
> 
> Thanks a lot. I think it would be better to have the namespace part
> (as well as other namespaces) then we don't need to answer hard
> questions like if it can break user space or not.
> 
> >

