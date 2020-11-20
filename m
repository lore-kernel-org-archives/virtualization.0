Return-Path: <SRS0=8XPq=E2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FC0C63777
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 08:46:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F3FC22253
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 08:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8Gqcylg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3FC22253
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B0568758D;
	Fri, 20 Nov 2020 08:46:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j-6pOpooDLAo; Fri, 20 Nov 2020 08:46:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 40DC7874FA;
	Fri, 20 Nov 2020 08:46:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2B913C163C;
	Fri, 20 Nov 2020 08:46:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05577C0891
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 08:46:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EC4D486D6A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 08:46:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3OZP2jb8EiI
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 08:46:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5F6C586303
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 08:46:01 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id b63so7182022pfg.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 00:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zzLhdipAOZ9XDbcgIs0h7PqDNReMT5wMo/AtToftNec=;
 b=n8GqcylgM95SMIeQwGPSut2nXHvOeygSf352H18yjXCxZiKOaeO/jlAMvcHrchT8HY
 TzIU680Wtcs9y2ru8pAdLN94RAd3ywkX70tqYGfhLBHUz1+I7D6EtysIVn8qcMCliVKn
 yB498fx/TXdvr1+NbYvJ2BGM70G00BR001H8UkYxu1SVfNl20G4TVKmRwwT2CuwXNCru
 qrqyU3kPcxGJEb81Am2Nelptu/6ktN7t1k5unnRwOiOrBLzdYVQX0zRQKsOpedUh6kK2
 nutqrMQsdWDUVtCJmTcjiXp+dOMIs+FUYifC93QWZAea7BsQw2+pSjhaTfWVXKslr+NO
 FSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zzLhdipAOZ9XDbcgIs0h7PqDNReMT5wMo/AtToftNec=;
 b=nrVWBuJcSg7lvUEGiuETIDKi0mgtsVvRLQqnd9jj5btknuvzW7GoaEDPqN5qq7wrH4
 1mulVUr8uBuW+iCfS7qVuFAsdhlLcQ+7JGyVBWlS8/m5SlH56f3eryCsRJ/EGdvMLcRd
 TjwWCHIZyGZEKZ4HQw7UaQeackqOLLU0MgFn16ZE9xxdk8lz6Prtme8yD75p/9wgYcAu
 XnqcC3B4CQHFZLv/GDFDe5OOgwLAVYp8F+CPla3uNzPYqcCXrxF/M5GXO/sXMYMTeuxd
 sTEP7pcriFs5VwNZRVqN1RBKzSkRoYewNq/e1z92nB/JMO5Eyje8uYC4sANmWowHOEtQ
 bblw==
X-Gm-Message-State: AOAM533F8aFJOlnkAHFAjD/n9gkL9iiIqZJSuVjiHCS6NnlfwwUWy2Ye
 2Et1m6EX233sq1dFzmOM2lkncA4yccbO0hjrW68=
X-Google-Smtp-Source: ABdhPJwBAXGphEVi30nMDVfjF2cmDlkL9jj8SyvK56Jd2R64dGyHl7cXJfapXWClM+dJeOj6Ndmy9jW0HRU/cO4mJeY=
X-Received: by 2002:a62:7ac2:0:b029:18b:c5bb:303d with SMTP id
 v185-20020a627ac20000b029018bc5bb303dmr13010657pfc.71.1605861960893; Fri, 20
 Nov 2020 00:46:00 -0800 (PST)
MIME-Version: 1.0
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain>
 <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
 <20201118113117.GF182763@stefanha-x1.localdomain>
 <20201119094315-mutt-send-email-mst@kernel.org>
 <ceebdc90-3ffc-1563-ff85-12a848bcba18@oracle.com>
 <CAJSP0QUvSwX5NCPmfSODV_C+D41E21LZT=oXQ2PLc6baAsGGDQ@mail.gmail.com>
 <ffd88f0c-981e-a102-4b08-f29d6b9a0f71@oracle.com>
 <CAJSP0QUfqd=QNFa-RikH4dVcLmfcP-pYCwznP3W0zobYkM+KDw@mail.gmail.com>
In-Reply-To: <CAJSP0QUfqd=QNFa-RikH4dVcLmfcP-pYCwznP3W0zobYkM+KDw@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 20 Nov 2020 08:45:49 +0000
Message-ID: <CAJSP0QVu4P6c+kdFkhw1S_OEaj7B-eiDqFOVDxWAaSOcsAADrA@mail.gmail.com>
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

On Thu, Nov 19, 2020 at 5:08 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 4:43 PM Mike Christie
> <michael.christie@oracle.com> wrote:
> >
> > On 11/19/20 10:24 AM, Stefan Hajnoczi wrote:
> > > On Thu, Nov 19, 2020 at 4:13 PM Mike Christie
> > > <michael.christie@oracle.com> wrote:
> > >>
> > >> On 11/19/20 8:46 AM, Michael S. Tsirkin wrote:
> > >>> On Wed, Nov 18, 2020 at 11:31:17AM +0000, Stefan Hajnoczi wrote:
> > > struct vhost_run_worker_info {
> > >      struct timespec *timeout;
> > >      sigset_t *sigmask;
> > >
> > >      /* List of virtqueues to process */
> > >      unsigned nvqs;
> > >      unsigned vqs[];
> > > };
> > >
> > > /* This blocks until the timeout is reached, a signal is received, or
> > > the vhost device is destroyed */
> > > int ret = ioctl(vhost_fd, VHOST_RUN_WORKER, &info);
> > >
> > > As you can see, userspace isn't involved with dealing with the
> > > requests. It just acts as a thread donor to the vhost driver.
> > >
> > > We would want the VHOST_RUN_WORKER calls to be infrequent to avoid the
> > > penalty of switching into the kernel, copying in the arguments, etc.
> >
> > I didn't get this part. Why have the timeout? When the timeout expires,
> > does userspace just call right back down to the kernel or does it do
> > some sort of processing/operation?
> >
> > You could have your worker function run from that ioctl wait for a
> > signal or a wake up call from the vhost_work/poll functions.
>
> An optional timeout argument is common in blocking interfaces like
> poll(2), recvmmsg(2), etc.
>
> Although something can send a signal to the thread instead,
> implementing that in an application is more awkward than passing a
> struct timespec.
>
> Compared to other blocking calls we don't expect
> ioctl(VHOST_RUN_WORKER) to return soon, so maybe the timeout will
> rarely be used and can be dropped from the interface.
>
> BTW the code I posted wasn't a carefully thought out proposal :). The
> details still need to be considered and I'm going to be offline for
> the next week so maybe someone else can think it through in the
> meantime.

One final thought before I'm offline for a week. If
ioctl(VHOST_RUN_WORKER) is specific to a single vhost device instance
then it's hard to support poll-mode (busy waiting) workers because
each device instance consumes a whole CPU. If we stick to an interface
where the kernel manages the worker threads then it's easier to share
workers between devices for polling.

I have CCed Stefano Garzarella, who is looking at similar designs for
vDPA software device implementations.

Stefan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
