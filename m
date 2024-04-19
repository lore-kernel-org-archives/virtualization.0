Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3CA322E
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Apr 2024 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487227; cv=none; b=X0xWuYjaa6OnsGYwszVMoMdt06aGB1dUlplyR6+bcQPSImG8aF6UuTnQLaqFK72H0N+DG59ucgRTaTJmQuzlpFMvbMvPRvScGe6Tw9rZ2SrwsSfDwcb4MI4EBijTyHgS3bxRuFfgaItn8+LbPnZ2hyhbe6OhDxpJF7h1D3vqdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487227; c=relaxed/simple;
	bh=N0bulSVUJloo00iKs7V5qRtQz/v0UIpkUJsAZGytpPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+uAU8Lw+TPUV/fAc1JRBLLMo7BWO6zMkNPxEZM245SasC6gWJcJzB7tyxuS65uOWiFZtv8gwXQkb8sha+lnd08CQr0uONrbGXjGN6gG6rskJmT6OKgnUtXzGAgR/7x4+d9M0OcC7aFSzKVtT+UkcIsywTo0TWj9zhEDaPnNw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDofSnqK; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDofSnqK"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 284D8402E5
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Apr 2024 00:40:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Go08gFkXRp5d for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Apr 2024 00:40:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EA0964023E
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA0964023E
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QDofSnqK
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EA0964023E
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Apr 2024 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713487221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hOoCPcHXwdCasfmnr7G+9vqHA3vI2dtqrJe2QKxUoE=;
	b=QDofSnqKH/AjA6hPZ8fpn4u/14szyEcbIPHcl6sZ6LPXPi8X32vDlH3eonGXLSu8c4YXFM
	POgvVU00k0SIsHt9B54hz/uhiy2vYAFz/ayHNeEJ4gMg+GKsEIIQU55BVpAkS85iAnMqgz
	nXkqLaodHSNa1KZRdLSLavCEavzLfCM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-nZvxw-nCNDqGdDNy4kX1RA-1; Thu, 18 Apr 2024 20:40:20 -0400
X-MC-Unique: nZvxw-nCNDqGdDNy4kX1RA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a4f59746f7so1686946a91.1
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 17:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713487219; x=1714092019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/hOoCPcHXwdCasfmnr7G+9vqHA3vI2dtqrJe2QKxUoE=;
        b=d0o2xALifJ/9PwbkCwhfiwY7eDK6C5/+k6+oYg5szIPF7o6rV6hoo9lcbNKYuZZorA
         UqkHe5kD4ude1Ys18ROqhyEXwlL1RUMfA9RnNFC/YMOfTlmBhCcmpJ7J7XDnKBKsCLZk
         MisFSIqfOnujtS02bwKYw/jeFdZwwW2ly83bd+eRFIYr+2AJx2j0hPIpWh4g8Gjuw9wk
         9djNtzOd5bYo8w3EM14OUk0kmXzmVaEXT8l09/IWVQUVccNIGjEBIXwPB9TnTOHDa+tQ
         ZICS8jYH7cj66PIL8Yvu0ZDcgDDjfr894J57billXJ3TcBisVi0Fv/kg8PJxj2p8aP7j
         94pQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2euhbhYMc4UTHjGCDG9i88iT3NPxp+AY4kN9XK70FLyU8KGMtBxHiCq8bUjwRJUu3uLuo/ZvkXi/VthBGq1BXhLM2MYoorHvqCNiuZFFHD4fdKp8uM2gsZw==
X-Gm-Message-State: AOJu0YxifmrTiJOGxb3yC2vGt08PRHZgFk8Hs97X/bH884xmO5luZQqA
	29MPdd21kdqNzosY9M8UK3Coz58Qn2OFe+swYf4Tn4Rl5jviGHM+GWSuzKgylz0MiLAk/JL9IHQ
	miC+p2/uG8vzOW8VVQ3n5lWEOQkeekAGVK9/gA3wkWFTuf4goYTI/HsVchhwpVb/GtnQsd6hmK4
	CdIJLlQitQ2+KrJbO/yzlyYKB8Bh/Ujj0NJwIbwGikkJPrX4F+D0roTQ==
