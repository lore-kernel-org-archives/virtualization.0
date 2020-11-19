Return-Path: <SRS0=WAh4=EZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5AEC56201
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 16:25:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697A022240
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 16:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RC6kidTr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697A022240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CDAC38743D;
	Thu, 19 Nov 2020 16:25:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id le4BnWUD5iXX; Thu, 19 Nov 2020 16:25:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 23F4C8741F;
	Thu, 19 Nov 2020 16:25:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10C17C1825;
	Thu, 19 Nov 2020 16:25:03 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49E95C0891
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 16:25:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3E18686AEB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 16:25:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1r7Opaw7_OdK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 16:25:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 679AA86A8C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 16:25:01 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id v21so4657617pgi.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZyaLeGcHosrNL0yuPcvoeG1cDM6m3aA84s9qCKOOfBk=;
 b=RC6kidTr2YeYPX2xrQeUj9TXC9NUQwXuxWUCxmczwSdXNLZDiF+Hm192e5v6Nx7h1V
 2HQeBBMuG07H+NKDJp6Klk7eaZWYXWe/1HmGLnUbbuHTGhqPDmRqkr4TgwgSMxPLzEKm
 pZOHAaOnQP8uQaBdD2aUzg8vZ6vIsdsAubxi857Ubqnl972mpRTvlQFxc1pMvXGH5yVR
 MyqK5FO5f3CO8fIWtHM6pUuUoMACdORbsEY9dOPNYq+lnhPx9j5260uWTPd7e/2fcG1J
 GY+HU+PFHxnB+B8XBW2v+S+JRoVJg0a3bPKxtDDY6OkxNLQSASYUA+QkeDWPQZg48czy
 RNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZyaLeGcHosrNL0yuPcvoeG1cDM6m3aA84s9qCKOOfBk=;
 b=pgPSRctzW+fSdzfotHbzQ4PUrZOVxWilwZzSDGFoIbsBN8092pR/ATG2mifPmzfEQV
 UiaRuZoWIhxYuW6m8hNJjUKcfmkJ8/QhYFLl1k0Mm4gAe4xdc/WlSLWXoEXQnYQBrqjq
 Bs1TqTlzt0cGuSnlnBpL0V5lIavix09MDXFM0KCxJF80Ow30ipSLIV07N2RmEiePGU9c
 nRL/vM62zHYV7rUJSns9sjZL4LPnUzWYPz7KeHDujXvIfI5M2aT3M44ARqgPP3i8R0eX
 hRIa98/bewoDwyGH3aa8NiB3F39xfSHnp5pNLQC6Q5tYlmBHgQvdS0pkB+3UMkeWX2a8
 TwLg==
X-Gm-Message-State: AOAM530YMm1UAacotv0UCQ4Z2C9SYLNJCREOc8YgZmbhp5K9gVtcT+0I
 v5JGaNzBQrUKdJrRHgfhxAsCvWqJ8GeDyT+4WDY=
X-Google-Smtp-Source: ABdhPJyDYnKVIZrUrCssk5aQhnlSJp8mYzI8v3T4NKeqbt8PjfaNWHD6A4UIy617zEZO2F2zer3GCclErwArsUe2J8g=
X-Received: by 2002:a62:7ac2:0:b029:18b:c5bb:303d with SMTP id
 v185-20020a627ac20000b029018bc5bb303dmr9842717pfc.71.1605803100948; Thu, 19
 Nov 2020 08:25:00 -0800 (PST)
MIME-Version: 1.0
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain>
 <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
 <20201118113117.GF182763@stefanha-x1.localdomain>
 <20201119094315-mutt-send-email-mst@kernel.org>
 <ceebdc90-3ffc-1563-ff85-12a848bcba18@oracle.com>
