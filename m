Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A581BDC8
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728007196; cv=none; b=I4heIMxu7vIB5JoumyW2AkWGzAm+JWDyO0kkB4vyiFd2YgBI4GR/HpXiakzwD8raRN9OMn7ehUFv4tN1mfljPy7olwiOHetAbH1gGwUNhm97YJEEwTJ54jldJ6FHmPXKtKxRawLMMjUGOSWRYb2QZS2vqMe+0+xQ+hn5h0XfFL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728007196; c=relaxed/simple;
	bh=zrQT/I2PK5lAcMS9tlIOjHCcoibHU9rgFnqoXsDWCX0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g21uvgXmDR/FM7nOwn1EteggtD5cIb6TxfZLmPPQnBmYAmBJ9Rd8hVaRsNvo4cQ7fP8O2GKqOuEH1r8U3O+7xgdG9JjUFjBbrULaaoxj8wv2R0lpixgaQ4OIzA+velMK21Y9s6P0BgX+2grIpZXMSbDRpX3QhOf5je62rsWHhGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LfTDLUBt; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LfTDLUBt"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A077B6078E
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 01:59:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id syazSWkugfZn for <virtualization@lists.linux-foundation.org>;
 Fri,  4 Oct 2024 01:59:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D38A86078C
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D38A86078C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LfTDLUBt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D38A86078C
	for <virtualization@lists.linux-foundation.org>; Fri,  4 Oct 2024 01:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728007192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qQE2RJORatJZ4HbSL1fxpt77UC2FjfgZSgKiByM6mc=;
	b=LfTDLUBtY9kMU3hsypAb6EkkWSHS3iezvmi0iCvVERSwtK1U1CvJLHk/51w97ANbAkv7Oo
	Uww1O1YBVAuaEjBk0W/SEtHOR4D9c4XFFIoKVFKmWSLcV1PKOnCkY8zVJHQdRYex8tSyYh
	LWB4DvK5n10HIYXfGmcg9vc5tb/qrdU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-NvTDSUtvPEOnbRzjKMyEXw-1; Thu,
 03 Oct 2024 21:59:51 -0400
X-MC-Unique: NvTDSUtvPEOnbRzjKMyEXw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCF0519560AB;
	Fri,  4 Oct 2024 01:59:49 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.45])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15DF319560A3;
	Fri,  4 Oct 2024 01:59:45 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/7] vhost: Add a new modparam to allow userspace select vhost_task
Date: Fri,  4 Oct 2024 09:58:15 +0800
Message-ID: <20241004015937.2286459-2-lulu@redhat.com>
In-Reply-To: <20241004015937.2286459-1-lulu@redhat.com>
References: <20241004015937.2286459-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The vhost is now using vhost_task and working as a child of the owner thread.
While this makes sense from containerization POV, some old userspace is
confused, as previously vhost not and so was allowed to steal cpu resources
from outside the container. So we add the kthread API support back

Add a new module parameter to allow userspace to select behaviour
between using kthread and task

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 9ac25d08f473..a4a0bc34f59b 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -41,6 +41,10 @@ static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
 	"Maximum number of iotlb entries. (default: 2048)");
+bool enforce_inherit_owner = true;
+module_param(enforce_inherit_owner, bool, 0444);
+MODULE_PARM_DESC(enforce_inherit_owner,
+		 "enforce vhost use vhost_task(default: Y)");
 
 enum {
 	VHOST_MEMORY_F_LOG = 0x1,
-- 
2.45.0