X-Received: by 2002:a17:90b:1c0e:b0:29d:eea9:c800 with SMTP id oc14-20020a17090b1c0e00b0029deea9c800mr800018pjb.7.1713487219230;
        Thu, 18 Apr 2024 17:40:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6+kYUb7tAngetZi9LkPhIxsJDv8hhl6K8dXEr3Bz/t+xKvBDjqr4bY0U4aXGJQ/XH/AtQ3kBIvVyuXWmptMQ=
X-Received: by 2002:a17:90b:1c0e:b0:29d:eea9:c800 with SMTP id
 oc14-20020a17090b1c0e00b0029deea9c800mr799995pjb.7.1713487218809; Thu, 18 Apr
 2024 17:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com>
 <9f75952f-c1a4-4483-8ec7-beddf022a821@oracle.com> <CACGkMEuY9cyCb+myzscHDetbfmDLZN-_JAFvZaAfrO0-Mc0FTA@mail.gmail.com>
 <06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com> <CACGkMEtm=YwQ6ZVyPGz+T=H2E8u6etv9OKbibtfMdzA7K6GibQ@mail.gmail.com>
 <CACGkMEumEd+5bEjKosK3jY8TxveEas+QAOVSCEiYsR56Ag3C0w@mail.gmail.com>
 <edc792c4-30c9-4065-bf09-657bd7766d04@oracle.com> <CACGkMEsH=+e+E234KymEdvZT-4K37X3iEmTKpvqGpMvSPkzRLQ@mail.gmail.com>
 <20240418030112-mutt-send-email-mst@kernel.org> <CAFZ-RRMMbwN=TwBsEJ_L98yH5+EmXcH8Oq0gjZ=8PU6kDn4=Rg@mail.gmail.com>
 <CACGkMEtA+n3=EmJ+ykK9eUZwUBjKRUB0sT0UG59zmeG99p3VeQ@mail.gmail.com>
In-Reply-To: <CACGkMEtA+n3=EmJ+ykK9eUZwUBjKRUB0sT0UG59zmeG99p3VeQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Apr 2024 08:40:07 +0800
Message-ID: <CACGkMEvO1D4QJnMncOEZYqAtNO5ZujcWJ_FXDrb+7C__3WFjXw@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: Andreas Karis <akaris@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Mike Christie <michael.christie@oracle.com>, oleg@redhat.com, 
	ebiederm@xmission.com, virtualization@lists.linux-foundation.org, 
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 8:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Thu, Apr 18, 2024 at 5:26=E2=80=AFPM Andreas Karis <akaris@redhat.com>=
 wrote:
> >
> > Not a kernel developer, so sorry if this here is pointless spam.
> >
> > But qemu is not the only thing consuming /dev/vhost-net:
> > https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html
> >
> > Before the series of patches around
> > https://github.com/torvalds/linux/commit/e297cd54b3f81d652456ae6cb93941=
fc6b5c6683,
> > you would run a DPDK application inside namespaces of container
> > "blue", but then the vhost-... threads were spawned as children of
> > kthreadd and run in the global namespaces. That seemed counter
> > intuitive, and what's worse, the DPDK application running inside the
> > "blue" container namespaces cannot see and thus cannot modify
> > scheduling attributes and affinity of its own vhost-... threads. In
> > scenarios with pretty strict isolation/pinning requirements, the
> > vhost-... threads could easily be scheduled on the same CPUs as the
> > DPDK poll mode drivers (because they inherit the calling process' CPU
> > affinity), and there's no way for the DPDK process itself to move the
> > vhost-... threads to other CPUs. Also, if the DPDK process ran as
> > SCHED_RR, the vhost-.... thread would still be SCHED_NORMAL.
> >
> > After the patch series, the fact that the vhost-... threads run as
> > tasks of the process that requests them seems more natural and gives
> > us as users the kind of control that we'd want from within the
> > container to modify the vhost-... threads' scheduling and affinity.
> > The vhost-... thread as a child of the DPDK application inherits the
> > same scheduling class, CPU set, etc and the DPDK process can easily
> > change those attributes.
> >
> > However, if another user was used to the old behavior, and their
> > entire tooling was created for the old behavior (imagine someone wrote
> > a bunch of scripts/services to force affinity from the global PID
> > namespace for those vhost-... threads), and now this change was
> > introduced, it would break their tooling. So because _I_ might fancy
> > the new behavior, but user _B_ might be all set up for the old
> > kthreadd, shouldn't there be a flag or configuration for the user to:
> >
> > if (new_flag)
> >     vhost_task_create()
> > else
> >     kthread_create()
> >
> > I don't know what kind of flag or knob I'd expect here, but it could
> > be granular for the calling process (a new syscall?), or a kernel
> > flag, etc. But something that let's the admin choose how the kernel
> > spawns the vhost-... threads?
>
> A flag via uAPI that could be controlled by the user of vhost-net via
> syscall. For example, it could be done via set/get_backend_feautre()
> syscall.

