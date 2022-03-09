Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934F3C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 21:51:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 242D060FAA;
	Wed,  9 Mar 2022 21:51:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eoHASPhOYECV; Wed,  9 Mar 2022 21:51:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5431B60ACB;
	Wed,  9 Mar 2022 21:51:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38786C0012;
	Wed,  9 Mar 2022 21:51:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 409C7C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 21:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2F7528431C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 21:51:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p1Ab-cQBxFSc
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 21:51:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 445678431B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 21:51:05 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id x15so5026173wru.13
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 13:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wB+NOcZPjuBQ7I++42cwqpD+y9hE+iVjMiQbLppxTXQ=;
 b=S5ziUcSwcWcbqql4ryBgFaU9gKpCBE1RLKnQP7DR/A/4pJO6wUAXSOpyOC/PimqW0K
 enPHbFGVz/35MIg78/PK2T2OmkRBZlHkZvRYSg31B27Ojy6Ymwd7fNI8qSHlnt75iSVX
 UzwdOpu2dZf0hwZ4B9nww9hl9WhRfSTUI35DLGd0M9FKMZKdlpVsVn4yPoxhx+DAiqkm
 NSylcRRoIzknJ19apuqe5z+3Z1yNmpa0sIlQBa5ZBFZjdmun0ZFn9enrkE9px7gNyuSR
 9sEAsMuA2MFx4TFTw0bsjNEJRtihF96nvJDmKiSuS83NE1nUoynqmTX/VcJAh8K/tiTO
 15mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wB+NOcZPjuBQ7I++42cwqpD+y9hE+iVjMiQbLppxTXQ=;
 b=sEXzEodb5izay4KE0qVSAIPsNAn1Z0t5x7cCZVSeA5ZYcIp91UFV8QKxme6rKXEBLZ
 cbd9T1cOAL4QUJM2BndJNayf/H5ZlE/F8SDDvSdwnt3Q2EoynLJB3522KPkwAjaq2TfQ
 3maTk4N+CtryKqdwRbTlu5YP1mVzuMoVI2029glq/a4Za9Cv6T2LSARTL9Y40vqitutN
 ySrJKJYAF5+pcOZygI0H4YaQ7DBZQGhYcazl78Abfb3ICYspLa45V1V00f68iUOQj98N
 +3D9+BPUrVKa4sSDzr6zWRvVURhD2EguhNzDXXVEDfR8s1P1VC0MFyThY11M6AFAdreX
 DCbA==
X-Gm-Message-State: AOAM533hgjFnpYr+jBjZ7be617v0lOU22XwFLRVGm097aNB8nMDdAfsv
 6A3Yk3a3InYfYeeoEK+A/FF43K/fkdp5vjtRdHxRdmsL
X-Google-Smtp-Source: ABdhPJz2ayymHz8VybPKo5wyBEMKvIoEykqiV82sROIEpsyQSqwGfjcsaesHGo/FmmgPPT5CBmcho8SDwODf8kuYNoU=
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id
 j73-20020adf914f000000b001edbb92d0ccmr1224465wrj.297.1646862663329; Wed, 09
 Mar 2022 13:51:03 -0800 (PST)
MIME-Version: 1.0
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <CAF6AEGt=aVJ9nR+Wv+bJEFZrn-cNOSNXG1TaJr=Cx-FTgutwKA@mail.gmail.com>
 <d2290971-ea22-8203-631e-b896c76a994b@collabora.com>
 <CAF6AEGuR8B6z+z=VFQ6y01wbboYS_qpkghD1GYdLES_RZOW1wA@mail.gmail.com>
 <42facae5-8f2c-9c1f-5144-4ebb99c798bd@collabora.com>
 <CAF6AEGtebAbWhkvrxzi4UBLdv2LJPQVPBzH-sXcACs7cxznQ8A@mail.gmail.com>
 <05e1fe61-1c29-152f-414b-cd6a44525af0@collabora.com>
