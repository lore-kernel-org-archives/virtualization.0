Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1C4683
	for <virtualization@lists.linux-foundation.org>; Fri, 31 Jan 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312549; cv=none; b=HMYLdlJzCp9JNQT0PSs9Kapxk9jGJg7GLZa4zHTC/q6isrTw9lHAHAaA+mDd90WC9ynbA6Ii4wuYsYPsQaXmvcXXWJ0qLXkqu8a0+yAwGM37OUY1lX2BmxAc/BqKSjiYWA/Eed+vwE7lEOGzj4F8pqPHrp7mS+qsRfvz0ZUcPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312549; c=relaxed/simple;
	bh=+lQ88HgYihnZe8QsK+4BdBsUiUilDPdJ3jiVQhGb30I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDwZa+cEMXhHjEXzXmScXd6uh/AKUAv+4svRs5kif/aHSGfiy+lRzBglBR1OVFb7Ka1Jxl+FJ6FQlKU2W1dYNY+wG5iWtAtZCLVWOyChlVyOY7LvVMIZW2tNEH87/9FaEIOlCQrLn1EWnLaJJz/jnl9+H0Wnv32yLLOTa7oh7LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=GkXwtZor; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="GkXwtZor"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C73FB60BAA
	for <virtualization@lists.linux-foundation.org>; Fri, 31 Jan 2025 08:35:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.791
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bH5ynxPEJ72f for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Jan 2025 08:35:46 +0000 (UTC)
X-Greylist: delayed 474 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 31 Jan 2025 08:35:46 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 217A360BA8
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 217A360BA8
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=swemel.ru header.i=@swemel.ru header.a=rsa-sha256 header.s=mail header.b=GkXwtZor
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.143.211.150; helo=mx.swemel.ru; envelope-from=arefev@swemel.ru; receiver=<UNKNOWN> 
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 217A360BA8
	for <virtualization@lists.linux-foundation.org>; Fri, 31 Jan 2025 08:35:46 +0000 (UTC)
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1738312067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+lQ88HgYihnZe8QsK+4BdBsUiUilDPdJ3jiVQhGb30I=;
	b=GkXwtZorWGYMmFiZuQcW9e80jh4ByTO/BpgMtWWZZ3sRlTy+ibu6KAAdARJ95IhgdJnaoq
	VzQTcdSVTYVJlgfdRvOFQ2jTTr9MW3wzgemRwqIjA9/dCvBppeXRm7zIQ2/7bn7CoSRXog
	vcryloj5Bau0wVDYlRIfAOUIZX3OP+Q=
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Willem de Bruijn <willemb@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 0/5] net: Backport fix for CVE-2024-43817
Date: Fri, 31 Jan 2025 11:27:36 +0300
Message-ID: <20250131082747.4101-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://nvd.nist.gov/vuln/detail/cve-2024-43817

[PATCH 5.10 1/5] net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
[PATCH 5.10 2/5] net: drop bad gso csum_start and offset in virtio_net_hdr
[PATCH 5.10 3/5] net: tighten bad gso csum offset check in virtio_net_hdr
[PATCH 5.10 4/5] net: add more sanity check in virtio_net_hdr_to_skb()
[PATCH 5.10 5/5] net: test for not too small csum_start in

The bug has been fixed "silently" in upstream with the following series
of 5 commits.

49d14b54a527 net: test for not too small csum_start in virtio_net_hdr_to_skb()
6513eb3d3191 net: tighten bad gso csum offset check in virtio_net_hdr
89add40066f9 net: drop bad gso csum_start and offset in virtio_net_hdr
9181d6f8a2bb net: add more sanity check in virtio_net_hdr_to_skb()
fc8b2a619469 net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation
