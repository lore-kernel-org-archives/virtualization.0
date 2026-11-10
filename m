Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794280884;
	b=cuM88I7ahFYRuArfYYR5reXap5PuzX+ENgj2Vn7ZOPA/NG4mAptHdbhHtnXs+IwzARSa
	 nNtpNhV4SitbLE0eDQVjsfG51rnwfjLrYeMMq1EtxPG+ITBy02UlhsOsdgowVvBfV7NGX
	 m1X4sP37Cf/qzXFf/ERWzHyYhc7lRydbWQJ4E5JPjCQLJeo5y9/MpRVqQAKnS1TDAm5RW
	 jPgZiIAlAhP3nwm4Y/QZr70bc1/I9gVn0uryLH5LpzyII9KG5W5V3GXAi3a7P3km5bJbn
	 jTwiGgWEfsPQULRAvm9YeLagKz4VQNj3hAyFc9Zxn4CJ3uRaLHue/xbjseacsemkuDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794280884;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Iu/jo1GP6S2hOnbceCXpLkMdW9l1lBuKE6wK4rMGL7s=;
	b=XTsmP4J1nJ60c3mB6rb4ByHm515xJLtlwQ00vwtm1KQ+ezCWequ5oTTFwePI6ubp6UFR
	 1Py3n/drdnQ1sgHD+cAZZcdy/dnsQ5L2SkSkp5VC/OXvr5j6F3UOh0wjkTYQ52r2dGYEE
	 ITXfvcCs2B4w5D1TldyyOMfC0aC3NzNPeEkwqHzeNv7b4Ft4gql3iq6Cbp348kzFnIB4E
	 qaryBe4EjQslALDexyFseVqtWSiM4prOJaQvkVQjhbT34KM1Oe5yNf9tkYN3S/hrbpE1a
	 /lg21p9uRi8IbjkknNJYWlW7jx/hBfZvWKXbO8SQaKA2ZwIXpazkLl7TXPMO0gHBuCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vtyrBxX3;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8BB606A331
	for <virtualization@lists.linux.dev>; Tue, 10 Nov 2026 03:21:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF8BB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=vtyrBxX3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=vtyrBxX3nBUcwHfcB5JBkuwv5gtB/DTRDFKTqGUq6Gu/IU7LYPokXEW3Gb1RVDuuA+2LtkbJ2kDw6
	 w810ovi1LNhJlyje+jiO3TbThnEeQB0gHwDlukhHm0dpTD8bjy4U7p2oLtL73uyj7OkSFz2BKm7NXa
	 lqh1xjS0I6WonSuI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96af28db151c-cf7e2;
	Tue, 10 Nov 2026 11:21:21 +0800 (CST)
X-RM-TRANSID:2ee96af28db151c-cf7e2
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86af28daaccd-a499f;
	Tue, 10 Nov 2026 11:21:21 +0800 (CST)
X-RM-TRANSID:2ee86af28daaccd-a499f
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] virtio_net: Keep AF_XDP zero-copy pools bound across suspend
Date: Tue, 10 Nov 2026 20:21:13 +0900
Message-ID: <20261110112114.11278-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179422769660.994134.7551261891585249565@kernel.org>
References: <20261108193845.73621-1-yanhaishuang@cmss.chinamobile.com> <20261108193845.73621-4-yanhaishuang@cmss.chinamobile.com> <179422769660.994134.7551261891585249565@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Nov 09, 2026 at 12:34:56PM +0000, netdev-bot+sashiko@kernel.org wrote:
> - [High] virtnet_xsk_pools_release() unmaps the DMA of a zero-copy pool
>   sitting at a qid >= curr_queue_pairs (left there by removing XDP), but…
> - [Medium] When virtnet_xsk_pool_attach() fails on restore, the pool
>   stays DMA mapped while rq->xsk_pool stays NULL.
> - [Medium] If virtnet_xsk_pool_attach() fails during restore,
>   virtnet_xsk_pools_attach() only logs netdev_warn() and the resume…
> - [Medium] virtnet_xsk_pools_release() is a new writer of AF_XDP driver
>   state (rq->xsk_pool, sq->xsk_pool, rq->xsk_buffs, sq->xsk_hdr) that…
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it defeats the
>   patch's cleanup model on the failed-restore path.

Thanks, these all hold. sashiko-bot raised the same points in its
review of this patch.

The High one and the first Medium have the same cause: once the queues
are freed on freeze, the patch finds a pool again only through
xsk_get_pool_from_qid(), which depends on the current queue counts. A
pool on a queue above curr_queue_pairs can then be unmapped on freeze
and bound again unmapped later, or not found when it has to be
unmapped.

The second Medium is right as well: when the attach fails, the socket
stays bound but gets no traffic and no error. And the release on freeze
runs without RTNL, unlike every other writer of that state.

The failed-restore issue is older, as noted: after a failed
virtnet_restore_up(), vi->rq and vi->sq are freed while the netdev
stays registered, and virtnet_close() uses them too. I'd rather keep
that separate.

I'll drop this patch from the series, resend patches 1 and 2 as v3, and
rework it to keep track of the pools in the driver across suspend
instead of looking them up by queue id.

pw-bot: cr


