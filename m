Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B493F65F6
	for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 10:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781692291; cv=none; b=mBxbptspGDIARoqXgSSLMMQtZ/9IDkwxTgMCrj9kSzoVyOMeITAO1x9ZYfdGqZjFe9lsaTB2uNeliYFZKziweSaBfrcOPc9OgtDfoyPrDYeuu/AkuQvyVHE9mYJ9KNjwQsTDJ04fNkxXW7SgfJVJZ15bdX3V5XydcbEw2uPNJmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781692291; c=relaxed/simple;
	bh=Bsu2l9ONC7HbFFdEO+yhGrPMQm+vAhw414YH/f8veHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5tgXcllrKvB6OfVTnRzYwi6miDdhoKDzaNHSd3b7PDQ1yV/qxKu9/0+Z2sRZ/xPlT5x6G2xrn1n5RSt3su/xTPLYCFLbL4k45nroRM/ButEG2lg8Rx6fC5wo4J/uOrhCPE+K/0dq7ZuFqzyb9LZwkiFZmZ+wkJ2QgamTafFSwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=esr+9xpk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esr+9xpk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781692289;
	h=from:from:sender:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:resent-to:
	 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references;
	bh=6MsmKmWCOsOVqQsn2afmiCg9PJfQEXeffS2heTK7guE=;
	b=esr+9xpkHpF3xgoZ2xDitPhm2h1WFZdfa+JQCGp5q4GBzkLmm1bNDFFhTGg1YdO0HrqGpU
	YDUxwVGXiJBOC7N1ZoV1h9BPgG6AR8E8skN1QyWq8l2vyA50qjc+RiGQ5IhrKi8xQQ2Xzc
	ur6+c5oF/WNW7yoYM9MeYYpVr66/XRU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-9xInshc3NEWOc-pmj81gQQ-1; Wed, 17 Jun 2026 06:31:26 -0400
X-MC-Unique: 9xInshc3NEWOc-pmj81gQQ-1
X-Mimecast-MFC-AGG-ID: 9xInshc3NEWOc-pmj81gQQ_1781692285
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae3bcf4cso28255045e9.3
        for <virtualization@lists.linux.dev>; Wed, 17 Jun 2026 03:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781692285; x=1782297085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:dkim-signature:delivered-to
         :delivered-to:resent-to:resent-message-id:resent-date:resent-from
         :from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MsmKmWCOsOVqQsn2afmiCg9PJfQEXeffS2heTK7guE=;
        b=ZjQo7vDsA4O4/d0FT7PYrtCXbvL4C9+hqV5iCvbDPidPIrMKbToXk3PmTEPQZ0h3uD
         KbhpGWR4RgCR9LsUe6vcuWC+Rush3Hyr9o9gHrkZmrtB9Dp96je2gALmQAZnLIUFKg6x
         ckLoP7ykQqHIcxt7dKJArfCbXqsHcRfhDUgdtWTUVuoNr/lOGc/rw2Gdbc0y2jTM80Sm
         otr1Q9m5N28xJSLXCO32Z9JuzjkZxAKS8helo8QxfYi+w5SCV+AcLFY3FRWBvdBIjMDD
         tvcfOVAVY7OmBHClkxMivvCbdlfO1rKeS5HnMjAjWi1u0X2k2J7p1W5qVqZmj4cRODxg
         KrBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DI8rqlXvGTOE9llKVt/cdScioY8DxFekWlsz111Rt3vFUGei9/w5vJTA9YokvMDeal3+gNHR/WcqdG+m1Iw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyxTvTpT2gqyG2KQM7JUhCeJe05QdnNCbVRe7KgGNc+iaunrDC
	GpH+FoNSUcUo7dZ6y6mJI4n/Rxe181+o3tvZ3N5mKk+Exu+H5QEp4NHowx/KEfXDquQVvA+kNjY
	TnsBp60GEVuJGNLF0ZzXwC0IMogRUk4bJbHKCL9kvMec6wr/chKzAqlJHQydxBmaiPn79lkaPzj
	VC
X-Gm-Gg: Acq92OEGefbZVapkrw27JPS5L0r7jQU3fBTUpHpsNJATNK1rsSQLg80z9I9q8ktcbc0
	GMYYqbNPTvZbOmpm0WwVRRF3BjuY49SbjkPE62zfEbC7Gl8RyfCXyq4Nf+MoZ31VDbg7wQUhlvK
	etVwZM4s3gUz1ruLNVbuPZCHsTfOhloBtM/qaMBpSD1UZqw6A/KxLLWH1fW7q40QL1eACG6zEMW
	RdL2ccaa9MfqVcNMD0oO8wgM/l0eYSXBRJ5+tnsV1/PTw2z3qZq+TkHfzioPLhwUpHngB965aoL
	Du2o30lopxwcNkGdt54Ec18FflnoRknCKV3POGyeTcscEa+dGg+/TiqKFqG+MWOG3G1go2xLo7P
	VZTadl6Ry0Ik7qfzas4VZnkpL2a2ETpAv
