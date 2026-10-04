Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2B44AB6C;
	Sun,  4 Oct 2026 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118823; cv=none; b=ftm4paL8XHkGpL1hfYQ8PicEM50DcQDUp+Wbi28sFn+u/51xMXLYdhH9R+N1L7TX2Ayy3Nxl/G4nOyQF3VkXHTjn+ziFDkzsIS4Oj1QYPpl3hNrMmH9JEHsLIsPb/dnoRO9N/RPbtiVEtnICFRT5112YZQ3+8puHP7PWoJ4SGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118823; c=relaxed/simple;
	bh=6Hj1cL+LJotPl+FVFDnC5D8apXfe1+/uuwaEIb0djlg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=mVK4TXE3kzFbVVvllEMtNNsmxwQLQh0dExfJg1GF6vPwPszMg6SYzo6VYT5y4nS7aDyM1w72vS5DwZYk/j1UsXiKfDPemkLSYOJOq3MBckUHq2dEXQXq8P2AjDA8v10Gqw55KzwxbqvBkLdqGo8sasoiBUZ50KhhCK4KWr5+J3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cpr/BJ1m; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cpr/BJ1m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791118813; bh=3yCK4Moh7XYc7YAvGVA6/15V7iheywb3ZZ7BFnLrWyE=;
	h=From:To:Cc:Subject:Date;
	b=cpr/BJ1mr3K7k5ZC5LudtvWqtuU7sqlA3clss92Tc1eDuvSCRuIDxN/JZttyvTk4U
	 xfCcKCaBX9IJq2z18zRLXKjB39qx/mccPLcJRtVPaitmxmCE710V4ta9BXrmRucqDA
	 3uYk0rguTNt2dK4NsQd1Z75SPCD6MKdCl1oABIHE=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id EF320A55; Sun, 04 Oct 2026 20:59:51 +0800
X-QQ-mid: xmsmtpt1791118791t0clyr4q0
Message-ID: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
X-QQ-XMAILINFO: MtVuuZx9Of9Q8kqEOgsouvcC72uiDLmJwtYoCS+VOfiODem4xYsTUMqZn9XLOO
	 9jTvUzyBkJYnv1/gxnmwIJKw3QIV2FhEkh5XRCy8ysl375HjU77ZSYN/rhucnTyd94We/lzOpShM
	 OqCejj0rRrJJlk4venFnHBDUQK3RgRMc5STVjGUQ8o/l1LdaxH8GzSXrkE9L06V95K4UFBsVCysU
	 ldqOUUknE53uVdlw9hZiU1Q2PhMH7Mo6utIuCAxHNJ2gcsaa2yf/Lwm0yyv/KQn09vA0X4SPN2iU
	 +pQAIvs0Gnh/4OJMdWzisTClW1vT/Z7hgOOoNSz4IZZHdMRcGfSMwN2H36qxQxw8sML1O4nPClCs
	 u18H3wMAGcmxNgBx6r+WMZffhlBTtpDhHEj37ZffR5j+0CbvM5zCkI+q7goEcpEPIBlE6RzgRoi6
	 FnG2uGLiKzYQ1z5I7+aKysCxXqlxFML4zLrAbObTW3BABROioVHe8zXjSoqX24mGZUnGAZJrsygT
	 8bAr2orrRfdra91Q+QMVu419K0VDNStlAOnxgnsPA2rjn4R/moao7XLcukPKxJiN5mJ2wQpjaTFW
	 GYfPZzCbObuCL/8Iyj0GSrgXYYB/IsST5dmILa5TcfHsQKWd8BekcyNmLnLcEUw9HDpeUz1IiV9J
	 GYJH7ywgf1Kp+B5uZkRit6LVWiJZigLCyglSmBBPvfArudBqAVYeYtAZdrt9RCmMNh7d5D57zWYl
	 NOcaQYR9GT9REFeudHD8vzjO54M0BAt4V+COsVLYr4Pkcp9s3bGCjKk5Zvu8lOixImblvIGBxZU9
	 6J7FktDY4K7claMHsNzPq9oP+JhjeiKMF0uxHa+PeRYRl5iD7uePZDFNhJCxjNmF6XJcM/V6YMW8
	 oS4J42xrY2O4QUdrtZw8LdAhfXype1RBnQghD4SgqmZsLPIm+qiwj39utEcBhZlQwgxj9fFUgvTe
	 HV6lmz2DbuMe1o/Fee474JHJIbApPtW9Lu6lgoqwXhm1JePwgbNe/GjOAji/fa9jjkWNlx6EF1nW
	 bByb0NQ4C20w5fsI7ZX+tfQuQfidKeyXaWQfE4dVntW3NCZ2/j0LgACRhIUhvXhoL+uXrx9F8Ymh
	 u3SR/XaBDIMLw2pB6HpI+/04TGgRjZQQ44N9gASwASPDxOuvkQ68iTDGcXRs/Gvjb58yEV1UP1Vi
	 0behg=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH v2 0/6] iommu/virtio: batch the mapping replay
Date: Sun,  4 Oct 2026 12:59:34 +0000
X-OQ-MSGID: <20261004125934.3224379-1-agicy@qq.com>
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

Changes since v1:
 - 1/6's comments now say why a failed ATTACH is reported without
   replaying (the endpoint did not move, so the old domain still holds it
   and its mappings), and why a failed replay leaves the old domain's
   mappings to its next attach, and viommu_restore_endpoint()'s kernel-doc
   covers both of its call sites;
 - 4/6 detaches the requests left on the request queue and frees them
   after the device is reset and before the queues are deleted, instead
   of leaking them (pointed out in review).

Anlai Lu (6):
  iommu/virtio: publish the endpoint before replaying it
  iommu/virtio: queue an UNMAP for every removed mapping
  iommu/virtio: allocate the UNMAP request with the mapping
  iommu/virtio: stop queueing and draining once the device is removed
  iommu/virtio: read the endpoint count under the lock in the iotlb
    paths
  iommu/virtio: batch the mapping replay on domain attach

 drivers/iommu/virtio-iommu.c | 673 +++++++++++++++++++++++++++++------
 1 file changed, 569 insertions(+), 104 deletions(-)

-- 
2.55.0

