Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C954C43457
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:01:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EB7222EB
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzK3Y4Pr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EB7222EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0015D86ECB;
	Mon, 19 Oct 2020 15:00:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1IdHUJaPTMda; Mon, 19 Oct 2020 15:00:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4752C86EA1;
	Mon, 19 Oct 2020 15:00:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 26437C088B;
	Mon, 19 Oct 2020 15:00:58 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20E7CC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:00:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 170BA874B6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:00:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5XqW5WYGoeo5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:00:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C2D1587308
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603119654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eeEwkWd2inwelOxnZFWrV6qJ4loEm7oC47tsgU5zrNE=;
 b=KzK3Y4PrPBqzVLK5EXFDXijQAaMHftHhFoZ7WePp24M9Rxe1w4kRDnyEKxNUegT0Lp7rcq
 Jp56FcRiRyeTkmLW6zqdLlpwNm0BOi8aG2bPjPHI+87rKedwHw5KgHPjUfiywbG6vAz0v3
 wajCgFHxNV774WTwCJdJd3FvAfDX/io=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-iDaeRig2Pruqy2dO2aWgAA-1; Mon, 19 Oct 2020 11:00:53 -0400
X-MC-Unique: iDaeRig2Pruqy2dO2aWgAA-1
Received: by mail-wr1-f71.google.com with SMTP id t17so7544842wrm.13
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 08:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=eeEwkWd2inwelOxnZFWrV6qJ4loEm7oC47tsgU5zrNE=;
 b=CFNuXMEs958ZZtW4QpKD6MlNQJiPZRD/jeB3sIAsxS/8FgqN0B09ycFmuha51uw1st
 z2gv4mQnocvZwDKpL/BTMyvED4PgT5Ry6J1ZB0WVK6KFjDFeRu+FbK1vR16U0B6Ffifv
 rItA3fHd76Pg76paXIYTJ4NSpmuEqzhNeX3/BSS4PjG4kH6ZJMiXtpVmFxcyyh3avBhO
 V/31O5T9OVJd72iE0mES45hOvQ58wyatUZ9ltoNoEWBSrFRiUErsCm9fA4fdLWMcmpas
 NOKtssfgTDgVWesNrsw3/rJH1fj9VpPjcufGgNvqL236Y5bnS+j5VkiTziNyYMAGKnWx
 1rQg==
X-Gm-Message-State: AOAM533ItJtOvinShTw9usTMK/Kj6gYV0Iyxz81ERzaDmo5HNixGTCEK
 8yWFfQqSYaFsR7zQvuug40Jw/dVNRUN8sSF8+U//VRchvyH9XM2+7BCVWLjbfsha2rEKjQ4g2NF
 0AeifsrPCNAqLNbVlfXToez4cIDCJ/xDXUggCKorWMA==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr17940603wmh.158.1603119650821; 
 Mon, 19 Oct 2020 08:00:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1K7foO6zAsERSnzDbqpvWg8Yzks+2b30SB3/GCrweUhcJIelqhNOTssKhNwAEMU36/iuvgw==
X-Received: by 2002:a7b:c081:: with SMTP id r1mr17940572wmh.158.1603119650551; 
 Mon, 19 Oct 2020 08:00:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id e15sm8898wro.13.2020.10.19.08.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 08:00:49 -0700 (PDT)
Date: Mon, 19 Oct 2020 11:00:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201019105118-mutt-send-email-mst@kernel.org>
References: <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <20201018114625-mutt-send-email-mst@kernel.org>
 <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
 <20201018115524-mutt-send-email-mst@kernel.org>
 <CALCETrUeRAhmEFR6EFXz8HzDYd2doZ2TMyZmu1pU_-yAPA6KDw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALCETrUeRAhmEFR6EFXz8HzDYd2doZ2TMyZmu1pU_-yAPA6KDw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Colm MacCarthaigh <colmmacc@amazon.com>,
 Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Eric Biggers <ebiggers@kernel.org>, "Singh, Balbir" <sblbir@amazon.com>,
 bonzini@gnu.org, "Graf \(AWS\), Alexander" <graf@amazon.de>,
 Jann Horn <jannh@google.com>, oridgar@gmail.com, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Michal Hocko <mhocko@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, Willy Tarreau <w@1wt.eu>, "Woodhouse,
 David" <dwmw@amazon.co.uk>
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

On Sun, Oct 18, 2020 at 09:14:00AM -0700, Andy Lutomirski wrote:
> On Sun, Oct 18, 2020 at 8:59 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Oct 18, 2020 at 08:54:36AM -0700, Andy Lutomirski wrote:
> > > On Sun, Oct 18, 2020 at 8:52 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Sat, Oct 17, 2020 at 03:24:08PM +0200, Jason A. Donenfeld wrote:
> > > > > 4c. The guest kernel maintains an array of physical addresses that are
> > > > > MADV_WIPEONFORK. The hypervisor knows about this array and its
> > > > > location through whatever protocol, and before resuming a
> > > > > moved/snapshotted/duplicated VM, it takes the responsibility for
> > > > > memzeroing this memory. The huge pro here would be that this
> > > > > eliminates all races, and reduces complexity quite a bit, because the
> > > > > hypervisor can perfectly synchronize its bringup (and SMP bringup)
> > > > > with this, and it can even optimize things like on-disk memory
> > > > > snapshots to simply not write out those pages to disk.
> > > > >
> > > > > A 4c-like approach seems like it'd be a lot of bang for the buck -- we
> > > > > reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
> > > > > userspace API to deal with, and it'd be race free, and eliminate a lot
> > > > > of kernel complexity.
> > > >
> > > > Clearly this has a chance to break applications, right?
> > > > If there's an app that uses this as a non-system-calls way
> > > > to find out whether there was a fork, it will break
> > > > when wipe triggers without a fork ...
> > > > For example, imagine:
> > > >
> > > > MADV_WIPEONFORK
> > > > copy secret data to MADV_DONTFORK
> > > > fork
> > > >
> > > >
> > > > used to work, with this change it gets 0s instead of the secret data.
> > > >
> > > >
> > > > I am also not sure it's wise to expose each guest process
> > > > to the hypervisor like this. E.g. each process needs a
> > > > guest physical address of its own then. This is a finite resource.
> > > >
> > > >
> > > > The mmap interface proposed here is somewhat baroque, but it is
> > > > certainly simple to implement ...
> > >
> > > Wipe of fork/vmgenid/whatever could end up being much more problematic
> > > than it naively appears -- it could be wiped in the middle of a read.
> > > Either the API needs to handle this cleanly, or we need something more
> > > aggressive like signal-on-fork.
> > >
> > > --Andy
> >
> >
> > Right, it's not on fork, it's actually when process is snapshotted.
> >
> > If we assume it's CRIU we care about, then I
> > wonder what's wrong with something like
> > MADV_CHANGEONPTRACE_SEIZE
> > and basically say it's X bytes which change the value...
> 
> I feel like we may be approaching this from the wrong end.  Rather
> than saying "what data structure can the kernel expose that might
> plausibly be useful", how about we try identifying some specific
> userspace needs and see what a good solution could look like.  I can
> identify two major cryptographic use cases:

Well, I'm aware of a non-cryptographic use-case:
https://bugzilla.redhat.com/show_bug.cgi?id=1118834

this seems to just ask for the guest to have a way to detect that
a VM cloning triggered.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
