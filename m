Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C7D41C62
	for <virtualization@lists.linux.dev>; Tue, 23 Jul 2024 01:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721697719; cv=none; b=sQWG8rpllB+LUzTlzp58Kqp002cGHRDIh5BTSuasH6Wy5OgaV7BsYPuQdrNwLqgpkaUs74Yd07UAkujN4ISoTO8Zelfy6vftlxwkDb2Fw9VRLneke+2NS8QJS8ommYIL7JSxMD/mT/cR7hk4pJJr2hDqngD8FI7yUDqcfU9azEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721697719; c=relaxed/simple;
	bh=sZHr2Gnel0ldBTDzDCSgwwZ5OaKWorgBIOfSH9dJHBo=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=muE9AWbEOtFIj69rG4KzG3wKWNVXROw1QtZENN9TuUDM85KJjh6njO8j2Ddn69+tKWFrMDB1OLlMzP7FGR7rtc21M7nyFif4njAg/XIHvGRldYpcvadEk/pTd8paX/Dmgf99V36bvdq+OwrL4b4c4HC+hLq8xQHXjfM7Ofc1g0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tJNqsliV; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tJNqsliV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1721697709; h=Message-ID:Subject:Date:From:To;
	bh=sZHr2Gnel0ldBTDzDCSgwwZ5OaKWorgBIOfSH9dJHBo=;
	b=tJNqsliVOcfafcrvXpysKFANQBk3CunFlDeHly5TW1zpzS1HcMEyzVSV1vR8CCGxU1wiUsREIdVi7xc1jBV4FFdIgPjXSyAy/P/nOKQcnA3wKRdo6Xjy/N0vQbS6HlUbimFUrh99Dpxfupq5DAw9vcPVne7masd4kE697FvPvlc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0WB77v12_1721697707;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WB77v12_1721697707)
          by smtp.aliyun-inc.com;
          Tue, 23 Jul 2024 09:21:48 +0800
Message-ID: <1721697638.0475743-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next 00/13] virtio-net: support AF_XDP zero copy (tx)
Date: Tue, 23 Jul 2024 09:20:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>
References: <20240716064628.1950-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsX5CwQmrwYzosSDMRdOfYVEmaL6x0-M9fWq0whwyRwSQ@mail.gmail.com>
 <20240722174204.0eedd139@kernel.org>
In-Reply-To: <20240722174204.0eedd139@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Mon, 22 Jul 2024 17:42:04 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Mon, 22 Jul 2024 15:27:42 +0800 Jason Wang wrote:
> > I wonder why this series is tagged as "RFC"?
>
> I guess it's because net-next is closed during merge window.


YES. As I know, we can not post "PATCH" during merge window.
So, I post "RFC".

Thanks.


> I understand that the situation is somewhat special
> because we got Rx merged but not Tx.
> Do you think this is ready for v6.11 with high confidence?
