Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E63806A4
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769685142; cv=none; b=oq9G8oMxJxhJeBwlMrCaXP+Z0gYGbgosL4v2sk7egaYlti9G7KNdWWbRyfiGSBtqIi853Xi0BS4WLutPODMcHXMwfZTrvl0ohDVANVLt1dOwvSG/88MbikSr1kceuke6/00kcxDVaPO+hOObqZ8+3tVPxs9Nmh53mFBswtX+OIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769685142; c=relaxed/simple;
	bh=WkAg+DQRNVI7tJ7g9umIgS0rIdaTcjXYEshkGDsAhzU=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Lp95RDkpIPPNKAj/mi8xy7DgoMKcDxGMlBRjf7AE9vbWQR8BlTlmhn+hOA76E0OM4cel5JccviU9udv1/Fn5os/zrjRyaRDCcb1xJM6lugyK4SKyK70tvz9LS2pMOQxz0nFk6uzCZfCgggDhnlJjAmSmVnAvWxY7u4eBxP6V4FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qFHGf17Z; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qFHGf17Z"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769685132; h=Message-ID:Subject:Date:From:To;
	bh=c+Gq2aLJ72NvCATpEEA0htSSDWqZ+7d6i33HsHlh7uU=;
	b=qFHGf17ZIffn0s9EgRtedlfQr3kKjeaC0n1RqPhvDP7bkQrGcskRns3wS1KT+hJ9ETsiMWW0NGwLb3CKIBRdHf3euK8yldlth2jPeypM8bCw1Q+2LryrMLZkUPpZ0NbclYqjy6vyY/u3H5Y4UQ7wmXQlNVr78u7zLdlrV4mOYnk=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wy7Eiug_1769685130 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 19:12:11 +0800
Message-ID: <1769684595.7934678-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH RFC v2 2/2] virtio-net: support receive timestamp
Date: Thu, 29 Jan 2026 19:03:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <20260129-v6-7-topic-virtio-net-ptp-v2-0-30a27dc52760@pengutronix.de>
 <20260129-v6-7-topic-virtio-net-ptp-v2-2-30a27dc52760@pengutronix.de>
 <1769680105.7884188-1-xuanzhuo@linux.alibaba.com>
 <87343og290.fsf@pengutronix.de>
In-Reply-To: <87343og290.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

On Thu, 29 Jan 2026 11:08:27 +0100, Steffen Trumtrar <s.trumtrar@pengutronix.de> wrote:
>
> Hi,
>
> On 2026-01-29 at 17:48 +08, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Since patch #1 used this struct, this one should be placed first in the series.
>
> oh, you are right, the order should be the other way around.
>
> > Also, has the virtio specification process accepted such a draft proposal?
>
> I haven't sent the draft yet, because I'm unsure if I understood the way this should be implemented with the flow filter correctly.
> If the direction is correct, I'd try and get the specification process going again.
> (That is not that easy, if you're not used to it and not that deep into the whole virtio universe ;))


There have been many historical attempts in this area- you may want to take a
look first.

Thanks.

>
>
> Best regards,
> Steffen
>
> --
> Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
> Steuerwalder Str. 21            | https://www.pengutronix.de/    |
> 31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
> Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |
