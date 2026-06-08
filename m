Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9373B4E9D
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908050; cv=none; b=InM9BIgnRPnDwlYiVxy91XAJCkROXC1bijvxYGdlduT0usuU7zRDL3o+t8ZffTKZkzQUGU3mdN9XutfCXH3+SwjsgJW1V1Z/sbbQPMHauJkcg42Hv5fKae9CA3M5T4kAuFjOsotSLipxs+Sgl9OVBpaEzQdHesWS+RysYp0HeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908050; c=relaxed/simple;
	bh=t7dTtFcMNo1oGbZCogjoqyizO/j3E+pcvyk5ppy+DwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=aQmp62p6zmMPLgqaV1cs/kHVGXcoyVvTDYnrffEQBNNptYlb5NdBQe6r6CoPrxFv0Dg5qWHTUNq3zeKsLPEpz3ktu0YjjlikReG59XAzBtwmuh85otRu1kP3IFBv9VmFzqaEigeATK8p1OJPUCiM30+dcBQXhv6KyihcmiApd7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CyScqIgk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CyScqIgk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780908048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4h2My/REs5Vp77QAaORxbiGwFbWeluHTenTERVDNw80=;
	b=CyScqIgkvbPjDWFTomxC6UduwHqNrPKtxhhsiFk9IvXf8/yPwx9g1rpZMis+yocjJDDAzZ
	Pv8A/xZjjYn7PzRiz//2HwGWeM+8T/9K08bucmiibRHJSOhPUlBfXGNV9j9M+TRRE6Zy+r
	oI5Fv20T8/Jt8Xt9t8ENGFkNtQCTNQ0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-ky2mBoVNNv-LSwgMc5qQ1w-1; Mon, 08 Jun 2026 04:40:47 -0400
X-MC-Unique: ky2mBoVNNv-LSwgMc5qQ1w-1
X-Mimecast-MFC-AGG-ID: ky2mBoVNNv-LSwgMc5qQ1w_1780908046
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef9f0af71so3070922f8f.1
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780908046; x=1781512846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4h2My/REs5Vp77QAaORxbiGwFbWeluHTenTERVDNw80=;
        b=Gp3bq0jFuQgpCfraZ+6Iz95K9AxbYMpEf/Fc2Ec1sQq4MXww6WNaeFRbW2vSZ218uG
         MSyWFq0D5re1Z+0flIoP8F0N+MlTITy5UzhjuYnTXxxSYCJqPdXOvghn1B6uqzfRYjL+
         Y5TlFR4ldTi642nKgW6YDsegeSFUzAkL9q79PGZb/1D6jdhM1rJOcHFgbF6f4lQMYEin
         0pLdwbmxn6dtx09cl4edDrzJx/E3+gCCUWHzbJRbtXOplVqw2TWqysoSuuYsgRloC00c
         z23XhX8RVhLh6eCVn3RiLN6CkD4rcmmhjRxogEEFPle/+bXAwGl1hPYziMjDLN3u62oU
         NptA==
X-Forwarded-Encrypted: i=1; AFNElJ8JsMP2NIO2DV2VuGASS8gMnzhXe4rmNTRKaIxFPgqS/pXxn1EnrlrTeYnh99rZMk4CTrZZm7BfNrenIe8nQg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzi/xX7bPHlN087V77rNJtUju7ZMMuomT4BldJui9zAIS0zfwPK
	LSti74ZpypIy/6JXVnmzlzWygZ12GZ70czRGljowjS2I3nQTu4Qm2X4dJcTr/XYPbytllp64T2C
	Lbs2C6O8oXfyiOHmP5j6EqkINPLbtq8IQdZRxkQ+0tV6g3l1EWcqv3mEuogCOBsQMRk15
X-Gm-Gg: Acq92OG6cQhdbqK6wTAtwz+CV7qpDvRGKiSpX0qvLh+Biuj1qefVGY7dP8wAnUeE1OW
	ZrwvPKg8CwJQyUYTI04jvXSVVm/3SZ8/HQhrdXYBNjS6cmjIDYWOwS5IJbExqORxcDnBb9RDL59
	KYJa7LEFb2nv9O78b15C8hgnpaN3yJB7dS2QUQME5TB46UVtVfMNd540sq4612ux4q5fEishBtl
	XIExycYKck27vuHOSxgphnbEJmC9/rzejGw4kl08UHDQKLexmG4COTXLMXAbOGWOR++cxpGjclQ
	/pUVzDJLAy7SiYrWo0jQe6GJeTAbvVjns8N5yNPptKmUmBDCDJ+C+gM7wAXZR4g+eexgl0U57wd
	f0Rp490CDsmy6oqrQ6xHo5gc=
X-Received: by 2002:a05:6000:491a:b0:45e:f93a:2069 with SMTP id ffacd0b85a97d-46032db4e83mr21033563f8f.23.1780908045890;
        Mon, 08 Jun 2026 01:40:45 -0700 (PDT)
X-Received: by 2002:a05:6000:491a:b0:45e:f93a:2069 with SMTP id ffacd0b85a97d-46032db4e83mr21033456f8f.23.1780908045356;
        Mon, 08 Jun 2026 01:40:45 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm48517487f8f.18.2026.06.08.01.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:40:44 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:40:30 -0400
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
Subject: [PATCH v10 35/37] virtio_balloon: disable reporting zeroed
 optimization for confidential guests
Message-ID: <101bfae36b0f6445ff0189c2b0936648f3f46118.1780906288.git.mst@redhat.com>
References: <cover.1780906288.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <cover.1780906288.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5cN3FGIJC0Ay-QsusPc0-_ILUI6scBF_IPyu4qdPu7M_1780908046
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

