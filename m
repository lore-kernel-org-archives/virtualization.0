Received: from esa10.hc2706-39.iphmx.com (esa10.hc2706-39.iphmx.com [216.71.140.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A504204E
	for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 18:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.140.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719340947; cv=none; b=awghp1emA6jdvWf6LLTyQ4/fxXmiFvuzZI8ptJ1LqPOU/QP6WN2Z9z30fL6gggrRZ0e865pxXMEu77TGOPdDXaQKvnq+X3kWizUagz5QsI+X8Ysv8cC74o/jNXP5jeksN7M6f9DlS3Xr1YnYMZ8PFWRHrJPLCjYTcUNAAWm6f/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719340947; c=relaxed/simple;
	bh=SseNpeKyupeNkoRBEoJQBVJ+Qm2dZaiugoWwAtZR+mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=buDgCIW7qMje8m4EdOnAN0VlIXbbnYWtw4ey//P5MqSsUDfbfc2aagsIiRTdjDVWKF2+ZGWvOZN4JzQg0D6tF+H/4lDwPH/AqufX8Fg28yh/xth7bIKRi2pizDDb4LMT4kEhj/ZQtLpLLeJLa1j9sz96fa4xrAjQtUwEQGhZOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bu.edu; spf=pass smtp.mailfrom=bu.edu; dkim=pass (2048-bit key) header.d=bu.edu header.i=@bu.edu header.b=cVai4+Ah; arc=none smtp.client-ip=216.71.140.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bu.edu header.i=@bu.edu header.b="cVai4+Ah"
X-CSE-ConnectionGUID: hZ0L3jNOQYCZfSZX4gEXag==
X-CSE-MsgGUID: CCBq6cUBTyiGO/9+7fdNTA==
X-IronPort-RemoteIP: 209.85.160.72
X-IronPort-MID: 375722548
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:P2D5ZK1v4gNib+RlKfbD5YJwkn2cJEfYwER7XKvMYLTBsI5bpzUAz
 WsdWmzQO/3ZamWmKdBxbtzj909U6J7Sz95lSQI+qSg9HnlHl5H5CIXCJC8cHc8zwu4v7q5Dx
 59DAjUVBJlsFhcwnj/0b/686yA6jfzVLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtH8CA6W0
 T/Ii5S31GSNhXgsYgr414rZ8Ekz5Kqo5WtD1rADTasjUGH2xiF94K03ePnZw0vQGuF8AuO8T
 uDf+7C1lkux1wstEN6sjoHgeUQMRLPIVSDW4paBc/H/6vTqjnVaPpcTbZLwW28O49m6t4kZJ
 OF2iHCFYVxB0psgOQgqe0Iw/ylWZcWq8VJcSJS1mZX7I0buKhMAzxjyZa2f0EJxFutfWAlzG
 fIkxD8lbiLbo7m05pWCe8JeiP8RHJXkEbMWtSQ1pd3ZJa5OrZHrRqzL4Zpf1W51iJ8UW/nZY
 MUdZHxkaxGojx9nYA9GTsJj2r723j+gKVW0q3rMzUYzy3PazAV32pDnLZzYdsHiqcB9xRnF+
 Ticojipav0cHPe04yPb+U+Guv7OsgS8CcFNGrGeytc/1TV/wURWUnX6T2CTv/ijllO3X9NNI
 lAV/SwGqakp6FftStj7Qg3+rHOa1iPwQPJVGuw+rQaEk+/avFzfCW8DQTpMLtchsafaWAAX6
 7NApPuxbRQHjVFfYSn1Gmu8xd9qBRUoEA==
IronPort-HdrOrdr: A9a23:etySTK8xPEP/pHyHQn1uk+D7I+orL9Y04lQ7vn2ZLiY4TiX4ra
 +TdZEgviMc5wx+ZJhNo7G90dC7MBThHMdOkO8s1NWZLWrbURqTTL2KhLGKq1eMJ8SZzJ856U
 4KSdkdNDSfNykAse/KpCW+DtY80J2m3cmT9J3jJq5WPHhXgndbnn9E4gH3KDwTeDV7
X-Talos-CUID: =?us-ascii?q?9a23=3A7/OKcGgSN9XnqvI6BOqsBNcREDJuck+F6CzSBWi?=
 =?us-ascii?q?BOE1bRoaneQOf1ZNtnJ87?=
X-Talos-MUID: 9a23:9jzqjQR5WbaS3c/yRXTHrxt7asxVyZi/CW8q1sRF5MeIExBZbmI=
Received: from mail-oa1-f72.google.com ([209.85.160.72])
  by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 14:41:14 -0400
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-254a2692f7bso6604459fac.1
        for <virtualization@lists.linux.dev>; Tue, 25 Jun 2024 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bu.edu; s=s1gsbu; t=1719340874; x=1719945674; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dcFRuze8aansEe6VFQfECvUgQS6Z3gD6NqAIG33MvOM=;
        b=cVai4+Ahn0vwcSAWRGMjZZ3wY7EYvRRsuQx1YnXekZXwrDOe6klGITLFrmf2mZSHqz
         QlRFE6LbRn7fdEAqKbY1Fz4USZjcnGjWcctgwD4Ov8gxSH/E7Aui8wQkORnqEPGAx5Ig
         kHP+TN/DfmawCLpM6dnMZnQ0Ky5P8KFu4MEO2rt/OTM1KWGbM78wNHP5cjyK2HTaCyvn
         Diiobn6VF6ob28AvDDWLdcdBwXmmjyD+4ftbgxuknfZAFea3a/iFb0IViVxpNrHBq3MT
         tJ0bDziMK4lWh6vTnI5VMCJapcRClqfBEDTPZNpVRMaUca9T98RdIwMVVlEwVTCCGVTW
         AD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719340874; x=1719945674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcFRuze8aansEe6VFQfECvUgQS6Z3gD6NqAIG33MvOM=;
        b=ZVCt3fJDL3ZlLQGEr9Cw0mVKG6XglT7hH8hkl3IbBmtAXM8ezDGEkI0C+fFyBOBUX7
         XLsQNHyYzDSWQbUNa67b3JT3AdGOvGxaeTaHUVX4sG5LC/Jbdg4IfXxo1IwH/UNFnHXp
         Qi9ObUe5w91vi03YaFUt4yjPGzVKmqBWzy4sJDZAZtdXzvWidFaIjFJgIjp60I9jFae4
         SOUCqA3YKdZ93qD8efSlAXR6uSrOzsftg6hsreQWiKeHizLS/UBNkPqW+KOxPRIJ/uZF
         qZ7CCqX35GF8CDYNt1yrSXb9ZaAPdH3CLnYH542CRyvO+6OAE8iJxa5A3ZB17VzZ1Gen
         izEQ==
X-Gm-Message-State: AOJu0YyU1ajUIEN4mxu/DoFPNCmm8LA0VEKs0tyIT8EvaBptA3N58jtA
	4f4VQfFV2yk+17CziKuO9dhTnQE1yB+HidBdBtRrNJDz04bvicXR91G6yF/GOlonlCW+NnuOfxq
	fmSIiHDj/ocnyq/8jobQhulyERxeeTZIyj8+LkEU5VY8MXhoj6pqwuCYANn3zQXphT6822r/5Ku
	cs4WM=
X-Received: by 2002:a05:6870:224b:b0:254:7936:e1df with SMTP id 586e51a60fabf-25cfcdf8cc9mr8781808fac.22.1719340873691;
        Tue, 25 Jun 2024 11:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMjaZqBEw3QnKN/jkLH/CWyrMPXlL2Z/h7A4AzTdTKNt2Uva8R2TACxlMVyAMtKKywIzRWqw==
X-Received: by 2002:a05:6870:224b:b0:254:7936:e1df with SMTP id 586e51a60fabf-25cfcdf8cc9mr8781785fac.22.1719340873309;
        Tue, 25 Jun 2024 11:41:13 -0700 (PDT)
Received: from dhcp-acadmin-128-197-176-198.bu.edu (dhcp-acadmin-128-197-176-198.bu.edu. [128.197.176.198])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce8b18fbsm432373485a.39.2024.06.25.11.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:41:12 -0700 (PDT)
From: sahanlb <sahanb@bu.edu>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	drepper@redhat.com,
	sahanlb <sahanb@bu.edu>
Subject: [PATCH] virtio-pci: PCI extended capabilities for virtio
Date: Tue, 25 Jun 2024 14:39:37 -0400
Message-ID: <20240625184043.10658-1-sahanb@bu.edu>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CES-GSUITE_AUTH: bf3aNvsZpxl8

PCI legacy configuration space does not have sufficient space for a device
that supports all kinds of virtio structures via PCI capabilities. This is
especially true if one were to use virtio drivers with physical devices.
Link: https://par.nsf.gov/servlets/purl/10463939
A physical device may already have many capabilities in the legacy space.

This patch adds support to place virtio capabilities in the PCI extended
configuration space and makes the driver search both legacy and extended
PCI configuration spaces.

Add new argument to vp_modern_map_capability to indicate whether mapping
a legacy or extended capability.
Add new function virtio_pci_find_ext_capability to walk extended
capabilities and find virtio capabilities.

Modify vp_modern_probe to search both legacy and extended configuration
spaces.
If virtio_pci_find_capability fails to find common, isr, notify, or device
virtio structures, call virtio_pci_find_ext_capability.

Notify virtio structure can get mapped either in vp_modern_probe or in
vp_modern_map_vq_notify. Add new attribute 'notify_ecap' to
struct virtio_pci_modern_device to indicate whether the notify capability
is in the extended congiguration structure.

Add virtio extended capability structures to
"include/uapi/linux/virtio_pci.h".
Format for the extended structures derived from
Link: https://lore.kernel.org/all/20220112055755.41011-2-jasowang@redhat.com/

This patch has been validated using an FPGA development board to implement 
a virtio interface.

Signed-off-by: sahanlb <sahanb@bu.edu>
---
 drivers/virtio/virtio_pci_modern_dev.c | 174 ++++++++++++++++++++-----
 include/linux/virtio_pci_modern.h      |   1 +
 include/uapi/linux/virtio_pci.h        |  31 +++++
 3 files changed, 175 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 0d3dbfaf4b23..75d0555edc7a 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -15,26 +15,41 @@
  * @size: map size
  * @len: the length that is actually mapped
  * @pa: physical address of the capability
+ * @ecap: capability is in the extended config space
  *
  * Returns the io address of for the part of the capability
  */
 static void __iomem *
 vp_modern_map_capability(struct virtio_pci_modern_device *mdev, int off,
 			 size_t minlen, u32 align, u32 start, u32 size,
-			 size_t *len, resource_size_t *pa)
+			 size_t *len, resource_size_t *pa, u8 ecap)
 {
 	struct pci_dev *dev = mdev->pci_dev;
 	u8 bar;
 	u32 offset, length;
 	void __iomem *p;
 
-	pci_read_config_byte(dev, off + offsetof(struct virtio_pci_cap,
-						 bar),
-			     &bar);
-	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, offset),
-			     &offset);
-	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
-			      &length);
+	if (ecap) {
+		pci_read_config_byte(dev, off + offsetof(struct virtio_pci_ecap,
+							 bar),
+				     &bar);
+		pci_read_config_dword(dev, off + offsetof(struct virtio_pci_ecap,
+							  offset),
+				     &offset);
+		pci_read_config_dword(dev, off + offsetof(struct virtio_pci_ecap,
+							  length),
+				      &length);
+	} else {
+		pci_read_config_byte(dev, off + offsetof(struct virtio_pci_cap,
+							 bar),
+				     &bar);
+		pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap,
+							  offset),
+				     &offset);
+		pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap,
+							  length),
+				      &length);
+	}
 
 	/* Check if the BAR may have changed since we requested the region. */
 	if (bar >= PCI_STD_NUM_BARS || !(mdev->modern_bars & (1 << bar))) {
@@ -142,6 +157,47 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
 	return 0;
 }
 
