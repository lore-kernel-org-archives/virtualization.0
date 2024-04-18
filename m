Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2BA8C1F
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 04:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413352; cv=none; b=dCna4elIeyVt2X4R3MuCIZALTc9DIYM0uiQN5hX3VqAWlFK6w7u1soirC73tdFlnuipK8Bk7CTtoZY1Jj3yVYj5sEew3nQkwMd/sfA2GP9TWlp0Gd9Y0SuaMjiZuciebv6MCTJrVJeCo/ZALEB6hUqMfEbtVsCbhzFmsdJEiR+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413352; c=relaxed/simple;
	bh=zH9JgRUsljQwj2u0LxDkowGnPvilrNYoJZLGuEnmZP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j2Ubp/U9Ovw8IIrR3dE2ftDms1bqXJT/394pxLLelAV0+JUgDjDQVy5xTrMtCj2ZctnU0BQ/djUv6QBK0lm/DyjjWnfCzhWEhn0FFaCYuO7jLshYGEpqIQPLRYGPWv+dYcYhmJ89YmOfnNudj8y4MGk9CmlrLyaZkZXrC0mvD28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U9GyPqM6; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U9GyPqM6"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F9EB60839
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 04:09:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MKiJrrDgSpSa for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Apr 2024 04:09:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2AA406068C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2AA406068C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=U9GyPqM6
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2AA406068C
	for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 04:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713413347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1VF6yn17Cfw6Pb3pmV1rqQGLkPd3XD7WNCYSZMi7EI=;
	b=U9GyPqM6wII7n0HWq6KgDPdRvtM8UyWJdXnErOo731FIxZSo11rMLxiPnS6uurAC7gglIA
	5ZV/15V/StEn5jW5ikZVzXY91gR02EN8h2AYEeUh/bSqCTjsy9DKWpWO+kGd9ZjWERtAeQ
	HpR4o6/y9nIlr8RM1XwhTQiyblDx01E=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-VJ8492OzOm2Wu9A9EBXpgA-1; Thu, 18 Apr 2024 00:09:06 -0400
X-MC-Unique: VJ8492OzOm2Wu9A9EBXpgA-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ed2a12e50aso366852b3a.1
        for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 21:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713413345; x=1714018145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1VF6yn17Cfw6Pb3pmV1rqQGLkPd3XD7WNCYSZMi7EI=;
        b=Qpja1aV7H/pe6p3ILO3HoXeI5KH9T4gKsOinBPd8uxMuJRhhGTsWsni2aTPjgG5t1D
         hDOp4g/eHgewhyEb8dt0w2Jgi9ZGFL/Oc51IMJbvwjgGkEwtwLHtT4g02EOwBaGPfpQl
         SiZ2DV06iAegHeNymUggzPdPr9Vcha8JCf5zfphbLRl/7pZXWtZZh6e3J/RvewKQu1OH
         Uw/vlZ5WCikSHAKZPt3tPKSXYz7JsiTEYiUj74GdSf9kPMzUcGf5wED4jI/k6zTxjH4r
         ScoRfcQPARLDPcjB+q/Nsc486bj3VfIYbjio0+GOQQxznklQ4qK5fLxubAbCM0n3WFSP
         Y/3w==
X-Forwarded-Encrypted: i=1; AJvYcCWPNGQh9dSrmZJWBvm7PoTN5L1wGJRMogkeMNI1DVC0pHb91ziMRX6VFUs7YB2Mu7bZtXr5P60WeF96FIIyfp7X+UXSViHjX+pOdpc533qBywqXFACD5gQ+GQ==
X-Gm-Message-State: AOJu0Yw1a6wtcFSKQP23lf5RoQe88+yfzutTNftfeJ5u/nGnNSyGwMWh
	pFhJ2HmmB6741axnhokOVkcjVvYRIjKuVdadieQ6LUbdkZADiZ8rlnAcT/4rjZS/c7q6E81i9A3
	wL9jLMaAZ/s7vAl9csK/ROjFhgSrOy6RTYA2LTnTWwPpq3Y9M0a6KKl41h5FfhRI84sYYv8J5l/
	BFjqGYrv4Zkx8eb+984yoDcdku9UsjGrZD8A216eO/TZgaYfnyN/fxtA==
X-Received: by 2002:a05:6a00:4b4e:b0:6ec:d3a6:801 with SMTP id kr14-20020a056a004b4e00b006ecd3a60801mr1837718pfb.11.1713413345040;
        Wed, 17 Apr 2024 21:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeCa6N8hbuUx9fWh7NSnsMCX+/GIDHuyaKKAkoPBJmZIKXVS6tKb0InU2c1FdogA8TbjYlfFiyctczgRDonUY=
