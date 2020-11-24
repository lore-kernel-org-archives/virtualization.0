Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73449C2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 21:25:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2B920857
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 21:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oKmDT/E0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE2B920857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBE5286549;
	Tue, 24 Nov 2020 21:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QyOhZsR0pDcA; Tue, 24 Nov 2020 21:25:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 80699864C4;
	Tue, 24 Nov 2020 21:25:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A44DC163C;
	Tue, 24 Nov 2020 21:25:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4032EC1833
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:25:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2216587337
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:25:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8jIpvdvtBDSV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:25:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com
 [209.85.215.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 288CC87335
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 21:25:44 +0000 (UTC)
Received: by mail-pg1-f196.google.com with SMTP id t21so365708pgl.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 13:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Hc7xHQdcWqcI1RL6yWHK3qM7+D3PcB+9wJ1f+Y4kOZ8=;
 b=oKmDT/E0BiqfYtxGd9S8VgvaixpTRLnYMRrsUV9kaRuJo3R/5oNlOHAboaJA72rvz5
 cPy+dYNpKpp/tW1abpWiBH/rmtZxXE/MLGj7m5uMt/n+RU1YTE1Rw6QIxNLzAajuHLbW
 OV/WWZm28UqOigi5ggHh0BMVZishCwQGNb1Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Hc7xHQdcWqcI1RL6yWHK3qM7+D3PcB+9wJ1f+Y4kOZ8=;
 b=f1x44WHNeTFO1NglWyUvcnj0RF1STSb5b7OWXR3dwasiQ3JY/ecKZ2YNYPWC7f7Pxp
 HM1nSLVUPuMsh5Dgvg6kcllZivZ70VLjE2fJoBAJRhB0pjWGnf3GU9XWxasVZDaCQWjB
 hYlrdkzi2KnftXPiue7XioOF0lyDZbwfRR+bPOZeTxC8ftlnR7lEr/yPYtzVz9XZ9WEk
 HNWFte6UMpxDUiCQiak2YUb6Po2dlBL07UyF1dydCwd27VAojJW7b4xJQqFNmPuVryBT
 VUZqlo28BruGtv0Lz0lTAHEQSFpF4Ln9KTawGbVou+Dg3Nzdr1pDwq6vB9h4d655ar2h
 bjZA==
X-Gm-Message-State: AOAM533plxCvbgrmhlzW+Z0LJ6yjgNqg6c2Ow3itO+YAJ9y2lJgvPSrv
 d3W6qUyZ+pM1qiW5unJGawXj0g==
X-Google-Smtp-Source: ABdhPJwtm7ki1o3tlMghBzBMLVUzEcZQN+PDIoPgB8WI7uCPSXlOMvf7LiH3SXaewZBRcFltugq6wg==
X-Received: by 2002:a17:90b:3505:: with SMTP id
 ls5mr176054pjb.55.1606253143764; 
 Tue, 24 Nov 2020 13:25:43 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id z68sm129381pgb.37.2020.11.24.13.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2020 13:25:41 -0800 (PST)
Date: Tue, 24 Nov 2020 13:25:40 -0800
From: Kees Cook <keescook@chromium.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
Message-ID: <202011241324.B3439A2@keescook>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKwvOdntVfXj2WRR5n6Kw7BfG7FdKpTeHeh5nPu5AzwVMhOHTg@mail.gmail.com>
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net,
 reiserfs-devel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless <linux-wireless@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linux-ide@vger.kernel.org,
 dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org,
 samba-technical@lists.samba.org, linux-i3c@lists.infradead.org,
 linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org,
 usb-storage@lists.one-eyed-alien.net, drbd-dev@lists.linbit.com,
 devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-scsi@vger.kernel.org,
 linux-rdma@vger.kernel.org, oss-drivers@netronome.com,
 bridge@lists.linux-foundation.org, linux-security-module@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com,
 linux-acpi@vger.kernel.org, coreteam@netfilter.org,
 intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 linux-ext4@vger.kernel.org, linux-media@vger.kernel.org,
 linux-watchdog@vger.kernel.org, selinux@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, intel-gfx@lists.freedesktop.org,
 linux-geode@lists.infradead.org, linux-can@vger.kernel.org,
 linux-block@vger.kernel.org, linux-gpio@vger.kernel.org,
 op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org,
 xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org,
 linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 linux-nfs@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com,
 tipc-discussion@lists.sourceforge.net,
 Linux Memory Management List <linux-mm@kvack.org>,
 Network Development <netdev@vger.kernel.org>,
 linux-decnet-user@lists.sourceforge.net, linux-mmc@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>, linux-sctp@vger.kernel.org,
 linux-usb@vger.kernel.org, netfilter-devel@vger.kernel.org,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com,
 Joe Perches <joe@perches.com>, linux-integrity@vger.kernel.org,
 target-devel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Mon, Nov 23, 2020 at 05:32:51PM -0800, Nick Desaulniers wrote:
> On Sun, Nov 22, 2020 at 8:17 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Nov 20, 2020 at 11:51:42AM -0800, Jakub Kicinski wrote:
> > > If none of the 140 patches here fix a real bug, and there is no change
> > > to machine code then it sounds to me like a W=2 kind of a warning.
> >
> > FWIW, this series has found at least one bug so far:
> > https://lore.kernel.org/lkml/CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com/
> 
> So looks like the bulk of these are:
> switch (x) {
>   case 0:
>     ++x;
>   default:
>     break;
> }
> 
> I have a patch that fixes those up for clang:
> https://reviews.llvm.org/D91895

I still think this isn't right -- it's a case statement that runs off
the end without an explicit flow control determination. I think Clang is
right to warn for these, and GCC should also warn.

-- 
Kees Cook
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
