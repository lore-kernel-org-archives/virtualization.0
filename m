Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE48692E0
	for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689533; cv=none; b=lE8GRKr33rA5pcJ+KEm47JiS/IBIgKbF/uJGjwRS6afISzz0mFchQAstqRUSF4WXkqKKj6v7onghZItstlPNKa9iFIhXU04MLI8HLABak4mDI1TXeucHsluXsZhpRHdkc5mgsn65EURwiThyrSrq8f0yJhw711uZ517M+rf0hO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689533; c=relaxed/simple;
	bh=kgf5qzofg9XdjyRI2Okw+ogBrpfswPf+/CPSQfTyBj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sdjKYZwkR114QVGjz9t05UNbRSoXZ5qO47z0lDMFpMZb6+mUY+oy4TTmf3nFRqhmcZ2Uno6fJ7atnxZLyzNcJqTUFAEwqvcm6iB6QNWb0cTItqrX7WcIAt+ge9TDKZzo95CNZUYG/cMQllwBo6v9lOIdxPSeeEjCexEEfZFsXCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso140539266b.0
        for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 03:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708689529; x=1709294329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wv2F+CMwFgzgnky2Oblv6t762R5K7w7duNIZkmo8KDY=;
        b=Ay1GMfzU6oJuK0P16a29z/mz6i0irP1EBxGn1PtYuAJuUI6X5BPOf6ZXwKQDzKDILQ
         yAILKaLnHZck05yDjXZTt0NWxNuMAmCCjslA7GVKaAswgPGmCUneITojrT4VEQ+v4yVD
         ZMIZUhRZ6DEEy1AyagLoRxmb3kQ0VPKGAwn+ZdZHgvXyMYc09IljXoMKf8uaMGRXVSpN
         F/fPFXqpY8t1vNlol7H4WXIUy44zuWtu34vNrwX5AMzhR4Ub7LteCzyJ9v6W5meETluI
         GhqV0Gx48ypGM93GpgQ0mZesFu84XYh3rDcxHU28LM1SRtaBz5D9I3QWT59k51LV6kHV
         aQHw==
X-Forwarded-Encrypted: i=1; AJvYcCW2PZGHz786pSlNQBsmIPv58wClKy5ciQoSBOhYxZmOU3bY8Pdzf5nuTW4U+HL6BrSEcG/ahWweV+1Fa4MeZvqhRYnx4debS9Ah3g5gCyk=
X-Gm-Message-State: AOJu0YwUFu5v8+mJ0evRDuP4oZgtrGUmRW0eQdHkohPMrpFYSSr49bMs
	sxZ2+9tJ0M3GVjhIL0Dg6QZ1FjVVo+adCpRzRjgxgnce8qRSZvPj
X-Google-Smtp-Source: AGHT+IEwZE90ddruXHba1WENbP9lNcLlOKscuPh/LATd8ln0hCxmETUo80I+NSEbZD9hNAu4n8T9iw==
X-Received: by 2002:a17:906:6d49:b0:a3f:af43:5245 with SMTP id a9-20020a1709066d4900b00a3faf435245mr1702677ejt.0.1708689528908;
        Fri, 23 Feb 2024 03:58:48 -0800 (PST)
Received: from localhost (fwdproxy-lla-120.fbsv.net. [2a03:2880:30ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id fj14-20020a1709069c8e00b00a3f64663fe8sm1895858ejc.200.2024.02.23.03.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 03:58:48 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	virtualization@lists.linux.dev (open list:VM SOCKETS (AF_VSOCK))
Subject: [PATCH net-next 1/2] net/vsockmon: Leverage core stats allocator
Date: Fri, 23 Feb 2024 03:58:37 -0800
Message-Id: <20240223115839.3572852-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
convert veth & vrf"), stats allocation could be done on net core
instead of this driver.

With this new approach, the driver doesn't have to bother with error
handling (allocation failure checking, making sure free happens in the
right spot, etc). This is core responsibility now.

Remove the allocation in the vsockmon driver and leverage the network
core allocation instead.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/vsockmon.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/net/vsockmon.c b/drivers/net/vsockmon.c
index b1bb1b04b664..a0b4dca36baf 100644
--- a/drivers/net/vsockmon.c
+++ b/drivers/net/vsockmon.c
@@ -13,19 +13,6 @@
 #define DEFAULT_MTU (VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + \
 		     sizeof(struct af_vsockmon_hdr))
 
-static int vsockmon_dev_init(struct net_device *dev)
-{
-	dev->lstats = netdev_alloc_pcpu_stats(struct pcpu_lstats);
-	if (!dev->lstats)
-		return -ENOMEM;
-	return 0;
-}
-
-static void vsockmon_dev_uninit(struct net_device *dev)
-{
-	free_percpu(dev->lstats);
-}
-
 struct vsockmon {
 	struct vsock_tap vt;
 };
@@ -79,8 +66,6 @@ static int vsockmon_change_mtu(struct net_device *dev, int new_mtu)
 }
 
 static const struct net_device_ops vsockmon_ops = {
-	.ndo_init = vsockmon_dev_init,
-	.ndo_uninit = vsockmon_dev_uninit,
 	.ndo_open = vsockmon_open,
 	.ndo_stop = vsockmon_close,
 	.ndo_start_xmit = vsockmon_xmit,
@@ -112,6 +97,7 @@ static void vsockmon_setup(struct net_device *dev)
 	dev->flags = IFF_NOARP;
 
 	dev->mtu = DEFAULT_MTU;
+	dev->pcpu_stat_type = NETDEV_PCPU_STAT_LSTATS;
 }
 
 static struct rtnl_link_ops vsockmon_link_ops __read_mostly = {
-- 
2.39.3

