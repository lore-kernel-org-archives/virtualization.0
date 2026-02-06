Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5621013A3F7
	for <virtualization@lists.linux.dev>; Fri,  6 Feb 2026 00:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337648; cv=none; b=IqYHTLtE1iqervE58hBYq7qGKsvGSxgiPQjjzk3LKY8Zu144qCmEng32bjmQB3aogfpltB1hFrn4NYFEzlNMm/OPpdeFw7wJV++v4UmTKTtp90hMUbFfgnYz4yj/pjb0JE8XRtDyiDBAkZonIHmo3kZwoU9YikcbTcwDBFhHwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337648; c=relaxed/simple;
	bh=tVj3lVpI4aZ8TTqpaoJEkZkIZWuFzIADrc4Fv61YUk4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pc57hCBSRNmLk2r+d6BmrpjSSMXVtK20bEz7/lmKtz8bv8l05CmaHj2zlcT2DyohGEdU5XZuF6GyhFdjqyhHsQCrtXSA2WlwreS/LWu7Xm73ehbPZ51fXiTd8aWV4nt7btredeZxrH3Q9RGRXDoPwiuWz1KNbanE8y5w3BF/K7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SeD3739q; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SeD3739q"
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6160Q1rO2205305;
	Thu, 5 Feb 2026 16:27:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=cKGXC2X/BXA5kwBSPS
	+rFIN4yR6cEyfWv739MJ0i1j0=; b=SeD3739q1fTOUVsAYeESvCdZetH2SxM//I
	UH8bx34ueZBp7gizVDUOfX2Ikl0XJ2VfBJD6Ke2DbDK3JyUPYzsVMKJ+Aiemrzso
	iKqz+sz52Rhau4p5sPxfm2P36Jc5np87qiTe8SY2jkPZemfUHXZQ7MVMNL8iDI2S
	oP3UgzTZ33RPWUyGlckQ5ZVLhoHgELVsgy/EKNh7h6fQRtWTtk0JV+ZU7LQHyqV3
	eoBp4Gg7HdH9l7z6+xFcMslQWJUrexBtmqprPYdXsxEm3i5K6/R4jr877kpFWgQx
	hmroKeC4APRaQAr+Qvg4qeeRQWGmB3wWW7+87huhPXo1qARiPgkA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c506gvdch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 16:27:16 -0800 (PST)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::c78f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Fri, 6 Feb
 2026 00:27:15 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei
	<dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas
	<ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
Subject: [PATCH net-next v5 0/2] virtio_net: add page_pool support
Date: Thu, 5 Feb 2026 16:27:13 -0800
Message-ID: <20260206002715.1885869-1-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: aWyzu9vMtefQS6sadZuxXAPjbO5fQeMO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDAwMiBTYWx0ZWRfX+YsmuxyynF5W
 fWT0yaQlCBXsiJH+HNhGKXGvvNUaofqBGCA0v7iY+MU/xJr5h7cIeuEgT/D+LzXOBnjXpgUDYFm
 p0EzIgn8vRZOJMk5P+gUFfZpcwS/jcBt6Y1rJMtbXQbZ+q3gt/41KWHSmCPsCcrywqsJZ8xeazw
 xw+BNmrb3fken608fUHMsfHGA5GIewNoThRoX3IhbryQ6NJLmsZAcP7zNvLlwXIXNeTVsd4+VqF
 WIwahC3U31QlaWVJL2OOaUKwbkjwFI4+Gh5IW3RxxXBfJ6BpEzXVU0ugL9VGuKUAg4QqR2Pe3DN
 NsXrK5+0Oo6/9lzVwbAiyv6sI7gNg1XtkF3n8ZrTB1U40ltCPmn6d+hIiw8jAEe3eNn/fjv/XAd
 JtMj43Qo9wrlsmB1vFu5u0MYowAct20Ey2vFnpB3ET4wm/T8BXEu+gSVcOQEj2km9Dh4cvtF302
 03KsAnIWOZXpHwE1OZA==
X-Proofpoint-GUID: aWyzu9vMtefQS6sadZuxXAPjbO5fQeMO
X-Authority-Analysis: v=2.4 cv=EZ7FgfmC c=1 sm=1 tr=0 ts=69853564 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=db6x6iqHiqAGgYmq6KwA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_06,2026-02-05_03,2025-10-01_01

Introduce page_pool support in virtio_net driver to enable page
recycling in RX buffer allocation and avoid repeated page allocator
calls. This applies to mergeable and small buffer modes.

Beyond performance improvements, this patch is a prerequisite for
enabling memory provider-based zero-copy features in virtio_net,
specifically devmem TCP and io_uring ZCRX, which require drivers to
use page_pool for buffer management.

The implementation preserves the DMA premapping optimization introduced
in commit 31f3cd4e5756 ("virtio-net: rq submits premapped per-buffer")
by conditionally using PP_FLAG_DMA_MAP when the virtio backend supports
standard DMA API (vhost, virtio-pci), and falling back to
allocation-only mode for backends with custom DMA mechanisms (VDUSE).

================================================================================
                      VIRTIO-NET PAGE POOL BENCHMARK RESULTS
================================================================================

CONFIGURATION
-------------
- Host: pktgen TX -> tap interface -> vhost-net
- Guest: virtio-net RX -> XDP_DROP
- Packet sizes: small buffers - 64; merge receivable 64, 1500

SMALL PACKETS (64 bytes)
==================================================
Queues | Base (pps)  | Page Pool (pps) | Improvement | Base (Gb/s) |PP (Gb/s)
-------|-------------|-----------------|-------------|-------------|----------
  1Q   |    853,493  |      868,923    |   +1.8%     |    0.44     | 0.44
  2Q   |  1,655,793  |    1,696,707    |   +2.5%     |    0.85     | 0.87
  4Q   |  3,143,375  |    3,302,511    |   +5.1%     |    1.61     | 1.69
  8Q   |  6,082,590  |    6,156,894    |   +1.2%     |    3.11     | 3.15