In-Reply-To: <ceebdc90-3ffc-1563-ff85-12a848bcba18@oracle.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Nov 2020 16:24:49 +0000
Message-ID: <CAJSP0QUvSwX5NCPmfSODV_C+D41E21LZT=oXQ2PLc6baAsGGDQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] vhost/qemu: thread per IO SCSI vq
To: Mike Christie <michael.christie@oracle.com>
Cc: fam <fam@euphon.net>, linux-scsi <linux-scsi@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 target-devel <target-devel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Thu, Nov 19, 2020 at 4:13 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 11/19/20 8:46 AM, Michael S. Tsirkin wrote:
> > On Wed, Nov 18, 2020 at 11:31:17AM +0000, Stefan Hajnoczi wrote:
> >>> My preference has been:
> >>>
> >>> 1. If we were to ditch cgroups, then add a new interface that would allow
> >>> us to bind threads to a specific CPU, so that it lines up with the guest's
> >>> mq to CPU mapping.
> >>
> >> A 1:1 vCPU/vq->CPU mapping isn't desirable in all cases.
> >>
> >> The CPU affinity is a userspace policy decision. The host kernel should
> >> provide a mechanism but not the policy. That way userspace can decide
> >> which workers are shared by multiple vqs and on which physical CPUs they
> >> should run.
> >
> > So if we let userspace dictate the threading policy then I think binding
> > vqs to userspace threads and running there makes the most sense,
> > no need to create the threads.
> >
>
> Just to make sure I am on the same page, in one of the first postings of
> this set at the bottom of the mail:
>
> https://www.spinics.net/lists/linux-scsi/msg148322.html
>
> I asked about a new interface and had done something more like what
> Stefan posted:
>
>    struct vhost_vq_worker_info {
>        /*
>         * The pid of an existing vhost worker that this vq will be
>         * assigned to. When pid is 0 the virtqueue is assigned to the
>         * default vhost worker. When pid is -1 a new worker thread is
>         * created for this virtqueue. When pid is -2 the virtqueue's
>         * worker thread is unchanged.
>         *
>         * If a vhost worker no longer has any virtqueues assigned to it
>         * then it will terminate.
>         *
>         * The pid of the vhost worker is stored to this field when the
>         * ioctl completes successfully. Use pid -2 to query the current
>         * vhost worker pid.
>         */
>        __kernel_pid_t pid;  /* in/out */
>
>        /* The virtqueue index*/
>        unsigned int vq_idx; /* in */
>    };
>
> This approach is simple and it allowed me to have userspace map queues
> and threads optimally for our setups.
>
> Note: Stefan, in response to your previous comment, I am just using my
> 1:1 mapping as an example and would make it configurable from userspace.
>
> In the email above are you guys suggesting to execute the SCSI/vhost
> requests in userspace? We should not do that because:
>
> 1. It negates part of what makes vhost fast where we do not have to kick
> out to userspace then back to the kernel.
>
> 2. It's not doable or becomes a crazy mess because vhost-scsi is tied to
> the scsi/target layer in the kernel. You can't process the scsi command
> in userspace since the scsi state machine and all its configuration info
> is in the kernel's scsi/target layer.
>
> For example, I was just the maintainer of the target_core_user module
> that hooks into LIO/target on the backend (vhost-scsi hooks in on the
> front end) and passes commands to userspace and there we have a
> semi-shadow state machine. It gets nasty to try and maintain/sync state
> between lio/target core in the kernel and in userspace. We also see the
> perf loss I mentioned in #1.

No, if I understand Michael correctly he has suggested a different approach.

My suggestion was that the kernel continues to manage the worker
threads but an ioctl allows userspace to control the policy.

I think Michael is saying that the kernel shouldn't manage/create
threads. Userspace should create threads and then invoke an ioctl from
those threads.

The ioctl will call into the vhost driver where it will execute
something similar to vhost_worker(). So this ioctl will block while
the kernel is using the thread to process vqs.

What isn't clear to me is how to tell the kernel which vqs are
processed by a thread. We could try to pass that information into the
ioctl. I'm not sure what the cleanest solution is here.

Maybe something like:

struct vhost_run_worker_info {
    struct timespec *timeout;
    sigset_t *sigmask;

    /* List of virtqueues to process */
    unsigned nvqs;
    unsigned vqs[];
};

/* This blocks until the timeout is reached, a signal is received, or
the vhost device is destroyed */
int ret = ioctl(vhost_fd, VHOST_RUN_WORKER, &info);

As you can see, userspace isn't involved with dealing with the
requests. It just acts as a thread donor to the vhost driver.

We would want the VHOST_RUN_WORKER calls to be infrequent to avoid the
penalty of switching into the kernel, copying in the arguments, etc.

Michael: is this the kind of thing you were thinking of?

Stefan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