X-Received: by 2002:a05:6a00:4b4e:b0:6ec:d3a6:801 with SMTP id
 kr14-20020a056a004b4e00b006ecd3a60801mr1837682pfb.11.1713413344543; Wed, 17
 Apr 2024 21:09:04 -0700 (PDT)
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
 <CACGkMEumEd+5bEjKosK3jY8TxveEas+QAOVSCEiYsR56Ag3C0w@mail.gmail.com> <edc792c4-30c9-4065-bf09-657bd7766d04@oracle.com>
In-Reply-To: <edc792c4-30c9-4065-bf09-657bd7766d04@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 Apr 2024 12:08:52 +0800
Message-ID: <CACGkMEsH=+e+E234KymEdvZT-4K37X3iEmTKpvqGpMvSPkzRLQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: Mike Christie <michael.christie@oracle.com>
Cc: oleg@redhat.com, ebiederm@xmission.com, 
	virtualization@lists.linux-foundation.org, mst@redhat.com, 
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org, 
	Andreas Karis <akaris@redhat.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:10=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 4/16/24 10:50 PM, Jason Wang wrote:
> > On Mon, Apr 15, 2024 at 4:52=E2=80=AFPM Jason Wang <jasowang@redhat.com=
> wrote:
> >>
> >> On Sat, Apr 13, 2024 at 12:53=E2=80=AFAM <michael.christie@oracle.com>=
 wrote:
> >>>
> >>> On 4/11/24 10:28 PM, Jason Wang wrote:
> >>>> On Fri, Apr 12, 2024 at 12:19=E2=80=AFAM Mike Christie
> >>>> <michael.christie@oracle.com> wrote:
> >>>>>
> >>>>> On 4/11/24 3:39 AM, Jason Wang wrote:
> >>>>>> On Sat, Mar 16, 2024 at 8:47=E2=80=AFAM Mike Christie
> >>>>>> <michael.christie@oracle.com> wrote:
> >>>>>>>
> >>>>>>> The following patches were made over Linus's tree and also apply =
over
> >>>>>>> mst's vhost branch. The patches add the ability for vhost_tasks t=
o
> >>>>>>> handle SIGKILL by flushing queued works, stop new works from bein=
g
> >>>>>>> queued, and prepare the task for an early exit.
> >>>>>>>
> >>>>>>> This removes the need for the signal/coredump hacks added in:
> >>>>>>>
> >>>>>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freeze=
r/ps regression")
> >>>>>>>
> >>>>>>> when the vhost_task patches were initially merged and fix the iss=
ue
> >>>>>>> in this thread:
> >>>>>>>
> >>>>>>> https://lore.kernel.org/all/000000000000a41b82060e875721@google.c=
om/
> >>>>>>>
> >>>>>>> Long Background:
> >>>>>>>
> >>>>>>> The original vhost worker code didn't support any signals. If the
> >>>>>>> userspace application that owned the worker got a SIGKILL, the ap=
p/
> >>>>>>> process would exit dropping all references to the device and then=
 the
> >>>>>>> file operation's release function would be called. From there we =
would
> >>>>>>> wait on running IO then cleanup the device's memory.
> >>>>>>
> >>>>>> A dumb question.
> >>>>>>
> >>>>>> Is this a user space noticeable change? For example, with this ser=
ies
> >>>>>> a SIGKILL may shutdown the datapath ...
> >>>>>
> >>>>> It already changed in 6.4. We basically added a new interface to sh=
utdown
> >>>>> everything (userspace and vhost kernel parts). So we won't just shu=
tdown
> >>>>> the data path while userspace is still running. We will shutdown ev=
erything
> >>>>> now if you send a SIGKILL to a vhost worker's thread.
> >>>>
> >>>> If I understand correctly, for example Qemu can still live is SIGKIL=
L
> >>>> is just send to vhost thread.
> >>>
> >>> Pre-6.4 qemu could still survive if only the vhost thread got a SIGKI=
LL.
> >>> We used kthreads which are special and can ignore it like how userspa=
ce
> >>> can ignore SIGHUP.
> >>>
> >>> 6.4 and newer kernels cannot survive. Even if the vhost thread sort o=
f
> >>> ignores it like I described below where, the signal is still delivere=
d
> >>> to the other qemu threads due to the shared signal handler. Userspace
> >>> can't ignore SIGKILL. It doesn't have any say in the matter, and the
> >>> kernel forces them to exit.
> >>
> >> Ok, I see, so the reason is that vhost belongs to the same thread
> >> group as the owner now.
> >>
> >>>
> >>>>
> >>>> If this is correct, guests may detect this (for example virtio-net h=
as
> >>>> a watchdog).
> >>>>
> >>>
> >>> What did you mean by that part? Do you mean if the vhost thread were =
to
> >>> exit, so drivers/vhost/net.c couldn't process IO, then the watchdog i=
n
> >>> the guest (virtio-net driver in the guest kernel) would detect that?
> >>
> >> I meant this one. But since we are using CLONE_THREAD, we won't see th=
ese.
> >>
> >>> Or
> >>> are you saying the watchdog in the guest can detect signals that the
> >>> host gets?
> >>>
> >>>
> >>>>>
> >>>>> Here are a lots of details:
> >>>>>
> >>>>> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent any=
 signal
> >>>>> to a vhost worker, we ignore it. Nothing happens. kthreads are spec=
ial and
> >>>>> can ignore all signals.
> >>>>>
> >>>>> You could think of it as the worker is a completely different proce=
ss than
> >>>>> qemu/userspace so they have completely different signal handlers. T=
he
> >>>>> vhost worker signal handler ignores all signals even SIGKILL.
> >>>>
> >>>> Yes.
> >>>>
> >>>>>
> >>>>> If you send a SIGKILL to a qemu thread, then it just exits right aw=
ay. We
> >>>>> don't get to do an explicit close() on the vhost device and we don'=
t get
> >>>>> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kern=
el exit
> >>>>> code runs and releases refcounts on the device/file, then the vhost=
 device's
> >>>>> file_operations->release function is called. vhost_dev_cleanup then=
 stops
> >>>>> the vhost worker.
> >>>>
> >>>> Right.
> >>>>
> >>>>>
> >>>>> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so the w=
orker
> >>>>> can be thought of as a thread within the userspace process. With th=
at
> >>>>> change we have the same signal handler as the userspace process.
> >>>>>
> >>>>> If you send a SIGKILL to a qemu thread then it works like above.
> >>>>>
> >>>>> If you send a SIGKILL to a vhost worker, the vhost worker still sor=
t of
> >>>>> ignores it (that is the hack that I mentioned at the beginning of t=
his
> >>>>> thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
> >>>>> then just continue to process works until file_operations->release
> >>>>> calls
> >>>>
> >>>> Yes, so this sticks to the behaviour before vhost_tasks.
> >>>
> >>> Not exactly. The vhost_task stays alive temporarily.
> >>>
> >>> The signal is still delivered to the userspace threads and they will
> >>> exit due to getting the SIGKILL also. SIGKILL goes to all the threads=
 in
> >>> the process and all userspace threads exit like normal because the vh=
ost
> >>> task and normal old userspace threads share a signal handler. When
> >>> userspace exits, the kernel force drops the refcounts on the vhost
> >>> devices and that runs the release function so the vhost_task will the=
n exit.
> >>>
> >>> So what I'm trying to say is that in 6.4 we already changed the behav=
ior.
> >>
> >> Yes. To say the truth, it looks even worse but it might be too late to=
 fix.
> >
> > Andres (cced) has identified two other possible changes:
> >
> > 1) doesn't run in the global PID namespace but run in the namespace of =
owner
>
> Yeah, I mentioned that one in vhost.h like it's a feature and when postin=
g
> the patches I mentioned it as a possible fix. I mean I thought we wanted =
it
> to work like qemu and iothreads where the iothread would inherit all thos=
e
> values automatically.

Right, but it could be noticed by the userspace, especially for the
one that tries to do tweak on the performance.

The root cause is the that now we do copy_processs() in the process of
Qemu instead of the kthreadd. Which result of the the differences of
namespace (I think PID namespace is not the only one we see
difference) and others for the vhost task.

>
> At the time, I thought we didn't inherit the namespace, like we did the c=
group,
> because there was no kernel function for it (like how we didn't inherit v=
2
> cgroups until recently when someone added some code for that).
>
> I don't know if it's allowed to have something like qemu in namespace N b=
ut then
> have it's children (vhost thread in this case) in the global namespace.
> I'll
> look into it.

Instead of moving vhost thread between difference namespaces, I wonder
if the following is simpler:

if (new_flag)
    vhost_task_create()
else
    kthread_create()

New flag inherits the attributes of Qemu (namespaces, rlimit, cgroup,
scheduling attributes ...) which is what we want. Without the new
flag, we stick exactly to the behaviour as in the past to unbreak
existing userspace.

>
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
> +       sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
>
> in vhost_task_fn() instead of inheriting kthreadd's values.
>
> >
> > Though such a change makes more sense for some use cases, it may break =
others.
> >
> > I wonder if we need to introduce a new flag and bring the old kthread
>
> Do you mean something like a module param?

This requires the management layer to know if it has a new user space
or not which is hard. A better place is to introduce backend features.

>
> > codes if the flag is not set? Then we would not end up trying to align
> > the behaviour?
> >
>
> Let me know what you guys prefer. The sched part is easy. The namespace
> part might be more difficult, but I will look into it if you want it.

Thanks a lot. I think it would be better to have the namespace part
(as well as other namespaces) then we don't need to answer hard
questions like if it can break user space or not.

>

