Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82806130AC8
	for <virtualization@lists.linux.dev>; Fri, 14 Mar 2025 21:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988304; cv=none; b=I9/zeZhZPoakQfrS8lkYRfrTSmtb7mtdL/nyAblxOAxpV00TlzLStX0Dka5J2yffQsa7NJpWcdyPwVdejuY1thO6qgfVsdNfITGJeDiWG2sFqeHL9Mge/BVdaJwnTvSa2lVOsHCx6pz+cg2JQpa+nXtxhQp9CFT+w+NjUmhFZv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988304; c=relaxed/simple;
	bh=wUKSvD8vwF3thpgoejutr15OJKzXA/OuDmMmmBeuNF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CbUr8a1oVUBMayJlF8tzbpxfJ+j4bl4lmFn4OSiS9n6GyOmB1sGHeycr9UtmxXajFbc/hFAAoeu7dxz02iKbxyGyeXZNoKE0GTiF03PdozXg21DVPHQgwtTPaJCZwF1DLgs8cieqMoGlessri8jVW23O3oaFSG9VAZTIbZTrRmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElnJ1fcO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElnJ1fcO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741988301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x8R8SnT0xlNk6NOCsego5+xxOFgcolEZepoyw3FUxJU=;
	b=ElnJ1fcOW07n+mt4t6nHqTXTKPjrtpVBcTXyj0cKMLX3dofdWjhVqHzCBLfP5Dtm3X1/Ih
	yZTP4sYZ8D6CVY8yy5Vd55cP8wb3/BS3yP+0iVZaZ1UXgm/BUB0CvPjMVIgRmylFwMOgml
	Sd1vmy8zW4rqWRs4LtJmpzBI4BnPlpU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-Z7N13xufNW6XUwaNZpccyg-1; Fri,
 14 Mar 2025 17:38:15 -0400
X-MC-Unique: Z7N13xufNW6XUwaNZpccyg-1
X-Mimecast-MFC-AGG-ID: Z7N13xufNW6XUwaNZpccyg_1741988292
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 898481800258;
	Fri, 14 Mar 2025 21:38:11 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.80.88])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 20D901944E42;
	Fri, 14 Mar 2025 21:38:03 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	virtualization@lists.linux.dev
Cc: alexander.atanasov@virtuozzo.com,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	mhocko@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	jgross@suse.com,
	sstabellini@kernel.org,
	oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org,
	mst@redhat.com,
	david@redhat.com,
	yosry.ahmed@linux.dev,
	hannes@cmpxchg.org,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	kanchana.p.sridhar@intel.com,
	llong@redhat.com,
	shakeel.butt@linux.dev
Subject: [PATCH v2 0/4] track memory used by balloon drivers
Date: Fri, 14 Mar 2025 15:37:53 -0600
Message-ID: <20250314213757.244258-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This series introduces a way to track memory used by balloon drivers.

Add a NR_BALLOON_PAGES counter to track how many pages are reclaimed by the
balloon drivers. First add the accounting, then updates the balloon drivers
(virtio, Hyper-V, VMware, Pseries-cmm, and Xen) to maintain this counter. The
virtio, Vmware, and pseries-cmm balloon drivers utilize the balloon_compaction
interface to allocate and free balloon pages. Other balloon drivers will have to
maintain this counter manually.

This makes the information visible in memory reporting interfaces like
/proc/meminfo, show_mem, and OOM reporting.

This provides admins visibility into their VM balloon sizes without
requiring different virtualization tooling. Furthermore, this information
is helpful when debugging an OOM inside a VM.

V2 changes:
- Add counter to the balloon_compaction interface
- Dropped patches for virtio and VMware as they use balloon_compaction interface

Tested: virtio_balloon, run stress-ng, inflate balloon, oom prints
Signed-off-by: Nico Pache <npache@redhat.com>

Nico Pache (4):
  meminfo: add a per node counter for balloon drivers
  balloon_compaction: update the NR_BALLOON_PAGES state
  hv_balloon: update the NR_BALLOON_PAGES state
  xen: balloon: update the NR_BALLOON_PAGES state

 drivers/hv/hv_balloon.c | 2 ++
 drivers/xen/balloon.c   | 4 ++++
 fs/proc/meminfo.c       | 2 ++
 include/linux/mmzone.h  | 1 +
 mm/balloon_compaction.c | 2 ++
 mm/show_mem.c           | 4 +++-
 mm/vmstat.c             | 1 +
 7 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.48.1

