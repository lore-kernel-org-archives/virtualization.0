Return-Path: <SRS0=EQvy=E7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AEEC2D0E4
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 00:32:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AA72151B
	for <virtualization@archiver.kernel.org>; Wed, 25 Nov 2020 00:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYdo15DH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AA72151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 166BC873E5;
	Wed, 25 Nov 2020 00:32:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4hkiKxPeudMI; Wed, 25 Nov 2020 00:32:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 76C2081E6B;
	Wed, 25 Nov 2020 00:32:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5724BC0891;
	Wed, 25 Nov 2020 00:32:32 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B47FFC0052;
 Wed, 25 Nov 2020 00:32:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A240E86985;
 Wed, 25 Nov 2020 00:32:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id spxAYxq40fhI; Wed, 25 Nov 2020 00:32:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CCC0E86739;
 Wed, 25 Nov 2020 00:32:29 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id y197so1358422qkb.7;
 Tue, 24 Nov 2020 16:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QqqubA90NyDjnD5SH+OxnZbso0TzlLiuZ5gzRUm0zsY=;
 b=DYdo15DH5n4eMCA51W2vXZfybVLPbTpwO6CR+j1CET94cx9FmUQEkAzz4OadVdmrht
 /5QscdfYh1sAKLvu6dkrheNjvEoR4Mdvvl3diWkBzFiGJNP9BCqxLhr4zTkKEaaVMxi5
 qUA6kNkUTJzI9KEPxIujLpbBVVOhJKSQSAf+FeTM6jY84RGcXl9jGks4AfD2ojo1GxQQ
 uEwHm9wuAxdOf70IRL+AXs8sujZOQd+kSEI1eU2QAsFia5W6QaIddZOITngYX9DSKM5R
 mNvBJUTqyzODtQONxErP8O8dRkCcVm25oDOfEuyrse782pSy0gFJjFFgzHOgMIi8mZem
 jSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QqqubA90NyDjnD5SH+OxnZbso0TzlLiuZ5gzRUm0zsY=;
 b=pt4NR/AkSGs/QBmJE92BMnrrtVdPgvPSb1rt0sF83LAPkXMyfeKcOu2Lw7Z6PCD+hU
 xLKdYDaFeSaO9sFcwa6t/9cwh6KN4x6u8Kc+hBxJ5n5Slm2r2WETBFsTa1qnAtAMR6Yy
 nFFbFEDqwBnkJffZaLUOrf8e0y8xOBskf/OLtO8QfMRfm8DAGs1MI6N2++WM6c/Ratys
 vZgNymJlGNGN3wpLe8unDLEBDr06qpxbut6lVBk3wIpV97rSIaUD3ko7BzyFvc0c7hAB
 z2m3vbhVM7V3nsZ5brlfQAa2Z2Phk+gUPXNfaNYcjVMM9/1yv0GEZb/Bw4Jr+OYmfgMh
 n83g==
X-Gm-Message-State: AOAM531QZ4jsN57IJDWp5JdyhTQIcXvPEWHbmc0SwCXyxs9vgmMX1C3I
 8eEtbRo45lPS5m3eVWqYufhy7tMRSCkMSGWtDAk=
X-Google-Smtp-Source: ABdhPJwwVKQFQuxzNO/2Mi/lJ3RUII3vPq9FIwhq+sZ6y3vyBbFPDKm/uCaEGwo9LU3j1fjBVCpYTO563lD14rGXSok=
X-Received: by 2002:a25:5f0f:: with SMTP id t15mr779915ybb.26.1606264348932;
 Tue, 24 Nov 2020 16:32:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org>
 <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
 <1c7d7fde126bc0acf825766de64bf2f9b888f216.camel@HansenPartnership.com>
 <CANiq72m22Jb5_+62NnwX8xds2iUdWDMAqD8PZw9cuxdHd95W0A@mail.gmail.com>
 <fc45750b6d0277c401015b7aa11e16cd15f32ab2.camel@HansenPartnership.com>
 <CANiq72k5tpDoDPmJ0ZWc1DGqm+81Gi-uEENAtvEs9v3SZcx6_Q@mail.gmail.com>
 <4993259d01a0064f8bb22770503490f9252f3659.camel@HansenPartnership.com>
