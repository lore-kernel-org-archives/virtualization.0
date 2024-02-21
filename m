Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17C4481AD
	for <virtualization@lists.linux.dev>; Wed, 21 Feb 2024 11:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515721; cv=none; b=c3E8TdCOzsZpxdcLgealeRrBdQWqYLmsxiZZyUcef2dFPmWfLpifDlLL4qqxxuuOzqjqDL5iKhIdLL4yqIqMyEjKp+/EIvND+vOEB+4J8U0qpHqrZ983SUFRripIGGv8sHGVOjUAmyZxFcbV1NBkYSJzYnyTItbpxGhvzmrl058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515721; c=relaxed/simple;
	bh=ILaW+tmU19Hc2hM6tJl9+D6rdU+hAvnyjOgyR8UveG4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ltsGiDObFXUA4jE8fQAJEbP73BRCgjhrVpYH5u2r1til8U6kR6kRbCyybTnl7hULrIxrxHenDB4ULDCUXDq2+en9qLJNYIS16vf30jIHPrG02hV6DGF6u1ggSSpJ5IBBCR4XkgTfTYB+UjMYiK7nyDB692YSjcqlPwh8CTAx+TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QneGEIeJ; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QneGEIeJ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708515709; h=Message-ID:Subject:Date:From:To;
	bh=0phsHgifgaYaoJTCL91u0y1uTS0FvlbXLUwQ30Yr5i8=;
	b=QneGEIeJXIpMpaLXE6ZxGwFfr1l0qipg0DZzqwX2RD3yNtbDjcLG6RLa4jzJKxsGQXpfm0cJ3S0/mWvPyEvciRLImyCOaHAK+Ahmo0//g5U4JoBhfhfiW3LLW/VOwE31+zAOaLB6x3800StsQOA1H925x48wem+s05/ymdyWOvI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W0zjbGX_1708515708;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W0zjbGX_1708515708)
          by smtp.aliyun-inc.com;
          Wed, 21 Feb 2024 19:41:49 +0800
Message-ID: <1708515555.2820647-2-xuanzhuo@linux.alibaba.com>
Subject: Re: RE: [PATCH net-next 1/2] xsk: Remove non-zero 'dma_page' check in xp_assign_dev
Date: Wed, 21 Feb 2024 19:39:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: wangyunjian <wangyunjian@huawei.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 xudingke <xudingke@huawei.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "magnus.karlsson@intel.com" <magnus.karlsson@intel.com>
References: <1706089058-1364-1-git-send-email-wangyunjian@huawei.com>
 <1708509152.9501102-1-xuanzhuo@linux.alibaba.com>
 <0fce8b64808f4c6faa0eb60e44687c36@huawei.com>
In-Reply-To: <0fce8b64808f4c6faa0eb60e44687c36@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 21 Feb 2024 11:37:22 +0000, wangyunjian <wangyunjian@huawei.com> wrote:
> > -----Original Message-----
> > From: Xuan Zhuo [mailto:xuanzhuo@linux.alibaba.com]
> > Sent: Wednesday, February 21, 2024 5:53 PM
> > To: wangyunjian <wangyunjian@huawei.com>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> > kvm@vger.kernel.org; virtualization@lists.linux.dev; xudingke
> > <xudingke@huawei.com>; wangyunjian <wangyunjian@huawei.com>;
> > mst@redhat.com; willemdebruijn.kernel@gmail.com; jasowang@redhat.com;
> > kuba@kernel.org; davem@davemloft.net; magnus.karlsson@intel.com
> > Subject: Re: [PATCH net-next 1/2] xsk: Remove non-zero 'dma_page' check in
> > xp_assign_dev
> >
> > On Wed, 24 Jan 2024 17:37:38 +0800, Yunjian Wang
> > <wangyunjian@huawei.com> wrote:
> > > Now dma mappings are used by the physical NICs. However the vNIC maybe
> > > do not need them. So remove non-zero 'dma_page' check in
> > > xp_assign_dev.
> >
> > Could you tell me which one nic can work with AF_XDP without DMA?
>
> TUN will support AF_XDP Tx zero-copy, which does not require DMA mappings.


Great. Though I do not know how it works, but I think a new option or feature
is better.

Thanks.


>
> Thanks
>
> >
> > Thanks.
> >
> >
> > >
> > > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> > > ---
> > >  net/xdp/xsk_buff_pool.c | 7 -------
> > >  1 file changed, 7 deletions(-)
> > >
> > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c index
> > > 28711cc44ced..939b6e7b59ff 100644
> > > --- a/net/xdp/xsk_buff_pool.c
> > > +++ b/net/xdp/xsk_buff_pool.c
> > > @@ -219,16 +219,9 @@ int xp_assign_dev(struct xsk_buff_pool *pool,
> > >  	if (err)
> > >  		goto err_unreg_pool;
> > >
> > > -	if (!pool->dma_pages) {
> > > -		WARN(1, "Driver did not DMA map zero-copy buffers");
> > > -		err = -EINVAL;
> > > -		goto err_unreg_xsk;
> > > -	}
> > >  	pool->umem->zc = true;
> > >  	return 0;
> > >
> > > -err_unreg_xsk:
> > > -	xp_disable_drv_zc(pool);
> > >  err_unreg_pool:
> > >  	if (!force_zc)
> > >  		err = 0; /* fallback to copy mode */
> > > --
> > > 2.33.0
> > >
> > >
