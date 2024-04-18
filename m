Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA215ADB2
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432369; cv=none; b=j6cxsYQfvqqRo3JERV19TL7DOjCne+6RUH+Oylm5JSxlOXovRUXDMehEJJqs9VBX25kNd7i1cvzaY6LmpHEoKDrplG0k012OA4OWYhxB31HQba4/rNCZTN3tJswTQ+QRRROEhf26Dp6/MgU/jY77aaeMj2UNgaYwmRfjwUpXmWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432369; c=relaxed/simple;
	bh=XoqCh+kdoIS7eNL2mpsFJeYHtfX4AO0fA8wMggdZAJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NE3aNEgZ/R65yxxkjhCgALXVezvnUH4oc1XC92z2ENJHnd9OF8hPbOPLkgTpj/6Y4LpNyx15kQCUpyfhsErtn3q8JRhqyFugiUaMfe0e7MRcbNHz9SpLSyf8OQnmxs+sVJBZLaw6r2s75UcNbHJxk7lsz0lNzWelLzAe8fgiC5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BA9AuM9h; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BA9AuM9h"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC9B54018B
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 09:26:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AlZzFlwELN1c for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Apr 2024 09:26:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=akaris@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D780740173
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D780740173
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BA9AuM9h
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D780740173
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 09:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713432364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJZJeONwTtKjLQI2ncnSIWrrktUEzaiyeeeCKsLo/HQ=;
	b=BA9AuM9h769YQfHYB//vNtEv7NomdMaHnSw/mlDt1XaxGCJjKN4ZEB/XAdYxt61wP0dZa8
	pFWaCXP1H1HRJeMSa6/9wOSJ6JzY8Ivm8NEsTNJ8msk+o8P6MTFxcvdBYNDqJzlEDVZ0uw
	FBxz1TR3QKajvJ9iMebYcJDf1nvHdAg=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-Br2Hh4DBNXaKdML2pTZYTg-1; Thu, 18 Apr 2024 05:26:00 -0400
X-MC-Unique: Br2Hh4DBNXaKdML2pTZYTg-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-22f0ab6b87aso1643247fac.0
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 02:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713432359; x=1714037159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJZJeONwTtKjLQI2ncnSIWrrktUEzaiyeeeCKsLo/HQ=;
        b=RDllADxAfDsd2qRq5cJA01TLk8gGuMRhE0Tjfl0Yy9m4VAYvMMET59NP6fNuHzlZ2Z
         9C3tlwKngXwTTV9cmZ11BMAohTMNR4oGRTBXgapGOYfPdiVBQGByWerwEgLJzme//2Fx
         Wj1+aFXg5DqIurfCW+ijkY/29jdb6piGoPYtQjFUnqbRA/x9vj57pbxtKZlRofr/Bwqk
         6ovgDqb9ridqrVJ7Ur2HznHcAh/G0fFIkTskOipgdrpYZAw2Z3EXHspPBGKidkCuwibq
         +pZv/6GEmUZqoXzfnHl7xDsTTQ5A+DdzP0JTdgWyNEFfSEjL1i4zWAWXewLEGVPxuzGa
         nz0w==
X-Forwarded-Encrypted: i=1; AJvYcCWvbtnG0OqyaI6oueurvTAEYDUAb4URzRYxuOTAO0yOPa9tcFVuKrJuDCcRlo6P0GEfIzqpK3h5U1U4GNoYKkOFzI1MGZTtx975xoe3/fFyDwTI/gh5RTWa4Q==
X-Gm-Message-State: AOJu0YwZRULEKexZnJeAvufBceoFJaO3VA4hIQxTspxOCluVoxeR4gYZ
	kbSn/wGHSlptmqMp/x8MpGSJSE3Ln7t/FsIt19sqcxDkxL9g62WpWwF04rl7unt6K9Yxa+HqKbY
	gu99G6HlZr5Iky80fmbLGgL6rrsquXE393MYkWjSCr0JAwLhdDipa1pkYoyHca32dRBQoQaIfHy
	8UYbYF1hmyXdCnzlibhsTsDWs+pgZXWbWaOoMMs7enHfBZYWmewGVYmg==
X-Received: by 2002:a05:6870:f60f:b0:229:eb17:3c08 with SMTP id ek15-20020a056870f60f00b00229eb173c08mr857423oab.4.1713432359459;
        Thu, 18 Apr 2024 02:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxMxaVGfPz6/KpDOsROYmA+CGXEzQxiQ9MU/wEEWvZPd5qjA3uYrEdrkVBp1XPDlh7wXybqw7g93vRYeZplac=
