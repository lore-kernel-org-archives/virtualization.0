Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC8331235;
	Mon, 23 Feb 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867961; cv=none; b=eREUihoukV5Bgnrjfy7QWfIhpJyUzawIA4PPDWJk0AnFnwwocliCpc9rbWSRwureaT+EJI4b3vxDe5CWdzWN25F/jPh4hwST3sO1SPtSHnOLUYpSEcSsntsf7+b1h3ANGtrjOZk2sPFdZbfSOJ3WZlf59Lj58x34Tmj+wNv/BH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867961; c=relaxed/simple;
	bh=2AfigayoAyKCIhTyaAoEdc9v5E1kP/zqJbLIqlwlabA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LieIInypWyxoFNZb9HXPwDCjOgkGfbPrbtGFAbcbNkhbzwwhCmIXzzOzrd5XfU/sKmESdS7MqRqvMUZxDGLgcTL6w5PT2PxvdC3nbKk0FWzygsvM6GOYaxjPcBaO1AJteT3DwWBb+YMKazpS9kOzgMDRTlcmmKylRze2i7Nkrjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JD/231jT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JD/231jT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22305C116C6;
	Mon, 23 Feb 2026 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771867961;
	bh=2AfigayoAyKCIhTyaAoEdc9v5E1kP/zqJbLIqlwlabA=;
	h=From:To:Cc:Subject:Date:From;
	b=JD/231jTxPt1IAs9Gn2RCYJBzoW1dPU6UqEzFhOevj+RaidoCHPDvf4hHO+TOkfyz
	 nYBSsiONVK8TDmE7sXU99OHv1YK5v559sUX1ub/12quAgprNgb3SfaTdfBo/tOqKy8
	 KnX8tCyVbuHxd6sS2HbUVkT/0K0Llma09HOvzPyg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	stable <stable@kernel.org>
Subject: [PATCH net] vsock: Use container_of() to get net namespace in sysctl handlers
Date: Mon, 23 Feb 2026 18:32:18 +0100
Message-ID: <2026022318-rearview-gallery-ae13@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1956; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=2AfigayoAyKCIhTyaAoEdc9v5E1kP/zqJbLIqlwlabA=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlz+pWVk+tVK57L9P62LWGZx32tcvIt8bMTjnLsZj5Y2 naS6/HVjlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiIx2GGeWrb235vWTAjwzr6 ziKl5DDdmp6UuwwLjt/eo17XXPXEtszs7jvmYK45DqU+AA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

current->nsproxy is should not be accessed directly as syzbot has found
that it could be NULL at times, causing crashes.  Fix up the af_vsock
sysctl handlers to use container_of() to deal with the current net
namespace instead of attempting to rely on current.

This is the same type of change done in commit 7f5611cbc487 ("rds:
sysctl: rds_tcp_{rcv,snd}buf: avoid using current->nsproxy")

Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

Note, this is compile-tested only.  Some of my scripts found this when
looking for places that are missing fixes that were applied to other
parts of the kernel.  I think the af_vsock code uses namespaces, but as
I don't know the network stack at all I figured I would let you all
review it to tell me how wrong I got this change and all is fine with
the original code.

thanks,

greg k-h

 net/vmw_vsock/af_vsock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 9880756d9eff..f4062c6a1944 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -2825,7 +2825,7 @@ static int vsock_net_mode_string(const struct ctl_table *table, int write,
 	if (write)
 		return -EPERM;
 
-	net = current->nsproxy->net_ns;
+	net = container_of(table->data, struct net, vsock.mode);
 
 	return __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				       vsock_net_mode(net), NULL);
@@ -2838,7 +2838,7 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 	struct net *net;
 	int ret;
 
-	net = current->nsproxy->net_ns;
+	net = container_of(table->data, struct net, vsock.child_ns_mode);
 
 	ret = __vsock_net_mode_string(table, write, buffer, lenp, ppos,
 				      vsock_net_child_mode(net), &new_mode);
-- 
2.53.0

