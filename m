Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028B6088B
	for <virtualization@lists.linux.dev>; Thu, 29 Feb 2024 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199835; cv=none; b=t4BnIwy+n1KSnihvCy6Gy/18Eb5b28iZiwkMu8X/AtPuXd9vZ3Vbl12atEXO6CvIHyy+Ax8HQNqIAasF7Yt4P1ECJBgZ6eYiLF/ICCp+wNqioEpoNc1iHYaZVaoOt7K6IRBsT2ijkfswvgnQlo3M5x5+xV/GjaJlGBUWrSJdheE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199835; c=relaxed/simple;
	bh=X/vfymhnan3upoVf726nPIc8SXJCCwv4OsemoA6fj3w=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=ELfwXueOh5+9zSnBERSjY6B0Mo/vCMvw1ifw7LDldqZNx/kVaAKat5W9SNWwzPJupCc6RxGZOUmJyMtJ2nKFywSwkmnhRgwEMPmGndmBVa1slnG8y7qnMaKb20d/s5ty5+BBSYMm8tGIoOvlVc/sHK5sQBoCGxBgUu3PL/neiWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FL8YFcIk; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FL8YFcIk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709199831; h=Message-ID:Subject:Date:From:To;
	bh=X/vfymhnan3upoVf726nPIc8SXJCCwv4OsemoA6fj3w=;
	b=FL8YFcIkjtTuVVfANDqDzhAWfgveKdjjP7sD/Xftxg0dCigr1s7Ilblipg9h4GDAXx4nPIhbjPbCpyQGHURQqQy4xMm2g39zTi1Jexp1vovkfacEkxSLcfWqSZFv332WvAsqGg2FKkeJSxvrsRWEB961pHzJbXe2j+NYS4WWB6g=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=34;SR=0;TI=SMTPD_---0W1Sa3HZ_1709199828;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W1Sa3HZ_1709199828)
          by smtp.aliyun-inc.com;
          Thu, 29 Feb 2024 17:43:49 +0800
Message-ID: <1709199778.0187387-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v3 00/19] virtio: drivers maintain dma info for premapped vq
Date: Thu, 29 Feb 2024 17:42:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: virtualization@lists.linux.dev,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?utf-8?q?IlpoJ=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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
 linux-um@lists.infradead.org,
 netdev@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 linux-remoteproc@vger.kernel.org,
 linux-s390@vger.kernel.org,
 kvm@vger.kernel.org,
 bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240229072044.77388-1-xuanzhuo@linux.alibaba.com>
 <20240229031755-mutt-send-email-mst@kernel.org>
 <1709197357.626784-1-xuanzhuo@linux.alibaba.com>
 <20240229043238-mutt-send-email-mst@kernel.org>
 <4825d7812ac06be3322ca4ae74e3650b2b0cd8de.camel@sipsolutions.net>
In-Reply-To: <4825d7812ac06be3322ca4ae74e3650b2b0cd8de.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 29 Feb 2024 10:41:11 +0100, Johannes Berg <johannes@sipsolutions.net> wrote:
> On Thu, 2024-02-29 at 04:34 -0500, Michael S. Tsirkin wrote:
> >
> > So the patchset is big, I guess it will take a couple of cycles to
> > merge gradually.
>
> Could also do patches 7, 8, and maybe 9 separately first (which seem
> reasonable even on their own) and get rid of CC'ing so many people and
> lists for future iterations of the rest of the patchset :-)

I agree.

@Michael How about you?

Thanks


>
> johannes
