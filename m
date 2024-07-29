Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACE80BF7
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 05:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722230526; cv=none; b=fy6juHHMVfddawedEE+/SJqSGC9dtjT124kDd9A8iFD8Qw1z68If5iYG1SDgztc/2FDAR+39W4VPn/VsrPPIr2XepacSsZ1cJkiTFAo6JeCVTXydypDG0E66sZq9hy521BMc5cTiT7YmES/xj2ZP/3L8sViQifbf7pFLvIeugmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722230526; c=relaxed/simple;
	bh=GPN0jjFfT/BA6h8jFrFebf2Sdt919SK6NeB4CTedbn8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aDpVgk00LnCWQaYjyju+HnZ+odwuaeysop2/3bVDa7t/BbFkA/yzzgXqQyyLvZ0PobHODAShfLXRFmJhJxFEQcYq3QfgQHOx0Z8QTTfjPD/wp2EmUoOun2+w3OyFu1x2Q6cUhNWCoFPLO3s/hf7iNZx+twRbMoDcTaRya+q66Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HRT6bqOa; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HRT6bqOa"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C68481154
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 05:22:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id F-UyhJZXu8xC for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Jul 2024 05:22:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 60A4581184
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60A4581184
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HRT6bqOa
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 60A4581184
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Jul 2024 05:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722230521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vQfZN7k4ZxQj4iZl6k75EO3jnmshySL3thsmTEvOARc=;
	b=HRT6bqOajbYMMciVaOS/nWPEhTV+9Vx7z1xuK7w1i1uXTBU8Kvi/jojhcG1dd58wSAg3HG
	7KOePk41lipaX3U2SETEaqrvTEVwznraxjC1gcPz6R4QlkzVfgk+0X0iSTg4y7x6aabuDU
	NL0FvqxvXGWf5CrLuQ3pgItuafz03hg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-4mKCWyYdO3--p_2ma8hYYw-1; Mon,
 29 Jul 2024 01:21:59 -0400
X-MC-Unique: 4mKCWyYdO3--p_2ma8hYYw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA5001955D4F;
	Mon, 29 Jul 2024 05:21:57 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.168])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9ADB195605F;
	Mon, 29 Jul 2024 05:21:50 +0000 (UTC)
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
Subject: [PATCH v7 0/3] vdpa: support set mac address from vdpa tool
Date: Mon, 29 Jul 2024 13:20:44 +0800
Message-ID: <20240729052146.621924-1-lulu@redhat.com>
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
 - Add a lock for the vdap_sim?_net device's dev_set_attr operation
Changelog v5
 - Address the comments
Changelog v6 
- Replace all the memcpy of mac address with ether_addr_copy()
- Remove the check for VIRTIO_NET_F_MAC in vdpa_dev_net_device_attr_set
- Remove unnecessary check
- Enhance the error log
Changelog v7
 - change the code to reverse-xmas tree style
 - make all patches pass the check of ./scripts/checkpatch.pl --strict 
 - Address other comments

Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 28 ++++++++++
 drivers/vdpa/vdpa.c                  | 80 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 21 +++++++-
 include/linux/vdpa.h                 |  9 ++++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 138 insertions(+), 1 deletion(-)

-- 
2.45.0

