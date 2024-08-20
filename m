Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2521BBBE8
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174583; cv=none; b=HaRSpszW6bZwCMAAmltV3Fdyer3sj0YipBRyUzD/tolpmrXL/T/lTQNLaaBtYXd8gHYxA1Wsl40p+L5dVoEbAwg1alljIygNuVNdgDIlYF2HfQUhR5EAunqUSzYxC3CZ2jbEO3NPTMXNepqGV6Cjwjb+9YqucJ+B5Va22fTU4LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174583; c=relaxed/simple;
	bh=WoePu1j9VOd2T7GWO2R+V03LjT4GKPVJ+35Dd/6RTPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGR6LeEEwkxRlQ2yRofZsqM3SZ1hkJOv7wkDvBUqaShDIPHrOd7Py9JzQhjLZoS3W5EeYPTAV1IKX8hiRlPrwv+GxO0jcfs2W8N3vWLJQRMa8l+r/ltGoo4lpdSSgnu3DHJh/Qn8Fsu5x3uS3qCc6Yfh1qGqfnDvOGCyPa79MWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EjCOZ/IP; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EjCOZ/IP"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1d6f47112so406258285a.0
        for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724174581; x=1724779381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nG3sk+SGqgopURDWRpSLqodBy9lchgvdy2diDegZ/Gw=;
        b=EjCOZ/IPRXHDBh/CEWA69lfZ459gye8IXG9xm9B9kW836akv7RI51XG3iKq2ggH342
         D9C9AuYafYCMZYdRIMBAj9KvGzq8hS6/B/iQ89kj90xKlnuDTeQTShj//3odWHnIZpwG
         j4EH7qGlP286JLD+g4hI4c+QEML97EmpDnmkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724174581; x=1724779381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nG3sk+SGqgopURDWRpSLqodBy9lchgvdy2diDegZ/Gw=;
        b=CCvTkO8oPbICFMo2rZ00saZ9E7XxkFBJSkPDSNpjUCL40EM3HiWC8XFe63sOfCoIUO
         c/N5DmU3ni+r8qLMmPR97iN07mC3kZUJzamxEzl+Fo8KzcJ29Su8AqkqZ/VFE+X/WZ5r
         pSolHHkdA8el6MCYuBsTWem18tHJj8nx6p8+qcB9Lvx4yQB/FdkLLMm1ku6zY5BaY2PP
         EuiyyvlTqXFe1bAAwypaRLdIOKnyELlm72kCVQGMmzoIXyHCHpz95pWokf5tHpJbojYr
         0e/7ODkAiZMaEOJ2OtpbRDXRLBuAu9H3U4tlzRD2A1lEMKAe8nV3cLjeN3IuB3eyjftj
         Ps0Q==
X-Gm-Message-State: AOJu0YwVR4yIPi++eOjU66itMCAPmR53prsC4PvhthvEPzSA0yzAEoYo
	nUW3sBiKCREx5b4LM4dQ+l0HaMPmO85QndGIJMu3kofnsjVpkAvFrZG0NJrEXw==
X-Google-Smtp-Source: AGHT+IGLC0VAnx3ACOqPL6vui1/41GTnaKvRUKl8IQ/H2tHfiWeItGJfBZfdI5j/ZjUY1Sk7SMbEsg==
X-Received: by 2002:a05:620a:370e:b0:79d:7ae3:4560 with SMTP id af79cd13be357-7a5069af85bmr1549222885a.55.1724174580540;
        Tue, 20 Aug 2024 10:23:00 -0700 (PDT)
Received: from philipchen.c.googlers.com.com (140.248.236.35.bc.googleusercontent.com. [35.236.248.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff0e42e9sm545390885a.88.2024.08.20.10.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 10:23:00 -0700 (PDT)
From: Philip Chen <philipchen@chromium.org>
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Cc: virtualization@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Philip Chen <philipchen@chromium.org>
Subject: [PATCH v2] virtio_pmem: Check device status before requesting flush
Date: Tue, 20 Aug 2024 17:22:56 +0000
Message-ID: <20240820172256.903251-1-philipchen@chromium.org>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a pmem device is in a bad status, the driver side could wait for
host ack forever in virtio_pmem_flush(), causing the system to hang.

So add a status check in the beginning of virtio_pmem_flush() to return
early if the device is not activated.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---

v2:
- Remove change id from the patch description
- Add more details to the patch description

 drivers/nvdimm/nd_virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 35c8fbbba10e..97addba06539 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	unsigned long flags;
 	int err, err1;
 
+	/*
+	 * Don't bother to submit the request to the device if the device is
+	 * not acticated.
+	 */
+	if (vdev->config->get_status(vdev) & VIRTIO_CONFIG_S_NEEDS_RESET) {
+		dev_info(&vdev->dev, "virtio pmem device needs a reset\n");
+		return -EIO;
+	}
+
 	might_sleep();
 	req_data = kmalloc(sizeof(*req_data), GFP_KERNEL);
 	if (!req_data)
-- 
2.46.0.184.g6999bdac58-goog

