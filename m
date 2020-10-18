Return-Path: <SRS0=CB8P=DZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA4B7C433E7
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 15:54:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDE12072D
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 15:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzbXoiBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDE12072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 00EAB22802;
	Sun, 18 Oct 2020 15:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5UVoHUeVdT+s; Sun, 18 Oct 2020 15:54:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D5DBD2034D;
	Sun, 18 Oct 2020 15:54:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C0FBEC0052;
	Sun, 18 Oct 2020 15:54:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A401C0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1FF6287729
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CvrDtDsoN5-A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:54:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9D96A87726
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:54:50 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0849922201
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 15:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603036490;
 bh=Ij8hCcQO2WHfMKXqZ9b6mcj8QwkRUY/6wK0sNA0dh5k=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=lzbXoiBwUCx8VRbmkG4nkt885exxkcqhAsuLb2fvr3fqkTlejSRJaeNyAYD2epEgu
 vJrqpsB5FALFVLCoGKlM+wXxG2Q+07RP85AFYpIjgIZz1hwOnr1NJ6Q7FSrx4ODrF0
 EFWrMcx3j36Aefjfb3FMwtF5XgySaAaPGPvN45OQ=
Received: by mail-wm1-f46.google.com with SMTP id p15so7919215wmi.4
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 08:54:49 -0700 (PDT)
X-Gm-Message-State: AOAM532beHR7U/3IlMP1AyxXBhfQBO8ekg8TBMfqk0Hr5r8mroWd+boo
 5wxTEbT4xT7bhWYlVfXMtrQUZRgnGecFW1ykvO+/JQ==
X-Google-Smtp-Source: ABdhPJzOzWCZEG9azNTIf9qwP5griKMHkVzCTru01xShRnsJyxl7Sq+uw//hwIlw3LWqPCYWr/akWwABt07P/Tsxr5M=
X-Received: by 2002:a05:600c:2256:: with SMTP id
 a22mr13689655wmm.138.1603036488608; 
 Sun, 18 Oct 2020 08:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <20201018114625-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201018114625-mutt-send-email-mst@kernel.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 18 Oct 2020 08:54:36 -0700
X-Gmail-Original-Message-ID: <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
Message-ID: <CALCETrXBJZnKXo2QLKVWSgAhSMdwEVHeut6pRw4P92CR_5A-fQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Jonathan Corbet <corbet@lwn.net>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 "Singh, Balbir" <sblbir@amazon.com>, bonzini@gnu.org, "Graf \(AWS\),
 Alexander" <graf@amazon.de>, Michal Hocko <mhocko@kernel.org>,
 Jann Horn <jannh@google.com>, oridgar@gmail.com, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 Colm MacCarthaigh <colmmacc@amazon.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
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

On Sun, Oct 18, 2020 at 8:52 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Sat, Oct 17, 2020 at 03:24:08PM +0200, Jason A. Donenfeld wrote:
> > 4c. The guest kernel maintains an array of physical addresses that are
> > MADV_WIPEONFORK. The hypervisor knows about this array and its
> > location through whatever protocol, and before resuming a
> > moved/snapshotted/duplicated VM, it takes the responsibility for
> > memzeroing this memory. The huge pro here would be that this
> > eliminates all races, and reduces complexity quite a bit, because the
> > hypervisor can perfectly synchronize its bringup (and SMP bringup)
> > with this, and it can even optimize things like on-disk memory
> > snapshots to simply not write out those pages to disk.
> >
> > A 4c-like approach seems like it'd be a lot of bang for the buck -- we
> > reuse the existing mechanism (MADV_WIPEONFORK), so there's no new
> > userspace API to deal with, and it'd be race free, and eliminate a lot
> > of kernel complexity.
>
> Clearly this has a chance to break applications, right?
> If there's an app that uses this as a non-system-calls way
> to find out whether there was a fork, it will break
> when wipe triggers without a fork ...
> For example, imagine:
>
> MADV_WIPEONFORK
> copy secret data to MADV_DONTFORK
> fork
>
>
> used to work, with this change it gets 0s instead of the secret data.
>
>
> I am also not sure it's wise to expose each guest process
> to the hypervisor like this. E.g. each process needs a
> guest physical address of its own then. This is a finite resource.
>
>
> The mmap interface proposed here is somewhat baroque, but it is
> certainly simple to implement ...

Wipe of fork/vmgenid/whatever could end up being much more problematic
than it naively appears -- it could be wiped in the middle of a read.
Either the API needs to handle this cleanly, or we need something more
aggressive like signal-on-fork.

--Andy
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
