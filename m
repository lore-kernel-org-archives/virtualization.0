Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B0C1EDA0B
	for <virtualization@lists.linux.dev>; Tue, 12 Aug 2025 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754963935; cv=none; b=jk2suMv116WBjLC9WdOCYcl2LGdNRNWF2Lzp+XUfimzKj6SXPcz9Sz1SxBz7FvHYNAqmGov+QkCmxUYgnLsE9TV7Ozc4UeYVHwdpve83Hc1K0pAqcJMaoq2ioBfiO9khj/p0gfBG6csm74YrbDCQggfqSADs2KHO4knUOIdtj6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754963935; c=relaxed/simple;
	bh=UzEWDia7gGgwOVF7m1ZaRBdsqIrgGalbDGEes9tFoPc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F4cMywD/NshY2G14ofch/TAv3kV7DfVDkWi8VhrTZTgqNJDadwA/uwxnODSpuli4Vcm0qsGModSmRuYAqDSXB6yYKxAjbTgT9zhoarP2abxUPUhWEZtfGD1yb1yhNE7x+Sy0CS3c/vwpitUE7ca/8mvpOiMaK+RDulViiZF67Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c1F0b3L90z14MHS;
	Tue, 12 Aug 2025 09:53:51 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 48D2E180064;
	Tue, 12 Aug 2025 09:58:50 +0800 (CST)
Received: from huawei.com (10.175.104.170) by dggpemf500016.china.huawei.com
 (7.185.36.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Aug
 2025 09:58:49 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <sgarzare@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>
CC: <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<wangliang74@huawei.com>, <virtualization@lists.linux.dev>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next] vsock: use sizeof(struct sockaddr_storage) instead of magic value
Date: Tue, 12 Aug 2025 09:59:29 +0800
Message-ID: <20250812015929.1419896-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)

Previous commit 230b183921ec ("net: Use standard structures for generic
socket address structures.") use 'struct sockaddr_storage address;'
to replace 'char address[MAX_SOCK_ADDR];'.

The macro MAX_SOCK_ADDR is removed by commit 01893c82b4e6 ("net: Remove
MAX_SOCK_ADDR constant").

The comment in vsock_getname() is outdated, use sizeof(struct
sockaddr_storage) instead of magic value 128.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/vmw_vsock/af_vsock.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index ead6a3c14b87..f7b2d61d1d16 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1028,12 +1028,7 @@ static int vsock_getname(struct socket *sock,
 		vm_addr = &vsk->local_addr;
 	}
 
-	/* sys_getsockname() and sys_getpeername() pass us a
-	 * MAX_SOCK_ADDR-sized buffer and don't set addr_len.  Unfortunately
-	 * that macro is defined in socket.c instead of .h, so we hardcode its
-	 * value here.
-	 */
-	BUILD_BUG_ON(sizeof(*vm_addr) > 128);
+	BUILD_BUG_ON(sizeof(*vm_addr) > sizeof(struct sockaddr_storage));
 	memcpy(addr, vm_addr, sizeof(*vm_addr));
 	err = sizeof(*vm_addr);
 
-- 
2.33.0

