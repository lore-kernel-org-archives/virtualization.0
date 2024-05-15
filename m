Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DD3B785
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 06:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754487; cv=none; b=QRRMnnaXckdUdOGWNuJBzCihP+sUCWRkTiZgIbty7C8nwdOywS0RWMhcBErUVeShZrStcAtzcwImqxZWQKCez3zqG8IcSGepuIHKqPT6dI8137w3YH5WsRzxcdFWVYO1OfMKtP9HVJ+0Zbf3mMb0Yo8Dt7wxx7UIX7vrZXNTL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754487; c=relaxed/simple;
	bh=BChrAAJmnPMDjMXP01D9CO+sAXED8/q6Q2x+sUvEkWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmA9eHjMIpl8YsiLQGa+pziC3hCWkgmdUOnpMsuAFaOHD1fkFeSWWFPMWyJMqOlYs/oL7cC+BpiU72x9kycO+fg4N/z0914cYlEd/d3WNb18WAFwNT3H9qBrRdy8gjLeMKVz6qmAO/i7PbRpr71By62bil+dsU5Mt0Kqfy3W+LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTtEwMsO; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTtEwMsO"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4195D40668
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 06:28:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0bFOsEAXoecn for <virtualization@lists.linux-foundation.org>;
 Wed, 15 May 2024 06:28:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 113F1405F7
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 113F1405F7
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RTtEwMsO
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 113F1405F7
	for <virtualization@lists.linux-foundation.org>; Wed, 15 May 2024 06:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715754481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQw2gbGBPGc6pz1EkQA52KVa9UU+Vt2S7MOr0OcbRvc=;
	b=RTtEwMsO93lpU4+dtdicPxThvKxMAEx2fzAz2xcn3THizeUNOlzYgjcjNbG2YA+eDxov2B
	ej6ZMbgFqNDhLJRYpatzxn3d2AuRxLlu1GfQjFeQomFNpkWNQly+RCgB70vJVbR1Xnk6De
	Fg7hFx4SiNccn/5KBHO6vIwovOgsv9U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-U_saqp5ePaaCLkmvRkFVeA-1; Wed, 15 May 2024 02:27:50 -0400
X-MC-Unique: U_saqp5ePaaCLkmvRkFVeA-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2b9e0939124so193263a91.0
        for <virtualization@lists.linux-foundation.org>; Tue, 14 May 2024 23:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715754469; x=1716359269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQw2gbGBPGc6pz1EkQA52KVa9UU+Vt2S7MOr0OcbRvc=;
        b=Ryv3Rj28hdaqbW6oWj/wOE7iyK/QF3YcYkRkBNUXrFughMdfoul/YM54MHqjNSR+Hs
         keCkqifkYY9v2nUFHthpEl/4+DNi1q0suASK5O/M4WsRqeunfTml7wouogxAv8ykp7u0
         xioUafPNgtFXIL99pOCS8T+KUffFXzcoQqKdHLY6BFIRxlLx3jjx3ecQulKbibnWBUdI
         Q5wgojvvidc/VXZCc85iF9dM1XoJ8zF8tKRswimOwrMdrLm9D4n6IByeXTdYALpaQ1MW
         uXgu8eRZtTvpK1C7ehCgRDx81UYgedU5RxY+xesvdBdVAE1VuPy7+6W8UlOt2vhogW2t
         fDKw==
X-Forwarded-Encrypted: i=1; AJvYcCVAALWK22zl9uN9Xmsh0yo4L1C3kKltX2CE6jvimzqhxNC6tleMtIajYf3C6dV8QKesXpYDyG8lPq7SLvkS9mk8O0XLqGEo/9aayf93fFAxD4B1Gq+qTpWiMg==
X-Gm-Message-State: AOJu0Yzr21k1Ul8rodfEZfHNUntp8A6gY/V8nuXzPhYsxPU3cLBu5acV
	4Yt7BehRW4id0+iY2hOIY8vDuDJ3uADaLoYDe5zqxPteEdp8ZkxP2Ujdv0S8Ykwv8Q9VjqJPtit
	kZBylQEvF+SdkWIUf2awsVMRXvFZPll0Aiyhdsq6zznS48OzdHfHQ3OT+9b1n89syKclCF7bf1u
	oejwCSMnQt9G2R3lxeXhNCaq+DPaUusHeVK1IKMm177zPlBMdsxcHBsQ==
