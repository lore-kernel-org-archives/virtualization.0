Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FC32C930
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Jan 2026 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769499581; cv=none; b=YhDfjKnkGTIXTGjkgLUIlxfIn1ba/6AFGliUclynHKaD4VcXUHwAmLscvP+4IlRvTcsZLL3OVvhQg21xPQemT8QpJ41xJ8pqjx0iM3VIHV9t8gBTVdGb40SIzyrsABTCNagMw87zzDiF/pVaQmbJimoERiR6ct5uQprRyF2U7aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769499581; c=relaxed/simple;
	bh=eHi/F5rgbKOLh7VbcqHDYhy9AXrHcsfvJc2Mvm/kcHo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MUMYy4lPSCgBeO4Wo0pts7pFp3GMIcxJv8nsfKPBg9B/RhiMQ6gEHytNuR1jc34wSAxDoIhvS+C8Qw182whVXDk8qiFuSHiNncxnhZi0ZWIQUQhcWXcTUfZ9s2bBmlooSfYU8ohHLHpKo7rsTV0eywpFNHLfraTJgX25OF6huW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PNkVqh5/; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNkVqh5/"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E126A80BF7
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Jan 2026 07:39:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VOqsnCo3UWHf for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jan 2026 07:39:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=lulu@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A219380BD3
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A219380BD3
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PNkVqh5/
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A219380BD3
	for <virtualization@lists.linux-foundation.org>; Tue, 27 Jan 2026 07:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769499576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bwBEw1zd5t7ZpgQXNt7Oa6aG6SzuHHJ86eogm7XJGHU=;
	b=PNkVqh5/J+maEXZV/icf4NwplqhB3osCR8/fTd4nI9UJz04oGqKTUyHakv2BIHTFHA0PNq
	DTsRSXO/SqW8lr5I+esCsBRNkdPc8q3icD/IRe5V8AOTXjqbofmDMur2MDSG2/DDT33o6M
	Khp3D2QhUN7+sIW/F5CMwaBmUKOxsMQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-2_lOBWUsNrWB4IwVkR7Cmw-1; Tue,
 27 Jan 2026 02:39:30 -0500
X-MC-Unique: 2_lOBWUsNrWB4IwVkR7Cmw-1
X-Mimecast-MFC-AGG-ID: 2_lOBWUsNrWB4IwVkR7Cmw_1769499569
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DA661944B17;
	Tue, 27 Jan 2026 07:39:29 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.73])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A25081800665;
	Tue, 27 Jan 2026 07:39:25 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: remove impossible check in VHOST_GET_FORK_FROM_OWNER ioctl
Date: Tue, 27 Jan 2026 15:39:11 +0800
Message-ID: <20260127073921.175981-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

remove impossible fork_owner check in VHOST_GET_FORK_FROM_OWNER ioctl

Fixes: 7d9896e9f6d02d8a ("vhost: Reintroduce kthread API and add mode selection")

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vhost/vhost.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index bccdc9eab267..889481c92236 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2338,11 +2338,6 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
 	if (ioctl == VHOST_GET_FORK_FROM_OWNER) {
 		u8 fork_owner_val = d->fork_owner;
 
-		if (fork_owner_val != VHOST_FORK_OWNER_TASK &&
-		    fork_owner_val != VHOST_FORK_OWNER_KTHREAD) {
-			r = -EINVAL;
-			goto done;
-		}
 		if (put_user(fork_owner_val, (u8 __user *)argp)) {
 			r = -EFAULT;
 			goto done;
-- 
2.51.0

