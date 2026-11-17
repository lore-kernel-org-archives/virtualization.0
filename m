Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794874132;
	b=TlC9E0PaZTyRXSAJKrX4Z31L0OQuYNjwrXskuslIJikZkKH0aBARF5xiMDWFakKOuOeA
	 mddTC5SnDSUIe7HXHaKB/W6+9EWihwa36QUjEYaS4nuCoxmfJJ3xgawoS9ivbM1LttrZW
	 wxUqajmYclPSplytVaAEKdjuwhwMrln8CdcVo1JgEeFZywR8ZbiEmiRQjllmlvKR8s0I6
	 6gofNnFUEkntVxMFfsbCWO2k/6Rnd8vtc5GmWUi/w31L2kJxUS87/9M6fyUjtl5w2V9pK
	 6WhIXPbrLUrpCheW8TRrScUYMf+E4ACZrVwphl5Mre5eB/XtSJv1+2QS4FPEOIPxkyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794874132;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fQhaA4t5eCBp8YpwrTq78zNwHUDKMkRDABJ3Yobt/9E=;
	b=lboHde06dNvVoVUy3Mu3X24ih+1fuMTviKRIaH4HB37F654Dx+KcGiCbhEKM6Q132c5i
	 8J+l55U9KuUDpYqHIpE/LWzmh8IjuHGzrvF10l8AFnJmT3klsJ/mDjdlblOJYdOyPZCzb
	 iIyNBVyvjMmgRz63BPguO7qw7e2bmo5XJaSJr9cnLRfsxEgo612bCoeQKIntzUOUl2IFy
	 cGXxnlNuRSc/XbXMeAbTMTp30pdoegaAiIPmVskTXSm6rhWbJ7I9h95eo5SP8Y9wxA9Mz
	 9mpCgNj6bDanqmlNjwgTPws7pZpJPnGJm79TbymKKVkKrZIfN5wQY9H0pxpXTpH+MBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9qyQHqW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7FC606A323;
	Tue, 17 Nov 2026 00:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L9qyQHqW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25D41F000C4;
	Tue, 17 Nov 2026 00:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794874132;
	bh=fQhaA4t5eCBp8YpwrTq78zNwHUDKMkRDABJ3Yobt/9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=L9qyQHqWViDLqBf1ym23/3j0T6giz/0oi9sN/4SOmoXrehOXPAua6/3FcSwriOv7O
	 hPEhPpl2/nxZkkUE1D9iRZz94wvTYzeQ1xI+3lU6npPohKuZJcSuB5o3bXgS9kEBRf
	 zzzvs/b5STuca9TZprcetwPVOeqXPQK74Bh/8bbfo63EnJEEklpQm6Plt0aHCs0fxS
	 AbMKQqyseVRTEkXJhlfpCP9JUP34G4maGQvzPudVmeeQyKohAzWVc8TXdMHiDvjoHP
	 Q+n7HCqL928MNlCmBAYAsT2ZxRgw0vt5i+b71sEDnhZxo/SsDttSZQmVdXDfu/tAO3
	 txjGEPX1cChEQ==
Date: Mon, 16 Nov 2026 16:08:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] virtio_net: Disable AF_XDP pools on queues
 above curr_queue_pairs
Message-ID: <20261116160851.37a2b158@kernel.org>
In-Reply-To: <20261110153003.23731-3-yanhaishuang@cmss.chinamobile.com>
References: <20261110153003.23731-1-yanhaishuang@cmss.chinamobile.com>
	<20261110153003.23731-3-yanhaishuang@cmss.chinamobile.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 00:30:01 +0900 Haishuang Yan wrote:
> With an XDP program attached, virtnet_xdp_set() adds nr_cpu_ids queue
> pairs for XDP_TX and raises curr_queue_pairs and real_num_rx_queues to
> match. virtnet_xsk_pool_enable() accepts any queue below
> curr_queue_pairs, so an AF_XDP zero-copy socket can be bound to one of
> them.

Alright. I still think that auto-changing real_num_rx_queues
to use Rx queues from queue pairs allocated for XDP Tx is fruitcake
behavior. But the bandaid is simple enough so whatever.
