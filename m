Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869171A716
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725847326; cv=none; b=rm/PMUk+m8u743dZC2d91rs9vs5ARzeXOEmIOrJ20knynGyhv1RIFqWoFa0xwlRKovr9qG4p6yF9CIwOnDxDtgScGWAK2802RKFjO0DZgUeJZtzLvPbq/AOgR7mFfhkiED4D2/fHExWAcJ23VN8UgDWNwFlYzN14l4mu55Iu8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725847326; c=relaxed/simple;
	bh=Ak4RUYn1eA5rfEtC6UaT2NAXVhW2XNZwTEkhokuf7aA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVsFkDLC7UY2rKx3m2v/SrJyE1rTGF9BoP0Z53PqPO0KRjBtJGoUnAaLKXfbJGUucmxRBz24GQqQnL8cD8dG7/1yzq/MMkqblmrDOxHt6Jvxy/QfhHwWTzJjvMKn4Pda+jk1ExiJ2ALdqnl55q8M0YuaIXSKjNHsfHyl6Q2jaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YyDyBYh0; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YyDyBYh0"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 17CBE80CDF
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VHztG5Oarg-6 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Sep 2024 02:02:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 670EA80CCA
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 670EA80CCA
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YyDyBYh0
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 670EA80CCA
	for <virtualization@lists.linux-foundation.org>; Mon,  9 Sep 2024 02:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725847323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkgZukq1NH7xZqgst5PAi/0pE3TPAwASepcK6DYlOEo=;
	b=YyDyBYh08lhk3+32rX99MVft4TgfnFzJU8anoSGaXZHEBZklmycvRJhvVoOMildRIObGEe
	iQbOe1FUreU2xkZRZq9yvXtbH4Rh/8e1kMxpY2g89iSPCoWQXa6z+T/x63MyKKtUMoOQLI
	J2teWSZsyK9Y1yMRoJI06rxbc7O56jw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-kwgtn3btOuilcuSSm7lDBw-1; Sun,
 08 Sep 2024 22:01:59 -0400
X-MC-Unique: kwgtn3btOuilcuSSm7lDBw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EDBD1956080;
	Mon,  9 Sep 2024 02:01:58 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2BF21956086;
	Mon,  9 Sep 2024 02:01:53 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [RESEND PATCH v1 1/7] vhost: Add a new module_param for enable kthread
Date: Mon,  9 Sep 2024 10:00:39 +0800
Message-ID: <20240909020138.1245873-2-lulu@redhat.com>
In-Reply-To: <20240909020138.1245873-1-lulu@redhat.com>
References: <20240909020138.1245873-1-lulu@redhat.com>
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

