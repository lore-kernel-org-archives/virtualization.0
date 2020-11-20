Return-Path: <SRS0=8XPq=E2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C01C5519F
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 12:31:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13B82087D
	for <virtualization@archiver.kernel.org>; Fri, 20 Nov 2020 12:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KCH4HwCv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13B82087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 42FB987174;
	Fri, 20 Nov 2020 12:31:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K9Z2W3xkJCSL; Fri, 20 Nov 2020 12:31:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4A5138716B;
	Fri, 20 Nov 2020 12:31:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 39FCDC163C;
	Fri, 20 Nov 2020 12:31:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B8A7C0891
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 12:31:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3CA1A87174
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 12:31:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OsjVHEsWwlPJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 12:31:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7D0688716B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605875479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ocK86ENwpJGmMxdlo0mfB3bMPeCsw3DadrlnqYb0ooI=;
 b=KCH4HwCvoU1hGohPLjLRNr0SLXwWB7fBXpWS2lMmNxMlENuRw0rRBeoJpsVvyUB1Auw5Sv
 uxuRaSYRM2LNOLOAUVP74+N7t0RSLApzFpA0hBGBfxs84Bh50zZRHmDGLSfF3SynRHYrZt
 8wbHw4Aid6DBMGDfjHPcnGLNA04Eqhc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-rN_p79_bNAuc6eTdpKTHiw-1; Fri, 20 Nov 2020 07:31:15 -0500
X-MC-Unique: rN_p79_bNAuc6eTdpKTHiw-1
Received: by mail-wm1-f69.google.com with SMTP id z62so5223542wmb.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Nov 2020 04:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ocK86ENwpJGmMxdlo0mfB3bMPeCsw3DadrlnqYb0ooI=;
 b=fuZ89lIbapVUEmg4LFgxsWY8Bw7sk3BOSg7SS+m23tZooPtGrNOhgPCTCsXud4Nogg
 CwLrlZ3yZ4B3ZBiVZUS7oVKmWiMsyCyZdBDLqJd+dHBFhbac22sow5CSx550P5Sfjeat
 8v0YS7aLZ+kHKqQrCpA4ugPPIlyLvmRa8jXLyVeG60GZmUABDexreMFtpPGWfXO5zHXL
 +PIDqX9gYg6lNuD7T2PagLossL271Qu/W8h3dxO3L9ThOxJ5vWF7/SNKhAhGPkXAZIZY
 MAZz6HAcnxq5OLPyU1cR7j/pBsxyo2axzWJO3k5RgJv/eT87n5e72Z6oJ0L8TNKOEpBP
 Kthg==
X-Gm-Message-State: AOAM5317SQCUsmMEiWx9Q+9teuJj8y7R+dDyoFgcunikfG9Pg1jotngb
 v4vM+QRiPeMB9qJHtwdda4TSuT+TR/Fl37V7AbcYrATsMIlQDk9LLLFaVd4R9ZNOG6jWYAezyNS
 W/GtGISCI1JfxmM3nkxVLoWn6JtoFQf9J0jtR6vfwTw==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr15575446wru.397.1605875474261; 
 Fri, 20 Nov 2020 04:31:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5yeyXryHim+8cbbaVgxlvvJwdtVTGEJ7CX1LFkcQa+sotAPHYcwKeUvV6gKolUT2mX0mACQ==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr15575426wru.397.1605875474024; 
 Fri, 20 Nov 2020 04:31:14 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id v6sm5115620wrb.53.2020.11.20.04.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2020 04:31:12 -0800 (PST)