X-Received: by 2002:a17:90b:d89:b0:2b9:8c75:4537 with SMTP id 98e67ed59e1d1-2b98c755ccdmr3561689a91.40.1715754468899;
        Tue, 14 May 2024 23:27:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+XTsO97mvh9Wm7uO01k5FVY/9AH7OZ8e9nC4s0grPdwIYr9oVAo+fsj4bom6yBW7ivAPpeIg3EQIapm+AxTM=
X-Received: by 2002:a17:90b:d89:b0:2b9:8c75:4537 with SMTP id
 98e67ed59e1d1-2b98c755ccdmr3561667a91.40.1715754468364; Tue, 14 May 2024
 23:27:48 -0700 (PDT)
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
 <CACGkMEtA+n3=EmJ+ykK9eUZwUBjKRUB0sT0UG59zmeG99p3VeQ@mail.gmail.com> <CACGkMEvO1D4QJnMncOEZYqAtNO5ZujcWJ_FXDrb+7C__3WFjXw@mail.gmail.com>
In-Reply-To: <CACGkMEvO1D4QJnMncOEZYqAtNO5ZujcWJ_FXDrb+7C__3WFjXw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 May 2024 14:27:32 +0800
Message-ID: <CACGkMEs-urygu=h4_Y75ojwCKvRXH39fr-HpSTHchT8eL7issA@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andreas Karis <akaris@redhat.com>, Mike Christie <michael.christie@oracle.com>, oleg@redhat.com, 
	ebiederm@xmission.com, virtualization@lists.linux-foundation.org, 
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 8:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Apr 19, 2024 at 8:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Thu, Apr 18, 2024 at 5:26=E2=80=AFPM Andreas Karis <akaris@redhat.co=
m> wrote:
> > >
> > > Not a kernel developer, so sorry if this here is pointless spam.
> > >
> > > But qemu is not the only thing consuming /dev/vhost-net:
> > > https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html
> > >
> > > Before the series of patches around
> > > https://github.com/torvalds/linux/commit/e297cd54b3f81d652456ae6cb939=
41fc6b5c6683,
> > > you would run a DPDK application inside namespaces of container
> > > "blue", but then the vhost-... threads were spawned as children of
> > > kthreadd and run in the global namespaces. That seemed counter
> > > intuitive, and what's worse, the DPDK application running inside the
> > > "blue" container namespaces cannot see and thus cannot modify
> > > scheduling attributes and affinity of its own vhost-... threads. In
> > > scenarios with pretty strict isolation/pinning requirements, the
> > > vhost-... threads could easily be scheduled on the same CPUs as the
> > > DPDK poll mode drivers (because they inherit the calling process' CPU
> > > affinity), and there's no way for the DPDK process itself to move the
> > > vhost-... threads to other CPUs. Also, if the DPDK process ran as
> > > SCHED_RR, the vhost-.... thread would still be SCHED_NORMAL.
> > >
> > > After the patch series, the fact that the vhost-... threads run as
> > > tasks of the process that requests them seems more natural and gives
> > > us as users the kind of control that we'd want from within the
> > > container to modify the vhost-... threads' scheduling and affinity.
> > > The vhost-... thread as a child of the DPDK application inherits the
> > > same scheduling class, CPU set, etc and the DPDK process can easily
> > > change those attributes.
> > >
> > > However, if another user was used to the old behavior, and their
> > > entire tooling was created for the old behavior (imagine someone wrot=
e
> > > a bunch of scripts/services to force affinity from the global PID
> > > namespace for those vhost-... threads), and now this change was
> > > introduced, it would break their tooling. So because _I_ might fancy
> > > the new behavior, but user _B_ might be all set up for the old
> > > kthreadd, shouldn't there be a flag or configuration for the user to:
> > >
> > > if (new_flag)
> > >     vhost_task_create()
> > > else
> > >     kthread_create()
> > >
> > > I don't know what kind of flag or knob I'd expect here, but it could
> > > be granular for the calling process (a new syscall?), or a kernel
> > > flag, etc. But something that let's the admin choose how the kernel
> > > spawns the vhost-... threads?
> >
> > A flag via uAPI that could be controlled by the user of vhost-net via
> > syscall. For example, it could be done via set/get_backend_feautre()
> > syscall.
>
> So it can be controlled by the admin if we want.
>
> Thanks

