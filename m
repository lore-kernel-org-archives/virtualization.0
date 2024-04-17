Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A513543AAE
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713325833; cv=none; b=ENauVU1/kbrkaDCOVr1mZHUqHFrnJUuPwQ5/gjyq2WUGp2vsYC0pilSliodxWRXq9v3EezO/oY6XYwLU4x9hjoW+Br0a/TCz41+G39CF4soNq0wUCsdlQk6v5O7W8G8cWe0zzCBmc3Mpetq90WGcI9PxZEQ4ToeafpbUkEIUD+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713325833; c=relaxed/simple;
	bh=1GTLaaKKQhGDVYYknUjD/txVKBNAGnMEnvBTEjPLUYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qQQor4ntUcCKd0Rdr1jP6z29r9HgsZSuzPvAoZPNKJYwbJy4GjqhcIOKzE8b9fCuCYtqUgGqub1mYjjFiZTjFhXfHqMVjnYWmeqhpY68qfhCQQcHIuNQfzzK67HnysIqa0+XC0W8yzElXH3OFNAj6oI4jPxD8sUagTtxZR9YwcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hK1vLBpo; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hK1vLBpo"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2CCEF40497
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 03:50:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -0.599
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JhjgOT00fBvI for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Apr 2024 03:50:30 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E060540116
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E060540116
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hK1vLBpo
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E060540116
	for <virtualization@lists.linux-foundation.org>; Wed, 17 Apr 2024 03:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713325828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GTLaaKKQhGDVYYknUjD/txVKBNAGnMEnvBTEjPLUYI=;
	b=hK1vLBpocLddBjbdvw9dp9LOFMYH+UqC9DdJfF7gvPl4gStAubnFtfzrorbo5/qWkWXpjI
	VCDYSQElb6hW3/dOG+eE/i17nfTL5g7BK6Y3Cv9tVONLufOUKp1xRJHClPCESndTsenK6Q
	OQYp42HB0S2qCTQeTi4L/hgtI9jOc7A=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-GM8Mk8KgOJi86PnKJJYFpA-1; Tue, 16 Apr 2024 23:50:24 -0400
X-MC-Unique: GM8Mk8KgOJi86PnKJJYFpA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d8dc8f906aso2949389a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 16 Apr 2024 20:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713325823; x=1713930623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GTLaaKKQhGDVYYknUjD/txVKBNAGnMEnvBTEjPLUYI=;
        b=AW9/vVfZ/49xoNlvLbv15Fr63oH/H2cWJBDkGBNM40KyjeihvVCEY6ihBZdBrNbuHL
         OqJjYKzuq4YBjbxbGqOiBEhTEIqjyeaJ48Wt+ZXs2aDeuZF9VvlyIhoLdrso2LlSO674
         Qa9/kECL4C1/Iy9QVvirc3TltKsNDARarBp6MNlWK5NKMCFWZMesxAU9pJOf1ClSNCDe
         /HkAoEs2SC2By0789m+JFh/Cjuav/BcMsMS7DlJDbJNHFtmpuevHAXG2FdNlxIHwhufK
         5dQ9MYP22oQi5THoS6KWhKRQa1zQi0Q1HsTEoSqkS4aahz0XphL1uuKL1BG84CDELOR1
         Fx1g==
X-Forwarded-Encrypted: i=1; AJvYcCXp+PBy02SXCQlYp71iBeXVKzvesdVAegfrTXCNEOfCRbG1sDIvVI6QxVRJD3v9Y7PYwvuBBViVENx2xoGOw0F9SdWVkFoDgHOmXf26z/ilpls8ivu/pAN4yw==
X-Gm-Message-State: AOJu0YybvonkiG/kvNuuQ8himU6IZI737ZGQzfIRW5nSv5m/S0k/ZRWA
	AGnPplcY63vm3ac6JPJWLfNvdE2qUKLYdeZXLPc3e5d64VGi+2p2PlIusv7pEyg1Ct1ZJTglmH8
	cPf0a6Bcm/98Mo1ulN57//Rmwlobo0HHDAb/MQqi3gSjUjDFHhp0+uk1VCZB0s0bPLB18yKgHAc
	GfbUyeAzZGVrM84jj3bUk3ckoGuEXoHH4tB4XDFECsBTM1OfzJ0RBERA==
