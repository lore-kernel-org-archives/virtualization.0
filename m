Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1E3A1D9
	for <virtualization@lists.linux.dev>; Thu,  1 Feb 2024 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706757590; cv=none; b=jglWGovUlPtEWCuk8UDAGx820mSdCyCM5tD+E25Lu9B00/AD6kZ3CmF6fjkuHzVAuJNw8GL1BtzzQf63bbEBH0BVcEL7w2kac78rq/723hm6Ppa2ap7sxhz15m429iHXu6CTULLfEfxTj03AwNexQxkn0usdVcppbdUqp9zLhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706757590; c=relaxed/simple;
	bh=PLhFLSirN3zIM/Dl1SY9Z1UcGt6Zg3JBMDy6mgyyODA=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=eMcdrG7H72MZ+cbGmtnKiZ8pUwaH3NxdN8t0pvu3Cx3FB7EX+WlJ5UQAC/+woFfCXaE0fp50RjrlJE9O2riKe9cEULzs9motQ0ZIkOFDvx4SXAKG85Dp+TCyzPaLkhn93xDvfoomGtWUAr4D7DyIdPZpzztdXtoxzV18g6cSjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bO+msRE7; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bO+msRE7"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706757585; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=PLhFLSirN3zIM/Dl1SY9Z1UcGt6Zg3JBMDy6mgyyODA=;
	b=bO+msRE7cnGpsoweN6yZmJdWuWiosg+E1bUhQFlSV4rCF9PnuhHdr6w+pkZ1qpx2SVhqWcPuuzEFpQWbHr8jyvstZR9JZB8P8IzyRcHVpc+wrD7hg/x8Df1e+gR05YMvSC2WEg9wS9ZvAm0uQN5omuCN4Os2xEJ9GXIDvJ4fi+Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=36;SR=0;TI=SMTPD_---0W.mW7Yb_1706757582;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.mW7Yb_1706757582)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 11:19:43 +0800
Message-ID: <1706757435.040749-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 11/17] virtio_ring: export premapped to driver by struct virtqueue
Date: Thu, 1 Feb 2024 11:17:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
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
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Benjamin Berg <benjamin.berg@intel.com>,
 Yang Li <yang.lee@linux.alibaba.com>,
 linux-um@lists.infradead.org,
 netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-12-xuanzhuo@linux.alibaba.com>
 <CACGkMEtWt1ROwJCeEa5FbQfxV2eqo0xRqHQZMsq-Q2TcQBur9g@mail.gmail.com>
In-Reply-To: <CACGkMEtWt1ROwJCeEa5FbQfxV2eqo0xRqHQZMsq-Q2TcQBur9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 31 Jan 2024 17:12:43 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 30, 2024 at 7:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > Export the premapped to drivers, then drivers can check
> > the vq premapped mode after the find_vqs().
>=20
> This looks odd, it's the charge of the driver to set premapped, so it
> should know it?

If the use_dma_api is false, we can not enable the premapped mode.
Though we wrapped dma apis, but the AF_XDP use the default dma api directly.
As we discussed, we just work in premapped mode when the use_dma_api is tru=
e.

Thanks.


>=20
> Thanks
>=20