Michael, does the flag make sense or not?

Thanks

>
> >
> > Thanks
> >
> > >
> > > On Thu, Apr 18, 2024 at 9:07=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Thu, Apr 18, 2024 at 12:08:52PM +0800, Jason Wang wrote:
> > > > > On Thu, Apr 18, 2024 at 12:10=E2=80=AFAM Mike Christie
> > > > > <michael.christie@oracle.com> wrote:
> > > > > >
> > > > > > On 4/16/24 10:50 PM, Jason Wang wrote:
> > > > > > > On Mon, Apr 15, 2024 at 4:52=E2=80=AFPM Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > >>
> > > > > > >> On Sat, Apr 13, 2024 at 12:53=E2=80=AFAM <michael.christie@o=
racle.com> wrote:
> > > > > > >>>
> > > > > > >>> On 4/11/24 10:28 PM, Jason Wang wrote:
> > > > > > >>>> On Fri, Apr 12, 2024 at 12:19=E2=80=AFAM Mike Christie
> > > > > > >>>> <michael.christie@oracle.com> wrote:
> > > > > > >>>>>
> > > > > > >>>>> On 4/11/24 3:39 AM, Jason Wang wrote:
> > > > > > >>>>>> On Sat, Mar 16, 2024 at 8:47=E2=80=AFAM Mike Christie
> > > > > > >>>>>> <michael.christie@oracle.com> wrote:
> > > > > > >>>>>>>
> > > > > > >>>>>>> The following patches were made over Linus's tree and a=
lso apply over
> > > > > > >>>>>>> mst's vhost branch. The patches add the ability for vho=
st_tasks to
> > > > > > >>>>>>> handle SIGKILL by flushing queued works, stop new works=
 from being
> > > > > > >>>>>>> queued, and prepare the task for an early exit.
> > > > > > >>>>>>>
> > > > > > >>>>>>> This removes the need for the signal/coredump hacks add=
ed in:
> > > > > > >>>>>>>
> > > > > > >>>>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to =
fix freezer/ps regression")
> > > > > > >>>>>>>
> > > > > > >>>>>>> when the vhost_task patches were initially merged and f=
ix the issue
> > > > > > >>>>>>> in this thread:
> > > > > > >>>>>>>
> > > > > > >>>>>>> https://lore.kernel.org/all/000000000000a41b82060e87572=
1@google.com/
> > > > > > >>>>>>>
> > > > > > >>>>>>> Long Background:
> > > > > > >>>>>>>
> > > > > > >>>>>>> The original vhost worker code didn't support any signa=
ls. If the
> > > > > > >>>>>>> userspace application that owned the worker got a SIGKI=
LL, the app/
> > > > > > >>>>>>> process would exit dropping all references to the devic=
e and then the
> > > > > > >>>>>>> file operation's release function would be called. From=
 there we would
> > > > > > >>>>>>> wait on running IO then cleanup the device's memory.
> > > > > > >>>>>>
> > > > > > >>>>>> A dumb question.
> > > > > > >>>>>>
> > > > > > >>>>>> Is this a user space noticeable change? For example, wit=
h this series
> > > > > > >>>>>> a SIGKILL may shutdown the datapath ...
> > > > > > >>>>>
> > > > > > >>>>> It already changed in 6.4. We basically added a new inter=
face to shutdown
> > > > > > >>>>> everything (userspace and vhost kernel parts). So we won'=
t just shutdown
> > > > > > >>>>> the data path while userspace is still running. We will s=
hutdown everything
> > > > > > >>>>> now if you send a SIGKILL to a vhost worker's thread.
> > > > > > >>>>
> > > > > > >>>> If I understand correctly, for example Qemu can still live=
 is SIGKILL
> > > > > > >>>> is just send to vhost thread.
> > > > > > >>>
> > > > > > >>> Pre-6.4 qemu could still survive if only the vhost thread g=
ot a SIGKILL.
> > > > > > >>> We used kthreads which are special and can ignore it like h=
ow userspace
> > > > > > >>> can ignore SIGHUP.
> > > > > > >>>
> > > > > > >>> 6.4 and newer kernels cannot survive. Even if the vhost thr=
ead sort of
> > > > > > >>> ignores it like I described below where, the signal is stil=
l delivered
> > > > > > >>> to the other qemu threads due to the shared signal handler.=
 Userspace
