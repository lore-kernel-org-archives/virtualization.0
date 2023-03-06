Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E51C678D4
	for <virtualization@archiver.kernel.org>; Mon,  6 Mar 2023 09:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6898160E3C;
	Mon,  6 Mar 2023 09:03:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6898160E3C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zNNjMEjoVMqd; Mon,  6 Mar 2023 09:03:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 731C160BF5;
	Mon,  6 Mar 2023 09:03:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 731C160BF5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34CA4C0071;
	Mon,  6 Mar 2023 09:03:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F889C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 09:03:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB8A6405E7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 09:03:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB8A6405E7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Is61Xne76tFE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 09:03:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22A82405CE
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22A82405CE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Mar 2023 09:03:42 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0VdDPc-._1678093416; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdDPc-._1678093416) by smtp.aliyun-inc.com;
 Mon, 06 Mar 2023 17:03:37 +0800
Message-ID: <1678092272.631299-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3] virtio-net: Fix probe of virtio-net on kvmtool
Date: Mon, 6 Mar 2023 16:44:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230223-virtio-net-kvmtool-v3-1-e038660624de@rivosinc.com>
 <20230301093054-mutt-send-email-mst@kernel.org>
 <CACGkMEsG10CWigz+S6JgSVK8XfbpT=L=30hZ8LDvohtaanAiZQ@mail.gmail.com>
 <20230302044806-mutt-send-email-mst@kernel.org>
 <20230303164603.7b35a76f@kernel.org>
 <20230305045249-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230305045249-mutt-send-email-mst@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 rbradford@rivosinc.com, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sun, 5 Mar 2023 04:53:58 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Mar 03, 2023 at 04:46:03PM -0800, Jakub Kicinski wrote:
> > On Thu, 2 Mar 2023 04:48:38 -0500 Michael S. Tsirkin wrote:
> > > > Looks not the core can try to enable and disable features according to
> > > > the diff between features and hw_features
> > > >
> > > > static inline netdev_features_t netdev_get_wanted_features(
> > > >         struct net_device *dev)
> > > > {
> > > >         return (dev->features & ~dev->hw_features) | dev->wanted_features;
> > > > }
> > >
> > > yes what we do work according to code.  So the documentation is wrong then?
> >
> > It's definitely incomplete but which part are you saying is wrong?
>
> So it says:
>   2. netdev->features set contains features which are currently enabled
>      for a device.
>
> ok so far.
> But this part:
>
>   This should be changed only by network core or in
>      error paths of ndo_set_features callback.
>
> seems to say virtio should not touch netdev->features, no?


I think the "changed" here refers to the user's opening or closing a function
by network core.

If the features contain a certain function, but hw_features does not include it
means that this function cannot be modified by user.


 *	struct net_device - The DEVICE structure.
 *   [....]
 *	@features:	Currently active device features
 *	@hw_features:	User-changeable features

Thanks.


>
> --
> MST
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
