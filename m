Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAE4C96
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 03:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892511; cv=none; b=HdBguoneW4JPCjkWo3bGWzoDaYN/Sc9Ol2aBH52qo+PTZ42I6cp89GiOCk4M/ikMtSkZ+kNfvqZXb3bAr6G+ET1EnVHYNrBkuzNUufLJeHz7/h7n5J59cH7Knq3NQDFO7MW29TrF7skKf9bbz2f0A9qX6Yo+5HVwbOjX72LKUXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892511; c=relaxed/simple;
	bh=2jqUwazLvuTpRvk7dqaRYQnL68ZS+0STHUq2m4/QyVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVRR6Pz5nMhB6csGrQVo2VggOwZsi/fV4k7SanxsFkJd/TibexJ9HOHGdPbyLBUrYJJSxl047T2K+E2sVsVpPECBzVyC25GoBxkVNyyBxuFlrIcZLbq/w/nWneOnTXOB124Hmzb+5fNFwUjBjpeoVi411HWMpI01CHnayit5Md0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNna2bYY; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNna2bYY"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5A58340202
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 03:28:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ND7DmV4Hy2Lp for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Apr 2024 03:28:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=jasowang@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C062440181
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C062440181
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gNna2bYY
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C062440181
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 03:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712892507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jqUwazLvuTpRvk7dqaRYQnL68ZS+0STHUq2m4/QyVU=;
	b=gNna2bYYFbWA+rrmCErMAFeystJASfulwEqm1GgIiMfcDex5auddyrpwjFuHuQRa9lOYmp
	EVgpQHvEUQUW1LvA1k7J4Pkl/vvGWL3JcTyf0HLGTKjJ/kqkkVPh7S46i+fd63dbPi229m
	sazONykRz750aYZ+TfvMxrb3qLry8DI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-e7WkfqEdNVuYgYZltrMqaA-1; Thu, 11 Apr 2024 23:28:25 -0400
X-MC-Unique: e7WkfqEdNVuYgYZltrMqaA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a4ff147030so439136a91.3
        for <virtualization@lists.linux-foundation.org>; Thu, 11 Apr 2024 20:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712892505; x=1713497305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jqUwazLvuTpRvk7dqaRYQnL68ZS+0STHUq2m4/QyVU=;
        b=uPwI2Rr31mE7F/u3HAM41sppTbjjVvzKHvuEERIid4y4ny7sZG91B+bpvkmENoztS9
         05R71Ig5t1vCup8wBLCteHBe92KfpwaD/48HcrgKW99iOUMHSA5iM+P3LSPXm7ELI0X6
         vFhaIo6qzWTSO+Apiqz9KdgsRbi+5J/xh/PqMl1tvocAtsQjA6kPAuMZ0b6wX92bleTu
         uNWzqKcW+PVlz0OuLde7cVSqMyJej7uPmATl1K3+nQuzqtxvRtYEVSgR/GCHQmOqvsGB
         vv6Qsog9tl7vH9qLj8YotbKRcFE9Vmb6Kkk0VXrhJ5rxxz9QMdYAiq0DfCvuuOgiinTA
         YsTA==
X-Forwarded-Encrypted: i=1; AJvYcCUQn5Y4Q8gvD+ufQQ+OjhcKv+i9DCZTrKrTuIDVcAfpTHQ5DRzK32tJz9sqv5jOQhqZ/VUiK9OF97df7Hc+3gutVcNPO5T8dKegQ6gPuYxltAWbV+PwpxOH4w==
X-Gm-Message-State: AOJu0YywbidMmS3cQfoCERK3L8zpw+Pm1BS6n5n/zcUFhSKDw4yT0KPM
	1+7nrLXhVLo0Us4dWUDeoJuj236udiFhOk+sKK0/ujviaHgCLyNkQwnUmMaYUKLhvmurd1q0nsR
	CWWMg1c7Fx8cERIandhemkhKEfGMNS8AmXHGyMcmePgUahGtRUENXb/bVSpV7bqjh5uWN2JSiOa
	HnHjoZslHP2Ciw4tssbla1jBowLMUC1UEG8PC+BtFThJoumg1OWfgGRQ==
X-Received: by 2002:a17:90a:e50e:b0:2a5:6e51:eebd with SMTP id t14-20020a17090ae50e00b002a56e51eebdmr1565557pjy.23.1712892504843;
        Thu, 11 Apr 2024 20:28:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKH9dU2mdBusPIa963IRxJ+cg+b/g1i8nFtUAGT0lvXLofEVZZ1O+gsTQzDGy247m2rXlECgPbrikgUoEkTu8=
X-Received: by 2002:a17:90a:e50e:b0:2a5:6e51:eebd with SMTP id
 t14-20020a17090ae50e00b002a56e51eebdmr1565551pjy.23.1712892504563; Thu, 11
 Apr 2024 20:28:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240316004707.45557-1-michael.christie@oracle.com>
 <CACGkMEs1KSdUOgLbwbR-S0v1jv8-N5cM5ZwrWyK8raF50MSRZg@mail.gmail.com> <9f75952f-c1a4-4483-8ec7-beddf022a821@oracle.com>
In-Reply-To: <9f75952f-c1a4-4483-8ec7-beddf022a821@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Apr 2024 11:28:13 +0800
Message-ID: <CACGkMEuY9cyCb+myzscHDetbfmDLZN-_JAFvZaAfrO0-Mc0FTA@mail.gmail.com>
Subject: Re: [PATCH 0/9] vhost: Support SIGKILL by flushing and exiting
To: Mike Christie <michael.christie@oracle.com>
Cc: oleg@redhat.com, ebiederm@xmission.com, 
	virtualization@lists.linux-foundation.org, mst@redhat.com, 
	sgarzare@redhat.com, stefanha@redhat.com, brauner@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 12:19=E2=80=AFAM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 4/11/24 3:39 AM, Jason Wang wrote:
> > On Sat, Mar 16, 2024 at 8:47=E2=80=AFAM Mike Christie
> > <michael.christie@oracle.com> wrote:
> >>
> >> The following patches were made over Linus's tree and also apply over
> >> mst's vhost branch. The patches add the ability for vhost_tasks to
> >> handle SIGKILL by flushing queued works, stop new works from being
> >> queued, and prepare the task for an early exit.
> >>
> >> This removes the need for the signal/coredump hacks added in:
> >>
> >> Commit f9010dbdce91 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps =
regression")
> >>
> >> when the vhost_task patches were initially merged and fix the issue
> >> in this thread:
> >>
> >> https://lore.kernel.org/all/000000000000a41b82060e875721@google.com/
> >>
> >> Long Background:
> >>
> >> The original vhost worker code didn't support any signals. If the
> >> userspace application that owned the worker got a SIGKILL, the app/
> >> process would exit dropping all references to the device and then the
> >> file operation's release function would be called. From there we would
> >> wait on running IO then cleanup the device's memory.
> >
> > A dumb question.
> >
> > Is this a user space noticeable change? For example, with this series
> > a SIGKILL may shutdown the datapath ...
>
> It already changed in 6.4. We basically added a new interface to shutdown
> everything (userspace and vhost kernel parts). So we won't just shutdown
> the data path while userspace is still running. We will shutdown everythi=
ng
> now if you send a SIGKILL to a vhost worker's thread.

If I understand correctly, for example Qemu can still live is SIGKILL
is just send to vhost thread.

If this is correct, guests may detect this (for example virtio-net has
a watchdog).

>
> Here are a lots of details:
>
> - Pre-6.4 kernel, when vhost workers used kthreads, if you sent any signa=
l
> to a vhost worker, we ignore it. Nothing happens. kthreads are special an=
d
> can ignore all signals.
>
> You could think of it as the worker is a completely different process tha=
n
> qemu/userspace so they have completely different signal handlers. The
> vhost worker signal handler ignores all signals even SIGKILL.

Yes.

>
> If you send a SIGKILL to a qemu thread, then it just exits right away. We
> don't get to do an explicit close() on the vhost device and we don't get
> to do ioctls like VHOST_NET_SET_BACKEND to clear backends. The kernel exi=
t
> code runs and releases refcounts on the device/file, then the vhost devic=
e's
> file_operations->release function is called. vhost_dev_cleanup then stops
> the vhost worker.

Right.

>
> - In 6.4 and newer kernels, vhost workers use vhost_tasks, so the worker
> can be thought of as a thread within the userspace process. With that
> change we have the same signal handler as the userspace process.
>
> If you send a SIGKILL to a qemu thread then it works like above.
>
> If you send a SIGKILL to a vhost worker, the vhost worker still sort of
> ignores it (that is the hack that I mentioned at the beginning of this
> thread). kernel/vhost_task.c:vhost_task_fn will see the signal and
> then just continue to process works until file_operations->release
> calls

Yes, so this sticks to the behaviour before vhost_tasks.

>
> However, the change in behavior is that because the worker is just a
> thread within qemu, qemu is going to exit since they share a signal
> handler and userspace can't ignore SIGKILL.
> We then run perform the
> steps above like in the pre-6.4 kernel description as if you sent a
> SIGKILL directly to a userspace thread.
>
> - With the patches in this thread there is no major difference in behavio=
r
> with 6.4 and newer kernels. We might exit a little faster. Instead of the
> vhost thread trying to do it's hacked up version of ignoring the signal
> and waiting for userspace to exit and call file_operations->release, the
> vhost worker thread will exit after it flushes works and stops new ones.
> So now, you can have the vhost thread exiting in parallel with the
> userspace thread.

Everything would be fine if Qemu wanted to quit but I meant there
could be a case where SIGKILL was sent to the vhost thread but not
Qemu.

Thanks

>