X-Received: by 2002:a05:600c:a144:b0:490:601f:d775 with SMTP id 5b1f17b1804b1-492333a02d6mr47278905e9.5.1781692285036;
        Wed, 17 Jun 2026 03:31:25 -0700 (PDT)
X-Received: by 2002:a05:600c:a144:b0:490:601f:d775 with SMTP id 5b1f17b1804b1-492333a02d6mr47278295e9.5.1781692284528;
        Wed, 17 Jun 2026 03:31:24 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49233bebc57sm35370995e9.2.2026.06.17.03.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:31:24 -0700 (PDT)
Sender: Michael Tsirkin <mtsirkin@redhat.com>
From: Qihang Tang <mst@redhat.com>
X-Google-Original-From: Qihang Tang <q.h.hack.winter@gmail.com>
Resent-From: "Michael S. Tsirkin" <mst@redhat.com>
Resent-Date: Wed, 17 Jun 2026 06:31:21 -0400
Resent-Message-ID: <ajJ3eaDYKRpaev_R@redhat.com>
Resent-To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, virtualization@lists.linux.dev
Received: from imap.gmail.com [64.233.184.108]
	by tuck.redhat.com with IMAP (fetchmail-6.5.7 polling redhat account mtsirkin@redhat.com folder INBOX)
	for <mst@localhost> (single-drop); Fri, 08 May 2026 03:58:44 -0400 (EDT)
Received: by 2002:a05:7108:3655:b0:569:1bde:8a97 with SMTP id e21csp58076gdd;
 Fri, 8 May 2026 00:58:35 -0700 (PDT)
X-Forwarded-Encrypted: i=3;
 AFNElJ99Ta1HxJbqNaF4Za2nDR7z/qPqWgYxroe5UjwNGil+caOGXbm73bfiH+nlNp6MrRhA0Y2BOzZINQ==@gapps.redhat.com
X-Received: by 2002:a05:6214:800c:b0:8b3:f59b:6c8 with SMTP id
 6a1803df08f44-8bc449ab1a3mr156788436d6.31.1778227115222; Fri, 08 May 2026
 00:58:35 -0700 (PDT)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-delivery-1.mimecast.com. [170.10.132.61]) by mx.google.com with
 ESMTPS id 6a1803df08f44-8b53db1a99csi260270446d6.613.2026.05.08.00.58.35 for
 <mtsirkin@gapps.redhat.com> (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384
 bits=256/256); Fri, 08 May 2026 00:58:35 -0700 (PDT)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-bJBWsglNMV6TBvNenkWF3g-1; Fri,
 08 May 2026 03:58:33 -0400
X-MC-Unique: bJBWsglNMV6TBvNenkWF3g-1
X-Mimecast-MFC-AGG-ID: bJBWsglNMV6TBvNenkWF3g_1778227113
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17]) (using
 TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits) server-digest SHA256) (No client
 certificate requested) by
 mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 E8EE21800451 for <mtsirkin@gapps.redhat.com>; Fri,  8 May 2026 07:58:32 +0000
 (UTC)
Received: by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix)
 id E3DD81944B20; Fri,  8 May 2026 07:58:32 +0000 (UTC)
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.90]) by
 mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E01BB195394A for <mst@redhat.com>; Fri,  8 May 2026 07:58:32 +0000 (UTC)
Received: from us-smtp-inbound-delivery-1.mimecast.com
 (us-smtp-inbound-delivery-1.mimecast.com [170.10.132.61]) (using TLSv1.3 with
 cipher TLS_AES_256_GCM_SHA384 (256/256 bits) key-exchange X25519
 server-signature RSA-PSS (2048 bits)) (No client certificate requested) by
 mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id
 6BE99180034C for <mst@redhat.com>; Fri,  8 May 2026 07:58:32 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-WFwogRdGNsKu-uINNZXqng-1; Fri, 08 May 2026 03:58:30 -0400
X-MC-Unique: WFwogRdGNsKu-uINNZXqng-1
X-Mimecast-MFC-AGG-ID: WFwogRdGNsKu-uINNZXqng_1778227109
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-358dff8447cso196191a91.0 for <mst@redhat.com>; Fri, 08 May 2026
 00:58:30 -0700 (PDT)
X-Received: by 2002:a05:6a21:68b:b0:3a3:2195:b536 with SMTP id
 adf61e73a8af0-3aa5b4e0a11mr6420960637.8.1778227108860; Fri, 08 May 2026
 00:58:28 -0700 (PDT)