> > > > > > >>> can't ignore SIGKILL. It doesn't have any say in the matter=
, and the
> > > > > > >>> kernel forces them to exit.
> > > > > > >>
> > > > > > >> Ok, I see, so the reason is that vhost belongs to the same t=
hread
> > > > > > >> group as the owner now.
> > > > > > >>
> > > > > > >>>
> > > > > > >>>>
> > > > > > >>>> If this is correct, guests may detect this (for example vi=
rtio-net has
> > > > > > >>>> a watchdog).
> > > > > > >>>>
> > > > > > >>>
> > > > > > >>> What did you mean by that part? Do you mean if the vhost th=
read were to
> > > > > > >>> exit, so drivers/vhost/net.c couldn't process IO, then the =
watchdog in
> > > > > > >>> the guest (virtio-net driver in the guest kernel) would det=
ect that?
> > > > > > >>
> > > > > > >> I meant this one. But since we are using CLONE_THREAD, we wo=
n't see these.
> > > > > > >>
> > > > > > >>> Or
> > > > > > >>> are you saying the watchdog in the guest can detect signals=
 that the
> > > > > > >>> host gets?
> > > > > > >>>
> > > > > > >>>
> > > > > > >>>>>
> > > > > > >>>>> Here are a lots of details:
> > > > > > >>>>>
> > > > > > >>>>> - Pre-6.4 kernel, when vhost workers used kthreads, if yo=
u sent any signal
> > > > > > >>>>> to a vhost worker, we ignore it. Nothing happens. kthread=
s are special and
> > > > > > >>>>> can ignore all signals.
> > > > > > >>>>>
> > > > > > >>>>> You could think of it as the worker is a completely diffe=
rent process than
> > > > > > >>>>> qemu/userspace so they have completely different signal h=
andlers. The
> > > > > > >>>>> vhost worker signal handler ignores all signals even SIGK=
ILL.
> > > > > > >>>>
> > > > > > >>>> Yes.
> > > > > > >>>>
> > > > > > >>>>>
> > > > > > >>>>> If you send a SIGKILL to a qemu thread, then it just exit=
s right away. We
> > > > > > >>>>> don't get to do an explicit close() on the vhost device a=
nd we don't get
> > > > > > >>>>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends=
. The kernel exit
> > > > > > >>>>> code runs and releases refcounts on the device/file, then=
 the vhost device's
> > > > > > >>>>> file_operations->release function is called. vhost_dev_cl=
eanup then stops
> > > > > > >>>>> the vhost worker.
> > > > > > >>>>
> > > > > > >>>> Right.
> > > > > > >>>>
> > > > > > >>>>>
> > > > > > >>>>> - In 6.4 and newer kernels, vhost workers use vhost_tasks=
, so the worker
> > > > > > >>>>> can be thought of as a thread within the userspace proces=
s. With that
> > > > > > >>>>> change we have the same signal handler as the userspace p=
rocess.
> > > > > > >>>>>
> > > > > > >>>>> If you send a SIGKILL to a qemu thread then it works like=
 above.
> > > > > > >>>>>
> > > > > > >>>>> If you send a SIGKILL to a vhost worker, the vhost worker=
 still sort of
> > > > > > >>>>> ignores it (that is the hack that I mentioned at the begi=
nning of this
> > > > > > >>>>> thread). kernel/vhost_task.c:vhost_task_fn will see the s=
ignal and
> > > > > > >>>>> then just continue to process works until file_operations=
->release
> > > > > > >>>>> calls
> > > > > > >>>>
> > > > > > >>>> Yes, so this sticks to the behaviour before vhost_tasks.
> > > > > > >>>
> > > > > > >>> Not exactly. The vhost_task stays alive temporarily.
> > > > > > >>>
> > > > > > >>> The signal is still delivered to the userspace threads and =
they will
> > > > > > >>> exit due to getting the SIGKILL also. SIGKILL goes to all t=
he threads in
> > > > > > >>> the process and all userspace threads exit like normal beca=
use the vhost
> > > > > > >>> task and normal old userspace threads share a signal handle=
r. When
> > > > > > >>> userspace exits, the kernel force drops the refcounts on th=
e vhost
> > > > > > >>> devices and that runs the release function so the vhost_tas=
k will then exit.
> > > > > > >>>
> > > > > > >>> So what I'm trying to say is that in 6.4 we already changed=
 the behavior.
