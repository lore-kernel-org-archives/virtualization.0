Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132083B794
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927969; cv=none; b=cDaEaCxZjl1CplsZjdY3a8z0/0BsVjnTzL8EFGwI3R7k+BxfchFk949S0a56P4GiUeUUrp9j/+OJUUM/tFa1VkC/16YbIKrPZh7vDoPCBWoLaA4gfv7ZJdSHRq28Qd01geBmk8rdi3GBzEgHPaN5LIEwX+OO9P2yz55RlCboRYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927969; c=relaxed/simple;
	bh=dLgoIfaTqa8nTP1PGLsxkGjCBSm52im/6G2YUb9BLjg=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=jUpGCPoun0kFdwOVf7Yq7q2LbjqS9DnjLIUvt/d3CS8mii0Dzv2mR9sH73JmiovSiQL0S8nv2do6ApYz6nhRI5JDh+mhN4iYXbUdtibQ5nVlf+XStWiKBVChkpDpbAAdQad1AsLi9fTNbUvd1rpd5ZiBP/e5qNJcItOu5I72fcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bUmE85ho; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bUmE85ho"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710927956; h=Message-ID:Subject:Date:From:To;
	bh=dLgoIfaTqa8nTP1PGLsxkGjCBSm52im/6G2YUb9BLjg=;
	b=bUmE85hoBhrpAS6lMzRQz7u0GsM+dUs+EOSYwVmbqV++ZVQeFtbwp0Kh3dOc9H6Q5LEisMeMF2m4vd53nPImzNPLf5NTpF9njLGC9U5bpFHjAQmg+T7+/Xz2jmz71KoIebo9Q1NRbgzD8zyZs91A6sxsjaKwpBeJmYiAR7qugao=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2wsc.n_1710927953;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2wsc.n_1710927953)
          by smtp.aliyun-inc.com;
          Wed, 20 Mar 2024 17:45:54 +0800
Message-ID: <1710927912.3040364-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Date: Wed, 20 Mar 2024 17:45:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

Hope this in your list.

Thanks.
