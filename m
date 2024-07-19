Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA915A35
	for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721367997; cv=none; b=iomlSWJFnumDdt49qkEuqt0Sjz8Qs2LswszWHM9hKpbQfVQeSn9C63Cf1s9XsiL/Svz94HKvcRXPlj+E2A8t1xfxojY41V1ORKy8KXPfHOqBGWMPE6TiDD4P+Dvx0zwlwiLIN7mZdADFCEXLIIe+bpCuKw0ZgFDtNH0ZlLav8sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721367997; c=relaxed/simple;
	bh=zN9/+1rjuerro0jVu0FzfAdAWYuIzI1B6N+VFbumnxY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HPNVfyDKkmyS3wJT+9W6QIAGRQqcTQp5SX+X0aQuTz31E2f74C1EJbatlxoP0pWKxkMBbo9TNBg8Rvw/aeiHvERvHbB63gKsAdGDfVzw0P+QlSV/WvXeZWd2gWyAyHXUL6t3MkiZr0xTZXYzDkQG2oxDWtanJzI81TiG8ujyQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwWfwbwb; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwWfwbwb"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-66526e430e0so17364257b3.2
        for <virtualization@lists.linux.dev>; Thu, 18 Jul 2024 22:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721367995; x=1721972795; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJjS/wLv9JaYG5E9s7DpraVtwtjmPgBNfmPRbaC7JfU=;
        b=UwWfwbwbnYWYNVBMXFllILsFHBVr6bVxnotTVVum1lvyeyjs1LAfJ/H//qgYks4cXG
         oC8OLs4qkI03zRxZOzfKa82Lw0X0VkN7Hf6jowztc5iuEzwXNkPLvNWjWCySYw0wBa2R
         rArbdrxR2rLfPpgVG8tUvWiiEV58R6JGYAeog/LPW1QDHUPiab5xqid4p4R6AabfLyd9
         Fag6baecF1+F5/gkEH5u0xORwXDAfpllH5qCCYs+LTAtwxTLnM4ME/+t/txHW10/NU1P
         VHC2j9CvkFRv3PmCVwHE+E2IIyqKeQFnoehxueNEWPSnDaeCTRLiFKEszm00/f2ZSJna
         HbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721367995; x=1721972795;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJjS/wLv9JaYG5E9s7DpraVtwtjmPgBNfmPRbaC7JfU=;
        b=KFlvvX4i2eFrYKeLdI0CZoW7hannxyukAjg2dpqPUsbOIQ10zwb5SfLlynjai5S5GO
         FDrmkYweDnDr0WEhiChdYcuB4TlrTO2Yf5t4itFRE1LEbUEswIwCBxjctn/7+Uj0lIDv
         0g4APrKN3YOQ7gdObj/zHm6iopS2fRO9Xjy5xRsblRMXWy/FdFibi2r8MYnx/+DIm2UM
         72it2vzwG4D5mTJ8B3pL2M+FEJBAcDQRXNxeKGTtwgWjvgUwvEHLmJkstfndtHdMaSE5
         emmvHosgqNBiWLzO2IJxSoRe09Nq3OTQnHE57U1rysUuTYti8IVgxHccZ8yBlwYtXeo9
         0gaA==
X-Gm-Message-State: AOJu0Yzn3HiTuUReHIoNNsvGVPZKOOCilKprj61X6gJojSLlhzrrE+yW
	o6LaqcGIHfl8yTSswNcSGcrr02zRIQr/a0LZCle/CQFVXSPivV88
X-Google-Smtp-Source: AGHT+IFG9O8rwQBcgRxDxDzzVmRJF2TUN2KgKHijtF82ufeDzuBXEgsDqFJYDAReQlEE3I9qLat9QA==
X-Received: by 2002:a81:7c02:0:b0:664:66d8:634f with SMTP id 00721157ae682-664ffeae0dbmr75546997b3.44.1721367994907;
        Thu, 18 Jul 2024 22:46:34 -0700 (PDT)
Received: from fedora ([2800:e6:4000:47e:7c52:7bd4:cfe5:9874])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-669541b9f7esm2564757b3.114.2024.07.18.22.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 22:46:34 -0700 (PDT)
Date: Fri, 19 Jul 2024 00:46:31 -0500
From: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev, trivial@kernel.org
Subject: [PATCH] virtio: Fix various coding style issues
Message-ID: <Zpn9t5xJCPMhvpZO@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Address various coding style warnings in the virtio_mmio driver:

- Move trailing `*/` to a new line in block comments.
- Use parentheses with sizeof for consistency.
- Add missing blank line after declarations.
- Replace 'S_IRUSR' with '0400' for permissions.

Signed-off-by: Juan José Arboleda <soyjuanarbol@gmail.com>
---
 drivers/virtio/virtio_mmio.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 173596589c71..7e6e41b2fb5a 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -74,7 +74,8 @@
 
 
 /* The alignment to use between consumer and producer parts of vring.
- * Currently hardcoded to the page size. */
+ * Currently hardcoded to the page size.
+ */
 #define VIRTIO_MMIO_VRING_ALIGN		PAGE_SIZE
 
 
@@ -167,21 +168,21 @@ static void vm_get(struct virtio_device *vdev, unsigned int offset,
 	switch (len) {
 	case 1:
 		b = readb(base + offset);
-		memcpy(buf, &b, sizeof b);
+		memcpy(buf, &b, sizeof(b));
 		break;
 	case 2:
 		w = cpu_to_le16(readw(base + offset));
-		memcpy(buf, &w, sizeof w);
+		memcpy(buf, &w, sizeof(w));
 		break;
 	case 4:
 		l = cpu_to_le32(readl(base + offset));
-		memcpy(buf, &l, sizeof l);
+		memcpy(buf, &l, sizeof(l));
 		break;
 	case 8:
 		l = cpu_to_le32(readl(base + offset));
-		memcpy(buf, &l, sizeof l);
-		l = cpu_to_le32(ioread32(base + offset + sizeof l));
-		memcpy(buf + sizeof l, &l, sizeof l);
+		memcpy(buf, &l, sizeof(l));
+		l = cpu_to_le32(ioread32(base + offset + sizeof(l)));
+		memcpy(buf + sizeof(l), &l, sizeof(l));
 		break;
 	default:
 		BUG();
@@ -209,22 +210,22 @@ static void vm_set(struct virtio_device *vdev, unsigned int offset,
 
 	switch (len) {
 	case 1:
-		memcpy(&b, buf, sizeof b);
+		memcpy(&b, buf, sizeof(b));
 		writeb(b, base + offset);
 		break;
 	case 2:
-		memcpy(&w, buf, sizeof w);
+		memcpy(&w, buf, sizeof(w));
 		writew(le16_to_cpu(w), base + offset);
 		break;
 	case 4:
-		memcpy(&l, buf, sizeof l);
+		memcpy(&l, buf, sizeof(l));
 		writel(le32_to_cpu(l), base + offset);
 		break;
 	case 8:
-		memcpy(&l, buf, sizeof l);
+		memcpy(&l, buf, sizeof(l));
 		writel(le32_to_cpu(l), base + offset);
-		memcpy(&l, buf + sizeof l, sizeof l);
-		writel(le32_to_cpu(l), base + offset + sizeof l);
+		memcpy(&l, buf + sizeof(l), sizeof(l));
+		writel(le32_to_cpu(l), base + offset + sizeof(l));
 		break;
 	default:
 		BUG();
@@ -281,7 +282,8 @@ static bool vm_notify(struct virtqueue *vq)
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
 
 	/* We write the queue's selector into the notification register to
-	 * signal the other end */
+	 * signal the other end
+	 */
 	writel(vq->index, vm_dev->base + VIRTIO_MMIO_QUEUE_NOTIFY);
 	return true;
 }
@@ -699,6 +701,7 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 static void virtio_mmio_remove(struct platform_device *pdev)
 {
 	struct virtio_mmio_device *vm_dev = platform_get_drvdata(pdev);
+
 	unregister_virtio_device(&vm_dev->vdev);
 }
 
@@ -799,7 +802,7 @@ static const struct kernel_param_ops vm_cmdline_param_ops = {
 	.get = vm_cmdline_get,
 };
 
-device_param_cb(device, &vm_cmdline_param_ops, NULL, S_IRUSR);
+device_param_cb(device, &vm_cmdline_param_ops, NULL, 0400);
 
 static int vm_unregister_cmdline_device(struct device *dev,
 		void *data)
-- 
2.45.2

