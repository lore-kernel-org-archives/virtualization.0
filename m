Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B543BADA7
	for <virtualization@lists.linux.dev>; Mon, 11 May 2026 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490259; cv=none; b=cuZB1ojMucEb2p9XZUZQfDL0M1kFg04OY6HRKc6plAVVSELIo2lXqjz7CamGHklHXuRC+0roRHraWaNtieWmxFM+qJeY71a+xhYElDZYfYlbTA75mTsKwJAQ7zRphEGHFDYBS0d82ePhFw9vas3tWuIuGn424uSxoQuXbP0QXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490259; c=relaxed/simple;
	bh=hR2o2io1GAVOsJv3zXjIRMgKCnEd5FQaTzCnowpFuV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=gLFpJUNByJ7gt20jZonu/Bvzr+KBR2+Gq88AqTdvWf+W8YOjFBGRfb7H7XFNWmE0nrK7t9VZFhgSZid33JXjuM15UaUg8GJvbry/zd99OAwImBToM3yE4pUzk2x7vSHnl7EsNeQESS9kn+mGYtwjPHF5Vw+HXPiZqZhjt4Co3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZRhiSBd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZRhiSBd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2QKjWRUGZavYM1HdL6nJ1yLQpyzjFP+uSIPdSalIxY=;
	b=UZRhiSBdxKcdFP7s0k8zsQF8D0haiN/wCE3PSVVxRxkbOVx2DKjx+YZGaIGTXMnmI4zyzC
	oUD1Sh2zQwaYJ2N43AHH+i0TcyVTcZqasZt9iU1RhKre+3h7sROO/tWuRbhuDQTHGK+iDG
	zdbtcXGBF3DPJj2qokV5r7ZoSWTq2qw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-nEh1HuDCP5axljgg2OIPtg-1; Mon, 11 May 2026 05:04:15 -0400
X-MC-Unique: nEh1HuDCP5axljgg2OIPtg-1
X-Mimecast-MFC-AGG-ID: nEh1HuDCP5axljgg2OIPtg_1778490255
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-44f1b4d0fb0so2721874f8f.1
        for <virtualization@lists.linux.dev>; Mon, 11 May 2026 02:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490254; x=1779095054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2QKjWRUGZavYM1HdL6nJ1yLQpyzjFP+uSIPdSalIxY=;
        b=WMUc8SlVJxRnUei7350WqrHJ3hYHpkOOMMnpZk1SqEWLA+1tBuIU0HGr6rH2NXVMl7
         ictmGJ0R28lcEyGGD9eIPSOuL+6MH3K4PKZpbas/0133ookaZk+ke76fscWtDLuxhU6p
         diNuPyrgE60mDHOzhhWexcsNfDsVv1S4ZjboPBVa8AV3MNnBNmd5dPIKDYtVxR67ogTS
         Qp8Yr8gMf5NWznLyC/YPOrkmz6KFdzLwmlLGnBdW38aI/2S2qRIAYHbQhBgVhbN7OcxL
         FL9rgiV0C8kfaKEIVp4EBKYdV9TJPRqg8JW9dzEvGqy1c8a/Ly2N2JMlBBv9iz20UZN/
         tjyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XYR8uLQy33V71vNtppocGlk4bqhMZoIhEl+z/gM5PL7+qX7bz1AInwXc4PlA5t+Iz1QLgpsQd3jMhqHMeyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz91InPU5b+YDpsFwUiYE+vTLrFUCaSuDuxpqqY5cmw4ZEYOzj
	RMAg8AYBPxK0PZU8Itc/564gB9C5BwdzbaFx+19djAUwE4KFitl2dHVvOvGRkxQQ00Uvn/U4Pme
	VFvZ3klv2IhyNA18V7CygmausxP1IMLSFVNlqjM0F0DLdy6raEYRnkwnfGElYMEF9pg/1
X-Gm-Gg: Acq92OGx02JKtXlBMfAooqXT0JqV1/KMlnWYrvGdWobWt0WNR0D+8sXZ0Djuorn5+1+
	f+SbAWVVdo15ZkveSkm1pQCyh46gmOL+B9b3nT1gsop/IGNpDeSaRpsxpKWtOd99EHsJ86wfH4L
	gDBTOINksHKpHsMePL/pV6pH5LBUHgPI0U9+GQmfylOOdOmtmaGOVZOdXmUMMu6gSltck29x0tA
	mjvr7OukSvANRCxUnbnoYcR6UC6M/uBsI+Fel5ytkd/cDJ9vLlhdVlZtsKhh6JGvuF5A+NV2hky
	8djczXxtge0ce3Ta7C2kZNjLINRedRjWjDKBr/axArY0Ft/Wg0ZD4CeFHcELam3ukch4FC+bogf
	8Bpnt0UrOwXrWbAuq8Y1TByLIIyTVG6HVOGzNxqxO
X-Received: by 2002:a05:600d:1:b0:48e:7f1c:8760 with SMTP id 5b1f17b1804b1-48e7f1c87bdmr67342725e9.27.1778490254419;
        Mon, 11 May 2026 02:04:14 -0700 (PDT)
X-Received: by 2002:a05:600d:1:b0:48e:7f1c:8760 with SMTP id 5b1f17b1804b1-48e7f1c87bdmr67341395e9.27.1778490253720;
        Mon, 11 May 2026 02:04:13 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db0b08asm78949215e9.8.2026.05.11.02.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:04:13 -0700 (PDT)
Date: Mon, 11 May 2026 05:04:08 -0400
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
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Subject: [PATCH resend v6 26/30] virtio_balloon: disable reporting zeroed
 optimization for confidential guests
Message-ID: <77585f29352cb5fa235898db07e7a3fa04d4d04e.1778489843.git.mst@redhat.com>
References: <cover.1778489843.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1778489843.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4OArvZjLOtDnMan-12dbDZP2od5iA-gKKluaOf14CHw_1778490255
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
index e5d11782ce41..d1cdb904d60b 100644
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

