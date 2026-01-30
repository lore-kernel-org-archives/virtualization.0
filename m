Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EE350A39
	for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760932; cv=none; b=nglpEINzDu3pMwEswesNwLvBbNRMbm0TQ1f92y1GdAjO0edatrdpBmgcRoZ4A5WyY+I9afNoNfx+wCNMzq6SWZ7nRBVkyxiOR31n3XkACoPi5XkL+pu+Yvzu7HDqyCl+8KaTTGsEep470tFn4MKuyHEApVpJsp7Nx6yZrta9eK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760932; c=relaxed/simple;
	bh=1GAiVzzvPMQjKqXjbaFyyP9Rjcoo8cli6yAZplPoREQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gv2OSSbqNqQ/8JRVm8lnjNKIoUI9rvVawFVIPRxF847KI2sA+l2Ds4MYxZTI3F80KFw6cipBvMTGoQP/x2mXi2ZwcWPyaKZO8zz8DNs658XZNM+vvA0Kx0/k5DJzSIcLOFyl8iBb8xLVonLUYY9RmPhaVf8q0Fwz8E9uS+60TH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AE83Vkp4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AE83Vkp4"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a7a23f5915so12052425ad.2
        for <virtualization@lists.linux.dev>; Fri, 30 Jan 2026 00:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1769760930; x=1770365730; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yncUN3Qjv0HcR5KwYrZuFrp8cFkPuWRQ2BfDlpVR3ps=;
        b=AE83Vkp4YZ0qtiPm4lw3G2TyuoHG0tHekBziCIJhMPW56FXAGNijAAh5PVLZrrLtow
         03S3uwu3PvDeAbw8ufSDBqvLZOAZbcJC+Q6ufrTJ5nx2eSGa14Etuqu8EJ1H9P11Tqpv
         UHmmAdA/SdTW3CDnvJul6p1npAe9MgVCjSZC3HS+Fy23eHA2Z8W3A0MApiIKsZ/Rvyml
         3HN7oinvxgiK1MIk0JYMR/O82+j7cz+2uLZLoNPdqX660jI0/UbCBNKeq4Sh0fERH4O1
         Vz1+xrHeD9YSt1CdHYIOxRwbnlAV1ZlbzVMN9A3tmXo3zsTUK+KpSd1WYu5K+RRbTXL/
         f1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769760930; x=1770365730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yncUN3Qjv0HcR5KwYrZuFrp8cFkPuWRQ2BfDlpVR3ps=;
        b=eGWaYEzp2/stuPblmBewXixaAYKuMQ7z9MFAczSrp0gEMXuhV3SfOa4XcO/g4Y9D1w
         zU9SZhaY7H7McY3E1fzZfOMmAIo+je2D9AxqGrp+f0nkMiHuty5o1Vxva8uSrMOs17aS
         hWI2tbnbAGfZ9aLhCC2qQIYBemJdn24ZEBg19dBXjfIoyak7on2roJK/nMHNbT0dQXXU
         1o4zZ49cSzxZdlL1LXZe9FGm0oOgEMBdbf/ntyh8qG4a8cHi6hPJHAYtNAdrZh5641bb
         UqE+vXFSr3SNY4BSfvYFEOrh/CLbxZ8EZjTkB1h7UM/mDgr7PyRRlUfzuPqNlEHIMCt6
         pxYw==
X-Forwarded-Encrypted: i=1; AJvYcCXh+91jBpRWr5BxBM87j9R8jYokbEEqmLVdmHbK+qJfQo2wTWOMSCc8QV1lSK72HsvVz4djwCbDWIS8yvwd+g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRhC0exlqaAXsRZNgZFGor/GF7pQS3TwBSLq5VooKAdRI3wprR
	K0IS6g+ThRaYXWPM0xW/zMrC3coe5Z1MRPsrfG3ah7RgSDEuGvGXEOvBdbXd5CKab9o=
X-Gm-Gg: AZuq6aKsTy/RldjszeeOzsjdnAb7RhFd09dBV2/mg2ghuW8zw41Q901CGGi0B5UoLit
	/nWLaDk2QA1fjnrNzaFmSmIV4CUn+tNrstgShD2Mw/T6Ty0CSiNms62dUG+7UALJ0yJSkCUuKuK
	NUJxoDb9bP8CICj3U6mk/cnzquQEvX1cZ1J28MstXlkvrMUjv8HdaBNON15WqRtmkO5QIiI1uSt
	TSpj0wb0AzDW0m38Be2RbHX1jQyy/n+4QbB0sUIQGMTPu4icrax0ELi2UuA/S7tDLmufKI2WpHk
	63XrzJqfvnIVUWqaHFoK0QF18kVg6bxu1h9kMZ/ZdQTyawk8NGUfKIx3WGJbRbowYPCN2BCE14U
	PoC3MB/PZ2iB5zmIFc3a2ikB2UPx7OAEuOgfGizwWlmgXO4vdHxjQgoPVGYp1Nz1j504vMl+PvD
	AVCEpzgPapJeIxtHKvR/Yn4uyMiQx5PAPh+sEo4JQYwhCoT24mAv8wvGs=
X-Received: by 2002:a17:902:f64e:b0:2a8:a133:dfed with SMTP id d9443c01a7336-2a8d9a5b280mr19239595ad.55.1769760929668;
        Fri, 30 Jan 2026 00:15:29 -0800 (PST)
Received: from tianci-mac.bytedance.net ([61.213.176.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b5d99eesm68997225ad.78.2026.01.30.00.15.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 Jan 2026 00:15:29 -0800 (PST)
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
Subject: [PATCH] vduse: Fix msg list race in vduse_dev_read_iter
Date: Fri, 30 Jan 2026 16:15:24 +0800
Message-ID: <20260130081524.81271-1-zhangtianci.1997@bytedance.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the message to recv_list before dropping msg_lock and copying the
request to userspace, avoiding a transient unlinked state that can race
with the msg_sync timeout path. Roll back to send_list on copy failures.

Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index ae357d014564c..b6a558341c06c 100644
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
+	 * Move @msg to recv_list before dropping msg_lock.
+	 * This avoids a window where @msg is detached from any list and
+	 * vduse_dev_msg_sync() timeout path may operate on an unlinked node.
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

