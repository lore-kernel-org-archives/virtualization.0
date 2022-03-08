Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAF5C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 22:24:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3387260D96;
	Tue,  8 Mar 2022 22:24:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x_lHCttDJY_5; Tue,  8 Mar 2022 22:24:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 914DB60BDB;
	Tue,  8 Mar 2022 22:23:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70F2EC001D;
	Tue,  8 Mar 2022 22:23:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2C08C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 22:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DAB0C40353
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 22:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R26OOfhV0w4U
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 22:23:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6635A4032A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 22:23:56 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id e24so251298wrc.10
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Mar 2022 14:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=VLNTenH17gTL++hzFtoUTNEHN+pSYqZsQ93MYsewbsE=;
 b=B+Y+aj0Kp1KcmHD1TJUXHwyix6ApB1/FqwmXZGhx1wcc4TAOmxh9gxTlBgAGamLqPE
 vpKcowdhEgZzk2U98r53D5Hy1Scrw6xH8PQcSydekPlZ5HI3qiA9pxOFbKVYi/9OQf1Z
 2z+/4YhPKMZ9oKQH20k7HP91wcJX8Isk8gqkO9jES0i3L0GPwD3p1LcGOB9U6h/BRgsQ
 8084feHyzqqtSFPTbppFkm13Ecg1wAy6AkYXNngnc+JaHTQVPUGmgGjdIb5GLtIM4Q/G
 bFqhl4gpP3fujkTcmelxXGFmAibfXsgFjzDNGvuS4OkzK2lYWp6unZQFj+/yXcyvAvNf
 Zjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VLNTenH17gTL++hzFtoUTNEHN+pSYqZsQ93MYsewbsE=;
 b=lYV6c3U6DyOVvu1h+ipJPGETcMX6ijgHuIBvIgFrOvLae2A9XuCB0GFlPH1epuMlh9
 rK59BNkbucQ9CiteIiAKF8o+FZt6vb54N+4Ws758wEG+VPSLtPD4neGnkYTqjjNVpGiw
 Zg20GFHUrH1RDoEIk6Tn1CjAJsF2Hm4DRFq2WzBl5ZZvVLdXRehwIz+zxm2Uod/NFmNa
 1lCWFTiq0pMwgwn31fm3ole3YvXgl29cv1b4nFhJ3X/k0R7gHwcy7WXtroj78BzPmKbz
 RgPYXFQOw/TWlwMwqt9OkWYxiSDKnHLGda/1tC/kdeeqjezCuSg1PJJsfdPcGV89QdXB
 WCVQ==
X-Gm-Message-State: AOAM530QY9vQHQA4/J/ygA7GiUxs5rqFcXl5Qs8CD6pjA6mUniUQ7PaD
 sP66X/VOa5yYMSxWWWiUxH4hT0/Yp+Cc8xlM3rg=
X-Google-Smtp-Source: ABdhPJyGuPzIrRNVs2k9a2b1qGUaqAliN4KUm5RnUtzkOdj1rRLWp/R6GjNYrs64hWACoBMY67pIWSlhNB+JjFA13n4=
X-Received: by 2002:a05:6000:15c5:b0:1f1:e64d:e4c3 with SMTP id
 y5-20020a05600015c500b001f1e64de4c3mr11545524wry.328.1646778234465; Tue, 08
 Mar 2022 14:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20220308131725.60607-1-dmitry.osipenko@collabora.com>
 <CAF6AEGt=aVJ9nR+Wv+bJEFZrn-cNOSNXG1TaJr=Cx-FTgutwKA@mail.gmail.com>
 <d2290971-ea22-8203-631e-b896c76a994b@collabora.com>
In-Reply-To: <d2290971-ea22-8203-631e-b896c76a994b@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 8 Mar 2022 14:24:22 -0800
Message-ID: <CAF6AEGuR8B6z+z=VFQ6y01wbboYS_qpkghD1GYdLES_RZOW1wA@mail.gmail.com>
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

On Tue, Mar 8, 2022 at 11:28 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 3/8/22 19:29, Rob Clark wrote:
> > On Tue, Mar 8, 2022 at 5:17 AM Dmitry Osipenko
> > <dmitry.osipenko@collabora.com> wrote:
> >>
> >> Hello,
> >>
> >> This patchset introduces memory shrinker for the VirtIO-GPU DRM driver.
> >> During OOM, the shrinker will release BOs that are marked as "not needed"
> >> by userspace using the new madvise IOCTL. The userspace in this case is
> >> the Mesa VirGL driver, it will mark the cached BOs as "not needed",
> >> allowing kernel driver to release memory of the cached shmem BOs on lowmem
> >> situations, preventing OOM kills.
> >
> > Will host memory pressure already trigger shrinker in guest?
>
> The host memory pressure won't trigger shrinker in guest here. This
> series will help only with the memory pressure within the guest using a
> usual "virgl context".
>
> Having a host shrinker in a case of "virgl contexts" should be a
> difficult problem to solve.

Hmm, I think we just need the balloon driver to trigger the shrinker
in the guest kernel?  I suppose a driver like drm/virtio might want to
differentiate between host and guest pressure (ie. consider only
objects that have host vs guest storage), but even without that,
freeing up memory in the guest when host is under memory pressure
seems worthwhile.  Maybe I'm over-simplifying?

> > This is
> > something I'm quite interested in for "virtgpu native contexts" (ie.
> > native guest driver with new context type sitting on top of virtgpu),
>
> In a case of "native contexts" it should be doable, at least I can't see
> any obvious problems. The madvise invocations could be passed to the
> host using a new virtio-gpu command by the guest's madvise IOCTL
> handler, instead-of/in-addition-to handling madvise in the guest's
> kernel, and that's it.

I think we don't want to do that, because MADV:WILLNEED would be by
far the most frequent guest<->host synchronous round trip.  So from
that perspective tracking madvise state in guest kernel seems quite
attractive.

If we really can't track madvise state in the guest for dealing with
host memory pressure, I think the better option is to introduce
MADV:WILLNEED_REPLACE, ie. something to tell the host kernel that the
buffer is needed but the previous contents are not (as long as the GPU
VA remains the same).  With this the host could allocate new pages if
needed, and the guest would not need to wait for a reply from host.

> > since that isn't using host storage
>
> s/host/guest ?

Yes, sorry, I meant that it is not using guest storage.

BR,
-R
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
