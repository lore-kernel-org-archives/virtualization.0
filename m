Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB44A2110F
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Apr 2024 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171183; cv=none; b=VoJDKc9Hgt4Z8TmFDAf7WLA3zZegq6STFgqEOTM0mZcG91+sJ0Ja+vV9iW/jfVS3/cSfte0Xl0K0Xb8ExAEu/si09s3wwQyGbMg9ic4MsuAonCIK7M9Wb8UEccUwO9dLBhe8WTBWbF30iZS3WR4TRAzwaFJmOT3X7WdHCJv30AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171183; c=relaxed/simple;
	bh=1+5G1Q4K1ZeMh9XO6Aj8qPpHNTeWMI+17QBkNex+l5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXKGAf5x2WPhmPbfBkK6v8720GXSRLeSi8ctksa/kKNfLDua5gs4EOnt/xKIxGzP0xuUcsY95O8f57ehfHfAyRv7+EReekI5cyExJ+/ntR/L9vgk8rtvuHMa+cJ+QmfNkv5HZvYUF2YLoIeRvOtfE8Q5WAOL77Ov2C9nMxaONKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iWkVbxHD; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iWkVbxHD"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5133C81A58
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Apr 2024 08:53:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Rg5frvmsY8W for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Apr 2024 08:53:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 08F0D8187F
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08F0D8187F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iWkVbxHD
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 08F0D8187F
	for <virtualization@lists.linux-foundation.org>; Mon, 15 Apr 2024 08:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713171179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAlm8htNNWhFreVH94mgAL2MHshARVWyDJDsMB55FXU=;
	b=iWkVbxHDIj65zn16H5M67bTNnWStgBijmN98OalBpy0GCkxNV/OgkLOOzHYZF97I64hfSN
	mhRsbdW6dfgcApJibDpPnPNLa4tpnuyf3keFbtVPMEyP6MdRgoeBBwJNH1VAANuPGmn2Cu
	Kp+eB8roaKTS1VF97a/o5N1E0FK9eUw=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-C_d1Iun1MYi4UkEtPDL42g-1; Mon, 15 Apr 2024 04:52:57 -0400
X-MC-Unique: C_d1Iun1MYi4UkEtPDL42g-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5ce67a3f275so2008531a12.0
        for <virtualization@lists.linux-foundation.org>; Mon, 15 Apr 2024 01:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713171177; x=1713775977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAlm8htNNWhFreVH94mgAL2MHshARVWyDJDsMB55FXU=;
        b=gXQgGpg2hf+EGgbLAi/Nw7RSsbRO7JJVQXC/GHVc4QgO7cOzlGFA4cBb+IlnrwYweD
         MOAV3gD/zbrgLmZeoLBebZBaQp5zgA0/CGalqas7Y7sQLPyH9EZflfeI65ERqw6uCG+1
         Gao1EfULskdgUkTn0W20XVQk+8ACVS57Ra1dhCtKYt2O5IMG41c/pe/djof4gq/6bIqo
         iq+gGFskzFjmP7EI5hyfCN3PJqh6YnSbH4OJxDg/4hak4LIDU1Qi1DQUbUcrl1yH7K10
         PwPj6FNWhoWk1Hwvlg8wxrsIRApmDmf9HKKTuMRfGdu4V0MN1X30NERISRFhLYIDtp/d
         1m6g==
X-Forwarded-Encrypted: i=1; AJvYcCXv60HL/GtdOS6xbr6eFDwr5g/t86eGE21F3KCVHD8cvW7bEJenj5RiueT4g9Y0MAea5N3PMqBKlBNYZs4AkKD86hWAopu5DPcRVGG5//0uswQcgzqTUYikSw==
X-Gm-Message-State: AOJu0YxexpVFKtmcXsQ/LLXKp44BlPTaSZ9ZUtvP8wDhrQ8VDvfxkLbU
	O6/3CD9YA32X2xiuyttQIHSXYWdChT77JU2zOFk3dETzl/7ddNSgLxJvXPAGz5gpZHMv9w3Rpr7
	9DBSLqjqX8t0MHcyfuX1HIC2NKB8DUpskm8KOmMAGiZ8WawLm479L1ijSisovckFWlPtYF4lCOz
	u7F7b+aQrZOstIhVkjBTAJMVIM5TAG7f8sbisUfPT/D15YQvLTic7vNQ==
X-Received: by 2002:a05:6a20:729c:b0:1a7:50e6:2f54 with SMTP id o28-20020a056a20729c00b001a750e62f54mr8245904pzk.42.1713171176715;
        Mon, 15 Apr 2024 01:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEvFh92RItIU2s/CejKrTzFbb9MeCrqS82E3Atroe+DwnOWVmvagTOrzMNmTgl+yd9+T+A/G0As1iW8ZJpHL0=
X-Received: by 2002:a05:6a20:729c:b0:1a7:50e6:2f54 with SMTP id
 o28-20020a056a20729c00b001a750e62f54mr8245889pzk.42.1713171176371; Mon, 15
 Apr 2024 01:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com>
 <9f75952f-c1a4-4483-8ec7-beddf022a821@oracle.com> <CACGkMEuY9cyCb+myzscHDetbfmDLZN-_JAFvZaAfrO0-Mc0FTA@mail.gmail.com>
 <06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com>
In-Reply-To: <06369c2c-c363-4def-9ce0-f018a9e10e8d@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Apr 2024 16:52:44 +0800
Message-ID: <CACGkMEtm=YwQ6ZVyPGz+T=H2E8u6etv9OKbibtfMdzA7K6GibQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: michael.christie@oracle.com
Cc: oleg@redhat.com, ebiederm@xmission.com, 
	virtualization@lists.linux-foundation.org, mst@redhat.com, 
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 12:53=E2=80=AFAM <michael.christie@oracle.com> wrot=
e:
>
> On 4/11/24 10:28 PM, Jason Wang wrote:
> > On Fri, Apr 12, 2024 at 12:19=E2=80=AFAM Mike Christie
> > <michael.christie@oracle.com> wrote:
> >>
> >> On 4/11/24 3:39 AM, Jason Wang wrote:
> >>> On Sat, Mar 16, 2024 at 8:47=E2=80=AFAM Mike Christie
> >>> <michael.christie@oracle.com> wrote:
> >>>>
> >>>> The following patches were made over Linus's tree and also apply ove=
r
> >>>> mst's vhost branch. The patches add the ability for vhost_tasks to
> >>>> handle SIGKILL by flushing queued works, stop new works from being
> >>>> queued, and prepare the task for an early exit.
> >>>>
> >>>> This removes the need for the signal/coredump hacks added in:
> >>>>
> >>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/p=
s regression")
> >>>>
> >>>> when the vhost_task patches were initially merged and fix the issue
> >>>> in this thread:
> >>>>
> >>>> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
> >>>>
> >>>> Long Background:
> >>>>
> >>>> The original vhost worker code didn't support any signals. If the
> >>>> userspace application that owned the worker got a SIGKILL, the app/
> >>>> process would exit dropping all references to the device and then th=
e
> >>>> file operation's release function would be called. From there we wou=
ld
> >>>> wait on running IO then cleanup the device's memory.
> >>>
> >>> A dumb question.
> >>>
> >>> Is this a user space noticeable change? For example, with this series
> >>> a SIGKILL may shutdown the datapath ...
> >>
> >> It already changed in 6.4. We basically added a new interface to shutd=
own
> >> everything (userspace and vhost kernel parts). So we won't just shutdo=
wn
> >> the data path while userspace is still running. We will shutdown every=
thing
> >> now if you send a SIGKILL to a vhost worker's thread.
> >
> > If I understand correctly, for example Qemu can still live is SIGKILL
> > is just send to vhost thread.
>
> Pre-6.4 qemu could still survive if only the vhost thread got a SIGKILL.
> We used kthreads which are special and can ignore it like how userspace
> can ignore SIGHUP.
>
> 6.4 and newer kernels cannot survive. Even if the vhost thread sort of
> ignores it like I described below where, the signal is still delivered
> to the other qemu threads due to the shared signal handler. Userspace
> can't ignore SIGKILL. It doesn't have any say in the matter, and the
> kernel forces them to exit.

Ok, I see, so the reason is that vhost belongs to the same thread
group as the owner now.

>
> >
> > If this is correct, guests may detect this (for example virtio-net has
> > a watchdog).
> >
>
> What did you mean by that part? Do you mean if the vhost thread were to
> exit, so drivers/vhost/net.c couldn't process IO, then the watchdog in
> the guest (virtio-net driver in the guest kernel) would detect that?

