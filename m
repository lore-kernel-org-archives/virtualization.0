Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042AC21B91D
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743156319; cv=none; b=CSOmMOfOz4ZcHoZZFnzuZvOM45MkenDTTk8Ft80bYF+EV8nVn+uX4Tq4hWYlwTP31tKwots4Sd/Sz1IfGTg0z0SIIGAxSx3Vjb7QxomApfhXQYjr/ouoHQKZOLSlLQyD7aj0fjhQEpPsmUYPVeCueIkC+lV1MqNzwiuYyYyIdZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743156319; c=relaxed/simple;
	bh=uvSR+nHkOyddC0QdPQ72//WOuIk64mxGFFY2EA8HABQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0DCGb1lbDD0NdcbX3u1k89iuQbf9wbud/LyKZq5V0OpRp+QH+P/9e2hdHY66uidd7Wy7lzdHD418qHdka+tXgk3/nFCePKc9kqxmI2kOYsY2aDMsQekrCOYSNsD156Rz+AORh4hvZXg93dbwNOZtJmSfPy0T2zN/bm5BWsAG5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L4rCipIF; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L4rCipIF"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 809034057F
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:05:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3VoU2_TsjMhV for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Mar 2025 10:05:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E2EB740426
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E2EB740426
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=L4rCipIF
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E2EB740426
	for <virtualization@lists.linux-foundation.org>; Fri, 28 Mar 2025 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743156313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rlJT47zLkSfn9zom7PdH4akIw1D+Y3HK6R7VYjb50+Q=;
	b=L4rCipIFHx2Kvky9pL0GPbmsKnK7lZ58/SewOAEy5bFfX9Z45ex0GrdC2a0FWiXfgGVniY
	nRi+sjFIBCy2KPdtjCG3zLMhu8ip/yyaloCjkoipSdepWXsmr/VkD9mXhRpt1f8tmxlmy0
	WLbXUORW6d5Mlb17KewrZ1LJT2OcDxQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-HiBbKl8yOjeI9ZL1yBl2Fg-1; Fri,
 28 Mar 2025 06:05:10 -0400
X-MC-Unique: HiBbKl8yOjeI9ZL1yBl2Fg-1
X-Mimecast-MFC-AGG-ID: HiBbKl8yOjeI9ZL1yBl2Fg_1743156309
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5DE2C1800260;
	Fri, 28 Mar 2025 10:05:09 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D4D4619541A5;
	Fri, 28 Mar 2025 10:05:04 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v8 7/8] vhost: Add check for inherit_owner status
Date: Fri, 28 Mar 2025 18:02:51 +0800
Message-ID: <20250328100359.1306072-8-lulu@redhat.com>
In-Reply-To: <20250328100359.1306072-1-lulu@redhat.com>
References: <20250328100359.1306072-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The VHOST_NEW_WORKER requires the inherit_owner
setting to be true. So we need to add a check for this.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index ff930c2e5b78..fb0c7fb43f78 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -1018,6 +1018,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
 	switch (ioctl) {
 	/* dev worker ioctls */
 	case VHOST_NEW_WORKER:
+		/*
+		 * vhost_tasks will account for worker threads under the parent's
+		 * NPROC value but kthreads do not. To avoid userspace overflowing
+		 * the system with worker threads inherit_owner must be true.
+		 */
+		if (!dev->inherit_owner)
+			return -EFAULT;
 		ret = vhost_new_worker(dev, &state);
 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
 			ret = -EFAULT;
-- 
2.45.0

