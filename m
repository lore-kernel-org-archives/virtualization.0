Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8EC037140
	for <virtualization@lists.linux.dev>; Mon, 18 Mar 2024 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762834; cv=none; b=GJVzD69xBXq6gGWX0RZ5QWo2CjdSbA4+sP+srbWC66/TYKi6PANTk/XmtfYT3dkNUVtH0o+EjOPIym7l1IaKJKU4haOrST+E8yivTS58oZNpQua1AU8tzFcb8lMFfTHwpeooIfWRMtP8hIm9I7NvlOv/gowd7lgmiPheqNbj2c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762834; c=relaxed/simple;
	bh=W6g4yZ4VJx/sK33OAzIbSo9XH2RCMHDyntFci0j3bqw=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=u+UZRJDm0GbgPJhanIMlWJykEUw+haMPkJBYwx2hVfNQUK1eteOuIIgXXH7kJvojyf3s4UOkL/5+NMk2YHt2Ap1UxuHrPy+gkA5DlON6niIoOWCo3KVGd/1tYzq2D+Vjx9qWYgAn4YO1QdBaizrZysfQdJuZWedFu8pkZ1WWz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DY/06RW3; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DY/06RW3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710762829; h=Message-ID:Subject:Date:From:To;
	bh=W6g4yZ4VJx/sK33OAzIbSo9XH2RCMHDyntFci0j3bqw=;
	b=DY/06RW3aiG36sebX2XEM5dyfFIowgI3bkYqm6bH+FlxJbk8iiy82jW7mi1stD0gqhQGM4Al2gSPrBhRdtDzGzNzfIXB1PZqtYwPe/+3D1KiEsT1RjHzzOYckGHhC5WbSJdz/FbSPmrHuP0aMdGsTxFj7LJZIG/Ezda0TlSJZIY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W2ndA9H_1710762827;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2ndA9H_1710762827)
          by smtp.aliyun-inc.com;
          Mon, 18 Mar 2024 19:53:48 +0800
Message-ID: <1710762818.1520293-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Date: Mon, 18 Mar 2024 19:53:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
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
 bpf@vger.kernel.org
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
 <Zfgq8k2Q-olYWiuw@nanopsycho>
In-Reply-To: <Zfgq8k2Q-olYWiuw@nanopsycho>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 18 Mar 2024 12:52:18 +0100, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, Mar 18, 2024 at 12:05:53PM CET, xuanzhuo@linux.alibaba.com wrote:
> >As the spec:
> >
> >https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> >
> >The virtio net supports to get device stats.
> >
> >Please review.
>
> net-next is closed. Please resubmit next week.


For review.

Thanks.
