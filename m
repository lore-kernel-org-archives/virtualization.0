Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.37.83.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795180857;
	b=2Y4nNjOMpb8ZIREuoYp48BMUJ22IcIdMCKlI62F08uF7kM5inJiYHgxS1+aotSgMunQi
	 etZcZUXnjKDsw01EAOD2OcekUqAhNG4R1HQCbXIG7tvMbhudIILgcGob6ujkdHmgig9Ur
	 Mv+ONEmyiHBojN9DeBrX65EwTLVunhjdqO0fEgYOK5AVGqVMOqHLgYZexZ/rtJtyP/flp
	 260dJSsozQAEtQo2FWu/+V1rSQ5ZsBEN7v7Dc/W0tZVLZ5AwffA6TyEhCTJkCi1t5t9ya
	 I7F8xVfDs2yXDoPHVuulglnKAawdXsN7F+xRsSRB9Qh0hKT70ThLJHST2hWjGW2GGuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795180857;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Gkaq7y0t6W9u9ga0uuU7sK+gI9R+BYJHhIlyp2e/T7E=;
	b=KIyUu/UC844gvUE44PWJITPuvBw1QwPtAbLopXQRShgoysPKM3Aewq3TSCXrZLfk2EDo
	 fCe0ey4FAPuvsze4WjszeyGqskDyK5hD+9dGTTWfURfc8wSTrVOQffyPOaogwYFkLQPjP
	 1zE4s/03o1ZWkWbXKHBEi7UWW38n0vCd9t0JmjT1ZO7Jx/4bnN+F+6nf15nqJNIzZcvAh
	 0nopXHEYCPuD67uR91do6Q839KGF8du1c7SCPXVBA5UMYJ99dxgKwbkPdqa8/EcrAtltD
	 QDcwFNzHwfK5DTKMwCgPOympI2nEkMRglf/4O0XNn5SnJATY1p/LuNP1Dl4ootKzsaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dfb.sh;
	spf=pass smtp.mailfrom=dfb.sh;
	dkim=pass header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=B+dnc40H;
	arc=none smtp.remote-ip=54.37.83.207
Received: from frkn.dfb.sh (frkn.dfb.sh [54.37.83.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935F606A334
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 13:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2935F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dfb.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfb.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=B+dnc40H
DKIM-Signature: v=1; a=rsa-sha256; s=frkn; d=dfb.sh; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1795180837; bh=Gkaq7y0t6W9u9ga0uuU7sK+
	gI9R+BYJHhIlyp2e/T7E=; b=B+dnc40HTqT0Asf/fygoTtwvxSKN81ITvZTE+gl2xUSDC7Ha4Z
	TfagQ3bq2yD7fILjtHAW55d3JOX3GT8jzmFtqmBr5MIp3I970aobEKP6BP3/I9dPMXnCDcIYvpC
	xFBATnKzBNZJL3GYk5yMviN4GQSypYgC56e2u10zNa6x/xQMbbwP8o3wYMrg1IsaszlMeX586A7
	kni0jAb9OHEpqlxL2Q6PbPcjS3nzSoZvj4BARldMoSYxb98pRqd8KMjC7V00JSu6SUVGzbykNb0
	uzTn7FXKRzVXKX3P+ZXcGhoKMNKINgbNwowYPnfkH1pqaLnIilISPlBBEzW8KbOl2uw==;
From: Vladimir Petrzhikovskii <vladimir@dfb.sh>
To: dtatulea@nvidia.com
Cc: mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	nikolai@kalinidze.me
Subject: Re: [PATCH] vdpa/mlx5: Bound the KLM count of the user MR
Date: Fri, 20 Nov 2026 14:20:34 +0100
Message-ID: <20261120132034.1337770-1-vladimir@dfb.sh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <d4f67696-5095-4948-9029-f657058431b0@nvidia.com>
References: <20261109-b4-mlx5-klm-v1-1-787b45145719@dfb.sh> <20261119101523-mutt-send-email-mst@kernel.org> <d4f67696-5095-4948-9029-f657058431b0@nvidia.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for the comments!

On 19.11.26 19:12, Dragos Tatulea wrote:
> Please make this paragraph more human friendly. Enough to say that
> the type doesn't fit the value or something like that.

> No need to say what the code does. Focus on the why.

Shortened both in v2.

> Yes The limit is right.

Thanks.

> Comment not needed.

Dropped.

> Unrelated change for fix. Drop please.

Dropped. The command then keeps today's limit: kzalloc() caps it at
KMALLOC_MAX_SIZE, 4 MiB with 4K pages, which holds fewer than 2^18
KLMs. On a device with log_max_klm_list_size above 18, a guest map
that needs more KLMs than that fails with -ENOMEM and a one-time
warning from the page allocator. Do devices report more than 18? If
so, I will send kvzalloc() as a separate patch.

> Why not DIV_ROUND_UP_POW2(map->start - pe, MAX_KLM_SIZE)?

I missed that it exists. v2 uses it.

> Use mlx5_vdpa_warn(). Rate limiting here won't help: the other prints
> will trigger.

Done.

Vladimir
