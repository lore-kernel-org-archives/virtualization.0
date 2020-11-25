Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CEAC6379D
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 12:24:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D8DF206F7
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 12:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GyrkIL7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8DF206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 104C92E140;
	Wed, 25 Nov 2020 12:24:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQCBYuhYUUbN; Wed, 25 Nov 2020 12:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3A5B62E11F;
	Wed, 25 Nov 2020 12:24:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DB22C0891;
	Wed, 25 Nov 2020 12:24:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42282C0052
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 12:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3CEEC8757D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 12:24:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xF-tDkqKFNei
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 12:24:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 62BFB8757E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 12:24:39 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id t3so2291589pgi.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Nov 2020 04:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9IH0l2L/ELs04A0W/6GC4nhC0e+RvRGWJ1bAzD1+dFc=;
 b=GyrkIL7rJc/Wrkz9wtYqXZYvGBry6qXFkQono0nmrBFDlUCiGmbX9ByD1wUhih87ZW
 XCd/8etF0h65aGuVNHVvGVnSoIRV2cIFxWeuMsMEKDZ+SIKsK6eM3KIHPaY2Au+pxfCB
 jFmSmO0a8jtSnIjbAi/709gkMW9hnqxggrhUNIGI/2GrlejcLn7tyz9MFlSEpE31y19Z
 9ARaZhNBbaKZzII6ioDoEFmbbi01XI+4/fF65wWR3SGfZuCMoV2cgGUJ8Osa8sFeqdbz
 KLllcyBsC3gtRPDbq4Yc+z3inKaZT7D05cYTb7CBHNDdR/afLH0A7E5JHrBWilMAefn4
 uS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9IH0l2L/ELs04A0W/6GC4nhC0e+RvRGWJ1bAzD1+dFc=;
 b=hlOC5+3X9aAbM8hKEOSW+KLU3UD3GqrG05UhQ3figMV82W16hS/IuUqc76LghtlAoU
 Omftelnw49k5HmD9BDYQz9M4TgCgJe8/YXGDrm9UJjFZszi0GY1vEMUYtUzNme+TbmiO
 jEy14UDcCWIhJFWPi+qMNChiL89Vxi/iI9h2mwr5l7EkgYZ3juGnBUhJ9d9uJvd7kI1G
 nkcWYBSvv6WbhmB39rdwnE3dCO61yvmiho7/p0ZD666xiDGB+ohRErTVkiyPn9xKd+GW
 4R1Gh88G2tbp840faQq0/hwDYailcU3KVgu0NQkFuww28LPxBfa2BpfiZvp3DreR+mbW
 yDwg==
X-Gm-Message-State: AOAM5332FwuJsXJIFcJYAk4Xy0Ft/bqiMBIQ5XIGHBXGwTwg5YrtL/dt
 clIcSV3GUt1byHh/30em7d6ww5PsadYGzLwYXMiEkg==
X-Google-Smtp-Source: ABdhPJySo35UzNwHodlreVMfJuWPwHO1z+zkcbFfSYU3Avf+sN4n16LJPBb97SBockWyJEKx3Xs8q1wCvzejZmwrmAM=
X-Received: by 2002:a62:7905:0:b029:197:f300:5a2a with SMTP id
 u5-20020a6279050000b0290197f3005a2amr2898775pfc.30.1606307078380; Wed, 25 Nov
 2020 04:24:38 -0800 (PST)
MIME-Version: 1.0
References: <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <ca071decb87cc7e905411423c05a48f9fd2f58d7.camel@perches.com>
 <0147972a72bc13f3629de8a32dee6f1f308994b5.camel@HansenPartnership.com>
 <d8d1e9add08cdd4158405e77762d4946037208f8.camel@perches.com>
 <dbd2cb703ed9eefa7dde9281ea26ab0f7acc8afe.camel@HansenPartnership.com>
 <20201123130348.GA3119@embeddedor>
 <8f5611bb015e044fa1c0a48147293923c2d904e4.camel@HansenPartnership.com>
 <202011241327.BB28F12F6@keescook>
 <a841536fe65bb33f1c72ce2455a6eb47a0107565.camel@HansenPartnership.com>
