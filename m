Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F036313E03;
	Sun,  4 Oct 2026 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791114949; cv=none; b=Lx/OREMKbYB07O+7M0GqFsqSjzn6MBVUAY5UeiyEq+c/UQtlPzupMEmeGqd8ZfHKJA/RpXAbUjBpqlzXRmkzvyDKeFjAeoISrx9TD4Kj0VOEliFzNd14MCJFx8oyQLo+D2qKNFIJ+d0ApfmwBOvN9WMS5uA7CV5IDo3uhyNztV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791114949; c=relaxed/simple;
	bh=2diUWiMumXZ8fcMT/hP3C8YLZMxoeUnkBqrM4miqhvs=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=dvAnvLDB8qALGs9ZwOUw4jSij4U+Eg+BUIBwL5KxC8vw1EvEHcIzBYmSIyNkAuEyR7+7UP3WCGU1A9dyfl6Si7aylZiFFjhlfNxxBIIbWK8b6KmlecfvuWL0HSOB5NspEPWKtXmaL1GH6ZYDGNRLO/tL5hj3tzANBiMkJ4UycIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=n6jBNXf4; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="n6jBNXf4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791114935; bh=fDJo9jmeOP/YKrCNIkJcfkH1W9LcFEnZJGyu0LsmuUI=;
	h=From:To:Cc:Subject:Date;
	b=n6jBNXf4XO+QI0r8QgmjdE7GIDjol9+9/L2zZy+GhAhXAZpr9Gy5YsJySVWvUFGUX
	 /DxXLAEf+JZHCryLEzr4IQYXSshWcPfhfujfomNTkFPLyMpsypz+8iLdBZHXLpCEOo
	 yYaXAbsorJPcqPbvBTrd9086h/HCNzE0qFsfWH3o=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id DDEB88E5; Sun, 04 Oct 2026 19:55:30 +0800
X-QQ-mid: xmsmtpt1791114930t5b6nu8wc
Message-ID: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uoNK3avNKS6+xPFpvNlg/AYkyPBeGn7Z8Kgr/eJTLNXfWylHBwl
	 j6V1CDX3eO5g/ly8uJri9A7MZyLoZ9eUypuNR7mwb3P0A2NVUNjG+L2peZaOpkxcUaswaDs+J592
	 g7ytTkKmjuyWF9XG7OZjgPuLJoT9dA2fyG8iBeXsxbfJxEFrfdoCL31f1t8KPol/RHM1qL6diuXF
	 7gCDmu1UiQPckouojFlVw8dSV8UPk4eJO7Qw+KIljzKA1pQ0ctoPjH4AeHjrxQOYO+UvGyPOxPs6
	 n9hCBkVlS3bwXcnKFyEeB0mBQArSvhmEOLlvBPvnhTKdUmYSYyon/gCJyGC7uf+qhOE5XILZBNyt
	 hyCKnBwrCGW9Nao8bHd/qv2B2AQ1M5bQCx5YwXMsw8AG8FgiDDwY7DghaLtcFded8prWl0rKM4eR
	 y+A0gK9xxPUqcpdVwlRiqvSfeKWph/hyB2c/7qk8GPGaLL3W/d+aeyVOA9PpTmQ7rcuHCPxk6z6N
	 C2ODlc7x/YnMJa9pH2cfeVrCWFTnJlX/0tH9xELGGIuavjFVud17emQhpdyBtdfLs8J3VvDdcFf5
	 zJ958PxTwBSlDGsZVFufaFszLJM2Iivs/NPU7PDv0NkCYxXMo4gDH8/0mI5UhizKcjqFZqoTRPM7
	 M22+kdjLbV3DptOXkZoYHa9NbEhPqvw9eABWCI6mJZSK0c+qHhFm4LnNPwUZc+3dASqENyhx0zuJ
	 ep5FK6G9+635aQ5bkWz2TznNqGbK+6agLGoMDjuzQCdoaGIGCgGAI3Us4ycqx7qY7sErqpyFXhWB
	 6k55U+HzZkBUNOf8C4lJzJESr+aKM6m38gt823TWW77b8zqJQUPODjz0lj7Lfz7D8lW9bs8k0bRG
	 D3eL+++IZuP/AW3fccotIO68kVRHhRrfalCK+WJxtZ7iwJtFHUInpRIbs5CJ6L2azNc610uXWnjw
	 K0hGmTtSTwlmSwEPZR48kTtF9cjEIpPQQGVJzqaGb8ChRgfSWiBuYL1b78U6AF9P9qARKd52FBLL
	 qgfp5hCq/ghcRD0bK+THq8apA+Xnpob9lQ96P66Y+kESePE2Yu7+wfWvO11tuQKSOZjsvU+g/aYb
	 yK2pGDA1ogPIo1Vzs=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	agicy@qq.com