X-Received: by 2002:a05:6870:f60f:b0:229:eb17:3c08 with SMTP id
 ek15-20020a056870f60f00b00229eb173c08mr857411oab.4.1713432359000; Thu, 18 Apr
 2024 02:25:59 -0700 (PDT)
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
 <20240418030112-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240418030112-mutt-send-email-mst@kernel.org>
From: Andreas Karis <akaris@redhat.com>
Date: Thu, 18 Apr 2024 11:25:47 +0200
Message-ID: <CAFZ-RRMMbwN=TwBsEJ_L98yH5+EmXcH8Oq0gjZ=8PU6kDn4=Rg@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Mike Christie <michael.christie@oracle.com>, oleg@redhat.com, 
	ebiederm@xmission.com, virtualization@lists.linux-foundation.org, 
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Not a kernel developer, so sorry if this here is pointless spam.

But qemu is not the only thing consuming /dev/vhost-net:
https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html

Before the series of patches around
https://github.com/torvalds/linux/commit/e297cd54b3f81d652456ae6cb93941fc6b=
5c6683,
you would run a DPDK application inside namespaces of container
"blue", but then the vhost-... threads were spawned as children of
kthreadd and run in the global namespaces. That seemed counter
intuitive, and what's worse, the DPDK application running inside the
"blue" container namespaces cannot see and thus cannot modify
scheduling attributes and affinity of its own vhost-... threads. In
scenarios with pretty strict isolation/pinning requirements, the
vhost-... threads could easily be scheduled on the same CPUs as the
DPDK poll mode drivers (because they inherit the calling process' CPU
affinity), and there's no way for the DPDK process itself to move the
vhost-... threads to other CPUs. Also, if the DPDK process ran as
SCHED_RR, the vhost-.... thread would still be SCHED_NORMAL.

After the patch series, the fact that the vhost-... threads run as
tasks of the process that requests them seems more natural and gives
us as users the kind of control that we'd want from within the
container to modify the vhost-... threads' scheduling and affinity.
The vhost-... thread as a child of the DPDK application inherits the
same scheduling class, CPU set, etc and the DPDK process can easily
change those attributes.

However, if another user was used to the old behavior, and their
entire tooling was created for the old behavior (imagine someone wrote
a bunch of scripts/services to force affinity from the global PID
namespace for those vhost-... threads), and now this change was
introduced, it would break their tooling. So because _I_ might fancy
the new behavior, but user _B_ might be all set up for the old
kthreadd, shouldn't there be a flag or configuration for the user to:

if (new_flag)
    vhost_task_create()
else
    kthread_create()

I don't know what kind of flag or knob I'd expect here, but it could
be granular for the calling process (a new syscall?), or a kernel
flag, etc. But something that let's the admin choose how the kernel
spawns the vhost-... threads?

On Thu, Apr 18, 2024 at 9:07=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 12:08:52PM +0800, Jason Wang wrote:
> > On Thu, Apr 18, 2024 at 12:10=E2=80=AFAM Mike Christie
> > <michael.christie@oracle.com> wrote:
> > >
> > > On 4/16/24 10:50 PM, Jason Wang wrote:
> > > > On Mon, Apr 15, 2024 at 4:52=E2=80=AFPM Jason Wang <jasowang@redhat=
.com> wrote:
> > > >>
> > > >> On Sat, Apr 13, 2024 at 12:53=E2=80=AFAM <michael.christie@oracle.=
com> wrote:
> > > >>>
> > > >>> On 4/11/24 10:28 PM, Jason Wang wrote:
> > > >>>> On Fri, Apr 12, 2024 at 12:19=E2=80=AFAM Mike Christie
> > > >>>> <michael.christie@oracle.com> wrote:
> > > >>>>>
> > > >>>>> On 4/11/24 3:39 AM, Jason Wang wrote:
> > > >>>>>> On Sat, Mar 16, 2024 at 8:47=E2=80=AFAM Mike Christie
> > > >>>>>> <michael.christie@oracle.com> wrote:
> > > >>>>>>>
> > > >>>>>>> The following patches were made over Linus's tree and also ap=
ply over
> > > >>>>>>> mst's vhost branch. The patches add the ability for vhost_tas=
ks to
> > > >>>>>>> handle SIGKILL by flushing queued works, stop new works from =
being
> > > >>>>>>> queued, and prepare the task for an early exit.
> > > >>>>>>>
> > > >>>>>>> This removes the need for the signal/coredump hacks added in:
> > > >>>>>>>
> > > >>>>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix fr=
eezer/ps regression")
> > > >>>>>>>
> > > >>>>>>> when the vhost_task patches were initially merged and fix the=
 issue
