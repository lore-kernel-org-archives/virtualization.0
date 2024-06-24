Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF2B2F24
	for <virtualization@lists.linux.dev>; Mon, 24 Jun 2024 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719226348; cv=none; b=YLnNuJkpgmAPu1JM2YqxWNQwGoyGqdZgf6+AWWkjyAWKgnT5Iqu6On9Sqa/lGlbAlDXN7OJ0E1xvxRByTW8/tF8HsPTpRJY4N4ow2slYn0goAmhDyO7iXPlb9wAOd4ccdtfr2CgGAsHbC4Y73u4GdCa9tDYRN1a/gDUNr1V2nyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719226348; c=relaxed/simple;
	bh=y+5l2xsFWl0AtmMU58rcQaOkATQ8125ep4fZKEiWhKs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=UAdDGPzBfbKEXFHu/qB9e9PYOKHGgm/wJzou9WAeZD72A8Cvag2f6UyR1xQ2lkoJkPtL3g6UZhhVjyizhfAbLL9V6ul886JIMkw3vgm34TXPnKKRfD9CcjjhOZDMoa0dm2IAMzpIkdgsqkHseuuZ6zqL5igciOLcTNLZIGOMSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gWofRogU; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gWofRogU"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719226337; h=Message-ID:Subject:Date:From:To;
	bh=UTLof5pqpbSZ2yej5b7IZywbHYCPzmbekz7s9J9+dxQ=;
	b=gWofRogU9AOeyS8TebScWOz/1n83jnt+xW73M/XvkA5Z1dq0LmVVob6dFleNtxm+4Vny8ng+Tp2abbljf3fz38KNuQoKlzfO0oBJx5AfkT4m+37xIJeFZr6vh+XXo0q4slrjviiAGYD/tE70E/QAZr/N/fdSPggEv/bJq2ouR5k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W989VUN_1719226334;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W989VUN_1719226334)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 18:52:14 +0800
Message-ID: <1719222832.5704103-18-hengqi@linux.alibaba.com>
Subject: Re: [PATCH virtio 0/8] virtio_pci_modern: allow parallel admin queue commands execution
Date: Mon, 24 Jun 2024 17:53:52 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com,
 jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com,
 parav@nvidia.com,
 feliu@nvidia.com,
 virtualization@lists.linux.dev
References: <20240624090451.2683976-1-jiri@resnulli.us>
In-Reply-To: <20240624090451.2683976-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 24 Jun 2024 11:04:43 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently the admin queue command execution is serialized by a lock.
> This patchsets lifts this limitation allowing to execute admin queue
> commands in parallel. To do that, admin queue processing needs to be
> converted from polling to interrupt based completion.
> 
> Patches #1-#6 are preparations, making things a bit smoother as well.
> Patch #7 implements interrupt based completion for admin queue.

Hi, Jiri

Before this set, I pushed the cvq irq set [1], and the discussion focused on the
fact that the newly added irq vector may cause the IO queue to fall back to
shared interrupt mode.
But it is true that devices implemented according to the specification should
not encounter this problem. So what do you think?

[1] https://lore.kernel.org/all/20240619171708-mutt-send-email-mst@kernel.org/

> Patch #8 finally removes the admin queue serialization lock.
> 
> Jiri Pirko (8):
>   virtio_pci: push out single vq find code to vp_find_one_vq_msix()
>   virtio_pci_modern: treat vp_dev->admin_vq.info.vq pointer as static
>   virtio: push out code to vp_avq_index()
>   virtio: create admin queues alongside other virtqueues
>   virtio_pci_modern: create admin queue of queried size
>   virtio_pci_modern: pass cmd as an identification token
>   virtio_pci_modern: use completion instead of busy loop to wait on
>     admin cmd result
>   virtio_pci_modern: remove admin queue serialization lock
> 
>  drivers/virtio/virtio.c            |  28 +----
>  drivers/virtio/virtio_pci_common.c | 109 ++++++++++++++------
>  drivers/virtio/virtio_pci_common.h |   9 +-
>  drivers/virtio/virtio_pci_modern.c | 160 ++++++++++++-----------------
>  include/linux/virtio.h             |   2 +
>  include/linux/virtio_config.h      |   2 -
>  6 files changed, 150 insertions(+), 160 deletions(-)
> 
> -- 
> 2.45.1
> 
> 
