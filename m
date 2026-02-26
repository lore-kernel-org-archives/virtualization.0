Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B2D37E309
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106964; cv=none; b=FFqm3cYVNrCXIBSTCWSacUwosyuK3UKerd8Shgh/IQyvp00QXkyiYl+mG3FYz/3GcVJrwGRDFk0Ca4Y96IyPAdC/FlASMmr9GxwJQW2nF3Pi5NgszzP5p1+onCbDnfv8WDIsJGG/eAXGIvJ+6QtgkwJg931TNrZumSofGepFi38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106964; c=relaxed/simple;
	bh=uBDI6vCLVayNa9JEpUxQbP6AJj9VHRh0JPtcRkORuNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWVgCTTKrUlNKTpvObmHBpfpWlXSOknZ6mz6uFiGX2+CGvD1j7Myr4KS3wbLqezqKjv1kPLGOIOMnJJv7rgPrQiligUEnIOMDpjgMKtzLPoLHgtF1nchLWH0fcU2Rh0ysTbq1TO8X/g/xloKCMgWAOKqnhvmUEXgXnG9s8RZCXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QODUWkoc; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QODUWkoc"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c6e2355739dso275609a12.2
        for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 03:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1772106959; x=1772711759; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0M73OcDWXDbjnvZuhTobLpl4M5OeahGpDzSfF/B7/1g=;
        b=QODUWkocpckSUMztoT6eX6kmZTRa4XytG9ecJs6L/PFcddUBBFUjqWeOHfSw9RaU9G
         m5aTW7ZNu8VtnBlpznKHiGB9rZnhOg8SXH4qr4kLXJn2eH4Eu/8gRn1uIw+1B5K7hqln
         9ID9TSRZ/hh3ZjlcqSjFPc8NirsWIRyGl512PheVZ7Jm9dxPiFTzIOXNPdhBkqkEEGUn
         WqQ677efaPI8K5SDvViqRRPPgu78SFZlxNj6l47uqB7uo987KWS9mop3t83mnNkFdJRV
         +tb9ezA1Nc9UOE1RwDropApsOESXoYYsWnw2hEeu1B1IscT3zcoqgqA8CnYqyO56L5Zr
         fhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106959; x=1772711759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0M73OcDWXDbjnvZuhTobLpl4M5OeahGpDzSfF/B7/1g=;
        b=V+SKX3DQDx0Jd/3ygTbhWkh6C0rhoiKnDGeQGIjsstoAdRJfsi3oEVPqZLdx+4AZjV
         dLJBZZDKM3I2GSIxf+yDEZr7+tDzjuIGFAO3AJR7WUNILMRhnCSUufsmLDGYJn0g6wP1
         TveIOPSWoRfSDncp5fUs1C2NFN3omOmBMBvweHRSHJxK6KRygjOttrSOVVE+jFJ3STc1
         xESF4hp+lToZXcSZwHDGtBs0OArpQqhLB1TcJ7zt+R7EIw4QECzb8JATBDmsurnbCkns
         +dosg534d4RYN1b6JUoHpMJGzmCz1d+3BhOvZeYz9QShxZEHTaGGshGYBQ4NMYaYIsjI
         X/Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWazX0Q/o+RuOvYgVB14wzkU8rKuCLq8zRH8uIdvcyQ5pTz+3XoFmOMFpAFL7VECykGXgK8emi9ynzSmvFO1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmUsnKU1BU/1tTU6T4kPdcX67dRLEN6CmKT9SyuU65FzjS/rDm
	8b4A8nkhA68ZCo470OsBpYfLtK1e9+8dMZeMlbV86IaaXZN1NmkqBYTV1dz/amT3lgQ=
X-Gm-Gg: ATEYQzzNcha6MXjYJ904Q8d7pJkCK4tdC62MYB8jPcSKniaKY1jI7OwmOZLSTbjC8AD
	53v/nzvU4xa7UL/gXPsdVb2y2gGdvR2FoO4o0FIJ0E9BUhkd2kkYfBWLPeeHcUAL/xCBk4X7M20
	EPrxRGnKbZXnRaOAOj0cBq13Inb0dxr56DZCmUw7GRHuX9LX9TUbipgAJExLzdUaDUyK597c24E
	CAnG1gqgoUzpx2VtHyROx1bfhGvXGbX6VbWlPHbakTM28IUmuREjGFpXhRdEPCRZb2SI8IzzldQ
	LR+EaeQCR8OWhhYfSNA3EM9zkOgR5V2dBgzg6SZRxHDVJtCsEZ57uWD+nFRUA7niG/K2EuFKkl6
	GdDKj1k9SyTwJPFYIh1C98CEmExCTcrCpp7LvEmURnLz7pIJQfS90TCkuz8+QOUwTrTYt32fST0
	iXuBJDvk+rH00FtLzo71XT5tRW+QXLyadNmvehlHZxp+VYqlHcbkx+IaPqYPbD3ah+S71fFnQw5
	sluAw==
X-Received: by 2002:a17:90a:d646:b0:359:28b9:5f64 with SMTP id 98e67ed59e1d1-3593da6ffffmr1974038a91.6.1772106958977;
        Thu, 26 Feb 2026 03:55:58 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359130712bcsm2390815a91.7.2026.02.26.03.55.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 03:55:58 -0800 (PST)
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	marco.crivellari@suse.com,
	anders.roxell@linaro.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v4 1/2] vduse: Requeue failed read to send_list head
Date: Thu, 26 Feb 2026 19:55:49 +0800
Message-ID: <20260226115550.1814-2-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260226115550.1814-1-zhangtianci.1997@bytedance.com>
References: <20260226115550.1814-1-zhangtianci.1997@bytedance.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When copy_to_iter() fails in vduse_dev_read_iter(), put the message back
at the head of send_list to preserve FIFO ordering and retry the oldest
pending request first.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Reported-by: Michael S. Tsirkin <mst@redhat.com>
Suggested-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ae357d014564c..b37f18a0ce6fd 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -194,6 +194,12 @@ static void vduse_enqueue_msg(struct list_head *head,
 	list_add_tail(&msg->list, head);
 }
 
+static void vduse_enqueue_msg_head(struct list_head *head,
+				   struct vduse_dev_msg *msg)
+{
+	list_add(&msg->list, head);
+}
+
 static void vduse_dev_broken(struct vduse_dev *dev)
 {
 	struct vduse_dev_msg *msg, *tmp;
@@ -354,7 +360,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	spin_lock(&dev->msg_lock);
 	if (ret != size) {
 		ret = -EFAULT;
-		vduse_enqueue_msg(&dev->send_list, msg);
+		vduse_enqueue_msg_head(&dev->send_list, msg);
 		goto unlock;
 	}
 	vduse_enqueue_msg(&dev->recv_list, msg);
-- 
2.39.5

