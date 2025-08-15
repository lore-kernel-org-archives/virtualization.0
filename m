Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BBE299AA0
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224638; cv=none; b=UXLWomLQVHwIP0HxJFytynp1fyB1koiUrPie6I9cd8jV5r15KnQHvwxvXYGV0cVfLL72a6IMmUT6uzBK4E0tXQNIkwt8itSpB55vzwQgf4HJ4Huxuped5Fwc2NNCeFmYqRpJUKohCGAG5LzmKaa5Yg8xiPz/rO0GXur4Ywc+a0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224638; c=relaxed/simple;
	bh=iGpiuMVJGtdIkVmTfPfuyQdh6Q2Q7FQkJ4+ZghkWp8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=K10C43BqiGyz31bxmchfjHO4DcoCWk9vH+oF0RNAyc5O0NCuDt7n6paCXGvy5hON1jmOfRzhRCSuq/4ddGDHfjWja8Sp/wz+Bj7N9uZpDS/nhLpEnBW374NxjOo7b2rPbj0DiSOx+HBfYET4SYpi5DHDbdfWhfBAe82q6bOpNx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=UIPu4ZPp; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="UIPu4ZPp"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250815022348epoutp040efbc0cca4ecbe8f5f522ea22d564a73~bz4Ac_Qar0308003080epoutp04v
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 02:23:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250815022348epoutp040efbc0cca4ecbe8f5f522ea22d564a73~bz4Ac_Qar0308003080epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755224628;
	bh=iGpiuMVJGtdIkVmTfPfuyQdh6Q2Q7FQkJ4+ZghkWp8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UIPu4ZPpN7+jQlJsQZIgOYnen2tyw8ffmfoevsfcqHtiCV6CnO3J81VUiOKvEjhe1
	 N9L9uq71TEJuCODWsHQWjEdGViIpXXmLQfCX6JPd0h+UOP+1zxybeVoZEezxOsWcN3
	 o8pM17sdnb+kE6GkkNeTQP0OUK2YPkayQEy2fDys=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250815022348epcas5p308b1e84b1a51311e6e2950c378d07b95~bz4AAI9g12290922909epcas5p3K;
	Fri, 15 Aug 2025 02:23:48 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c35Wl3Yxlz2SSKX; Fri, 15 Aug
	2025 02:23:47 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e~bz3QdmzWE1407014070epcas5p3H;
	Fri, 15 Aug 2025 02:22:57 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250815022255epsmtip19fe40763e2627809b0c5ccca38b858a7~bz3O_gx3L0969109691epsmtip1z;
	Fri, 15 Aug 2025 02:22:55 +0000 (GMT)
From: Junnan Wu <junnan01.wu@samsung.com>
To: jasowang@redhat.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	eperezma@redhat.com, junnan01.wu@samsung.com, kuba@kernel.org,
	lei19.wang@samsung.com, linux-kernel@vger.kernel.org, mst@redhat.com,
	netdev@vger.kernel.org, pabeni@redhat.com, q1.huang@samsung.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com,
	ying123.xu@samsung.com
Subject: Re: [PATCH net] virtio_net: adjust the execution order of function
 `virtnet_close` during freeze
Date: Fri, 15 Aug 2025 10:23:08 +0800
Message-Id: <20250815022308.2783786-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e
References: <CACGkMEv2wMm_tb+mbgMFA2M2ZimVr1OBKre3nrYrBDVPpqVoiw@mail.gmail.com>
	<CGME20250815022257epcas5p3de66f4e633a87e17275c0b16b888bb4e@epcas5p3.samsung.com>

Sorry, I basically mean that the tx napi which caused by userspace will not be scheduled during suspend,
others can not be guaranteed, such as unfinished packets already in tx vq etc.

But after this patch, once `virtnet_close` completes,
both tx and rq napi will be disabled which guarantee their napi will not be scheduled in future.
And the tx state will be set to "__QUEUE_STATE_DRV_XOFF" correctly in `netif_device_detach`.

Thanks.
