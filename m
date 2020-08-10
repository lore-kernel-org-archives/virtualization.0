Return-Path: <SRS0=GaRw=BU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD87CC433E1
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 16:31:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A656B2076B
	for <virtualization@archiver.kernel.org>; Mon, 10 Aug 2020 16:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VcCcrVlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A656B2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 75C468792F;
	Mon, 10 Aug 2020 16:31:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24lOw70iGRkj; Mon, 10 Aug 2020 16:31:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 462C485C3B;
	Mon, 10 Aug 2020 16:31:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12732C013C;
	Mon, 10 Aug 2020 16:31:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BE35C004D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 16:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A947203CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 16:31:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XfiZ3X7GVCex
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 16:31:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 by silver.osuosl.org (Postfix) with ESMTPS id C55912038B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Aug 2020 16:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=FMM2Oh5ZcSDbnvQyC1t6T96Kd/pYSYYJIBdqY44N+mE=; b=VcCcrVlTv4q8hsDw2XhWxjImqo
 1f9DJZEH46qIh7p2rkLn4PG88vV4p0bFar1lLmZYAcAnqwkhTAiw429X/TX1tUyN0psM1k4rzhFyC
 Ui8zFdkoEGd4AWQRbkB0IZBhUDj+YjVNCFxkddwgBeka9S7Tx3QR2KxoidCQn5qvjWB71pzfIFaX0
 Z0+i50mpuP1Lzsa33G6uCbb/edkwV+OWceRKtUI2dsywROH+KBPj46cClTkvRk7PUKjsxebypErvZ
 iuTMTLmK4HzvkNpr9HgNiqYvuqDpVO3GNB7kq+aJP4qFQTjJ4tnMFQUqfCfCdeYzXd9a7jrWqdGP1
 C+ByazgQ==;
Received: from [2601:1c0:6280:3f0::19c2]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Ahq-0001Ko-0D; Mon, 10 Aug 2020 16:31:26 +0000
Subject: Re: linux-next: Tree for Aug 10 (drivers/vdpa/mlx5/net)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20200810141028.2140cfb2@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5a7a0e6d-842a-78f6-aeac-c5b4c27b7186@infradead.org>
Date: Mon, 10 Aug 2020 09:31:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810141028.2140cfb2@canb.auug.org.au>
Content-Language: en-US
Cc: virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Eli Cohen <eli@mellanox.com>
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

On 8/9/20 9:10 PM, Stephen Rothwell wrote:
> Hi all,
> 


on i386:

Lots (63) of left shift warnings: {not all are shown here}


  CC      drivers/vdpa/mlx5/net/mlx5_vnet.o
In file included from ../include/linux/bits.h:6:0,
                 from ../include/linux/bitops.h:5,
                 from ../include/linux/kernel.h:12,
                 from ../include/linux/vdpa.h:5,
                 from ../drivers/vdpa/mlx5/net/mlx5_vnet.c:4:
../drivers/vdpa/mlx5/net/mlx5_vnet.c: In function 'print_features':
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:27:60: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_MQ) | BIT(VIRTIO_NET_F_CTRL_MAC_ADDR) | BIT(VIRTIO_NET_F_HASH_REPORT) |  \
                                                            ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:28:3: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
   ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:28:27: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
                           ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:28:55: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_RSS) | BIT(VIRTIO_NET_F_RSC_EXT) | BIT(VIRTIO_NET_F_STANDBY) |           \
                                                       ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:29:3: note: in expansion of macro 'BIT'
   BIT(VIRTIO_NET_F_SPEED_DUPLEX) | BIT(VIRTIO_F_NOTIFY_ON_EMPTY) |                          \
   ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~
../include/vdso/bits.h:7:26: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define BIT(nr)   (UL(1) << (nr))
                          ^
../drivers/vdpa/mlx5/net/mlx5_vnet.c:30:30: note: in expansion of macro 'BIT'
   BIT(VIRTIO_F_ANY_LAYOUT) | BIT(VIRTIO_F_VERSION_1) | BIT(VIRTIO_F_ACCESS_PLATFORM) |      \
                              ^~~
../drivers/vdpa/mlx5/net/mlx5_vnet.c:186:18: note: in expansion of macro 'VALID_FEATURES_MASK'
  if (features & ~VALID_FEATURES_MASK)
                  ^~~~~~~~~~~~~~~~~~~



-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
