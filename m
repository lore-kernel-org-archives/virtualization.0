Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F268813C8E3
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721713269; cv=none; b=cRyxcNVnQPQWAT+qVxjA4YupHk6sEeJ/yrIjDzGmwXOFIKbdirqZ2wF5IRqvOy4aTtFyahs1Uamv8tRFbtRKDFcKz0Mhz4jNAwVN2A1+oYo9kJE29lNvTOkSxx9IzW3bHUAqJwwVduGqbRY2qgl5lm3flhF+aGy025u/0l799Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721713269; c=relaxed/simple;
	bh=/Aoxe5oofzDkL78uMqwAz1MIv6O2W5mN3YwJHvbCyPU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=QlJRb9Hxo/6Iab513l6ZEQWnGy5/IRJ+dXoTVY5HDrZtzfbUkPGz1+Hw0mGISpdObMp8rPgCzx5ZesxsNBcVXkf8t4KU3UsT7SzLjJpKls1StFu2Gm70HI5duDlcwafk0UBlM6brwn6DbC/hZhF0bsHsUXS5OD40QTMrnSrAGn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GwMuVkwg; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwMuVkwg"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87D35400A6
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 05:41:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gJOEKxJEWnwQ for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Jul 2024 05:41:06 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7AF1240042
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AF1240042
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GwMuVkwg
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7AF1240042
	for <virtualization@lists.linux-foundation.org>; Tue, 23 Jul 2024 05:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721713263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uc8bRSj3u2naHy4OwEtHQaZFuHW8/B0CaCmWjb3ybm8=;
	b=GwMuVkwgsSj6Rp9dB46bXSUj5o3tuhJQ5aRRI5m+zF9+qW7TALve4wKHU7k+q/B44P7qna
	G9pJIJdpCpFwqTmgygwerCrDSs5nC58goKXbFxr2+hcAPEGv/BGJTpDQo1qVZX5Gy/yzUu
	CxmCCyybqDPgXtU8l7uJG4riMQxyVDA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-L-E6AIHYM4CquSFP8_khmg-1; Tue,
 23 Jul 2024 01:40:58 -0400
X-MC-Unique: L-E6AIHYM4CquSFP8_khmg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BB7FB1955D52;
	Tue, 23 Jul 2024 05:40:56 +0000 (UTC)
Received: from server.redhat.com (unknown [10.72.112.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 323F01955F40;
	Tue, 23 Jul 2024 05:40:50 +0000 (UTC)
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
Subject: [PATH v5 0/3] vdpa: support set mac address from vdpa tool
Date: Tue, 23 Jul 2024 13:39:19 +0800
Message-ID: <20240723054047.1059994-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Cindy Lu (3):
  vdpa: support set mac address from vdpa tool
  vdpa_sim_net: Add the support of set mac address
  vdpa/mlx5: Add the support of set mac address

 drivers/vdpa/mlx5/net/mlx5_vnet.c    | 28 ++++++++++
 drivers/vdpa/vdpa.c                  | 84 ++++++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 22 +++++++-
 include/linux/vdpa.h                 |  9 +++
 include/uapi/linux/vdpa.h            |  1 +
 5 files changed, 143 insertions(+), 1 deletion(-)

-- 
2.45.0

