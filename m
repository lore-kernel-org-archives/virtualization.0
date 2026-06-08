Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBB93C13F9
	for <virtualization@lists.linux.dev>; Mon,  8 Jun 2026 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780908006; cv=none; b=A7iphtHctcAs7OwV6JrA7sbwrskq+WJxv+W2044H/nNn6RPi7wZCPkUHErVih1hBiVW5BYl4ylxq5keibHrkynWWBpHcl2OGqwZ1Hu4Fxigz/ue9XKsUnoSSrm3UeX+gyU38cHBxCIU/TZe2w1N0qYuy24ynxOJreBRXS5UA9OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780908006; c=relaxed/simple;
	bh=5wGTQWwTRWiz92QjrAnqbfvJyoSWYuOrxYhosbDCVVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kkOR0shcIScHy4vl6r9yefIH7plGmM468HzOhrYU1nyqHOAd8+gNcAmrzQZAf92CfZ0oOzL6oUbUwqxDgAWUdXqip2MeK2UX7s9bd8ugWhTUSq81+upY59IbSmGUL0hudS+YFYe86G0aXFYg/dFV2AvcHTWBhosPptR5WSrWtYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NaTnWor3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NaTnWor3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780908000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w/d/SpfWsyx4WFKJs+ZrOIC973gnVs56nqbJSdvDWbI=;
	b=NaTnWor3bRWWSxIbwABgGIAOYs6wJeflVzD8DUnbJjZj68pRBHJWJkKM/tvlxMZA6F+YwA
	ZIpB2ot0IY7VlQuDYCE03LvX4ZzAGS8z+EpHUPSslMc3TZT+lRsE9FHFP9hihO4sySoRFz
	dLhAbA6EQ+jS+gLnECj5juGkj6WADig=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-gcoPenzdMIqfIwermyAlsA-1; Mon, 08 Jun 2026 04:39:58 -0400
X-MC-Unique: gcoPenzdMIqfIwermyAlsA-1
X-Mimecast-MFC-AGG-ID: gcoPenzdMIqfIwermyAlsA_1780907998
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45ef6417092so3351286f8f.2
        for <virtualization@lists.linux.dev>; Mon, 08 Jun 2026 01:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780907997; x=1781512797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/d/SpfWsyx4WFKJs+ZrOIC973gnVs56nqbJSdvDWbI=;
        b=qex0coU6qBoYlqwQYfEuEar0/oZMGv8hXFFNHuX46BJaTttfMZcQ8tf/YLUqmhGrtU
         yJnxTQxCp1J6iahXhiwQDWfDyYEa10XGirIVjPcnBeuRD3z/TmVABueDdPY/rm+dxLTS
         kqztyeU9U6i+iUT86Qs2Sl1G+xfzB7oL3VscDF7+yC+wU7AWXwOTB5Lsy6Z2WqJb4Huz
         MvKWWAP+/lf+MNASVXHlGW4yyXV4eghFNoxbWW392UhDVogFEKfIKsijJUBJc6E0EDdm
         P5DNstwaokT7eL4dCdGXDOGJgjxRtwC7cQ0Z41q/Vv4Yh74iihXqlsXC1qo/077jZsq5
         R2MA==
X-Forwarded-Encrypted: i=1; AFNElJ84EZ0ZDpNQpVsD1dhuu7rutHJqgwfQPogBrhWU4zxoNRf8nA+bGLWO05j7y2/8HUboRReVgyq7a/wPJGg9Eg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj6mmDbogMjVIymazZDeyLFuh7vwopklEQZYMesX9FZibeeO9P
	dB420nibVHPye1dnPtLsGIngEq8xhtlaDW5xKUnL/gYBoVOZedyFe68eRphSgDCS1Gbv5QxAcWs
	bODcu8hbGu40bRzX9ftYTPYY0DMgVkRT+wXnO0hTCSFPDAjOOb2ACuHA9K4r1ZzYnvdNn
X-Gm-Gg: Acq92OHwkpf9wNsfNhOlAKFUqg+9uXHaObQ2AEkJUY+r8pocY4sQgjbecMaHHQwODHk
	HY+SbwSsjIBkUJCVlXlrjfSkGJlNvovYMk8FlGnA8d9xCV2yILlY7ZI9yM7ZSRQHDjRoDjbqptE
	NevpoVZALJIoeYSP2Sj5TtWq03S5BXptee5pz0KsvEpbiw2utTsuSDPhbcIDlnpJdIFKiRLS1nD
	FDQqkhX3PToo3MuMU1/bTx/XhskjYahKSLad30C3qpSqTGaCKxqPZZbuOO/I/h8oHHHlg3sQ3Sv
	pN+1xacWgKpOUJ0bk/i2QOUNKwVbT/Mc4TG8TNvaPlm/OLVxVeAyByV4KFi8BQTn3dZ56zm1M5D
	lN61+fRImOduJiyUXxTbtlwg=
