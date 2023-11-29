Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7B118AE9
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1W/TmkQ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07763817AC
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 10:52:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07763817AC
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g1W/TmkQ
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iiTmDFOvyax8
	for <virtualization@lists.linux-foundation.org>;
	Wed, 29 Nov 2023 10:52:46 +0000 (UTC)
X-Greylist: delayed 426 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 29 Nov 2023 10:52:45 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEFF6817BA
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CEFF6817BA
	for <virtualization@lists.linux-foundation.org>; Wed, 29 Nov 2023 10:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701255166; x=1732791166;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rbU00ZlSBNX0l3gHoeLVRwt3IFr67F4reSXWY6JN9vE=;
  b=g1W/TmkQtUBZui1guVE6ias3Gt98aOUUlOaVKpjqXME7wzzVYHLkJCbH
   wx59/EZryeDGGBlYc0E5IDBcb22ha9C/iUUryCvl3Ww6ctMl8Z0jS2hjj
   VmatFBz9tDShB/aKiu2YVYpA5Q8B/hjG+Ku5GuX4FC1jejmdHcd6qvmvH
   PgfVQ68vPGWIs+uCh2GiIE/bYSSQBaNGMgxAhF4eK8gX7t/gMphwVctu7
   yCxD4yWShG7oPFanL4gYM6JNnf4p2iMkHCADJt9DjgIFFUiR3psmC03EV
   6urkD5dU3ULNZHW4dihyJhsYIGC3zzoyKnTV3qmMCmVFtuHgx1BRoMfXh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="29569"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="29569"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:45:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859781936"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="859781936"
Received: from hongyuni-mobl.ccr.corp.intel.com (HELO [10.238.2.21]) ([10.238.2.21])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 02:45:34 -0800
Message-ID: <f37cb55a-6fc8-4e21-8789-46d468325eea@linux.intel.com>
Date: Wed, 29 Nov 2023 18:45:32 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] virtio: features
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
 <6f84bbad-62f9-43df-8134-a6836cc3b66c@linux.intel.com>
 <CACGkMEvtus2BseZec8at6YORO=As1v9r9p=xtZjE1e2i=uhwhA@mail.gmail.com>
Content-Language: en-US
From: "Ning, Hongyu" <hongyu.ning@linux.intel.com>
In-Reply-To: <CACGkMEvtus2BseZec8at6YORO=As1v9r9p=xtZjE1e2i=uhwhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2023/11/29 18:20, Jason Wang wrote:
> On Wed, Nov 29, 2023 at 6:12 PM Ning, Hongyu
> <hongyu.ning@linux.intel.com> wrote:
>>
>>
>> On 2023/11/29 17:16, Jason Wang wrote:
>>> On Wed, Nov 29, 2023 at 5:05 PM Ning, Hongyu
>>> <hongyu.ning@linux.intel.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2023/9/4 6:13, Michael S. Tsirkin wrote:
>>>>> The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:
>>>>>
>>>>>      Linux 6.5 (2023-08-27 14:49:51 -0700)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>      https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
>>>>>
>>>>> for you to fetch changes up to 1acfe2c1225899eab5ab724c91b7e1eb2881b9ab:
>>>>>
>>>>>      virtio_ring: fix avail_wrap_counter in virtqueue_add_packed (2023-09-03 18:10:24 -0400)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> virtio: features
>>>>>
>>>>> a small pull request this time around, mostly because the
>>>>> vduse network got postponed to next relase so we can be sure
>>>>> we got the security store right.
>>>>>
>>>>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> Eugenio Pérez (4):
>>>>>          vdpa: add VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK flag
>>>>>          vdpa: accept VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK backend feature
>>>>>          vdpa: add get_backend_features vdpa operation
>>>>>          vdpa_sim: offer VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK
>>>>>
>>>>> Jason Wang (1):
>>>>>          virtio_vdpa: build affinity masks conditionally
>>>>>
>>>>> Xuan Zhuo (12):
>>>>>          virtio_ring: check use_dma_api before unmap desc for indirect
>>>>>          virtio_ring: put mapping error check in vring_map_one_sg
>>>>>          virtio_ring: introduce virtqueue_set_dma_premapped()
>>>>>          virtio_ring: support add premapped buf
>>>>>          virtio_ring: introduce virtqueue_dma_dev()
>>>>>          virtio_ring: skip unmap for premapped
>>>>>          virtio_ring: correct the expression of the description of virtqueue_resize()
>>>>>          virtio_ring: separate the logic of reset/enable from virtqueue_resize
>>>>>          virtio_ring: introduce virtqueue_reset()
>>>>>          virtio_ring: introduce dma map api for virtqueue
>>>>>          virtio_ring: introduce dma sync api for virtqueue
>>>>>          virtio_net: merge dma operations when filling mergeable buffers
>>>>
>>>> Hi,
>>>> above patch (upstream commit 295525e29a5b) seems causing a virtnet
>>>> related Call Trace after WARNING from kernel/dma/debug.c.
>>>>
>>>> details (log and test setup) tracked in
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218204
>>>>
>>>> it's recently noticed in a TDX guest testing since v6.6.0 release cycle
>>>> and can still be reproduced in latest v6.7.0-rc3.
>>>>
>>>> as local bisects results show, above WARNING and Call Trace is linked
>>>> with this patch, do you mind to take a look?
>>>
>>> Looks like virtqueue_dma_sync_single_range_for_cpu() use
>>> DMA_BIDIRECTIONAL unconditionally.
>>>
>>> We should use dir here.
>>>
>>> Mind to try?
>>>
>>> Thanks
>>>
>>
>> sure, but what I see in the code
>> virtqueue_dma_sync_single_range_for_cpu() is using DMA_FROM_DEVICE,
>> probably I misunderstood your point?
>>
>> Please let me know any patch/setting to try here.
> 
> Something like attached.  (Not even compiling test).
> 
> Thanks
> 

Oh, this patch works, WARNING and Call Trace are no more reproduced in 
the same Linux Guest Kernel setup.

>>
>>
>>>>
>>>>>
>>>>> Yuan Yao (1):
>>>>>          virtio_ring: fix avail_wrap_counter in virtqueue_add_packed
>>>>>
>>>>> Yue Haibing (1):
>>>>>          vdpa/mlx5: Remove unused function declarations
>>>>>
>>>>>     drivers/net/virtio_net.c           | 230 ++++++++++++++++++---
>>>>>     drivers/vdpa/mlx5/core/mlx5_vdpa.h |   3 -
>>>>>     drivers/vdpa/vdpa_sim/vdpa_sim.c   |   8 +
>>>>>     drivers/vhost/vdpa.c               |  15 +-
>>>>>     drivers/virtio/virtio_ring.c       | 412 ++++++++++++++++++++++++++++++++-----
>>>>>     drivers/virtio/virtio_vdpa.c       |  17 +-
>>>>>     include/linux/vdpa.h               |   4 +
>>>>>     include/linux/virtio.h             |  22 ++
>>>>>     include/uapi/linux/vhost_types.h   |   4 +
>>>>>     9 files changed, 625 insertions(+), 90 deletions(-)
>>>>>
>>>>
>>>
>>
