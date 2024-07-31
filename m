Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82F1A4B2D
	for <virtualization@lists.linux.dev>; Wed, 31 Jul 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722425030; cv=none; b=EbkBzh9GIRECDpjPmml5sqEeNhN+p+c0/+UNnGenJZosGZimKx1J+1Ynw7ot7NSvtlr93+A4lmipH24CgTpqm5yVKv+2WHopHrHTetJcFI1pS08K1TDi8hhZMz1SeL1HAYN81DMqKwYt1n6s9XSySjAEmwGyM7xsS0N5zzGnKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722425030; c=relaxed/simple;
	bh=HATaWdQZWZIzAvM9h+SZ6bUQcK7RXstln/FD6gO0xe8=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=LLgA/p8rhauZbMnuSGS+AUAhojmtfm5+e1s3snVWQzYFlXI7ut/h+PYS6a0w6FoTfuS70VShv2+1Jr8KNJ+ekPNKesXu09QK6XFL2+RsSL2zpTLVrbHRw4+wIZ0W59fCrgUDdcd78nhTnyfp4T2BcbDJkwSmIKwOmLdthdlrNTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Bhwd0MR6; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Bhwd0MR6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722425020; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=HATaWdQZWZIzAvM9h+SZ6bUQcK7RXstln/FD6gO0xe8=;
	b=Bhwd0MR6Djdg7R0TGfvM4aL+Gj2SDXZfiBxOtmfhSOXeDBWA9ejQHWJqNWjf/9Jfl3FkYuKTH9ClSH9Jrw3nlwJP1/jMjhi6pRNXv/k28P50kXt5K4BNYiqik2UMX8p51fTokxbO5r4tY5iWJkGm1xstO0GoRonQ7D82MNm6+eM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0WBjLas6_1722425017;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0WBjLas6_1722425017)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 19:23:38 +0800
Message-ID: <1722424933.7532778-1-hengqi@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands
Date: Wed, 31 Jul 2024 19:22:13 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux.dev,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
 <20240730182020.75639070@kernel.org>
 <CACGkMEuxvLVLuKCLNi2eBy5ipzNn+ZGM+RSRBXk-UA0bJCKgZg@mail.gmail.com>
In-Reply-To: <CACGkMEuxvLVLuKCLNi2eBy5ipzNn+ZGM+RSRBXk-UA0bJCKgZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 31 Jul 2024 11:13:03 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Wed, Jul 31, 2024 at 9:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Mon, 29 Jul 2024 20:47:55 +0800 Heng Qi wrote:
> > > Subject: [PATCH net] virtio_net: Avoid sending unnecessary vq coalesc=
ing commands
> >
> > subject currently reads like this is an optimization, could you
> > rephrase?
>=20
> It might be "virtio-net: unbreak vq resizing when coalescing is not
> negotiated" ?

It's great.

Thanks.

>=20
> Thanks
>=20
