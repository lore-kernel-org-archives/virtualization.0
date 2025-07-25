Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D78376F1
	for <virtualization@lists.linux.dev>; Fri, 25 Jul 2025 01:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406206; cv=none; b=ZqRhj9LWMoomv4rFkI5kYWQc7nQ23O3uXnAYT7iMAQSuvzK8wsVnjIebWDUsE5M2elP+5JsHmhI/UJRYS4U0QIOWTdsx2K6SQQwHgpakLV0BBeqDpvJKYrjNmwWifqU7bGZA8WPs5lclDIMnA/iGiQO00MgM9wA77396qat+RfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406206; c=relaxed/simple;
	bh=tgJjmb3D/EBX50l0+VI6F0vwMmlQ/g6/llxOIyaa9H0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mn35ujvDqrwMVeNC6QMrJi/Dnpacz6sdQx3qOgyCKKhmY9v3Bd7dqVK16DueySpr7DN4bK3i74elX2pHTZUi+d1n23eN3GTAOg6lRnB1rcG/4A1xvIb0nzD8mWCjDVLJ4xanmW7b0H9gWTeaMJaaWLcFdHmGiVCbars/TXaMNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bp8zN2fTmz2RVxc;
	Fri, 25 Jul 2025 09:14:24 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id CDF271400D4;
	Fri, 25 Jul 2025 09:16:39 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 25 Jul
 2025 09:16:38 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <sgarzare@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <virtualization@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] vsock: remove unnecessary null check in vsock_getname()
Date: Fri, 25 Jul 2025 09:38:08 +0800
Message-ID: <20250725013808.337924-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500016.china.huawei.com (7.185.36.197)

The local variable 'vm_addr' is always not NULL, no need to check it.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/vmw_vsock/af_vsock.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 1053662725f8..fae512594849 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1028,11 +1028,6 @@ static int vsock_getname(struct socket *sock,
 		vm_addr = &vsk->local_addr;
 	}
 
-	if (!vm_addr) {
-		err = -EINVAL;
-		goto out;
-	}
-
 	/* sys_getsockname() and sys_getpeername() pass us a
 	 * MAX_SOCK_ADDR-sized buffer and don't set addr_len.  Unfortunately
 	 * that macro is defined in socket.c instead of .h, so we hardcode its
-- 
2.34.1