> > > >>>>>>> in this thread:
> > > >>>>>>>
> > > >>>>>>> https://lore.kernel.org/all/000000000000a41b82060e875721@goog=
le.com/
> > > >>>>>>>
> > > >>>>>>> Long Background:
> > > >>>>>>>
> > > >>>>>>> The original vhost worker code didn't support any signals. If=
 the
> > > >>>>>>> userspace application that owned the worker got a SIGKILL, th=
e app/
> > > >>>>>>> process would exit dropping all references to the device and =
then the
> > > >>>>>>> file operation's release function would be called. From there=
 we would
> > > >>>>>>> wait on running IO then cleanup the device's memory.
> > > >>>>>>
> > > >>>>>> A dumb question.
> > > >>>>>>
> > > >>>>>> Is this a user space noticeable change? For example, with this=
 series
> > > >>>>>> a SIGKILL may shutdown the datapath ...
> > > >>>>>
> > > >>>>> It already changed in 6.4. We basically added a new interface t=
o shutdown
> > > >>>>> everything (userspace and vhost kernel parts). So we won't just=
 shutdown
> > > >>>>> the data path while userspace is still running. We will shutdow=
n everything
> > > >>>>> now if you send a SIGKILL to a vhost worker's thread.
> > > >>>>
> > > >>>> If I understand correctly, for example Qemu can still live is SI=
GKILL
> > > >>>> is just send to vhost thread.
> > > >>>
> > > >>> Pre-6.4 qemu could still survive if only the vhost thread got a S=
IGKILL.
> > > >>> We used kthreads which are special and can ignore it like how use=
rspace
> > > >>> can ignore SIGHUP.
> > > >>>
> > > >>> 6.4 and newer kernels cannot survive. Even if the vhost thread so=
rt of
> > > >>> ignores it like I described below where, the signal is still deli=
vered
> > > >>> to the other qemu threads due to the shared signal handler. Users=
pace
> > > >>> can't ignore SIGKILL. It doesn't have any say in the matter, and =
the
> > > >>> kernel forces them to exit.
> > > >>
> > > >> Ok, I see, so the reason is that vhost belongs to the same thread
> > > >> group as the owner now.
> > > >>
> > > >>>
> > > >>>>
> > > >>>> If this is correct, guests may detect this (for example virtio-n=
et has
> > > >>>> a watchdog).
> > > >>>>
> > > >>>
> > > >>> What did you mean by that part? Do you mean if the vhost thread w=
ere to
> > > >>> exit, so drivers/vhost/net.c couldn't process IO, then the watchd=
og in
> > > >>> the guest (virtio-net driver in the guest kernel) would detect th=
at?
> > > >>
> > > >> I meant this one. But since we are using CLONE_THREAD, we won't se=
e these.
> > > >>
> > > >>> Or
> > > >>> are you saying the watchdog in the guest can detect signals that =
the
> > > >>> host gets?
> > > >>>
> > > >>>
> > > >>>>>
> > > >>>>> Here are a lots of details:
> > > >>>>>
> > > >>>>> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent=
 any signal
> > > >>>>> to a vhost worker, we ignore it. Nothing happens. kthreads are =
special and
> > > >>>>> can ignore all signals.
> > > >>>>>
> > > >>>>> You could think of it as the worker is a completely different p=
rocess than
> > > >>>>> qemu/userspace so they have completely different signal handler=
s. The
> > > >>>>> vhost worker signal handler ignores all signals even SIGKILL.
> > > >>>>
> > > >>>> Yes.
> > > >>>>
> > > >>>>>
> > > >>>>> If you send a SIGKILL to a qemu thread, then it just exits righ=
t away. We
> > > >>>>> don't get to do an explicit close() on the vhost device and we =
don't get
> > > >>>>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The =
kernel exit
> > > >>>>> code runs and releases refcounts on the device/file, then the v=
host device's
> > > >>>>> file_operations->release function is called. vhost_dev_cleanup =
then stops
> > > >>>>> the vhost worker.
> > > >>>>
> > > >>>> Right.
> > > >>>>
> > > >>>>>
> > > >>>>> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so t=
he worker
> > > >>>>> can be thought of as a thread within the userspace process. Wit=
h that
> > > >>>>> change we have the same signal handler as the userspace process=
.
> > > >>>>>
> > > >>>>> If you send a SIGKILL to a qemu thread then it works like above=
.
> > > >>>>>
> > > >>>>> If you send a SIGKILL to a vhost worker, the vhost worker still=
 sort of
