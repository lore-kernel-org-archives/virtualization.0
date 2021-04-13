Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7589BC43461
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 09:16:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A299610CE
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 09:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A299610CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D1FAA40680;
	Tue, 13 Apr 2021 09:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZ7XQI0olSUA; Tue, 13 Apr 2021 09:16:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58723404EB;
	Tue, 13 Apr 2021 09:16:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ED91C000B;
	Tue, 13 Apr 2021 09:16:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D089C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 09:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 66DA584330
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 09:16:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BRZwYNySHcdr
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 09:16:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 51E7A84315
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 09:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618305368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Nsxd662d4i8x3VCivCNK0fCVgM6UOW8+ULBoukCe2ZU=;
 b=HIcJFErnYgx4eitlrlzasNDzEHQAoI806ImiejChWXfBVcAH9NTQXP1pU3a+w1JmphZ7dy
 6OU+73C5hO94IbJW8Nj5b8+mFm+WqKBd4bkF2+zS0wDB9mEzQNauhycjboiOjIZuLP/ECm
 F/YAKSalD0xZnaqS0F6LZV467d8Yhiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-71-x88dCRRUMHWcrN8rL8uRAw-1; Tue, 13 Apr 2021 05:16:07 -0400
X-MC-Unique: x88dCRRUMHWcrN8rL8uRAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD9BD107ACCA;
 Tue, 13 Apr 2021 09:16:05 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-128.pek2.redhat.com
 [10.72.13.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55CC360C04;
 Tue, 13 Apr 2021 09:15:59 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] vhost-vdpa: fix vm_flags for virtqueue doorbell mapping
Date: Tue, 13 Apr 2021 17:15:57 +0800
Message-Id: <20210413091557.29008-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The virtqueue doorbell is usually implemented via registeres but we
don't provide the necessary vma->flags like VM_PFNMAP. This may cause
several issues e.g when userspace tries to map the doorbell via vhost
IOTLB, kernel may panic due to the page is not backed by page
structure. This patch fixes this by setting the necessary
vm_flags. With this patch, try to map doorbell via IOTLB will fail
with bad address.

Cc: stable@vger.kernel.org
Fixes: ddd89d0a059d ("vhost_vdpa: support doorbell mapping via mmap")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index e0a27e336293..865eab69cb71 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -989,6 +989,7 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma->vm_end - vma->vm_start != notify.size)
 		return -ENOTSUPP;
 
+	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_ops = &vhost_vdpa_vm_ops;
 	return 0;
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
