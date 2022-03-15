Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D788CC433FE
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 12:47:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6764E416CE;
	Tue, 15 Mar 2022 12:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bOg26I4FyGyo; Tue, 15 Mar 2022 12:47:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EC5841691;
	Tue, 15 Mar 2022 12:47:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B4F3C001A;
	Tue, 15 Mar 2022 12:47:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9848C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7D72840327
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gkm1ukb1HMvK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:47:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B40F4400C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:47:35 +0000 (UTC)
Received: by mail-qt1-x82a.google.com with SMTP id i8so3750133qtx.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 05:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B7pEXwFzgo4rOox6nVDFmgxOXeOCcTVTTlTiwKE1qAQ=;
 b=AxLlzrZFFinx3v3qxcSJwG8kMMDCTJfPy3a238z9DU+++nlTT8+pv9T22v9CjOFgk/
 nRzcbWMhrqTTrxDXGG364svExwF4vANPV/0VH4H0bh8g2/lDL1iJo7fm2ZUEbzLICyh3
 Us6w9epVMrwVwDxq22P94dmbZtRRhL4Kz0dwGa2ChzZ2skWq4YyOFJzEimcpWT2mpB42
 /eLjmoDlK/7nRK6COKRe/x7eAZH5CHk9Uk6MVZZumeyZafQjFa6oNWzJDiG4JPQhre8q
 uWqEfO0TLPI5RMdyfaRxz3rCbG+gq/dcfiZZSVAmMLznCkZFUcOxmvn2KwgQvIU+2P1m
 LRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B7pEXwFzgo4rOox6nVDFmgxOXeOCcTVTTlTiwKE1qAQ=;
 b=L3TgyFsJCGpOsfl+7moOK2RaHe+F1A8fG+Sz6HRgO5/nmdFMPaENZC1WGZ2SVB3jce
 bMifrfSC+j5w7XDkV7X9nUgzIFTKNw397lo6AUQNOWnBNd59+fwSFERNYHC4I9KEUVOb
 Qjo1ygjXiFSp3fzvMgLS7NyoIkPZwn7sYopzmVgP4F0T7UMf4STIuJbMLuWxRr3b+qy8
 c9pJ14jxqlOxnwheP4HBfJLpkwcF5f6TSjKecF5UEdI2sLjYWnOsfssE27Gne2aTqjzf
 0WefPbQibN9Lj2szpmY4UgSMUVTGjXdcRFWa5IdkjyEPAg8wYNvrO5dOyDdX5FhhF/X7
 Yx4w==
X-Gm-Message-State: AOAM530n75lazAXPlrXnhlbnfttbtiGWSNQ3vUHD97b9ciu44Bqhm+NX
 GTFALK5EK7oRvk5Bs2CXQgAvzo6A29nUmqcn9bA=
X-Google-Smtp-Source: ABdhPJxoKSVtwYVfQbcSJEII0PVgKvOgzB/w3kHMi5aRoRnGhYo75quRtlNpytcbBPbJJCtdyRKPqLjju3VOFwaNqok=
X-Received: by 2002:a05:622a:134d:b0:2e1:ce33:5d2d with SMTP id
 w13-20020a05622a134d00b002e1ce335d2dmr8848701qtk.407.1647348454540; Tue, 15
 Mar 2022 05:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 15 Mar 2022 12:47:23 +0000
Message-ID: <CACvgo50Fxn6D1d2_20etnL1TWfNkzJFydyDgr6DwGKFoxzg0_A@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Add memory shrinker to VirtIO-GPU DRM driver
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Gert Wollny <gert.wollny@collabora.com>,
 Tomeu Vizoso <tomeu.vizoso@collabora.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 David Airlie <airlied@linux.ie>, Thomas Zimmermann <tzimmermann@suse.de>,
 ML dri-devel <dri-devel@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dmitry Osipenko <digetx@gmail.com>, Steven Price <steven.price@arm.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
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

On Mon, 14 Mar 2022 at 22:44, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:

> Dmitry Osipenko (8):
>   drm/virtio: Correct drm_gem_shmem_get_sg_table() error handling
>   drm/virtio: Check whether transferred 2D BO is shmem
>   drm/virtio: Unlock GEM reservations in error code path

These three are legitimate fixes that we want regardless of the shrinker.

Please add the respective "Fixes" tag, so they find their way in the
stable trees. With that, them 3 are:
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

HTH
Emil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
