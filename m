Return-Path: <SRS0=x5ns=DY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D4EC43467
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 06:56:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7931720760
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 06:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qT5tSTup"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7931720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 18A7288E64;
	Sat, 17 Oct 2020 06:56:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OvP5ByURKonn; Sat, 17 Oct 2020 06:56:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 90D1C88E95;
	Sat, 17 Oct 2020 06:56:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59F0FC0052;
	Sat, 17 Oct 2020 06:56:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89C0FC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 06:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6FF5D88B00
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 06:56:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UCcEEpfxoW6h
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 06:56:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B799988AEB
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 06:56:03 +0000 (UTC)
Received: by mail-lj1-f195.google.com with SMTP id h20so5128104lji.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wzkWOoKjInRI+O5FvJvA/t/AUj8a5RTpGl8TvIyMwpk=;
 b=qT5tSTupKtI9+LV08l4NhIywJjENbE/1819qMpMZ4wleQCC2UZcegHiJKzfH1HMZ3e
 VQ39ggQjsnoUsTrwcVQ97D1zQSE6mutGso5Q8ogf39SUNsMEKhaYEUFy/VRoirOjmt9b
 37fnHoejXu8BkEr6+HM11CFBIeNasDURFIHxGHoIweZ8GffWeTWMHjs1yf08SJ9aElhz
 uVubdWIw6/aHW+WMsmF6jE1F+EA14IbVZRX4CbiaSO5HESQkyn+DtfxAcYY1TXnDXa3y
 L0xoXUEVvRAwv4QmP1JweP+0D8VJwUznxwhWGyWIOZuxwKsIs2yP+PPDqRQknJmj0Lnw
 LbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wzkWOoKjInRI+O5FvJvA/t/AUj8a5RTpGl8TvIyMwpk=;
 b=TtVulqY9r8oGN5Q5PAZAZDI+qpzGKcx79eskhsIhMj/frAWYCzUAO5N9yoP1694A+A
 bqheK7CHNZGL+kMm3mUmYzs3vFdHSBdHvNsc94MfTIFqhKoRH+B+f8JGJGfhZxngyhG7
 Zc4TeL5I4CaYnW3mO3eFkbNeb8kYcvDIkdkx3w7p8mKlTu3/NEi1/evmmB/uD2NAGRhq
 B/D/4M1enaJGdJu/i/H9M4Byizmk4//+u6E4Wu0iwJcBaFQFQLdQ4g4U6IrDEiYbMLTi
 uOSorC+B86XTj9Z2QwxHGPIMfZkmJTrxZMH53LJUDgfk2sByk31BQunkv3bEHiqwZ1ja
 opvA==
X-Gm-Message-State: AOAM5329GwzGQQdm6lpVjzM9SI5+9z6UaVyP2G03jlrS5tG1//fHNXuC
 WZjUkTpml/9+RtxF/XnscVeIjmRKyyswNGix47S8iA==
X-Google-Smtp-Source: ABdhPJy+7ndzZeyQ/tSwJHmtK1PTCVWdHHr1LWw9yj8KnDosvV+fAVJTuHJyVyhRpmky/WIBh3xN8Pb/8hbCqMiC0A0=
X-Received: by 2002:a2e:8816:: with SMTP id x22mr2697080ljh.377.1602917761335; 
 Fri, 16 Oct 2020 23:56:01 -0700 (PDT)
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
In-Reply-To: <20201017064442.GA14117@1wt.eu>
Date: Sat, 17 Oct 2020 08:55:34 +0200
Message-ID: <CAG48ez3pXLC+eqAXDCniM0a+5yP2XJODDkZqiUTZUOttCE_LbA@mail.gmail.com>
Subject: Re: [PATCH] drivers/virt: vmgenid: add vm generation id driver
To: Willy Tarreau <w@1wt.eu>
Cc: Jason Donenfeld <Jason@zx2c4.com>, KVM list <kvm@vger.kernel.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, ghammer@redhat.com,
 "Weiss, Radu" <raduweis@amazon.com>, Qemu Developers <qemu-devel@nongnu.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Pavel Machek <pavel@ucw.cz>, Colm MacCarthaigh <colmmacc@amazon.com>,
 Jonathan Corbet <corbet@lwn.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Biggers <ebiggers@kernel.org>, "Singh, Balbir" <sblbir@amazon.com>,
 bonzini@gnu.org, "Graf \(AWS\), Alexander" <graf@amazon.de>, oridgar@gmail.com,
 "Catangiu, Adrian Costin" <acatan@amazon.com>,
 Andy Lutomirski <luto@kernel.org>, Michal Hocko <mhocko@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
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

