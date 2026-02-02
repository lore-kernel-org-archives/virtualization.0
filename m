Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05958221DB9
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 03:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770001980; cv=none; b=s1RtiDZiRvttJXm0WVxz8kJh018mXDAysbaMGQLbKInh9Acg6bTWc3tMk+lf4S4DoN1XunU8JJIM2pCQWUK/vnYxBIIStj74vXRLKGv2lqgzkboDZoiw5O1NURcO9PY7rZdSBDdFehu9LnxqHVFfuKMqxV85WEJIRr8B6qAZpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770001980; c=relaxed/simple;
	bh=7yhISprganOOYxh69Ev9h0O7lWNMFwfj4PHkG6GLE90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3s5XXe9dThuVlz66jyDSv3g44Shb3f1HUfw8SmLWm7/L1Z9+hkqg2seMCpITK/BAOu9Nvn4hqcnnK0drTZsP8sTHP7mwxAVZFBwtF13NS9UzRfCQApABGtiqGUyXili8nulG336R/DK9xbnK1J1a6rnfkinbNvQwQhJWbovoW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b1RlqShn; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="b1RlqShn"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a8ff2ca490so4784185ad.2
        for <virtualization@lists.linux.dev>; Sun, 01 Feb 2026 19:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770001978; x=1770606778; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WmjllnZw+5iXRdcSzwZdOKzRNkr16JL8ICqTiH9EaYg=;
        b=b1RlqShnGMXejsdEZh8L3bf6r2H8CwPSI0HI1l/CyOV4zaAhgq0mshcg4+CsKjgoaU
         TLkEGL2l9fB2DIL0Yfdzyvri3MWsCabUzISApQ85fVvDojRvb+GHRHRcyxANNjYnqJpp
         u6Wli0y0wui7EXbtcHe177EXkBR0Gn5znyvTmJsSxEY5UGSiDWObrFgwrJV4VJ8zQdeg
         S1UsCPW3MX/j5Iw4yRBlgIqtbxgIDtpUcM1rvsZkXyj+aa4ERxBl0pXJKt5EhqyK6beD
         EFzPMl6q1la4EybeCBPzYbPalRQC9jSxGGBkE+iHG7en95zsAB+H9wuMh7VMTIERz5nu
         43RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770001978; x=1770606778;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmjllnZw+5iXRdcSzwZdOKzRNkr16JL8ICqTiH9EaYg=;
        b=IGAUd0IQd6CiO6QyywuXAOCGn6UKoWbC+/OzH9vgwRO9/bnPDpqVD5G4FHY0xyRcPi
         IHh3kioeQHC09XXQ3Cd44rOvEmZU0Zmu9oT2VwzOhIg04n3dgQRmvx/omBVpMFk7IDQ+
         LMZJtxTI88sciRwRFCFTTtAzm8fuMFU+3yRWeemqcbLchkdsT/V0uZS3PuDk4+AIwwaH
         H9pc31CT6pshZOtFN8xzK1wt4GYV5D1SI2h2fP1M0MmXou2wkYBxp1DpRmKZ/DDS7MoK
         ewGi7T+puUdP74x9sHcJJUPu9+QBfhmtbZ5r8LZwXReHX4qUWS983KjZ8nTnpmgf86Yq
         Dtew==
X-Forwarded-Encrypted: i=1; AJvYcCW772OYqWJ5MN5yMCqggVHb+RV+bI+AFhSzs4LPsgyu7tpJm1IhokqayX9nfInJB0OhRHAceqlk1bc+W8KJjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzPppjGxCj2GFvYRWwec0hUafBN+xw/4RVBnNUxjUBs3NbjcOrR
	MQQSfeEsfaPG41Fzaltau93LEUkx7QC7JAauMAsXfKC8WJAMaZlKGu+BJ6pLfonqwFA=
