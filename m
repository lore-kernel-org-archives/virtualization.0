Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B66C433F5
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 23:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B47D240861;
	Sun, 24 Apr 2022 23:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lTYonumAwA4H; Sun, 24 Apr 2022 23:05:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F000C408CC;
	Sun, 24 Apr 2022 23:05:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6C57C0032;
	Sun, 24 Apr 2022 23:05:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A68DAC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 23:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93600408CC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 23:05:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1r4_mUuyK539
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 23:05:03 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8C82F4090B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 23:05:03 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id i24so13235745pfa.7
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=euank-com.20210112.gappssmtp.com; s=20210112;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
 bh=bX1MRE00cmZrdByJhlsiISFv4gvgYP7aw1k+hkZKzWI=;
 b=jRlPpOyM2XgSuvfE3NcJ/Ukxsev6I2N4LEx41+Huk8koUtB36IQVrNJaar0nLf3Wc2
 UqM26JwrR5chZTeiG2WF3Xu/oPVRozph9JTMJCiicZGJ0fu4q38ex396fNz4jV6aKhKd
 gA0nK3HSmwkVdWEdZoN3+5mreetEiK2TdLgDDDXGqcT3q9F6ElARis8yxgF6/K1wynQu
 RQiLWHVsNUwM9NWzd3Z1nUkMupQX1EAOCZi7fLOO+YLRHiAHSRGcd2uwrzuKhgmTZn5n
 hyIjMKnZVC4LspPOK+1GQkZZE5Xp/OCFVr0nitfNyTQBMkhrJWsFZnwTe1/H0TjF+tl4
 YDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=bX1MRE00cmZrdByJhlsiISFv4gvgYP7aw1k+hkZKzWI=;
 b=TkTwQCJtGXO8di0H2/hl58MPcLkogp4JbTFrN6kUfvn7XZfFhC9up0Tev+gZfumyOG
 W0tPiqScxzMBN1Fm49M1s7nWzzpbxQxcPstedxR1Ws0r1ItjFeDm6DF/hXF13e1s2aP6
 q+erTslvrxSoYZ1y/jvnppcOLFK3LZ8uocy8+lWJAspbjSHsC0p0rM2OLoJp8Z8cqVea
 u9jwLB0FS/Jq4SBIr9QzZY1Xoi1jKgLA+tq4DIxypi2Ykj0f+Z544wv0PE9cjmqq7BDp
 ykzOZovR8dLgLxFOblQhK8O/nB5zGCDLCn9QJDTjJWUae3Lcc1HIvLSqepmSA3VaXIvQ
 QdzA==
X-Gm-Message-State: AOAM533TZqBwjk4J5GcV4JbrXbqYC2DWalXHaTljuntyDhe3Kf+ZEyhG
 yzH/Y6cr+wRJll0ut39UX50X56O+qvDHbg==
X-Google-Smtp-Source: ABdhPJy+iVts6wxt+gLniriSaDP98cZbBG6HcIDWG4Cn8GxkXzETSwEFM3SH/nQx8uB+5OER4DnzRw==
X-Received: by 2002:a63:8848:0:b0:3ab:2967:df83 with SMTP id
 l69-20020a638848000000b003ab2967df83mr2840000pgd.77.1650841502902; 
 Sun, 24 Apr 2022 16:05:02 -0700 (PDT)
Received: from Enkidudu ([209.251.245.16]) by smtp.gmail.com with ESMTPSA id
 d21-20020a056a0010d500b004fd9ee64134sm9156797pfu.74.2022.04.24.16.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Apr 2022 16:05:02 -0700 (PDT)
Date: Sun, 24 Apr 2022 16:05:02 -0700
From: Euan Kemp <euank@euank.com>
To: mst@redhat.com
Subject: network hangs after 'virtio: fix up virtio_disable_cb'
Message-ID: <20220424230502.une24mt5sr65qcdk@Enkidudu>
MIME-Version: 1.0
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

Hey,

I have a linux host (linux 4.12.5) running linux guest VMs using the
virtio_net driver.

After upgrading the guests to a newer kernel, the guests started
experiencing network hangs every few hours.

Once the guest got into this "hung" state, no data seems to reach its
network interface, even though the host could see packets supposedly
destined for it.

I bisected the problem to 8d622d21d248 ("virtio: fix up virtio_disable_cb").

Reverting that commit in the guest's kernel resolves the issue described
above for my setup.

I've further verified that the only portion of the patch that I needed
to revert to fix my network hangs is:

> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 992cb1cbec93..809ff4a58b8e 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -742,10 +742,7 @@ static void virtqueue_disable_cb_split(struct virtqueue *_vq)
>
>         if (!(vq->split.avail_flags_shadow & VRING_AVAIL_F_NO_INTERRUPT)) {
>                 vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
> -               if (vq->event)
> -                       /* TODO: this is a hack. Figure out a cleaner value to write. */
> -                       vring_used_event(&vq->split.vring) = 0x0;
> -               else
> +               if (!vq->event)

I also noticed it didn't reproduce for guests running on more modern
host kernels, so I also bisected down what host kernels were impacted,
which lead me to
8d65843c4426 ('Revert "vhost: cache used event for better performance"').

The commit that reverts (809ecb9bca6a) was present in 4.10 to 4.12
(inclusive), and I can only reproduce the above hang with hosts in that
version range.

From that, my current understanding is that "virtio: fix up virtio_disable_cb"
isn't buggy itself, but it triggers a bug in older vhost drivers, which
previously seemed to be latent (I at least never ran into it before).

So, what's the point of this email?

Primarily, I want to just make y'all aware, and especially make sure
this info is out there for anyone else who runs into this interaction.
I couldn't find reports of anyone else hitting this bug, but surely
there's other people out there with old host kernels.

I also want to ask: should anything be done on the virtio guest driver
side of things?
I know this is an old vhost bug, and I'm personally just updating my
host (better late than never), but I'm also curious if there's some
prior art or policy here.
Do the virtio guest drivers try to avoid regressions for the last X host
kernel versions? For all host kernels with relevant vhost drivers?
Somewhere in between?

- Euan

P.S. Just wanted to throw in a thanks for the excellent virtio drivers!
The rest of the email's dry, but I do appreciate all the work going into em!
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