On Sat, Oct 17, 2020 at 8:44 AM Willy Tarreau <w@1wt.eu> wrote:
> On Sat, Oct 17, 2020 at 07:52:48AM +0200, Jann Horn wrote:
> > On Sat, Oct 17, 2020 at 7:37 AM Willy Tarreau <w@1wt.eu> wrote:
> > > On Sat, Oct 17, 2020 at 07:01:31AM +0200, Jann Horn wrote:
> > > > Microsoft's documentation
> > > > (http://go.microsoft.com/fwlink/?LinkId=260709) says that the VM
> > > > Generation ID that we get after a fork "is a 128-bit,
> > > > cryptographically random integer value". If multiple people use the
> > > > same image, it guarantees that each use of the image gets its own,
> > > > fresh ID:
> > >
> > > No. It cannot be more unique than the source that feeds that cryptographic
> > > transformation. All it guarantees is that the entropy source is protected
> > > from being guessed based on the output. Applying cryptography on a simple
> > > counter provides apparently random numbers that will be unique for a long
> > > period for the same source, but as soon as you duplicate that code between
> > > users and they start from the same counter they'll get the same IDs.
> > >
> > > This is why I think that using a counter is better if you really need something
> > > unique. Randoms only reduce predictability which helps avoiding collisions.
> >
> > Microsoft's spec tells us that they're giving us cryptographically
> > random numbers. Where they're getting those from is not our problem.
> > (And if even the hypervisor is not able to collect enough entropy to
> > securely generate random numbers, worrying about RNG reseeding in the
> > guest would be kinda pointless, we'd be fairly screwed anyway.)
>
> Sorry if I sound annoying, but it's a matter of terminology and needs.
>
> Cryptograhically random means safe for use with cryptography in that it
> is unguessable enough so that you can use it for encryption keys that
> nobody will be able to guess. It in no ways guarantees uniqueness, just
> like you don't really care if the symmetric crypto key of you VPN has
> already been used once somewhere else as long as there's no way to know.
> However with the good enough distribution that a CSPRNG provides,
> collisions within a *same* generator are bound to a very low, predictable
> rate which is by generally considered as acceptable for all use cases.

Yes.

> Something random (cryptographically or not) *cannot* be unique by
> definition, otherwise it's not random anymore, since each draw has an
> influence on the remaining list of possible draws, which is contrary to
> randomness. And conversely something unique cannot be completely random
> because if you know it's unique, you can already rule out all other known
> values from the candidates, thus it's more predictable than random.

Yes.

> With this in mind, picking randoms from a same RNG is often highly
> sufficient to consider they're highly likely unique within a long
> period. But it's not a guarantee. And it's even less one between two
> RNGs (e.g. if uniqueness is required between multiple hypervisors in
> case VMs are migrated or centrally managed, which I don't know).
>
> If what is sought here is a strong guarantee of uniqueness, using a
> counter as you first suggested is better.

My suggestion is to use a counter *in the UAPI*, not in the hypervisor
protocol. (And as long as that counter can only miss increments in a
cryptographically negligible fraction of cases, everything's fine.)

> If what is sought is pure
> randomness (in the sense that it's unpredictable, which I don't think
> is needed here), then randoms are better.

And this is what *the hypervisor protocol* gives us (which could be
very useful for reseeding the kernel RNG).

> If both are required, just
> concatenate a counter and a random. And if you need them to be spatially
> unique, just include a node identifier.
>
> Now the initial needs in the forwarded message are not entirely clear
> to me but I wanted to rule out the apparent mismatch between the expressed
> needs for uniqueness and the proposed solutions solely based on randomness.

Sure, from a theoretical standpoint, it would be a little bit nicer if
the hypervisor protocol included a generation number along with the
128-bit random value. But AFAIU it doesn't, so if we want this to just
work under Microsoft's existing hypervisor, we'll have to make do with
checking whether the random value changed. :P
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
