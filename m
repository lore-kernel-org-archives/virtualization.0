Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A144C81
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874712; cv=none; b=hAwvuytceh1385kntoAh2m9PpdkO2v3sIbS5N4K4gu1zk/vci2rLsXHXYRMN46KpA/2Q+v4xlLMgp3WP9En0NirF8X3Vbh0ilaMAic9JERJMUmgspfagRuQMuaoCr19wkUktd2tOfojbEYzkw1Gk+UEBdtCxowP8NpAomvaGdCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874712; c=relaxed/simple;
	bh=cIfjJc07P7y5qrEZM0vHd+Xvm525eNjmn4ELStGOJU4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=EJvbR7urC2a9NrEZfoP9FO2jCltWxlMrLpDOaTsnqjKFB742vc2LvL9J2qdtqmA0mJZ/a31BVZ6n8AEssWCAnoTXuP/WViSQZcHcnpQZTKPNdiRUqownp8NvFGIQa3x5+3UIW2V4o0dFEQMfho8PUrR253dxrwVrdMzI6UFQApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P/LD5WN3; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P/LD5WN3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718874707; h=Message-ID:Subject:Date:From:To;
	bh=CGkxrn4agaW0Vr5vpXzC42/97aB1jmaKYDnBMSSUceQ=;
	b=P/LD5WN3xoaip96QY13bRkturOYCAgbhW0qp2soutxAshz8yNSnWrneKZycgKCgWBgRhZ3PIfA5FycCP1ZMHSzMzRXlH/wIvqShTprOMzXWoMeziK2d7ZAwYeKRJEmFGhIbcCEFJbpNy3aE4cKjX2ogNsvwczGkAovGYRW0PhL4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W8rElt4_1718874705;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8rElt4_1718874705)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 17:11:46 +0800
Message-ID: <1718874293.698573-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 2/6] virtio: remove support for names array entries being null.
Date: Thu, 20 Jun 2024 17:04:53 +0800
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
 <20240424091533.86949-3-xuanzhuo@linux.alibaba.com>
 <20240620035749-mutt-send-email-mst@kernel.org>
 <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
 <20240620044839-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620044839-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 05:01:08 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 04:39:38PM +0800, Xuan Zhuo wrote:
> > On Thu, 20 Jun 2024 04:02:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Apr 24, 2024 at 05:15:29PM +0800, Xuan Zhuo wrote:
> > > > commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> > > > support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> > > > doesn't apply. And not one uses this.
> > > >
> > > > On the other side, that makes some trouble for us to refactor the
> > > > find_vqs() params.
> > > >
> > > > So I remove this support.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > Acked-by: Eric Farman <farman@linux.ibm.com> # s390
> > > > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> > >
> > >
> > > I don't mind, but this patchset is too big already.
> > > Why do we need to make this part of this patchset?
> >
> >
> > If some the pointers of the names is NULL, then in the virtio ring,
> > we will have a trouble to index from the arrays(names, callbacks...).
> > Becasue that the idx of the vq is not the index of these arrays.
> >
> > If the names is [NULL, "rx", "tx"], the first vq is the "rx", but index of the
> > vq is zero, but the index of the info of this vq inside the arrays is 1.
>
>
> Ah. So actually, it used to work.
>
> What this should refer to is
>
> commit ddbeac07a39a81d82331a312d0578fab94fccbf1
> Author: Wei Wang <wei.w.wang@intel.com>
> Date:   Fri Dec 28 10:26:25 2018 +0800
>
>     virtio_pci: use queue idx instead of array idx to set up the vq
>
>     When find_vqs, there will be no vq[i] allocation if its corresponding
>     names[i] is NULL. For example, the caller may pass in names[i] (i=4)
>     with names[2] being NULL because the related feature bit is turned off,
>     so technically there are 3 queues on the device, and name[4] should
>     correspond to the 3rd queue on the device.
>
>     So we use queue_idx as the queue index, which is increased only when the
>     queue exists.
>
>     Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

That just work for PCI.

The trouble I described is that we can not index in the virtio ring.

In virtio ring, we may like to use the vq.index that do not increase
for the NULL.


>
> Which made it so setting names NULL actually does not reserve a vq.
>
> But I worry about non pci transports - there's a chance they used
> a different index with the balloon. Did you test some of these?
>

Balloon is out of spec.

The vq.index does not increase for the name NULL. So the Balloon use the
continuous id. That is out of spec.

That does not matter for this patchset.
The name NULL is always skipped.

Thanks.

> --
> MST
>
