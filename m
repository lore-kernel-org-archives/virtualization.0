Return-Path: <SRS0=CB8P=DZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05663C4363A
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 15:59:54 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8516621D7F
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 15:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pyf4yAXz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8516621D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 243748752C;
	Sun, 18 Oct 2020 15:59:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ndLtVlNXkuuu; Sun, 18 Oct 2020 15:59:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9E08487488;
	Sun, 18 Oct 2020 15:59:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8377AC0052;
	Sun, 18 Oct 2020 15:59:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F3E5C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:59:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EF3E320441
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:59:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gnDM0eoq1B52
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:59:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id E03882033F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603036787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G1NfFqRvQCLurPJ/4oycBIXRpf/JK9ZrKM1/uUoh0IA=;
 b=Pyf4yAXzQVn2Aj82XmoXSyLYN97mk9UayHMBtuxkEhO2tsJrAtLI8o/4ftXbS1JseST0dR
 MUozCkLLJkcBN2mmXQUtGjfeBWpeek3vqoyUp3WZnuUg1d5frZLAVidmNiV+JJKe9Yvu9f
 dSZolVLhGG7ZO7zxXGEhltq8Rr3yQbw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-r9GA-IQrPGCcMNIVeExKhA-1; Sun, 18 Oct 2020 11:59:45 -0400
X-MC-Unique: r9GA-IQrPGCcMNIVeExKhA-1
Received: by mail-wr1-f72.google.com with SMTP id t3so6298911wrq.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 08:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G1NfFqRvQCLurPJ/4oycBIXRpf/JK9ZrKM1/uUoh0IA=;
 b=b7HnCSzGeaR5O9VIuqt9080/SrXBCGjPEzOeK2qSo6JVKUlG4ICs4HSllkmMvpwIff
 oJME711q5qkIoeYNOL2O8fYyhCWC/SvkLfuB6SqZ2TJXUe0jeggSaHjbvOkwUbCcYK7K
 SyT5crxvS/4nTTBUP61DIq1gTgql5w+h0xaL69WFDK618FK4p3Bzitsq/U+3nsDSLD93
 /vHUF5SY0m1SGI0qdXqrW4R4u3nWugqJjJDvItX0MvALlIFp/gUzj6dJN8z+qdgMdeOU
 1iw8ObRX+DkMvNQK7I+YY5anIfGJA/rXmQvpyE+8X0Sxi5cB0W9tep6v8rJP5d+772ET
 T4iA==
X-Gm-Message-State: AOAM530rRutrY7o+5PnWTuUf+Q002QF+LhBeazBEC2xGc50GLuwA8WkM
 0iNfl6DtmurEkJ2Pzrxo5vPU7fdslmEdlHwcnRcAjwSjtTfCu9yn1uzUuC5jG1CT9NyPiZKnT+A
 pLijdz5DgM0S+EeEtxqhyhSPJdv28rlRzszQGLLSK5A==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr13416574wmh.186.1603036784677; 
 Sun, 18 Oct 2020 08:59:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKG4LDYGrfcTeGKXBvhe3OP7bjzV07mWsDR9CnUloQlRE4wGL7GgoXxjxr0ZXIKJ7mRGf5bw==
X-Received: by 2002:a1c:f719:: with SMTP id v25mr13416551wmh.186.1603036784415; 
 Sun, 18 Oct 2020 08:59:44 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id a82sm12794262wmc.44.2020.10.18.08.59.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2020 08:59:43 -0700 (PDT)
Date: Sun, 18 Oct 2020 11:59:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
Message-ID: <20201018115524-mutt-send-email-mst@kernel.org>
References: <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <20201018114625-mutt-send-email-mst@kernel.org>
 <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
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

On Sun, Oct 18, 2020 at 08:54:36AM -0700, Andy Lutomirski wrote:
> On Sun, Oct 18, 2020 at 8:52 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sat, Oct 17, 2020 at 03:24:08PM +0200, Jason A. Donenfeld wrote:
> > > 4c. The guest kernel maintains an array of physical addresses that are
> > > MADV_WIPEONFORK. The hypervisor knows about this array and its
> > > location through whatever protocol, and before resuming a
> > > moved/snapshotted/duplicated VM, it takes the responsibility for
> > > memzeroing this memory. The huge pro here would be that this
> > > eliminates all races, and reduces complexity quite a bit, because the
> > > hypervisor can perfectly synchronize its bringup (and SMP bringup)
> > > with this, and it can even optimize things like on-disk memory
> > > snapshots to simply not write out those pages to disk.
> > >
> > > A 4c-like approach seems like it'd be a lot of bang for the buck -- we
> > > reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
> > > userspace API to deal with, and it'd be race free, and eliminate a lot
> > > of kernel complexity.
> >
> > Clearly this has a chance to break applications, right?
> > If there's an app that uses this as a non-system-calls way
> > to find out whether there was a fork, it will break
> > when wipe triggers without a fork ...
> > For example, imagine:
> >
> > MADV_WIPEONFORK
> > copy secret data to MADV_DONTFORK
> > fork
> >
> >
> > used to work, with this change it gets 0s instead of the secret data.
> >
> >
> > I am also not sure it's wise to expose each guest process
> > to the hypervisor like this. E.g. each process needs a
> > guest physical address of its own then. This is a finite resource.
> >
> >
> > The mmap interface proposed here is somewhat baroque, but it is
> > certainly simple to implement ...
> 
> Wipe of fork/vmgenid/whatever could end up being much more problematic
> than it naively appears -- it could be wiped in the middle of a read.
> Either the API needs to handle this cleanly, or we need something more
> aggressive like signal-on-fork.
> 
> --Andy


Right, it's not on fork, it's actually when process is snapshotted.

If we assume it's CRIU we care about, then I
wonder what's wrong with something like
MADV_CHANGEONPTRACE_SEIZE
and basically say it's X bytes which change the value...


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
