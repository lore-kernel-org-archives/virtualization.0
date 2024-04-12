Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B382C76
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928693; cv=none; b=hROtPYCWLN0TbEsgRhuXn+qulSRVh1d23ospZcBrbpi+s2OBfYZ/Cqqq25kCtsdBpFzC53fm7pv77W0U3z07BNdjKIKc1kRZTNT2rsfUgZwhLPwCLp3bruGZ6bG1aRGEg+NTwFeJdisw6VyBvZxOQkF0ePLdgKeJpiuJRP31Jnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928693; c=relaxed/simple;
	bh=bKN8UQ9NS8z8CGfSU2og9P/q9mfucOox+qnqy3HOHbs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXFjIdj5Uak1fBAX4T742FDRCkOivpVzFRqBKaYwi733kg2ZHav7/fEFRMxcXfiMxny25f1TnAXbmm0XrvYzyVIrClg5755p/i5TdSdrvy78Oi3UQx4K+9BOAC4mDc96i5nQeNbGxzu5qfC21HqIkSwgPJi41WEkFzgYfddVDak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DbYC8hVt; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DbYC8hVt"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 68A2D40534
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:31:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GXYF8NyvfrEm for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Apr 2024 13:31:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 98B1840434
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 98B1840434
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DbYC8hVt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 98B1840434
	for <virtualization@lists.linux-foundation.org>; Fri, 12 Apr 2024 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712928690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=35sWc1yIwO6N5kVcpws/O6LKONaL5+Jtm0fcsW8kNnY=;
	b=DbYC8hVtQrE34ZLVY7Xqg9vNwsHJDGvvgWOcdEIVq9g+eSdlYWUJnlGTko1n5gH5RXJNJw
	IULvjJjgKpOclBk1os2s2jfMXuDbMEq+C9SxS1O+qo9yJcdCnPCJ54Vsg6TxouyFVcr+Ld
	thuTGsBImlKTJqmDAv5I/aocs/DWmkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-r1p6kOVmNpGuT-qX4K-ScA-1; Fri, 12 Apr 2024 09:31:26 -0400
X-MC-Unique: r1p6kOVmNpGuT-qX4K-ScA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0643B80A1B9;
	Fri, 12 Apr 2024 13:31:26 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A25CC10E4B;
	Fri, 12 Apr 2024 13:31:23 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	jasowang@redhat.com,
	mst@redhat.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org
Subject: [PATCH v5 4/5] vduse: Add file operation for mmap
Date: Fri, 12 Apr 2024 21:28:24 +0800
Message-ID: <20240412133017.483407-5-lulu@redhat.com>
In-Reply-To: <20240412133017.483407-1-lulu@redhat.com>
References: <20240412133017.483407-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Add the operation for mmap, This function  will be used by the user space
application to map the pages to the user space.

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 57 ++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 2da659d5f4a8..7abe0c17cf0e 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1465,6 +1465,61 @@ static struct vduse_dev *vduse_dev_get_from_minor(int minor)
 	return dev;
 }
 
+static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
+{
+	struct vduse_dev *dev = vmf->vma->vm_file->private_data;
+	struct vm_area_struct *vma = vmf->vma;
+	u16 index = vma->vm_pgoff;
+	struct vduse_virtqueue *vq;
+	unsigned long vaddr;
+
+	/* index 0~vq_number-1 page reserved for virtqueue state*/
+	vq = dev->vqs[index];
+	vaddr = vq->vdpa_reconnect_vaddr;
+	if (remap_pfn_range(vma, vmf->address & PAGE_MASK,
+			    PFN_DOWN(virt_to_phys((void *)vaddr)), PAGE_SIZE,
+			    vma->vm_page_prot))
+		return VM_FAULT_SIGBUS;
+	return VM_FAULT_NOPAGE;
+}
+
+static const struct vm_operations_struct vduse_vm_ops = {
+	.fault = vduse_vm_fault,
+};
+
+static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct vduse_dev *dev = file->private_data;
+	unsigned long vaddr = 0;
+	unsigned long index = vma->vm_pgoff;
+	struct vduse_virtqueue *vq;
+
+	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EINVAL;
+	if ((vma->vm_flags & VM_SHARED) == 0)
+		return -EINVAL;
+	if (index >= dev->vq_num)
+		return -EINVAL;
+
+	index = array_index_nospec(index, dev->vq_num);
+	vq = dev->vqs[index];
+	vaddr = vq->vdpa_reconnect_vaddr;
+	if (vaddr == 0)
+		return -EOPNOTSUPP;
+
+	if (virt_to_phys((void *)vaddr) & (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	/* Check if the Userspace App mapped the correct size */
+	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
+		return -EOPNOTSUPP;
+
+	vm_flags_set(vma, VM_DONTEXPAND);
+	vma->vm_ops = &vduse_vm_ops;
+
+	return 0;
+}
+
 static int vduse_dev_open(struct inode *inode, struct file *file)
 {
 	int ret;
@@ -1497,6 +1552,8 @@ static const struct file_operations vduse_dev_fops = {
 	.unlocked_ioctl	= vduse_dev_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.llseek		= noop_llseek,
+	.mmap		= vduse_dev_mmap,
+
 };
 
 static ssize_t irq_cb_affinity_show(struct vduse_virtqueue *vq, char *buf)
-- 
2.43.0

