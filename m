Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD5C4696
	for <virtualization@lists.linux.dev>; Mon,  1 Apr 2024 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711941016; cv=none; b=GKupItnLNnl4Vhz649vQ2ghKMrQaPufasq+NQlW7bIqJWyUtJWvqPGCGc2k5heX4sLz4h2LQ8VZ7VYOgzdi1g+DVBGbRNJ7EYrFUA46TSxeZGJM3DFRgJJV3STtqMOPqo70pq6Sn/vC8lQKUG0alKQQHiHwRdja6AUl37vnxiXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711941016; c=relaxed/simple;
	bh=5rD5pYwEBPF9mnrp6IGl9JPh+Hr+NE4RH/8JaLR//TY=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=VGjkT1+1dIh8khq3Wg9+jTE7+qJHOEGpdoPLHYfwJRdzKNmaAavvUBf4ZMWqUqRCcxoVRMqUnCOmGvlTTuOdxNCG1j1uDbjoFukcYJ7wlDwddl5JzUHroOHK6xGVEcC0OumWCGvUNgPJ9tsYvvrPlE6LzFarg0npxQHaPYaVmx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FS3P0bYa; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FS3P0bYa"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711941006; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=5rD5pYwEBPF9mnrp6IGl9JPh+Hr+NE4RH/8JaLR//TY=;
	b=FS3P0bYa4nS2TalrqFlsRAQh2r3f0sbCAKLTNlLws0ezS3oe9Ea3vq/+++QG21zBkbDTgbRouzXEYmm+4HCiZ8cDSRwL2LkTdyGdFZeL/2rnBEBzJWu+FD+TprslDIisxtYUGuni7kXYDfHTZHNKn8A3/JPYFlz5NsI/ePXcwm8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3dgpyi_1711941003;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3dgpyi_1711941003)
          by smtp.aliyun-inc.com;
          Mon, 01 Apr 2024 11:10:03 +0800
Message-ID: <1711940418.2573907-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 09/10] virtio_net: set premapped mode by find_vqs()
Date: Mon, 1 Apr 2024 11:00:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>
References: <20240327111430.108787-1-xuanzhuo@linux.alibaba.com>
 <20240327111430.108787-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEs=NZGkkA7ye0wY7YcPBPfbKkYq84KCRX1gS0e=bZDX-w@mail.gmail.com>
 <1711614157.5913072-7-xuanzhuo@linux.alibaba.com>
 <CACGkMEuBhfMwrfaiburLG7gFw36GuVHSbRTtK+FycrGFVTgOcA@mail.gmail.com>
 <1711935607.4691076-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1711935607.4691076-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 1 Apr 2024 09:40:07 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> w=
rote:
> On Fri, 29 Mar 2024 11:20:08 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> > On Thu, Mar 28, 2024 at 4:27=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Thu, 28 Mar 2024 16:05:02 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Wed, Mar 27, 2024 at 7:14=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > Now, the virtio core can set the premapped mode by find_vqs().
> > > > > If the premapped can be enabled, the dma array will not be
> > > > > allocated. So virtio-net use the api of find_vqs to enable the
> > > > > premapped.
> > > > >
> > > > > Judge the premapped mode by the vq->premapped instead of saving
> > > > > local variable.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > >
> > > > I wonder what's the reason to keep a fallback when premapped is not=
 enabled?
> > >
> > > Rethink this.
> > >
> > > I think you are right. We can remove the fallback.
> > >
> > > Because we have the virtio dma apis that wrap all the cases.
> > > So I will remove the fallback from the virtio-net in next version.
> >
> > Ok.
> >
> > >
> > > But we still need to export the premapped to the drivers.
> > > Because we can enable the AF_XDP only when premapped is true.
> >
> > I may miss something but it should work like
> >
> > enable AF_XDP -> enable remapping
> >
> > So can we fail during remapping enablement?
>
>
> YES.
>
> Enabling the premapped mode may fail, then we must stop to enable AF_XDP.
>
> AF-XDP requires that we export the dma dev to the af-xdp.
> We can do that only when the virtio core works with use_dma_api.
> Other other side, if we support the page-pool in future, we may have the
> same requirement.

Rethink this.

Enable premapped MUST NOT fail. No care the use_dma_api is true or not, bec=
ause
we have the DMA APIs for virtio. Then the virtio-net rx will work with
premapped (I will make the big mode work with premapped mode)

AF_XDP checks the virtqueue_dma_dev() when enabling.

But disabling premapped mode may fail, because that virtio ring need to
allocate memory for dma.

Thanks.



>
>
> Thanks.
>
>
> >
> > THanks
> >
> > >
> > > Thanks
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
>
