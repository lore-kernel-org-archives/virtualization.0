Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C514554908
	for <virtualization@lists.linux.dev>; Tue,  5 Mar 2024 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638619; cv=none; b=f+S8t4k69ML968RFf3nSzxFKqEa7rQsvDGmYmV42qL6ZtVXww8Jd3+wNNlpfkSVqy07IyzZj8XULZwbOOAp6LMh/dSH4Q0GLgvcJaLOhHOM7og/I382g0H/Az7GC1BvhoChPTeRdY/Z3Q6UyJ9P7n0H+wgCHnaOoCSO01URUKwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638619; c=relaxed/simple;
	bh=POkETsGRbketoDWXsvwDhq3gn8TxqRz5duFUPrt1aNw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jc6YVIQKH2JBsgPJa0QDd5uyGuKhgiRdWZ2/RKeIT+aMPS/ZeBe8UX6nupNf3GICcvO71pa65LIRDqJHxQJy+YLnykd/2sjwU6Km5LjBgxr+IK017ephi1l/Su1p/vDiJjMOgvPvrkhFOuaAyeTvv7H3HHxG4kkeWBn5VtZf86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wr4Xlb38; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wr4Xlb38"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709638609; h=Message-ID:Subject:Date:From:To;
	bh=JO+6AB9KzJnq15c7g9gV2LhFHu7FmUfPL9YGcXxQKUI=;
	b=wr4Xlb381T/rtgFhBsqCUkscRn+yOIMMUtsoUz1dUnX27jv9hsfPP+jME37K0KlNdgFokwPiLnYddpnvXUcIOtERcN253hLje+1l9d4a0eBZZBNgIOvR7ATBOIZ292+MKh974HZwZKbIvYD2RhXnP8anq/Vy+v6AFU9D/wc0Toc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=24;SR=0;TI=SMTPD_---0W1uAS0I_1709638606;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1uAS0I_1709638606)
          by smtp.aliyun-inc.com;
          Tue, 05 Mar 2024 19:36:47 +0800
Message-ID: <1709638595.0478082-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 3/4] virtio: vring_new_virtqueue(): pass struct instead of multi parameters
Date: Tue, 5 Mar 2024 19:36:35 +0800
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
References: <20240304114719.3710-1-xuanzhuo@linux.alibaba.com>
 <20240304114719.3710-4-xuanzhuo@linux.alibaba.com>
 <0cbf4910-ec0c-4b06-681e-aafae3720455@linux.intel.com>
In-Reply-To: <0cbf4910-ec0c-4b06-681e-aafae3720455@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 5 Mar 2024 13:27:25 +0200 (EET), =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com> wrote:
> On Mon, 4 Mar 2024, Xuan Zhuo wrote:
>
> > Just like find_vqs(), it is time to refactor the
> > vring_new_virtqueue(). We pass the similar struct to
> > vring_new_virtqueue.
>
> Please write a proper commit message here and do not just refer to
> some other commit to describe what's going on here.


YES.

Thanks.


>
> --
>  i.
>
