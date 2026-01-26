Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A1932BF51
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420947; cv=none; b=L4UsJmsCfc22Fv4u7VAcsWUWFuN3kPNDUcSkylbUjlTiC4ATtv3l+kw2/42IIKmpvubHiLDytnXpAxq//uUJYN4oVdaFKJIbfQYjBzS7KLwUY0wqEJ6dHDey9EBcovgijBg6P6IkRxhzHkjpXadlkWbtlS/SBwRQaB5d3+dGPgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420947; c=relaxed/simple;
	bh=r+oip4R667LHFktLfsnoRd3W3lTXOBV3+88WDRL4GUA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A6o6z9aqhsdYgz2sHY/KVvl2aLOR6hvMYevkoZpuzsz8JuaNoohuNrMLvbETpXvBdwYKO6KnS3RqJHzjQDOWYbb6ADKFH2iikysNruf9iA9MhNiO9qr48OJaRSXHvcbMXp1/o/cJnQAhCE6TuT65CTgb+NAB8RdxPrZ43NOfixA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWAOY0DM; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWAOY0DM"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A84798177A
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fW5Zwr6Xeg6e for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jan 2026 09:49:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8055D8164B
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8055D8164B
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XWAOY0DM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8055D8164B
	for <virtualization@lists.linux-foundation.org>; Mon, 26 Jan 2026 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769420942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Z5yOTegihamA+5DHF4ho0ETS7pvQFQEOBeeVEwzyjsk=;
	b=XWAOY0DMSIJuiO/NK1snqeuVDMScQ6MUcs0OxWu7UaHn98uWu8Xizf0+GKdvk+UO9wtuDY
	aIl8LjEOplwnHe/u1hcTlr78xaxhtyIbdCvmjZzUDUqgyshXOvrQdI5D5vyL9lnO4dYRZF
	CCr9gt2Ds+/pcpAC0/opSTKz3C7NS4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-HZwwQUGLO92c1Ytd60hUjg-1; Mon,
 26 Jan 2026 04:48:58 -0500
X-MC-Unique: HZwwQUGLO92c1Ytd60hUjg-1
X-Mimecast-MFC-AGG-ID: HZwwQUGLO92c1Ytd60hUjg_1769420937
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DE511956096;
	Mon, 26 Jan 2026 09:48:57 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11B1518001D5;
	Mon, 26 Jan 2026 09:48:52 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH v4 0/3] vdpa/mlx5: Fix MAC address update via vdpa-tool
Date: Mon, 26 Jan 2026 17:45:35 +0800
Message-ID: <20260126094848.9601-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series hardens the mlx5 vDPA MAC plumbing by ensuring new addresses replace old
entries cleanly, reusing shared update logic to keep flow tables consistent, and only
advertising the MAC feature when the device is not yet DRIVER_OK

Changes in v2
 Factor out the MAC address update logic and reuse it from handle_ctrl_mac().
 Address review comments.
Changes in v3
 rename mlx5_vdpa_change_new_mac to mlx5_vdpa_change_mac
 Address review comments.
Changes in v4
 Replace memcpy with ether_addr_copy in mlx5_vdpa_change_mac 


Cindy Lu (3):
  vdpa/mlx5: update mlx_features with driver state check
  vdpa/mlx5: reuse common function for MAC address updates
  vdpa/mlx5: update MAC address handling in mlx5_vdpa_set_attr()

 drivers/vdpa/mlx5/net/mlx5_vnet.c | 149 +++++++++++++++++-------------
 1 file changed, 83 insertions(+), 66 deletions(-)

-- 
2.51.0

