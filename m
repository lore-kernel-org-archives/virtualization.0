Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F667101F3
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQQ8r9Up"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E57081A3E
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:11:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E57081A3E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hQQ8r9Up
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AAcDcrksJSvB
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 09:11:16 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 29 Nov 2023 09:11:16 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 719D28194A
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 719D28194A
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701249077; x=1732785077;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=woZ8E+l0CNEPRBPUKxmoG/NfRBBDwznN1n7mx/aFQJ4=;
  b=hQQ8r9Up0dVqQZLlNsjm7Sx5SCSYQP8qH7vhCbsAyllJ9ngyAuoonr91
   /Wc9b4HCJ/UUQABMV5++4ZoEEuB4Nr6CkFeXDcCHOg94BeSij7QHSa1P0
   aVLUmwEy9L6HZwQGuowKvSOVdbT087ePrkk8BTSd33wUR4LdE3qU3JLe0
   iUrqBxi1tXs2bA7JKjo/b3dCqZ0LNodIMnX8aalyGlnEh1bcLMvjCRosd
   OvDQxbzqWMT+wfcaHP1NygmEIkUhzbCkpROLOBTX+aMtMZgMEtaQ4E+eM
   GVjrRuHodt4Jozd2a5k+71pwBBKoP31rpozrHcbPQC17qEUkR2wfzI9+u
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="25405"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="25405"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 01:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="718678539"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="718678539"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.238.2.21]) ([10.238.2.21])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 01:04:04 -0800
Message-ID: <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
Date: Wed, 29 Nov 2023 17:03:50 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] virtio: features
To: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, jasowang@redhat.com,
 shannon.nelson@amd.com, yuanyaogoog@chromium.org, yuehaibing@huawei.com,
 kirill.shutemov@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 alexander.shishkin@linux.intel.com
References: <20230903181338-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <20230903181338-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/9/4 6:13, Michael S. Tsirkin wrote:
> The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:
> 
>    Linux 6.5 (2023-08-27 14:49:51 -0700)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
> 
> for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab:
> 
>    virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023-09-03 18:10:24 -0400)
> 
> ----------------------------------------------------------------
> virtio: features
> 
> a small pull request this time around, mostly because the
> vduse network got postponed to next relase so we can be sure
> we got the security store right.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> ----------------------------------------------------------------
> Eugenio Pérez (4):
>        vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
>        vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
>        vdpa: add get_backend_features vdpa operation
>        vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
> 
> Jason Wang (1):
>        virtio_vdpa: build affinity masks conditionally
> 
> Xuan Zhuo (12):
>        virtio_ring: check use_dma_api before unmap desc for indirect
>        virtio_ring: put mapping error check in vring_map_one_sg
>        virtio_ring: introduce virtqueue_set_dma_premapped()
>        virtio_ring: support add premapped buf
>        virtio_ring: introduce virtqueue_dma_dev()
>        virtio_ring: skip unmap for premapped
>        virtio_ring: correct the expression of the description of virtqueue_resize()
>        virtio_ring: separate the logic of reset/enable from virtqueue_resize
>        virtio_ring: introduce virtqueue_reset()
>        virtio_ring: introduce dma map api for virtqueue
>        virtio_ring: introduce dma sync api for virtqueue
>        virtio_net: merge dma operations when filling mergeable buffers

Hi,
above patch (upstream commit 295525e29a5b) seems causing a virtnet 
related Call Trace after WARNING from kernel/dma/debug.c.

details (log and test setup) tracked in 
https://bugzilla.kernel.org/show_bug.cgi?id=218204

it's recently noticed in a TDX guest testing since v6.6.0 release cycle 
and can still be reproduced in latest v6.7.0-rc3.

as local bisects results show, above WARNING and Call Trace is linked 
with this patch, do you mind to take a look?

> 
> Yuan Yao (1):
>        virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
> 
> Yue Haibing (1):
>        vdpa/mlx5: Remove unused function declarations
> 
>   drivers/net/virtio_net.c           | 230 ++++++++++++++++++---
>   drivers/vdpa/mlx5/core/mlx5_vdpa.h |   3 -
>   drivers/vdpa/vdpa_sim/vdpa_sim.c   |   8 +
>   drivers/vhost/vdpa.c               |  15 +-
>   drivers/virtio/virtio_ring.c       | 412 ++++++++++++++++++++++++++++++++-----
>   drivers/virtio/virtio_vdpa.c       |  17 +-
>   include/linux/vdpa.h               |   4 +
>   include/linux/virtio.h             |  22 ++
>   include/uapi/linux/vhost_types.h   |   4 +
>   9 files changed, 625 insertions(+), 90 deletions(-)
> 
