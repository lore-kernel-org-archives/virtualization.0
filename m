Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C701384
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Apr 2024 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713486862; cv=none; b=gqKmQuxxKMmhwUpl/qLN2L04aK6sJ5/C8+xACOH4BCxp/h8MCeXZdk+AiImH5sBRSL0e3vuF7s5y+0g39D64aeSxnq+3J5Jj7ZKVR2kCzeQkplZ9+0vZEm5M6M3L/yOf4N7OcXyczJTd2vm9q4BCqrRklTwsSubt6aLzC9goOgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713486862; c=relaxed/simple;
	bh=UFxUK64tBqd5siOt60UEs3n5Tcj3NoKbRpvCN+BaYj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dvc816opNXsuqglp3g06w4xYspm8xhuEyPwC0Tsueebz+/AgOSx5ucG5cY0mFpeRmw3aE6HfYotuiY416JiJsIgz+RhkH10JihmXT3t7fdnFS47ahdeix66Rj3CyhjQOty9SjO9O6scrNGVAcFxaTZdoBj7BS/tfV1xfQJJ4Kmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C9jf/t+E; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C9jf/t+E"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0613640541
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Apr 2024 00:34:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KUuHHeeCzh_B for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Apr 2024 00:34:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org BEDE040540
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEDE040540
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=C9jf/t+E
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BEDE040540
	for <virtualization@lists.linux-foundation.org>; Fri, 19 Apr 2024 00:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713486856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFxUK64tBqd5siOt60UEs3n5Tcj3NoKbRpvCN+BaYj4=;
	b=C9jf/t+EkbUlVtiNhMeW/3jwpk8SK8gN+evxom7uuPo+scRP8IDyqIy9HC9H9LTeEfKAVU
	51YFC4D2egc/RS31CTR4phdUIs9TWXEQdyeylSUXMT98JyQdW9GjG3ScanXwflwzPL9Q4A
	3t7M/kPwhZiyu8t2zSqfKfBW61/YHIw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-CXMzpYyuO4i7cnflzKvaFw-1; Thu, 18 Apr 2024 20:34:12 -0400
X-MC-Unique: CXMzpYyuO4i7cnflzKvaFw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ece02cfbf2so1795437b3a.2
        for <virtualization@lists.linux-foundation.org>; Thu, 18 Apr 2024 17:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713486851; x=1714091651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFxUK64tBqd5siOt60UEs3n5Tcj3NoKbRpvCN+BaYj4=;
        b=ctR3tCyRsrIwxAObYMM+oeddq3PRt+u4f96UPVpHHKETECYsNMgxZex9rsO745R+MC
         na3DFokhTAGtdxDfkXcIYDoTiwp7P+qYbkNCpBzzgejnNO75DoV61BGLFkII884wta+F
         zm+QmnQKQhZAyAwM0EsswJslhbkIvgdRPtRBq8Nt3nE3XYsT863pf5ZKViCWt4Cr3Mvf
         8ZWGwMi14bZdD8Fjeuf6dYEA9Sz6uzuCMCjQjKVCWbf+2Hc7JUfzRXvYB3gyO3mntHC+
         thWGIfYoYi2LaF0zgfT72559IK/Q2SXMLmnlyNK3Zt8gWK5+jmMLGUdOT3VDEQAodzja
         tFsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEXjua+OxMozqBwVMvgXaJr7K6PsDDEP/vRNphM0CNWWbQFM7kVrzbiVI9gz4Bb/tp4vt3UfWNPBCo4n0WbRAaneCY/q+H7a6iSv7mJs2W/1vx7hqdmtkVuQ==
X-Gm-Message-State: AOJu0YwjKDzk3CRM5urcvy8XONNNjnVMTx1D/4YKDScYuVcADPKGgwgB
	tgGdQeMx6ou119fx9LwbtgIqMB5PN9CkTsT49Bvl5gly/k3DNNMKYoILNITrAB82lbi+kZCAXJN
	FKXf+WXUmVa6+qUEFRGm4kjXXGJqtzAp6UTwAXyQreHsOIxZpU3w0JTMlZf7oMOeCj+qSafF1sc
	uTSPIOa3ioXzQYLapn3IZZFQ9ippOoK42lZhYJTKz5f22clk+9+9vwXQ==
X-Received: by 2002:a05:6a20:d492:b0:1a7:c67:82ff with SMTP id im18-20020a056a20d49200b001a70c6782ffmr1102099pzb.13.1713486851527;
        Thu, 18 Apr 2024 17:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtiR9B2D1bmnqBAbJjf/swNXSeZpJMaisn+kA7kwEQz3FVsDCfagr1+SV1cv6Qh73gaJxBf9bqzM+H3I/CAGc=
X-Received: by 2002:a05:6a20:d492:b0:1a7:c67:82ff with SMTP id
 im18-20020a056a20d49200b001a70c6782ffmr1102084pzb.13.1713486851159; Thu, 18
 Apr 2024 17:34:11 -0700 (PDT)
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
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Apr 2024 08:33:59 +0800
Message-ID: <CACGkMEtQes1-OhboEPKTBVKurkTqraZOKxvucMByc+HS_bFzjQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, oleg@redhat.com, ebiederm@xmission.com, 
	virtualization@lists.linux-foundation.org, sgarzare@redhat.com, 
	stefanha@redhat.com, brauner@kernel.org, Andreas Karis <akaris@redhat.com>, 
	Laurent Vivier <lvivier@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 3:07=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
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

Well, not sure if it's a bug as kthread inherits the namespace of it's
parent which is kthreadd. It follows the semantics of copy_process and
there are plenty of users now. The problem is that it's too late to
judge if it is a bug as it has been noticed by the userspace. And
namespace is not the only thing that could be noticed by the
userspace. Any assumption for the kthreadd attributes will break.

Instead of waiting for complaints for the new behaviour, why not
simply stick to the old behaviour and use the flag for the new one?

Thanks

