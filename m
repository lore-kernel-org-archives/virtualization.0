Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757D44C81
	for <virtualization@lists.linux.dev>; Thu, 20 Jun 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875376; cv=none; b=hwZBY8VbuYZvre4FqH0SK9+sYxDBjxrrt8ejSs6fXW6aLgxkMNxuvJtvec6ZvJo1SkFklr6TBJql5CbUQyilwjq2s6ZKAze/lSrgPx2f/HJfg/1WYDFFAahvz/zzA/fBkIob74C+if4xYVjmYw1r/O0sSBPut3j4wS0v3Ig/Fjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875376; c=relaxed/simple;
	bh=0NDh1twCkDYHtf9esiX7Ztx85TJA3bCRvkBv9woillc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=VMsge6UFZSjke/UFbH0/A3OlG98+RhuFge0Nf3E1NrNHoXgESksKHYvCG9X+hkaE2KmD0qupDbBQXRxtVnHNPFyGyGpIKhAdsuhF/EX8GxhbH5rt2lf+C+phkM93Ri1gOHdBrmtwBGMc4J/x+5C2IrTEtI81dA/6uImcwKIUV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dgdEfTw3; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dgdEfTw3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718875371; h=Message-ID:Subject:Date:From:To;
	bh=c2UyGUAnU9MppByM5/160z/h1FZQF4H8b3fhx9biUXw=;
	b=dgdEfTw3BnP+ksa9YEGksZdK+WpT73q6xB+nWtHmC/POBtgTinmLBTpf3bV0v1TLXbhodxCvICbVY1aAz6dJ/nXAhEKMlj7aMR6BeabX8h1+aOjRBQEenNlHPdsJ1DTwnEQrC5gWT8RjtrIz9MBRRzyG3qQ6d+W3XFoFpRhCiA4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W8rDkyX_1718875370;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8rDkyX_1718875370)
          by smtp.aliyun-inc.com;
          Thu, 20 Jun 2024 17:22:50 +0800
Message-ID: <1718875249.1787696-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v9 3/6] virtio: find_vqs: pass struct instead of multi parameters
Date: Thu, 20 Jun 2024 17:20:49 +0800
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
 <20240424091533.86949-4-xuanzhuo@linux.alibaba.com>
 <20240620034823-mutt-send-email-mst@kernel.org>
 <1718874049.457552-1-xuanzhuo@linux.alibaba.com>
 <20240620050545-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240620050545-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 20 Jun 2024 05:14:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Thu, Jun 20, 2024 at 05:00:49PM +0800, Xuan Zhuo wrote:
> > > > @@ -226,21 +248,37 @@ struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
> > > >
> > > >  static inline
> > > >  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
> > > > -			struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > -			const char * const names[],
> > > > -			struct irq_affinity *desc)
> > > > +		    struct virtqueue *vqs[], vq_callback_t *callbacks[],
> > > > +		    const char * const names[],
> > > > +		    struct irq_affinity *desc)
> > > >  {
> > > > -	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
> > > > +	struct virtio_vq_config cfg = {};
> > > > +
> > > > +	cfg.nvqs = nvqs;
> > > > +	cfg.vqs = vqs;
> > > > +	cfg.callbacks = callbacks;
> > > > +	cfg.names = (const char **)names;
> > >
> > >
> > > Casting const away? Not safe.
> >
> >
> >
> > Because the vp_modern_create_avq() use the "const char *names[]",
> > and the virtio_uml.c changes the name in the subsequent commit, so
> > change the "names" inside the virtio_vq_config from "const char *const
> > *names" to "const char **names".
>
> I'm not sure I understand which commit you mean,
> and this kind of change needs to be documented, but it does not matter.
> Don't cast away const.


Do you mean change the virtio_find_vqs(), from
const char * const names[] to const char *names[].

And update the caller?

If we do not cast the const, we need to update all the caller to remove the
const.

Right?

Thanks.

>
> --
> MST
>