So it can be controlled by the admin if we want.

Thanks

>
> Thanks
>
> >
> > On Thu, Apr 18, 2024 at 9:07=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com> wrote:
> > >
> > > On Thu, Apr 18, 2024 at 12:08:52PM +0800, Jason Wang wrote:
> > > > On Thu, Apr 18, 2024 at 12:10=E2=80=AFAM Mike Christie
> > > > <michael.christie@oracle.com> wrote:
> > > > >
> > > > > On 4/16/24 10:50 PM, Jason Wang wrote:
> > > > > > On Mon, Apr 15, 2024 at 4:52=E2=80=AFPM Jason Wang <jasowang@re=
dhat.com> wrote:
> > > > > >>
> > > > > >> On Sat, Apr 13, 2024 at 12:53=E2=80=AFAM <michael.christie@ora=
cle.com> wrote:
> > > > > >>>
> > > > > >>> On 4/11/24 10:28 PM, Jason Wang wrote:
> > > > > >>>> On Fri, Apr 12, 2024 at 12:19=E2=80=AFAM Mike Christie
> > > > > >>>> <michael.christie@oracle.com> wrote:
> > > > > >>>>>
> > > > > >>>>> On 4/11/24 3:39 AM, Jason Wang wrote:
> > > > > >>>>>> On Sat, Mar 16, 2024 at 8:47=E2=80=AFAM Mike Christie
> > > > > >>>>>> <michael.christie@oracle.com> wrote:
> > > > > >>>>>>>
> > > > > >>>>>>> The following patches were made over Linus's tree and als=
o apply over
> > > > > >>>>>>> mst's vhost branch. The patches add the ability for vhost=
_tasks to
> > > > > >>>>>>> handle SIGKILL by flushing queued works, stop new works f=
rom being
> > > > > >>>>>>> queued, and prepare the task for an early exit.
> > > > > >>>>>>>
> > > > > >>>>>>> This removes the need for the signal/coredump hacks added=
 in:
> > > > > >>>>>>>
> > > > > >>>>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fi=
x freezer/ps regression")
> > > > > >>>>>>>
> > > > > >>>>>>> when the vhost_task patches were initially merged and fix=
 the issue
> > > > > >>>>>>> in this thread:
> > > > > >>>>>>>
> > > > > >>>>>>> https://lore.kernel.org/all/000000000000a41b82060e875721@=
google.com/
> > > > > >>>>>>>
> > > > > >>>>>>> Long Background:
> > > > > >>>>>>>
> > > > > >>>>>>> The original vhost worker code didn't support any signals=
. If the
> > > > > >>>>>>> userspace application that owned the worker got a SIGKILL=
, the app/
> > > > > >>>>>>> process would exit dropping all references to the device =
and then the
> > > > > >>>>>>> file operation's release function would be called. From t=
here we would
> > > > > >>>>>>> wait on running IO then cleanup the device's memory.
> > > > > >>>>>>
> > > > > >>>>>> A dumb question.
> > > > > >>>>>>
> > > > > >>>>>> Is this a user space noticeable change? For example, with =
this series
> > > > > >>>>>> a SIGKILL may shutdown the datapath ...
> > > > > >>>>>
> > > > > >>>>> It already changed in 6.4. We basically added a new interfa=
ce to shutdown
> > > > > >>>>> everything (userspace and vhost kernel parts). So we won't =
just shutdown
> > > > > >>>>> the data path while userspace is still running. We will shu=
tdown everything
> > > > > >>>>> now if you send a SIGKILL to a vhost worker's thread.
> > > > > >>>>
> > > > > >>>> If I understand correctly, for example Qemu can still live i=
s SIGKILL
> > > > > >>>> is just send to vhost thread.
> > > > > >>>
> > > > > >>> Pre-6.4 qemu could still survive if only the vhost thread got=
 a SIGKILL.
