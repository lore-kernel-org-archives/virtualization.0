Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF5237A41
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849165; cv=none; b=WZPOx/C/L4uebzjh/QJxNEhofBQGggiv9S9GxsLi5Wd6dxT9p1Ds/g0MEl2Y+PrE/Lq+GQKaoaSzA9Ndl+4fsAJRSfUbkfH/TD1hotpO3jek0cnOlP6L9gUOw8PWWp4t6Y0V54nEBbGnzcbrywn5/DrwO5NAFlKJzd8rle0g0CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849165; c=relaxed/simple;
	bh=Kp0iIIE/kSL/BU14HXYAIg5EU4ZZS6Kg8QDyOD4nqiQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSSR1NWsz24pBZ6XWeB3TYQGwktw/5BGu37UQ6yu+HsgL7yyLBXoHfMe1n0XUOe8n1c6imQEVW1dRweTWyglguhookkaeiCfcXFqWFROFwAb70BYnFL2lNaYzuBSVpSvYfZfPBMV8prGVmZ3NenAa+PbsPykJcMZtcy9X54hmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i9QnA5yO; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i9QnA5yO"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D7C3408BA
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:46:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.793
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xfEptQuSRW8l for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Dec 2024 16:46:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 74E27408D3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74E27408D3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i9QnA5yO
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 74E27408D3
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Dec 2024 16:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733849162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=76z9zS4RFMPn2YcEr8rESUAPULegGSBBggeYhtMkPgk=;
	b=i9QnA5yOiwAByUtq1+KWlSkCj9UuK55uoXgHrwqa7qLQxYawx6tfclS0nGUEDaED0dYNNd
	UYGcp5XVvNgKLrT3zbGvhnyJv6+nNGfCkUvKS3b48pXzU0wRPdHeHoGvl9oaLHtOq+XjNc
	RmiHgr+Le2U61PFMF/VcRduTK2onS8Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-66HnsfF7NO6ROf4rHCso8A-1; Tue,
 10 Dec 2024 11:45:59 -0500
X-MC-Unique: 66HnsfF7NO6ROf4rHCso8A-1
X-Mimecast-MFC-AGG-ID: 66HnsfF7NO6ROf4rHCso8A
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E84A01954ADC;
	Tue, 10 Dec 2024 16:45:57 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.152])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9DB2C19560A2;
	Tue, 10 Dec 2024 16:45:53 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	michael.christie@oracle.com,
	sgarzare@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 6/8] vhost: Add kthread support in function vhost_worker_destroy()
Date: Wed, 11 Dec 2024 00:41:45 +0800
Message-ID: <20241210164456.925060-7-lulu@redhat.com>
In-Reply-To: <20241210164456.925060-1-lulu@redhat.com>
References: <20241210164456.925060-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The function vhost_worker_destroy() uses a function pointer in
vhost_worker, which is initialized based on the inherit_owner
value.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index d1aec41bcd56..3e9cb99da1b5 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -701,7 +701,7 @@ static void vhost_worker_destroy(struct vhost_dev *dev,
 
 	WARN_ON(!llist_empty(&worker->work_list));
 	xa_erase(&dev->worker_xa, worker->id);
-	vhost_task_stop(worker->vtsk);
+	worker->task_stop(worker);
 	kfree(worker);
 }
 
-- 
2.45.0

