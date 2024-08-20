Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CB1494C3
	for <virtualization@lists.linux.dev>; Tue, 20 Aug 2024 06:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724134870; cv=none; b=eb7xX2VdLhRDkDaOD7tjUjLCOIjn4dD9qAEFw80+kWshjOrORYseRnvv49QkB93ZTGF4R3dAfEeWOp/GBWDviugqAq6iPsM5NHdkhGPhWb6sPUrgCFnZfyuzTJ4Xku842UtDDBERiGh3abefqV+bw8r5ffgPiRmHgmgfCSNHULI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724134870; c=relaxed/simple;
	bh=HN/gqSUG72SvYiIjtM1v/nfEHRMWbyqMna1vKY9LjqM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=C64zqbQNrVyZv6AxXABsYW+eLz6Z5UQ0l49mGJu9cjlP0zqaO8Yxv8MTJigPMxMWgGQw2LOiRU0WGNQfRijcu+jNj+58zq+Ul5Uze8MpsCa1w3t3H7aCG0Q9vUbKoWSZMsLfI2JYm2jm8I/Lvgn/WkGJjo9Z8RXrp2XuXggsZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dK1Op/cG; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dK1Op/cG"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724134857; h=Message-ID:Subject:Date:From:To;
	bh=14Pe3SLqdbqr5ua24G1iMx9ClrRaNFm8prbboqDtRjI=;
	b=dK1Op/cG2MFT6e6mAlkhgmp1QG8/Uf1velhMXaxLhouKKINCsfK1JValjcMvX9l4MSsBK6p/dNpeIPAokEmyWibmSYLsL2o17CUDqQuGrb+Rh+fZKwmJuI/BPuPhyE77UtfuzWU/VJHj53BzRg4dGMtY6GEezK8UQdN52eG9dd8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WDHX2Kv_1724134854)
          by smtp.aliyun-inc.com;
          Tue, 20 Aug 2024 14:20:54 +0800
Message-ID: <1724134768.1456072-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 1/4] virtio_ring: enable premapped mode whatever use_dma_api
Date: Tue, 20 Aug 2024 14:19:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Si-Wei Liu" <si-wei.liu@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 Darren Kenny <darren.kenny@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240511031404.30903-1-xuanzhuo@linux.alibaba.com>
 <20240511031404.30903-2-xuanzhuo@linux.alibaba.com>
 <8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com>
 <1723900832.273505-1-xuanzhuo@linux.alibaba.com>
 <b4b3df48-d0c9-df99-5c47-7b193a5f70fd@oracle.com>
In-Reply-To: <b4b3df48-d0c9-df99-5c47-7b193a5f70fd@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 19 Aug 2024 18:06:07 -0700, "Si-Wei Liu" <si-wei.liu@oracle.com> wrote:
> Hi,
>
> May I know if this is really an intended fix to post officially, or just
> a workaround/probe to make the offset in page_frag happy when
> net_high_order_alloc_disable is true? In case it's the former, even
> though this could fix the issue, I would assume clamping to a smaller
> page_frag than a regular page size for every buffer may have certain
> performance regression for the merge-able buffer case? Can you justify
> the performance impact with some benchmark runs with larger MTU and
> merge-able rx buffers to prove the regression is negligible? You would
> need to compare against where you don't have the inadvertent
> virtnet_rq_dma cost on any page i.e. getting all 4 patches of this
> series reverted. Both tests with net_high_order_alloc_disable set to on
> and off are needed.


I will post a PATCH, let we discuss under that.

Thanks.

>
> Thanks,
> -Siwei
>
> On 8/17/2024 6:20 AM, Xuan Zhuo wrote:
> > Hi, guys, I have a fix patch for this.
> > Could anybody test it?
> >
> > Thanks.
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index af474cc191d0..426d68c2d01d 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2492,13 +2492,15 @@ static unsigned int get_mergeable_buf_len(struct receive_queue *rq,
> >   {
> >          struct virtnet_info *vi = rq->vq->vdev->priv;
> >          const size_t hdr_len = vi->hdr_len;
> > -       unsigned int len;
> > +       unsigned int len, max_len;
> > +
> > +       max_len = PAGE_SIZE - ALIGN(sizeof(struct virtnet_rq_dma), L1_CACHE_BYTES);
> >
> >          if (room)
> > -               return PAGE_SIZE - room;
> > +               return max_len - room;
> >
> >          len = hdr_len + clamp_t(unsigned int, ewma_pkt_len_read(avg_pkt_len),
> > -                               rq->min_buf_len, PAGE_SIZE - hdr_len);
> > +                               rq->min_buf_len, max_len - hdr_len);
> >
> >          return ALIGN(len, L1_CACHE_BYTES);
> >   }
>
