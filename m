Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055A6BFAF
	for <virtualization@lists.linux.dev>; Thu, 14 Mar 2024 08:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406512; cv=none; b=XFOXllaHAIFXr2OyWPOsk0Rk4xp3cARnUqcyntlWDKItnQ/yko154aFk0s/n8MIdB5zOwq10J/Fp9JHGIah985rvNp5dj1G0g7/UAhTr2O5TKtl8p6E/ZyjL2e1zNmGxqPNNbpAFgjgXgqYSccoKG/yuAIHZtKFRwJftdgY97RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406512; c=relaxed/simple;
	bh=g7MDnwJa4sMN0bQaStBd6SvmxSktKfjJRuOwAzBq5eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PX8KMaVBR9J9ycr6ILsICaZ8LD5FZPw0CkvV6+kvxREcJ/A0BzLRRw/MGxLzvSRRvfHdVO+XT/hfdicqoXxyn875lv0IRBMTGbZgtGl+5cD/rDp9JyCuLM8+p6lNhXGpYuINnfzKO0wwAIUkLgBJDZGu3UplcOwt4oyjR4M/+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Is9+Hund; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Is9+Hund"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710406502; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=v5R56GJm1wCv4DzgzfQDshrevtSBDuWhu6Ql2bvSzys=;
	b=Is9+Hund3MbaVthgymLfjmFYyZ4L4Fn0mQzk6hpAGmmejnPTkpwUDqvzF1NJ9xSfO0ybyqdKL8ylRRjysJqO9Axt0OIpPqUf90cXB0Pbu9rd8Eb03U8Q+6XNf9nsg+g+IPZBEL3GsYy2/WcD+MY7J5rjdFtPXXK875P1TzJFJKA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2S1OCB_1710406499;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2S1OCB_1710406499)
          by smtp.aliyun-inc.com;
          Thu, 14 Mar 2024 16:55:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v4 0/8] virtio-net: support device stats
Date: Thu, 14 Mar 2024 16:54:51 +0800
Message-Id: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 76259b0090f3
Content-Transfer-Encoding: 8bit

As the spec:

https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82

The virtio net supports to get device stats.

Please review.

Thanks.


v4:
    1. Support per-queue statistics API
    2. Fix some small problems in last version

v3:
    1. rebase net-next

v2:
    1. fix the usage of the leXX_to_cpu()
    2. add comment to the structure virtnet_stats_map

v1:
    1. fix some definitions of the marco and the struct





Xuan Zhuo (8):
  virtio_net: introduce device stats feature and structures
  virtio_net: virtnet_send_command supports command-specific-result
  virtio_net: support device stats
  virtio_net: stats map include driver stats
  virtio_net: add the total stats field
  virtio_net: rename stat tx_timeout to timeout
  netdev: add queue stats
  virtio-net: support queue stat

 Documentation/netlink/specs/netdev.yaml | 105 ++++
 drivers/net/virtio_net.c                | 708 +++++++++++++++++++++---
 include/net/netdev_queues.h             |  27 +
 include/uapi/linux/netdev.h             |  20 +
 include/uapi/linux/virtio_net.h         | 137 +++++
 net/core/netdev-genl.c                  |  23 +-
 tools/include/uapi/linux/netdev.h       |  19 +
 7 files changed, 962 insertions(+), 77 deletions(-)

--
2.32.0.3.g01195cf9f