X-Received: by 2002:a05:6a21:1505:b0:1aa:5e21:17ac with SMTP id nq5-20020a056a21150500b001aa5e2117acmr3123047pzb.6.1713325823332;
        Tue, 16 Apr 2024 20:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEe/BTJkUbo5DpHAkeHCLvlKSzQYEBGMJ+4giVK7BlNv1xmn3tKl4WBcdiRNMzCC1BKBbdheJ76DNyn8jqyGZk=
X-Received: by 2002:a05:6a21:1505:b0:1aa:5e21:17ac with SMTP id
 nq5-20020a056a21150500b001aa5e2117acmr3123039pzb.6.1713325822958; Tue, 16 Apr
 2024 20:50:22 -0700 (PDT)
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
In-Reply-To: <CACGkMEtm=YwQ6ZVyPGz+T=H2E8u6etv9OKbibtfMdzA7K6GibQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 17 Apr 2024 11:50:11 +0800
Message-ID: <CACGkMEumEd+5bEjKosK3jY8TxveEas+QAOVSCEiYsR56Ag3C0w@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: michael.christie@oracle.com
Cc: oleg@redhat.com, ebiederm@xmission.com, 
	virtualization@lists.linux-foundation.org, mst@redhat.com, 
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org, 
	Andreas Karis <akaris@redhat.com>, Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:52=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Apr 13, 2024 at 12:53=E2=80=AFAM <michael.christie@oracle.com> wr=
ote:
> >
> > On 4/11/24 10:28 PM, Jason Wang wrote:
> > > On Fri, Apr 12, 2024 at 12:19=E2=80=AFAM Mike Christie
> > > <michael.christie@oracle.com> wrote:
> > >>
> > >> On 4/11/24 3:39 AM, Jason Wang wrote:
> > >>> On Sat, Mar 16, 2024 at 8:47=E2=80=AFAM Mike Christie
> > >>> <michael.christie@oracle.com> wrote:
> > >>>>
> > >>>> The following patches were made over Linus's tree and also apply o=
ver
> > >>>> mst's vhost branch. The patches add the ability for vhost_tasks to
> > >>>> handle SIGKILL by flushing queued works, stop new works from being
> > >>>> queued, and prepare the task for an early exit.
> > >>>>
> > >>>> This removes the need for the signal/coredump hacks added in:
> > >>>>
> > >>>> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer=
/ps regression")
> > >>>>
> > >>>> when the vhost_task patches were initially merged and fix the issu=
e
> > >>>> in this thread:
> > >>>>
> > >>>> https://lore.kernel.org/all/000000000000a41b82060e875721@google.co=
m/
> > >>>>
> > >>>> Long Background:
> > >>>>
> > >>>> The original vhost worker code didn't support any signals. If the
> > >>>> userspace application that owned the worker got a SIGKILL, the app=
/
> > >>>> process would exit dropping all references to the device and then =
the
> > >>>> file operation's release function would be called. From there we w=
ould
> > >>>> wait on running IO then cleanup the device's memory.
> > >>>
> > >>> A dumb question.
> > >>>
> > >>> Is this a user space noticeable change? For example, with this seri=
es
> > >>> a SIGKILL may shutdown the datapath ...
> > >>
> > >> It already changed in 6.4. We basically added a new interface to shu=
tdown
> > >> everything (userspace and vhost kernel parts). So we won't just shut=
down
> > >> the data path while userspace is still running. We will shutdown eve=
rything
> > >> now if you send a SIGKILL to a vhost worker's thread.
> > >
> > > If I understand correctly, for example Qemu can still live is SIGKILL
> > > is just send to vhost thread.
> >
> > Pre-6.4 qemu could still survive if only the vhost thread got a SIGKILL=
.
> > We used kthreads which are special and can ignore it like how userspace
> > can ignore SIGHUP.
> >
> > 6.4 and newer kernels cannot survive. Even if the vhost thread sort of
> > ignores it like I described below where, the signal is still delivered
> > to the other qemu threads due to the shared signal handler. Userspace
> > can't ignore SIGKILL. It doesn't have any say in the matter, and the
> > kernel forces them to exit.
>
> Ok, I see, so the reason is that vhost belongs to the same thread
> group as the owner now.
>
> >
> > >
> > > If this is correct, guests may detect this (for example virtio-net ha=
s
> > > a watchdog).
> > >
> >
> > What did you mean by that part? Do you mean if the vhost thread were to
> > exit, so drivers/vhost/net.c couldn't process IO, then the watchdog in
> > the guest (virtio-net driver in the guest kernel) would detect that?
>
> I meant this one. But since we are using CLONE_THREAD, we won't see these=
.
>
> > Or
> > are you saying the watchdog in the guest can detect signals that the
> > host gets?
> >
> >
> > >>
> > >> Here are a lots of details:
> > >>
> > >> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent any =
signal
> > >> to a vhost worker, we ignore it. Nothing happens. kthreads are speci=
al and
> > >> can ignore all signals.
> > >>
> > >> You could think of it as the worker is a completely different proces=
s than
> > >> qemu/userspace so they have completely different signal handlers. Th=
e
> > >> vhost worker signal handler ignores all signals even SIGKILL.
> > >
> > > Yes.
> > >
> > >>
> > >> If you send a SIGKILL to a qemu thread, then it just exits right awa=
y. We
> > >> don't get to do an explicit close() on the vhost device and we don't=
 get
