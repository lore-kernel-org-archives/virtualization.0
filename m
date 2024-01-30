Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCCA33CCF
	for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 03:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706585139; cv=none; b=iffU2T/WwYn1Xugl5qDo/5J2xmHWOscbFCwicmhTv9YN8EvRsbRZ6iX604KDBJXAaN0arhxj+0Sgm6PQUDsq+zcyQznTa22XcQKSKWus1wAyW0iuBClRs7Kqo6sewcGC6auWR9IaZA+Ze4ymGtiyJVOnvbVhy02eEF+7OB+WLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706585139; c=relaxed/simple;
	bh=XdmMp38XHfHGXfOUFlI32RQN5ORjJDu+eiAe4I7lFv8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=apPK8IJxPpKgaTULRIdddPTgjmPbvMD/yxf+tGdn+IeswdZ6Be0i2DXE/bLNeAzPFamMwILB4SF34fFRjc+PEmFIlFx1IkQCI5DXsMsPJFzoYP3X7oqiD4IsdeYviQ+jhofKWt66LhbvQaHXR5RivzQa12dax9hA9dE0geXM6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BOFAyIa0; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BOFAyIa0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706585135; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=XdmMp38XHfHGXfOUFlI32RQN5ORjJDu+eiAe4I7lFv8=;
	b=BOFAyIa0z0XHNjjFWPxSTuldY9wswFAJuLWxaJ+qjVSQkI2ppE23YWODWTxOPggciU69S6CJiXIymif6D4/iCSk1aE1V3YowK4jzHgT4BZE7fA+HJIiAR6rFCn2AdUtGcK/QSbvf0IA0nEqoOBUU+V1B3hAWb38LIO5uy1x2J38=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W.eeJ4R_1706585134;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.eeJ4R_1706585134)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 11:25:34 +0800
Message-ID: <1706585112.676438-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 0/6] virtio-net: support device stats
Date: Tue, 30 Jan 2024 11:25:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 Zhu Yanjun <yanjun.zhu@linux.dev>,
 netdev@vger.kernel.org
References: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
 <1705384540.169184-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEsOs5L6eU==Vym_AkomvhhkHN0O_G9SaPFThAtH9XVyJQ@mail.gmail.com>
In-Reply-To: <CACGkMEsOs5L6eU==Vym_AkomvhhkHN0O_G9SaPFThAtH9XVyJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Tue, 30 Jan 2024 11:20:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Jan 16, 2024 at 1:56=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >
> > On Tue, 26 Dec 2023 15:30:57 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
> > > As the spec:
> > >
> > > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95=
bbbd243291ab0064f82
> > >
> > > The virtio net supports to get device stats.
> >
> > Hi Jason,
> >
> > Any comments for this?
> >
> > Thanks
> >
>
> I see comments from both Simon and Michael, let's try to address them
> and I will review v2.
>
> Does this sound good to you?

OK.

Thanks.


>
> Thanks
>
