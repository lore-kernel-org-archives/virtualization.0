Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32338DC7E
	for <virtualization@lists.linux.dev>; Tue, 22 Sep 2026 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053381; cv=none; b=MEYY8BmeLabgkmpOCmggVSoDV3nzbK8gMv2xwgbtXycVDFKghrl4C039W5bYYa78bvRcOlwY8cmRkmZpQMpa3+rdBfqnp0C48NFGYV60P4vm79LpQr9ikJR+A0voNfDqKOjPqPWPoCL10G7qp5BfOuNUfAtYSGrkbCM4/Pz5gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053381; c=relaxed/simple;
	bh=lYFM2icJd9dTPDzF6woXYA1zRrS4VpaQ8uxQMpGJe7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyQ4AkKS2d/TR0EDH0MvWHQuQ2sUfotyyDb2p2ICVNTBpKKKlgrWD0cpgE3C0hTsskWIAJg/0fWniQ3MLUkp6Njgm+ZzDw/h2XjBm1eyfPCAVT+V+AsFgQmSD2IHL5XPhjXwlLR1PTLzIORX7sYsWsg3OT3VHisjIzKIb9K+XN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgHOKF+G; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgHOKF+G"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939109f067cso369446385a.3
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 22:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790053378; x=1790658178; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2Ara9sJRSL0sr/3H6tA1EEPm7uyc4h6klL0iWIcKZUA=;
        b=KgHOKF+Gg+YA/hjlq8z1BqGHeavVmpU/M+wP7QalJ9zMNlQ5gvilWY9vBuwlFpzpm3
         dsr4TvC3sz2s3HjIE5d4S5EZiVuejwkvsTEh5ZFVZYumjdtv2uTrhzAsPyCLbSkvbQMG
         8+cl4GBqgFIDVOApzL/qidD9EUSFtRQjgPibxWwSqEQwFWW3XOa48cjzJ8hrgU4uNkTM
         Wuo2nnnirME7/x/4R+aGIeEnV/r2cJXdbBE5yhPQkEtsqduC8P9QfAL4proH5Cwt+Uu+
         vQk6EYVMf26jUVfoePjNbHDOSYh0OIOdZiW3Q2iK2GZvhQpN9JK93BgbgwcLMxoESNE4
         +TPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790053378; x=1790658178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Ara9sJRSL0sr/3H6tA1EEPm7uyc4h6klL0iWIcKZUA=;
        b=PRF7nldlzf1cBvDRiDBRnjj35PoF6C1nbroMCRQ2Wb/E3bJ8lCcEVQiwMF2J2k3d0Q
         e5THK7tbIuSHrFRwmaAeX8ecDL/urIM2qzHHygmgL8adUtgxYjUwrfY3PwHZTUyWp/T9
         6eY+6NX1c43sA6dgvDClJ/Kv0mM6Lg7ndB7KP4meUHWnsu1HAwRs4xNSirQ40+GNwG+d
         yjoOBvppahTBkiRA9K5eeUN8UyF5KiXRjx18opGzIwNUfGzqoyUQO6V8znLqQzddXtU5
         8vAXDFCRUToNvhb30to3jAqCGgFTCjmO2rqTvpvHcoMbJeFdJ5aZ54iHa8O+60VZXfQW
         Qklg==
X-Forwarded-Encrypted: i=1; AKwUvByesd56iOBhbX4nxcVT/Kf7grs6WcQvCgoGGhT+Rvs+mAZN86TsX6Q6XGFC2YBLQ39XHqQ/Lgbc6NazURP5zQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ng+e9SYKLsnFmv+3p+D+I45ml1BUVFQ5pBdcT8Xp0h4WhYWb0e
	KmNnlpnc+9W8GQ7+tpHK07Vs4DxW/0A/A/YabMBjzY0jEKd3AFnTtTz1
X-Gm-Gg: AYBFou3LusApId21gcwc2We69NS9hRuGrYpgurOBYXZtuQSMdmQJEWwjAq6HvFibuYy
	Xnz/+dNpbPZdeXWJ9pUjcnlVP+U5NpedbbXu+TPv+9wRAsasTMQ6s4CXLQeqAfnKkTwx2qRSpqI
	oz6OBlRRi45AxRqUTqPKfN1TI+JmdtiyTyoYH+abZhwU2AwHYSdDw2VmZrjIV7Hh438olpiO+U1
	nYbp5yE2VmNAiPtTp4pxiRqtFY9UUgd9hnJW2poKNDRWrnWClSunEXHPyryEn+SpeZkuKyBmklq
	OFlTYVGkqyM1pdgyVZ+eKlj4CsnUDONHgnrbvNv3H5ZbYcE7m74f2NJr6KlnpD3hG5jT7HPZTT4
	3bkO72s7nHFSZF5dfCCiG8CvEGQTsCNn2p4JfLIQB+UGxPiyLaEWkkk/SiVJnG8R5Z0YpECyxlo
	RHy4Enr4Th4BfP5elwADl+CBnE5XQrRxF0V/l3sbLXtQF9N4J7tOEKyTZQng3DYHSsVU3guRLyw
	gWeirfQmNT1WcOaoi/PPw==
X-Received: by 2002:a05:620a:6006:b0:93b:d79f:d955 with SMTP id af79cd13be357-93c15f2e6e5mr372386185a.74.1790053378323;
        Mon, 21 Sep 2026 22:02:58 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c1d18948esm48202285a.23.2026.09.21.22.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:02:58 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: "Chen, Jian Jun" <jian.jun.chen@intel.com>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	linux-i2c@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] Revert "i2c: virtio: Avoid hang by using interruptible completion wait"
Date: Tue, 22 Sep 2026 01:02:51 -0400
Message-ID: <20260922050251.403857-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit a663b3c47ab10f66130818cf94eb59c971541c3f.

When a transfer is interrupted by a signal, virtio_i2c_complete_reqs()
stops waiting for the remaining requests and virtio_i2c_xfer() frees the
reqs array while the virtqueue descriptors are still in flight on the
device.  The backend can then write into freed memory, and
virtio_i2c_msg_done() calls complete() on already-freed requests.

Commit 84e1d0bf1d71 ("i2c: virtio: disable timeout handling") removed the
exact same failure mode caused by timeouts, concluding there was no simple
fix because the buffers must be held until the device returns them.  A hang
due to an unresponsive backend is preferable to guest memory corruption.
Restore the unconditional wait until request lifetime can be decoupled
safely.

Fixes: a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible completion wait")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
A proper interruptible wait requires refcounting requests and bounce
buffering to hold memory until the backend returns descriptors (similar
to virtio_rtc/virtio_pmem). Since that is a larger rework unsuitable for
stable, revert to uninterruptible wait first.

 drivers/i2c/busses/i2c-virtio.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
index 5da6fef92bec3..581e55b5c65ba 100644
--- a/drivers/i2c/busses/i2c-virtio.c
+++ b/drivers/i2c/busses/i2c-virtio.c
@@ -116,16 +116,15 @@ static int virtio_i2c_complete_reqs(struct virtqueue *vq,
 	for (i = 0; i < num; i++) {
 		struct virtio_i2c_req *req = &reqs[i];
 
-		if (!failed) {
-			if (wait_for_completion_interruptible(&req->completion))
-				failed = true;
-			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
-				failed = true;
-			else
-				j++;
-		}
+		wait_for_completion(&req->completion);
+
+		if (!failed && req->in_hdr.status != VIRTIO_I2C_MSG_OK)
+			failed = true;
 
 		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
+
+		if (!failed)
+			j++;
 	}
 
 	return j;

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

