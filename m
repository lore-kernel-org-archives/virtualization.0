Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674679C2
	for <virtualization@lists.linux.dev>; Wed, 17 Jan 2024 05:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705470927; cv=none; b=YBWTiMHAOThaSOtWbzd5pv9mIgV3NYLP4O2/2LAsysShUDQT+vJtDIEqf3XrLEAH0UPTs1al4P8kVbLsRRvHFzR8eAwbZ/c1ZDA9SgQ7GX4jnso9MhMC2gMiJQiXP2D+mXA+E+yFx/3o56y9/44F/LpY52XLjQvhq7see2wksMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705470927; c=relaxed/simple;
	bh=aakhbWhnRWgzK/sjdw+/ZIoiU7KjVwjzSws1JZD46Zg=;
	h=X-Alimail-AntiSpam:Received:Message-ID:Subject:Date:From:To:Cc:
	 References:In-Reply-To; b=dXinM2WkQGc6/lqCAsKfSHd25OvIKEDkhASsjYc+7fvO18bdIEUE1xfEsgJOzamS3+ailWBpjHhJtrLjAku3qGd6ZuSPEOukUZymcqaLvJOALbaFNwEGT+/DAzp9zO/M7hc4OH8jx2vOuKofJIAOwyIEXSen/AZL5ocxBgmv6jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W-oMYkq_1705470921;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-oMYkq_1705470921)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 13:55:22 +0800
Message-ID: <1705470800.285488-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy (3/3)
Date: Wed, 17 Jan 2024 13:53:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
 <e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
 <20240116070705.1cbfc042@kernel.org>
 <20240116154405-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240116154405-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 16 Jan 2024 15:46:00 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Jan 16, 2024 at 07:07:05AM -0800, Jakub Kicinski wrote:
> > On Tue, 16 Jan 2024 13:37:30 +0100 Paolo Abeni wrote:
> > > For future submission it would be better if you split this series in
> > > smaller chunks: the maximum size allowed is 15 patches.
> >
> > Which does not mean you can split it up and post them all at the same
> > time, FWIW.
>
>
> Really it's just 17 I don't think it matters. Some patches could be
> squashed easily but I think that would be artificial.

Yes. About this patch set I think a lot. This is the core code for the function.
I think we should not split it. And some commits are simply.

Thanks.


>
