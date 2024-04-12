Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A87824A3
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928663; cv=none; b=U6Ko3QD39PQyOBQKWZiGtEWGFihCunTWCJdrtxP+6Bmt2c3kV/mU3y7tS+U7Bay8sqn0eTIeBY5V/QQHDkFnDONT+bcDDsmCrq5D7pXfbbNRNVi/5EG5dvQ3/+wxehvnVblDgn0CXGDnzP/uZP9HyjlEE7xCbrTXEQyY8bwWhUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928663; c=relaxed/simple;
	bh=cBLjryLsVfu47+tjl5ywQAYVk9Q3xIPJ/WF63oos9zU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIRpnDi8k/eKeLr5cB2GOVI+5b9aaCSmzaYV6wRy+Ee7v7GcTcB5IwUxTQEzSwtsB44gbNdirGnvKxKUExviqKGoxEjIFvJ1i6kdLjBzZni+kPkbONBwaEFSNfziW01lrshYq/FT0RU07GcE/0J6sCNq0tVNxL2AzbLSRIPPjFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fuxn2mMN; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fuxn2mMN"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6E6EB41EB5
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pcHRIPjtf3xO for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Apr 2024 13:31:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 5A756407F1
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5A756407F1
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fuxn2mMN
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5A756407F1
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712928660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x2Trg27lougTGtlprzjhUTV72eb8EddnblMr0yERIK0=;
	b=Fuxn2mMNterhML9PVg+vnxkKITduxMyxtBs2G6kCD9mnD7VwBkELQaD64uqGgU1my7ONrD
	M5trrlXfXkP6pbT3PLiLso4ZjNrdiJv6qQdy00x2DLSXBwLtMq4AHx2F30Rv6EiH3fM1Bz
	WYrplZfDaixJiKrYNrw3Ej5G/3C6S+4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-uC2OtfNHNf6bhTxSIazRng-1; Fri, 12 Apr 2024 09:30:58 -0400
X-MC-Unique: uC2OtfNHNf6bhTxSIazRng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 818188007AD;
	Fri, 12 Apr 2024 13:30:57 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2CDDB40C6DAE;
	Fri, 12 Apr 2024 13:30:54 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v5 3/5] vduse: Add function to get/free the pages for reconnection
Date: Fri, 12 Apr 2024 21:28:23 +0800
Message-ID: <20240412133017.483407-4-lulu@redhat.com>
In-Reply-To: <20240412133017.483407-1-lulu@redhat.com>
References: <20240412133017.483407-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add the function vduse_alloc_reconnnect_info_mem
and vduse_alloc_reconnnect_info_mem
These functions allow vduse to allocate and free memory for reconnection
information. The amount of memory allocated is vq_num pages.
Each VQS will map its own page where the reconnection information will be saved

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ef3c9681941e..2da659d5f4a8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -65,6 +65,7 @@ struct vduse_virtqueue {
 	int irq_effective_cpu;
 	struct cpumask irq_affinity;
 	struct kobject kobj;
+	unsigned long vdpa_reconnect_vaddr;
 };
 
 struct vduse_dev;
@@ -1105,6 +1106,38 @@ static void vduse_vq_update_effective_cpu(struct vduse_virtqueue *vq)
 
 	vq->irq_effective_cpu = curr_cpu;
 }
+static int vduse_alloc_reconnnect_info_mem(struct vduse_dev *dev)
+{
+	unsigned long vaddr = 0;
+	struct vduse_virtqueue *vq;
+
+	for (int i = 0; i < dev->vq_num; i++) {
+		/*page 0~ vq_num save the reconnect info for vq*/
+		vq = dev->vqs[i];
+		vaddr = get_zeroed_page(GFP_KERNEL);
+		if (vaddr == 0)
+			return -ENOMEM;
+
+		vq->vdpa_reconnect_vaddr = vaddr;
+	}
+
+	return 0;
+}
+
+static int vduse_free_reconnnect_info_mem(struct vduse_dev *dev)
+{
+	struct vduse_virtqueue *vq;
+
+	for (int i = 0; i < dev->vq_num; i++) {
+		vq = dev->vqs[i];
+
+		if (vq->vdpa_reconnect_vaddr)
+			free_page(vq->vdpa_reconnect_vaddr);
+		vq->vdpa_reconnect_vaddr = 0;
+	}
+
+	return 0;
+}
 
 static long vduse_dev_ioctl(struct file *file, unsigned int cmd,
 			    unsigned long arg)
@@ -1672,6 +1705,8 @@ static int vduse_destroy_dev(char *name)
 		mutex_unlock(&dev->lock);
 		return -EBUSY;
 	}
+	vduse_free_reconnnect_info_mem(dev);
+
 	dev->connected = true;
 	mutex_unlock(&dev->lock);
 
@@ -1855,12 +1890,17 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	ret = vduse_dev_init_vqs(dev, config->vq_align, config->vq_num);
 	if (ret)
 		goto err_vqs;
+	ret = vduse_alloc_reconnnect_info_mem(dev);
+	if (ret < 0)
+		goto err_mem;
 
 	__module_get(THIS_MODULE);
 
 	return 0;
 err_vqs:
 	device_destroy(&vduse_class, MKDEV(MAJOR(vduse_major), dev->minor));
+err_mem:
+	vduse_free_reconnnect_info_mem(dev);
 err_dev:
 	idr_remove(&vduse_idr, dev->minor);
 err_idr:
-- 
2.43.0

