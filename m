Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B375D53C
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845764; cv=none; b=lFK5DFMyPpzdIG1JpkgXi6BOCvw2V6by2coQJ2cR0gcB7Ag2MDPMhklX27Q1FGLK+zGYqRsVkRtzEBqKtMB/yBMoZ2ZTF8SU1+PQ2RImL46JGmUZG95eSvFh+DsOEHXRAZ6yfh93txMgdSs9OF2MI7Y8VcJQ2q5NZMQEdym+xrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845764; c=relaxed/simple;
	bh=b1TL6VfkMSGelSbZuz3i/ovmXnm6fRU5ZpQUCeqKGzw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uF/ivlNzvXyF8MDhCZvAMiUC+B+jR7a5qE4F3F9QPqmnCm2w69PDLaWvmlYQjEw46fG0Kfhwde0bLkDO0+kbTFCl3GsCJzIx/DQoH2qh57+FGYpml3WNOHKyUA+2eK1dplYUKDIFtNUd0RNfoJp8CPHemvFr2APP746/c9R6fS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YO+ZlE/N; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YO+ZlE/N"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9963580FA2
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 01:36:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sem4dGJJqmbn for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Sep 2024 01:36:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EDC5980F9E
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDC5980F9E
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YO+ZlE/N
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EDC5980F9E
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 01:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725845757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=78yJ0rrxnE6exhPYiyoiwtUEzl2VKCruczkggBJ6zeM=;
	b=YO+ZlE/NTbr+FdpRN3DBm9asus44ylQDRqhc16HcseU98pFeV1+D8+blLbJaew0XUVYVHC
	1X6ncxE0PO4mLuKmOpwaUI/X36SRg3eL3QK6zKJtvrREojGgdYj+ql6nPbsMNwsJTwTTgP
	KvV11N675g926+ewJV8CLypD2uaPThM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-262-pq-bCRioPZSzoE9Y_jFsBw-1; Sun,
 08 Sep 2024 21:35:54 -0400
X-MC-Unique: pq-bCRioPZSzoE9Y_jFsBw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3027E1955DC3;
	Mon,  9 Sep 2024 01:35:51 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EA871956086;
	Mon,  9 Sep 2024 01:35:46 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v1 1/7] vhost: Add a new module_param for enable kthread
Date: Mon,  9 Sep 2024 09:33:40 +0800
Message-ID: <20240909013531.1243525-2-lulu@redhat.com>
In-Reply-To: <20240909013531.1243525-1-lulu@redhat.com>
References: <20240909013531.1243525-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Add a new module parameter to enable kthread while loading modules.
This parameter will identify if the vhost will use kthread or a task.
The default value will be true.

Signed-off-by: Cindy Lu <lulu@redhat.com>

module_param
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473..be43181af659 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,9 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+bool enforce_kthread = true;
+module_param(enforce_kthread, bool, 0444);
+MODULE_PARM_DESC(enforce_kthread, "enable vhost to use kthread (default: Y)");
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
-- 
2.45.0

