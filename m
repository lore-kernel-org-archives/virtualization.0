Return-Path: <SRS0=Fazc=QA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90609C433EF
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 17:07:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E55F60F6B
	for <virtualization@archiver.kernel.org>; Sat, 13 Nov 2021 17:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2E55F60F6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EE83F40282;
	Sat, 13 Nov 2021 17:07:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LE-hGh3iMQ15; Sat, 13 Nov 2021 17:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4E57A40281;
	Sat, 13 Nov 2021 17:07:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30C92C002E;
	Sat, 13 Nov 2021 17:07:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2713FC0012
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 17:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0218D605AD
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 17:07:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linux-foundation.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id njmSnRuFqZem
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 17:07:10 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E3441605AB
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 17:07:09 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id e3so14856552edu.4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 Nov 2021 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nRHTN+KJ/0jakG/3S1m86FduFSvoZNR/waj5CoABhhY=;
 b=AI5EgBuhXv3ifPQ/QJGAcgXo9vjiG/by8UhhOa7KCZNrvEzzpepwyfZxQwC1UOwsTg
 3NZXmVOf8DUa+Rt2QZOWgxDJuoswYf8qCtbhrV+XAj0eYtpUMzeJaj3aEp1I532no0eE
 8qsaWz4Ud04P5QaZPk1SnPlYrcPiAhAz2LsOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nRHTN+KJ/0jakG/3S1m86FduFSvoZNR/waj5CoABhhY=;
 b=1piweKvafqaya8388l1i5bvXzNDAvCtn5I8hMiq/SxnhuttHWpDk6mABaX6vX8IKqG
 CPzUpX+f5Uh0FBM2VrTXXrhpVbzUfFrcRJWg28Oj9twHOQc1E2DCHJddsEbWtLkk3i8m
 e6bdNgvBb+LH0xKBqR0YyYmh1FowyrAD/9CaPKWCCwtudZHI6wtPCkj+hL4CDa992TrD
 zMOpJiTFlMdF7Ka/Yt+yxIWqNEEPQXpwuz0L2XBqsXxzfAZgUpBmlU0J/1/JbA0SA7IV
 JLcatX0YKM68btIcPndWSHhoSBtYpMS0I7whsoO9LjVyAJqrdMrQ5EQJXe3uMwq7lz7C
 m6wQ==
X-Gm-Message-State: AOAM5334b23n6GZgyNguSO5HPwZ7nq/qd0MV5Hze0EFYaV+fVYuPXS3K
 bIhmU3FJulLwVwUg0Ssnz5knjSw/y6CC5LjdJYBGhkbN
X-Google-Smtp-Source: ABdhPJwGP1iH54aBaYVC33bjqbgQctUZp4Pi4rXKBOfxyi1+bPS5kw2APZGmPTqMUBDICCtmS9pO8y+RNk0rZrzATh4=
X-Received: by 2002:a05:6402:5146:: with SMTP id
 n6mr24252309edd.126.1636823228182; 
 Sat, 13 Nov 2021 09:07:08 -0800 (PST)
MIME-Version: 1.0
References: <CADVatmOuOk6RoZF=M9sZm2L=9NuDDsSNNCJJbAtkgScG0og1Ww@mail.gmail.com>
 <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
In-Reply-To: <CADVatmP_Sn+SS5Yu5+7sJJ5SVpcaZcW8Z_Bj5vmYz9g3kJD86g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 13 Nov 2021 09:06:57 -0800
Message-ID: <CAADWXX80QGk7MwZ7A-n+1+GHv=yrA0qrw-70Z=pFSEsc3UXfgQ@mail.gmail.com>
Subject: Re: regression with mainline kernel
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
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

[ Hmm. This email was marked as spam for me. I see no obvious reason
for it being marked as spam, but it happens.. ]

On Thu, Nov 11, 2021 at 12:52 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> # first bad commit: [cd7f5ca33585918febe5e2f6dc090a21cfa775b0]
> drm/virtio: implement context init: add virtio_gpu_fence_event

Hmm. Judging from your automated screenshots, the login never appears.

> And, indeed reverting cd7f5ca33585 on top of debe436e77c7 has fixed
> the problem I was seeing on my qemu test of x86_64. The qemu image is
> based on Ubuntu.

Presumably either that commit is somehow buggy in itself - or it does
exactly what it means to do, and the new poll() semantics just
confuses the heck out of the X server (or wayland or whatever).

And honestly, if I read that thing correctly, the patch is entirely
broken. The new poll function (virtio_gpu_poll()) will unconditionally
remove the first event from the event list, and then report "Yeah, I
had events".

This is completely bogus for a few reasons:

 - poll() really should be idempotent, because the poll function gets
called multiple times

 - it doesn't even seem to check that the event that it removes is the
new VIRTGPU_EVENT_FENCE_SIGNALED_INTERNAL kind of event, so it will
unconditionally just remove random events.

 - it does seem to check the "vfpriv->ring_idx_mask" and do the old
thing if that is zero, but I see absolutely no reason for that (and
that check itself has caused problems, see below)

Honestly, my reaction to this all is that that commit is fundamentally
broken and probably should be reverted regardless as "this commit does
bad things".

HOWEVER - it has had a fix for a NULL pointer dereference in the
meantime - can you check whether the current top of tree happens to
work for you? Maybe your problem isn't due to "that commit does
unnatural things", but simply due to the bug fixed in d89c0c8322ec
("drm/virtio: Fix NULL dereference error in virtio_gpu_poll").

And if it's still broken with that commit, I'll happily revert it and
people need to go back to the drawing board.

In fact, I would really suggest that people look at that
virtio_gpu_poll() function regardless. That odd "let's unconditionally
just drop events in the poll function is really REALLY broken
behavior.

              Linus
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