X-Gm-Gg: AZuq6aLa9IjiZ013yeSRkmH1iaCNU7KaNw+Z3ph49hCi2/R15Km3QFPwolG6COK6Ku5
	h7hd/axuQW/gdk4diYDg6zevJS6E6wlgdZ5BJtfdsmFLs/5thurzDm7QNM+cSWR25+38umSstNg
	NNefiVjlLkhrOmbzHxEwpnvctYNeEFTE1cWh9y206oLoRJiJZWespjVQhoq/jG6lDgV+4Dwg8V8
	1liHFKKBVPMicL0VNCaiKpr15xYLTLV1b+HlcbHHqgv4bw/EDqSL5ohz6+DCV5el1ClFKNTR7KE
	4BIsxRvZedYmq0o0m9k0JSJUtGJ+jJRKe435Fo4leOXqrqa2uk0oZtk2g3P1Br3CQ7QaxZdCnnz
	sY0l5XdiNZ04dAirYhpVTbVbu2NHioJwhf84kJm5DbW9j4BqtopkH4U7XCkjta0Mni48jpwMKeM
	G8g0tq2dPvnpydgx2KwHJP2HYaaDptGhMbyq9R6pdXZU8OOVtWKFAnKq5HCg==
X-Received: by 2002:a17:903:190:b0:2a0:34ee:3725 with SMTP id d9443c01a7336-2a8d7ed32ecmr103955495ad.14.1770001978153;
        Sun, 01 Feb 2026 19:12:58 -0800 (PST)
Received: from tianci-mac.bytedance.net ([63.216.146.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d93cdsm127466295ad.70.2026.02.01.19.12.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 19:12:57 -0800 (PST)
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
	stable@vger.kernel.org,
	Xie Yongji <xieyongji@bytedance.com>
Subject: [PATCH v2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
Date: Mon,  2 Feb 2026 11:12:12 +0800
Message-ID: <20260202031212.26871-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is one race case in vduse_dev_msg_sync and vduse_dev_read_iter:

vduse_dev_read_iter():
    lock(msg_lock);
    dequeue_msg(send_list);
    unlock(msg_lock);
vduse_dev_msg_sync():
    wait_timeout() finish
    lock(msg_lock);
    check msg->complete is false
        list_del(msg);   <- double list_del() crash!

To fix this case, we shall ensure vduse_msg is on send_list or recv_list
outside the msg_lock critical section.

Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
---
v2:
 - Rewrite commit message.                        [Michael]
 - Add Fixes tag and cc stable email list.        [Eugenio]
 - Rewrite one comment.                           [Michael]

v1: https://lkml.org/lkml/2026/1/30/323

 drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ae357d014564c..a70d0580d54e8 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -325,6 +325,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct vduse_dev *dev = file->private_data;
 	struct vduse_dev_msg *msg;
+	struct vduse_dev_request req;
 	int size = sizeof(struct vduse_dev_request);
 	ssize_t ret;
 
@@ -339,7 +340,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		ret = -EAGAIN;
 		if (file->f_flags & O_NONBLOCK)
-			goto unlock;
+			break;
 
 		spin_unlock(&dev->msg_lock);
 		ret = wait_event_interruptible_exclusive(dev->waitq,
@@ -349,17 +350,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		spin_lock(&dev->msg_lock);
 	}
+	if (!msg) {
+		spin_unlock(&dev->msg_lock);
+		return ret;
+	}
+
+	memcpy(&req, &msg->req, sizeof(req));
+	/*
+	 * We must ensure vduse_msg is on send_list or recv_list before unlock
+	 * dev->msg_lock. Because vduse_dev_msg_sync() may be timeout when we
+	 * copy data to userspace, and will call list_del() for this msg.
+	 */
+	vduse_enqueue_msg(&dev->recv_list, msg);
 	spin_unlock(&dev->msg_lock);
-	ret = copy_to_iter(&msg->req, size, to);
-	spin_lock(&dev->msg_lock);
+
+	ret = copy_to_iter(&req, size, to);
 	if (ret != size) {
+		spin_lock(&dev->msg_lock);
+		/* Roll back: move msg back to send_list if still pending. */
+		msg = vduse_find_msg(&dev->recv_list, req.request_id);
+		if (msg)
+			vduse_enqueue_msg(&dev->send_list, msg);
+		spin_unlock(&dev->msg_lock);
 		ret = -EFAULT;
-		vduse_enqueue_msg(&dev->send_list, msg);
-		goto unlock;
 	}
-	vduse_enqueue_msg(&dev->recv_list, msg);
-unlock:
-	spin_unlock(&dev->msg_lock);
 
 	return ret;
 }
-- 
2.39.5

