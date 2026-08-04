Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982420DD51
	for <virtualization@lists.linux.dev>; Tue,  4 Aug 2026 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785823608; cv=none; b=n0QZsGmeIAC+4AG1thTIyAWC8xSgmB2+LNz5JJUtVuXLjmQ4QKE3rN9m4zpzQm0/Xk2D1obI+42xvBGPq0R1XJd8eHkeN+WlO0A53iCQM+GQpYUw7rL1X5Zn1o5dAkFyGFp0QuyysIKKXV6xkw/zyrmRJdUI7GqBTGFZrm5uycM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785823608; c=relaxed/simple;
	bh=aP0+RRXIgMn66e98KbKmeqqZSAJftYY0Hv2Ucv5x3xI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hIlbwExyLYg+AS58B0hx4FE+uAIosrWlY7s+Ovlxx+SABWwxZc/sX4JGG9l2fZa3uFug4pW6tumLBcLQ23j8zBY3r/Kf+u1NXhGEvoboTztwjEyedV3kRa9xuymdkQusIC1ks2uJMUd4m7F+sm2G7I/MoEDJKtDyS00F+HSxGt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTI/BVHO; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTI/BVHO"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caced6038eso7958865ad.0
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 23:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785823606; x=1786428406; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjxoV0tL8kSvsYtiWC0e5PWggVMkESpJYPzZ3/qyCk4=;
        b=iTI/BVHObwqzU6tCSGRhsKoGUW3wAsuqwtVOFUS0C9/blXtw1dTcmAVeGg5cXQaYsh
         d+/zIiwqnFh9S6nxZcDfrWAJVlprgXC2DlZE9Oja3ulkA+e3ZqLGXwGsNaT1dgZ2aB2u
         eXAxhcmGzEMdsq7H0n66qv9r7QQbjf2l7cuyMK2FOyYsx/zvpKK+YZigKf6kFcpJnLxl
         6xO27Io+C0jBKEd5pSEEOKH6FTxowNq1EtV9wHrU+3abb1IUtSVlZ8tRps5CLGqKPWwh
         MFqn7ma9hLMIsHO1Gsdczgv0a+0LDZnuJ+xjjYZWzasCkSUCB1py3RCE5ln2Kxda8oVH
         +chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785823606; x=1786428406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjxoV0tL8kSvsYtiWC0e5PWggVMkESpJYPzZ3/qyCk4=;
        b=MeVYBMXZ2TMJWdAY60zgmBsIQDmQtmnKTTFDLSPuyruPwPhJlx3fsGKhHbREGi/Rhb
         RQPtgvdbdack8dMC1ahQaTMZzUjvvGPNhNV9rsVP1qc3pnUaO5+nd1gJPrtDFRk/JE/6
         g95tt/sXrS7eZM75HpxBGyOY3GYbsvyazREQc3RDMR1PQmZKPULSxIj2laggOqjOOcgl
         4f3Uj+D6xzv7YExI6izvMciXEmMfBpTb8MsvbrFY9eE4i4dUxoA1VUyL2u3DoUGE3zKZ
         U4ZPOWDF6VAHwQoBwmy2MmeOEIBXXLr+Kx1ROtcLLOS2Ug3/JMPBBVzDLANOMumhpTaV
         aRBw==
X-Forwarded-Encrypted: i=1; AHgh+RrWTfDimXPPPZgYW+H5JJ6IJt92ejJzbr4RwtFYzdQmCiAiJwuPHLli6O1nlWF33OXhGO3R0wQHijxHD7DrgQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxE7/kWwuMVXQipWnvBUbYVDmcPgIowaxS7zZ0rOyg2SIMca6jb
	n3LiwZW6cef09K56zVDIHcp/kobcb4YmIRolujaciMoFJ8QdqWnN76Ki
X-Gm-Gg: AR+sD11sxzd6tzmAx8QO4ZkuuuAlxAHp7kCNgfTcf3hMBA2MVTXMGDem7I8gbTlkWp0
	/iSipYI05VuHYUnXdMSuo1gZZ9o5bSck26OJbST58KShRW+JvaDE7cJH9jHOQq1EL3UEcemn72m
	DGvCkOz/gUlRXbeGIyxEDwl3cG+W0AR/YRmXCuHG76hfSh7lLDNy3X3NsV14KVed/jBWA5qsg76
	OSmprN69Gc3At2Bpfzu4GEHst+t+Ua+9nsxvGC6V4frzrcF9LUPrIpTKofH4uVAyNuMvXEukCZ2
	ry7Rdp9CLJ6a+TQrGwA301DVEjMi+x3WTYJqpaAJrXcuHGeTf2Nyk5ctQwOzy/gihiiklOrCYTb
	p/wRf14i+u9GF1uM3Bcdug8lM6fYrwDllHhjruDFMryvrdD49rTVD2B2ikfDQR9FPThYQ/Q1Da1
	GF2tKZJ+XXOqwkuqla9rnEcuUxlbqqWkSbays/8ZcoOTX4ZAMrh0X3RYYhR2V7CAldx6Am5PZ6e
	A==
X-Received: by 2002:a17:902:ebc3:b0:2cc:89ce:2f07 with SMTP id d9443c01a7336-2d08aa1b2bcmr21504545ad.1.1785823606239;
        Mon, 03 Aug 2026 23:06:46 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa012bdfsm394425ad.33.2026.08.03.23.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 23:06:45 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: michael.christie@oracle.com,
	mst@redhat.com,
	jasowangio@gmail.com
Cc: pbonzoni@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: [PATCH v2] vhost-scsi: flush backend after device ioctls
Date: Tue,  4 Aug 2026 14:06:31 +0800
Message-Id: <20260804060631.6444-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-scsi translates guest response descriptors into userspace iovecs
when commands are submitted.  Target-core completes those commands
asynchronously, so VHOST_SET_MEM_TABLE can replace the memory table while
an in-flight command still retains response iovecs translated through the
old table.

If the old mapping is reused after VHOST_SET_MEM_TABLE returns, command
completion can write the response to an unrelated userspace object.

Flush the vhost-scsi backend after vhost_dev_ioctl() handles a device
ioctl.  This waits for in-flight commands that can still use the old
response iovecs before the ioctl returns.

Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Changes in v2:
- Shorten the changelog and remove investigation details.

 drivers/vhost/scsi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index 9a1253b9d8c5..c3e8f1a0b2d4 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -2424,10 +2424,11 @@ vhost_scsi_ioctl(struct file *f, unsigned int ioctl, unsigned long arg)
 	default:
 		mutex_lock(&vs->dev.mutex);
 		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
-		/* TODO: flush backend after dev ioctl. */
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
+		else
+			vhost_scsi_flush(vs);
 		mutex_unlock(&vs->dev.mutex);
 		return r;
 	}
 }
-- 
2.43.0
