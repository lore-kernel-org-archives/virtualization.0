Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2662F60BF
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250254; cv=none; b=AN1/WBW5aWBALFIuHu6Eag0Z4gCHsshQ13p0r4xc1y9+lb69c5zfhwRxU+LFxjuNTFalUo0GELvf9N2DVfIxfeALSPLr80Wi9dDAuB/APDdjRau2sPDeGKwy3NBJRCB66J+cwprvZox8t5xByXgprW4FvzM6IF0gh2dNQ4DzKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250254; c=relaxed/simple;
	bh=t7UlHOuN49CWXLyZpNuOkb/8d+QezXZ+35enZ0R4o+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=WTCix1vzcGyOJzTpvotNb+SkxbGDmdr6wYI3VU8t7SKEtgJ/nJy2fRIwd8KV5wtGXZvk6P8O/ghXmY7J/01dcLA45NqlH82Zct4GQHlyj7ItoHn9DDLsiT0t1wxiaSpYfd3SNMdBKY3JflszWjiVJb3W1A7rF5Hx7V4d/TYBZjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uHgeWOyj; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uHgeWOyj"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250815093044epoutp03c95222c68f41949a7063fa7f82ef8d70~b5sxNR6kt1253012530epoutp03W
	for <virtualization@lists.linux.dev>; Fri, 15 Aug 2025 09:30:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250815093044epoutp03c95222c68f41949a7063fa7f82ef8d70~b5sxNR6kt1253012530epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755250244;
	bh=oDZNru6EzrQYE5oyYm0kJ/e5sm/ukK+OmYVVJ+YMNcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uHgeWOyj1Hu0xurEfTFZR3mgvaO+VfobyNmRk3g1EhZCtKawWKSycs84AFWzTpeB9
	 sl9N/zlqCMfXetsvpGM+htdVfMCwBmf0TOO3tVxzDXVDCx5skF5m0gTn7iJni7Cipm
	 4TNkiufnzjKJxPNvxKc42kp/e/0Sz8lEWRUQOQTI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250815093044epcas5p2a2173e718c713bf1d49e0eeed3a886ff~b5sw3Knp_2650526505epcas5p2f;
	Fri, 15 Aug 2025 09:30:44 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4c3H0M4fTTz2SSKX; Fri, 15 Aug
	2025 09:30:43 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250815060604epcas5p3a6856bcd64ee4ed80abb43b09aab8a42~b26D626KY2237322373epcas5p3c;
	Fri, 15 Aug 2025 06:06:04 +0000 (GMT)
Received: from asg29.. (unknown [109.105.129.29]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250815060602epsmtip2645ad38253d82a680344ab48d7efd956~b26Cb0GMD0801708017epsmtip2Z;
	Fri, 15 Aug 2025 06:06:02 +0000 (GMT)
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
Date: Fri, 15 Aug 2025 14:06:15 +0800
Message-Id: <20250815060615.4162-1-junnan01.wu@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACGkMEtakEiHbrcAqF+TMU0jWgYOxTcDYpuELG+1p9d85MSN0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250815060604epcas5p3a6856bcd64ee4ed80abb43b09aab8a42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-505,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250815060604epcas5p3a6856bcd64ee4ed80abb43b09aab8a42
References: <CACGkMEtakEiHbrcAqF+TMU0jWgYOxTcDYpuELG+1p9d85MSN0w@mail.gmail.com>
	<CGME20250815060604epcas5p3a6856bcd64ee4ed80abb43b09aab8a42@epcas5p3.samsung.com>

On Fri, 15 Aug 2025 13:38:21 +0800 Jason Wang <jasowang@redhat.com> wrote
> On Fri, Aug 15, 2025 at 10:24 AM Junnan Wu <junnan01.wu@samsung.com> wrote:
> >
> > Sorry, I basically mean that the tx napi which caused by userspace will not be scheduled during suspend,
> > others can not be guaranteed, such as unfinished packets already in tx vq etc.
> >
> > But after this patch, once `virtnet_close` completes,
> > both tx and rq napi will be disabled which guarantee their napi will not be scheduled in future.
> > And the tx state will be set to "__QUEUE_STATE_DRV_XOFF" correctly in `netif_device_detach`.
> 
> Ok, so the commit mentioned by fix tag is incorrect.

Yes, you are right. The commit of this fix tag is the first commit I found which add function `virtnet_poll_cleantx`.
Actually, we are not sure whether this issue appears after this commit.

In our side, this issue is found by chance in version 5.15.

It's hard to find the key commit which cause this issue
for reason that the reproduction of this scenario is too complex.
