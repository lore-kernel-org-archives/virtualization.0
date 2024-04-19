Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B82384
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Apr 2024 00:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713487170; cv=none; b=aPp5sSTMxDvq2m0JJNEGTMkNj1YFUxKXlch+K+WriJ7PApJHxPECBEVJso6tuSGMkY1isEMUw2HKxMj5JFEwHEYc4D4CsQHfLkHdFcRRuLe0bL+/0bXkE2rczUZCpW/58sZFNbZ0aqxXvHBEAqnJIXri8MmKsuKA9PbVd/9mUs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713487170; c=relaxed/simple;
	bh=lhEJhtAhKb0wm47fisMkvcWKYcL3BKVGMxKRKtOcJYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCIlvNSKl/nHtdOcrPb9vUslRU/dG91PKaJOsHrqx8cpsfMvSgMxsXxUEeZSj2173UCxo1TMu3I4uWOirXOsWD3oIc3fWs20RUaX5I4NNjYMaNCnngNOV2EbKbAz9rK6U1Dnb3wLz8cilHJSe0BEfTDIRB4WjbywQu+nOgsMXwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3ejhPHM; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3ejhPHM"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C20DC4149D
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Apr 2024 00:39:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lT-lfKzbpQVo for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Apr 2024 00:39:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 89869410D8
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 89869410D8
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O3ejhPHM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 89869410D8
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Apr 2024 00:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713487165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=llR3ghsXicl2kuIvkBMDCDGH8DijF4XwtwY8C4a4v04=;
	b=O3ejhPHMkqCAN3s8xUsYNDz/xYDyPt36zPm9/Z92ExifLDCBw3WFf3mD0xUz8I3WalBmZs
	rGIfjkn06rFDUuZuutMSIbjTpBE8jRIXesLz5iHjLMTwVIxy2xQwaaNEukw+7vo7oZejeQ
	Rl7DPzHJ647xAerUqoD4hnFFDiT8YXU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-4xpg-3UkPwKr0VyFIVM6lg-1; Thu, 18 Apr 2024 20:37:35 -0400
X-MC-Unique: 4xpg-3UkPwKr0VyFIVM6lg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5cf555b2a53so1789510a12.1
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 17:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713487054; x=1714091854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llR3ghsXicl2kuIvkBMDCDGH8DijF4XwtwY8C4a4v04=;
        b=K8Eq9jhzWiwPi0zSuWQ4EkR8JUtHHLG5kdrDxx27qWk2djRrOk4dL/MCA25xrAY6Pq
         PPfadf/8tp7tkb7dKPPgVfECpf+5LIZ+k5BONNVk/vN7eNL67L9cmHj7KScQc01ResMU
         xQqp7bvmhoCMjBpaj9i7j3365vsnPhLx0ltiC+V5fBH7qUmqXc0RHXSDjtphqZdG4vrA
         7h62PCNPax1ukTgyMDkc1qXwQwAr3+QD7zV4UoZN+awhBQK5PdLrGP+ZSRaqyfQTWasK
         a2Yq7HxedNYwfAzj5BdUcosY0de06WgKLRCxXYlWuBXyQlDl/cUA6FtGrvfQ+F4ah7h0
         Ug2w==
X-Forwarded-Encrypted: i=1; AJvYcCXao105Q+mxZtGnBfuRa888BMjQtd5FYWWty4PBLSFSasxLkVj2iYlXpDAovs9Yh/hL09CYniLbuC/PiaWDy1ooNXOHFU1f06TWdjS3kq423UCow8b7NuRqBg==
X-Gm-Message-State: AOJu0YxXXO16SEl++8hhGi1PLIu0QGDBgrZceu/lzovahrwudK3WsnxU
	n9I6kUaZRSojBN2JXKKbAVjcIsSUjvSsvvysENeK/e+sGkdlnCgS6G1zfnajMYmrHBBm8vxixPc
	zXyZ07ilFneM3uAfJf3JX3TggMLpYomQtutuhISwcgLt4WW/DX+89mR/s66KiqShtEsjDEan1VB
	tlO3m8yeDCcgmM0sCfG6k76VgqjENUfpBoX8TDnCRcXy1+cgyD6weKRA==
X-Received: by 2002:a17:90a:6282:b0:2a9:e879:c83d with SMTP id d2-20020a17090a628200b002a9e879c83dmr5702010pjj.5.1713487054053;
        Thu, 18 Apr 2024 17:37:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/t4L7FDuRMJG3+iTylBsQ+9NqFBqXZ9FArmn53P/SNTy1lmbElm2eSyJrC+J7T3xB1kvsKh4KTYLYGLe4QaA=
