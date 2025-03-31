Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85181EF01
	for <virtualization@lists.linux.dev>; Mon, 31 Mar 2025 01:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743386148; cv=none; b=hJnf5JXnARjxMkXSur+PhqaTdWEUYLYzcjn7B1hXu3lsF4I0ebyKww0ybjNwC+IBDy1UQsS9syDS285WRQEuyR3DtMrpCF2Xf5+S6ZMZ8Kxzil6oMy7ql6uo6QMhnCJBn6PzDQG4isTf7HLpGCGg6NXGsRjP6lPGhJhe+mYmoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743386148; c=relaxed/simple;
	bh=yz62TKK6huhFh0HWx99pfPawYWTuAWXT+s00Gpt22t8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=MXYJNZOlmL0MO3Z8F4xTY43i5g5p99INj6m9amyUi4a4kTeQPwscfHcBDwbK6Gj5AWMKkXcGxiHD7c+d7eIla2vSiK5x02PxvbXXf1lbI3JAhGA0PgmML9XdjPgI/VfiDMDBimk9Z0h21qv6prjFTifMbvQODntprpbg4qGqSio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cWNubupa; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cWNubupa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743386138; h=Message-ID:Subject:Date:From:To;
	bh=jHOq3QtmwewmuGcfwHQ9jM68BB3uetbBtMD2GTM1Pxc=;
	b=cWNubupaGf7Ur44NrEn7TyC/+Zj429jc4XRiSP7tZ3ysaOgOyZ8QboVFPn/iLSPjJwAEqR+78GEy0jD1YH+2JXRY41vwZKNW0wBPdYDiJaUFX7vyqVIpuLGpHdnZqPTNUw/rvYWLtode8wvIIaIcNzlbYQtEzpZVPaRiu4D8HJg=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WTOXjik_1743385819 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Mar 2025 09:50:19 +0800
Message-ID: <1743385770.0724318-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/19] virtio_ring in order support
Date: Mon, 31 Mar 2025 09:49:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: eperezma@redhat.com,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 mst@redhat.com,
 jasowang@redhat.com
References: <20250324054333.1954-1-jasowang@redhat.com>
In-Reply-To: <20250324054333.1954-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>


For series:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

On Mon, 24 Mar 2025 13:43:14 +0800, Jason Wang <jasowang@redhat.com> wrote:
> Hello all:
>
> This sereis tries to implement the VIRTIO_F_IN_ORDER to
> virtio_ring. This is done by introducing virtqueue ops so we can
> implement separate helpers for different virtqueue layout/features
> then the in-order were implmeented on top.
>
> Tests shows 5% imporvemnt in RX PPS with KVM guest + testpmd on the
> host.
>
> Please review.
>
> Thanks
>
> Jason Wang (19):
>   virtio_ring: rename virtqueue_reinit_xxx to virtqueue_reset_xxx()
>   virtio_ring: switch to use vring_virtqueue in virtqueue_poll variants
>   virtio_ring: unify logic of virtqueue_poll() and more_used()
>   virtio_ring: switch to use vring_virtqueue for virtqueue resize
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_kick_prepare
>     variants
>   virtio_ring: switch to use vring_virtqueue for virtqueue_add variants
>   virtio: switch to use vring_virtqueue for virtqueue_add variants
>   virtio_ring: switch to use vring_virtqueue for enable_cb_prepare
>     variants
>   virtio_ring: use vring_virtqueue for enable_cb_delayed variants
>   virtio_ring: switch to use vring_virtqueue for disable_cb variants
>   virtio_ring: switch to use vring_virtqueue for detach_unused_buf
>     variants
>   virtio_ring: use u16 for last_used_idx in virtqueue_poll_split()
>   virtio_ring: introduce virtqueue ops
>   virtio_ring: determine descriptor flags at one time
>   virtio_ring: factor out core logic of buffer detaching
>   virtio_ring: factor out core logic for updating last_used_idx
>   virtio_ring: move next_avail_idx to vring_virtqueue
>   virtio_ring: factor out split indirect detaching logic
>   virtio_ring: add in order support
>
>  drivers/virtio/virtio_ring.c | 856 ++++++++++++++++++++++++++---------
>  1 file changed, 653 insertions(+), 203 deletions(-)
>
> --
> 2.42.0
>
