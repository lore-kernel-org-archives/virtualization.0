Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6387935BDCA;
	Thu, 15 Jan 2026 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768468893; cv=none; b=siFL9YbDiM5Cc306KYYNnRtZS7mV9M4wzolGJ9IlMDL86keyPE7pWEnbA6EnoQGliNeu3+i57MtckVXXpINXNOsD1z+gOB0ReJBeLkhxZx7GafYlKv4HXhv6EJYvWe39L1wT2fjC1bnvI9yA5UBfVBjNUZq3PwMw5Ouv78jI/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768468893; c=relaxed/simple;
	bh=6msByTrRia9i6vND/vW1jweXAy1e72/r1CKD4n734CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNgA+eUb3PYn61a6qmgiyB3Thbps553EldA+btYzRVprf5KHc8BMXOYquwji+uxX2xry/BlaSks+oovzONvcYq1u4Zx9+8wVns9o6REv5NN1aiSZ/5G2Q9j6ua9DGvDN4sXbB5hF+S4WmKzlubyLoZFqcsmBj7CB7MEzqoFVRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qu5cnsss; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qu5cnsss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D840AC19421;
	Thu, 15 Jan 2026 09:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768468893;
	bh=6msByTrRia9i6vND/vW1jweXAy1e72/r1CKD4n734CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qu5cnsssHM0VOA2MGc8aTwkHs5DfKAxz8/KwFTSko1lI+ScylNG3t6KiXREGnGYG4
	 bbajnHy0fVOa5j3ek1JI70AVPeN+FZW+TEy1INoJw+F2pAFEGzIjvs7q8F0zIqdheB
	 5SIpjUgk5E9J67b6iBFVQmoZiYC+BeHVbM658tP0rwFlhllNOQDloLuGo7VYiWbeIk
	 ORaDqAHDYEraa10Y7nrOVGW6wIKuRACCqbuew8ilXlfJ2fEj4fTQYD4OTtSs52Uagr
	 8ZwIkkfcpdPLwwkRUB5iFUqhulaWwTq3TRtoMlYOChCsWG1c1YUkGSDalb9T3rxaXa
	 W4fHfh+JcLDbQ==
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-doc@vger.kernel.org,
	virtualization@lists.linux.dev,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v2 10/23] mm/balloon_compaction: drop fs.h include from balloon_compaction.h
Date: Thu, 15 Jan 2026 10:20:00 +0100
Message-ID: <20260115092015.3928975-11-david@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115092015.3928975-1-david@kernel.org>
References: <20260115092015.3928975-1-david@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ever since commit 68f2736a8583 ("mm: Convert all PageMovable users to
movable_operations") we no longer store an inode in balloon_dev_info,
so we can stop including "fs.h".

Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
---
 include/linux/balloon_compaction.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 7db66c2c86cdc..1452ea0635245 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -42,7 +42,6 @@
 #include <linux/migrate.h>
 #include <linux/gfp.h>
 #include <linux/err.h>
-#include <linux/fs.h>
 #include <linux/list.h>
 
 /*
-- 
2.52.0