Subject: [PATCH 0/6] iommu/virtio: batch the mapping replay
Date: Sun,  4 Oct 2026 11:55:28 +0000
X-OQ-MSGID: <20261004115528.3180918-1-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The virtio-iommu device frees a domain together with its last endpoint, so
the first endpoint attaching to a domain that already has mappings must
rebuild it: viommu_replay_mappings() re-sends every mapping the driver
holds. That walk sent one synchronous request per mapping with
mappings_lock held - and with it interrupts disabled. The IRQ-off window
therefore grew with the number of mappings: 233 ms for 8192 4K mappings,
about 29 s for a million, long enough to add scheduling latency to
everything else running on the CPU.

The same code had two long-standing defects, fixed by the first patches:

 - nr_endpoints was bumped only after the replay, without the lock, while
   viommu_map_pages() read the same counter, also without the lock, to
   decide whether to send a MAP itself or leave it to the replay. A map
   racing the first attach could be sent by nobody and never reach the
   device.

 - viommu_unmap_pages() removed whole mappings from its tree but queued a
   single UNMAP built from the range the caller asked for, after dropping
   the lock: the device could keep translating memory the driver had
   released, and a concurrent map could be sent ahead of the UNMAP. That
   queueing also allocated on the unmap path, which iommu_unmap_nofail()
   does not allow.

The series:

 - 1/6 publishes the endpoint before the replay, tracks an unfinished
   replay with replay_pending, and puts the endpoint back on the old
   domain when the ATTACH or the replay fails - with a replay pending for
   it if the device dropped its mappings - so a failed attach cannot leave
   the endpoint count short, the endpoint unattached (bypassed), or the
   endpoint recorded on a domain the core does not reference;
 - 2/6 queues one UNMAP per contiguous run of removed mappings, in the
   section that removes them, covering the mappings' own ranges;
 - 3/6 allocates the UNMAP request together with the mapping, on the map
   path, so the unmap path never allocates;
 - 4/6 stops queueing and draining once the device is removed;
 - 5/6 reads the endpoint count under the lock in the iotlb paths;
 - 6/6 queues the replayed mappings, one per lock section, and waits once.

Measured with QEMU/KVM and iommufd, N=8192 4K mappings: max IRQ-off window
233.7 ms -> 1.4-2.5 ms, flat from N=64 to 32768; attach ioctl 218.9/249.0
-> 50.3/48.8 ms (48-67 ms across runs); viommu_send_req_sync() calls 8193
-> 1; the device receives exactly the same MAPs. With large pages the
same 256 MB attach is about 4 ms (197 device requests); the remaining cost
is the device processing one MAP per mapping, which the protocol
requires. The concurrent map-vs-first-attach test loses mappings on the
unpatched driver in several runs and none with the series; lockdep and
KCSAN report nothing. Allocation-failure and device-rejection paths were
exercised with test-only fault injection in QEMU.

Patches 1-4 carry Fixes: tags for the original driver commit. Behaviour
that predates this work - in particular, how a MAP the device rejects on
the map path - is deliberately left unchanged. Based on v7.3-rc5
(ce1e0223d8ad).

Anlai Lu (6):
  iommu/virtio: publish the endpoint before replaying it
  iommu/virtio: queue an UNMAP for every removed mapping
  iommu/virtio: allocate the UNMAP request with the mapping
  iommu/virtio: stop queueing and draining once the device is removed
  iommu/virtio: read the endpoint count under the lock in the iotlb
    paths
  iommu/virtio: batch the mapping replay on domain attach

 drivers/iommu/virtio-iommu.c | 642 +++++++++++++++++++++++++++++------
 1 file changed, 538 insertions(+), 104 deletions(-)

-- 
2.55.0