X-Received: by 2002:a17:90a:6282:b0:2a9:e879:c83d with SMTP id
 d2-20020a17090a628200b002a9e879c83dmr5701983pjj.5.1713487053588; Thu, 18 Apr
 2024 17:37:33 -0700 (PDT)
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
In-Reply-To: <CAFZ-RRMMbwN=TwBsEJ_L98yH5+EmXcH8Oq0gjZ=8PU6kDn4=Rg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Apr 2024 08:37:22 +0800
Message-ID: <CACGkMEtA+n3=EmJ+ykK9eUZwUBjKRUB0sT0UG59zmeG99p3VeQ@mail.gmail.com>
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

On Thu, Apr 18, 2024 at 5:26=E2=80=AFPM Andreas Karis <akaris@redhat.com> w=
rote:
>
> Not a kernel developer, so sorry if this here is pointless spam.
>
> But qemu is not the only thing consuming /dev/vhost-net:
> https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html
>
> Before the series of patches around
> https://github.com/torvalds/linux/commit/e297cd54b3f81d652456ae6cb93941fc=
6b5c6683,
> you would run a DPDK application inside namespaces of container
> "blue", but then the vhost-... threads were spawned as children of
> kthreadd and run in the global namespaces. That seemed counter
> intuitive, and what's worse, the DPDK application running inside the
> "blue" container namespaces cannot see and thus cannot modify
> scheduling attributes and affinity of its own vhost-... threads. In
> scenarios with pretty strict isolation/pinning requirements, the
> vhost-... threads could easily be scheduled on the same CPUs as the
> DPDK poll mode drivers (because they inherit the calling process' CPU
> affinity), and there's no way for the DPDK process itself to move the
> vhost-... threads to other CPUs. Also, if the DPDK process ran as
> SCHED_RR, the vhost-.... thread would still be SCHED_NORMAL.
>
> After the patch series, the fact that the vhost-... threads run as
> tasks of the process that requests them seems more natural and gives
> us as users the kind of control that we'd want from within the
> container to modify the vhost-... threads' scheduling and affinity.
> The vhost-... thread as a child of the DPDK application inherits the
> same scheduling class, CPU set, etc and the DPDK process can easily
> change those attributes.
>
> However, if another user was used to the old behavior, and their
> entire tooling was created for the old behavior (imagine someone wrote
> a bunch of scripts/services to force affinity from the global PID
> namespace for those vhost-... threads), and now this change was
> introduced, it would break their tooling. So because _I_ might fancy
> the new behavior, but user _B_ might be all set up for the old
> kthreadd, shouldn't there be a flag or configuration for the user to:
>
> if (new_flag)
>     vhost_task_create()
> else
>     kthread_create()
>
> I don't know what kind of flag or knob I'd expect here, but it could
> be granular for the calling process (a new syscall?), or a kernel
> flag, etc. But something that let's the admin choose how the kernel
> spawns the vhost-... threads?

A flag via uAPI that could be controlled by the user of vhost-net via
syscall. For example, it could be done via set/get_backend_feautre()
syscall.

Thanks

>
> On Thu, Apr 18, 2024 at 9:07=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Thu, Apr 18, 2024 at 12:08:52PM +0800, Jason Wang wrote:
> > > On Thu, Apr 18, 2024 at 12:10=E2=80=AFAM Mike Christie
> > > <michael.christie@oracle.com> wrote:
> > > >
> > > > On 4/16/24 10:50 PM, Jason Wang wrote:
> > > > > On Mon, Apr 15, 2024 at 4:52=E2=80=AFPM Jason Wang <jasowang@redh=
at.com> wrote:
> > > > >>
> > > > >> On Sat, Apr 13, 2024 at 12:53=E2=80=AFAM <michael.christie@oracl=
e.com> wrote:
> > > > >>>
> > > > >>> On 4/11/24 10:28 PM, Jason Wang wrote:
> > > > >>>> On Fri, Apr 12, 2024 at 12:19=E2=80=AFAM Mike Christie
> > > > >>>> <michael.christie@oracle.com> wrote:
> > > > >>>>>
> > > > >>>>> On 4/11/24 3:39 AM, Jason Wang wrote:
> > > > >>>>>> On Sat, Mar 16, 2024 at 8:47=E2=80=AFAM Mike Christie
> > > > >>>>>> <michael.christie@oracle.com> wrote:
> > > > >>>>>>>
> > > > >>>>>>> The following patches were made over Linus's tree and also =
apply over
> > > > >>>>>>> mst's vhost branch. The patches add the ability for vhost_t=
asks to
> > > > >>>>>>> handle SIGKILL by flushing queued works, stop new works fro=
m being
> > > > >>>>>>> queued, and prepare the task for an early exit.
> > > > >>>>>>>
> > > > >>>>>>> This removes the need for the signal/coredump hacks added i=
n:
> > > > >>>>>>>
> > > > >>>>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix =
freezer/ps regression")
> > > > >>>>>>>
> > > > >>>>>>> when the vhost_task patches were initially merged and fix t=
he issue
> > > > >>>>>>> in this thread:
> > > > >>>>>>>
> > > > >>>>>>> https://lore.kernel.org/all/000000000000a41b82060e875721@go=
ogle.com/
> > > > >>>>>>>
> > > > >>>>>>> Long Background:
> > > > >>>>>>>
> > > > >>>>>>> The original vhost worker code didn't support any signals. =
If the
> > > > >>>>>>> userspace application that owned the worker got a SIGKILL, =
the app/
> > > > >>>>>>> process would exit dropping all references to the device an=
d then the
> > > > >>>>>>> file operation's release function would be called. From the=
re we would
> > > > >>>>>>> wait on running IO then cleanup the device's memory.
> > > > >>>>>>
> > > > >>>>>> A dumb question.
> > > > >>>>>>
> > > > >>>>>> Is this a user space noticeable change? For example, with th=
is series
> > > > >>>>>> a SIGKILL may shutdown the datapath ...
> > > > >>>>>
> > > > >>>>> It already changed in 6.4. We basically added a new interface=
 to shutdown
