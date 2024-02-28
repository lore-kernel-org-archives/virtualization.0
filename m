Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327579B86
	for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144655; cv=none; b=T6qQqQFU7fb+scSgiO2lM9WW4LJW5KyOZvRWpG3flPURV+xIw4o0BixktsYpKiqcfPKkt2sqPUvsLlF0bbY8yU0xHmGKwH3GitAWc8zpugVB+rLBzrUkvf4RXpjveS6K86/e42UY5i3JuXJ69KPmHxMFLQIrBDcclSgoQ+ZrQGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144655; c=relaxed/simple;
	bh=r81XQMf23teX1T+JGKRU64I4W8Z8plFKuxG2dA9W0e0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=A0rdQkbwvrk7Agk9oDS+LF99FPs4CHmG6xhPDlgU749ZlX1WfLoBoC++maXNviPMPOtZHGSZSRQKKVSFknx2z2L6Jcy9g7O+or4vEddsUFURDtzRB+WN1y7cqfEq68nXQpWFjcBdd3Y+E+PR66JDJ8so+NvvERoVWElLGgrHy9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hzs2gIWR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hzs2gIWR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-412b7bb0bd3so299415e9.1
        for <virtualization@lists.linux.dev>; Wed, 28 Feb 2024 10:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709144651; x=1709749451; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Qz1dKrMSqcJN7vhekUwEPSMU/YeVaBN11f7/M4F1f4=;
        b=Hzs2gIWROrtujPabALrmq7j8VUBXCoUjUuF9fn6G7EmxKQ+cpiLfPBIopSrgupacmT
         xyQp3+/ZTcyVgnFEnldews7QApotK+zWRt91pkT/SYVeJEDU8YF+49PJhsSlfxAl2+Bm
         DBO5bcUrFaES+EkasU5qFPOEVvSxUoI9UpHA0PaJtP8lSV22vK2A1ACHKUlbRcgG9+X4
         EiibKOnp55Svg89/vksqi1Wqc24sS20Omi8lnPMYWepQGlBUDuZqKOlPaNsOw7J6m6Dp
         YVT7OHD+S2hQl32GeqD28Okwp2mKkkJ2NcbXYPXWNqV3SyD5rgKr4Vy81PNpGtAP6cUs
         3j+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709144651; x=1709749451;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Qz1dKrMSqcJN7vhekUwEPSMU/YeVaBN11f7/M4F1f4=;
        b=jTGRMNq8dOzCUPUcX9icbr3YU8JIQ6ZAem9+EwUZY2P427Qzy2gKazJu9tuBjU+yzf
         1VNwVVCYR+j+V4j/yN1OfRxgGeQVvLICkVCN19q/lzRzo/qDLqL5BceLZI8XQujV8SNe
         Lqgn/B3nHutUYc9GBdvXW9rn6F4TjlJ5gB12dMr0g5V5mo7ND3aWMbkoT0yIv2XeMx36
         dkorbuUNNV35Xm2SjYk7WJxNwmn8obH/Gf8x/9aiSKTLM0OrcXJkkrzDT5LoGUxBwD7x
         uzIBIvJflVxKJOOy6TPoYfstLrefsSB8s9b37aCm7S+cebxc9CMUYYwT35Q5F0iaFQac
         f3/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9UV7nlt8mCp605hYcYwvV8wG+U4r7z5vMtnbSNCitZFPOMVF2l9oLbVHLAk5ZMYw3dGZVU54rinHeF8UbKwPbz9wfGKkfzDWZcgHESkE=
X-Gm-Message-State: AOJu0YyvGcZBqxtMtRm+KzQclJpTxK2NtXuYO22vSYAkFFjvrGHAB/i+
	5lR7Gu3TZyQ6R3n1Ca+phfY7tROUhkzp0tZ69c4oQOUUcrGWQ/udiVpBabUCX+A=
X-Google-Smtp-Source: AGHT+IElRJ3gqeiSGlL5qwYW93OYT6mf3vu1RfSzg+Bf0SkGa+KphevMjr4f+hkHMRduO19FmMIfEA==
X-Received: by 2002:a05:600c:4e90:b0:412:b659:1ac9 with SMTP id f16-20020a05600c4e9000b00412b6591ac9mr58808wmq.11.1709144651138;
        Wed, 28 Feb 2024 10:24:11 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id q16-20020a7bce90000000b0041069adbd87sm2781312wmj.21.2024.02.28.10.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:24:10 -0800 (PST)
Date: Wed, 28 Feb 2024 21:24:07 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cindy Lu <lulu@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Xie Yongji <xieyongji@bytedance.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH v3] vduse: Fix off by one in vduse_dev_mmap()
Message-ID: <98298b2f-7288-4b0b-8974-3d5111b589cb@moroto.mountain>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The dev->vqs[] array has "dev->vq_num" elements.  It's allocated in
vduse_dev_init_vqs().  Thus, this > comparison needs to be >= to avoid
reading one element beyond the end of the array.

Add an array_index_nospec() as well to prevent speculation issues.

Fixes: 316ecd1346b0 ("vduse: Add file operation for mmap")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: add array_index_nospec()
v3: I accidentally corrupted v2.  Try again.

 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b7a1fb88c506..eb914084c650 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1532,9 +1532,10 @@ static int vduse_dev_mmap(struct file *file, struct vm_area_struct *vma)
 	if ((vma->vm_flags & VM_SHARED) == 0)
 		return -EINVAL;
 
-	if (index > dev->vq_num)
+	if (index >= dev->vq_num)
 		return -EINVAL;
 
+	index = array_index_nospec(index, dev->vq_num);
 	vq = dev->vqs[index];
 	vaddr = vq->vdpa_reconnect_vaddr;
 	if (vaddr == 0)
-- 
2.43.0