In-Reply-To: <a841536fe65bb33f1c72ce2455a6eb47a0107565.camel@HansenPartnership.com>
Date: Wed, 25 Nov 2020 04:24:27 -0800
Message-ID: <CAKwvOdkGBn7nuWTAqrORMeN1G+w3YwBfCqqaRD2nwvoAXKi=Aw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: alsa-devel@alsa-project.org, bridge@lists.linux-foundation.org,
 target-devel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
 linux-iio@vger.kernel.org, samba-technical@lists.samba.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-fbdev@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-ide@vger.kernel.org,
 dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org,
 linux-i3c@lists.infradead.org, linux1394-devel@lists.sourceforge.net,
 linux-afs@lists.infradead.org, drbd-dev@lists.linbit.com,
 devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-rdma@vger.kernel.org,
 oss-drivers@netronome.com, linux-atm-general@lists.sourceforge.net,
 ceph-devel@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com,
 usb-storage@lists.one-eyed-alien.net, linux-mmc@vger.kernel.org,
 coreteam@netfilter.org, intel-wired-lan@lists.osuosl.org,
 linux-input@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, linux-ext4@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netfilter-devel@vger.kernel.org,
 linux-media@vger.kernel.org, Kees Cook <keescook@chromium.org>,
 selinux@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 intel-gfx@lists.freedesktop.org, linux-sctp@vger.kernel.org,
 reiserfs-devel@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-block@vger.kernel.org, linux-gpio@vger.kernel.org,
 op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org,
 xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org,
 linux-hams@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
 linux-can@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-hwmon@vger.kernel.org,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 linux-watchdog@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Network Development <netdev@vger.kernel.org>,
 linux-decnet-user@lists.sourceforge.net,
 linux-wireless <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-security-module@vger.kernel.org, linux-usb@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com,
 Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org,
 linux-nfs@vger.kernel.org, linux-hardening@vger.kernel.org
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
From: Nick Desaulniers via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Nov 24, 2020 at 11:05 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2020-11-24 at 13:32 -0800, Kees Cook wrote:
> > We already enable -Wimplicit-fallthrough globally, so that's not the
> > discussion. The issue is that Clang is (correctly) even more strict
> > than GCC for this, so these are the remaining ones to fix for full
> > Clang coverage too.
> >
> > People have spent more time debating this already than it would have
> > taken to apply the patches. :)
>
> You mean we've already spent 90% of the effort to come this far so we
> might as well go the remaining 10% because then at least we get some
> return? It's certainly a clinching argument in defence procurement ...

So developers and distributions using Clang can't have
-Wimplicit-fallthrough enabled because GCC is less strict (which has
been shown in this thread to lead to bugs)?  We'd like to have nice
things too, you know.

I even agree that most of the churn comes from

case 0:
  ++x;
default:
  break;

which I have a patch for: https://reviews.llvm.org/D91895.  I agree
that can never lead to bugs.  But that's not the sole case of this
series, just most of them.

Though, note how the reviewer (C++ spec editor and clang front end
owner) in https://reviews.llvm.org/D91895 even asks in that review how
maybe a new flag would be more appropriate for a watered
down/stylistic variant of the existing behavior.  And if the current
wording of Documentation/process/deprecated.rst around "fallthrough"
is a straightforward rule of thumb, I kind of agree with him.

>
> > This is about robustness and language wrangling. It's a big code-
> > base, and this is the price of our managing technical debt for
> > permanent robustness improvements. (The numbers I ran from Gustavo's
> > earlier patches were that about 10% of the places adjusted were
> > identified as legitimate bugs being fixed. This final series may be
> > lower, but there are still bugs being found from it -- we need to
> > finish this and shut the door on it for good.)
>
> I got my six patches by analyzing the lwn.net report of the fixes that
> was cited which had 21 of which 50% didn't actually change the emitted
> code, and 25% didn't have a user visible effect.
>
> But the broader point I'm making is just because the compiler people
> come up with a shiny new warning doesn't necessarily mean the problem

That's not what this is though; you're attacking a strawman.  I'd
encourage you to bring that up when that actually occurs, unlike this
case since it's actively hindering getting -Wimplicit-fallthrough
enabled for Clang.  This is not a shiny new warning; it's already on
for GCC and has existed in both compilers for multiple releases.

And I'll also note that warnings are warnings and not errors because
they cannot be proven to be bugs in 100% of cases, but they have led
to bugs in the past.  They require a human to review their intent and
remove ambiguities.  If 97% of cases would end in a break ("Expert C
Programming: Deep C Secrets" - Peter van der Linden), then it starts
to look to me like a language defect; certainly an incorrectly chosen
default.  But the compiler can't know those 3% were intentional,
unless you're explicit for those exceptional cases.

> it's detecting is one that causes us actual problems in the code base.
> I'd really be happier if we had a theory about what classes of CVE or
> bug we could eliminate before we embrace the next new warning.

We don't generally file CVEs and waiting for them to occur might be
too reactive, but I agree that pointing to some additional
documentation in commit messages about how a warning could lead to a
bug would make it clearer to reviewers why being able to enable it
treewide, even if there's no bug in their particular subsystem, is in
the general interest of the commons.

On Mon, Nov 23, 2020 at 7:58 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> We're also complaining about the inability to recruit maintainers:
>
> https://www.theregister.com/2020/06/30/hard_to_find_linux_maintainers_says_torvalds/
>
> And burn out:
>
> http://antirez.com/news/129
>
> The whole crux of your argument seems to be maintainers' time isn't
> important so we should accept all trivial patches ... I'm pushing back
> on that assumption in two places, firstly the valulessness of the time
> and secondly that all trivial patches are valuable.

It's critical to the longevity of any open source project that there
are not single points of failure.  If someone is not expendable or
replaceable (or claims to be) then that's a risk to the project and a
bottleneck.  Not having a replacement in training or some form of
redundancy is short sighted.

If trivial patches are adding too much to your workload, consider
training a co-maintainer or asking for help from one of your reviewers
whom you trust.  I don't doubt it's hard to find maintainers, but
existing maintainers should go out of their way to entrust
co-maintainers especially when they find their workload becomes too
high.  And reviewing/picking up trivial patches is probably a great
way to get started.  If we allow too much knowledge of any one
subsystem to collect with one maintainer, what happens when that
maintainer leaves the community (which, given a finite lifespan, is an
inevitability)?
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
