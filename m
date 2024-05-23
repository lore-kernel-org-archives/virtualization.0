Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CB1869
	for <virtualization@lists.linux.dev>; Thu, 23 May 2024 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716450738; cv=none; b=I4mHxNxRDqgdVAmo8rjXy6qLWqeGhiy95mNkHkwVcG05LH6NYU0sYxw0aNntUjSDpH1OBCQvHpqF86X45abko7nCRtaKwnLJdqcKGOX9BUxglCaobunj9C9PgqMK7aJPoNgc2224jQSGHgd0M+6aKA/sTDsSRHRLM+Q+no+YLg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716450738; c=relaxed/simple;
	bh=uiw/KIo7ZzS5LrObk9p7ZQSl8SME5Wqkks2CezeF2pw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q90QHaGW50Sn4vRsmGzyYIdsRMFn9RdgPj60q/LQ3M0hCb5A22i6tatgqQDwED54oh5wJualwmkXmAGC9Ymp1LGyahQUV9cy8dx5TCsxTznjO2ve0h2UAnEmNESEI200gNWbOny5oJwyVPQidnejHsgxeyo4qUfCHs6EXhdt8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jXh0sw7o; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jXh0sw7o"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716450729; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AqDQzHp4jZumxGfK3oZba/CK9i50zN0jYDJfmJs8+iY=;
	b=jXh0sw7o7ATtBtCSwKTlQFRrgvNXsvxYeaGqsLcCa67GzZDMAwLUlsKWgqzdTtVeIKOMbquzQM74yommfPA4VlLAv6ueDMzjcSGTbJc5GZLEACAZbDFEVyz2Kn91toUTRCZNvpRYS5hHeQoEcmFJRSm+MicKAc1SJ5v6AgLjNM8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W724Ck0_1716450411;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W724Ck0_1716450411)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 15:46:52 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: netdev@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net v2 0/2] virtio_net: fix lock warning and unrecoverable state
Date: Thu, 23 May 2024 15:46:49 +0800
Message-Id: <20240523074651.3717-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 describes and fixes an issue where dim cannot return to
normal state in certain scenarios.

Patch 2 attempts to resolve lockdep's complaints that holding many
nested locks and when there is a maximum number of queues may also
be problematic, so try to remove the dim_lock.

Changelog
=======
v1->v2:
  Patch(2/2): rephase the commit log.

Heng Qi (2):
  virtio_net: fix possible dim status unrecoverable
  Revert "virtio_net: Add a lock for per queue RX coalesce"

 drivers/net/virtio_net.c | 55 ++++++++++------------------------------
 1 file changed, 13 insertions(+), 42 deletions(-)

-- 
2.32.0.3.g01195cf9f

