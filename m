Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7813CAA2E
	for <virtualization@lists.linux.dev>; Tue, 12 May 2026 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778620061; cv=none; b=Dg+6CLqA91E0t85L/OozOzE8CAcjkjIxfO4zYfyXJ3b0a1QY/faC3D9m8ve6XiDtKx+13fjIkHZEgH6txPM+9ef1Uqr/d3snIkKRuPMpzKuSkLPDIvDD5bdoEjeNCcmBpNpCLSPrKxguiGYFPHwzcDqoNTCSIu2BMscyfX8EyEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778620061; c=relaxed/simple;
	bh=dUSL7eroMCveC7qL1a8RxQsVNz0x+gAKUklqgXhGMFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hCd5FxgTf0qHAGw7VNhtt8oM/uy/giI1VGfZ8FfzAT0QGzPMR5m5wGfHSIcHjr/sGH1l6yVUSRq7TkDyFoYem6EqlxYeI6uJ68JwXYjOMXIItREVo/lVG6QCQBL7s67rnD0BCHfhai31fF2mwFlQaZqEx3+JfNXilrLbE6XCrNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=azmWj05v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azmWj05v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778620059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=carebiiwA0WkwpCm1TTKgYlVMa/8U14hyqClEOGQapg=;
	b=azmWj05vUX1SUQKdDn/R8fXHb/yBBhjdC7OHDqN2rixp8HWTLsYW59zHFaYwYOyzuJipdQ
	BlkAA1UOj9Bb7ov8sTFNyIyv6gURosrhP8PPuB4iB4y65haQiM2WAbqnzvKtjczz/leM1U
	0VM2ZkWdCmhOyBMvdO+oFJ91bdRb51o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-_dU0Ymj2OPiEEbx5oq9axw-1; Tue, 12 May 2026 17:07:38 -0400
X-MC-Unique: _dU0Ymj2OPiEEbx5oq9axw-1
X-Mimecast-MFC-AGG-ID: _dU0Ymj2OPiEEbx5oq9axw_1778620057
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d789cebcfso4971075f8f.1
        for <virtualization@lists.linux.dev>; Tue, 12 May 2026 14:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778620056; x=1779224856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=carebiiwA0WkwpCm1TTKgYlVMa/8U14hyqClEOGQapg=;
        b=IFYq0dWXqstYTEPPp+bTGsamzfdtyT6ZIEtn93NSXw/5tmSDOzpf9AWeiwGMimFhlC
         Tqd1jDGeWpY5FbUKBzFv+pn1LhhYDniTSugdlE2MDd26TQ4QikGrZndo50dC4IGNhFSq
         JJKNCLcAYqIEL4QJRT4ih3CCvivCBYLSNGIzmL78vJBFPzWKPK6zE9bAEhk6CoCH9wrf
         7uJm2yNM55qRYZ44ECUMWrfoCWvXKNKBjGe2+tBKDiQ7B8GwzxYTVVkM6xtqmim0RTdE
         X4X7v/1OZtVnSnh1A4xGqPiaSsfN2B9CUgREZT8gdJ6LW0YN8qtM9H1Srl6XsC9jBqz+
         0g6Q==
X-Forwarded-Encrypted: i=1; AFNElJ+uihHzut1EsI8RTAgMgBtAxoiQzIpX6KTMadIGPLuHDI/q4ZFQ4naOWang1r2LHujOT7Mr0/pTune5FhqD0g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcaxbkpeNaynNVjzGbLepnAlEsd060SnLEyBUU2ebOR1xRQPcu
	+V98E1yrd5MuUsugdwWESUvi7tTDa7mfdoQQxbwiIHBBqNi3or+DdB8RUdCZvw8xMUKMbY3bxyq
	t2DUlEAU/k2y8lFeM+uNJmS0WprSrHu1rviBGfHoKLdXbbp3C1X1mmPtw2T3ytPJIDutY
X-Gm-Gg: Acq92OEzr2nYeGqPpVloEB2YjmyxMMAWbLFLoJChDq1+Np2ARhRBcQun1yBnL1vjeK5
	oWp+PwalFiHykYQcvBUCgQxcf29UwDLPvlCh/Ng/ulOan/YIedpRxjRba48kPBSY9Ri3q7v4OK6
	OR3Od/8gTPaFy22Mz1Xzrc9UuURP9uHc5tw7I4fLJuy2UTPDKStUt633g9ZjXjelomjLIHQc9gC
	6M7k8USWoh/FUEGSCxvrCk21JXEO8lNxyOE35ddhmlq9V9fjGaqWZIBLmb9skRWVo1AcFmulyB3
	8zysEOKrv6lrQzpHN58NbR+05j7+0ChA0PtOzMXrpQHAjuM5HT/WgHaaCAeE+sLKWVhrXMPq70n
	Y5GkyekAmKUVGzhB34vBy/0YY3YWlvFsKfy4yw7hs
X-Received: by 2002:a05:600c:4e55:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48fc99275d3mr8053525e9.8.1778620056281;
        Tue, 12 May 2026 14:07:36 -0700 (PDT)
X-Received: by 2002:a05:600c:4e55:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48fc99275d3mr8053095e9.8.1778620055793;
        Tue, 12 May 2026 14:07:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d1986fsm19697375e9.3.2026.05.12.14.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:07:35 -0700 (PDT)
Date: Tue, 12 May 2026 17:07:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	virtualization@lists.linux.dev, linux-mm@kvack.org,
	Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 27/31] virtio_balloon: disable reporting zeroed
 optimization for confidential guests
Message-ID: <cb436acb343cef1282f380cdb68f2aee53ba24fd.1778616612.git.mst@redhat.com>
References: <cover.1778616612.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778616612.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VRtDyq458KPoXuvoIryGIGfwFaMXkI-qkvvu7yGjGr4_1778620057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In confidential computing environments (TDX, SEV-SNP), the host
is untrusted and may lie about zeroing reported pages. Clear
DEVICE_INIT_REPORTED in validate() so the guest does not skip
re-zeroing based on hints from an untrusted device.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 drivers/virtio/virtio_balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 6586699396b7..02d21147d4c6 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -18,6 +18,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/cc_platform.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -1190,6 +1191,8 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	    !want_init_on_free())
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
 
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
-- 
MST

