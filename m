Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161843A29B
	for <virtualization@lists.linux.dev>; Mon,  4 Mar 2024 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552847; cv=none; b=gDPNT5RNPFyqsrJY2lOgYuAyodxlm6/KEteTms/C0zmLiOUNdiv4yUYuVgwCSs5Xv6x+fRWswf4c0dAfgpvAZDC5pQcVHbWzXg4n8m/VFUIe/i9TgXn0JJeilZ0HkRKAj2S+vCjmW7aBa76YeDkHQFPojCDISY8FB0gnB4kYdjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552847; c=relaxed/simple;
	bh=oqLqmjqNZDJQAVDOjGK0i7+t19ZhCA5VqlzoKug4/mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FeoeGf197BA6NKcyUea06fP/462/vsVZlzWy4E5aA9Jb18hv4iu5XSmOZ/O2iznoaCEfWVXJhLTkMJ53uygUglDpBaAPUYkGOZuO0YaL3zlotnEC5mNdbxwQoIhEd7IPA4Iy7vPDX+lJQM7TyV43zrVS9SMeiBKF49+5FwGvrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EC1bB4pE; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EC1bB4pE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709552841; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=FSbHit5fj3JcGj8LdoWrNWb4RI1EJ336YjFwd8R5Hlk=;
	b=EC1bB4pEmfUK7K/TxrmnPmaZSFeGo+9YSAeo9bxz2oLNpgyZ43i3CumHaFJHZ2YoddfL4ioelQjDypzRJ4D1JG0fCGX740Oo+08WDtQWaHyhP9gJI5SwfbFyJsZFUOAMlYoHgN8+2h9ZsCcWlIPVYldR/um1QdPHyfxEKCPGr58=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W1op2Ky_1709552839;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1op2Ky_1709552839)
          by smtp.aliyun-inc.com;
          Mon, 04 Mar 2024 19:47:20 +0800
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
Subject: [PATCH vhost 0/4] refactor the params of find_vqs()
Date: Mon,  4 Mar 2024 19:47:15 +0800
Message-Id: <20240304114719.3710-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: f8834711b783
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
 drivers/virtio/virtio_pci_common.c       |  59 ++++----
 drivers/virtio/virtio_pci_common.h       |   9 +-
 drivers/virtio/virtio_pci_legacy.c       |  16 ++-
 drivers/virtio/virtio_pci_modern.c       |  38 +++--
 drivers/virtio/virtio_ring.c             | 173 ++++++++---------------
 drivers/virtio/virtio_vdpa.c             |  45 +++---
 include/linux/virtio_config.h            |  51 +++++--
 include/linux/virtio_ring.h              |  82 ++++++-----
 tools/virtio/virtio_test.c               |   4 +-
 tools/virtio/vringh_test.c               |  28 ++--
 15 files changed, 328 insertions(+), 326 deletions(-)

--
2.32.0.3.g01195cf9f