> > > > > > >>
> > > > > > >> Yes. To say the truth, it looks even worse but it might be t=
oo late to fix.
> > > > > > >
> > > > > > > Andres (cced) has identified two other possible changes:
> > > > > > >
> > > > > > > 1) doesn't run in the global PID namespace but run in the nam=
espace of owner
> > > > > >
> > > > > > Yeah, I mentioned that one in vhost.h like it's a feature and w=
hen posting
> > > > > > the patches I mentioned it as a possible fix. I mean I thought =
we wanted it
> > > > > > to work like qemu and iothreads where the iothread would inheri=
t all those
> > > > > > values automatically.
> > > > >
> > > > > Right, but it could be noticed by the userspace, especially for t=
he
> > > > > one that tries to do tweak on the performance.
> > > > >
> > > > > The root cause is the that now we do copy_processs() in the proce=
ss of
> > > > > Qemu instead of the kthreadd. Which result of the the differences=
 of
> > > > > namespace (I think PID namespace is not the only one we see
> > > > > difference) and others for the vhost task.
> > > >
> > > > Leaking things out of a namespace looks more like a bug.
> > > > If you really have to be pedantic, the thing to add would
> > > > be a namespace flag not a qemu flag. Userspace running inside
> > > > a namespace really must have no say about whether to leak
> > > > info out of it.
> > > >
> > > > > >
> > > > > > At the time, I thought we didn't inherit the namespace, like we=
 did the cgroup,
> > > > > > because there was no kernel function for it (like how we didn't=
 inherit v2
> > > > > > cgroups until recently when someone added some code for that).
> > > > > >
> > > > > > I don't know if it's allowed to have something like qemu in nam=
espace N but then
> > > > > > have it's children (vhost thread in this case) in the global na=
mespace.
> > > > > > I'll
> > > > > > look into it.
> > > > >
> > > > > Instead of moving vhost thread between difference namespaces, I w=
onder
> > > > > if the following is simpler:
> > > > >
> > > > > if (new_flag)
> > > > >     vhost_task_create()
> > > > > else
> > > > >     kthread_create()
> > > > >
> > > > > New flag inherits the attributes of Qemu (namespaces, rlimit, cgr=
oup,
> > > > > scheduling attributes ...) which is what we want. Without the new
> > > > > flag, we stick exactly to the behaviour as in the past to unbreak
> > > > > existing userspace.
> > > > >
> > > > > >
> > > > > > > 2) doesn't inherit kthreadd's scheduling attributes but the o=
wner
> > > > > >
> > > > > > Same as above for this one. I thought I was fixing a bug where =
before
> > > > > > we had to manually tune the vhost thread's values but for iothr=
eads they
> > > > > > automatically got setup.
> > > > > >
> > > > > > Just to clarify this one. When we used kthreads, kthread() will=
 reset the
> > > > > > scheduler priority for the kthread that's created, so we got th=
e default
> > > > > > values instead of inheriting kthreadd's values.  So we would wa=
nt:
> > > > > >
> > > > > > +       sched_setscheduler_nocheck(current, SCHED_NORMAL, &para=
m);
> > > > > >
> > > > > > in vhost_task_fn() instead of inheriting kthreadd's values.
> > > > > >
> > > > > > >
> > > > > > > Though such a change makes more sense for some use cases, it =
may break others.
> > > > > > >
> > > > > > > I wonder if we need to introduce a new flag and bring the old=
 kthread
> > > > > >
> > > > > > Do you mean something like a module param?
> > > > >
> > > > > This requires the management layer to know if it has a new user s=
pace
> > > > > or not which is hard. A better place is to introduce backend feat=
ures.
> > > > >
> > > > > >
> > > > > > > codes if the flag is not set? Then we would not end up trying=
 to align
> > > > > > > the behaviour?
> > > > > > >
> > > > > >
> > > > > > Let me know what you guys prefer. The sched part is easy. The n=
amespace
> > > > > > part might be more difficult, but I will look into it if you wa=
nt it.
> > > > >
> > > > > Thanks a lot. I think it would be better to have the namespace pa=
rt
> > > > > (as well as other namespaces) then we don't need to answer hard
> > > > > questions like if it can break user space or not.
> > > > >
> > > > > >
> > > >
> > >

