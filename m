Return-Path: <SRS0=x5ns=DY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F5C43467
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 05:53:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9499620709
	for <virtualization@archiver.kernel.org>; Sat, 17 Oct 2020 05:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="amsP3PlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9499620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 24CEE88CEC;
	Sat, 17 Oct 2020 05:53:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qn9-5W9olSmg; Sat, 17 Oct 2020 05:53:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4BA8488E8A;
	Sat, 17 Oct 2020 05:53:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FB25C07FF;
	Sat, 17 Oct 2020 05:53:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 928FDC0051
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 05:53:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 793DE88E8A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 05:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QihqH-AkWPfI
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 05:53:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 531C588CEC
 for <virtualization@lists.linux-foundation.org>;
 Sat, 17 Oct 2020 05:53:17 +0000 (UTC)
Received: by mail-lj1-f193.google.com with SMTP id d24so5027638ljg.10
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Oct 2020 22:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M3YB82PP3WUpBHFEbh3oPhQQSux8Pw6AFe+SN7DiJGw=;
 b=amsP3PlI3ZycdlVxgLx5tS3RcZ/aE2JugXN/de8WjJzEbbWQfg5yay9mu9yMNOTQEG
 zDGufeyQG0D8nAwfy0A+eh+5b93z85bXUL2cX8T/4mhVh2wiIWZNqlk28ZRb4QzNB/dh
 AIBnGWL+ksEigCgQdVu62IDy26gLVIDUnczpRvNend8MTTwuaCQtont43SmFPbW4CRcT
 cmRIzAt2jsd2hPhc8PRzFfChw9wh+qGJaBiAl8a3e2bI5TkwKjB9tCNO3N3jC/SV0wIn
 USEp5Yt0/QCw/q0JJrWcSGJN2B9ryqMiiGMVPf4OXy69UAR96sfkVVyhw3En3TdcYtr6
 S+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M3YB82PP3WUpBHFEbh3oPhQQSux8Pw6AFe+SN7DiJGw=;
 b=BfKnAfhyo6c1FG78Zg2WGXuToo8PciEe2xfq8NoVp137ehTk4DpjtckfZRdRhGl9eg
 vKNARXo/MDxePaGB2zYS1rOS1o968wowpzxdHE1lrS3wQ8msjYTcV7nedK/iyM+Id4u+
 RV3Y7vP5lOAPz0v8bGDegIxYRqJIw5WH4nW/kDWqR7jHgAZ0hzOxRISUuGErUocz8YW2
 xrPHNLxMzUcX34/WSSDqwEG+oB/+XQWvsPSIV2Wwv5eumamCkd962SUSiUHUa3Lpoh9u
 K8mcxl2Mth5zg+wg4sLxwM2kCI0MdH3cSy0+gmf5tKjSPJEwAokN2Xgzl2HpbmLTmtHq
 FafQ==
X-Gm-Message-State: AOAM533+Bh84rl+F25FjewJMkZDxaiCWgYCIjwG81jZjAYTvFdmSeosQ
 Yd4q+yYi9Q8KSVSGsixG7PLJP+w/ND73gCQmkeEm4Q==
X-Google-Smtp-Source: ABdhPJyqRwgfzaNO4k6jC4+ngiz4xp94h1rvkVA6jI+YkhoWwbWi6nRJWMl5uQZtM/9C6Yz+umn28GEOA1tFiD8OGAE=
X-Received: by 2002:a2e:504b:: with SMTP id v11mr2673538ljd.138.1602913994976; 
 Fri, 16 Oct 2020 22:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <788878CE-2578-4991-A5A6-669DCABAC2F2@amazon.com>
 <CAG48ez0EanBvDyfthe+hAP0OC8iGLNSq2e5wJVz-=ENNGF97_w@mail.gmail.com>
 <20201017033606.GA14014@1wt.eu>
 <CAG48ez0x2S9XuCrANAQbXNi8Jjwm822-fnQSmr-Zr07JgrEs1g@mail.gmail.com>
 <6CC3DB03-27BA-4F5E-8ADA-BE605D83A85C@amazon.com>
 <CAG48ez1ZtvjOs2CEq8-EMosPCd_o7WQ3Mz_+1mDe7OrH2arxFA@mail.gmail.com>
 <20201017053712.GA14105@1wt.eu>
In-Reply-To: <20201017053712.GA14105@1wt.eu>
Date: Sat, 17 Oct 2020 07:52:48 +0200
Message-ID: <CAG48ez1h0ynXfGap_KiHiPVTfcB8NBQJ-2dnj08ZNfuhrW0jWA@mail.gmail.com>
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

On Sat, Oct 17, 2020 at 7:37 AM Willy Tarreau <w@1wt.eu> wrote:
> On Sat, Oct 17, 2020 at 07:01:31AM +0200, Jann Horn wrote:
> > Microsoft's documentation
> > (http://go.microsoft.com/fwlink/?LinkId=260709) says that the VM
> > Generation ID that we get after a fork "is a 128-bit,
> > cryptographically random integer value". If multiple people use the
> > same image, it guarantees that each use of the image gets its own,
> > fresh ID:
>
> No. It cannot be more unique than the source that feeds that cryptographic
> transformation. All it guarantees is that the entropy source is protected
> from being guessed based on the output. Applying cryptography on a simple
> counter provides apparently random numbers that will be unique for a long
> period for the same source, but as soon as you duplicate that code between
> users and they start from the same counter they'll get the same IDs.
>
> This is why I think that using a counter is better if you really need something
> unique. Randoms only reduce predictability which helps avoiding collisions.

Microsoft's spec tells us that they're giving us cryptographically
random numbers. Where they're getting those from is not our problem.
(And if even the hypervisor is not able to collect enough entropy to
securely generate random numbers, worrying about RNG reseeding in the
guest would be kinda pointless, we'd be fairly screwed anyway.)

Also note that we don't actually need to *always* reinitialize RNG
state on forks for functional correctness; it is fine if that fails
with a probability of 2^-128, because functionally everything will be
fine, and an attacker who is that lucky could also just guess an AES
key (which has the same probability of being successful). (And also
2^-128 is such a tiny number that it doesn't matter anyway.)

> And I'm saying this as someone who had on his external gateway the same SSH
> host key as 89 other hosts on the net, each of them using randoms to provide
> a universally unique one...

If your SSH host key was shared with 89 other hosts, it evidently
wasn't generated from cryptographically random numbers. :P Either
because the key generator was not properly hooked up to the system's
entropy pool (if you're talking about the Debian fiasco), or because
the system simply did not have enough entropy available. (Or because
the key generator is broken, but I don't think that ever happened with
OpenSSH?)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
