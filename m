Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EA43BDC8;
	Sun,  4 Oct 2026 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791115058; cv=none; b=LpkrlmhweR1DVyIHfwIQBPInkswcAUsFwI/J3jm+3MkV5zkB0ikUv+f6NnQaDXxUKwr0fjGvk+0+L/7lmsbLIYEWR9uaaF9y4ajiu2GsuFnxLVzqZ3NQMOtQHQjTJn8okEr7Fclm35whZB+YN7vaRlaHIoW83ESebopE0YnHpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791115058; c=relaxed/simple;
	bh=4YSstm1VbEtUPUDsFi1yPw9oHYIL4gvyorW57fRInSs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=nbgtULcyB1eE8POPfwAYcgVvdFRN5RIEYD7Mb3DQnQEddsUFcezocV5tkf9v75/3V70hWf3IQvYYQHgSGAfSRo8XTsMsRp3p3aEey/2SSrFLKiVYZGc9TRVYK9rGtQWmMYRk8cHCPwyREUeUusVB0Loa4xKm6jJf8DkJNlCqbHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=O6VVwIj7; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="O6VVwIj7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791115047; bh=3TguttCU59P+v8Iys28CUB+uIsSTVpdlEytAq6xMeqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O6VVwIj7WqRWzTITMY9Mcry+aBRFF97AKuwRI0iYbf3JIuewDMELv5+ImZst6CukN
	 FTzIrIL8mklGJt9yj/OSBU86SXi5oml2rfwpNF7xSrlwZGJmDGfy4xqLlxnUyTJIIh
	 ztUtzas/fHi7+SVqR0mblNvTrgyTglFJVj2hwXf0=
Received: from xiuos ([2001:da8:201:1175:6e92:bfff:fe3b:37c3])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id E4D020DE; Sun, 04 Oct 2026 19:57:13 +0800
X-QQ-mid: xmsmtpt1791115044tgm3mqobh
Message-ID: <tencent_C7BA3FB54A956BDCEC9B48C7741F06566708@qq.com>
X-QQ-XMAILINFO: OWq/UyOXDF6XbrCx+K583PZONr7pC6HELlsI6E08pp6G1vxEjOvI/XgzvJj9oA
	 0XEBPIfZFxSaavgzrezJTXMSCdaSNLO4eE8RcJDfpmNk6kZoHxUSLs7oTn+TkEgHm+jCh5rmEUom
	 hLOtk3kut6+TVn6ma34/70WUI9LS0Y5wQJ1y5PX2BYeBFPnvB5W3+lCSTlbIiHDhlIrlnnHcmKMK
	 7tax5joIlxSb4BnKc+juP3tAAManutgOJxpCllEviS2779QLeEEYYoR7VJUjMXh23nsom4i8UrWa
	 aa8Iy+DvCGQugin3Db/u+fa8Zupo4Xs9ZOOEzLDfCOng0CZe6OC0SJRITbavLBaep2TZ22njpveH
	 eFKNo5u3ePGcOHAAHSsfu/V6UYWIz8SZGcE/2uREJirVIHMRkuzJuwkdZsgbUwb2ln4A7DCmmndw
	 s/JJDSnkCUQMdCfqN9eIooxpJeWsOVcsZKHGPFFeQ3z5gf6tD68rvRLEcEF8nKVO+L16kK8ytQCP
	 YRpU5guKtEhMWMu1HGdRQzDdeNsFIKqBSbjYpLDIC/s9rRHX/QalYRVjolCFqyt7vPRh9vVK8Tfg
	 iCDPwCTvv0Q0RlVeIAdC/Fl1VQn/+jIaZV8k4AQB5lbcN4GSRwRuCmAQbZjBUa8zQR0GEWa9K9j6
	 O31uj1b+iF2xCkGphsAvNO2ohQfQwEaARfYpApjcKO4RDsgB91PIbM3+LxhcMa0FZooyvPAECBNd
	 Myx/qN3HsKeH/3s0fAbh9w0EDNN5jB9be8f2RcM1CNB/C9yFy7423vvfY5jsqTYfPAyr8tm1W8gY
	 LjgyqgLxUfTxgeyEsLL1jLstgeTYKR5/cabywDVW7QM4clhPt7wVdAYtL22w2ujQLoHitBcEQ5b7
	 KWA7RT+P9hKnZVi/vIb95qwkLwu2l4o3CGKPqm3T/t7X2QgdZWMX06rcS+MfyLWT7pHdUqpnondW
	 T8oGUa8sJypwZakCvxnv76M6HhMXXgAiDqNqu+Yh7B8pi6QVjvw4/XDC20oBnX9S33BuKE4jixJ1
	 rlqQjHlYiaTyp+2rS4y28r2pz9qSXQMZb31VqgNWkaSFX0bc//PJwv8248QDOiXr+T5Q9V5yaoDY
	 iNPROeKmfWPIiXXFq3GH/q6XKi8LQ8Y5fEhylkTLH4COsCXsaywPHRB2gKiw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Anlai Lu <agicy@qq.com>
To: Jean-Philippe Brucker <jpb@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Anlai Lu <agicy@qq.com>
Subject: [PATCH 5/6] iommu/virtio: read the endpoint count under the lock in the iotlb paths
Date: Sun,  4 Oct 2026 11:57:08 +0000
X-OQ-MSGID: <20261004115709.3181856-5-agicy@qq.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
References: <tencent_85AC6E749F6A912B7BB9FF360F8ECB3F5C09@qq.com>
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
index ba1d78e4daa0..4e578d4255f6 100644
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
@@ -1273,8 +1286,10 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
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
 
@@ -1286,7 +1301,7 @@ static void viommu_flush_iotlb_all(struct iommu_domain *domain)
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

