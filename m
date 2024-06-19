Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0CFC1F
	for <virtualization@lists.linux.dev>; Wed, 19 Jun 2024 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762996; cv=none; b=pSufQeCW9/zbQq+j9yIYHySTlmhejgp+xlCEjJSAKTSWELFfBgbnG0GFURoejHuajk1cQZC16afeYEmhZ952CM7LcodxxYCA0pRhShbrUeqJ6VX7GmAA+U2MI5lArq7I9DX7BRwlQvEx59hkQhNwARn/RIgd3ndqvHh/ebd5oKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762996; c=relaxed/simple;
	bh=maZCRxTEbw58+voMBBXCbSIr89KJcCRkHmv1NE6+dTc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=QqBwdQqCCboZVnuTxfU2pxRbNjInJRS6psLEST4HVwSUUtRG9ZYcESYEYKHj+n5FPe7y5KQEScsEkivlg+Ybvn6vwH3yfZD0GCeWbBwLEivygy9noTQU60sn+AslkOuiMgzhZMtolr1PpOS12KD2DuYiblO4/sKI2QdooPlXfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yZd9GauK; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yZd9GauK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718762991; h=Message-ID:Subject:Date:From:To;
	bh=ggJv3/qZjwl30W5odr9ez843wirdfGE3skUnyQIwycA=;
	b=yZd9GauK7shPLM5/fzi2FM5ct0xCOiXqGR87h4w0GXDe9ugVkq9R3You7gYCpsC61AYD2CoW6TrYkIjCMo1Aei4Kc5c/CatB6gGyMOlOjf21qNZ7+YXkBaGHUCNL/HQ8N/4mK6toHUCDVXhLH9UhK4HSYu8XDjgdx+cc+7GwbMQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8lgN2W_1718762990;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W8lgN2W_1718762990)
          by smtp.aliyun-inc.com;
          Wed, 19 Jun 2024 10:09:50 +0800
Message-ID: <1718762578.3916998-2-hengqi@linux.alibaba.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
Date: Wed, 19 Jun 2024 10:02:58 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 Thomas Huth <thuth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-2-hengqi@linux.alibaba.com>
 <CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
 <1718680142.7236671-11-hengqi@linux.alibaba.com>
 <20240618181516.7d22421e@kernel.org>
In-Reply-To: <20240618181516.7d22421e@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 18 Jun 2024 18:15:16 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Tue, 18 Jun 2024 11:09:02 +0800 Heng Qi wrote:
> > > (Should we manually do checksum if RXCUSM is disabled?)
> > >   
> > 
> > Currently we do not allow RXCUSM to be disabled.
> 
> You don't have to disable checksuming in the device.

Yes, it is up to the device itself to decide whether to validate checksum.
What I mean is that we don't allow users to disable the driver's
NETIF_F_RXCSUM flag.

> Just ignore VIRTIO_NET_HDR_F_DATA_VALID if user cleared NETIF_F_RXCSUM.

Right.

Thanks.

> I know some paranoid workloads which do actually want the kernel to
> calculate the checksum.
> 
