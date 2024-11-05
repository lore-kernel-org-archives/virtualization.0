Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EB91FE116
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730791720; cv=none; b=ckJQtgTxU+jz/QrDh0kKAkajvsO5M2gSeT1hUnfIYClp0xtX1TKzKmBbywG3prcyaL599tuDxRUYCTX7s9+j1kpjbbMS+LfACFR1vlCQkmOGOWvitG7MWKubpHvBiXE+ad7Ubi17bL+NMMBRd5tbCk7ETDrR35FLLLw3bbNu1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730791720; c=relaxed/simple;
	bh=vJGsOnLSVbNs9zEE3Y9TV4PsmII2ryUMx1W/w1V1sgo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEt42zxtrBLZRHM2qlGKwYrF/Kb/yd2WzhCCtyDbU9S6VWu0Hiwp6roYYMrz0NPmz1Qh0Lw8H/YMvJNKLkCKqcG9xIvF4K7bOMjU6tqjNbASSMV79GMDZVlLzEImwF9K/BY/lbSlraj3AkE0ubbOOvPuP2CD4zTm9ECUHVP3j7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KroNaPbJ; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KroNaPbJ"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E02F880DB1
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YG8fhsBKFkNa for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Nov 2024 07:28:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 369A080DAF
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 369A080DAF
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KroNaPbJ
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 369A080DAF
	for <virtualization@lists.linux-foundation.org>; Tue,  5 Nov 2024 07:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730791717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=taXN/BByVA3oeUwccMMIwwKlQcWqxPtqO9YY/m4NEgM=;
	b=KroNaPbJ/0vNf4plqZ2pDVdHFRBzemiEjZBj2NMl1dHq/d/ISd/xjEGAgbGQtT0Yxm5l5C
	FBsYs2ztAmO2dMej9B5eyHf/RWCdgHs9IdfjyLc0NOiz8v8sa/Gb6txi6BwGdXWkaRZQ0h
	EfGtJLXUSb47He8MsRjr58oXGjm4DY0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-435-AAOEehLKPrGIGDel1AAU2Q-1; Tue,
 05 Nov 2024 02:28:33 -0500
X-MC-Unique: AAOEehLKPrGIGDel1AAU2Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C46FB1955EAB;
	Tue,  5 Nov 2024 07:28:32 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7D39019560A3;
	Tue,  5 Nov 2024 07:28:28 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 9/9] vhost: Expose the modparam inherit_owner_default
Date: Tue,  5 Nov 2024 15:25:28 +0800
Message-ID: <20241105072642.898710-10-lulu@redhat.com>
In-Reply-To: <20241105072642.898710-1-lulu@redhat.com>
References: <20241105072642.898710-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Expose the inherit_owner_default modparam by module_param().

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 70c793b63905..1a4ccf4f7316 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -43,6 +43,9 @@ module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
 static bool inherit_owner_default = true;
+module_param(inherit_owner_default, bool, 0444);
+MODULE_PARM_DESC(inherit_owner_default,
+		 "Set vhost_task mode as the default(default: Y)");
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
-- 
2.45.0

