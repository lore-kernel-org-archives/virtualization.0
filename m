Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEEF15FA78
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059755; cv=none; b=Qa3PXx7FzR4Ili6n6q8BBJNWILYj6/9g2cnkJl/iXHuG0zTQ3Qs8bdSgKq/iO0nxH4fDpm9Iv31IbZsww6346aoQiHCiEKn/RHdqV5eXTlOaB2mMgUtSdTWSfY4vvr3/D2UkSLNApBzgVzH6i7yMn8Mdsd9/VdIRwcdDgJK2Oaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059755; c=relaxed/simple;
	bh=T28RQRktjxNSpRXzjatTxI5HNr8v0aKmaJkUuNN6u0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGNRFGzurDDjE4igtjKYgG3tffUyfnrB2DKRf1SPDQjJ43KerApjvBz1SESpzCJbWv78jTKLCTQ+dN0nzypX6P6UuPfBgjwGoVFptK3epeYnrE9m2Ab4THnFireruOhEr1Zh1S+cNHbjrgkgoVaR+dleotizenz/YAerL4FQROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5SPuexw; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5SPuexw"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A602A402A7
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uH7wNtayYBMg for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Aug 2024 09:29:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B0DCB401F6
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B0DCB401F6
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=f5SPuexw
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B0DCB401F6
	for <virtualization@lists.linux-foundation.org>; Mon, 19 Aug 2024 09:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724059751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m/kmoYqnstbKFrlYx9VIPQUYp5ncxzSL1je8L9dtZF4=;
	b=f5SPuexwxblvyfv7t9MuYSjGnO456A0qvMfQji3sMBADjzlV798rxdcb9dHaZ6BXcTVpkN
	g0ZPhgG9mhtItf/b6Ftk1ib+qUI67bOAEC76gnSNxvNuJJnc7pt7rv+WBCUqirvIWqGAtm
	cjuiTh0l1fKH45b2uR7js0QPSy2EG4w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-59nOVgyVNDa2gavH-v9Rrw-1; Mon,
 19 Aug 2024 05:29:07 -0400
X-MC-Unique: 59nOVgyVNDa2gavH-v9Rrw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64FA01954206;
	Mon, 19 Aug 2024 09:29:06 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.11])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 175AA1956054;
	Mon, 19 Aug 2024 09:29:02 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RFC 1/7] vhost: Add a new module_param for enable kthread
Date: Mon, 19 Aug 2024 17:27:27 +0800
Message-ID: <20240819092851.441670-2-lulu@redhat.com>
In-Reply-To: <20240819092851.441670-1-lulu@redhat.com>
References: <20240819092851.441670-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add a new module parameter to enable kthread while loading modules.
This parameter will identify if the vhost will use kthread or a task.
The default value will be true.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473..da701f6b3f2c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,9 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+bool use_kthread = true;
+module_param(use_kthread, bool, 0444);
+MODULE_PARM_DESC(use_kthread, "enable vhost to use kthread (default: Y)");
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
-- 
2.45.0

