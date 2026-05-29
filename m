Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F87943635D
	for <virtualization@lists.linux.dev>; Fri, 29 May 2026 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780068314; cv=none; b=c83AU+GEF3XAntxLZXWy0h8pCnIRpkOehWfw3tW6LxG90kT5UvlF/5/Wx9kZ20os4eMe/R8mkdyRvRB3KnoXnOGYBjZAOJDFUeovsz9ETHX6wHRjO/H/6NZC1CTAWzWx4LRixeMtFY+Kw4EW8qEKwqiBcTluO1P8Pb+IWxV5r1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780068314; c=relaxed/simple;
	bh=KQP828o7Oia72X2oJuTNYtM9uBAruxIc45lg9ub3w4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tY/MouoWQYjJCLmJb/GAT4g8vguT+DaICsyfE9EU5a8I76sW4CyLiB1VzEMNj85jIYliHuB45Omj4gqdKK+rf7g4aox6m4T7mv87BkSyrtCXy6UVGwSIj6O1ZVsDXItEhx0uLlgnh2o3mYLrhm0bkRym+MzsR3gDVKwmWb58h7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6b0snqX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6b0snqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780068312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3kNatCmWHyttmbkexMBnMmdZ3Q708953lxRldkYnzX4=;
	b=e6b0snqX4PONJePy5k5SX0vOtBlB/ZL+IoRuNKCANEaMPiV7SjiTS6r/IZ6mMbYjFA0E4t
	6zcHRilscTdH5VAJLajqSp7giEOXyNU8zVXOD0IvqtbHK3VQrIyoTQc+bEDXSkCmkX9nej
	zr7paysGx4maSo8RvL62MR5tkoiLG78=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-wh-O1QbzPymY0yAllMI1sA-1; Fri, 29 May 2026 11:25:11 -0400
X-MC-Unique: wh-O1QbzPymY0yAllMI1sA-1
X-Mimecast-MFC-AGG-ID: wh-O1QbzPymY0yAllMI1sA_1780068310
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-45ef0af9517so739674f8f.3
        for <virtualization@lists.linux.dev>; Fri, 29 May 2026 08:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780068310; x=1780673110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kNatCmWHyttmbkexMBnMmdZ3Q708953lxRldkYnzX4=;
        b=TFZF3o7thZydSBapd2VLRGRoeob8Csg1884bRFh7LH6FjuPp/PUyERYFwkgiPd8hme
         /RPKxTfYtRuRw4SLrwVMxNtwqas2CxL5eGKv1FzYpXJDveHS30D4rau9X6lmeivSTTHj
         z/LTFND4SQZhLpbIafRkqzPTKtou21D1vNeuAkhApIvw9HRYKdpgGk0w5c1txo2ChWPp
         IRROiDpXaCxj6CJxbnvT0Y9iUSwQ61a1kD3co3Si6+BOTLxU6bxQir5LPY+4OgcdU1SX
         kprDSBjrCXpJhFbfxjwXn8bdgltiLp8lDYzQ5FipSJ8EAIc4bnAJs7BDxkE1aBnmVAHd
         fTAA==
X-Forwarded-Encrypted: i=1; AFNElJ+L8NNpiitQ5Ff0ri0pHu9DAR40HEaLnHpnJ59hg/eHxPnMNQkVKCyjfdkrLPf0nTppXsAqu68NCMQxtgJu/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVg+3qxNIcTa6yUXzGqZ/fMiDY1xzFc9CqkQ+NkFIYC9se0njP
	rfVHPWi3ipSUafeBLBoZzZJc7HX0m6bBm4X4u+NTrnJE0h9SSyYKrnP4GiDvDKmNfXw2SCUMl0l
	D2ydL0nj49J6y1rsv9UzHa2gWlg+mZCneG7vSYeovHR9zdYOBmaYhtz0lWxwpBCjmYkWX
X-Gm-Gg: Acq92OEwfJnzC0yEnKGqxxvxy6AeUa4R8NyrrOohXKSs3clSHBwBHrVT9Jf0VcaWLC1
	hm1PhDntGkdkE1rEhGks1nic9K8xIefiu15Dic1s2dSVNvn3J8gR6GEuzb/KLYefHpGde1m1aTW
	17Zcqu2tNaU/1PfizC+4+xqcnqEpSlyg6pBi+p17I2rJissxIpXo1efJhUuxJIANTVDlDv1q5Fk
	LgGi5FCsZS6FwZxjA8S2/RPg9T6L/1CWrAI7OxgEp077B3oFYK42l5ZVcKj+7mRtvN/sUYhqMFo
	/k3Po2JcaKP9iHQnmt4X8wcxDuU9/JRQvCsxCLDZC1406pK6wcgKE09MptOav1O+tzE3CxN7tTf
	nIn5niNLs4X9Y2oQkz4sdFanWD97M8dhYLSdQSc7LViYzaaitpbJ6+w==
X-Received: by 2002:a05:6000:2892:b0:45e:f581:6483 with SMTP id ffacd0b85a97d-45ef6b60373mr513523f8f.30.1780068309773;
        Fri, 29 May 2026 08:25:09 -0700 (PDT)
X-Received: by 2002:a05:6000:2892:b0:45e:f581:6483 with SMTP id ffacd0b85a97d-45ef6b60373mr513407f8f.30.1780068309118;
        Fri, 29 May 2026 08:25:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef3556f51sm4162514f8f.25.2026.05.29.08.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 08:25:08 -0700 (PDT)
Date: Fri, 29 May 2026 11:25:04 -0400
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
Subject: [PATCH v9 32/37] virtio_balloon: disable reporting zeroed
 optimization for confidential guests
Message-ID: <1c8bd24b901c36666c675044bfebf498740d1594.1780067978.git.mst@redhat.com>
References: <cover.1780067977.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780067977.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wJPNzUPMpiq6cvqUU8vZ1cjNZXrm05NtjrTiNt_8itw_1780068310
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In confidential computing environments (TDX, SEV-SNP), the host
is untrusted and may lie about zeroing reported pages. Clear
DEVICE_INIT_REPORTED in validate() so the guest does not skip
re-zeroing based on hints from an untrusted device.

Note: currently REPORTING remains enabled and
VIRTIO_F_ACCESS_PLATFORM is cleared in CC environments.
This is known to leak free page physical addresses to the
host.  Whether that, or ballooning in general, is a security
concern in CC is up to the user.  This patch only disables
our new zeroed-page hints where the host is untrusted.
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 drivers/virtio/virtio_balloon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index e3afa6f32ba5..bf1172ad5419 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -19,6 +19,7 @@
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/page_reporting.h>
+#include <linux/cc_platform.h>
 
 /*
  * Balloon device works in 4K page units.  So each page is pointed to by
@@ -1193,6 +1194,8 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	    !want_init_on_free())
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
 
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_DEVICE_INIT_REPORTED);
 	/*
 	 * Balloon submits 1-2 sg entries max per buffer, virtqueue
 	 * sizes are 128+.  Disable indirect descriptors to avoid
-- 
MST

