Return-Path: <SRS0=Fazc=QA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA64C433EF
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 21:35:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4019460E90
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 21:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4019460E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EDD6B402BF;
	Sat, 13 Nov 2021 21:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1bRZSjws2ih; Sat, 13 Nov 2021 21:35:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9477E402A8;
	Sat, 13 Nov 2021 21:35:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F9C5C002E;
	Sat, 13 Nov 2021 21:35:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ED67C0012
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 21:35:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 49656402AA
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 21:35:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6IVFkljWD2Qr
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 21:35:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60662402A8
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 21:35:30 +0000 (UTC)
Received: by mail-yb1-xb31.google.com with SMTP id g17so33974842ybe.13
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 13:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mSXJ3uMUoVuuhGKC/oVSm8bEZNFwZL8IbH9GMbqinz8=;
 b=dkaTRJTRIi4ZifpY9ICa/j7nErEweW4HufoKRtFVlWbkDqfE4ttOCtu7D5UAdvMdgM
 PWs9pViYlrbvAtah2pdcHABvOMfIs0sZlVgdDFdbzbzPz2qxb5Zc5BAnRhtc2vU8s2u4
 f96KLpJKEmp/G/mmEkgTXD+UJ8eZ7EO9ENCU8FuPCqr0uhYFEf59rUGKutg4J8bXgU0V
 fkW4Tdf4cC2QgTk941IQoGtpRpl2n+7AXMqSRU1jm6y8Or5cHZ+XM4AK6Y9OW6xlu57r
 4yTL12Ous6bHQraMdkCLQTtwlIRAY7mxzuOlGD00jNimEmG7l3bwEIUnk1bDoAA8R86T
 xFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mSXJ3uMUoVuuhGKC/oVSm8bEZNFwZL8IbH9GMbqinz8=;
 b=YOXZIaQMkS7RoqWEeXRg+76HNRM+qXsC07cljKcSph6On58ObUdZjXQyNvwW+MsOUt
 ZVRZYC0zrX4ZDgs7mXm9ZXVchGUM9uRk/K7IUfiIl90COLCmi9bbRt7NLzRpUoNEp9cH
 4oyoOxG9j4IpeAZ3rRuU56gMX+JmT8gNBYfxkz4/SETe86A/h40GJT2OdEevabIQSpUp
 WrYn48NoOJfRn8ID9P1Yf0+oY3P7OZf0Ndedo8JyA7C+UUF60ijV8ch+fNRuuEKfR8ef
 NHuTFuBwsyxDL0Hy1Noy+MOuc+W0qcW2xQ+bjTopSwHnjfPIkU2zvb0t251uiauspXeb
 EM5g==
X-Gm-Message-State: AOAM530uiUHw9CQtjdhj7qDPTYLTFlOut8nhMtDWpEXgAkoj0Be8reLC
 qGpl45+/2BZxidmOaT+NZB/7OTmanzODEY2jh2s=
X-Google-Smtp-Source: ABdhPJxiyniWoK2HoBAw4yOk/7IK6gECxvBOuNXSV39rmBpeaxcPXsgNhCEjQ1hAuKN5hNQecWTsHtNVolyHlBLYX3w=
X-Received: by 2002:a25:488:: with SMTP id 130mr27073299ybe.346.1636839329289; 
 Sat, 13 Nov 2021 13:35:29 -0800 (PST)
MIME-Version: 1.0
References: <CADVatmOuOk6RoZF=M9sZm2L=9NuDDsSNNCJJbAtkgScG0og1Ww@mail.gmail.com>
 <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
 <CAADWXX80QGk7MwZ7A-n+1+GHv=yrA0qrw-70Z=pFSEsc3UXfgQ@mail.gmail.com>
In-Reply-To: <CAADWXX80QGk7MwZ7A-n+1+GHv=yrA0qrw-70Z=pFSEsc3UXfgQ@mail.gmail.com>
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Sat, 13 Nov 2021 21:34:53 +0000
Message-ID: <CADVatmN7rQYhWJQao3qXz7TZxz5piN+kN4g4tV_wYC4=uxtgtA@mail.gmail.com>
Subject: Re: regression with mainline kernel
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Nicholas Verne <nverne@chromium.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>
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

Hi Linus,

On Sat, Nov 13, 2021 at 5:07 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ Hmm. This email was marked as spam for me. I see no obvious reason
> for it being marked as spam, but it happens.. ]
>
> On Thu, Nov 11, 2021 at 12:52 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > # first bad commit: [cd7f5ca33585918febe5e2f6dc090a21cfa775b0]
> > drm/virtio: implement context init: add virtio_gpu_fence_event
>
> Hmm. Judging from your automated screenshots, the login never appears.
>

<snip>

>
> HOWEVER - it has had a fix for a NULL pointer dereference in the
> meantime - can you check whether the current top of tree happens to
> work for you? Maybe your problem isn't due to "that commit does
> unnatural things", but simply due to the bug fixed in d89c0c8322ec
> ("drm/virtio: Fix NULL dereference error in virtio_gpu_poll").
>
> And if it's still broken with that commit, I'll happily revert it and
> people need to go back to the drawing board.

I sent another mail yesterday which is now at
https://lore.kernel.org/lkml/CADVatmOOzCxAgLhCu1tTz=44sgRDXds5-oMZ3V0w4f5kLCLKrw@mail.gmail.com/
I will just pase that here for you.

Last night's test on 66f4beaa6c1d worked fine. So I guess this has now
been fixed.

I have not done a bisect to see what has fixed it, but looking at the
log I think it will be that NULL pointer fix.


-- 
Regards
Sudip
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
