Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC157C9F
	for <virtualization@lists.linux.dev>; Fri, 31 May 2024 02:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120935; cv=none; b=on5uHhN3614KSn/NdC+ShIGGe8u4YUAA1lU6Rn19EkucNJV/aUXIqafzz6qcqOYPS0i8AlsxXefosKs4YAoiYYuyxleTgFTH8/eaR+2Dlsil9tE37uJTRbfpvyyT6v43KccxvliJcMuK2GHmvYVQE5jcQ4DAnpTZQqZki+4ZMUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120935; c=relaxed/simple;
	bh=5Qd0+YkPbyEFtmhmhsPZSrhbDlVPAjQSs8XXnIwKSvM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=prrmqWaTsdfODcEmrAm18DUMumVWVi5oisPKTU84QM/4X+gf1gK7R4gR2Bar8EQmSKGu0iScE1f7PfC3AJ+Z969Lqr3slpldrdP5mGWjM7P1++O8+anj6ZazM+fvqqgSr081ELEEI5ot1C5UtVAFxDpmbbPWQ5QhMFOm8s4RG2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZZjTlWT+; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZZjTlWT+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717120929; h=Message-ID:Subject:Date:From:To;
	bh=5Qd0+YkPbyEFtmhmhsPZSrhbDlVPAjQSs8XXnIwKSvM=;
	b=ZZjTlWT+Nz8CDcPZ20xthn5GHGJlJ7S+q74BGPEjPQmPInWuWSM8G/R19AVSCaMQAD1AEaJ3/IMMMqQx3+x8vE32iL1NH/ibpTCHpxUmY9Kz3pLiyVPNQbsYjb2s3OlbCaJUdYrCsCQ1sDNrycB2/dVqBum+du5dw4pRKO+VMss=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7YFVXu_1717120928;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W7YFVXu_1717120928)
          by smtp.aliyun-inc.com;
          Fri, 31 May 2024 10:02:08 +0800
Message-ID: <1717120653.9337146-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v2 00/12] virtnet_net: prepare for af-xdp
Date: Fri, 31 May 2024 09:57:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240530112406.94452-1-xuanzhuo@linux.alibaba.com>
 <20240530075003-mutt-send-email-mst@kernel.org>
 <1717070084.6955814-1-xuanzhuo@linux.alibaba.com>
 <1717119614.404968-1-xuanzhuo@linux.alibaba.com>
 <20240530185517.33ba5daa@kernel.org>
In-Reply-To: <20240530185517.33ba5daa@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 30 May 2024 18:55:17 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Fri, 31 May 2024 09:40:14 +0800 Xuan Zhuo wrote:
> > On Thu, 30 May 2024 19:54:44 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > On Thu, 30 May 2024 07:53:17 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > It's great that you are working on this but
> > > > I'd like to see the actual use of this first.
> > >
> > >
> > > For me, that is easy. But how should we do, if we use one patch set,
> > > then the commit number maybe 26, that exceeds 15 (limit of the net next).
> >
> > Hi, Jakub
> >
> > There will be a huge patch set (about 25) to support AF-XDP for virtio-net.
> > Can I just post this huge patch set if the maintainers of virtio-net agree?
>
> First of all, I see you posted v2 within 4 hours of v1, without really
> waiting for Michael to reply.

Because I was checking the code, I found some commits need to be prepared also.

> So I guess that 15 patch rule is not the
> only one you intend to break?

Actually, that is the only one rule.

>
> On v1 Michael asked you to not do the rename, and start with AF_XDP
> support. Why don't you do that instead of asking me if you can break
> more rules?

Because if I don't rename the files, there will still be about 21 commits. For
me, I don't think this is the key. If I release everything in one patch set,
then I think Michael can understand why I want to rename the files.

Thanks.


> --
> pw-bot: cr
