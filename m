Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FDCC433FE
	for <virtualization@archiver.kernel.org>; Tue, 15 Mar 2022 12:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59930812BA;
	Tue, 15 Mar 2022 12:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t8gJCom7P4DF; Tue, 15 Mar 2022 12:43:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECBFF81268;
	Tue, 15 Mar 2022 12:43:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABBEBC001A;
	Tue, 15 Mar 2022 12:43:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37791C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:43:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3442160AAE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:43:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e1_oxq2a7j3p
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:43:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E7C1A607EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 12:43:34 +0000 (UTC)
Received: by mail-qv1-xf2c.google.com with SMTP id im7so14864287qvb.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Mar 2022 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fEAT5UUsmyhaWxfcdGvh7mL5N8nTzlfAjcT9ivAGrCk=;
 b=cJ3yz86PEJDMILIQDbCRMD2eU82iXa2ZdXQiRq/hGWWqGtCRC3levbgE1ET08LU9JZ
 Idn5sFu8lxnTQL1hHkWMqNUUNohvVuk33T7Er5pIDgobs0u9fwZ51Y0BYG7sEic/uHli
 gBxt9aBWt25EJoNh2wcv5sbrlTOfvSGOLDznrsFb6S7YuIIlfaB09htbwydgfWEHkhFW
 lzEDYnuMGPHCPfylp0nNT5oN+UIU6NITjEKoJO9NerR3bfgpLmlcU6VgyLOPtgM//zqd
 ZDwG53dsSK1qMWwtZCaS2kCNFkzEoQ2FGVH7My+q7d1fBMrkGuaEZLIU/AJf3uA/zUeo
 eY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fEAT5UUsmyhaWxfcdGvh7mL5N8nTzlfAjcT9ivAGrCk=;
 b=EygDBwDWsCwvpZFcMVwo+7CmcAEEF3CSLmUlA46zvhWPPg3Pcv1bGsnfBPl2Jcn6t6
 iFcdFGSYplfWyhuMUAZUY9KjmwixCO2betn/rSUKCoklxWYiLbGq2qmsBjlPUFDwsSo7
 04mHuPLCGQWGrh/yrBIl2jwb/kmQfnpS3xt/6ECD679vaWR8W4Ngl8ll20qNFmexdscC
 WLnLxk804c+NA1Z9k0MwBED2dPg7Q4PoDar8YMqRlrOrP/pVs7osBsDQ1HE72sVLcqES
 C+Enw7ymBpyfyXg2iJyD52cXIxTbsd26E4G5n9Ez09qWHIlY3iDy92VnUDW3xG9swYMH
 n/Sw==
X-Gm-Message-State: AOAM531nEEeE/CY0Y/vzy12Pb68xWFeUR3/+Vl16tYPiMGAXcuPjc40G
 4rRR66U7dLSx7TzuTwGMMOXhcaRpsuk04cMdzm0=
X-Google-Smtp-Source: ABdhPJyoBonLxpVxdTKXm42VxIsdx96swV25W1RhjgHw2hK2gkTM/mwRVMnfK/H+pC9Fm5nWO7+Bak6+7qLijWaZH/I=
X-Received: by 2002:a05:6214:262a:b0:439:2d7c:a4fb with SMTP id
 gv10-20020a056214262a00b004392d7ca4fbmr18312638qvb.121.1647348213749; Tue, 15
 Mar 2022 05:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220314224253.236359-1-dmitry.osipenko@collabora.com>
 <20220314224253.236359-8-dmitry.osipenko@collabora.com>
In-Reply-To: <20220314224253.236359-8-dmitry.osipenko@collabora.com>
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Tue, 15 Mar 2022 12:43:22 +0000
Message-ID: <CACvgo52-pd-g=ZnR=m0T7W2yQ4i7_Q6gWy22=vm-fX+eA-YwQg@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] drm/virtio: Support memory shrinking
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

Greetings everyone,

Food for thought: Would it make sense to have the madvise ioctl as
generic DRM one?
Looking around - i915, msm & panfrost already have one and the virtio
implementation [below] seems as generic as it gets.

On Mon, 14 Mar 2022 at 22:44, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:

> +#define VIRTGPU_MADV_WILLNEED 0
> +#define VIRTGPU_MADV_DONTNEED 1
> +struct drm_virtgpu_madvise {
> +       __u32 bo_handle;
> +       __u32 retained; /* out, non-zero if BO can be used */
> +       __u32 madv;
> +       __u32 pad;

This seems to be based on panfrost/msm yet names (bo_handle vs
handle), layout and documentation varies.
Why is that - copy/paste is cheap :-P

HTH

-Emil
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
