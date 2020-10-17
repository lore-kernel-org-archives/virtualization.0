Return-Path: <SRS0=x5ns=DY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC92EC433E7
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 04:03:13 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148EB20758
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 04:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="G0aFMwnX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148EB20758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7D24D2044C;
	Sat, 17 Oct 2020 04:03:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sMaqd8Drpyj2; Sat, 17 Oct 2020 04:03:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 41071203DB;
	Sat, 17 Oct 2020 04:03:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FAF3C0052;
	Sat, 17 Oct 2020 04:03:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 694DAC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 04:03:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5CABE88A66
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 04:03:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iNeScW9fTuJU
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 04:03:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A198F88A06
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 04:03:05 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id c21so4881218ljn.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 21:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uR2yRSoFIyQFa85ZmyTeQWbKesy0kogveF0JOmK3HCU=;
 b=G0aFMwnXL3XlqQtltqTo0eoChMRvdBPFzMoicowzO+xAY5WA7wnecLBujcLmZah0k/
 e5mpG2PgiCXI5UV6aPxyJHgp+ak3mHqsIwGNyATLAY9IpyytJ/yv/eUNLEx8n5Z8IWxM
 5Ev81C4+GL/IiR5iIz/ra80OcP7ctuQ69Pj2L7/QrHYXrCEAAle4I31KIYWKOWdz7wXn
 M3HFOt505tL/bufF7RKhxyavqsmuktaYt6aLjMXM2bezAY35bwnHVGu6RsGL9aReXefA
 CUnwlpUOUePqMTfmrge6m16eiA1+eUvlxTaBEHUJphVGNMuBAicVc8kqC269vRlgE0G9
 pD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uR2yRSoFIyQFa85ZmyTeQWbKesy0kogveF0JOmK3HCU=;
 b=gZDDNZyS+JXPGr4IbaS0ReQpTCFJssJeVRJ7IMITmmV1BhJYqnInA6a5/y7uQe11s5
 FxA0dsUDiVOD/D3cnYKyUoBjm419oA0MGJkMwQfw5JSDyr6Jsi5J35wDKQLhrOLM1P+l
 rMHMYHtRouVsKWabYvpMIZeYfqSy+vvQyiO9zNTlDdMP0ZXqR8ZHav7b9ZHXNdw9EIbR
 +z2pLzTYcPMS4Xe7tLa3RU6gNHV8bl6qVe5CihekK6JEUv3NSVnOt+My0/wf5ElIAsBG
 fclxDjDZIjAW6jnXpIQ+BVaLEyePmt/h8vJkyWD0h9P/G6OaJfXJX/UggKubKDqpaJuc
 qFvQ==
X-Gm-Message-State: AOAM533wB6tQGTMS5XC++dtjWtyyHEC9MEpGmtq6BBVc8vnKTf1OpQHj
 GPmWY9cgfsXfd1zsouS3ZiaUs8Nx2ldYLCelggf94w==
X-Google-Smtp-Source: ABdhPJyWM+KuxWSKm+WZakQM1coYpvqzhvFBssVoo8yKJsSvLXOonodEkq1Mrj4Ytt2McNT6VBun6xj6Gc9/hPkEfDk=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr2543467ljh.377.1602907383409; 
 Fri, 16 Oct 2020 21:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
