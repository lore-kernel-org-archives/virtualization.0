Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD80DF4F
	for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 02:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669167; cv=none; b=Khdiyk1aTWolis7FZ/eMl56tbILTTPAx3oUBPMzy7AsUdaFS8foAz9L5GJuWwjkRicodKxlbzbFWwF5RCWHDDmNdRwlRiDybvH45k4Gb+jCKnqF6YJoA8lewD1p0y0CQSz3ySKzttS9LBhCxeE5SKysJXYv/dhw26PAcWzfK080=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669167; c=relaxed/simple;
	bh=LqNTI0RdHPb+OTAOKc6/qTP+mOuVq6DWwO3owjjfP/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VoSyfEJpuEB4sQjzZ/PBAQZAageiGR2Us7f6RrObOPoGG7+oA6MVSLrR9oSq/pUfz+AiBma0ASvAjvJ30hw45juX0b605m4g3xxPHJo1gWf3kifKU3BCaCFrcH35yFEQgKx0DacAKkHH58Ck1F6By2yUsZJqFFq2wmxgdqL6SmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rZ6/TBxo; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rZ6/TBxo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706669161; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=IzQD3tMg1mXC5+7/I9iCORFUJC8bBiJ6iN1YWqN42M8=;
	b=rZ6/TBxoEEpGjSABJACh0vtvD4psJ+JbG5oqX66O022lNXuTFsCs++xd0Y/rWfcuR0NXdxgiCD4RGtOFdJv4D26KKlWHDsLJyGA9jeXVl7pARXgQZjwv8/ZqaWgdUWQIU7SHWfUUJ3hQRoIZo35xMJhvbG2FRilPepweZKgcN1U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W.hnzCY_1706669159;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.hnzCY_1706669159)
          by smtp.aliyun-inc.com;
          Wed, 31 Jan 2024 10:46:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/6] virtio-net: support device stats
Date: Wed, 31 Jan 2024 10:45:53 +0800
Message-Id: <20240131024559.63572-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 80d9c8e6c6fe
Content-Transfer-Encoding: 8bit

As the spec:

https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtio net supports to get device stats.

Please review.

Thanks.

v2:
    1. fix the usage of the leXX_to_cpu()
    2. add comment to the structure virtnet_stats_map

v1:
    1. fix some definitions of the marco and the struct



Xuan Zhuo (6):
  virtio_net: introduce device stats feature and structures
  virtio_net: virtnet_send_command supports command-specific-result
  virtio_net: support device stats
  virtio_net: stats map include driver stats
  virtio_net: add the total stats field
  virtio_net: rename stat tx_timeout to timeout

 drivers/net/virtio_net.c        | 536 ++++++++++++++++++++++++++++----
 include/uapi/linux/virtio_net.h | 137 ++++++++
 2 files changed, 613 insertions(+), 60 deletions(-)

--
2.32.0.3.g01195cf9f