I meant this one. But since we are using CLONE_THREAD, we won't see these.

> Or
> are you saying the watchdog in the guest can detect signals that the
> host gets?
>
>
> >>
> >> Here are a lots of details:
> >>
> >> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent any si=
gnal
> >> to a vhost worker, we ignore it. Nothing happens. kthreads are special=
 and
> >> can ignore all signals.
> >>
> >> You could think of it as the worker is a completely different process =
than
> >> qemu/userspace so they have completely different signal handlers. The
> >> vhost worker signal handler ignores all signals even SIGKILL.
> >
> > Yes.
> >
> >>
> >> If you send a SIGKILL to a qemu thread, then it just exits right away.=
 We
> >> don't get to do an explicit close() on the vhost device and we don't g=
et
> >> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kernel =
exit
> >> code runs and releases refcounts on the device/file, then the vhost de=
vice's
> >> file_operations->release function is called. vhost_dev_cleanup then st=
ops
> >> the vhost worker.
> >
> > Right.
> >
> >>
> >> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so the work=
er
> >> can be thought of as a thread within the userspace process. With that
> >> change we have the same signal handler as the userspace process.
> >>
> >> If you send a SIGKILL to a qemu thread then it works like above.
> >>
> >> If you send a SIGKILL to a vhost worker, the vhost worker still sort o=
f
> >> ignores it (that is the hack that I mentioned at the beginning of this
> >> thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
> >> then just continue to process works until file_operations->release
> >> calls
> >
> > Yes, so this sticks to the behaviour before vhost_tasks.
>
> Not exactly. The vhost_task stays alive temporarily.
>
> The signal is still delivered to the userspace threads and they will
> exit due to getting the SIGKILL also. SIGKILL goes to all the threads in
> the process and all userspace threads exit like normal because the vhost
> task and normal old userspace threads share a signal handler. When
> userspace exits, the kernel force drops the refcounts on the vhost
> devices and that runs the release function so the vhost_task will then ex=
it.
>
> So what I'm trying to say is that in 6.4 we already changed the behavior.

Yes. To say the truth, it looks even worse but it might be too late to fix.

>
> >
> >>
> >> However, the change in behavior is that because the worker is just a
> >> thread within qemu, qemu is going to exit since they share a signal
> >> handler and userspace can't ignore SIGKILL.
> >> We then run perform the
> >> steps above like in the pre-6.4 kernel description as if you sent a
> >> SIGKILL directly to a userspace thread.
> >>
> >> - With the patches in this thread there is no major difference in beha=
vior
> >> with 6.4 and newer kernels. We might exit a little faster. Instead of =
the
> >> vhost thread trying to do it's hacked up version of ignoring the signa=
l
> >> and waiting for userspace to exit and call file_operations->release, t=
he
> >> vhost worker thread will exit after it flushes works and stops new one=
s.
> >> So now, you can have the vhost thread exiting in parallel with the
> >> userspace thread.
> >
> > Everything would be fine if Qemu wanted to quit but I meant there
> > could be a case where SIGKILL was sent to the vhost thread but not
> > Qemu.
>
>
> Yeah, in the last mail, I was trying to say that behavior already
> changed in 6.4. In 6.4 we basically added a new interface to the vhost
> layer that uses signals/SIGKILL to tell the vhost layer and userspace to
> completely shutdown.
>
> This patchset is just removing the hacks Eric and Oleg allowed for us in
> 6.4. That code where we do our hacked up version of ignoring signals
> (clear it and just go on) combined with the signals/coredump related
> hacks done in this patch:
>
> commit f9010dbdce911ee1f1af1398a24b1f9f992e0080
> Author: Mike Christie <michael.christie@oracle.com>
> Date:   Thu Jun 1 13:32:32 2023 -0500
>
>     fork, vhost: Use CLONE_THREAD to fix freezer/ps regression
>
>
> is causing this bug:
>
> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
>
> Basically, as Eric mentions in that thread the signal/kernel developers
> considered the signal/coredump hacks were meant to be temp, and we were
> supposed to convert to work more like io_uring's io_worker_exit. That's
> what I'm doing in this patchset. Patch 9/9 in this set then removes the
> hacks from the core kernel/signal code.
>

Ok.

Thanks