> > > > > >>> We used kthreads which are special and can ignore it like how=
 userspace
> > > > > >>> can ignore SIGHUP.
> > > > > >>>
> > > > > >>> 6.4 and newer kernels cannot survive. Even if the vhost threa=
d sort of
> > > > > >>> ignores it like I described below where, the signal is still =
delivered
> > > > > >>> to the other qemu threads due to the shared signal handler. U=
serspace
> > > > > >>> can't ignore SIGKILL. It doesn't have any say in the matter, =
and the
> > > > > >>> kernel forces them to exit.
> > > > > >>
> > > > > >> Ok, I see, so the reason is that vhost belongs to the same thr=
ead
> > > > > >> group as the owner now.
> > > > > >>
> > > > > >>>
> > > > > >>>>
> > > > > >>>> If this is correct, guests may detect this (for example virt=
io-net has
> > > > > >>>> a watchdog).
> > > > > >>>>
> > > > > >>>
> > > > > >>> What did you mean by that part? Do you mean if the vhost thre=
ad were to
> > > > > >>> exit, so drivers/vhost/net.c couldn't process IO, then the wa=
tchdog in
> > > > > >>> the guest (virtio-net driver in the guest kernel) would detec=
t that?
> > > > > >>
> > > > > >> I meant this one. But since we are using CLONE_THREAD, we won'=
t see these.
> > > > > >>
> > > > > >>> Or
> > > > > >>> are you saying the watchdog in the guest can detect signals t=
hat the
> > > > > >>> host gets?
> > > > > >>>
> > > > > >>>
> > > > > >>>>>
> > > > > >>>>> Here are a lots of details:
> > > > > >>>>>
> > > > > >>>>> - Pre-6.4 kernel, when vhost workers used kthreads, if you =
sent any signal
> > > > > >>>>> to a vhost worker, we ignore it. Nothing happens. kthreads =
are special and
> > > > > >>>>> can ignore all signals.
> > > > > >>>>>
> > > > > >>>>> You could think of it as the worker is a completely differe=
nt process than
> > > > > >>>>> qemu/userspace so they have completely different signal han=
dlers. The
> > > > > >>>>> vhost worker signal handler ignores all signals even SIGKIL=
L.
> > > > > >>>>
> > > > > >>>> Yes.
> > > > > >>>>
> > > > > >>>>>
> > > > > >>>>> If you send a SIGKILL to a qemu thread, then it just exits =
right away. We
> > > > > >>>>> don't get to do an explicit close() on the vhost device and=
 we don't get
> > > > > >>>>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. =
The kernel exit
> > > > > >>>>> code runs and releases refcounts on the device/file, then t=
he vhost device's
> > > > > >>>>> file_operations->release function is called. vhost_dev_clea=
nup then stops
> > > > > >>>>> the vhost worker.
> > > > > >>>>
> > > > > >>>> Right.
> > > > > >>>>
> > > > > >>>>>
> > > > > >>>>> - In 6.4 and newer kernels, vhost workers use vhost_tasks, =
so the worker
> > > > > >>>>> can be thought of as a thread within the userspace process.=
 With that
> > > > > >>>>> change we have the same signal handler as the userspace pro=
cess.
> > > > > >>>>>
> > > > > >>>>> If you send a SIGKILL to a qemu thread then it works like a=
bove.
> > > > > >>>>>
> > > > > >>>>> If you send a SIGKILL to a vhost worker, the vhost worker s=
till sort of
> > > > > >>>>> ignores it (that is the hack that I mentioned at the beginn=
ing of this
> > > > > >>>>> thread). kernel/vhost_task.c:vhost_task_fn will see the sig=
nal and
> > > > > >>>>> then just continue to process works until file_operations->=
release
> > > > > >>>>> calls
> > > > > >>>>
> > > > > >>>> Yes, so this sticks to the behaviour before vhost_tasks.
> > > > > >>>
> > > > > >>> Not exactly. The vhost_task stays alive temporarily.
> > > > > >>>
> > > > > >>> The signal is still delivered to the userspace threads and th=
ey will
> > > > > >>> exit due to getting the SIGKILL also. SIGKILL goes to all the=
 threads in
> > > > > >>> the process and all userspace threads exit like normal becaus=
e the vhost
> > > > > >>> task and normal old userspace threads share a signal handler.=
 When
