Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7BEA35
	for <virtualization@lists.linux.dev>; Mon, 11 Mar 2024 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710123909; cv=none; b=qq/2rGx3R3BQxykUWMp4uUBaSqMqwqdaw8s3mSGbLdnMh61OVwSRwniF72qSK2WGwuhsq80eMXBAaMWfqNQktqfrf5GI+Cx3ObYU7TcnH1I+Or7emTHVWgK0/HfG5o4TbMa5Eiy9Pjgw36eytbISt3vPof2bK+PS3gfGQkq6ngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710123909; c=relaxed/simple;
	bh=Q+YAp+SydATt35XhZXtZHP2qTDIuk+FIlk46vKpyMsQ=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=u6PnCrxae9JBsD+LExDNNqSqthdz4bDBHz5QEl2/pOvbReY8+jGPI9pMhMqkRK5p5pLtqITQmCGq1Hf/QhxqzHffxhxYz0z1drkf7kaanNFVQ/BzyLsRMfjOkqSJaaGk2sTYikbpAZL0pH9LksXYJpXGvu5IFLATcweRbQj/2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vGA1cGpe; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vGA1cGpe"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710123898; h=Message-ID:Subject:Date:From:To;
	bh=IjggKy7HR74Lw2lFaJO8aNhkimYBeigCUfT94zbJh7Y=;
	b=vGA1cGpej+3MrnWBoeHQsr/wgLBXBiWBy+p29cpU3VJaKpS3uZH2FfeA8MHynRllzr6QhTJrefuGAdieT2ZQeoeNaSJEYAqALrK6XQ/GOXhRx/5kA/cYUbgSmKKtUmZzwKLfkBF7xXx8qXI5ed1pK0maknGSUeVPh7BIOe2hj/A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W29MS6c_1710123896;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W29MS6c_1710123896)
          by smtp.aliyun-inc.com;
          Mon, 11 Mar 2024 10:24:57 +0800
Message-ID: <1710123875.2753754-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v1 2/4] virtio: vring_create_virtqueue: pass struct instead of multi parameters
Date: Mon, 11 Mar 2024 10:24:35 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Hans de Goede <hdegoede@redhat.com>,
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
References: <20240306114615.88770-1-xuanzhuo@linux.alibaba.com>
 <20240306114615.88770-3-xuanzhuo@linux.alibaba.com>
 <8f77a787-0bb7-96ad-0dac-f8ef36879ae3@linux.intel.com>
In-Reply-To: <8f77a787-0bb7-96ad-0dac-f8ef36879ae3@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Fri, 8 Mar 2024 12:19:21 +0200 (EET), =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com> wrote:
> On Wed, 6 Mar 2024, Xuan Zhuo wrote:
>
> > Now, we pass multi parameters to vring_create_virtqueue. These parameters
> > may from transport or from driver.
> >
> > vring_create_virtqueue is called by many places.
> > Every time, we try to add a new parameter, that is difficult.
> >
> > If parameters from the driver, that should directly be passed to vring.
> > Then the vring can access the config from driver directly.
> >
> > If parameters from the transport, we squish the parameters to a
> > structure. That will be helpful to add new parameter.
> >
> > Because the virtio_uml.c changes the name, so change the "names" inside
> > the virtio_vq_config from "const char *const *names" to
> > "const char **names".
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Acked-by: Johannes Berg <johannes@sipsolutions.net>
>
> > @@ -60,38 +61,25 @@ struct virtio_device;
> >  struct virtqueue;
> >  struct device;
> >
> > +struct vq_transport_config {
> > +	unsigned int num;
> > +	unsigned int vring_align;
> > +	bool weak_barriers;
> > +	bool may_reduce_num;
> > +	bool (*notify)(struct virtqueue *vq);
> > +	struct device *dma_dev;
> > +};
>
> kerneldoc is missing from this struct too.
>
> It would be generally helpful if you are proactive when somebody comments
> your series by checking if there are similar cases within your series,
> instead of waiting them to be pointed out for you specificly.

Sorry. I missed it.

Will fix in next version.

Thanks


>
> --
>  i.
>
