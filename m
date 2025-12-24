Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475222127A
	for <virtualization@lists.linux.dev>; Wed, 24 Dec 2025 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536144; cv=none; b=HpAbaR1hcedq6z761hW+jMnHotDcveJBr1ai4p71I2s0dT9neVM9V+hsGy23LjJXYqrRLBmrwJvJWMIO7Wt4hu8Op+c0wqZ5hr9gs5BB34PTnD3ibWnh+gZGOwZgRhpGG2dqTzTin3/SIaYoQO3rh/p5sQdICBrKwRUQuxrM/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536144; c=relaxed/simple;
	bh=8kT9Sce1CZrAgVQ7vnNZA70o4fM254DKC0wfkmWzB90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSYrG0GOJB4y3q1L/pSxAqaSWoB+K0P/7K/GXJ1CIRokIUgOLEPm3bYvewqorRDXidQd8+xhVdEQDjSouHLjZgnksttUCkMvK1p+Lrwp3bgUZ0G1paD4mz28T5yczx9XKv3xLKrT9QK7u2e57TeDunT5eqTJ8j0tuCl+EsVVfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PTj8rMab; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PTj8rMab"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c21417781so5426773a91.3
        for <virtualization@lists.linux.dev>; Tue, 23 Dec 2025 16:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536141; x=1767140941; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uP5dCmGJx/cfUOeiPby/DoTXnEYYyl2lr0FiheN3O+M=;
        b=PTj8rMabCJ0XcHKQsgqjPRTHj61f8AeSL2MueXU9km2wpukTOqy/AlkY2A6am4s6cy
         oIYzbNF8PcNTIW5rsiaeZVqX0Ds1mf1N9rIdgmFPq/6vZwnj0ihoahf1ecG1uQUVuRzY
         p3h2dbYiTtDh7c3wCb7ShTbN68awa8TwHlwiXn8ywOEA+w/qQvB6YxiIU1+2Czt3/vCN
         aCamRfwkMPSUSFTUiiz5Qt/GmhI7GOabLAeI1kpVmiv+DCxg5bz0qRcY34nY1ut9ox0Y
         wDStR0QM4vsc6A9C++YzpJ5TG0H0bhTMykhK90DrB7sDjRMNKc+kZNxrbERF7xNlRGib
         mHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536141; x=1767140941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uP5dCmGJx/cfUOeiPby/DoTXnEYYyl2lr0FiheN3O+M=;
        b=X++a+afuugtFGyN1WVbNt7Btl/4g2yABlBWcrs/zBYlkYM7xxYEVZscRyFikk1BV4j
         ST54OM5mlx4MyFdcNEgpqgPDgtE6V7bj62fcTFin5U0YSHovbpuASLRxmosbNXnDoBGr
         bk3SBy8pXOlUsF/925FC8knxTPMfOhaOtLkhKutSUDTPRTT0UgXr/LSIii8PMlJmpbRa
         5muTZkSpzLczKbpsVE3XaDRROM7MRz9V5J/Ixh+Y0UEFOTUrlSV4T94dLeTlOQKHaqwH
         uc1oHQxXLEVQOBR4IdDD7u6uqi/nHcaGOXtT2/5eD3sqIVYiYjDmLoQ7hG8R+pYuHkU1
         nWsw==
X-Forwarded-Encrypted: i=1; AJvYcCVLbSzjQIJNFMUJtOxGc1MALvWFOXyVgkcYEk4o1QFYgu3nUoxC7ekQcpqbn4/4fnKvANRPKJNd9sbYuKCNCg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5p1xc2JKIIRctaSRoJRMgi05qOFUOdkzjDWJngw87NnBUr9qe
	Pe4mnE/7kDCU/NWeUPI+0ZUidfrRxx3TUAR+4Ta3X9OvY/lwrJZJ9zEL
X-Gm-Gg: AY/fxX6eAWDcdKWCchPteH1vWm68cw9qijkdgHd7fzsQhisvToWUTxFqjvE062HiFRW
	XnEODYnb4DrhIJquRS48yS+RRMnst+ZPlKwpZWS03JBr4xn5jUF3PsyjhYRZ4abLJtxg2tiVQ5h
	vCg7qSpz2rkr40EaSIFvV35tq2GHdvqjL+FimLJVeDg1zIMZyGL5sQuGt24iW2PJv9qGFtAWkuQ
	NQqlC3xZBAizq6k6LGaCly4G/BeKhKsiqNgNookZwJhTQ4nbZkrPqY5YN6JXTWRNATMXOU5FGyb
	Gj511lVH8MgmI28JSxLVKJK971Dd/CYiFYo3J1jgt+62rr5zSVvEKFQdGngY/EdNPn/BmHWHXyf
	JJfdqPtTcIBIgZ+PrTDDO9Tj5SqMWIANCukAGKSygmYSDM5EBBN8WTXX+Z4x7y6KOtbHet5JKRB
	8ZYMBCCMu7X3in//HtB94=
X-Google-Smtp-Source: AGHT+IHYttjQEhb9KjxqMyLHj/1hdXCnFP9vzlZa8bawr+JTs4i5zRKkDDsgduCmLxwKQO9RWMQpbg==
X-Received: by 2002:a17:90b:2688:b0:34a:a1c1:90a0 with SMTP id 98e67ed59e1d1-34e921be0e1mr12335108a91.28.1766536140885;
        Tue, 23 Dec 2025 16:29:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34ed530475bsm2112700a91.8.2025.12.23.16.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:39 -0800
Subject: [PATCH RFC net-next v13 05/13] selftests/vsock: increase timeout
 to 1200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-5-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Increase the timeout from 300s to 1200s. On a modern bare metal server
my last run showed the new set of tests taking ~400s. Multiply by an
(arbitrary) factor of three to account for slower/nested runners.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
index 694d70710ff0..79b65bdf05db 100644
--- a/tools/testing/selftests/vsock/settings
+++ b/tools/testing/selftests/vsock/settings
@@ -1 +1 @@
-timeout=300
+timeout=1200

-- 
2.47.3