> > > > > >>> userspace exits, the kernel force drops the refcounts on the =
vhost
> > > > > >>> devices and that runs the release function so the vhost_task =
will then exit.
> > > > > >>>
> > > > > >>> So what I'm trying to say is that in 6.4 we already changed t=
he behavior.
> > > > > >>
> > > > > >> Yes. To say the truth, it looks even worse but it might be too=
 late to fix.
> > > > > >
> > > > > > Andres (cced) has identified two other possible changes:
> > > > > >
> > > > > > 1) doesn't run in the global PID namespace but run in the names=
pace of owner
> > > > >
> > > > > Yeah, I mentioned that one in vhost.h like it's a feature and whe=
n posting
> > > > > the patches I mentioned it as a possible fix. I mean I thought we=
 wanted it
> > > > > to work like qemu and iothreads where the iothread would inherit =
all those
> > > > > values automatically.
> > > >
> > > > Right, but it could be noticed by the userspace, especially for the
> > > > one that tries to do tweak on the performance.
> > > >
> > > > The root cause is the that now we do copy_processs() in the process=
 of
> > > > Qemu instead of the kthreadd. Which result of the the differences o=
f
> > > > namespace (I think PID namespace is not the only one we see
> > > > difference) and others for the vhost task.
> > >
> > > Leaking things out of a namespace looks more like a bug.
> > > If you really have to be pedantic, the thing to add would
> > > be a namespace flag not a qemu flag. Userspace running inside
> > > a namespace really must have no say about whether to leak
> > > info out of it.
> > >
> > > > >
> > > > > At the time, I thought we didn't inherit the namespace, like we d=
id the cgroup,
> > > > > because there was no kernel function for it (like how we didn't i=
nherit v2
> > > > > cgroups until recently when someone added some code for that).
> > > > >
> > > > > I don't know if it's allowed to have something like qemu in names=
pace N but then
> > > > > have it's children (vhost thread in this case) in the global name=
space.
> > > > > I'll
> > > > > look into it.
> > > >
> > > > Instead of moving vhost thread between difference namespaces, I won=
der
> > > > if the following is simpler:
> > > >
> > > > if (new_flag)
> > > >     vhost_task_create()
> > > > else
> > > >     kthread_create()
> > > >
> > > > New flag inherits the attributes of Qemu (namespaces, rlimit, cgrou=
p,
> > > > scheduling attributes ...) which is what we want. Without the new
> > > > flag, we stick exactly to the behaviour as in the past to unbreak
> > > > existing userspace.
> > > >
> > > > >
> > > > > > 2) doesn't inherit kthreadd's scheduling attributes but the own=
er
> > > > >
> > > > > Same as above for this one. I thought I was fixing a bug where be=
fore
> > > > > we had to manually tune the vhost thread's values but for iothrea=
ds they
> > > > > automatically got setup.
> > > > >
> > > > > Just to clarify this one. When we used kthreads, kthread() will r=
eset the
> > > > > scheduler priority for the kthread that's created, so we got the =
default
> > > > > values instead of inheriting kthreadd's values.  So we would want=
:
> > > > >
> > > > > +       sched_setscheduler_nocheck(current, SCHED_NORMAL, &param)=
;
> > > > >
> > > > > in vhost_task_fn() instead of inheriting kthreadd's values.
> > > > >
> > > > > >
> > > > > > Though such a change makes more sense for some use cases, it ma=
y break others.
> > > > > >
> > > > > > I wonder if we need to introduce a new flag and bring the old k=
thread
> > > > >
> > > > > Do you mean something like a module param?
> > > >
> > > > This requires the management layer to know if it has a new user spa=
ce
> > > > or not which is hard. A better place is to introduce backend featur=
es.
> > > >
> > > > >
> > > > > > codes if the flag is not set? Then we would not end up trying t=
o align
> > > > > > the behaviour?
> > > > > >
> > > > >
> > > > > Let me know what you guys prefer. The sched part is easy. The nam=
espace
> > > > > part might be more difficult, but I will look into it if you want=
 it.
> > > >
> > > > Thanks a lot. I think it would be better to have the namespace part
> > > > (as well as other namespaces) then we don't need to answer hard
> > > > questions like if it can break user space or not.
> > > >
> > > > >
> > >
> >