+/**
+ * virtio_pci_find_ext_capability - walk extended capabilities to find device info.
+ * @dev: the pci device
+ * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
+ * @ioresource_types: IORESOURCE_MEM and/or IORESOURCE_IO.
+ * @bars: the bitmask of BARs
+ *
+ * Returns offset of the capability, or 0.
+ */
+static inline int virtio_pci_find_ext_capability(struct pci_dev *dev, u16 cfg_type,
+						 u32 ioresource_types, int *bars)
+{
+	int pos;
+
+	for (pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VNDR);
+	     pos > 0;
+	     pos = pci_find_next_ext_capability(dev, pos, PCI_EXT_CAP_ID_VNDR)) {
+		u16 type;
+		u8  bar;
+
+		pci_read_config_word(dev, pos + offsetof(struct virtio_pci_ecap,
+							 cfg_type),
+				     &type);
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_ecap,
+							 bar),
+				     &bar);
+
+		/* Ignore structures with reserved BAR values */
+		if (bar >= PCI_STD_NUM_BARS)
+			continue;
+
+		if (type == cfg_type) {
+			if (pci_resource_len(dev, bar) &&
+			    pci_resource_flags(dev, bar) & ioresource_types) {
+				*bars |= (1 << bar);
+				return pos;
+			}
+		}
+	}
+	return 0;
+}
 /* This is part of the ABI.  Don't screw with it. */
 static inline void check_offsets(void)
 {
@@ -226,7 +282,12 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	int err, common, isr, notify, device;
 	u32 notify_length;
 	u32 notify_offset;
+	u8 common_ecap, isr_ecap, notify_ecap, device_ecap;
 	int devid;
+	common_ecap = 0;
+	isr_ecap    = 0;
+	notify_ecap = 0;
+	device_ecap = 0;
 
 	check_offsets();
 
@@ -257,18 +318,42 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 					    IORESOURCE_IO | IORESOURCE_MEM,
 					    &mdev->modern_bars);
 	if (!common) {
-		dev_info(&pci_dev->dev,
-			 "virtio_pci: leaving for legacy driver\n");
-		return -ENODEV;
+		/* Check extended configuration space. */
+		common = virtio_pci_find_ext_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
+							IORESOURCE_IO | IORESOURCE_MEM,
+							&mdev->modern_bars);
+		if (!common) {
+			dev_info(&pci_dev->dev,
+				 "virtio_pci: leaving for legacy driver\n");
+			return -ENODEV;
+		}
+		common_ecap = 1;
 	}
 
 	/* If common is there, these should be too... */
