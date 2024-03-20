Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB2038DE1
	for <virtualization@lists.linux.dev>; Wed, 20 Mar 2024 08:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922380; cv=none; b=FiUkdk7+86Bt5hHGEF+8itwxQkZ4jczaVN1sdWsKSjI3tPLlgOcwXpO51RRy1/xOfB8mrqem+Ro6d94BoGv7Z1M17BcSQ4YB/cA3JeTkCLkS9BtKvSs6+Z8K63fQ6OUPfvkBsJoiTN60qp4A/1eQz5UfMoEmkVZ6QOK4VEmib54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922380; c=relaxed/simple;
	bh=fHOlSCvGtV0ncCDqa3WflXyXb/dBKkEIXLDLn460Lak=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=WJ15UOXbQW9iPgmNncU5iExv8mGOV2tzA48hcP7oYCnSVwJqEaT0IA0+KzwB2pdOIZCIR2bvrD2fg2HFGxtkJFhDfDMBj8Q3zWNpCgxwCJs1ZPrIH7/G3VMJ4cvrtjWC54lu5XeuUWTy4BynV1vaGCKWZL8GmFHTrG3p3+RuX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tfnt6xZk; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tfnt6xZk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710922371; h=Message-ID:Subject:Date:From:To;
	bh=fHOlSCvGtV0ncCDqa3WflXyXb/dBKkEIXLDLn460Lak=;
	b=tfnt6xZkDnjunZbrvMMz0j+73zBHZjvhbhfwnovo+Kc4Z0OyG0A81lU2aIkxrVFbHafzsI/evKHDmFMNcIOHar5Nn9UAgiYthxug0NhyLnTsldOCU/G1mz2vzen40DqSSkZ5YgKDhUbCmJKtMOIAip554VVG8H+UJah0RzdhKHk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2waAbV_1710922367;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2waAbV_1710922367)
          by smtp.aliyun-inc.com;
          Wed, 20 Mar 2024 16:12:48 +0800
Message-ID: <1710922342.4241717-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 3/8] virtio_net: support device stats
Date: Wed, 20 Mar 2024 16:12:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric   Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S.   Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alexei   Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@google.com>,
 Amritha   Nambiar <amritha.nambiar@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240314085459.115933-1-xuanzhuo@linux.alibaba.com>
 <20240314085459.115933-4-xuanzhuo@linux.alibaba.com>
 <20240314155425.74b8c601@kernel.org>
 <1710489940.1772969-1-xuanzhuo@linux.alibaba.com>
 <20240319101525.2452065d@kernel.org>
In-Reply-To: <20240319101525.2452065d@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 19 Mar 2024 10:15:25 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 15 Mar 2024 16:05:40 +0800 Xuan Zhuo wrote:
> > > Don't duplicate the stats which get reported via the netlink API in
> > > ethtool. Similar story to the rtnl stats:
> > >
> > > https://docs.kernel.org/next/networking/statistics.html#notes-for-driver-authors
> >
> > Sorry, this patch set did not follow this.
> >
> > I will fix in next version.
> >
> > But I plan that will be done in the commit "virtio-net: support queue stat".
> > This commit in next version will report all stat by ethtool -S.
> > The commit "virtio-net: support queue stat" in next version
> > will not report the duplicate the stats that reported via the netlink API.
> >
> > Do you think ok?
>
> I guess that could save time refactoring the code, but we generally
> push authors to go the extra mile and make reviewers life easier.
> Also, in a way, making the evolution of the code base look more
> logical. So I'd prefer if the series was reorganized to never
> expose the standard stats via -S.


v5 was post.

I will try in v6.

Thanks.