In-Reply-To: <4993259d01a0064f8bb22770503490f9252f3659.camel@HansenPartnership.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 25 Nov 2020 01:32:17 +0100
Message-ID: <CANiq72kqO=bYMJnFS2uYRpgWATJ=uXxZuNUsTXT+3aLtrpnzvQ@mail.gmail.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: alsa-devel@alsa-project.org, linux-atm-general@lists.sourceforge.net,
 reiserfs-devel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-wireless <linux-wireless@vger.kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <natechancellor@gmail.com>, linux-ide@vger.kernel.org,
 dm-devel@redhat.com, keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 GR-everest-linux-l2@marvell.com, wcn36xx@lists.infradead.org,
 samba-technical@lists.samba.org, linux-i3c@lists.infradead.org,
 linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org,
 usb-storage@lists.one-eyed-alien.net, drbd-dev@lists.linbit.com,
 devel@driverdev.osuosl.org, linux-cifs@vger.kernel.org,
 rds-devel@oss.oracle.com, Nick Desaulniers <ndesaulniers@google.com>,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org,
 oss-drivers@netronome.com, bridge@lists.linux-foundation.org,
 linux-security-module@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com,
 linux-acpi@vger.kernel.org, coreteam@netfilter.org,
 intel-wired-lan@lists.osuosl.org, linux-input <linux-input@vger.kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 linux-geode@lists.infradead.org, linux-can@vger.kernel.org,
 linux-block@vger.kernel.org, linux-gpio@vger.kernel.org,
 op-tee@lists.trustedfirmware.org, linux-mediatek@lists.infradead.org,
 xen-devel@lists.xenproject.org, nouveau@lists.freedesktop.org,
 linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org,
 linux-watchdog@vger.kernel.org, linux-nfs@vger.kernel.org,
 GR-Linux-NIC-Dev@marvell.com, tipc-discussion@lists.sourceforge.net,
 Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>,
 linux-decnet-user@lists.sourceforge.net, linux-mmc@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 linux-renesas-soc@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-usb@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 patches@opensource.cirrus.com, Joe Perches <joe@perches.com>,
 linux-integrity@vger.kernel.org, target-devel@vger.kernel.org,
 linux-hardening@vger.kernel.org
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

On Mon, Nov 23, 2020 at 9:38 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> So you think a one line patch should take one minute to produce ... I
> really don't think that's grounded in reality.

No, I have not said that. Please don't put words in my mouth (again).

I have said *authoring* lines of *this* kind takes a minute per line.
Specifically: lines fixing the fallthrough warning mechanically and
repeatedly where the compiler tells you to, and doing so full-time for
a month.

For instance, take the following one from Gustavo. Are you really
saying it takes 12 minutes (your number) to write that `break;`?

diff --git a/drivers/gpu/drm/via/via_irq.c b/drivers/gpu/drm/via/via_irq.c
index 24cc445169e2..a3e0fb5b8671 100644
--- a/drivers/gpu/drm/via/via_irq.c
+++ b/drivers/gpu/drm/via/via_irq.c
@@ -364,6 +364,7 @@ int via_wait_irq(struct drm_device *dev, void
*data, struct drm_file *file_priv)
                irqwait->request.sequence +=
                        atomic_read(&cur_irq->irq_received);
                irqwait->request.type &= ~_DRM_VBLANK_RELATIVE;
+               break;
        case VIA_IRQ_ABSOLUTE:
                break;
        default:

>  I suppose a one line
> patch only takes a minute to merge with b4 if no-one reviews or tests
> it, but that's not really desirable.

I have not said that either. I said reviewing and merging those are
noise compared to any complex patch. Testing should be done by the
author comparing codegen.

> Part of what I'm trying to measure is the "and useful" bit because
> that's not a given.

It is useful since it makes intent clear. It also catches actual bugs,
which is even more valuable.

> Well, you know, subsystems are very different in terms of the amount of
> patches a maintainer has to process per release cycle of the kernel.
> If a maintainer is close to capacity, additional patches, however
> trivial, become a problem.  If a maintainer has spare cycles, trivial
> patches may look easy.

First of all, voluntary maintainers choose their own workload.
Furthermore, we already measure capacity in the `MAINTAINERS` file:
maintainers can state they can only handle a few patches. Finally, if
someone does not have time for a trivial patch, they are very unlikely
to have any time to review big ones.

> You seem to be saying that because you find it easy to merge trivial
> patches, everyone should.

Again, I have not said anything of the sort.

Cheers,
Miguel
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