+	/* These also could be in the extended configuration space. */
 	isr = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_ISR_CFG,
 					 IORESOURCE_IO | IORESOURCE_MEM,
 					 &mdev->modern_bars);
+	if (!isr) {
+		isr = virtio_pci_find_ext_capability(pci_dev,
+						     VIRTIO_PCI_CAP_ISR_CFG,
+						     IORESOURCE_IO | IORESOURCE_MEM,
+						     &mdev->modern_bars);
+		isr_ecap = 1;
+	}
+
 	notify = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_NOTIFY_CFG,
 					    IORESOURCE_IO | IORESOURCE_MEM,
 					    &mdev->modern_bars);
+	if (!notify) {
+		notify = virtio_pci_find_ext_capability(pci_dev,
+							VIRTIO_PCI_CAP_NOTIFY_CFG,
+							IORESOURCE_IO | IORESOURCE_MEM,
+							&mdev->modern_bars);
+		notify_ecap = 1;
+	}
+
 	if (!isr || !notify) {
 		dev_err(&pci_dev->dev,
 			"virtio_pci: missing capabilities %i/%i/%i\n",
@@ -290,6 +375,13 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	device = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_DEVICE_CFG,
 					    IORESOURCE_IO | IORESOURCE_MEM,
 					    &mdev->modern_bars);
+	if (!device) {
+		device = virtio_pci_find_ext_capability(pci_dev,
+							VIRTIO_PCI_CAP_DEVICE_CFG,
+							IORESOURCE_IO | IORESOURCE_MEM,
+							&mdev->modern_bars);
+		device_ecap = 1;
+	}
 
 	err = pci_request_selected_regions(pci_dev, mdev->modern_bars,
 					   "virtio-pci-modern");
@@ -301,30 +393,48 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 			      sizeof(struct virtio_pci_common_cfg), 4, 0,
 			      offsetofend(struct virtio_pci_modern_common_cfg,
 					  admin_queue_num),
-			      &mdev->common_len, NULL);
+			      &mdev->common_len, NULL, common_ecap);
 	if (!mdev->common)
 		goto err_map_common;
 	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
 					     0, 1,
