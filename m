Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A01352F6B
	for <virtualization@lists.linux.dev>; Wed,  6 Mar 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709725583; cv=none; b=H3PmBbLu10oM26AQPSh1bqx3+O8YKalyFw9EOXBc34dMwOexH9uPH8hU3rdbRsFirAmE36dhMJPPPydg/1G7W+YiB4VxWZ3BiDWMDF7XoB91sVhhah0UnBezMurlLWUi5pBIxuhpRRECLB3FCzCgESoS3ftNFY9aZOm3gEnLLkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709725583; c=relaxed/simple;
	bh=jQ5LqlPDIY+3XgVGi+/oSa7JJvvFuVqD2LRBQQmpkCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=goIh/Fyd1qxxIIUR2Xtogy23FNMV0axXNv03fQbDhrPCd6K7Gf68hxnJxeqLzPLe4eoD9ludfyKAyG1M5SrVzrTjarv//0bqkoWSDMyizLwimxXsSADmONIzsobcto7BBdLY2gMJ1ZLmugjZXQDu5iBdRtEU9L7dGSVk8b/4Q24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qyIuiAJt; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qyIuiAJt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709725578; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Z+gtGQnd7649aJaQBgZX3EXXYvWVCzrVQ9Rpd6VeQPk=;
	b=qyIuiAJt0ETnUUEtYrtVYBlLPV4k2UQFMXbkmhH902yyV2pD3QfBodsIqyyCAOZ12RKd2lLyaCx3KrnHrpHew60JBAUkig+gRtZMy4sQ2TNYQ9Ovd+KL3xijrtyJrV235q2O0scRLL+tBIUXa0uA8O2HgdITNiGb7dAPUT2YcRM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W1xT8mL_1709725575;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1xT8mL_1709725575)
          by smtp.aliyun-inc.com;
          Wed, 06 Mar 2024 19:46:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH vhost v1 0/4] refactor the params of find_vqs()
Date: Wed,  6 Mar 2024 19:46:11 +0800
Message-Id: <20240306114615.88770-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: b9b03370361a
Content-Transfer-Encoding: 8bit

This pathset is splited from the

     http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com

That may needs some cycles to discuss. But that notifies too many people.

But just the four commits need to notify so many people.
And four commits are independent. So I split that patch set,
let us review these first.

The patch set try to  refactor the params of find_vqs().
Then we can just change the structure, when introducing new
features.

Thanks.

v1:
  1. fix some comments from ilpo.jarvinen@linux.intel.com

Xuan Zhuo (4):
  virtio: find_vqs: pass struct instead of multi parameters
  virtio: vring_create_virtqueue: pass struct instead of multi
    parameters
  virtio: vring_new_virtqueue(): pass struct instead of multi parameters
  virtio_ring: simplify the parameters of the funcs related to
    vring_create/new_virtqueue()

 arch/um/drivers/virtio_uml.c             |  31 ++--
 drivers/platform/mellanox/mlxbf-tmfifo.c |  24 ++--
 drivers/remoteproc/remoteproc_virtio.c   |  31 ++--
 drivers/s390/virtio/virtio_ccw.c         |  33 ++---
 drivers/virtio/virtio_mmio.c             |  30 ++--
 drivers/virtio/virtio_pci_common.c       |  60 ++++----
 drivers/virtio/virtio_pci_common.h       |   9 +-
 drivers/virtio/virtio_pci_legacy.c       |  16 ++-
 drivers/virtio/virtio_pci_modern.c       |  38 +++--
 drivers/virtio/virtio_ring.c             | 173 ++++++++---------------
 drivers/virtio/virtio_vdpa.c             |  45 +++---
 include/linux/virtio_config.h            |  77 ++++++++--
 include/linux/virtio_ring.h              |  82 ++++++-----
 tools/virtio/virtio_test.c               |   4 +-
 tools/virtio/vringh_test.c               |  28 ++--
 15 files changed, 348 insertions(+), 333 deletions(-)

--
2.32.0.3.g01195cf9f

