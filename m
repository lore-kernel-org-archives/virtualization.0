Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC57D23765
	for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711523776; cv=none; b=teaMHBKG2kkftWqr76nqr16mFHL0GeGCgBqgFSKzbJmml+/zXjgTVx2yTIm6uDG2d+rS8c7FhVgX4BwSA5o0QkOx9JU3BvoS/Xo6yXUq8WkCq9vjh0J6DeMv0Glp3h4I5UccK5qYbieqoxAVf0dUGyWMK7zOkfYeUKWMzVS2zEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711523776; c=relaxed/simple;
	bh=kDdm8hEYohfXelRrmZggLCcWeFW6IOJLlADSDE4d4CE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=B0ix2Me/6fnWMr+O7oXsZsdN4G/7AFWiaMZtKbGyLrE8Ve53n4FlMbydmwfLRDskrtUyyNH9Ycq+ZJwIDQaMmuAj1PExIjg3e0hsONJEcp3zGu/2Gi8Ce9j2fJE0w2sgLTQ6YxSbrhooOkB0+LfiqqFsbEEfvDa4w4A7hfK28Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gNzw/h+/; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gNzw/h+/"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711523773; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=oWppE/QA18ZHv4BeAUEMpkgtAUE7wCmySEaGiLBMekQ=;
	b=gNzw/h+/coOwErp7ZlAFDdYE3/i5Tr+1Q1ZVJzNYr3E2WtEjnr44d8t/vCr4VMTZA3rJ12jIWvBZSs8YOdbqSPOWD7xkHRW+j7yvMzl8DwDDOVDTUS+lo8VfskRksJP1ongfFEwmOFYlAGPIStNwi1MypmhiM2pvkHxwt4sSjdI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W3NsP.d_1711523771;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3NsP.d_1711523771)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 15:16:12 +0800
Message-ID: <1711523698.8996527-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v5 00/10] virtio: drivers maintain dma info for premapped vq
Date: Wed, 27 Mar 2024 15:14:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEtEWCjb8+Zcfizij2+0ef-wb8YJD2bfyAvP_72hKZrGvA@mail.gmail.com>
In-Reply-To: <CACGkMEtEWCjb8+Zcfizij2+0ef-wb8YJD2bfyAvP_72hKZrGvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 26 Mar 2024 14:35:21 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Mon, Mar 25, 2024 at 4:54=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > As discussed:
> >
> > http://lore.kernel.org/all/CACGkMEvq0No8QGC46U4mGsMtuD44fD_cfLcPaVmJ3rH=
YqRZxYg@mail.gmail.com
> >
> > If the virtio is premapped mode, the driver should manage the dma info =
by self.
> > So the virtio core should not store the dma info. We can release the me=
mory used
> > to store the dma info.
> >
> > For virtio-net xmit queue, if the virtio-net maintains the dma info,
> > the virtio-net must allocate too much memory(19 * queue_size for per-qu=
eue), so
> > we do not plan to make the virtio-net to maintain the dma info by defau=
lt. The
> > virtio-net xmit queue only maintain the dma info when premapped mode is=
 enable
> > (such as AF_XDP is enable).
> >
> > So this patch set try to do:
> >
> > 1. make the virtio core to do not store the dma info when driver can do=
 that
> >     - But if the desc_extra has not dma info, we face a new question,
> >       it is hard to get the dma info of the desc with indirect flag.
> >       For split mode, that is easy from desc, but for the packed mode,
> >       it is hard to get the dma info from the desc. And hardening
> >       the dma unmap is safe, we should store the dma info of indirect
> >       descs when the virtio core does not store the bufer dma info.
> >
> >       The follow patches to this:
> >          * virtio_ring: packed: structure the indirect desc table
> >          * virtio_ring: split: structure the indirect desc table
> >
> >     - On the other side, in the umap handle, we mix the indirect descs =
with
> >       other descs. That make things too complex. I found if we we disti=
nguish
> >       the descs with VRING_DESC_F_INDIRECT before unmap, thing will be =
clearer.
> >
> >       The follow patches do this.
> >          * virtio_ring: packed: remove double check of the unmap ops
> >          * virtio_ring: split: structure the indirect desc table
> >
> > 2. make the virtio core to enable premapped mode by find_vqs() params
> >     - Because the find_vqs() will try to allocate memory for the dma in=
fo.
> >       If we set the premapped mode after find_vqs() and release the
> >       dma info, that is odd.
> >
> >
> > Please review.
> >
> > Thanks
>
> This doesn't apply cleany on vhost.git linux-next branch.
>
> Which tree is this based on?


Sorry. That is on the top of "[PATCH vhost v5 0/6] refactor the params of
find_vqs()".

Lore-URL: http://lore.kernel.org/all/20240325090419.33677-1-xuanzhuo@linux.=
alibaba.com

Thanks.

>
> Thanks
>