> > > >>>>> ignores it (that is the hack that I mentioned at the beginning =
of this
> > > >>>>> thread). kernel/vhost_task.c:vhost_task_fn will see the signal =
and
> > > >>>>> then just continue to process works until file_operations->rele=
ase
> > > >>>>> calls
> > > >>>>
> > > >>>> Yes, so this sticks to the behaviour before vhost_tasks.
> > > >>>
> > > >>> Not exactly. The vhost_task stays alive temporarily.
> > > >>>
> > > >>> The signal is still delivered to the userspace threads and they w=
ill
> > > >>> exit due to getting the SIGKILL also. SIGKILL goes to all the thr=
eads in
> > > >>> the process and all userspace threads exit like normal because th=
e vhost
> > > >>> task and normal old userspace threads share a signal handler. Whe=
n
> > > >>> userspace exits, the kernel force drops the refcounts on the vhos=
t
> > > >>> devices and that runs the release function so the vhost_task will=
 then exit.
> > > >>>
> > > >>> So what I'm trying to say is that in 6.4 we already changed the b=
ehavior.
> > > >>
> > > >> Yes. To say the truth, it looks even worse but it might be too lat=
e to fix.
> > > >
> > > > Andres (cced) has identified two other possible changes:
> > > >
> > > > 1) doesn't run in the global PID namespace but run in the namespace=
 of owner
> > >
> > > Yeah, I mentioned that one in vhost.h like it's a feature and when po=
sting
> > > the patches I mentioned it as a possible fix. I mean I thought we wan=
ted it
> > > to work like qemu and iothreads where the iothread would inherit all =
those
> > > values automatically.
> >
> > Right, but it could be noticed by the userspace, especially for the
> > one that tries to do tweak on the performance.
> >
> > The root cause is the that now we do copy_processs() in the process of
> > Qemu instead of the kthreadd. Which result of the the differences of
> > namespace (I think PID namespace is not the only one we see
> > difference) and others for the vhost task.
>
> Leaking things out of a namespace looks more like a bug.
> If you really have to be pedantic, the thing to add would
> be a namespace flag not a qemu flag. Userspace running inside
> a namespace really must have no say about whether to leak
> info out of it.
>
> > >
> > > At the time, I thought we didn't inherit the namespace, like we did t=
he cgroup,
> > > because there was no kernel function for it (like how we didn't inher=
it v2
> > > cgroups until recently when someone added some code for that).
> > >
> > > I don't know if it's allowed to have something like qemu in namespace=
 N but then
> > > have it's children (vhost thread in this case) in the global namespac=
e.
> > > I'll
> > > look into it.
> >
> > Instead of moving vhost thread between difference namespaces, I wonder
> > if the following is simpler:
> >
> > if (new_flag)
> >     vhost_task_create()
> > else
> >     kthread_create()
> >
> > New flag inherits the attributes of Qemu (namespaces, rlimit, cgroup,
> > scheduling attributes ...) which is what we want. Without the new
> > flag, we stick exactly to the behaviour as in the past to unbreak
> > existing userspace.
> >
> > >
> > > > 2) doesn't inherit kthreadd's scheduling attributes but the owner
> > >
> > > Same as above for this one. I thought I was fixing a bug where before
> > > we had to manually tune the vhost thread's values but for iothreads t=
hey
> > > automatically got setup.
> > >
> > > Just to clarify this one. When we used kthreads, kthread() will reset=
 the
> > > scheduler priority for the kthread that's created, so we got the defa=
ult
> > > values instead of inheriting kthreadd's values.  So we would want:
> > >
> > > +       sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> > >
> > > in vhost_task_fn() instead of inheriting kthreadd's values.
> > >
> > > >
> > > > Though such a change makes more sense for some use cases, it may br=
eak others.
> > > >
> > > > I wonder if we need to introduce a new flag and bring the old kthre=
ad
> > >
> > > Do you mean something like a module param?
> >
> > This requires the management layer to know if it has a new user space
> > or not which is hard. A better place is to introduce backend features.
> >
> > >
> > > > codes if the flag is not set? Then we would not end up trying to al=
ign
> > > > the behaviour?
> > > >
> > >
> > > Let me know what you guys prefer. The sched part is easy. The namespa=
ce
> > > part might be more difficult, but I will look into it if you want it.
> >
> > Thanks a lot. I think it would be better to have the namespace part
> > (as well as other namespaces) then we don't need to answer hard
> > questions like if it can break user space or not.
> >
> > >
>

