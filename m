Return-Path: <SRS0=CB8P=DZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED49C4363A
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 02:08:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D611522210
	for <virtualization@archiver.kernel.org>; Sun, 18 Oct 2020 02:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="JYBvkmsN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D611522210
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 583B2873D6;
	Sun, 18 Oct 2020 02:08:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vr3dvdwWD3Vd; Sun, 18 Oct 2020 02:08:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5CE05873C9;
	Sun, 18 Oct 2020 02:08:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44D83C0052;
	Sun, 18 Oct 2020 02:08:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82FBDC0051
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 02:08:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 631D7873CB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 02:08:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0K9WNfO1SfNl
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 02:08:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com
 [209.85.208.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5442A873C9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Oct 2020 02:08:34 +0000 (UTC)
Received: by mail-lj1-f194.google.com with SMTP id h20so7248065lji.9
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 19:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EoL7d0lHzdswPEFGsAEJJdNfE07sA8igVy5PEUcTbDQ=;
 b=JYBvkmsN9RysEeFQRgQMS2IGgQheKP8WCpVEITeoShBcDrScb2YzXJWCS9fBQBrxMO
 n86hAFDTEQHXskSLJ578m/TKYBOiwMg0z/aLu4hSKM9fzy3Bml2AtFnKiNFHXmC81ou5
 oLgoTyjjd7m8dU7zn1iDkaLBmUIFwukS3W1degboeUcB5xxmHAwJ7X7ZJjY5qLq4Uevz
 9565oX51vhmKmr/jiZRuPNAZjyZvYkS6kUYo9TyvCsqYY8xkBsy/gcixSZeElDfa4GKl
 lQjC5lLseYNii8XoYpb7znRj1djIzK3pwUzl9c71Hf2cfPLya0ovLXiar856omGyFgtc
 cBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EoL7d0lHzdswPEFGsAEJJdNfE07sA8igVy5PEUcTbDQ=;
 b=a30RatTcDiLlHEOMTgaHShG9ohbUjmnNw0/NFwJR8WSksWO2Gr3unEN3+9S8+t7S9g
 Kl5AIsyZf8f9CbKvdgOsrTkQeSFFwHuKVXCFZ6qZkql5z7Od7EA3t1kJMbFUQLzUdtZO
 rIMZ4l+RqvcJr8L8vO9WWgyoJSl2xcwjBjkYLKzhfzy1Y7LeIrd1W2uoXiiWd9wzUZho
 VKAZvTmfVXSJloBfiwinVW3ON8/+HCvuVGiIvfZEAN8GjfHYKoz+CQgil1Q9UvJCwjUx
 SqTevNuhEUkbhpe8UxSFvug5JPxDgFbu64DKT/SPDU/fP2sXlsiuHIKlL3lAW2OYc8Ek
 ij4Q==
X-Gm-Message-State: AOAM5308Eo3Tuecf+suHynZrTc9rDPpM17CaKkRjTApzfbH7CLua4KvL
 BRgxLiLhpS/BF7vI4mlUH/tiotZoYzM6xrJdzqAXXA==
X-Google-Smtp-Source: ABdhPJxVC4A8hz5Ph8xI5Lcuiwu6i49AGWglYFrVbrHYISFimwHqgN7R9bAY4u2r3Hi8cj+JpNCqLDs0HlkcXSFAtqI=
X-Received: by 2002:a05:651c:1313:: with SMTP id
 u19mr1073920lja.47.1602986911177; 
 Sat, 17 Oct 2020 19:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
 <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
 <20201017064442.GA14117@1wt.eu>
 <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
 <CAHmME9qHGSF8w3DoyCP+ud_N0MAJ5_8zsUWx=rxQB1mFnGcu9w@mail.gmail.com>
 <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
In-Reply-To: <aacdff7a-2af1-4f46-6ab2-2a9d5b865d35@amazon.de>
Date: Sun, 18 Oct 2020 04:08:04 +0200
Message-ID: <CAG48ez0JYK2_tk0DuEgKY2y0d38N+O5HJrH2je7RRk6o7XBixA@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Alexander Graf <graf@amazon.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Colm MacCarthaigh <colmmacc@amazon.com>,
 Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
 Christian Borntraeger <borntraeger@de.ibm.com>, "Singh,
 Balbir" <sblbir@amazon.com>, bonzini@gnu.org, oridgar@gmail.com, "Catangiu,
 Adrian Costin" <acatan@amazon.com>, Andy Lutomirski <luto@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Willy Tarreau <w@1wt.eu>, "Woodhouse, David" <dwmw@amazon.co.uk>
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

On Sat, Oct 17, 2020 at 8:09 PM Alexander Graf <graf@amazon.de> wrote:
> There are applications way beyond that though. What do you do with
> applications that already consumed randomness? For example a cached pool
> of SSL keys. Or a higher level language primitive that consumes
> randomness and caches its seed somewhere in an internal data structure.

For deterministic protection, those would also have to poll some
memory location that tells them whether the VmGenID changed:

1. between reading entropy from their RNG pool and using it
2. between collecting data from external sources (user input, clock,
...) and encrypting it

and synchronously shoot down the connection if a change happened. If
e.g. an application inside the VM has an AES-GCM-encrypted TLS
connection and, directly after the VM is restored, triggers an
application-level timeout that sends some fixed message across the
connection, then the TLS library must guarantee that either the VM was
already committed to sending exactly that message before the VM was
forked or the message will be blocked. If we don't do that, an
attacker who captures both a single packet from the forked VM and
traffic from the old VM can decrypt the next message from the old VM
after the fork (because AES-GCM is like AES-CTR plus an authenticator,
and CTR means that when keystream reuse occurs and one of the
plaintexts is known, the attacker can simply recover the other
plaintext using XOR).

(Or maybe, in disaster failover environments, TLS 1.3 servers could
get away with rekeying the connection instead of shooting it down? Ask
your resident friendly cryptographer whether that would be secure, I
am not one.)

I don't think a mechanism based around asynchronously telling the
application and waiting for it to confirm the rotation at a later
point is going to cut it; we should have some hard semantics on when
an application needs to poll this value.

> Or even worse: your system's host ssh key.

Mmmh... I think I normally would not want a VM to reset its host ssh
key after merely restoring a snapshot though? And more importantly,
Microsoft's docs say that they also change the VmGenID on disaster
failover. I think you very much wouldn't want your server to lose its
host key every time disaster failover happens. On the other hand,
after importing a public VM image, it might be a good idea.

I guess you could push that responsibility on the user, by adding an
option to the sshd_config that tells OpenSSH whether the host key
should be rotated on an ID change or not... but that still would not
be particularly pretty.

Ideally we would have the host tell us what type of events happened to
the VM, or something like that... or maybe even get the host VM
management software to ask the user whether they're importing a public
image... I really feel like with Microsoft's current protocol, we
don't get enough information to figure out what we should do about
private long-term authentication keys.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