RECEIVE MERGEABLE (64 bytes)
======================================================
Queues | Base (pps)  | Page Pool (pps) | Improvement | Base (Gb/s) |PP (Gb/s)
-------|-------------|-----------------|-------------|-------------|----------
   1Q  |    766,168  |      814,493    |   +6.3%     |    0.39     | 0.42
   2Q  |  1,384,871  |    1,670,639    |  +20.6%     |    0.71     | 0.86
   4Q  |  2,773,081  |    3,080,574    |  +11.1%     |    1.42     | 1.58
   8Q  |  5,600,615  |    6,043,891    |   +7.9%     |    2.87     | 3.10


RECEIVE MERGEABLE (1500 bytes)
========================================================
Queues | Base (pps)  | Page Pool (pps) | Improvement | Base (Gb/s) |PP (Gb/s)
-------|-------------|-----------------|-------------|-------------|----------
  1Q   |    741,579  |      785,442    |   +5.9%     |    8.90     | 9.43
  2Q   |  1,310,043  |    1,534,554    |  +17.1%     |   15.72     | 18.41
  4Q   |  2,748,700  |    2,890,582    |   +5.2%     |   32.98     | 34.69
  8Q   |  5,348,589  |    5,618,664    |   +5.0%     |   64.18     | 67.42

The page_pool implementation showed consistent performance improvements
by eliminating per packet overhead of allocating and deallocating
memory. When running the performance benchmarks, I noticed that
page_pool also had a consistent throughput performance compared to the
base patch where performance variability was due to accessing free_list
for getting the next set of pages.


Changes in v5
=============

Addressing reviewer feedback from v4:

- Add page_pool_frag_offset_add() helper to page_pool API to advance
  fragment offset when drivers extend buffers to consume unused page
  space (hole optimization). (Michael S. Tsirkin)
- Unify big_packets condition checks and added an  explanatory comment 
  (Michael S. Tsirkin)
- Add page_pool_dma_sync_for_cpu() calls in receive paths before
  reading buffer data when using PP_FLAG_DMA_MAP
  (Michael S. Tsirkin)
- Remove virtnet_rq_unmap() and free_receive_page_frags() entirely,
  replacing with page_pool lifecycle management (Jason Wang)
- Dropped selftests patch from the series
- v4 link: https://lore.kernel.org/virtualization/20260204193617.1200752-1-vishs@meta.com/ 

Changes in v4
=============

Addressing reviewer feedback from v3:

- Remove unnecessary !rq->page_pool check in page_to_skb()
- Reorder put_xdp_frags() parameters
- Remove unnecessary xdp_page = NULL initialization in receive_small_xdp()
- Move big_packets mode check outside the loop in virtnet_create_page_pools()
  for efficiency
- Remove unrelated whitespace changes
- v3 link: https://lore.kernel.org/virtualization/20260203231021.1331392-1-vishs@meta.com/

Changes in v3
=============

Addressing reviewer feedback from v2:

- Fix CI null-ptr-deref crash: use max_queue_pairs instead of
  curr_queue_pairs in virtnet_create_page_pools() to ensure page pools
  are created for all queues (Jason Wang, Jakub Kicinski)
- Preserve big_packets mode page->private chaining in page_to_skb() with
  conditional checks (Jason Wang)
- Use page_pool_alloc_pages() in xdp_linearize_page() and
  mergeable_xdp_get_buf() to eliminate xdp_page tracking logic and simplify
  skb_mark_for_recycle() calls (Jason Wang)
- Add page_pool_page_is_pp() check in virtnet_put_page() to safely
  handle both page_pool and non-page_pool pages (Michael S. Tsirkin)
- Remove unrelated rx_mode_work_enabled changes (Jason Wang)
- Selftest: use random ephemeral port instead of hardcoded port to avoid
  conflicts when running tests in parallel (Michael S. Tsirkin)
- v2 link: https://lore.kernel.org/virtualization/20260128212031.1431746-1-vishs@meta.com/

Changes in v2
=============

Addressing reviewer feedback from v1:

- Add "select PAGE_POOL" to Kconfig (Jason Wang)
- Move page pool creation from ndo_open to probe for device lifetime
  management (Xuan Zhuo, Jason Wang)
- Implement conditional DMA strategy using virtqueue_dma_dev():
  - When non-NULL: use PP_FLAG_DMA_MAP for page_pool-managed DMA
    premapping
  - When NULL (VDUSE): page_pool handles allocation only
- Use page_pool_get_dma_addr() + virtqueue_add_inbuf_premapped() to
  preserve DMA premapping optimization from commit 31f3cd4e5756
  ("virtio-net: rq submits premapped per-buffer") (Jason Wang)
- Remove dual allocation code paths - page_pool now always used for
  small/mergeable modes (Jason Wang)
- Remove unused virtnet_rq_alloc/virtnet_rq_init_one_sg functions
- Add comprehensive performance data (Michael S. Tsirkin)
- v1 link:
  https://lore.kernel.org/virtualization/20260106221924.123856-1-vishs@meta.com/

Vishwanath Seshagiri (2):
  page_pool: add page_pool_frag_offset_add() helper
  virtio_net: add page_pool support for buffer allocation

 drivers/net/Kconfig             |   1 +
 drivers/net/virtio_net.c        | 430 ++++++++++++++++----------------
 include/net/page_pool/helpers.h |  20 ++
 3 files changed, 241 insertions(+), 210 deletions(-)

-- 
2.47.3