In-Reply-To: <05e1fe61-1c29-152f-414b-cd6a44525af0@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 9 Mar 2022 13:51:42 -0800
Message-ID: <CAF6AEGvf81epGOs7Zh4WK-7mkXRApO2p-h4g8dTuk4xtc1HOeg@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add memory shrinker to VirtIO-GPU DRM driver
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Rob Clark <robdclark@chromium.org>, Gert Wollny <gert.wollny@collabora.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Osipenko <digetx@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

On Wed, Mar 9, 2022 at 12:06 PM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 3/9/22 03:56, Rob Clark wrote:
> >> If we really can't track madvise state in the guest for dealing with
> >> host memory pressure, I think the better option is to introduce
> >> MADV:WILLNEED_REPLACE, ie. something to tell the host kernel that the
> >> buffer is needed but the previous contents are not (as long as the GPU
> >> VA remains the same).  With this the host could allocate new pages if
> >> needed, and the guest would not need to wait for a reply from host.
> > If variant with the memory ballooning will work, then it will be
> > possible to track the state within guest-only. Let's consider the
> > simplest variant for now.
> >
> > I'll try to implement the balloon driver support in the v2 and will get
> > back to you.
> >
>
> I looked at the generic balloon driver and looks like this not what we
> want because:
>
> 1. Memory ballooning is primarily about handling memory overcommit
> situations. I.e. when there are multiple VMs consuming more memory than
> available in the system. Ballooning allows host to ask guest to give
> unused pages back to host and host could give pages to other VMs.
>
> 2. Memory ballooning operates with guest memory pages only. I.e. each
> ballooned page is reported to/from host in a form of page's DMA address.
>
> 3. There is no direct connection between host's OOM events and the
> balloon manager. I guess host could watch system's memory pressure and
> inflate VMs' balloons on low memory, releasing the guest's memory to the
> system, but apparently this use-case not supported by anyone today, at
> least I don't see Qemu supporting it.
>

hmm, on CrOS I do see balloon getting used to balance host vs guest
memory.. but admittedly I've not yet looked closely at how that works,
and it does seem like we have some things that are not yet upstream
all over the place (not to mention crosvm vs qemu)

>
> So the virtio-balloon driver isn't very useful for us as-is.
>
> One possible solution could be to create something like a new
> virtio-shrinker device or add shrinker functionality to the virtio-gpu
> device, allowing host to ask guests to drop shared caches. Host then
> should become a PSI handler. I think this should be doable in a case of
> crosvm. In a case of GNU world, it could take a lot of effort to get
> everything to upstreamable state, at first there is a need to
> demonstrate real problem being solved by this solution.

I guess with 4GB chromebooks running one or more VMs in addition to
lots of browser tabs in the host, it shouldn't be too hard to
demonstrate a problem ;-)

(but also, however we end up solving that, certainly shouldn't block
this series)

> The other minor issue is that only integrated GPUs may use system's
> memory and even then they could use a dedicated memory carveout, i.e.
> releasing VRAM BOs may not help with host's OOM. In case of virgl
> context we have no clue about where buffers are physically located. On
> the other hand, in the worst case dropping host caches just won't help
> with OOM.

Userspace should know whether the BO has CPU storage, so I don't think
this should be a problem virtio_gpu needs to worry about

> It's now unclear how we should proceed with the host-side shrinker
> support. Thoughts?
>
> We may start easy and instead of thinking about host-side shrinker, we
> could make VirtIO-GPU driver to expire cached BOs after a certain
> timeout. Mesa already uses timeout-based BO caching, but it doesn't have
> an alarm timer and simply checks expiration when BO is allocated. Should
> be too much trouble to handle timers within Mesa since it's executed in
> application context, easier to do it in kernel, like VC4 driver does it
> for example. This is not good as a proper memory shrinker, but could be
> good enough in practice.

I think that, given virgl uses host storage, guest shrinker should be
still useful.. so I think continue with this series.

For host shrinker, I'll have to look more at when crosvm triggers
balloon inflation.  I could still go the MADV:WILLNEED_REPLACE
approach instead, which does have the advantage of host kernel not
relying on host userspace or vm having a chance to run in order to
release pages.  The downside (perhaps?) is it would be more specific
to virtgpu-native-context and less so to virgl or venus (but I guess
there doesn't currently exist a way for madvise to be useful for vk
drivers).

BR,
-R
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
