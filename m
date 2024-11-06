Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9051922EF
	for <virtualization@lists.linux.dev>; Wed,  6 Nov 2024 08:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882832; cv=none; b=mkKgo1lSkk4536bY4Z0eUDI0j1e02TTN1V6bx3mIzTOmRy/kaNeIgxBj3tuoMdNwkVaNLc6B/wvQ46qzWlqkURdCk4B6wDnkC+ttqVOwhqFEygFUIr2sX85VWfNqWzK4aAhls+PA+N4fHrDIA98DhgKaKub8bA99NOH7aIDyTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882832; c=relaxed/simple;
	bh=mDuHoyCsVT8fNy8uOP3L4BiDARjKYHXqekGIpA0UaxI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Q4Tdc4gWSrYN2YTs4NtBYjK6d+xqVEdSM3v5PVD4kQQThQB1800ODkJfvCT10ujBZzRccnK34X670+6oQUQ1PFpP3uo/65y0oDJi8OWk92Iaii5knh+H5VYQu9TQupQIN+4WixI9hMoJv6va2ddUIGQgHKHjnKbfaWuWxPpTLW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yYW/bB6n; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yYW/bB6n"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730882822; h=Message-ID:Subject:Date:From:To;
	bh=mDuHoyCsVT8fNy8uOP3L4BiDARjKYHXqekGIpA0UaxI=;
	b=yYW/bB6nKSYIF7tocE3zKbYIt2ZbxB1oFAZhkQPo4N1D7pRCxEaui3Y9TK3sh9GgvvZoEMasMe1C3O+x3say5zFx1NTcv82zWb+MSiCrqCfgrlf8wbILFNfXbObAZY3AuzlmekL1rQxKIPULT04FFfVuf3hhT2PKb6iNi396Wps=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIqeaLn_1730882821 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 16:47:01 +0800
Message-ID: <1730882783.399233-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by default
Date: Wed, 6 Nov 2024 16:46:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 Jakub Kicinski <kuba@kernel.org>
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com>
 <20241104184641.525f8cdf@kernel.org>
 <20241106023803-mutt-send-email-mst@kernel.org>
In-Reply-To: <20241106023803-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Wed, 6 Nov 2024 02:38:40 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Nov 04, 2024 at 06:46:41PM -0800, Jakub Kicinski wrote:
> > On Tue, 29 Oct 2024 16:46:11 +0800 Xuan Zhuo wrote:
> > > In the last linux version, we disabled this feature to fix the
> > > regress[1].
> > >
> > > The patch set is try to fix the problem and re-enable it.
> > >
> > > More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@linux.alibaba.com
> >
> > Sorry to ping, Michael, Jason we're waiting to hear from you on
> > this one.
>
> Can patch 1 be applied on net as well? Or I can take it through
> my tree. It's a bugfix, just for an uncommon configuration.


Why? That can not be triggered in net branch.

Thanks