-					     NULL, NULL);
+					     NULL, NULL, isr_ecap);
 	if (!mdev->isr)
 		goto err_map_isr;
 
-	/* Read notify_off_multiplier from config space. */
-	pci_read_config_dword(pci_dev,
-			      notify + offsetof(struct virtio_pci_notify_cap,
-						notify_off_multiplier),
-			      &mdev->notify_offset_multiplier);
-	/* Read notify length and offset from config space. */
-	pci_read_config_dword(pci_dev,
-			      notify + offsetof(struct virtio_pci_notify_cap,
-						cap.length),
-			      &notify_length);
-
-	pci_read_config_dword(pci_dev,
-			      notify + offsetof(struct virtio_pci_notify_cap,
-						cap.offset),
-			      &notify_offset);
+	if (notify_ecap) {
+		/* Read notify_off_multiplier from config space. */
+		pci_read_config_dword(pci_dev,
+				      notify + offsetof(struct virtio_pci_notify_ecap,
+							notify_off_multiplier),
+				      &mdev->notify_offset_multiplier);
+		/* Read notify length and offset from config space. */
+		pci_read_config_dword(pci_dev,
+				      notify + offsetof(struct virtio_pci_notify_ecap,
+							cap.length),
+				      &notify_length);
+
+		pci_read_config_dword(pci_dev,
+				      notify + offsetof(struct virtio_pci_notify_ecap,
+							cap.offset),
+				      &notify_offset);
+	} else {
+		/* Read notify_off_multiplier from config space. */
+		pci_read_config_dword(pci_dev,
+				      notify + offsetof(struct virtio_pci_notify_cap,
+							notify_off_multiplier),
+				      &mdev->notify_offset_multiplier);
+		/* Read notify length and offset from config space. */
+		pci_read_config_dword(pci_dev,
+				      notify + offsetof(struct virtio_pci_notify_cap,
+							cap.length),
+				      &notify_length);
+
+		pci_read_config_dword(pci_dev,
+				      notify + offsetof(struct virtio_pci_notify_cap,
+							cap.offset),
+				      &notify_offset);
+	}
 
 	/* We don't know how many VQs we'll map, ahead of the time.
 	 * If notify length is small, map it all now.
@@ -335,11 +445,13 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 							     2, 2,
 							     0, notify_length,
 							     &mdev->notify_len,
-							     &mdev->notify_pa);
+							     &mdev->notify_pa,
+							     notify_ecap);
 		if (!mdev->notify_base)
 			goto err_map_notify;
 	} else {
 		mdev->notify_map_cap = notify;
+		mdev->notify_ecap = notify_ecap;
 	}
 
 	/* Again, we don't know how much we should map, but PAGE_SIZE
@@ -349,7 +461,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 		mdev->device = vp_modern_map_capability(mdev, device, 0, 4,
 							0, PAGE_SIZE,
 							&mdev->device_len,
-							NULL);
+							NULL, device_ecap);
 		if (!mdev->device)
 			goto err_map_device;
 	}
@@ -718,7 +830,7 @@ void __iomem *vp_modern_map_vq_notify(struct virtio_pci_modern_device *mdev,
 		return vp_modern_map_capability(mdev,
 				       mdev->notify_map_cap, 2, 2,
 				       off * mdev->notify_offset_multiplier, 2,
-				       NULL, pa);
+				       NULL, pa, mdev->notify_ecap);
 	}
 }
 EXPORT_SYMBOL_GPL(vp_modern_map_vq_notify);
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index c0b1b1ca1163..d9c2e66f23f4 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -41,6 +41,7 @@ struct virtio_pci_modern_device {
 	size_t common_len;
 
 	int notify_map_cap;
+	u8 notify_ecap;
 
 	u32 notify_offset_multiplier;
 	int modern_bars;
diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index a8208492e822..a7348ef8f61a 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -129,17 +129,43 @@ struct virtio_pci_cap {
 	__le32 length;		/* Length of the structure, in bytes. */
 };
 