> > >> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kerne=
l exit
> > >> code runs and releases refcounts on the device/file, then the vhost =
device's
> > >> file_operations->release function is called. vhost_dev_cleanup then =
stops
> > >> the vhost worker.
> > >
> > > Right.
> > >
> > >>
> > >> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so the wo=
rker
> > >> can be thought of as a thread within the userspace process. With tha=
t
> > >> change we have the same signal handler as the userspace process.
> > >>
> > >> If you send a SIGKILL to a qemu thread then it works like above.
> > >>
> > >> If you send a SIGKILL to a vhost worker, the vhost worker still sort=
 of
> > >> ignores it (that is the hack that I mentioned at the beginning of th=
is
> > >> thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
> > >> then just continue to process works until file_operations->release
> > >> calls
> > >
> > > Yes, so this sticks to the behaviour before vhost_tasks.
> >
> > Not exactly. The vhost_task stays alive temporarily.
> >
> > The signal is still delivered to the userspace threads and they will
> > exit due to getting the SIGKILL also. SIGKILL goes to all the threads i=
n
> > the process and all userspace threads exit like normal because the vhos=
t
> > task and normal old userspace threads share a signal handler. When
> > userspace exits, the kernel force drops the refcounts on the vhost
> > devices and that runs the release function so the vhost_task will then =
exit.
> >
> > So what I'm trying to say is that in 6.4 we already changed the behavio=
r.
>
> Yes. To say the truth, it looks even worse but it might be too late to fi=
x.

Andres (cced) has identified two other possible changes:

1) doesn't run in the global PID namespace but run in the namespace of owne=
r
2) doesn't inherit kthreadd's scheduling attributes but the owner

Though such a change makes more sense for some use cases, it may break othe=
rs.

I wonder if we need to introduce a new flag and bring the old kthread
codes if the flag is not set? Then we would not end up trying to align
the behaviour?

Thanks

