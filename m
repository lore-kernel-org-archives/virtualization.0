Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8DDC2BA4C
	for <virtualization@archiver.kernel.org>; Wed, 26 Jan 2022 07:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE912415DE;
	Wed, 26 Jan 2022 07:54:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VHClkdPMputb; Wed, 26 Jan 2022 07:54:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5E59E415D9;
	Wed, 26 Jan 2022 07:54:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08582C0031;
	Wed, 26 Jan 2022 07:54:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4472C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AE49540629
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:54:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x1woMIc7UeF0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:54:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EF8204049A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:54:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R921e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=10; SR=0; TI=SMTPD_---0V2ucAWv_1643183646; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2ucAWv_1643183646) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 26 Jan 2022 15:54:07 +0800
Message-Id: <1643183537.4001389-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC PATCH 0/5] TUN/VirtioNet USO features support.
Date: Wed, 26 Jan 2022 15:52:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Andrew Melnychenko <andrew@daynix.com>
In-Reply-To: <20220125084702.3636253-1-andrew@daynix.com>
Cc: mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, yuri.benditovich@daynix.com,
 yan@daynix.com, kuba@kernel.org, davem@davemloft.net
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

On Tue, 25 Jan 2022 10:46:57 +0200, Andrew Melnychenko <andrew@daynix.com> wrote:
> Added new offloads for TUN devices TUN_F_USO4 and TUN_F_USO6.
> Technically they enable NETIF_F_GSO_UDP_L4
> (and only if USO4 & USO6 are set simultaneously).
> It allows to transmission of large UDP packets.
>
> Different features USO4 and USO6 are required for qemu where Windows guests can
> enable disable USO receives for IPv4 and IPv6 separately.
> On the other side, Linux can't really differentiate USO4 and USO6, for now.
> For now, to enable USO for TUN it requires enabling USO4 and USO6 together.
> In the future, there would be a mechanism to control UDP_L4 GSO separately.
>
> Test it WIP Qemu https://github.com/daynix/qemu/tree/Dev_USOv2
>
> New types for VirtioNet already on mailing:
> https://lists.oasis-open.org/archives/virtio-comment/202110/msg00010.html

Seems like this hasn't been upvoted yet.

	https://github.com/oasis-tcs/virtio-spec#use-of-github-issues

Thanks.

>
> Also, there is a known issue with transmitting packages between two guests.
> Without hacks with skb's GSO - packages are still segmented on the host's postrouting.
>
> Andrew Melnychenko (5):
>   uapi/linux/if_tun.h: Added new ioctl for tun/tap.
>   driver/net/tun: Added features for USO.
>   uapi/linux/virtio_net.h: Added USO types.
>   linux/virtio_net.h: Added Support for GSO_UDP_L4 offload.
>   drivers/net/virtio_net.c: Added USO support.
>
>  drivers/net/tap.c               | 18 ++++++++++++++++--
>  drivers/net/tun.c               | 15 ++++++++++++++-
>  drivers/net/virtio_net.c        | 22 ++++++++++++++++++----
>  include/linux/virtio_net.h      | 11 +++++++++++
>  include/uapi/linux/if_tun.h     |  3 +++
>  include/uapi/linux/virtio_net.h |  4 ++++
>  6 files changed, 66 insertions(+), 7 deletions(-)
>
> --
> 2.34.1
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
