Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A571DC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 09:27:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2A2D44048C;
	Mon,  4 Jul 2022 09:27:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A2D44048C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nGyr6y36
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VvLEgTkcd3hF; Mon,  4 Jul 2022 09:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BB34C40125;
	Mon,  4 Jul 2022 09:27:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB34C40125
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C669C0032;
	Mon,  4 Jul 2022 09:27:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4602FC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 09:27:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 20CB282572
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 09:27:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 20CB282572
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=nGyr6y36
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fF-2z_M7w4se
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 09:27:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BCDB824CE
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8BCDB824CE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 09:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1656926820; x=1688462820;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Qqfi1RkliWW6P1CYgD0y8b0qTLe8TyQmIvTSDwhAims=;
 b=nGyr6y36YFXX1D55FJLsxr5j5RRogDbtTKh4tOK9ZoOdeDXpLftZL6x8
 bP8FvkXWUJ+hBoB3QV1lBBaoRccqqYNr2OFZufSSFTA5+8vt+0HPgjtXN
 hRAX6/9HUyO3a7nsxFUpXUf62kDLfE+58ZchnwoYOSjvB2wT39NY95qpk
 TogX4Hx/xOSkL7Q7NSj7FyQ9OIZNGr8+x9b6cw7y03+3C9TVhlV/wn86i
 I6k9/AmGV1j7ROAt/s+aH2oQD/bBPHC39+YjYJga14sDH363jre+ck+Iv
 oig9PMFz9lodE0SfyLhe/+0PcbX1ucMCowBZUVj3v3rHfANEALq4+OcEP w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="344760909"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; d="scan'208";a="344760909"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2022 02:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; d="scan'208";a="542519403"
Received: from storage2.sh.intel.com (HELO localhost) ([10.67.110.197])
 by orsmga003.jf.intel.com with ESMTP; 04 Jul 2022 02:26:57 -0700
Date: Mon, 4 Jul 2022 05:26:52 -0400
From: Liu Xiaodong <xiaodong.liu@intel.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 0/6] VDUSE: Support registering userspace memory as
 bounce buffer
Message-ID: <20220704092652.GB105370@storage2.sh.intel.com>
References: <20220629082541.118-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220629082541.118-1-xieyongji@bytedance.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Cc: mst@redhat.com, xiaodong.liu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, maxime.coquelin@redhat.com,
 stefanha@redhat.com
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

On Wed, Jun 29, 2022 at 04:25:35PM +0800, Xie Yongji wrote:
> Hi all,
> 
> This series introduces some new ioctls: VDUSE_IOTLB_GET_INFO,
> VDUSE_IOTLB_REG_UMEM and VDUSE_IOTLB_DEREG_UMEM to support
> registering and de-registering userspace memory for IOTLB
> as bounce buffer in virtio-vdpa case.
> 
> The VDUSE_IOTLB_GET_INFO ioctl can help user to query IOLTB
> information such as bounce buffer size. Then user can use
> those information on VDUSE_IOTLB_REG_UMEM and
> VDUSE_IOTLB_DEREG_UMEM ioctls to register and de-register
> userspace memory for IOTLB.
> 
> During registering and de-registering, the DMA data in use
> would be copied from kernel bounce pages to userspace bounce
> pages and back.
> 
> With this feature, some existing application such as SPDK
> and DPDK can leverage the datapath of VDUSE directly and
> efficiently as discussed before [1]. They can register some
> preallocated hugepages to VDUSE to avoid an extra memcpy
> from bounce-buffer to hugepages.

Hi, Yongji

Very glad to see this enhancement in VDUSE. Thank you.
It is really helpful and essential to SPDK.
With this new feature, we can get VDUSE transferred data
accessed directly by userspace physical backends, like RDMA
and PCIe devices.

In SPDK roadmap, it's one important work to export block
services to local host, especially for container scenario.
This patch could help SPDK do that with its userspace
backend stacks while keeping high efficiency and performance.
So the whole SPDK ecosystem can get benefited.

Based on this enhancement, as discussed, I drafted a VDUSE
prototype module in SPDK for initial evaluation:
[TEST]vduse: prototype for initial draft
https://review.spdk.io/gerrit/c/spdk/spdk/+/13534

Running SPDK on single CPU core, configured with 2 P3700 NVMe,
and exported block devices to local host kernel via different
protocols. The randwrite IOPS through each protocol are:
NBD 		  121K
NVMf-tcp loopback 274K
VDUSE 		  463K

SPDK with RDMA backends should have a similar ratio.
VDUSE has a great performance advantage for SPDK.
We have kept investigating on this usage for years.
Originally, some SPDK users used NBD. Then NVMf-tcp loopback
is SPDK community accommended way. In future, VDUSE could be
the preferred way.

> The kernel and userspace codes could be found in github:
> 
> https://github.com/bytedance/linux/tree/vduse-umem
> https://github.com/bytedance/qemu/tree/vduse-umem
> 
> To test it with qemu-storage-daemon:
> 
> $ qemu-storage-daemon \
>     --chardev socket,id=charmonitor,path=/tmp/qmp.sock,server=on,wait=off \
>     --monitor chardev=charmonitor \
>     --blockdev driver=host_device,cache.direct=on,aio=native,filename=/dev/nullb0,node-name=disk0
> \
>     --export type=vduse-blk,id=vduse-test,name=vduse-test,node-name=disk0,writable=on
> 
> [1] https://lkml.org/lkml/2021/6/27/318
> 
> Please review, thanks!

Waiting for its review process.

Thanks
Xiaodong
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
