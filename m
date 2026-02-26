Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1EF37BE64
	for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772106965; cv=none; b=oWdsdk1bygK5tEWCsXkebJkHcrEYdkCOpeDp9SMFpkpeuoJfaeYz8isvYtUUSt9gQfCL6xEaS5ZzfWBw6WNWOrfzkX7Dm2sewGBbhHIOtZ7abKl5Kqq3+Y/dUowzxQbUArbTEs1adC6xc4z7xZeo5mUi9Quqs/I+RpNUXfWK5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772106965; c=relaxed/simple;
	bh=DHLLkqkDnWvEZuqYb/4TzoA2PvbjZgAKakxtrxBFNoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DU2lJgsRD4B6JTgtb0Zfc3HArtm5gBKvtfS0YASGzu6Cp08iCDuMzXz50BwSWhgcyiAYX/dFAX5m4okrGwPNANIyF4GbLqUL7+bVu+3YTvmhkB4pzqi1Zb32Akyeg2JfiDRbbZqJunLIslDw2VBCw9Cv7T+zfU1n6HitFER4y+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OKJmbx41; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OKJmbx41"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c6e1e748dc1so664208a12.1
        for <virtualization@lists.linux.dev>; Thu, 26 Feb 2026 03:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1772106961; x=1772711761; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8hp9OyhudeTkze2mm5y1Lxwv/Mn5sOVBkvROnjUBeHw=;
        b=OKJmbx41+P8r3piwtck/cucbB5BY5xAbqTp0EVaqbN+v7DFgx+U8PsJPc3HwUdFGEI
         F7s8MaDXs4jrOI7hzWNTd52gP+13vUT+UjPDkw/9gC7oqrNhAhECqTjHP7Ox1CbEe4FO
         ETDLsCdFbCYiDgZM6Z21oTuUY3uAhHuPAzP5KLe2JbubLtfdV9HdLVlFSfYWsXyk910W
         uE8TDWggs/N0gyEL4hSkM5M0vzNVF3szjGiW5uFmefLQ+FN1E+flJcoPSdcvNmn7gjMo
         21NUQbAm4NU2ZlaM0EAOkNjB7EHpm3mgfiEo9yfR6/Ytcqu7E3pwbFkCBLZTMohj9Svj
         6yzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772106961; x=1772711761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8hp9OyhudeTkze2mm5y1Lxwv/Mn5sOVBkvROnjUBeHw=;
        b=UEH1kOmWZ49E4gI4dTfiIAc0aKswDB33iwzSkDvQyeaLHBj1Wz/7kZip4P/Z8Pyuxi
         gCUtVqfB9AypSIxtG7KHKLw7eWUbsLyFjX2GQxCYTmYt5Buq3w3XQ02E2s3VVp0Cz2L2
         /XQkwII5oziDmqH9j14uORiXi5y1Sx0/QoPygZcIjeMj7uEEWz/n8niV9sJd/1l0sR7O
         OQ5kgu1rQOpIeYe+BHjTr7IKeP/j3/s9mH7COrl27DWCubYgOYBh2XJj4XwR0M4RfxZ5
         FBsnpq9w6bHjhAsP2s+0gxkO4GSi/ZESj+fyoWeG/o7wTRgmtzh28OLbcIWYhAQ31wR9
         9CPg==
X-Forwarded-Encrypted: i=1; AJvYcCXGgzanPOvUdaFfboHD0VoLRWfmF83woIgRcg/JU00+8W5f/dxgGnKYhnB1WueJl7S0EQ3bxRnpUEx4W4AGCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyh2STf5fX0VqhSOSIlqVEDUxKMmhscrXa0cFN2ciV6XCxTsOib
	7vt5bSdbdR29z5AQMx4gfhXrF8iuVyUbHYgJUC9QcTnYd1vnx35DWaZGJRH+dlRuKZg=
X-Gm-Gg: ATEYQzzO69VNwMEjYsNjn7KRaeFlnFHMZbXssyk+LVLUslkIiI3agc8bMfNv6q1eL3I
	7F4wGQcRtYx+k6xfHwe6JsCleLWdPZwoElQtiiNyiufDG2Q8UgV1kiSZ+arfjRvqqO48sVI/HkK
	X2OM0jc863BgPmBLRAeb0kJRqJKQk2UQj7g0W56l5q9TZgG24gVtzflbWANqHQEOLEEMn1CgieJ
	r9XZbNEQiYjpM00WEAUiOZKhIaMRtKIEmpUYZUbSyybnh6GAox96ovh+wuXoXcDJVzLLb0agEZT
	CWq3qXtBXOAN4L6tHLvo1v4CJl8FpGTJLJmPJAxy6cxUxZZgZuVAOS2YQ8aASOPTUNmsg/I/8u7
	fuKCMguqfBuL+0TPCzbtHt2uBADvqKbDVfPsskzqYSYnrtKysc670lQiDoKNUSwQbfzsv7WNmq/
	YKsyVyiRSzU4GqsfW126zIwvQJZ/xhU9kkM4lommFWcu04lg+ssswyxQXd7bx9xZGcrbc=
X-Received: by 2002:a17:90b:3f4e:b0:356:22ef:57a6 with SMTP id 98e67ed59e1d1-3593870f204mr2186856a91.15.1772106961486;
        Thu, 26 Feb 2026 03:56:01 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359130712bcsm2390815a91.7.2026.02.26.03.55.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Feb 2026 03:56:01 -0800 (PST)
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
Subject: [PATCH v4 2/2] vduse: Fix race in vduse_dev_msg_sync and vduse_dev_read_iter
Date: Thu, 26 Feb 2026 19:55:50 +0800
Message-ID: <20260226115550.1814-3-zhangtianci.1997@bytedance.com>
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
 drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index b37f18a0ce6fd..1ca1811f7594a 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -331,6 +331,7 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct file *file = iocb->ki_filp;
 	struct vduse_dev *dev = file->private_data;
 	struct vduse_dev_msg *msg;
+	struct vduse_dev_request req;
 	int size = sizeof(struct vduse_dev_request);
 	ssize_t ret;
 
@@ -342,12 +343,11 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		msg = vduse_dequeue_msg(&dev->send_list);
 		if (msg)
 			break;
+		spin_unlock(&dev->msg_lock);
 
-		ret = -EAGAIN;
 		if (file->f_flags & O_NONBLOCK)
-			goto unlock;
+			return -EAGAIN;
 
-		spin_unlock(&dev->msg_lock);
 		ret = wait_event_interruptible_exclusive(dev->waitq,
 					!list_empty(&dev->send_list));
 		if (ret)
@@ -355,17 +355,34 @@ static ssize_t vduse_dev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 
 		spin_lock(&dev->msg_lock);
 	}
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
+		/*
+		 * Roll back: move msg back to send_list if still pending.
+		 *
+		 * NOTE:
+		 * vduse_find_msg() must use req.request_id instead of `msg`.
+		 * A malicious userspace may reply to this request, and wake up
+		 * the caller, after which `msg` will have already been freed.
+		 * And here vduse_find_msg() will return NULL then do nothing.
+		 */
+		spin_lock(&dev->msg_lock);
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