Received: from localhost.localdomain
 ([240e:47c:d8d0:4133:1cd2:48d8:fcfa:10ea]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbdfb0sm10998532b3a.45.2026.05.08.00.58.25 (version=TLS1_3
 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256); Fri, 08 May 2026 00:58:28
 -0700 (PDT)
To: mst@redhat.com
Cc: jasowang@redhat.com, w@1wt.eu, eperezma@redhat.com, Qihang Tang <q.h.hack.winter@gmail.com>,   kvm@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH v5] vhost/vdpa: validate virtqueue index in mmap and fault paths
Date: Fri,  8 May 2026 15:58:21 +0800
Message-Id: <20260508075821.92656-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260508063745.90506-1-q.h.hack.winter@gmail.com>
References: <20260508063745.90506-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-MFC-PROC-ID: xYBbRmrejl6wZYb-1BK7Pc6jkCvbRJL8CEXZ3d2v8HM_1778227109
X-Mimecast-Impersonation-Protect: Policy=DMARC Check - CHG0118091;Similar
 Internal Domain=false;Similar Monitored External Domain=false;Custom External
 Domain=false;Mimecast External Domain=false;Newly Observed
 Domain=false;Internal User Name=false;Custom Display Name List=false;Reply-to
 Address Mismatch=false;Targeted Threat Dictionary=false;Mimecast Threat
 Dictionary=false;Custom Threat Dictionary=false
X-Mimecast-Impersonation-Protect: Policy=CLT - Impersonation Protection
 Definition;Similar Internal Domain=false;Similar Monitored External
 Domain=false;Custom External Domain=false;Mimecast External
 Domain=false;Newly Observed Domain=false;Internal User Name=false;Custom
 Display Name List=false;Reply-to Address Mismatch=false;Targeted Threat
 Dictionary=false;Mimecast Threat Dictionary=false;Custom Threat
 Dictionary=false
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Label: todo
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WPyjX1JCEQgyiA_z7Y2f4e-OxnbHSopK5UKhoUZCPdk_1781692285
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vhost_vdpa_mmap() and vhost_vdpa_fault() use vma->vm_pgoff as a
virtqueue index for get_vq_notification(), but they do not validate
that the index is smaller than v->nvqs.

The ioctl path already performs both a bounds check and
array_index_nospec(), but the mmap/fault path only checks that the
index fits in u16. This allows an out-of-range queue index to reach
driver-specific get_vq_notification() callbacks.

Fix this by extracting a unified vhost_vdpa_get_vq_notification()
helper that validates the queue index against v->nvqs and applies
array_index_nospec() before calling the driver callback. Both the
mmap and fault paths use this helper, and the bounds checking is
consolidated into a single location.

>From source inspection, the most defensible impact is out-of-bounds
access in the callback path, potentially leading to invalid PFN
remaps and crash/DoS.

Fixes: ddd89d0a059d ("vhost_vdpa: support doorbell mapping via mmap")
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Qihang Tang <q.h.hack.winter@gmail.com>
---
 drivers/vhost/vdpa.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 692564b1bcbb..ac55275fa0d0 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1482,16 +1482,32 @@ static int vhost_vdpa_release(struct inode *inode, struct file *filep)
 }
 
 #ifdef CONFIG_MMU
-static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
+static int
+vhost_vdpa_get_vq_notification(struct vhost_vdpa *v, unsigned long index,
+			       struct vdpa_notification_area *notify)
 {
-	struct vhost_vdpa *v = vmf->vma->vm_file->private_data;
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
+
+	if (index > 65535 || index >= v->nvqs)
+		return -EINVAL;
+
+	index = array_index_nospec(index, v->nvqs);
+
+	*notify = ops->get_vq_notification(vdpa, index);
+
+	return 0;
+}
+
+static vm_fault_t vhost_vdpa_fault(struct vm_fault *vmf)
+{
+	struct vhost_vdpa *v = vmf->vma->vm_file->private_data;
 	struct vdpa_notification_area notify;
 	struct vm_area_struct *vma = vmf->vma;
-	u16 index = vma->vm_pgoff;
+	unsigned long index = vma->vm_pgoff;
 
-	notify = ops->get_vq_notification(vdpa, index);
+	if (vhost_vdpa_get_vq_notification(v, index, &notify))
+		return VM_FAULT_SIGBUS;
 
 	return vmf_insert_pfn(vma, vmf->address & PAGE_MASK, PFN_DOWN(notify.addr));
 }
@@ -1514,8 +1530,6 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
 		return -EINVAL;
 	if (vma->vm_flags & VM_READ)
 		return -EINVAL;
-	if (index > 65535)
-		return -EINVAL;
 	if (!ops->get_vq_notification)
 		return -ENOTSUPP;
 
@@ -1523,7 +1537,8 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
 	 * support the doorbell which sits on the page boundary and
 	 * does not share the page with other registers.
 	 */
-	notify = ops->get_vq_notification(vdpa, index);
+	if (vhost_vdpa_get_vq_notification(v, index, &notify))
+		return -EINVAL;
 	if (notify.addr & (PAGE_SIZE - 1))
 		return -EINVAL;
 	if (vma->vm_end - vma->vm_start != notify.size)
-- 
2.39.5 (Apple Git-154)

