Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A368019BAE
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PivL9517"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08D6381EA8
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 10:12:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08D6381EA8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PivL9517
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2gEkxKqiAPPX
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 10:12:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8CCBC8161D
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 10:12:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CCBC8161D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701252752; x=1732788752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T/nE2PLN0CkqTzjNu7omvvMU4nDr0lpxOaDVDfchUJ4=;
  b=PivL9517X6vLt2ioRxCA3WMCQq6ZkuxOpoYuve1Hkkoq0hwxZKUVScbU
   +lFZhFon4EldryJVEfKQO1pMLsxdq18VfeZcUvNxAFEKG9Q4kj/1NLYrY
   GxUoW7cPteVpVtqiY0+EYK0oV4nS9WPZMuN+uBeLsGks+MVvgxp0Sl2FQ
   6tisoUUpP4btNkksqZnCaBTMRri/DZ3SFty53vI27HQPa2OyUwnLKOkMW
   G0hpoWhz171QU7tOpdXcF9geoRfLyRhytIL9WWXKLpT2KCO6KaxCdng9V
   5zcKJsyhk8YRAYx56dYKllQqoKEdbrsw6Lf5HqvUWJAq4SV5ifuk80Xi0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="397037843"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="397037843"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:12:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="886798488"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="886798488"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.238.2.21]) ([10.238.2.21])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:12:27 -0800
Message-ID: <6f84bbad-62f9-43df-8134-a6836cc3b66c@linux.intel.com>
Date: Wed, 29 Nov 2023 18:12:25 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] virtio: features
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com,
 Linus Torvalds <torvalds@linux-foundation.org>, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, eperezma@redhat.com, shannon.nelson@amd.com,
 yuanyaogoog@chromium.org, yuehaibing@huawei.com,
 kirill.shutemov@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 alexander.shishkin@linux.intel.com
References: <20230903181338-mutt-send-email-mst@kernel.org>
 <647701d8-c99b-4ca8-9817-137eaefda237@linux.intel.com>
 <CACGkMEvoGOO0jtq5T7arAjRoB_0_fHB2+hPJe1JsPqcAuvr98w@mail.gmail.com>
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <CACGkMEvoGOO0jtq5T7arAjRoB_0_fHB2+hPJe1JsPqcAuvr98w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023/11/29 17:16, Jason Wang wrote:
> On Wed, Nov 29, 2023 at 5:05 PM Ning, Hongyu
> <hongyu.ning@linux.intel.com> wrote:
>>
>>
>>
>> On 2023/9/4 6:13, Michael S. Tsirkin wrote:
>>> The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:
>>>
>>>     Linux 6.5 (2023-08-27 14:49:51 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
>>>
>>> for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab:
>>>
>>>     virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023-09-03 18:10:24 -0400)
>>>
>>> ----------------------------------------------------------------
>>> virtio: features
>>>
>>> a small pull request this time around, mostly because the
>>> vduse network got postponed to next relase so we can be sure
>>> we got the security store right.
>>>
>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> ----------------------------------------------------------------
>>> Eugenio Pérez (4):
>>>         vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
>>>         vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
>>>         vdpa: add get_backend_features vdpa operation
>>>         vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
>>>
>>> Jason Wang (1):
>>>         virtio_vdpa: build affinity masks conditionally
>>>
>>> Xuan Zhuo (12):
>>>         virtio_ring: check use_dma_api before unmap desc for indirect
>>>         virtio_ring: put mapping error check in vring_map_one_sg
>>>         virtio_ring: introduce virtqueue_set_dma_premapped()
>>>         virtio_ring: support add premapped buf
>>>         virtio_ring: introduce virtqueue_dma_dev()
>>>         virtio_ring: skip unmap for premapped
>>>         virtio_ring: correct the expression of the description of virtqueue_resize()
>>>         virtio_ring: separate the logic of reset/enable from virtqueue_resize
>>>         virtio_ring: introduce virtqueue_reset()
>>>         virtio_ring: introduce dma map api for virtqueue
>>>         virtio_ring: introduce dma sync api for virtqueue
>>>         virtio_net: merge dma operations when filling mergeable buffers
>>
>> Hi,
>> above patch (upstream commit 295525e29a5b) seems causing a virtnet
>> related Call Trace after WARNING from kernel/dma/debug.c.
>>
>> details (log and test setup) tracked in
>> https://bugzilla.kernel.org/show_bug.cgi?id=218204
>>
>> it's recently noticed in a TDX guest testing since v6.6.0 release cycle
>> and can still be reproduced in latest v6.7.0-rc3.
>>
>> as local bisects results show, above WARNING and Call Trace is linked
>> with this patch, do you mind to take a look?
> 
> Looks like virtqueue_dma_sync_single_range_for_cpu() use
> DMA_BIDIRECTIONAL unconditionally.
> 
> We should use dir here.
> 
> Mind to try?
> 
> Thanks
> 

sure, but what I see in the code 
virtqueue_dma_sync_single_range_for_cpu() is using DMA_FROM_DEVICE, 
probably I misunderstood your point?

Please let me know any patch/setting to try here.


>>
>>>
>>> Yuan Yao (1):
>>>         virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
>>>
>>> Yue Haibing (1):
>>>         vdpa/mlx5: Remove unused function declarations
>>>
>>>    drivers/net/virtio_net.c           | 230 ++++++++++++++++++---
>>>    drivers/vdpa/mlx5/core/mlx5_vdpa.h |   3 -
>>>    drivers/vdpa/vdpa_sim/vdpa_sim.c   |   8 +
>>>    drivers/vhost/vdpa.c               |  15 +-
>>>    drivers/virtio/virtio_ring.c       | 412 ++++++++++++++++++++++++++++++++-----
>>>    drivers/virtio/virtio_vdpa.c       |  17 +-
>>>    include/linux/vdpa.h               |   4 +
>>>    include/linux/virtio.h             |  22 ++
>>>    include/uapi/linux/vhost_types.h   |   4 +
>>>    9 files changed, 625 insertions(+), 90 deletions(-)
>>>
>>
> 
