Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B794CC4167B
	for <virtualization@archiver.kernel.org>; Wed, 25 May 2022 21:51:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3FE4F60B89;
	Wed, 25 May 2022 21:51:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K0_EV8KejmQU; Wed, 25 May 2022 21:51:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE9BC60669;
	Wed, 25 May 2022 21:51:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CDC28C0032;
	Wed, 25 May 2022 21:51:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE0DBC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 21:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E5C4D60BC2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 21:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zC0gqpCZnlWW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 21:50:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1043B606EB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 May 2022 21:50:58 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EA7F761AB6;
 Wed, 25 May 2022 21:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68EFC385B8;
 Wed, 25 May 2022 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
 s=korg; t=1653515457;
 bh=RJBqCEbCNY0ooTTHUDW8T5ccFZ9a+R65ZzhmVt+2S44=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=R8xzes5UjWb8BqqxzRNWgPf7cEHyaAbeSDj+v3F0k3sq8Asguyz6Vmo/uMlX6uzmY
 8HryaeniW2c258rIiLOGG2MjKsnv6NbBuzhNNsrGT4ET41NSmI5sqMNPKOc8It7ZVv
 QGSPkTQx3i5p9WrHix2LggCVXiwA2BU9p5l/o92c=
Date: Wed, 25 May 2022 14:50:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: kernel test robot <lkp@intel.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 8cb8311e95e3bb58bd84d6350365f14a718faa6d
Message-Id: <20220525145056.953631743a4c494aabf000dc@linux-foundation.org>
In-Reply-To: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
References: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Cc: linux-fbdev@vger.kernel.org, linux-parport@lists.infradead.org,
 kvm@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-staging@lists.linux.dev, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-mm@kvack.org, amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-omap@vger.kernel.org,
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Thu, 26 May 2022 05:35:20 +0800 kernel test robot <lkp@intel.com> wrote:

> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 8cb8311e95e3bb58bd84d6350365f14a718faa6d  Add linux-next specific files for 20220525
> 
> Error/Warning reports:
> 
> ...
>
> Unverified Error/Warning (likely false positive, please contact us if interested):

Could be so.

> mm/shmem.c:1948 shmem_getpage_gfp() warn: should '(((1) << 12) / 512) << folio_order(folio)' be a 64 bit type?

I've been seeing this one for a while.  And from this report I can't
figure out what tool emitted it.  Clang?

>
> ...
>
> |-- i386-randconfig-m021
> |   `-- mm-shmem.c-shmem_getpage_gfp()-warn:should-((()-)-)-folio_order(folio)-be-a-bit-type

If you're going to use randconfig then shouldn't you make the config
available?  Or maybe quote the KCONFIG_SEED - presumably there's a way
for others to regenerate.

Anyway, the warning seems wrong to me.


#define PAGE_SIZE               (_AC(1,UL) << PAGE_SHIFT)

#define BLOCKS_PER_PAGE  (PAGE_SIZE/512)

	inode->i_blocks += BLOCKS_PER_PAGE << folio_order(folio);

so the RHS here should have unsigned long type.  Being able to generate
the cpp output would be helpful.  That requires the .config.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
