Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DEE14AB0
	for <virtualization@lists.linux.dev>; Fri, 15 Mar 2024 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710490257; cv=none; b=i2/Q7wfFhYGRRaYlrLkQCPiJ42LFOWR9Bsh/z5o/dTVis+5zjXEAGBx2AqKQ/EsPD+I7Lj4jQtQlywkYZZ4Q95vHX+Ck+TLh7BKjA4fNwoXHSu7OzBojdm20SGr4Qw/SGJmxUtaQtKrZdWjZBM9gMiplCFkg6jd1lhnpUD7YKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710490257; c=relaxed/simple;
	bh=hf/7tzQiNSvYmFuA/yKuj1fm3A4gA/3hedPkcZLXEe8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=aJPIUA5a9/OVdrjkK8lC2XSuC4Xy3CDfGZ1pWie/VtryFmU/spr6g+Yr/y+7Zv6FAHczXj82pK4VlXwynxoR29hdMVQUm/cwi0rJvvfvWTvMphW6G970WaZrpOKv/CFlYootMqnCJiuHJ7DBx2bPwBItofUgNg6nD0efTC4q1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fYXNmJWp; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fYXNmJWp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710490251; h=Message-ID:Subject:Date:From:To;
	bh=hf/7tzQiNSvYmFuA/yKuj1fm3A4gA/3hedPkcZLXEe8=;
	b=fYXNmJWplcKF5W2UnPUwG8wBfUOtbby51EA29jlCTX4AUdPfQvQZX+jYjlycW3ntVgfyX7P4eHccM7eVAkx4Wa+5sooe1KEWSKdOPOmP9Eitntb/MkNR8QfV7i0JMB/WeaUp5KhIA5YSHPaj6SWGXjEXNRINsieTWZhNxICvtKo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2ViqTo_1710490249;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2ViqTo_1710490249)
          by smtp.aliyun-inc.com;
          Fri, 15 Mar 2024 16:10:50 +0800
Message-ID: <1710489940.1772969-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 3/8] virtio_net: support device stats
Date: Fri, 15 Mar 2024 16:05:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric  Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S.  Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei  Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha  Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
 <20240314085459.115933-4-xuanzhuo@linux.alibaba.com>
 <20240314155425.74b8c601@kernel.org>
In-Reply-To: <20240314155425.74b8c601@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 14 Mar 2024 15:54:25 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 14 Mar 2024 16:54:54 +0800 Xuan Zhuo wrote:
> > make virtio-net support getting the stats from the device by ethtool -S
> > <eth0>.
> >
> > Due to the numerous descriptors stats, an organization method is
> > required. For this purpose, I have introduced the "virtnet_stats_map".
> > Utilizing this array simplifies coding tasks such as generating field
> > names, calculating buffer sizes for requests and responses, and parsing
> > replies from the device. By iterating over the "virtnet_stats_map,"
> > these operations become more streamlined and efficient.
>
> Don't duplicate the stats which get reported via the netlink API in
> ethtool. Similar story to the rtnl stats:
>
> https://docs.kernel.org/next/networking/statistics.html#notes-for-driver-authors

Sorry, this patch set did not follow this.

I will fix in next version.

But I plan that will be done in the commit "virtio-net: support queue stat".
This commit in next version will report all stat by ethtool -S.
The commit "virtio-net: support queue stat" in next version
will not report the duplicate the stats that reported via the netlink API.

Do you think ok?

Thanks.







