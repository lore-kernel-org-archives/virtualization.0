Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E4207A11
	for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736540779; cv=none; b=Hw2GuM/GBotmXjJ+6qKfRZ0wl6YKaVRrae1e4adVtA1jzRpqAInyWMzSLS71OsDoZawOvlkO7DcT29j0l++ubbb7IHUJN9MF0euHuJX7S3taOZT33gb7cz4Nrhsgiz0PGfULTGB90/xQA+0urvDN4Wk1IMfOxcOLw1cMAUap4TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736540779; c=relaxed/simple;
	bh=Xo0gE3Mz2ABxEjO3uSGnAnsv0P4c2/27bA2L41PyRFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uTPp6gXit3OL4IOukNykwbWFvdgubwN4SuzvJ9It2Du7rKg/ZNkIkclxwGGJFW1oMS8/vAGePjLTIByzjt27WE/UBcqk+M2fpdfeXA3oDI9Qmoo6xr/YMPnokkff10NJvd0JCsLFyQh5oXBCLum73cGSY6GY5iqeJ15FlCnpG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=tQvkdnQN; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="tQvkdnQN"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2163b0c09afso43910725ad.0
        for <virtualization@lists.linux.dev>; Fri, 10 Jan 2025 12:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736540778; x=1737145578; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NgEKaAYjEQkVoq1sjh2PN8hyqxTEtZd69YDO7/mBq+4=;
        b=tQvkdnQNJu8TRZNATpH3NIcWdM7tdtc0IEE/X/P4j+wYrqwgyA+uz+YIjjF7wv5o6B
         ky3sogd4VNA2B2YrM7fmXDrMX9jT4OY6mVrjWkq/rMlICGlAHBHTnWGJlJNJG49A3UT1
         c8DQgbU9pyRrq5Oz4uiW9b4MDs2WmkmaW+Kt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736540778; x=1737145578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgEKaAYjEQkVoq1sjh2PN8hyqxTEtZd69YDO7/mBq+4=;
        b=bTRmM41eMJBWijcNXmPT69Oxn5Rf+0okO//88txr3FQcrhE0qm1q836WYTOsXH3pC3
         TrLxHgJ4tzPYmDDC5ljJ1gbC9omxz/+0yePI+ZPYEodqRl061wzpTY67eQMuPyMGKLCu
         xdyNBd+OYtzdCN9DBMVAsbDZc+zcpBqZ4K0IVPT8Ndq5ukEabQO9ee6gbqmndKyTziCU
         EfdRT27V5VO3J6NVmZKrGCgFGCBcJ8KlmvrWp073j1IGoSfvaN+9ceSgOuHPXO4mrVKp
         bybqJatS+T6izYRbsJGgvIbQI/wcWiJotLr7F29vWWBz6BT06WFslbvxspxo/FvmnUVF
         fJpA==
X-Forwarded-Encrypted: i=1; AJvYcCU9UMW5ol3UaLnVNZoXMgBBmMOmhwzD3p8YYg86rKAOWJN1vyiZ8VKsLJ/RALZDdSuwARBnavIjRuhW8zzA5w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxwo4JQphgG07K8OlLIzlXIb1B4G2pFeUhMXLJuxdBsQFRQLJJf
	8zxQE/EQUSOLvkwzKDpnbgqlXsV1p59iY83bqt0+cPPh5AKKJx0EkrfBDQK8hmM=
X-Gm-Gg: ASbGncvQ/EIPFFdXMoriOqg8dVWAxCVyIP2aruXe5GydfnM+Mzbq/CcQ5uSc9p+s+lN
	3WuByCzySgg/HxpuHNljpos72h1cIrE/pCKNvBnhm4Hv6rVS/u33R9ZDNEO6wlSQP43W2oOGppC
	3WY07kAzQUvqFNY93Xr15O67tdtavBfq6CCfTJxON2HTG66oJ+l4chm0Ng77TBgqS/tjZh8bl5+
	opOepFVc5HNK3jfwv7Zt+AUNpyzXLqh4EkcdGux8xSF0XirztujPOgtSby9ob8N
X-Google-Smtp-Source: AGHT+IHjLKyND/SFeTKqLeqcEkuKAdYPWdTMIhriRKuPFfdIBg2wiJFD7YroP+PiW7Hy24jWiDFI8g==
X-Received: by 2002:a17:903:1109:b0:216:48f4:4f1a with SMTP id d9443c01a7336-21a83f4bfa8mr180322945ad.16.1736540777654;
        Fri, 10 Jan 2025 12:26:17 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f22eb8esm17091825ad.166.2025.01.10.12.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 12:26:17 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE AND NET DRIVERS),
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH net-next 0/3] virtio_net: Link queues to NAPIs
Date: Fri, 10 Jan 2025 20:26:01 +0000
Message-Id: <20250110202605.429475-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Recently [1], Jakub mentioned that there were a few drivers that are not
yet mapping queues to NAPIs.

While I don't have any of the other hardware mentioned, I do happen to
have a virtio_net laying around ;)

I've attempted to link queues to NAPIs, taking care to hold RTNL when it
seemed that the path was not already holding it.

Note: It seems virtio_net uses TX-only NAPIs which do not have NAPI IDs.
As such, I've left the TX NAPIs unset (as opposed to setting them to 0).

See the commit message of patch 3 for example out to see what I mean.

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20250109084301.2445a3e3@kernel.org/

Joe Damato (3):
  virtio_net: Prepare for NAPI to queue mapping
  virtio_net: Hold RTNL for NAPI to queue mapping
  virtio_net: Map NAPIs to queues

 drivers/net/virtio_net.c | 48 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)


base-commit: 7b24f164cf005b9649138ef6de94aaac49c9f3d1
-- 
2.25.1