+/* PCI extended capability header */
+struct virtio_pci_ecap {
+	__le16 cap_vndr;      /* Generic PCI field: PCI_EXT_CAP_ID_VNDR */
+	__le16 cap_rev:4;     /* Generic PCI field: capability version: 0x1 */
+	__le16 cap_next:12;   /* Generic PCI field: next ptr */
+	__le16 cfg_type;      /* Identifies the structure */
+	__le16 cfg_rev:4;     /* Identifies the version of the structure: 0x1 */
+	__le16 cap_len:12;    /* The bytes of the entire capability */
+	__u8 bar;             /* Where to find it. */
+	__u8 id;              /* Multiple capabilities of the same type */
+	__u8 padding[2];      /* Pad to full dword. */
+	__le32 offset;        /* Offset within bar. */
+	__le32 length;        /* Length of the structure, in bytes. */
+};
+
 struct virtio_pci_cap64 {
 	struct virtio_pci_cap cap;
 	__le32 offset_hi;             /* Most sig 32 bits of offset */
 	__le32 length_hi;             /* Most sig 32 bits of length */
 };
 
+struct virtio_pci_ecap64 {
+	struct virtio_pci_ecap cap;
+	__le32 offset_hi;             /* Most sig 32 bits of offset */
+	__le32 length_hi;             /* Most sig 32 bits of length */
+};
+
 struct virtio_pci_notify_cap {
 	struct virtio_pci_cap cap;
 	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
 };
 
+struct virtio_pci_notify_ecap {
+	struct virtio_pci_ecap cap;
+	__le32 notify_off_multiplier;	/* Multiplier for queue_notify_off. */
+};
+
 /* Fields in VIRTIO_PCI_CAP_COMMON_CFG: */
 struct virtio_pci_common_cfg {
 	/* About the whole device. */
@@ -186,6 +212,11 @@ struct virtio_pci_cfg_cap {
 	__u8 pci_cfg_data[4]; /* Data for BAR access. */
 };
 
+struct virtio_pci_cfg_ecap {
+	struct virtio_pci_ecap cap;
+	__u8 pci_cfg_data[4]; /* Data for BAR access. */
+};
+
 /* Macro versions of offsets for the Old Timers! */
 #define VIRTIO_PCI_CAP_VNDR		0
 #define VIRTIO_PCI_CAP_NEXT		1
-- 
2.42.0

