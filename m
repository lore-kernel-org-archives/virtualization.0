Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5698A13D61A
	for <virtualization@lists.linux.dev>; Wed, 22 May 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381703; cv=none; b=ZPmjit8aXu7Zwj11Vz+NM2VxmRskVgR3d5W/PQl60JEtv1w1I4BG4sFEGnQCpYBc+S1tUDGdz2CD9j5Rk1mAjub/A2CEngUTnch5e96gYA+a28Z33roF6XxQgpFfdieCB+GtbUK7u/yznyWcHYW08f9AmJvkmbkoaI6iUtxK0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381703; c=relaxed/simple;
	bh=E7CA4yr2gUx/CdKF+BADYtjytvmGLX2W3OhjfrhmVcs=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=WL/jMwcyXvENITeIffEBZRoqqEjBhKxTkAl+Y2vp93WuMOu8xDo43mkDpnSxWKuFLFEBvKAkeexbIC2OzDhiC62MoTbIJZe2efhLCshADJ0oERPsHrqR0q1VdLtHRerk5GWSJZVYBucaEPYxz6a0hIM3bqa29144jTzpaRgLWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K7CET/ZK; arc=none smtp.client-ip=47.90.199.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K7CET/ZK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716381685; h=Message-ID:Subject:Date:From:To;
	bh=kaW0YgGw3dq/rQoPZq4yGMzGnulifIeN6HXu9g9dSzU=;
	b=K7CET/ZKHxPBxAF1BXhnBKUKEv+nIdHmsvcjWmAi7hwh3T78DGLblm+fCqGRJ5/fDxgMvcbo2W8SK7LnNsOXAEkBExpunAiiwfMvNGKOACNvsCJz7vG20MCkz5z8G77nqtKc6D5sZPCd2sLHI+ZEJXn7/10Moz4Z+8lQ56NrsZ8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W7.bw5p_1716381683;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7.bw5p_1716381683)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 20:41:24 +0800
Message-ID: <1716381321.6426032-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 0/6] refactor the params of find_vqs()
Date: Wed, 22 May 2024 20:35:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Hans de Goede <hdegoede@redhat.com>,
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
 David Hildenbrand <david@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240522082732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240522082732-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 22 May 2024 08:28:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Apr 24, 2024 at 05:15:27PM +0800, Xuan Zhuo wrote:
> > This pathset is splited from the
> >
> >      http://lore.kernel.org/all/20240229072044.77388-1-xuanzhuo@linux.alibaba.com
> >
> > That may needs some cycles to discuss. But that notifies too many people.
> >
> > But just the four commits need to notify so many people.
> > And four commits are independent. So I split that patch set,
> > let us review these first.
> >
> > The patch set try to  refactor the params of find_vqs().
> > Then we can just change the structure, when introducing new
> > features.
> >
> > Thanks.
>
> It's nice but I'd like to see something that uses this before I bother
> merging. IIUC premapped is dropped - are we going to use this in practice?


1. You know this modification makes sense.
2. This modification is difficult. Unlike modifying virtio ring or virtio-net,
   this patch set requires modifying many modules and being reviewed by
   many people.
3. If you do not merge it now, then this patch set will most likely be
   abandoned. And I worked a lot on that.
4. premapped has not been abandoned, I have been advancing this work. What was
   abandoned was just virtio-net big mode's support for premapped.
5. My plan is to complete virtio-net support for af-xdp in 6.10. This must
   depend on premapped.

So, I hope you merge this patch set.

Thanks.


>
> > v8:
> >   1. rebase the vhost branch
> >
> > v7:
> >   1. fix two bugs. @Jason
> >
> > v6:
> >   1. virtio_balloon: a single variable for both purposes.
> >   2. if names[i] is null, return error
> >
> > v5:
> >   1. virtio_balloon: follow David Hildenbrand's suggest
> >     http://lore.kernel.org/all/3620be9c-e288-4ff2-a7be-1fcf806e6e6e@redhat.com
> >   2. fix bug of the reference of "cfg_idx"
> >     http://lore.kernel.org/all/202403222227.Sdp23Lcb-lkp@intel.com
> >
> > v4:
> >   1. remove support for names array entries being null
> >   2. remove cfg_idx from virtio_vq_config
> >
> > v3:
> >   1. fix the bug: "assignment of read-only location '*cfg.names'"
> >
> > v2:
> >   1. add kerneldoc for "struct vq_transport_config" @ilpo.jarvinen
> >
> > v1:
> >   1. fix some comments from ilpo.jarvinen@linux.intel.com
> >
> >
> >
> >
> >
> >
> >
> >
> >
> > Xuan Zhuo (6):
> >   virtio_balloon: remove the dependence where names[] is null
> >   virtio: remove support for names array entries being null.
> >   virtio: find_vqs: pass struct instead of multi parameters
> >   virtio: vring_create_virtqueue: pass struct instead of multi
> >     parameters
> >   virtio: vring_new_virtqueue(): pass struct instead of multi parameters
> >   virtio_ring: simplify the parameters of the funcs related to
> >     vring_create/new_virtqueue()
> >
> >  arch/um/drivers/virtio_uml.c             |  36 +++--
> >  drivers/platform/mellanox/mlxbf-tmfifo.c |  23 +--
> >  drivers/remoteproc/remoteproc_virtio.c   |  37 +++--
> >  drivers/s390/virtio/virtio_ccw.c         |  38 ++---
> >  drivers/virtio/virtio_balloon.c          |  48 +++---
> >  drivers/virtio/virtio_mmio.c             |  36 +++--
> >  drivers/virtio/virtio_pci_common.c       |  69 ++++-----
> >  drivers/virtio/virtio_pci_common.h       |   9 +-
> >  drivers/virtio/virtio_pci_legacy.c       |  16 +-
> >  drivers/virtio/virtio_pci_modern.c       |  37 +++--
> >  drivers/virtio/virtio_ring.c             | 177 ++++++++---------------
> >  drivers/virtio/virtio_vdpa.c             |  51 +++----
> >  include/linux/virtio_config.h            |  76 +++++++---
> >  include/linux/virtio_ring.h              |  93 +++++++-----
> >  tools/virtio/virtio_test.c               |   4 +-
> >  tools/virtio/vringh_test.c               |  28 ++--
> >  16 files changed, 384 insertions(+), 394 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
>
