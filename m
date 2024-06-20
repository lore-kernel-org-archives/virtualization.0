Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1344715B118
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718881572; cv=none; b=kOuFcbjLC2/U4GUeZNRHtdfOxNAfMBsrWeiQYGbTn3LAimKJjy0jRaOC6x018t8X+QbsQ1Ovds85dy1SKwRg/qlq+aiNZ2kWzamiTnO4IPIZH+AWD9pavaFgOh0TpjtFJQbJO5+SU9eFv/N9rVoeYQSRVkyojcgCUuFuruUaiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718881572; c=relaxed/simple;
	bh=cDnGgPf/RQFLjjxubFv742myrYapE56/7qE+uXYgbPg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=oIygX03h/TRez20cTb0A1n4BZD5JimSwnqDwtZiQvOk7SH1u1xFgKx4dw5RPFPsmeOHRw4CjZksickXtkzrvOcJD/wUi/0+xcBOl60gbXd/GAJp/DMsBJ4wgsAJC4zcRXfGD5Wmu0uLlxKJBM1WSJewpck+a/bNuKDbpbkahiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nuiLcQ+V; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nuiLcQ+V"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718881567; h=Message-ID:Subject:Date:From:To;
	bh=OU8LJN+z4JBfJHzW1KsQNBVFiB3CWUJ4weYWWQZupeM=;
	b=nuiLcQ+VdMx8RFOPFnqpILosyXpderHcHaxu+a5hYeSmcqyuKtCddDNusgA5ntl64ZSfQvp5G6AVLZBEGvyz5bh217b9dKJvjm1gZl1Q7ZAYj82yKv4k8argJYpQZGvnmJoJj2cyRUSEnTuBCzcwBVgv0qEE2WzOKYpKzaYUIpM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068164191;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=26;SR=0;TI=SMTPD_---0W8sK4pP_1718881566;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8sK4pP_1718881566)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 19:06:06 +0800
Message-ID: <1718881448.8979208-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 2/6] virtio: remove support for names array entries being null.
Date: Thu, 20 Jun 2024 19:04:08 +0800
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
 kvm@vger.kernel.org,
 Wei Wang <wei.w.wang@intel.com>
References: <20240424091533.86949-1-xuanzhuo@linux.alibaba.com>
 <20240424091533.86949-3-xuanzhuo@linux.alibaba.com>
 <20240620035749-mutt-send-email-mst@kernel.org>
 <1718872778.4831812-1-xuanzhuo@linux.alibaba.com>
 <20240620044839-mutt-send-email-mst@kernel.org>
 <1718874293.698573-2-xuanzhuo@linux.alibaba.com>
 <20240620054548-mutt-send-email-mst@kernel.org>
 <1718880548.281809-3-xuanzhuo@linux.alibaba.com>
 <20240620065602-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620065602-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 07:02:42 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 06:49:08PM +0800, Xuan Zhuo wrote:
> > On Thu, 20 Jun 2024 06:01:54 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Jun 20, 2024 at 05:04:53PM +0800, Xuan Zhuo wrote:
> > > > On Thu, 20 Jun 2024 05:01:08 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Thu, Jun 20, 2024 at 04:39:38PM +0800, Xuan Zhuo wrote:
> > > > > > On Thu, 20 Jun 2024 04:02:45 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > > > On Wed, Apr 24, 2024 at 05:15:29PM +0800, Xuan Zhuo wrote:
> > > > > > > > commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> > > > > > > > support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> > > > > > > > doesn't apply. And not one uses this.
> > > > > > > >
> > > > > > > > On the other side, that makes some trouble for us to refactor the
> > > > > > > > find_vqs() params.
> > > > > > > >
> > > > > > > > So I remove this support.
> > > > > > > >
> > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > > > Acked-by: Eric Farman <farman@linux.ibm.com> # s390
> > > > > > > > Acked-by: Halil Pasic <pasic@linux.ibm.com>
> > > > > > >
> > > > > > >
> > > > > > > I don't mind, but this patchset is too big already.
> > > > > > > Why do we need to make this part of this patchset?
> > > > > >
> > > > > >
> > > > > > If some the pointers of the names is NULL, then in the virtio ring,
> > > > > > we will have a trouble to index from the arrays(names, callbacks...).
> > > > > > Becasue that the idx of the vq is not the index of these arrays.
> > > > > >
> > > > > > If the names is [NULL, "rx", "tx"], the first vq is the "rx", but index of the
> > > > > > vq is zero, but the index of the info of this vq inside the arrays is 1.
> > > > >
> > > > >
> > > > > Ah. So actually, it used to work.
> > > > >
> > > > > What this should refer to is
> > > > >
> > > > > commit ddbeac07a39a81d82331a312d0578fab94fccbf1
> > > > > Author: Wei Wang <wei.w.wang@intel.com>
> > > > > Date:   Fri Dec 28 10:26:25 2018 +0800
> > > > >
> > > > >     virtio_pci: use queue idx instead of array idx to set up the vq
> > > > >
> > > > >     When find_vqs, there will be no vq[i] allocation if its corresponding
> > > > >     names[i] is NULL. For example, the caller may pass in names[i] (i=4)
> > > > >     with names[2] being NULL because the related feature bit is turned off,
> > > > >     so technically there are 3 queues on the device, and name[4] should
> > > > >     correspond to the 3rd queue on the device.
> > > > >
> > > > >     So we use queue_idx as the queue index, which is increased only when the
> > > > >     queue exists.
> > > > >
> > > > >     Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > > >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > >
> > > >
> > > > That just work for PCI.
> > > >
> > > > The trouble I described is that we can not index in the virtio ring.
> > > >
> > > > In virtio ring, we may like to use the vq.index that do not increase
> > > > for the NULL.
> > > >
> > > >
> > > > >
> > > > > Which made it so setting names NULL actually does not reserve a vq.
> > > > >
> > > > > But I worry about non pci transports - there's a chance they used
> > > > > a different index with the balloon. Did you test some of these?
> > > > >
> > > >
> > > > Balloon is out of spec.
> > > >
> > > > The vq.index does not increase for the name NULL. So the Balloon use the
> > > > continuous id. That is out of spec.
> > >
> > >
> > > I see. And apparently the QEMU implementation is out of spec, too,
> > > so they work fine. And STATS is always on in QEMU.
> > >
> > > That change by Wei broke the theoretical config which has
> > > !STATS but does have FREE_PAGE. We never noticed - not many people
> > > ever bothered with FREE_PAGE.
> > >
> > > However QEMU really is broken in a weird way.
> > > In particular if it exposes STATS but driver does not
> > > configure STATS then QEMU still has the stats vq.
> > > Things will break then.
> > >
> > >
> > > In short, it's a mess, and it needs thought.
> > > At this point I suggest we keep the ability to set
> > > names to NULL in case we want to just revert Wei's patch.
> > >
> > >
> > >
> > > > That does not matter for this patchset.
> > > > The name NULL is always skipped.
> > > >
> > > > Thanks.
> > >
> > >
> > > Let's keep this patchset as small as possible.
> > > Keep the existing functionality, we'll do cleanups
> > > later.
> >
> >
> > I am ok. But we need a idx to index the info of the vq.
> >
> > How about a new element "cfg_idx" to virtio_vq_config.
> >
> > struct virtio_vq_config {
> > 	unsigned int nvqs;
> > ->	unsigned int cfg_idx;
> >
> > 	struct virtqueue   **vqs;
> > 	vq_callback_t      **callbacks;
> > 	const char         **names;
> > 	const bool          *ctx;
> > 	struct irq_affinity *desc;
> > };
> >
> >
> > That is setted by transport. The virtio ring can use this to index the info
> > of the vq. Then the #1 #2 commits can be dropped.
> >
> >
> > Thanks.
> >
>
> I'm not sure why you need this in the API.
>
>
> Actually now I think about it, the whole struct is weird.
> I think nvqs etc should be outside the struct.
> All arrays are the same size, why not:
>
> struct virtio_vq_config {
>  	vq_callback_t      callback;
>  	const char         *name;
>  	const bool          ctx;
> };
>
> And find_vqs should get an array of these.
> Leave the rest of params alone.


YES, this is great.

I thought about this.

The trouble is that all the callers need to be changed.
That are too many.

Thanks.


>
>
> >
> > >
> > >
> > > > > --
> > > > > MST
> > > > >
> > >
>
