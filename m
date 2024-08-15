Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F559BA20
	for <virtualization@lists.linux.dev>; Thu, 15 Aug 2024 00:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723683431; cv=none; b=p/Qst552wiynIBcJnvNXvkIbLyiXZvoF+hzEaLgLhpHYyd/CXa2JPFmFiSWJmw5jfVUXoaRQdSad17uj51HXGQuoGXmLJTSIsIDHbYpqKQvXB/BGC5TzckWXv52L1pD+vBrOAKAXyteyepFOIUJQ5pQ0o/8P1iiKzr2tGPhGthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723683431; c=relaxed/simple;
	bh=368TiaxNIcxCK60CWSg8TX4WbROxX/ctY6baf9Uo4PU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QAhxNM70SYdME1Svsgu/WXxZTgppibHo50++YGCM9jc5H1HlymmI33a7LWTQkujHkrUNd7EWIZz+YDtwg+CAzFEuzNKQQlout+P2eztpaQfLq6hbx47ese1cvWPBotR4bBpioSomF5b6iWOVZEKvae63GtRNfeGRlU1BScfiz2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Mwi0UJjR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mwi0UJjR"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a37c72b8caso1963385a.0
        for <virtualization@lists.linux.dev>; Wed, 14 Aug 2024 17:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723683429; x=1724288229; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mC/qr8MXY+EwHkMGwD4N6qk5mBndc0DNrIK0ECikEHI=;
        b=Mwi0UJjRQMjyNqNLDF5EIixbPxtQztVpmSc024M3iX8yC4SpdKm9FcTsZMQ8i41SBK
         fFoOW29NtguH21JAYKheIGr/3ndWBL93ahZT0euqioyu5qUf8ybrGy46suRGJMNEioso
         K1ozsn6fBgos8bcZIbFSV20uZhfcRLEAoJ0n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723683429; x=1724288229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mC/qr8MXY+EwHkMGwD4N6qk5mBndc0DNrIK0ECikEHI=;
        b=wkw4h1FkFQcxSxgWVCbzHrpEM7nmn4xUMLoec+s9oiogYbPNM57ksSJUtdDkQhFFtk
         G4iBKuBeqYuowuqgBgTp88ok7yh521V4fBYXTqqcnmDMuaQvKnysdvdvhmfz8F+WS5J5
         nyFQPeqCto1AsaajWWDIjPvELApe5LNt2ZB5PVO+MZ8Wsv6PfmccvVdJDybISsB/wptk
         upqrF5xKZlWCxPF/ql6TYFvJgJLCx16PbCJrZb77o8PLvgp0n+fx7MRMGAQldC1HRhli
         4NqaA0GAIkS9x5paIigrvwdWp5lqZUmgk5iiQNA4feSrZ1YUcvgiafIBbkQ1bwcKQPPG
         mfJA==
X-Gm-Message-State: AOJu0YyXxR/Mnwp1ZlGITE68f3QL3Zw5c0UaLVzb5fwUMfVg2CMQ2Yts
	38AAdhvMNZaF6Hn5k0Y98n6Tv1SNn3EpWwUkupaAMBZT4mkdNpunF1t2AEQjxw==
X-Google-Smtp-Source: AGHT+IFzFS1cAkp04Ak5eb02FF38FZuq4vN9/hrIFBugIoOlifoqQbAf2j9hy/A1dl3myUgxjXWyxw==
X-Received: by 2002:a05:622a:18a2:b0:44f:89e3:e8d2 with SMTP id d75a77b69052e-4535bb75416mr28547711cf.12.1723683428894;
        Wed, 14 Aug 2024 17:57:08 -0700 (PDT)
Received: from philipchen.c.googlers.com.com (140.248.236.35.bc.googleusercontent.com. [35.236.248.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a07249dsm1977581cf.89.2024.08.14.17.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:57:08 -0700 (PDT)
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
Subject: [PATCH] virtio_pmem: Check device status before requesting flush
Date: Thu, 15 Aug 2024 00:57:04 +0000
Message-ID: <20240815005704.2331005-1-philipchen@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a pmem device is in a bad status, the driver side could wait for
host ack forever in virtio_pmem_flush(), causing the system to hang.

Signed-off-by: Philip Chen <philipchen@chromium.org>
---
 drivers/nvdimm/nd_virtio.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvdimm/nd_virtio.c b/drivers/nvdimm/nd_virtio.c
index 35c8fbbba10e..3b4d07aa8447 100644
--- a/drivers/nvdimm/nd_virtio.c
+++ b/drivers/nvdimm/nd_virtio.c
@@ -44,6 +44,15 @@ static int virtio_pmem_flush(struct nd_region *nd_region)
 	unsigned long flags;
 	int err, err1;
 
+	/*
+	 * Don't bother to send the request to the device if the device is not
+	 * acticated.
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
2.46.0.76.ge559c4bf1a-goog

