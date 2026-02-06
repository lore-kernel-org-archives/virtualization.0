Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECAF1DE4FB
	for <virtualization@lists.linux.dev>; Fri,  6 Feb 2026 00:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337652; cv=none; b=euRcxsEPN11FD9OM2vkbbM/M+Nta64sh7+qdWwJ324FdG0KDQhntAAPFwznUJ9JQOVwh9wq3pvPnQaUS0JwqktPOBjIpX+VZf00pVRXvA0J4t8tWWHm6lrUJP7qF+EdsDFQ10H4d+Otg8oYcOV7sVLVqaEsgeWO/3BNKV7/cYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337652; c=relaxed/simple;
	bh=1RARk+ZNBucupua7AOknp++jAAXf65IB9iVB1hXUpEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uo3MZJLhVj6NnUsdCPX4x5kZFQ6+1IMvEplStVWy1yR+pJI5B0L7daiEAgHR3AQti79znVx4rIdqPAxzoCnQodsat5nWwv9t0uvUd1+su2RX0E3hV5yg01Hb2EJ0BfNSXMcKUGr9sTdYJ7zRLy0wEHQpv9Cf2NmNyrUwbll2QF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=lYtpQLRi; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="lYtpQLRi"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBT7b3292284;
	Thu, 5 Feb 2026 16:27:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=zWt8nkIjO0eKVZt1rqRs+WhnwVduqp4MDpiVTgTyz1E=; b=lYtpQLRiFFm1
	e7/ELFefKlhPqRhRORh239hXyj7CZszXX+9LA9nmXqvhoo87MDZVBMScjtNBA3Aq
	DvmJL9oOs5EI/R4nRB35uwz+5ADOauC01AOWV7UUHqulCY3lS5/PjvMSKodXTqTV
	cNS6EaTuzvc9ulGOdfckyUnRPB+99mA+Az+pIiqBoZpw9zdXBN+gg5/IhvxpIrD2
	spg6CJZavBBhHK7AbTzkNTVWR0zMu8o85Pa9x894o82TH2h1R0AiWKZb5rn2nnpk
	BQbwsPsNIYGyiaoeuLDug6ZZL+JtqaOxYxyu6WFqto1TqswzNuc2lFDAdovucSb2
	qtgAbIXxUA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4x2spd6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 16:27:23 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Fri, 6 Feb
 2026 00:27:21 +0000
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
Subject: [PATCH net-next v5 1/2] page_pool: add page_pool_frag_offset_add() helper
Date: Thu, 5 Feb 2026 16:27:14 -0800
Message-ID: <20260206002715.1885869-2-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206002715.1885869-1-vishs@meta.com>
References: <20260206002715.1885869-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YjZH3TCYAu4GQR4IyH0Gx9wr3UozoqWe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDAwMiBTYWx0ZWRfXw2AM5Nk23L6C
 coQ8dqF2Mf07vJVAlpeDHYcxQlduRREi5d7Wl13y6JkafyU9VAEUT67qo4iy+eCGxRvC3hS3Mxl
 j9CzNsIBAjZ/C28wUKA+KVVgn/9gg8qFhWxLOtec0EWUAzJxrqhd0qyJ0pYtCEm0r6t5VtmLC+d
 2/W3HbvzZpN/i6C4ozJEO5/n9j6Snxu3DkVdCgV+GSK3BSKg3tP9HO5ln2rW4C5I7kx/5YmrpfY
 mjvdtZBSTH+ymJwBFV7b+4nBSEmRx4OrJyE6maKd3Pl5gOn7RHlRXIMU28CiGVhmW0qoZPoSYv2
 kZkySvCjETl39Y4xRXSKLf3z/z00v4V9DfJNt1s9aeo15GocSf/ciQXRQpEc0RzpFJpWZ0PWed+
 duLRoO97mISYqy7y0ecn8pptGOnjuaOK6+96Cbz09//Jzxfdws76ST2FuVSxR0ZR4FOuu1Tnx/y
 qybG2c0mYdaRC2fn/9g==
X-Authority-Analysis: v=2.4 cv=aPz9aL9m c=1 sm=1 tr=0 ts=6985356b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VabnemYjAAAA:8 a=rozs98Jf37xvrOoLKDoA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: YjZH3TCYAu4GQR4IyH0Gx9wr3UozoqWe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_06,2026-02-05_03,2025-10-01_01

Add a helper function to advance the fragment offset without performing
an allocation. This is needed by drivers that extend a buffer to consume
unused space at the end of a page fragment to avoid internal fragmentation.

When a driver uses page_pool_alloc_frag() and determines that the
remaining space in the page is too small for another buffer, it may
extend the current buffer to include that space. However, page_pool's
internal frag_offset is not aware of this extension, which could cause
the next allocation to overlap with the extended buffer.

page_pool_frag_offset_add() allows drivers to advance frag_offset to
match the actual consumed space.

Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
---
 include/net/page_pool/helpers.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/net/page_pool/helpers.h b/include/net/page_pool/helpers.h
index 3247026e096a..14907c3badae 100644
--- a/include/net/page_pool/helpers.h
+++ b/include/net/page_pool/helpers.h
@@ -96,6 +96,26 @@ static inline struct page *page_pool_dev_alloc_pages(struct page_pool *pool)
 	return page_pool_alloc_pages(pool, gfp);
 }
 
+/**
+ * page_pool_frag_offset_add() - advance fragment offset without allocation
+ * @pool: pool to update
+ * @bytes: number of bytes to skip
+ *
+ * Advance the fragment offset by @bytes without performing an allocation.
+ * This is useful when a driver extends a buffer to consume unused space
+ * at the end of a page fragment (to avoid internal fragmentation), and
+ * needs to ensure the next allocation doesn't overlap.
+ *
+ * Must be called in the same context as page_pool_alloc_frag() to avoid
+ * racing with fragment allocations.
+ *
+ */
+static inline void page_pool_frag_offset_add(struct page_pool *pool,
+					     unsigned int bytes)
+{
+	pool->frag_offset += bytes;
+}
+
 /**
  * page_pool_dev_alloc_frag() - allocate a page fragment.
  * @pool: pool from which to allocate
-- 
2.47.3