> > > > >>>>> everything (userspace and vhost kernel parts). So we won't ju=
st shutdown
> > > > >>>>> the data path while userspace is still running. We will shutd=
own everything
> > > > >>>>> now if you send a SIGKILL to a vhost worker's thread.
> > > > >>>>
> > > > >>>> If I understand correctly, for example Qemu can still live is =
SIGKILL
> > > > >>>> is just send to vhost thread.
> > > > >>>
> > > > >>> Pre-6.4 qemu could still survive if only the vhost thread got a=
 SIGKILL.
> > > > >>> We used kthreads which are special and can ignore it like how u=
serspace
> > > > >>> can ignore SIGHUP.
> > > > >>>
> > > > >>> 6.4 and newer kernels cannot survive. Even if the vhost thread =
sort of
> > > > >>> ignores it like I described below where, the signal is still de=
livered
> > > > >>> to the other qemu threads due to the shared signal handler. Use=
rspace
> > > > >>> can't ignore SIGKILL. It doesn't have any say in the matter, an=
d the
> > > > >>> kernel forces them to exit.
> > > > >>
> > > > >> Ok, I see, so the reason is that vhost belongs to the same threa=
d
> > > > >> group as the owner now.
> > > > >>
> > > > >>>
> > > > >>>>
> > > > >>>> If this is correct, guests may detect this (for example virtio=
-net has
> > > > >>>> a watchdog).
> > > > >>>>
> > > > >>>
> > > > >>> What did you mean by that part? Do you mean if the vhost thread=
 were to
> > > > >>> exit, so drivers/vhost/net.c couldn't process IO, then the watc=
hdog in
> > > > >>> the guest (virtio-net driver in the guest kernel) would detect =
that?
> > > > >>
> > > > >> I meant this one. But since we are using CLONE_THREAD, we won't =
see these.
> > > > >>
> > > > >>> Or
> > > > >>> are you saying the watchdog in the guest can detect signals tha=
t the
> > > > >>> host gets?
> > > > >>>
> > > > >>>
> > > > >>>>>
> > > > >>>>> Here are a lots of details:
> > > > >>>>>
> > > > >>>>> - Pre-6.4 kernel, when vhost workers used kthreads, if you se=
nt any signal
> > > > >>>>> to a vhost worker, we ignore it. Nothing happens. kthreads ar=
e special and
> > > > >>>>> can ignore all signals.
> > > > >>>>>
> > > > >>>>> You could think of it as the worker is a completely different=
 process than
> > > > >>>>> qemu/userspace so they have completely different signal handl=
ers. The
> > > > >>>>> vhost worker signal handler ignores all signals even SIGKILL.
> > > > >>>>
> > > > >>>> Yes.
> > > > >>>>
> > > > >>>>>
> > > > >>>>> If you send a SIGKILL to a qemu thread, then it just exits ri=
ght away. We
> > > > >>>>> don't get to do an explicit close() on the vhost device and w=
e don't get
> > > > >>>>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. Th=
e kernel exit
> > > > >>>>> code runs and releases refcounts on the device/file, then the=
 vhost device's
> > > > >>>>> file_operations->release function is called. vhost_dev_cleanu=
p then stops
> > > > >>>>> the vhost worker.
> > > > >>>>
> > > > >>>> Right.
> > > > >>>>
> > > > >>>>>
> > > > >>>>> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so=
 the worker
