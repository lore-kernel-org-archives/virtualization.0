Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFFA3C463;
	Wed,  7 May 2025 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577948; cv=none; b=t8fRyRp8ARflbXs9fHN0OkcfV4j/zwytgkXgyt3Q7rQpvRPD4jHW4jFGFpTrBR60z/e3KxYloOI0N0ytMRlGXtnD9jjNvfgD4wG+rm8jh4N5fRE3xPpAMi/LHqsv/jU3txOwhyQc1sgOdJoeYDhmYsKuYaAR9V02Hlc22akq/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577948; c=relaxed/simple;
	bh=S2mF9N2pK6E76W1+2X/icZ8bV7bTpWmy8wFpM30COn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+2NS7EBhmL4gnUg123akVPlI+hnufsm64cm0Ay7XRWxrhamLBa4eLNBfXySRf0B4DjMPN5AR6dXgrZ45DNAbkQE3Um5T9RsbUgLi/qnxMYBsxNnNr1j/JPwXFwBBTT9fSEUI6NpykkAzqrzZmspvrGhHBxQ9f31qT3FHCvgILU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgjFmZ5R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgjFmZ5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0331EC4CEF0;
	Wed,  7 May 2025 00:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746577947;
	bh=S2mF9N2pK6E76W1+2X/icZ8bV7bTpWmy8wFpM30COn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jgjFmZ5RjFR9Ixl+XNwC/L6pcCOGTGehsJTCL6GChPDra6M+iB3LnadhDSR66ikIT
	 tjaMjmqtE0E15IwcktqDsI7Zd4qSsK0mS7QffW/ONw1b6aR4C2UQkOrD0PPIACFid9
	 I8ocoDW3BrpO/yPiVtYdbNgGLvcN9VPmVwXcqFiW2Usc8cbKZJW3rhf+dR4O6Faij7
	 2nlIilUOMdmTg0FJOON/UIkrcEZIbpRQbTBrEBwq560Ogl9wQWu7x8r/KHuSY8gLG5
	 shSJyO4sviZaDwlOTF9Hv3yP0HVnw3gS62VIrcAWtn52Wd1um9bM8QknFjQRlMl8NV
	 WK6UHxTaLv9Sg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	jdamato@fastly.com,
	virtualization@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 2/2] virtio-net: fix total qstat values
Date: Tue,  6 May 2025 17:32:21 -0700
Message-ID: <20250507003221.823267-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507003221.823267-1-kuba@kernel.org>
References: <20250507003221.823267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NIPA tests report that the interface statistics reported
via qstat are lower than those reported via ip link.
Looks like this is because some tests flip the queue
count up and down, and we end up with some of the traffic
accounted on disabled queues.

Add up counters from disabled queues.

Fixes: d888f04c09bb ("virtio-net: support queue stat")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/virtio_net.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index f9e3e628ec4d..e53ba600605a 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -5678,6 +5678,10 @@ static void virtnet_get_base_stats(struct net_device *dev,
 
 	if (vi->device_stats_cap & VIRTIO_NET_STATS_TYPE_TX_SPEED)
 		tx->hw_drop_ratelimits = 0;
+
+	netdev_stat_queue_sum(dev,
+			      dev->real_num_rx_queues, vi->max_queue_pairs, rx,
+			      dev->real_num_tx_queues, vi->max_queue_pairs, tx);
 }
 
 static const struct netdev_stat_ops virtnet_stat_ops = {
-- 
2.49.0

