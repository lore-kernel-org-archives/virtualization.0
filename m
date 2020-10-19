Return-Path: <SRS0=EPK4=D2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7DCC433E7
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 19:42:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D70C222EA
	for <virtualization@archiver.kernel.org>; Mon, 19 Oct 2020 19:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vqIoQqfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D70C222EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EFC4D2E106;
	Mon, 19 Oct 2020 19:42:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RBroNz-kQgzr; Mon, 19 Oct 2020 19:42:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 823EA2E0F6;
	Mon, 19 Oct 2020 19:42:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 551E9C0052;
	Mon, 19 Oct 2020 19:42:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 073F0C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 19:42:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F2AF886A9D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 19:42:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kSG0QbdNv5xW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 19:42:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com
 [209.85.214.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 9981D86A95
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 19:42:27 +0000 (UTC)
Received: by mail-pl1-f196.google.com with SMTP id bf6so330450plb.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=no6WOfZDuAXhTDfVia9Vunkz4L7BthY0F8m0jo4//vs=;
 b=vqIoQqfPtCUD7ceHGEmbvFqqUZd/9dE0IpLQQ4p4nyONBXQMSFxBG5OzgCaJfT8eu8
 Ez0DMwUntzcU9c2WJzs/WqMvxG3bzlj0mstlcz+E4fW0gt02sZNjrL1HdU6SHVwmCE5R
 WFeHYzJRJuPZspqj8YJ2wlUmUN4Mc8MNrI6kLekCJ8yejCepkvkgEUeb7TbpDze1NnEh
 TP2SjhqdakZDUedR00qYjd62k5W2m7FgfHIpcuS/rhjqMGxVL3Apppn+UDRO/ftdIfoh
 duvoKavmXDacw9mysFV+xdp1Tg4QxCPiDxNSeCeZyO+34Y2S1kYSdX61NJzSKhmGsX5T
 HLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=no6WOfZDuAXhTDfVia9Vunkz4L7BthY0F8m0jo4//vs=;
 b=AypW1E6/0YKonUxuyLjfXnECx76XaunJ5bcRNY6IBaqway3JaopOC96TjwB58MoE/F
 YFTKpe42SXJwyynymGOC+zC5Ivq3aJigZNdBSQu33SNNkHCPGnetmOCPbphX85b1rfH3
 BwhTI+CG8Txmo4XkjTpFoRs5j2RA1FvxZZCNOXFJp4jbQeId+JRzS+/gkJBuIxin+dRo
 +fuSBXUGXp6Wy2SFNJPEL1b143/3NIi0QAJmtUdXcOV12DhtoVPJGjmrgwHjAidPi8o/
 tAIX10RB/EpezSkpJknHWVLrkISWUXIPaEvdS0ZK0IYnbe9AIku61slBax4ST8Z2pvXP
 lr2Q==
X-Gm-Message-State: AOAM5309KSDt2TmGG3AE5GRzpUV+mMS6XHB59WtIRAlA9/HhFdul/Daj
 GWfF6QmOAB40yYIEDN3rlMWUPSoqDvAI55MWa3Yemw==
X-Google-Smtp-Source: ABdhPJxy4K+2uRaBuhFTeTSlHPetqrP1uAAP7dKvm6UBZz10SCa23PJUxb54E5JJmlle9J/y892Qp+TTrKvO4GeNXIk=
X-Received: by 2002:a17:90a:ee87:: with SMTP id i7mr921476pjz.25.1603136546933; 
 Mon, 19 Oct 2020 12:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201017160928.12698-1-trix@redhat.com>
 <20201018054332.GB593954@kroah.com>
In-Reply-To: <20201018054332.GB593954@kroah.com>
Date: Mon, 19 Oct 2020 12:42:15 -0700
Message-ID: <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To: Tom Rix <trix@redhat.com>
Cc: alsa-devel@alsa-project.org,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 nouveau@lists.freedesktop.org, storagedev@microchip.com,
 dri-devel <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, keyrings@vger.kernel.org,
 linux-mtd@lists.infradead.org, ath10k@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, usb-storage@lists.one-eyed-alien.net,
 linux-watchdog@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-acpi@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, industrypack-devel@lists.sourceforge.net,
 linux-pci@vger.kernel.org, spice-devel@lists.freedesktop.org,
 MPT-FusionLinux.pdl@broadcom.com, linux-media@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-nfc@lists.01.org, linux-pm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-block@vger.kernel.org,
 linux-gpio@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-amlogic@lists.infradead.org, openipmi-developer@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-integrity@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-edac@vger.kernel.org,
 George Burgess <gbiv@google.com>, Network Development <netdev@vger.kernel.org>,
 linux-usb@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com,
 bpf <bpf@vger.kernel.org>, ocfs2-devel@oss.oracle.com,
 linux-power@fi.rohmeurope.com
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

On Sat, Oct 17, 2020 at 10:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> >
> > This is a upcoming change to clean up a new warning treewide.
> > I am wondering if the change could be one mega patch (see below) or
> > normal patch per file about 100 patches or somewhere half way by collecting
> > early acks.
>
> Please break it up into one-patch-per-subsystem, like normal, and get it
> merged that way.
>
> Sending us a patch, without even a diffstat to review, isn't going to
> get you very far...

Tom,
If you're able to automate this cleanup, I suggest checking in a
script that can be run on a directory.  Then for each subsystem you
can say in your commit "I ran scripts/fix_whatever.py on this subdir."
 Then others can help you drive the tree wide cleanup.  Then we can
enable -Wunreachable-code-break either by default, or W=2 right now
might be a good idea.

Ah, George (gbiv@, cc'ed), did an analysis recently of
`-Wunreachable-code-loop-increment`, `-Wunreachable-code-break`, and
`-Wunreachable-code-return` for Android userspace.  From the review:
```
Spoilers: of these, it seems useful to turn on
-Wunreachable-code-loop-increment and -Wunreachable-code-return by
default for Android
...
While these conventions about always having break arguably became
obsolete when we enabled -Wfallthrough, my sample turned up zero
potential bugs caught by this warning, and we'd need to put a lot of
effort into getting a clean tree. So this warning doesn't seem to be
worth it.
```
Looks like there's an order of magnitude of `-Wunreachable-code-break`
than the other two.

We probably should add all 3 to W=2 builds (wrapped in cc-option).
I've filed https://github.com/ClangBuiltLinux/linux/issues/1180 to
follow up on.
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
