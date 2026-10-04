Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF7F450403;
	Sun,  4 Oct 2026 13:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791118898; cv=none; b=VaLFP6w/hcKakOHA2P0TCfE751YQTH8gLiISL51BfCcq+av9L0hprDQ4gH6bMjy4eqtnGt8OhbaN3T92v/rLGxpucsKjng4rxh09AxIQ4ZcK60r36F5N9LIMycWMSidEhZGA2abHiFBJfbe/vgTDjWZDLdVcXBMCU59G6EKG95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791118898; c=relaxed/simple;
	bh=ZO8isj3UJhPLY4jS935P6K7dL+icMSTJSQ/giyJq7Q8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=pfEKWEbBhMvJoJbMJekHtsoap80vzgnKt0TlILKq+11Yyj8SR6Yq+jrbn47+X4pbMrZLXnTtPYwhi/m44V0qmjq/95lqETznvDkUv1V5l9Oik5SbeD1lHl/KzmPCaxUs2V3varw1DU1lbgEOsyTCS8y7DbNb/Ks+VS1+qvkVB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=rTiocX6x; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="rTiocX6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791118891; bh=vhMSXwat1tJQPzFTZ+qtcGezuAY4dB8KDS9yTfBi6wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rTiocX6xTQ478nBaC79OG+mxbbBKt2A5RERjiwQPHGnE6f2vyMep3QoTO+1hpuF9x
	 TB4JAbOTJx/P+ekEML1WUBWwJI7c55p+0AtZBPxeT5pu4jt/ZpXCo7RDbWPyg+spqj
	 hzinYZbSkVaJj4ncLbLq3iitgbTPdZt4QVxCoWqI=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4EAF2BA; Sun, 04 Oct 2026 21:01:14 +0800
X-QQ-mid: xmsmtpt1791118888td03605do
Message-ID: <tencent_B82D6F251AF7CE66EA71E7479C15BAAE5606@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X6pDMzNGuWCZqZx+I7Jt32lp5LT5VlpIrt9PZXuSW8y35nMY6Uv
	 Z534HWgijzA8+JZtp2+jzCHHae5E1Qd1eVX6n6fnTtsYUh8/gFDJ+saQthE2JH5zqo/4z7dhb11x
	 7F5lrdQ6c/oiHTzsBou4AXy9uYf+R5GiksbA6GBNtvTGm4+lGup91vuBZultWEP4a4KC08jG2wK/
	 DpwP29x5jsufbU7zQlgQeCIBmQS2siVUj5oyOZO9SWC9wk/rJYZPHwRK6zpgXgcNyEI/d2JdMkn4
	 lSLiKI1/CqGnCwEFvHRopSF6yVArOumpnhCCx5f5si6TEpZPX5aQePvli/DJTezDBJ5ln+5LSaE2
	 espkaxQWlyjfyWiHhlB55Y7OUviF/LJsB4y2umrCr1G4kJPoJrHo31kOBgyXBCR5zq46h2eveL+E
	 RAYBdWZnPbm+Bkr/Bipf0BBM4v5Ps8uGtxjkzEsYqKcBNoC5leuIsFkuY94Ru/SXBxq9cm8P5K48
	 l74oDm32qiKsqZxoH2ONhyYTXWrohHF12ZeCpSR20jE3oM5jMJdRyLE28QuNn8mUQVUYrsweSC9/
	 Qcno65MnK+Z2+VBWx0Z1Xus+f1TspPu1l6YYgjtyGOr9sUqaKvXiTFseEkMQmGeoGIsqPrBZjqm1
	 tHr/A9pyKOZyQzRnlpe459fUr/lXz3AatC6Emgy/zQY9CQLQ2qHIf1H/lM+DS7pQ95wNwe2vRyru
	 Ll3MvLDZakZhN+xGqpEPwMgQeN7TG+PD7bDQUDLo23zg3h+SlvKHm8IaQv/RIEqMMd9B8RkCH8Mc
	 kSjd2jDx4sadjak+Sp7EvmohpF16yuDXOgQZAsVprsfw8NVI9uOzxL3vJidATp051mSZne6jYJa3
	 voh6yWmKGMYp3hvK/mlRuMlm3xCLjmUQoOPRqlLXJcuJ9yaH0wMAX+VSk8EEOXiaz7GkOsvq5z3P
	 VKzOfwr46Mwu29KH8BDDYj7WF009HnhMsQhaSfR0LFerfhmpIlslPnXrRCW6seywXsgFrU3XTnTr
	 RsxXFaWSMqmf9CVptEVgiWvZIPgZw4E5b51rAXkfWvaqHpcltxhn8jCmkXwhSWXtuGfIbhdrGLt2
	 u23QhK4utStAw/984EeO10CSJGNhQJvNhZnG6byIATf1R7X8YUtvGaNluHwIf33OkXcBbIaGHNyn
	 t1ayGgyVQniw2NhmqlFlypxamK
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH v2 5/6] iommu/virtio: read the endpoint count under the lock in the iotlb paths
Date: Sun,  4 Oct 2026 13:01:12 +0000
X-OQ-MSGID: <20261004130113.3225005-5-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
References: <tencent_D757B544955DDC509B5DC7161F425620BA08@qq.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

viommu_iotlb_sync_map() and viommu_flush_iotlb_all() read nr_endpoints
without the lock its writers take: the one place left after the endpoint
helpers were introduced. Order a sync only when the device holds the
domain, and read the count under the same lock as the writers.

Signed-off-by: Anlai Lu <agicy@qq.com>
---
 drivers/iommu/virtio-iommu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 7119030dbcb3..8a93d5f0668f 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -131,6 +131,19 @@ static bool viommu_device_live(struct viommu_dev *viommu)
 	return !viommu->removed;
 }
 
+/* Does the device hold this domain for at least one endpoint? */
+static bool viommu_domain_has_endpoint(struct viommu_domain *vdomain)
+{
+	unsigned long flags;
+	bool has;
+
+	spin_lock_irqsave(&vdomain->mappings_lock, flags);
+	has = vdomain->nr_endpoints != 0;
+	spin_unlock_irqrestore(&vdomain->mappings_lock, flags);
+
+	return has;
+}
+
 static int viommu_get_req_errno(void *buf, size_t len)
 {
 	struct virtio_iommu_req_tail *tail = buf + len - sizeof(*tail);
@@ -1287,8 +1300,10 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
 	 * May be called before the viommu is initialized including
 	 * while creating direct mapping
 	 */
-	if (!vdomain->nr_endpoints)
+	if (!viommu_domain_has_endpoint(vdomain))
 		return 0;
+
+	/* Wait for this batch's MAPs, whose outcome nobody looks at */
 	return viommu_sync_req(vdomain->viommu);
 }
 
@@ -1300,7 +1315,7 @@ static void viommu_flush_iotlb_all(struct iommu_domain *domain)
 	 * May be called before the viommu is initialized including
 	 * while creating direct mapping
 	 */
-	if (!vdomain->nr_endpoints)
+	if (!viommu_domain_has_endpoint(vdomain))
 		return;
 	viommu_sync_req(vdomain->viommu);
 }
-- 
2.55.0

