Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E98C1B
	for <virtualization@lists.linux.dev>; Wed, 17 Jan 2024 05:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705471141; cv=none; b=JiYgqA/7wj1hzj77JQuLYeyrH5xJhz5ZydVS/R87U8P6z0b59lK0o5ibmZZ2LVmHV8iUn1uTwpyAJ3sNO5UKJjxIbNwU3FE9mZH8560IpZf3aLaIU3CYCQte3dFPXjmSIUIsazmHAs+HfW8QDLS0OiblnJRCdz5Mf2P1NnGmrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705471141; c=relaxed/simple;
	bh=D4KHcuCwO6TM93KeN4GQmsoxdmonylr1GPq99r0fO5E=;
	h=X-Alimail-AntiSpam:Received:Message-ID:Subject:Date:From:To:Cc:
	 References:In-Reply-To; b=IFvPL7/6PgXA9Rtcx+PFgYgJC6j840hppjtLqeifPUojpob+AtoIVwIqHouCxKBpqZiXyNF+UPdn65YcIY8TUMBCNb6cTPJVJo/xsIUTtCDb1qrh6DjMrPhcjIo/70HD/AcEt5u12tS3alS0McGSG3KfRKPIosU1+129W+HjNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W-oO.HL_1705471128;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W-oO.HL_1705471128)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 13:58:48 +0800
Message-ID: <1705470932.7850752-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 00/17] virtio-net: support AF_XDP zero copy (3/3)
Date: Wed, 17 Jan 2024 13:55:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org,
 "Michael S.  Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S.  Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Alexei  Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org
References: <20240116094313.119939-1-xuanzhuo@linux.alibaba.com>
 <e19024b42c8f72e2b09c819ff1a4118f4b73da78.camel@redhat.com>
 <20240116070705.1cbfc042@kernel.org>
In-Reply-To: <20240116070705.1cbfc042@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 16 Jan 2024 07:07:05 -0800, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 16 Jan 2024 13:37:30 +0100 Paolo Abeni wrote:
> > For future submission it would be better if you split this series in
> > smaller chunks: the maximum size allowed is 15 patches.
>
> Which does not mean you can split it up and post them all at the same
> time, FWIW.


I hope some ones have time to reivew the other parts.
In the future, I will post one after the last one is merged.

Thanks.