> > > > >>>>> can be thought of as a thread within the userspace process. W=
ith that
> > > > >>>>> change we have the same signal handler as the userspace proce=
ss.
> > > > >>>>>
> > > > >>>>> If you send a SIGKILL to a qemu thread then it works like abo=
ve.
> > > > >>>>>
> > > > >>>>> If you send a SIGKILL to a vhost worker, the vhost worker sti=
ll sort of
> > > > >>>>> ignores it (that is the hack that I mentioned at the beginnin=
g of this
> > > > >>>>> thread). kernel/vhost_task.c:vhost_task_fn will see the signa=
l and
> > > > >>>>> then just continue to process works until file_operations->re=
lease
> > > > >>>>> calls
> > > > >>>>
> > > > >>>> Yes, so this sticks to the behaviour before vhost_tasks.
> > > > >>>
> > > > >>> Not exactly. The vhost_task stays alive temporarily.
> > > > >>>
> > > > >>> The signal is still delivered to the userspace threads and they=
 will
> > > > >>> exit due to getting the SIGKILL also. SIGKILL goes to all the t=
hreads in
> > > > >>> the process and all userspace threads exit like normal because =
the vhost
> > > > >>> task and normal old userspace threads share a signal handler. W=
hen
> > > > >>> userspace exits, the kernel force drops the refcounts on the vh=
ost
> > > > >>> devices and that runs the release function so the vhost_task wi=
ll then exit.
> > > > >>>
> > > > >>> So what I'm trying to say is that in 6.4 we already changed the=
 behavior.
> > > > >>
> > > > >> Yes. To say the truth, it looks even worse but it might be too l=
ate to fix.
> > > > >
> > > > > Andres (cced) has identified two other possible changes:
> > > > >
> > > > > 1) doesn't run in the global PID namespace but run in the namespa=
ce of owner
> > > >
> > > > Yeah, I mentioned that one in vhost.h like it's a feature and when =
posting
> > > > the patches I mentioned it as a possible fix. I mean I thought we w=
anted it
> > > > to work like qemu and iothreads where the iothread would inherit al=
l those
> > > > values automatically.
> > >
> > > Right, but it could be noticed by the userspace, especially for the
> > > one that tries to do tweak on the performance.
> > >
> > > The root cause is the that now we do copy_processs() in the process o=
f
> > > Qemu instead of the kthreadd. Which result of the the differences of
> > > namespace (I think PID namespace is not the only one we see
> > > difference) and others for the vhost task.
> >
> > Leaking things out of a namespace looks more like a bug.
> > If you really have to be pedantic, the thing to add would
> > be a namespace flag not a qemu flag. Userspace running inside
> > a namespace really must have no say about whether to leak
> > info out of it.
> >
> > > >
> > > > At the time, I thought we didn't inherit the namespace, like we did=
 the cgroup,
> > > > because there was no kernel function for it (like how we didn't inh=
erit v2
> > > > cgroups until recently when someone added some code for that).
> > > >
> > > > I don't know if it's allowed to have something like qemu in namespa=
ce N but then
> > > > have it's children (vhost thread in this case) in the global namesp=
ace.
> > > > I'll
> > > > look into it.
> > >
> > > Instead of moving vhost thread between difference namespaces, I wonde=
r
> > > if the following is simpler:
> > >
> > > if (new_flag)
> > >     vhost_task_create()
> > > else
> > >     kthread_create()
> > >
> > > New flag inherits the attributes of Qemu (namespaces, rlimit, cgroup,
> > > scheduling attributes ...) which is what we want. Without the new
> > > flag, we stick exactly to the behaviour as in the past to unbreak
> > > existing userspace.
> > >
> > > >
> > > > > 2) doesn't inherit kthreadd's scheduling attributes but the owner
> > > >
> > > > Same as above for this one. I thought I was fixing a bug where befo=
re
> > > > we had to manually tune the vhost thread's values but for iothreads=
 they
> > > > automatically got setup.
> > > >
> > > > Just to clarify this one. When we used kthreads, kthread() will res=
et the
> > > > scheduler priority for the kthread that's created, so we got the de=
fault
> > > > values instead of inheriting kthreadd's values.  So we would want:
> > > >
> > > > +       sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> > > >
> > > > in vhost_task_fn() instead of inheriting kthreadd's values.
> > > >
> > > > >
> > > > > Though such a change makes more sense for some use cases, it may =
break others.
> > > > >
> > > > > I wonder if we need to introduce a new flag and bring the old kth=
read
> > > >
> > > > Do you mean something like a module param?
> > >
> > > This requires the management layer to know if it has a new user space
> > > or not which is hard. A better place is to introduce backend features=
.
> > >
> > > >
> > > > > codes if the flag is not set? Then we would not end up trying to =
align
> > > > > the behaviour?
> > > > >
> > > >
> > > > Let me know what you guys prefer. The sched part is easy. The names=
pace
> > > > part might be more difficult, but I will look into it if you want i=
t.
> > >
> > > Thanks a lot. I think it would be better to have the namespace part
> > > (as well as other namespaces) then we don't need to answer hard
> > > questions like if it can break user space or not.
> > >
> > > >
> >
>