In-Reply-To: <20201017033606.GA14014@1wt.eu>
Date: Sat, 17 Oct 2020 06:02:36 +0200
Message-ID: <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Willy Tarreau <w@1wt.eu>
Cc: Jason Donenfeld <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "ghammer@redhat.com" <ghammer@redhat.com>, "Weiss, Radu" <raduweis@amazon.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>,
 "MacCarthaigh, Colm" <colmmacc@amazon.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "mst@redhat.com" <mst@redhat.com>, Eric Biggers <ebiggers@kernel.org>, "Singh,
 Balbir" <sblbir@amazon.com>, "bonzini@gnu.org" <bonzini@gnu.org>,
 "Graf \(AWS\), Alexander" <graf@amazon.de>,
 "oridgar@gmail.com" <oridgar@gmail.com>, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Woodhouse, David" <dwmw@amazon.co.uk>
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
From: Jann Horn via Virtualization <virtualization@lists.linux-foundation.org>
Reply-To: Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Oct 17, 2020 at 5:36 AM Willy Tarreau <w@1wt.eu> wrote:
> On Sat, Oct 17, 2020 at 03:40:08AM +0200, Jann Horn wrote:
> > [adding some more people who are interested in RNG stuff: Andy, Jason,
> > Theodore, Willy Tarreau, Eric Biggers. also linux-api@, because this
> > concerns some pretty fundamental API stuff related to RNG usage]
> >
> > On Fri, Oct 16, 2020 at 4:33 PM Catangiu, Adrian Costin
> > <acatan@amazon.com> wrote:
> > > This patch is a driver which exposes the Virtual Machine Generation ID
> > > via a char-dev FS interface that provides ID update sync and async
> > > notification, retrieval and confirmation mechanisms:
> > >
> > > When the device is 'open()'ed a copy of the current vm UUID is
> > > associated with the file handle. 'read()' operations block until the
> > > associated UUID is no longer up to date - until HW vm gen id changes -
> > > at which point the new UUID is provided/returned. Nonblocking 'read()'
> > > uses EWOULDBLOCK to signal that there is no _new_ UUID available.
> > >
> > > 'poll()' is implemented to allow polling for UUID updates. Such
> > > updates result in 'EPOLLIN' events.
> > >
> > > Subsequent read()s following a UUID update no longer block, but return
> > > the updated UUID. The application needs to acknowledge the UUID update
> > > by confirming it through a 'write()'.
> > > Only on writing back to the driver the right/latest UUID, will the
> > > driver mark this "watcher" as up to date and remove EPOLLIN status.
> > >
> > > 'mmap()' support allows mapping a single read-only shared page which
> > > will always contain the latest UUID value at offset 0.
> >
> > It would be nicer if that page just contained an incrementing counter,
> > instead of a UUID. It's not like the application cares *what* the UUID
> > changed to, just that it *did* change and all RNGs state now needs to
> > be reseeded from the kernel, right? And an application can't reliably
> > read the entire UUID from the memory mapping anyway, because the VM
> > might be forked in the middle.
> >
> > So I think your kernel driver should detect UUID changes and then turn
> > those into a monotonically incrementing counter. (Probably 64 bits
> > wide?) (That's probably also a little bit faster than comparing an
> > entire UUID.)
>
> I agree with this. Further, I'm observing there is a very common
> confusion between "universally unique" and "random". Randoms are
> needed when seeking unpredictability. A random number generator
> *must* be able to return the same value multiple times in a row
> (though this is rare), otherwise it's not random.
[...]
> If the UUIDs used there are real UUIDs, it could be as simple as
> updating them according to their format, i.e. updating the timestamp,
> and if the timestamp is already the same, just increase the seq counter.
> Doing this doesn't require entropy, doesn't need to block and doesn't
> needlessly leak randoms that sometimes make people feel nervous.

Those UUIDs are supplied by existing hypervisor code; in that regard,
this is almost like a driver for a hardware device. It is written
against a fixed API provided by the underlying machine. Making sure
that the sequence of UUIDs, as seen from inside the machine, never
changes back to a previous one is the responsibility of the hypervisor
and out of scope for this driver.

Microsoft's spec document (which is a .docx file for reasons I don't
understand) actually promises us that it is a cryptographically random
128-bit integer value, which means that if you fork a VM 2^64 times,
the probability that any two of those VMs have the same counter is
2^-64. That should be good enough.

But in userspace, we just need a simple counter. There's no need for
us to worry about anything else, like timestamps or whatever. If we
repeatedly fork a paused VM, the forked VMs will see the same counter
value, but that's totally fine, because the only thing that matters to
userspace is that the counter changes when the VM is forked.

And actually, since the value is a cryptographically random 128-bit
value, I think that we should definitely use it to help reseed the
kernel's RNG, and keep it secret from userspace. That way, even if the
VM image is public, we can ensure that going forward, the kernel RNG
will return securely random data.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
