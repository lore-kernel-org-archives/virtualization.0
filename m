Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651411F181F
	for <virtualization@lists.linux.dev>; Mon,  2 Feb 2026 07:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770017241; cv=none; b=t2fGZPcbOtkkEeAx69eTPjMt3XxeKIwzUh1Dvs26lS3yXkFFYENy0ToPDBkhrc4w26ZigkvNsLNZYf/I2S+jy4wVpikbg+CVgVgEKqwTWqiXeL8RGtxpSv4ps9RL6dPKXTo9HPfqzogLLRHWOus+uOyigikEtcdAJku1gaPyqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770017241; c=relaxed/simple;
	bh=pl6VwA/VUV/Zau9QfAtae90e95h4JJbv1lONMJ4/9Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUqW7MhC3lukB0NnBlTgnuQ+GEoewOcMRyuv1xYz2Mu7mrkHfVCIzEwQDUH+HB/32azzUN41xZ/I3dKfQHv+O6vVVjVwSDP3HZmblyptdfAfZN4qSMl9DwG40I+DP06roEW9N9vXGAIk/VHLUro36sujYZq8V325TdG8uWJfV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QF6ofgQh; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QF6ofgQh"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c633984fbeeso1683318a12.0
        for <virtualization@lists.linux.dev>; Sun, 01 Feb 2026 23:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1770017240; x=1770622040; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kmq6UkeFlJ38GZ9Njho8FK6yJ51WYaa7aCjJvi0pQSw=;
        b=QF6ofgQh+8FQkM0ENBL52EoKUIfzM2W2jRMstaN43klursXkncJJHPNTewyW2cVU4t
         LrIp879sF+R+U8DbjYqIUWcEetpL86Gl4TxLdvmkiBxs8kVKV8v+0q9Ubdj0v3hPDsDx
         dWLibQMLDZ+58eLgnMxjSJ4xnJ99/rDUvj8VD7HXCG5FelKGVQbb56DaqwQqQnOMsNsT
         DDs63Ns71e6pFOSy1dAml8TbkcEukGCczHjPU+kf7XXHBJha5S6wgmYXy7H7uAKni0qe
         0V0bCD8m+RjOnogg4jzxHXXUTmniSFd+Pcl0CnhQWllXwpW+Pk/BK3a4AxC2jNz2DkGC
         F35A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770017240; x=1770622040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kmq6UkeFlJ38GZ9Njho8FK6yJ51WYaa7aCjJvi0pQSw=;
        b=g0dbC+yIf26A5MCwZ6QWbCLLPhdHcFU1l4iwzyA3kACWl5dM4lqbX8gPBchfKrzEeP
         cQm88Tgz4ueAz9WiQ+3u1M6ATRp1CXqMXZ5awxP8txI4QRvSeQSPpUrMwaADM9Px7G+k
         IjssxNKwxHr3L8gyYiuF8BSwYMJr4+VGpkblyBBacMf5NDo5pubJRVRET+QecE4ng3F/
         n5IhH2nV1z5j9v+Z1RPRED+lj8pcPonEdyoVA66HQlOu+gd7MvFqZmKIy0FtROG+Ltwp
         aylDMZJYFzpCTDb6n9QwC6PzXN5e1mIGjErwVV+fYUEKn3GGr7fV2pSLeseRZ1fYEKTq
         WuXw==
X-Forwarded-Encrypted: i=1; AJvYcCXWzOK/JjpY201ZW4M4b7DbhCi6pf/rQZ7xlw4DLWioHrZwg4KB97KlJ9vzk7oWvzy6bXXIX9ZSLScfrVN5Hw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzXukR0gqV2OgSgowK5i32bRT0+Cv96hYGbOm65TODg1qCozwaO
	snA+oaia7DaplXxIauERIkdiDo7mfuU4+7I/1pRCmIQg+gYmzU1OaoduTEtGlexB9FfQ0x0cYH/
	bIIIsMTDMfuG7
X-Gm-Gg: AZuq6aI0BNG9yZB2bi8vZK6fvSb2FRxFwrLsfpHkVhC2Kpn2dcb3Fgj4nGlUMYbqqqw
	pb3VJoP2m+P7NeTA2MTvk2dFzkL4I02XkmcW8MsQCZ3JeEo5zAwWxQiVBzSP2RM1+bFrxyrpz/z
	kq57SIOojhMxWvtL79JAMKsRLlTNzoQMstnIPNZPjm821g7a7U8JeAcd9UatxLKeK8u/NoD5+aD
	2gJkJKoDzhB6OngX86UVY1Y9ATjPWa5yjuiw8NnmK/XAOimY7/zIImHxBfypYQlHAPaMem+Kl9k
	r/tQy+EMmgbjxTpha+FkgU17ef/Z2Vy78XqT9AiCkrLHox/VCIrbKcaxziDXG5zD4VWlFsiPksD
	3DIyGbUEodom+txQ8DPBbhAfkaae5hPok7o/0PE3m3W9sI/jad3QRXy3brZvZ4UkYpDkUlWEl7z
	IDN/8D+d8m8bkr6WU5jwAFtfzrWjLZoVcJfcjIvewDqntkdkaZsBnIaZIdLaJ66vrWBKI=
X-Received: by 2002:a17:903:380b:b0:29f:1b1f:784 with SMTP id d9443c01a7336-2a8bd3ebfeemr152850155ad.4.1770017239838;
        Sun, 01 Feb 2026 23:27:19 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d88f0sm145352365ad.67.2026.02.01.23.27.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Feb 2026 23:27:19 -0800 (PST)
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
Subject: [PATCH v3 2/2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
Date: Mon,  2 Feb 2026 15:26:55 +0800
Message-ID: <20260202072655.95143-3-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260202072655.95143-1-zhangtianci.1997@bytedance.com>
References: <20260202072655.95143-1-zhangtianci.1997@bytedance.com>
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
 drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b37f18a0ce6fd..1e274688bba32 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -331,6 +331,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct vduse_dev *dev = file->private_data;
 	struct vduse_dev_msg *msg;
+	struct vduse_dev_request req;
 	int size = sizeof(struct vduse_dev_request);
 	ssize_t ret;
 
@@ -345,7 +346,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		ret = -EAGAIN;
 		if (file->f_flags & O_NONBLOCK)
-			goto unlock;
+			break;
 
 		spin_unlock(&dev->msg_lock);
 		ret = wait_event_interruptible_exclusive(dev->waitq,
@@ -355,17 +356,30 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
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
+			vduse_enqueue_msg_head(&dev->send_list, msg);
+		spin_unlock(&dev->msg_lock);
 		ret = -EFAULT;
-		vduse_enqueue_msg_head(&dev->send_list, msg);
-		goto unlock;
 	}
-	vduse_enqueue_msg(&dev->recv_list, msg);
-unlock:
-	spin_unlock(&dev->msg_lock);
 
 	return ret;
 }
-- 
2.39.5