Date: Fri, 20 Nov 2020 07:31:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 00/10] vhost/qemu: thread per IO SCSI vq
Message-ID: <20201120072802-mutt-send-email-mst@kernel.org>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <20201117164043.GS131917@stefanha-x1.localdomain>
 <b3343762-bb11-b750-46ec-43b5556f2b8e@oracle.com>
 <20201118113117.GF182763@stefanha-x1.localdomain>
 <20201119094315-mutt-send-email-mst@kernel.org>
 <ceebdc90-3ffc-1563-ff85-12a848bcba18@oracle.com>
 <CAJSP0QUvSwX5NCPmfSODV_C+D41E21LZT=oXQ2PLc6baAsGGDQ@mail.gmail.com>
 <ffd88f0c-981e-a102-4b08-f29d6b9a0f71@oracle.com>
 <CAJSP0QUfqd=QNFa-RikH4dVcLmfcP-pYCwznP3W0zobYkM+KDw@mail.gmail.com>
 <CAJSP0QVu4P6c+kdFkhw1S_OEaj7B-eiDqFOVDxWAaSOcsAADrA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVu4P6c+kdFkhw1S_OEaj7B-eiDqFOVDxWAaSOcsAADrA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: fam <fam@euphon.net>, linux-scsi <linux-scsi@vger.kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 target-devel <target-devel@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mike Christie <michael.christie@oracle.com>
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

On Fri, Nov 20, 2020 at 08:45:49AM +0000, Stefan Hajnoczi wrote:
> On Thu, Nov 19, 2020 at 5:08 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> >
> > On Thu, Nov 19, 2020 at 4:43 PM Mike Christie
> > <michael.christie@oracle.com> wrote:
> > >
> > > On 11/19/20 10:24 AM, Stefan Hajnoczi wrote:
> > > > On Thu, Nov 19, 2020 at 4:13 PM Mike Christie
> > > > <michael.christie@oracle.com> wrote:
> > > >>
> > > >> On 11/19/20 8:46 AM, Michael S. Tsirkin wrote:
> > > >>> On Wed, Nov 18, 2020 at 11:31:17AM +0000, Stefan Hajnoczi wrote:
> > > > struct vhost_run_worker_info {
> > > >      struct timespec *timeout;
> > > >      sigset_t *sigmask;
> > > >
> > > >      /* List of virtqueues to process */
> > > >      unsigned nvqs;
> > > >      unsigned vqs[];
> > > > };
> > > >
> > > > /* This blocks until the timeout is reached, a signal is received, or
> > > > the vhost device is destroyed */
> > > > int ret = ioctl(vhost_fd, VHOST_RUN_WORKER, &info);
> > > >
> > > > As you can see, userspace isn't involved with dealing with the
> > > > requests. It just acts as a thread donor to the vhost driver.
> > > >
> > > > We would want the VHOST_RUN_WORKER calls to be infrequent to avoid the
> > > > penalty of switching into the kernel, copying in the arguments, etc.
> > >
> > > I didn't get this part. Why have the timeout? When the timeout expires,
> > > does userspace just call right back down to the kernel or does it do
> > > some sort of processing/operation?
> > >
> > > You could have your worker function run from that ioctl wait for a
> > > signal or a wake up call from the vhost_work/poll functions.
> >
> > An optional timeout argument is common in blocking interfaces like
> > poll(2), recvmmsg(2), etc.
> >
> > Although something can send a signal to the thread instead,
> > implementing that in an application is more awkward than passing a
> > struct timespec.
> >
> > Compared to other blocking calls we don't expect
> > ioctl(VHOST_RUN_WORKER) to return soon, so maybe the timeout will
> > rarely be used and can be dropped from the interface.
> >
> > BTW the code I posted wasn't a carefully thought out proposal :). The
> > details still need to be considered and I'm going to be offline for
> > the next week so maybe someone else can think it through in the
> > meantime.
> 
> One final thought before I'm offline for a week. If
> ioctl(VHOST_RUN_WORKER) is specific to a single vhost device instance
> then it's hard to support poll-mode (busy waiting) workers because
> each device instance consumes a whole CPU. If we stick to an interface
> where the kernel manages the worker threads then it's easier to share
> workers between devices for polling.


Yes that is the reason vhost did its own reason in the first place.


I am vaguely thinking about poll(2) or a similar interface,
which can wait for an event on multiple FDs.


> I have CCed Stefano Garzarella, who is looking at similar designs for
> vDPA software device implementations.
> 
> Stefan

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
