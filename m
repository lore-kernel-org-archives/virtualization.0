Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37CD4431
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610403; cv=none; b=BgYr7QS9uNGNhLnhK2vtLXfjidY06K5BV+CDxus6JmJGemx6IaNexs1hUn36mPLvcNO5vWYd+6uhAW51dtAgdvp/+znSZGetffe4sSvj7FadiaZxCdkNY/pliOBk6h+Iwu0tSi2+me+3SfIqTotngNs781nFQG4f+l5bQlIjQU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610403; c=relaxed/simple;
	bh=diILvCZinSjzgPrFQoxOVtRera4h862XU+rAcYS/Nvk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T54+KcHkmcfBviVNkaW4h14Ncwfj6pEM0HRpwezrr+5ZKdd0cF4OyWBaNeg7oM/V2Lq8K86a37UzvvP4tQd85zQgIOYDV31j5n+7WoYP09UQX22458mFBGvBJmhgodlUT/S6YsScq8S3FsRmDL7Cu0qF67VB5C/cOItXRoEHQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShC6Zap1; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShC6Zap1"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51B6581089
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 01:06:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wceqdvnOX_XM for <virtualization@lists.linux-foundation.org>;
 Mon, 22 Jul 2024 01:06:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8F75E80D80
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8F75E80D80
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ShC6Zap1
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8F75E80D80
	for <virtualization@lists.linux-foundation.org>; Mon, 22 Jul 2024 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721610399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8+7BYv0y9Snk+G9iQOgMHiR8iidKZj6hsfK238F04TA=;
	b=ShC6Zap1FA+MMcRd7/V8QANdOUlT+mIPLAY1z1ZoPrlmkXbIYUYOW6+femMcsyjUCy6geB
	BwnA4byLArEZyuAOByZw+bQGvfwojaxAdCpwqv/kL6GknDI7GG/NW5zUQsObNBnKcg8n2E
	B0vGV9wX0Nl4YrPdxEOfdCYMSyUpaH8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-nl83Et2YM92NMpfjfyVP9g-1; Sun,
 21 Jul 2024 21:06:37 -0400
X-MC-Unique: nl83Et2YM92NMpfjfyVP9g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 360A919560A1;
	Mon, 22 Jul 2024 01:06:36 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3F7F195605A;
	Mon, 22 Jul 2024 01:06:30 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	dtatulea@nvidia.com,
	mst@redhat.com,
	jasowang@redhat.com,
	parav@nvidia.com,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATH v4 0/3] vdpa: support set mac address from vdpa tool
Date: Mon, 22 Jul 2024 09:05:17 +0800
Message-ID: <20240722010625.1016854-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add support for setting the MAC address using the VDPA tool.
This feature will allow setting the MAC address using the VDPA tool.
For example, in vdpa_sim_net, the implementation sets the MAC address
to the config space. However, for other drivers, they can implement their
own function, not limited to the config space.

Changelog v2
 - Changed the function name to prevent misunderstanding
 - Added check for blk device
 - Addressed the comments
Changelog v3
 - Split the function of the net device from vdpa_nl_cmd_dev_attr_set_doit
 - Add a lock for the network device's dev_set_attr operation
 - Address the comments
Changelog v4
 - Address the comments
 - Add a lock for the vdap_sim_net device's dev_set_attr operation


Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 25 +++++++++
 drivers/vdpa/vdpa.c                  | 84 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++-
 include/linux/vdpa.h                 |  9 +++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 140 insertions(+), 1 deletion(-)

-- 
2.45.0

