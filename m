Return-Path: <SRS0=Lrx6=QC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1B1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 14:25:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B145161B97
	for <virtualization@archiver.kernel.org>; Mon, 15 Nov 2021 14:24:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B145161B97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71D57605FC;
	Mon, 15 Nov 2021 14:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RMNKmo8XVUsn; Mon, 15 Nov 2021 14:24:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EAFFE60633;
	Mon, 15 Nov 2021 14:24:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 951C7C001E;
	Mon, 15 Nov 2021 14:24:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6737EC0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 14:24:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E843606BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 14:24:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q38Ed-U80dW0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 14:24:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ED2F3605FC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 14:24:53 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id b15so72406556edd.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 06:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:mail-followup-to:references
 :mime-version:content-disposition:in-reply-to;
 bh=XzW2ROAlPRz9ydv9L/AshSNhxbtWQbbcjLTS7Atescc=;
 b=jqY7XD2SmwV3T9FBCXsO0foOKIJt8O1+RCuaDdyjfa0As1sIs2dZbe7iyhw2GZXnNX
 eTdf11/29Tly1vIeVz9wOAo82uVZaUcTq59iK9BDv9EaQSfmSPqd2D2sW9xIJatoMnkf
 5eZqw7jyTM8ju/xQp+bpGviSfGYQzviLspbrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id
 :mail-followup-to:references:mime-version:content-disposition
 :in-reply-to;
 bh=XzW2ROAlPRz9ydv9L/AshSNhxbtWQbbcjLTS7Atescc=;
 b=fJPAlrDG+4RzC+2ck5K8IJoRrxNJ/mzudPLXrfV7+rBa7+rIt5Ej3ktZ8+JfmdM6JH
 Ew6rfBIHVYN/Xc4dEzTW5rxvc/FkO+4l+OTlP6yTG+uEXGHCi72bbci23ryOY15ZJHs+
 BoUqGDgGJiE+uPyToiUFLQ6663UJOr4b3zhM8B3k2IIQTZ59rhLzKyqj2oaESy1rgGxp
 22u6nczuYb2Nyzw6egNVHAWl3ZIh344xozNRml5cVLGCgaEyof2Tb9RV0S0RCgTR+Xtv
 qIWCxYlkzRfD2rTFUX3tsEAmPU/inSO2lomfLunIXhZQngwhKrnQbPmfK02s358zq+q4
 7vHw==
X-Gm-Message-State: AOAM532gkMzq/jRiXmwAGeh/8q2WFmodYde4NmGkuENqY2mj085seifL
 vmN3emNH/BjkPmttdaxZvfViQQ==
X-Google-Smtp-Source: ABdhPJw5ZxU4iCIzOsNPKcXBw6KrI77E95CzPk/ozBQVETPduv7gf3e6d9dDX1FVXIzpayyJ7jBTzg==
X-Received: by 2002:a05:6402:5158:: with SMTP id
 n24mr19430190edd.230.1636986292018; 
 Mon, 15 Nov 2021 06:24:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id l11sm7651319edb.28.2021.11.15.06.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Nov 2021 06:24:51 -0800 (PST)
Date: Mon, 15 Nov 2021 15:24:49 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: regression with mainline kernel
Message-ID: <YZJtsV15k6mrBt1f@phenom.ffwll.local>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Nicholas Verne <nverne@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
References: <CADVatmOuOk6RoZF=M9sZm2L=9NuDDsSNNCJJbAtkgScG0og1Ww@mail.gmail.com>
 <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
 <CAADWXX80QGk7MwZ7A-n+1+GHv=yrA0qrw-70Z=pFSEsc3UXfgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAADWXX80QGk7MwZ7A-n+1+GHv=yrA0qrw-70Z=pFSEsc3UXfgQ@mail.gmail.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Nicholas Verne <nverne@chromium.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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

On Sat, Nov 13, 2021 at 09:06:57AM -0800, Linus Torvalds wrote:
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

Greg also reported a regression, plus I looked at the commit and had
questions too.

> > And, indeed reverting cd7f5ca33585 on top of debe436e77c7 has fixed
> > the problem I was seeing on my qemu test of x86_64. The qemu image is
> > based on Ubuntu.
> 
> Presumably either that commit is somehow buggy in itself - or it does
> exactly what it means to do, and the new poll() semantics just
> confuses the heck out of the X server (or wayland or whatever).
> 
> And honestly, if I read that thing correctly, the patch is entirely
> broken. The new poll function (virtio_gpu_poll()) will unconditionally
> remove the first event from the event list, and then report "Yeah, I
> had events".
> 
> This is completely bogus for a few reasons:
> 
>  - poll() really should be idempotent, because the poll function gets
> called multiple times
> 
>  - it doesn't even seem to check that the event that it removes is the
> new VIRTGPU_EVENT_FENCE_SIGNALED_INTERNAL kind of event, so it will
> unconditionally just remove random events.
> 
>  - it does seem to check the "vfpriv->ring_idx_mask" and do the old
> thing if that is zero, but I see absolutely no reason for that (and
> that check itself has caused problems, see below)
> 
> Honestly, my reaction to this all is that that commit is fundamentally
> broken and probably should be reverted regardless as "this commit does
> bad things".
> 
> HOWEVER - it has had a fix for a NULL pointer dereference in the
> meantime - can you check whether the current top of tree happens to
> work for you? Maybe your problem isn't due to "that commit does
> unnatural things", but simply due to the bug fixed in d89c0c8322ec
> ("drm/virtio: Fix NULL dereference error in virtio_gpu_poll").
> 
> And if it's still broken with that commit, I'll happily revert it and
> people need to go back to the drawing board.
> 
> In fact, I would really suggest that people look at that
> virtio_gpu_poll() function regardless. That odd "let's unconditionally
> just drop events in the poll function is really REALLY broken
> behavior.

Tbh I haven't looked at the poll implementation, but it's fishy on
principles as in drm drivers shouldn't reinvent them. The commit message
cites vmwgfx as example for a private driver drm_event, but that works
perfectly fine with standard drm_poll (and is meant to work perfectly fine
with standard drm_poll).

So if it's buggy on top of questionable I think revert might be the right
choice irrespective of whether there's some fixes in-flight.

So if you end up pushing that revert:

References: https://lore.kernel.org/dri-devel/YZJrutLaiwozLfSw@phenom.ffwll.local/
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Plus credit Greg too and all that ofc.

But lets wait a bit for virtio folks to chime in, it's only Monday :-)

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
