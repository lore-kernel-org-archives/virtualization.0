Return-Path: <SRS0=cI1G=H2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF923C433DB
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 11:49:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2323864E60
	for <virtualization@archiver.kernel.org>; Wed, 24 Feb 2021 11:49:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2323864E60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6E24B430A3;
	Wed, 24 Feb 2021 11:49:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YZTqs5VfEDNk; Wed, 24 Feb 2021 11:49:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1E3084309A;
	Wed, 24 Feb 2021 11:49:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7E8CC000B;
	Wed, 24 Feb 2021 11:49:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 730E0C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 61975430A3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:49:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dcxqe4a7c_xs
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:49:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2E90A4309A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 11:49:16 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id t26so1293134pgv.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Feb 2021 03:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iKXu5MTD/qNOkcWSg8bnOE00gDFp+RLdj201NypZGkc=;
 b=KKBBnpxYRiqICn8VUoFHfqlpocIoktHL4QfBR1OT8Xvc1+/veBc+D5nj8QMdgbjEwK
 1yes/Xz/5+dBGfZfK5rBMgrvkm8wyTUv9ozrjZqeorOJwYfVaXIgvVOeaTxScEgm6uxe
 ShSM1T4kGf/HKJ7o92OvMPKvMd2MtMwNXJfpv4zWmtN4vZFk68JK9AeETv6DaSkPTaX2
 Q0eNTMfrQyKvVO3cB9nEzDjn+uugTxpR1NA/SAkxX9dttovsdlENoepSTauut08ZtS6D
 RIhc0TTMYYczzbwHhAkg659qMxVfsalOutdE5pYFZ7KFyMTQEQL71StaqkENpqS+OQ3X
 YjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iKXu5MTD/qNOkcWSg8bnOE00gDFp+RLdj201NypZGkc=;
 b=BTLPeuj4K97PkWr8p5RvdOXtMpOHgVK0DID9vdV4NJofxYt6nv+OmZuCqYFdRbL9o5
 r3nU0he8gGkbvN0GJc5IYmIxlKZcFhEXHYmoQee1ra9zTen8km5nfYMh0f5MyPENbVjK
 oWC7v8aUoAy5hEBIgYvqYyDPsfJN/sBhWFVDuNBWJTFOYjR8SN40aFAKe1raOe0gkXs4
 FnKzyozKxbTKZUslDGGD6a1u5UkzXAvli1fBACVJ9UIsPKudfumpOUx3abPamM/m5yU2
 woBAjl6d93c6Y5+TV40l5ui0Am+oHYMl+PKDmJc7k36UxINYb9jQ2+5wjTKNjOQpPuTH
 vHrA==
X-Gm-Message-State: AOAM531IQ2WnQNp3/BxXPW/F3p65ZYSPP2fJnGxAmeGgwZYaO45nwyXH
 Dd2lQoqSlFGpzt236hXvfG8=
X-Google-Smtp-Source: ABdhPJy6zT+ozN8jYuxk5CjeXkIK3JoA1vELHsGjU/enp38Jl4Qv64XF+ot1sMiM9QL4epMFQG0Dlw==
X-Received: by 2002:a05:6a00:16c7:b029:1bc:6eb9:ee47 with SMTP id
 l7-20020a056a0016c7b02901bc6eb9ee47mr32285893pfc.0.1614167355611; 
 Wed, 24 Feb 2021 03:49:15 -0800 (PST)
Received: from ndr730u.nd.solarflarecom.com ([182.71.24.30])
 by smtp.googlemail.com with ESMTPSA id q23sm2533479pfl.123.2021.02.24.03.49.12
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Feb 2021 03:49:15 -0800 (PST)
From: Gautam Dawar <gdawar.xilinx@gmail.com>
To: mst@redhat.com
Subject: [PATCH] vhost_vdpa: fix the missing irq_bypass_unregister_producer()
 invocation
Date: Wed, 24 Feb 2021 17:18:45 +0530
Message-Id: <20210224114845.104173-1-gdawar.xilinx@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Gautam Dawar <gdawar.xilinx@gmail.com>, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 martinh@xilinx.com, hanand@xilinx.com, Zhu Lingshan <lingshan.zhu@intel.com>
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

When qemu with vhost-vdpa netdevice is run for the first time,
it works well. But after the VM is powered off, the next qemu run
causes kernel panic due to a NULL pointer dereference in
irq_bypass_register_producer().

When the VM is powered off, vhost_vdpa_clean_irq() misses on calling
irq_bypass_unregister_producer() for irq 0 because of the existing check.

This leaves stale producer nodes, which are reset in
vhost_vring_call_reset() when vhost_dev_init() is invoked during the
second qemu run.

As the node member of struct irq_bypass_producer is also initialized
to zero, traversal on the producers list causes crash due to NULL
pointer dereference.

Fixes: 2cf1ba9a4d15c ("vhost_vdpa: implement IRQ offloading in vhost_vdpa")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211711
Signed-off-by: Gautam Dawar <gdawar.xilinx@gmail.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vdpa.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 62a9bb0efc55..e00573b87aba 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -844,14 +844,10 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 
 static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
 {
-	struct vhost_virtqueue *vq;
 	int i;
 
-	for (i = 0; i < v->nvqs; i++) {
-		vq = &v->vqs[i];
-		if (vq->call_ctx.producer.irq)
-			irq_bypass_unregister_producer(&vq->call_ctx.producer);
-	}
+	for (i = 0; i < v->nvqs; i++)
+		vhost_vdpa_unsetup_vq_irq(v, i);
 }
 
 static int vhost_vdpa_release(struct inode *inode, struct file *filep)
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
