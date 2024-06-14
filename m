Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71DD1487ED
	for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718402697; cv=none; b=ORmQso70J7y2d49b6kaJ93V61lccnwHXYaJDBtZtOucg269Z+mfYe+1PlknOoriHB2Jyb2vVZ3jjSPmBWO063Jfsv5cZZhp93jhbq+QYGcNyKcBwWlgsnrI0kY6jDOUhWdsb8MdTSATqi0NL3zVUvAMOvehkgvKEnO4aArsnDd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718402697; c=relaxed/simple;
	bh=n/dIbEBzku354LPAwJ5AA17Jtd1gqtcu4Ldd7iIeX6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CkpJhf0lLuBIGvmG++hSHmDZ8Q3SCGuPSOoRNW3WZcW6XUn0ltKZ1qlNtW36YBylcNb4nFfQsV+b0X2JjrstIZcnHAVt9kEUthzo1nZGhAAMvDp9+ropMzkCELCHjJ+DtiruoWYGvi/bRBW7Fm8L0ir9NvIeKKlKff2Ujb6POCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaDlP5yw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaDlP5yw"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f480624d10so22147515ad.1
        for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718402695; x=1719007495; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3GvcueyQPUEu25Z3M+kcx0gqsGUqckbLKTeC7p2z6FQ=;
        b=JaDlP5ywxN8XcYy6RfpwmY13D5RBZln4JdizvjDH2Effc9mfnVQ9ZtCh0/RtmWLr8r
         qc+qEWcz7nmOIx4GYCnyGhkU0bUeN8UULGaN65lUFXI15A+yAaKEkt/tM7GDS4dVWkya
         GEq7Y6VHpiP4TTvvYhK09ih2y2uz6Lc7iGodgA8Kv1GdfW8lV3ep6XgMFX7pLFu+EYBW
         zU+1uUXIHCbs8C4sMO7e3LYEnGr2i509eDeolcmIR0zFTof78nUJbOADuhFLP3xr5wte
         mHbXIZENYptMUGWK5lDQz8wz04icpSMuhDquZ6uxF9G+jqfphufDiFzUfhCenZZ0F82s
         vNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718402695; x=1719007495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3GvcueyQPUEu25Z3M+kcx0gqsGUqckbLKTeC7p2z6FQ=;
        b=i7ol1b6NtyhowX3ZYCEplugFNs8mGhjrpc1X+0LHvIGpIpDBWB8PvwTqLprG2Tx6+9
         goIJvvVp/NZyFpFK8mOQbOleooEZbQ5L+fIavt/gjiGQXQsPjH+RMl/IxPrnXjBuvX3s
         26LDM8glAD1gSUOtkdPzLKIn/kEAEE7ezbGJH8Wn7tomaOGlxDU3r/w2mUgBNyTj8WKy
         DATLDFbLiICxc7ZLZF4XiuNTWdwkcs2wsfHwLdD8J6GI98khqsah4u8LWOlIHKK8Yi1b
         zjDEWeryEwwhEkexYsxxFzWXDrc9Q2EuGdDoLUVmeIkV0+mwW/70prg9Iuc/O2i/TcNT
         tzUw==
X-Forwarded-Encrypted: i=1; AJvYcCU2c6nI3+eOdt4OCn0DLyvALYLGXM1BP8bWT2MKLXx7VREAe7QrrdVRllkVx7SYqwtd/Nal8KMU2UapRHTnJxcKsPOhVEYqdSFlNpLG3bo=
X-Gm-Message-State: AOJu0YxNUGEndACXVxedt0NtrChK92w++sbilykFnuRk/BpuXVLMVWmj
	T+sdiTqgxy3tt7cxLXV8n3Mp6YLQW+jUghdVpbeyVCWeDYxn5OLs
X-Google-Smtp-Source: AGHT+IFqvmnvREoZpL4HIEpMIZNae92JdUxNXwL23tevbC6InKHNUqYV0Ja7ifE4kxB84ngtUtcjvQ==
X-Received: by 2002:a17:903:234b:b0:1f2:fb02:3dfd with SMTP id d9443c01a7336-1f8625c0deamr45197675ad.11.1718402694709;
        Fri, 14 Jun 2024 15:04:54 -0700 (PDT)
Received: from dev0.. ([49.43.162.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e7ca78sm37008375ad.106.2024.06.14.15.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 15:04:54 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] virtio_net: Eliminate OOO packets during switching
Date: Fri, 14 Jun 2024 22:04:22 +0000
Message-Id: <20240614220422.42733-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable the network device & turn off carrier before modifying the
number of queue pairs.
Process all the in-flight packets and then turn on carrier, followed
by waking up all the queues on the network device.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/net/virtio_net.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..d0a655a3b4c6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3447,7 +3447,6 @@ static void virtnet_get_drvinfo(struct net_device *dev,
 
 }
 
-/* TODO: Eliminate OOO packets during switching */
 static int virtnet_set_channels(struct net_device *dev,
 				struct ethtool_channels *channels)
 {
@@ -3471,6 +3470,15 @@ static int virtnet_set_channels(struct net_device *dev,
 	if (vi->rq[0].xdp_prog)
 		return -EINVAL;
 
+	/* Disable network device to prevent packet processing during
+	 * the switch.
+	 */
+	netif_tx_disable(dev);
+	netif_carrier_off(dev);
+
+	/* Make certain that all in-flight packets are processed. */
+	synchronize_net();
+
 	cpus_read_lock();
 	err = virtnet_set_queues(vi, queue_pairs);
 	if (err) {
@@ -3482,7 +3490,12 @@ static int virtnet_set_channels(struct net_device *dev,
 
 	netif_set_real_num_tx_queues(dev, queue_pairs);
 	netif_set_real_num_rx_queues(dev, queue_pairs);
- err:
+
+	/* Restart the network device */
+	netif_carrier_on(dev);
+	netif_tx_wake_all_queues(dev);
+
+err:
 	return err;
 }
 
-- 
2.34.1

