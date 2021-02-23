Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BEAC433E0
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:45:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1227564DDA
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 12:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1227564DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D1AA084C2C;
	Tue, 23 Feb 2021 12:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QeWhzyK-Jkao; Tue, 23 Feb 2021 12:45:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6263B8511B;
	Tue, 23 Feb 2021 12:45:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3BD80C000A;
	Tue, 23 Feb 2021 12:45:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD235C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:45:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C499E87057
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:45:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x-TkjzM3sEhK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:45:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com
 [209.85.167.176])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 30E3C8700C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 12:45:19 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id l3so17482999oii.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Yz95go8zYVULI1NaGtJorgI/wbpTXKE/v3dLCZlljFc=;
 b=nzXOKcIpOgtqWAxRO7WseLacyJtFwTq5RGE8+T+aoHXaVrK4aozLi2qrZr6blBN9I2
 XWUdZDSPxY5g0VllC1FN9z16luFse8wavPbylA8u3NfYEoXBtMm6mdnDcGJfhbdOH8R+
 xSnKNAO7IKMsZ2NTKvaO+lJEeY9LoUYBDVPWfkfwer4e/TTFrDLgwL7tS3PgR/Nd0WVb
 /mD+NKFOAZ9wD+sfFPgG/p2BuquuVN2ps9VoNPP9K2GFfRj4dCUrBz47ylJf7vn8b+f8
 N9tU9OOLWKs9gjkrKJ1y2uHsRBDaeLoQXq7+rttFwEaS+7Ci+a0ctE0CbjYJbKQzuHyI
 em2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Yz95go8zYVULI1NaGtJorgI/wbpTXKE/v3dLCZlljFc=;
 b=DL1pnXR+JrwuUtbw79dD/PQ+dZ1MUQ0oK3y/e14zhZzKoIDIvIvWoH7wtgBBxpsCq+
 dzScJTqymrb2slHtPGIli5F/pc3MH7Lrj8mFal6+WEMaeowxabUdjpfAWEPb5SOsK8f3
 +IbTn36IWFHJbKBxRQyJ3o6JNMAreF6ririiOk3zDTm/TnRfm7+QB6W1jdmaqDqF7cd9
 iXbZ88hM5jTmyWrzkAcBGHR8+aRcmvxxwdcFBT/Ljiz8n5EQaaJd/Mf9ooxMCbExCs5B
 IcmY0vwj/YQ3ElI3pk2p9xpu3Q3IkyeX9omBQjBESrIrHUnYgqaSUigfKiue68Zf6dgh
 cLUw==
X-Gm-Message-State: AOAM532PxUqdwb7PzDP26ROQn13iD1TkBtqleVWW92VHoPmYizgNuKVl
 dylxAXdM89nP/uGJpAghSS0kCATcU1hrRvzaA4JSx9UK5pcCGA==
X-Google-Smtp-Source: ABdhPJxRgSqc5R/GXu/2N0e9/avKVMSKIQpMZL9H2IOV5Bk3ix5iSHE+f4aSqNHlIAdSx94EX0tscdRnFZZhY1ajhZc=
X-Received: by 2002:a05:6808:14ce:: with SMTP id
 f14mr17966772oiw.59.1614084318362; 
 Tue, 23 Feb 2021 04:45:18 -0800 (PST)
MIME-Version: 1.0
From: Gautam Dawar <gdawar.xilinx@gmail.com>
Date: Tue, 23 Feb 2021 18:15:07 +0530
Message-ID: <CAJ-rMYrst2Xrg5a6dDTufMacqjy_Ccg2FM8XpAt4p2J9Yk_u7g@mail.gmail.com>
Subject: [PATCH v3] vhost_vdpa: fix the missing
 irq_bypass_unregister_producer() invocation
To: virtualization@lists.linux-foundation.org, 
 Jason Wang <jasowang@redhat.com>, mst@redhat.com, martinh@xilinx.com,
 gdawar@xilinx.com, hanand@xilinx.com
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

When qemu with vhost-vdpa netdevice is run for the first time, it works well.
But after the VM is powered off, the next qemu run causes kernel panic due to a
NULL pointer dereference in irq_bypass_register_producer().

When the VM is powered off, vhost_vdpa_clean_irq() misses on calling
irq_bypass_unregister_producer() for irq 0 because of the existing check.

This leaves stale producer nodes, which are reset in vhost_vring_call_reset()
when vhost_dev_init() is invoked during the second qemu run.

As the node member of struct irq_bypass_producer is also initialized
to zero, traversal on the producers list causes crash due to NULL pointer
dereference.

Fixes: 2cf1ba9a4d15c ("vhost_vdpa: implement IRQ offloading in vhost_vdpa")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211711
Signed-off-by: Gautam Dawar <gdawar@xilinx.com>

-----
changelog:
v2->v3:
 - Re-submitting the patch in plain text format as suggested by Michael
 - Added the fixes tag

v1->v2:
 - Addressed Jason's comment to remove the irq check and use
   vhost_vdpa_unsetup_vq_irq() to avoid local variable vq
-----


diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 62a9bb0efc55..e00573b87aba 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -844,14 +844,10 @@ static int vhost_vdpa_open(struct inode *inode,
struct file *filep)

 static void vhost_vdpa_clean_irq(struct vhost_vdpa *v)
 {
-       struct vhost_virtqueue *vq;
        int i;

-       for (i = 0; i < v->nvqs; i++) {
-               vq = &v->vqs[i];
-               if (vq->call_ctx.producer.irq)
-                       irq_bypass_unregister_producer(&vq->call_ctx.producer);
-       }
+       for (i = 0; i < v->nvqs; i++)
+               vhost_vdpa_unsetup_vq_irq(v, i);
 }

 static int vhost_vdpa_release(struct inode *inode, struct file *filep)
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
