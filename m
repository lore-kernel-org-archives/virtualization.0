Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794129877;
	b=TpJ9vWy2Novub+2DDsVucpXoBJzw07lcHuRWeUjpSrgeN+twTZVYRO97fTdCi0CNY7Ey
	 D6WntvDA3Rj1aqCoT681/+es6O3EJpL29uSD0Ey8M/9mFMl7EMonAki+/7xGTepizVy/N
	 jKZcFMrJRc+FKyovq7O2BCOEGqTaKLSSgfQ9OpdWU6W/+yGw0DjveY0LarJbh2J2mZL+o
	 Whev1rRji8OrO9CIcCYTLdjZd+l1+/NLqb3ljRQKueKRyOaf4wHEn6g2BhsIv9ETKr5dI
	 XUONNubqfgOXMKOtI/Emt29Zzmz3WV1R8XFDwgCxB5djXrK1P2IDanaYu5DecyTvV9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129877;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PnzH+B+BQHmWRcHqdfcGVVstdJf8NJtY2FdKLBnT8BA=;
	b=moFluC48b/pxWvLJ0oPoBfFailUVbJbddVmNIcBnPsGYiji14fspV9VzDU6Dnek8ZTLJ
	 muFutSUSXLnQnwU4ajPC+Nl+XhPNgZCpbQjCVXuzlY2Jq78FilOQ72hnDoTADNaPm3bZI
	 qbvbl2+zQWoUOf8Wtq+OalpDWNwb074sY09MRAW1afDqB06ByznTYlkoLRuVwSmChEER8
	 7aBtwvHfUg2ce1OipdCkg9HkEPeA2QoUND2hnadMvaR4qSCuvk96P0W5cOsrtCYY03wOI
	 UI6MMRyxCE+kk6DOM6RA7fn8BcxW6BXj+8VKZm4IS/B03tmJxKZJxiogffixRd2VL1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P6HdDUCZ;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C27606A332
	for <virtualization@lists.linux.dev>; Sun,  8 Nov 2026 09:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8C27606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=P6HdDUCZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=P6HdDUCZ2dodrGT4fxgKTi+gcM2AkdrIy1MRstIFj6tiyIi5AAWFz+a1KqJgaNoDq3kdT/LXsx/Ol
	 8lpjzTROB9Pi98FQQudt3FpG6rLUHyHcUubKzESAblFP6B7rF2p4zESaYABsJ7axqy7o0Q+xxQxy2i
	 OhHS1Qcf+NsKrn+M=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46af03fc5e3c-5aacd;
	Sun, 08 Nov 2026 17:24:27 +0800 (CST)
X-RM-TRANSID:2ee46af03fc5e3c-5aacd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from openEuler-24.03.03 (unknown[74.82.203.40])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af03fc1270-639dd;
	Sun, 08 Nov 2026 17:24:26 +0800 (CST)
X-RM-TRANSID:2ee76af03fc1270-639dd
From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
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
Subject: Re: [PATCH net 1/2] virtio_net: Don't DMA map the kernel image for the AF_XDP TX header
Date: Mon,  9 Nov 2026 02:23:54 +0900
Message-ID: <20261108172417.56607-1-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179411647562.994134.8636776015987575971@kernel.org>
References: <20261107125723.33547-1-yanhaishuang@cmss.chinamobile.com> <20261107125723.33547-2-yanhaishuang@cmss.chinamobile.com> <179411647562.994134.8636776015987575971@kernel.org>
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

On Sun, Nov 08, 2026 at 05:41:15AM +0000, netdev-bot+sashiko@kernel.org wrote:
> > and binding an AF_XDP zero-copy socket fails with -ENOMEM. Even where
> > the mapping succeeds, the header shares cache lines with unrelated data.
>
> [Severity: Low]
> Does the second sentence here match what the patch does? It reads as
> though the patch also gives the header its own cache line.

[ ... ]

> Could this sentence be dropped, or reworded so it doesn't suggest the
> patch provides cache-line isolation?

Agreed. The header is only mapped DMA_TO_DEVICE, so the sentence
doesn't describe a real problem, and the patch doesn't change it
anyway. I'll drop it in v2.


