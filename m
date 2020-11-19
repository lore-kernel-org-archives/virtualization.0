Return-Path: <SRS0=WAh4=EZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20808C63697
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 17:09:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F08D2468B
	for <virtualization@archiver.kernel.org>; Thu, 19 Nov 2020 17:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q09CUPq3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F08D2468B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C477E86D03;
	Thu, 19 Nov 2020 17:09:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rKpD5J+iYKW7; Thu, 19 Nov 2020 17:09:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3997486CF9;
	Thu, 19 Nov 2020 17:09:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5BECC163C;
	Thu, 19 Nov 2020 17:09:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E9DCC0891
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 17:09:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2033A8744D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 17:09:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sQ2sHwBdY4UF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 17:08:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 87B028744C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 17:08:59 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id t21so4784176pgl.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Nov 2020 09:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=s3jwRzYh5eBRDXKSUjnimUTZgZnImvs3tPqk9uLXKM8=;
 b=Q09CUPq3p7/L63rO5X2XHwdBmQzH9mQPiPutCAYOmwM2YyafFpTWV111jPTCymkG9Y
 ovduueR9oZ61aWho4Yz17uIz6uTEtuQXdUK4RvAHXzpkmm5rPE1t2Aw4+DSlciucvF5R
 jotssCUfpFMS6O+6wxZgAKOoZoHVV9f8HTl0+iSjpYCT1HGZhBFXrd3/8HtuVTjl7RYb
 bfRM/cst8SBFn9Zml/YxCxPxqLQqOnYCl2Dw3TuOxZf/jmFNY5DwqRr7toUCi6oLaFF4
 QE1LSxuIoEwA9v8eqE65TqJLI3JnEvsRzPIWESo/aSVW59lSNU/8gyo04pJUaw4YwwGt
 OFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=s3jwRzYh5eBRDXKSUjnimUTZgZnImvs3tPqk9uLXKM8=;
 b=NqBeLZMxrP71qXuUU0qqRUQuVp9E4RtLM+7dTg8daPa0xDzuug7H14J7gSk45Z+Y+O
 eXTI2l4AUkAVfjccCWfWv6uR7hIl98lc/kMC4vb2Vx1ffAwpB7O+cuKCwaHU3mThsV8I
 BnjMRx+2KAhfIXh2MXGYxmEt15Ku01eJR5qRPA2eJqk3SSrhjsXs8rcUBZ8qyNOdk0jZ
 LXEL2X9pqoVFudlyAUlgLEcNz4fL/EP0zfp6hoYNfJcnheaCl5UIF1SrSDdDGJsVnKBD
 T5zJfu79R5eM1bUau39S9Cz9Lh2UUORnGW5eZhx8e1fTCCaG0j1F2xkzwzyYYI8JO59f
 Uhuw==
X-Gm-Message-State: AOAM533i3MZ+182ZmdOwtNZQocVjkA4eOlKwuEKUNnxt8pEQog68nQMn
 R3IWJ3iXsznyHQqhQiaByrgNcMBFeLnBVSU20gc=
X-Google-Smtp-Source: ABdhPJyDEv/rHjyCS4JMHft6qsXpnMX+lNmHydsgOhE+h0eF4acHxdAjpVUYkUc61MNhiw0Te7O/Sse7gIf5gynlGgY=
X-Received: by 2002:a63:4e49:: with SMTP id o9mr13956352pgl.61.1605805739158; 
 Thu, 19 Nov 2020 09:08:59 -0800 (PST)
MIME-Version: 1.0
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain>
 <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
 <20201118113117.GF182763@stefanha-x1.localdomain>
 <20201119094315-mutt-send-email-mst@kernel.org>
 <ceebdc90-3ffc-1563-ff85-12a848bcba18@oracle.com>
 <CAJSP0QUvSwX5NCPmfSODV_C+D41E21LZT=oXQ2PLc6baAsGGDQ@mail.gmail.com>
 <ffd88f0c-981e-a102-4b08-f29d6b9a0f71@oracle.com>
In-Reply-To: <ffd88f0c-981e-a102-4b08-f29d6b9a0f71@oracle.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 19 Nov 2020 17:08:47 +0000
Message-ID: <CAJSP0QUfqd=QNFa-RikH4dVcLmfcP-pYCwznP3W0zobYkM+KDw@mail.gmail.com>
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

On Thu, Nov 19, 2020 at 4:43 PM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 11/19/20 10:24 AM, Stefan Hajnoczi wrote:
> > On Thu, Nov 19, 2020 at 4:13 PM Mike Christie
> > <michael.christie@oracle.com> wrote:
> >>
> >> On 11/19/20 8:46 AM, Michael S. Tsirkin wrote:
> >>> On Wed, Nov 18, 2020 at 11:31:17AM +0000, Stefan Hajnoczi wrote:
> > struct vhost_run_worker_info {
> >      struct timespec *timeout;
> >      sigset_t *sigmask;
> >
> >      /* List of virtqueues to process */
> >      unsigned nvqs;
> >      unsigned vqs[];
> > };
> >
> > /* This blocks until the timeout is reached, a signal is received, or
> > the vhost device is destroyed */
> > int ret = ioctl(vhost_fd, VHOST_RUN_WORKER, &info);
> >
> > As you can see, userspace isn't involved with dealing with the
> > requests. It just acts as a thread donor to the vhost driver.
> >
> > We would want the VHOST_RUN_WORKER calls to be infrequent to avoid the
> > penalty of switching into the kernel, copying in the arguments, etc.
>
> I didn't get this part. Why have the timeout? When the timeout expires,
> does userspace just call right back down to the kernel or does it do
> some sort of processing/operation?
>
> You could have your worker function run from that ioctl wait for a
> signal or a wake up call from the vhost_work/poll functions.

An optional timeout argument is common in blocking interfaces like
poll(2), recvmmsg(2), etc.

Although something can send a signal to the thread instead,
implementing that in an application is more awkward than passing a
struct timespec.

Compared to other blocking calls we don't expect
ioctl(VHOST_RUN_WORKER) to return soon, so maybe the timeout will
rarely be used and can be dropped from the interface.

BTW the code I posted wasn't a carefully thought out proposal :). The
details still need to be considered and I'm going to be offline for
the next week so maybe someone else can think it through in the
meantime.

Stefan
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
