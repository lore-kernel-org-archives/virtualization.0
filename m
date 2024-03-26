Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEBD12AAE6
	for <virtualization@lists.linux.dev>; Tue, 26 Mar 2024 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437621; cv=none; b=ag+AlQZk4ehqeZfu4zlhsjDbznxDDtniIzbmCG/AoiL5XuZZpeSiDJNdgEG9pYAyIOo9SK/afjy6JC0R1X0YEHfvmTei9ABy8FzcNVEFY81C/PYRiWR9/6sdIFqJVXQkscb+s1UaLp6F4KYtrBHv9a27Co05iUz7G3rBqujddF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437621; c=relaxed/simple;
	bh=RsJ7VrEEuAn7tTwwGnJRLnr1CsxYZKR6Kh8SviuJHh8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=HmJqa7Xy+TbJLE/gl8AGacCUziNt4TgvXLswFxex3aBVT0le5JRAaBDbXhzUHph2kM9VGQaXYPQITaxUqsIhDWmKdd5k7YiK7KPXHNAcPTmTChizO+4Kb+ax82KuzioL+aVkfu3wZNf4a4aib2nrXGmDEIAVFXQvw0nQds1n5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KT4pOrc4; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KT4pOrc4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711437611; h=Message-ID:Subject:Date:From:To;
	bh=q4Y2Cxq3/mRKaUI5wDBHgLNzWvAkhTGSKamX46lAkos=;
	b=KT4pOrc4iA2HUOk2st43NShxqaxM58XT1wY/+2hg5KzHH1BDlnFCu7/s6V2Bk+EWq7ht+91Ino000R/7QrZxqUA/p/xesfPFPrzGRkDk54LrOOibDNz11lppUqG4L13QNmHCjl4XbUGrWEpcrSVa4Hx8rN5Wj+p3sVYteA0oJJE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=25;SR=0;TI=SMTPD_---0W3KMgO7_1711437609;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3KMgO7_1711437609)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 15:20:10 +0800
Message-ID: <1711437558.7066448-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v5 1/6] virtio_balloon: remove the dependence where names[] is null
Date: Tue, 26 Mar 2024 15:19:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Cc: Richard Weinberger <richard@nod.at>,
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 linux-um@lists.infradead.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240325090419.33677-1-xuanzhuo@linux.alibaba.com>
 <20240325090419.33677-2-xuanzhuo@linux.alibaba.com>
 <1b5123f9-6fd8-4783-aec7-5cc5507ee3b4@redhat.com>
In-Reply-To: <1b5123f9-6fd8-4783-aec7-5cc5507ee3b4@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 25 Mar 2024 10:12:51 +0100, David Hildenbrand <david@redhat.com> wrote:
> On 25.03.24 10:04, Xuan Zhuo wrote:
> > Currently, the init_vqs function within the virtio_balloon driver relies
> > on the condition that certain names array entries are null in order to
> > skip the initialization of some virtual queues (vqs). This behavior is
> > unique to this part of the codebase. In an upcoming commit, we plan to
> > eliminate this dependency by removing the function entirely. Therefore,
> > with this change, we are ensuring that the virtio_balloon no longer
> > depends on the aforementioned function.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   drivers/virtio/virtio_balloon.c | 46 +++++++++++++--------------------
> >   1 file changed, 18 insertions(+), 28 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > index 1f5b3dd31fcf..8409642e54d7 100644
> > --- a/drivers/virtio/virtio_balloon.c
> > +++ b/drivers/virtio/virtio_balloon.c
> > @@ -531,49 +531,39 @@ static int init_vqs(struct virtio_balloon *vb)
> >   	struct virtqueue *vqs[VIRTIO_BALLOON_VQ_MAX];
> >   	vq_callback_t *callbacks[VIRTIO_BALLOON_VQ_MAX];
> >   	const char *names[VIRTIO_BALLOON_VQ_MAX];
> > -	int err;
> > +	int err, nvqs = 0, idx = 0;
>
> Re-reading, you could just use a single variable for both purposes.

OK. Will update in next version.

Thanks.


>
> Assuming I didn't miss a functional change
>
> Acked-by: David Hildenbrand <david@redhat.com>
>
> --
> Cheers,
>
> David / dhildenb
>
