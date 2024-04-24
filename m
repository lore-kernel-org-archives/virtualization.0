Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312B9158D83
	for <virtualization@lists.linux.dev>; Wed, 24 Apr 2024 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950140; cv=none; b=TJl8oLr1ortcSOTuoPqjPm+qOMPvmixb914Rr27ka9LQwHlNTKnxVuGjDKobCQUeLH89f1Sa5AAhgyKCaLJhoYXPf1NbGc3B+IztCralFNb2woJhNr3hdiZxPalrwMh8WpKIrFj1EA3mSFYNU+HqnopR7IzpMNalKW1JEutrOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950140; c=relaxed/simple;
	bh=b0rc4smgJ1P6nbK75FXOGPdUyAPn30OCb1hAbfz8OYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=dS9NmutlNNJwNr4VzqAk9A8ylf8/dk/+yiORp7kR6d7auppYPQIse8RRrUNgcRQzyGuSPFrUURjbemlrqvvvl0/UD8HCMJCoERcL4OjJjJ/wT9PnQt52SmR7G6wjoFFIqxuwrGAtnrENafLDt2jdIWN5+uRxj50tMpXD8fY1FBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vj8z1SbZ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vj8z1SbZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713950135; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=cYH6nuPV+ukxc4q3ctbCjioUc9rbgmodHni+uxe6ecQ=;
	b=vj8z1SbZKeeKGLD5sP0EPj/IgGshGVX3H1NcgfY6pHbSAhHozeNgR+4/fFt76zkS1DM7zYh4Xgpjfu5tCXWcLRT56puhDkVpicafwoQZDPzQjYtmaoKbiV66x890cNAi1I5vv7y2iLF9paoz3+4sIlA05VJhf6lEKG0B2UZAGEA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W5BsEmF_1713950133;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W5BsEmF_1713950133)
          by smtp.aliyun-inc.com;
          Wed, 24 Apr 2024 17:15:34 +0800
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
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	linux-um@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org
Subject: [PATCH vhost v9 0/6] refactor the params of find_vqs()
Date: Wed, 24 Apr 2024 17:15:27 +0800
Message-Id: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Git-Hash: bdb00f35db89
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

v8:
  1. rebase the vhost branch

v7:
  1. fix two bugs. @Jason

v6:
  1. virtio_balloon: a single variable for both purposes.
  2. if names[i] is null, return error

v5:
  1. virtio_balloon: follow David Hildenbrand's suggest
    http://lore.kernel.org/all/3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com
  2. fix bug of the reference of "cfg_idx"
    http://lore.kernel.org/all/202403222227.Sdp23Lcb-lkp@intel.com

v4:
  1. remove support for names array entries being null
  2. remove cfg_idx from virtio_vq_config

v3:
  1. fix the bug: "assignment of read-only location '*cfg.names'"

v2:
  1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen

v1:
  1. fix some comments from ilpo.jarvinen@linux.intel.com









Xuan Zhuo (6):
  virtio_balloon: remove the dependence where names[] is null
  virtio: remove support for names array entries being null.
  virtio: find_vqs: pass struct instead of multi parameters
  virtio: vring_create_virtqueue: pass struct instead of multi
    parameters
  virtio: vring_new_virtqueue(): pass struct instead of multi parameters
  virtio_ring: simplify the parameters of the funcs related to
    vring_create/new_virtqueue()

 arch/um/drivers/virtio_uml.c             |  36 +++--
 drivers/platform/mellanox/mlxbf-tmfifo.c |  23 +--
 drivers/remoteproc/remoteproc_virtio.c   |  37 +++--
 drivers/s390/virtio/virtio_ccw.c         |  38 ++---
 drivers/virtio/virtio_balloon.c          |  48 +++---
 drivers/virtio/virtio_mmio.c             |  36 +++--
 drivers/virtio/virtio_pci_common.c       |  69 ++++-----
 drivers/virtio/virtio_pci_common.h       |   9 +-
 drivers/virtio/virtio_pci_legacy.c       |  16 +-
 drivers/virtio/virtio_pci_modern.c       |  37 +++--
 drivers/virtio/virtio_ring.c             | 177 ++++++++---------------
 drivers/virtio/virtio_vdpa.c             |  51 +++----
 include/linux/virtio_config.h            |  76 +++++++---
 include/linux/virtio_ring.h              |  93 +++++++-----
 tools/virtio/virtio_test.c               |   4 +-
 tools/virtio/vringh_test.c               |  28 ++--
 16 files changed, 384 insertions(+), 394 deletions(-)

-- 
2.32.0.3.g01195cf9f