X-Received: by 2002:a5d:6e84:0:b0:45e:f2bd:2b17 with SMTP id ffacd0b85a97d-46030501f7fmr16740270f8f.21.1780907997441;
        Mon, 08 Jun 2026 01:39:57 -0700 (PDT)
X-Received: by 2002:a5d:6e84:0:b0:45e:f2bd:2b17 with SMTP id ffacd0b85a97d-46030501f7fmr16740213f8f.21.1780907996901;
        Mon, 08 Jun 2026 01:39:56 -0700 (PDT)
Received: from redhat.com ([31.152.37.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344558sm48512372f8f.18.2026.06.08.01.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 01:39:56 -0700 (PDT)
Date: Mon, 8 Jun 2026 04:39:49 -0400
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
Subject: [PATCH v10 30/37] mm: page_reporting: add per-page zeroed bitmap for
 host feedback
Message-ID: <a9d591e7cf886f4752949c744acfd36eb4ae74f9.1780906288.git.mst@redhat.com>
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
X-Mimecast-MFC-PROC-ID: lHloV-IGgwAcr8U-RM0IPvOOr1GIm3o5Oxfy1nx3p0Y_1780907998
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The host may skip zeroing some reported pages (e.g., due to alignment
constraints or bounce buffer fallback in QEMU).  Currently, when
host_zeroes_pages is set, all reported pages are unconditionally
marked PG_zeroed - even ones the host did not actually zero.

Add a zeroed_bitmap to page_reporting_dev_info that the report()
callback can use to indicate which pages were actually zeroed.
The driver's report() callback is responsible for managing the
bitmap: zeroing it before sending pages to the host, then setting
bits for pages the host actually zeroed.

page_reporting_drain() checks the bitmap per-page in addition to the
global host_zeroes_pages flag.

No driver sets host_zeroes_pages yet, so the static key is
off and the bitmap is never read.  Behavior is unchanged.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Assisted-by: cursor-agent:GPT-5.4-xhigh
---
 include/linux/page_reporting.h | 7 +++++++
 mm/page_reporting.c            | 8 ++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_reporting.h b/include/linux/page_reporting.h
index c331c6b36687..e2e6a487ddab 100644
--- a/include/linux/page_reporting.h
+++ b/include/linux/page_reporting.h
@@ -17,6 +17,13 @@ struct page_reporting_dev_info {
 	/* If true, host zeros reported pages on reclaim */
 	bool host_zeroes_pages;
 
+	/*
+	 * Per-page zeroed status, indexed by scatterlist position.
+	 * The driver's report() callback must clear the bitmap,
+	 * then set bits for pages that were actually zeroed.
+	 */
+	DECLARE_BITMAP(zeroed_bitmap, PAGE_REPORTING_CAPACITY);
+
 	/* work struct for processing reports */
 	struct delayed_work work;
 
diff --git a/mm/page_reporting.c b/mm/page_reporting.c
index 84ebc4547119..9c39448e758b 100644
--- a/mm/page_reporting.c
+++ b/mm/page_reporting.c
@@ -108,6 +108,7 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 		     struct scatterlist *sgl, unsigned int nents, bool reported)
 {
 	struct scatterlist *sg = sgl;
+	unsigned int i = 0;
 
 	/*
 	 * Drain the now reported pages back into their respective
@@ -122,7 +123,7 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 
 		/* If the pages were not reported due to error skip flagging */
 		if (!reported)
-			continue;
+			goto next;
 
 		/*
 		 * If page was not commingled with another page we can
@@ -133,9 +134,12 @@ page_reporting_drain(struct page_reporting_dev_info *prdev,
 		 */
 		if (PageBuddy(page) && buddy_order(page) == order) {
 			__SetPageReported(page);
-			if (page_reporting_host_zeroes_pages())
+			if (page_reporting_host_zeroes_pages() &&
+			    test_bit(i, prdev->zeroed_bitmap))
 				__SetPageZeroed(page);
 		}
+next:
+		i++;
 	} while ((sg = sg_next(sg)));
 
 	/* reinitialize scatterlist now that it is empty */
-- 
MST

